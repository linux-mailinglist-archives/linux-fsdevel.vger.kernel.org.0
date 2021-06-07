Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0957939D95C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 12:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhFGKOK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Mon, 7 Jun 2021 06:14:10 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:43732 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230517AbhFGKOK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:14:10 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-IlQ4XzviN4SAgc_tkftXBw-1; Mon, 07 Jun 2021 06:12:15 -0400
X-MC-Unique: IlQ4XzviN4SAgc_tkftXBw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9833C106BAE7;
        Mon,  7 Jun 2021 10:12:13 +0000 (UTC)
Received: from web.messagingengine.com (ovpn-116-49.sin2.redhat.com [10.67.116.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 918945E26F;
        Mon,  7 Jun 2021 10:12:06 +0000 (UTC)
Subject: [PATCH v5 3/6] kernfs: use VFS negative dentry caching
From:   Ian Kent <raven@themaw.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Eric Sandeen <sandeen@sandeen.net>, Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 07 Jun 2021 18:12:05 +0800
Message-ID: <162306072498.69474.16160057168984328507.stgit@web.messagingengine.com>
In-Reply-To: <162306058093.69474.2367505736322611930.stgit@web.messagingengine.com>
References: <162306058093.69474.2367505736322611930.stgit@web.messagingengine.com>
User-Agent: StGit/0.23
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=raven@themaw.net
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: themaw.net
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If there are many lookups for non-existent paths these negative lookups
can lead to a lot of overhead during path walks.

The VFS allows dentries to be created as negative and hashed, and caches
them so they can be used to reduce the fairly high overhead alloc/free
cycle that occurs during these lookups.

Use the kernfs node parent revision to identify if a change has been
made to the containing directory so that the negative dentry can be
discarded and the lookup redone.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/kernfs/dir.c |   53 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index b88432c48851f..5ae95e8d1aea1 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1039,13 +1039,32 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
 
-	/* Always perform fresh lookup for negatives */
-	if (d_really_is_negative(dentry))
-		goto out_bad_unlocked;
-
 	kn = kernfs_dentry_node(dentry);
 	mutex_lock(&kernfs_mutex);
 
+	/* Negative hashed dentry? */
+	if (!kn) {
+		struct dentry *d_parent = dget_parent(dentry);
+		struct kernfs_node *parent;
+
+		/* If the kernfs parent node has changed discard and
+		 * proceed to ->lookup.
+		 */
+		parent = kernfs_dentry_node(d_parent);
+		if (parent) {
+			if (kernfs_dir_changed(parent, dentry)) {
+				dput(d_parent);
+				goto out_bad;
+			}
+		}
+		dput(d_parent);
+
+		/* The kernfs node doesn't exist, leave the dentry
+		 * negative and return success.
+		 */
+		goto out;
+	}
+
 	/* The kernfs node has been deactivated */
 	if (!kernfs_active(kn))
 		goto out_bad;
@@ -1062,12 +1081,11 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	if (kn->parent && kernfs_ns_enabled(kn->parent) &&
 	    kernfs_info(dentry->d_sb)->ns != kn->ns)
 		goto out_bad;
-
+out:
 	mutex_unlock(&kernfs_mutex);
 	return 1;
 out_bad:
 	mutex_unlock(&kernfs_mutex);
-out_bad_unlocked:
 	return 0;
 }
 
@@ -1082,30 +1100,21 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	struct dentry *ret;
 	struct kernfs_node *parent = dir->i_private;
 	struct kernfs_node *kn;
-	struct inode *inode;
+	struct inode *inode = NULL;
 	const void *ns = NULL;
 
 	mutex_lock(&kernfs_mutex);
-
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dir->i_sb)->ns;
 
 	kn = kernfs_find_ns(parent, dentry->d_name.name, ns);
-
-	/* no such entry */
-	if (!kn || !kernfs_active(kn)) {
-		ret = NULL;
-		goto out_unlock;
-	}
-
 	/* attach dentry and inode */
-	inode = kernfs_get_inode(dir->i_sb, kn);
-	if (!inode) {
-		ret = ERR_PTR(-ENOMEM);
-		goto out_unlock;
+	if (kn && kernfs_active(kn)) {
+		inode = kernfs_get_inode(dir->i_sb, kn);
+		if (!inode)
+			inode = ERR_PTR(-ENOMEM);
 	}
-
-	/* instantiate and hash dentry */
+	/* instantiate and hash (possibly negative) dentry */
 	ret = d_splice_alias(inode, dentry);
 	if (!IS_ERR(ret)) {
 		if (unlikely(ret))
@@ -1113,8 +1122,8 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 		else
 			kernfs_set_rev(parent, dentry);
 	}
- out_unlock:
 	mutex_unlock(&kernfs_mutex);
+
 	return ret;
 }
 


