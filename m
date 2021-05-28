Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC4D393D28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 08:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbhE1Gfz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 May 2021 02:35:55 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:40146 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234364AbhE1Gfu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 May 2021 02:35:50 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-VwkpEfrcPiijzoUPh1SiZg-1; Fri, 28 May 2021 02:34:11 -0400
X-MC-Unique: VwkpEfrcPiijzoUPh1SiZg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E2A0801817;
        Fri, 28 May 2021 06:34:10 +0000 (UTC)
Received: from web.messagingengine.com (ovpn-116-22.sin2.redhat.com [10.67.116.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2916BE2CB;
        Fri, 28 May 2021 06:34:06 +0000 (UTC)
Subject: [REPOST PATCH v4 2/5] kernfs: use VFS negative dentry caching
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
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 28 May 2021 14:34:05 +0800
Message-ID: <162218364554.34379.636306635794792903.stgit@web.messagingengine.com>
In-Reply-To: <162218354775.34379.5629941272050849549.stgit@web.messagingengine.com>
References: <162218354775.34379.5629941272050849549.stgit@web.messagingengine.com>
User-Agent: StGit/0.23
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/kernfs/dir.c |   55 +++++++++++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 4c69e2af82dac..5151c712f06f5 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1037,12 +1037,33 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
 
-	/* Always perform fresh lookup for negatives */
-	if (d_really_is_negative(dentry))
-		goto out_bad_unlocked;
+	mutex_lock(&kernfs_mutex);
 
 	kn = kernfs_dentry_node(dentry);
-	mutex_lock(&kernfs_mutex);
+
+	/* Negative hashed dentry? */
+	if (!kn) {
+		struct kernfs_node *parent;
+
+		/* If the kernfs node can be found this is a stale negative
+		 * hashed dentry so it must be discarded and the lookup redone.
+		 */
+		parent = kernfs_dentry_node(dentry->d_parent);
+		if (parent) {
+			const void *ns = NULL;
+
+			if (kernfs_ns_enabled(parent))
+				ns = kernfs_info(dentry->d_sb)->ns;
+			kn = kernfs_find_ns(parent, dentry->d_name.name, ns);
+			if (kn)
+				goto out_bad;
+		}
+
+		/* The kernfs node doesn't exist, leave the dentry negative
+		 * and return success.
+		 */
+		goto out;
+	}
 
 	/* The kernfs node has been deactivated */
 	if (!kernfs_active_read(kn))
@@ -1060,12 +1081,11 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
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
 
@@ -1080,33 +1100,24 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
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
- out_unlock:
 	mutex_unlock(&kernfs_mutex);
+
 	return ret;
 }
 


