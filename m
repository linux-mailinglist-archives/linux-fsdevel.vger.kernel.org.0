Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3792E06E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 08:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgLVHst convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Dec 2020 02:48:49 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:35155 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725785AbgLVHst (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Dec 2020 02:48:49 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-NnEHhwp-MdWNip3acu6hiw-1; Tue, 22 Dec 2020 02:47:49 -0500
X-MC-Unique: NnEHhwp-MdWNip3acu6hiw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17830800D62;
        Tue, 22 Dec 2020 07:47:48 +0000 (UTC)
Received: from mickey.themaw.net (ovpn-116-49.sin2.redhat.com [10.67.116.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94D57299AD;
        Tue, 22 Dec 2020 07:47:42 +0000 (UTC)
Subject: [PATCH 2/6] kernfs: use VFS negative dentry caching
From:   Ian Kent <raven@themaw.net>
To:     Fox Chen <foxhlchen@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Tue, 22 Dec 2020 15:47:39 +0800
Message-ID: <160862325932.291330.15146665974057046065.stgit@mickey.themaw.net>
In-Reply-To: <160862320263.291330.9467216031366035418.stgit@mickey.themaw.net>
References: <160862320263.291330.9467216031366035418.stgit@mickey.themaw.net>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
 fs/kernfs/dir.c |   45 +++++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index c52190acda8a..34b15b95a1c2 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1032,17 +1032,37 @@ struct kernfs_node *kernfs_create_empty_dir(struct kernfs_node *parent,
 
 static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 {
+	struct kernfs_node *parent;
 	struct kernfs_node *kn;
 
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
+		/* If the kernfs node can be found this is a stale negative
+		 * hashed dentry so it must be discarded and the lookup redone.
+		 */
+		parent = kernfs_dentry_node(dentry->d_parent);
+		if (parent) {
+			const void *ns = NULL;
+
+			if (kernfs_ns_enabled(parent))
+				ns = kernfs_info(dentry->d_parent->d_sb)->ns;
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
@@ -1060,12 +1080,11 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
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
 
@@ -1080,7 +1099,7 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	struct dentry *ret;
 	struct kernfs_node *parent = dir->i_private;
 	struct kernfs_node *kn;
-	struct inode *inode;
+	struct inode *inode = NULL;
 	const void *ns = NULL;
 
 	mutex_lock(&kernfs_mutex);
@@ -1090,11 +1109,9 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 
 	kn = kernfs_find_ns(parent, dentry->d_name.name, ns);
 
-	/* no such entry */
-	if (!kn || !kernfs_active(kn)) {
-		ret = NULL;
-		goto out_unlock;
-	}
+	/* no such entry, retain as negative hashed dentry */
+	if (!kn || !kernfs_active(kn))
+		goto out_negative;
 
 	/* attach dentry and inode */
 	inode = kernfs_get_inode(dir->i_sb, kn);
@@ -1102,10 +1119,10 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 		ret = ERR_PTR(-ENOMEM);
 		goto out_unlock;
 	}
-
+out_negative:
 	/* instantiate and hash dentry */
 	ret = d_splice_alias(inode, dentry);
- out_unlock:
+out_unlock:
 	mutex_unlock(&kernfs_mutex);
 	return ret;
 }


