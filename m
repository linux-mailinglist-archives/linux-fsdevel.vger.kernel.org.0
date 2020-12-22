Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956032E06EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 08:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgLVHtC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Dec 2020 02:49:02 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:53476 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725850AbgLVHtC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Dec 2020 02:49:02 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-EyZ81KT6MgSOJxpq8uvo6g-1; Tue, 22 Dec 2020 02:48:04 -0500
X-MC-Unique: EyZ81KT6MgSOJxpq8uvo6g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16E9D15720;
        Tue, 22 Dec 2020 07:48:03 +0000 (UTC)
Received: from mickey.themaw.net (ovpn-116-49.sin2.redhat.com [10.67.116.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 19D4F17F73;
        Tue, 22 Dec 2020 07:47:56 +0000 (UTC)
Subject: [PATCH 3/6] kernfs: use revision to identify directory node changes
From:   Ian Kent <raven@themaw.net>
To:     Fox Chen <foxhlchen@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Tue, 22 Dec 2020 15:47:54 +0800
Message-ID: <160862327395.291330.3759464665965297953.stgit@mickey.themaw.net>
In-Reply-To: <160862320263.291330.9467216031366035418.stgit@mickey.themaw.net>
References: <160862320263.291330.9467216031366035418.stgit@mickey.themaw.net>
User-Agent: StGit/0.21
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

If a kernfs directory node hasn't changed there's no need to search for
an added (or removed) child dentry.

Add a revision counter to kernfs directory nodes so it can be used
to detect if a directory node has changed.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/kernfs/dir.c             |   15 ++++++++++++---
 fs/kernfs/kernfs-internal.h |   24 ++++++++++++++++++++++++
 include/linux/kernfs.h      |    5 +++++
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 34b15b95a1c2..aced0bb41083 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -372,6 +372,7 @@ static int kernfs_link_sibling(struct kernfs_node *kn)
 	/* successfully added, account subdir number */
 	if (kernfs_type(kn) == KERNFS_DIR)
 		kn->parent->dir.subdirs++;
+	kernfs_inc_rev(kn->parent);
 
 	return 0;
 }
@@ -394,6 +395,7 @@ static bool kernfs_unlink_sibling(struct kernfs_node *kn)
 
 	if (kernfs_type(kn) == KERNFS_DIR)
 		kn->parent->dir.subdirs--;
+	kernfs_inc_rev(kn->parent);
 
 	rb_erase(&kn->rb, &kn->parent->dir.children);
 	RB_CLEAR_NODE(&kn->rb);
@@ -1044,13 +1046,18 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 
 	/* Negative hashed dentry? */
 	if (!kn) {
-		/* If the kernfs node can be found this is a stale negative
-		 * hashed dentry so it must be discarded and the lookup redone.
-		 */
 		parent = kernfs_dentry_node(dentry->d_parent);
 		if (parent) {
 			const void *ns = NULL;
 
+			/* Directory node changed, no, then don't search? */
+			if (kernfs_dir_changed(parent, dentry))
+				goto out_bad;
+
+			/* If the kernfs node can be found this is a stale
+			 * negative hashed dentry so it must be discarded and
+			 * the lookup redone.
+			 */
 			if (kernfs_ns_enabled(parent))
 				ns = kernfs_info(dentry->d_parent->d_sb)->ns;
 			kn = kernfs_find_ns(parent, dentry->d_name.name, ns);
@@ -1104,6 +1111,8 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 
 	mutex_lock(&kernfs_mutex);
 
+	kernfs_set_rev(dentry, parent);
+
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dir->i_sb)->ns;
 
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 7ee97ef59184..0d48a367231d 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -81,6 +81,30 @@ static inline struct kernfs_node *kernfs_dentry_node(struct dentry *dentry)
 	return d_inode(dentry)->i_private;
 }
 
+static inline void kernfs_set_rev(struct dentry *dentry,
+				  struct kernfs_node *kn)
+{
+	dentry->d_time = kn->dir.rev;
+}
+
+static inline void kernfs_inc_rev(struct kernfs_node *kn)
+{
+	if (kernfs_type(kn) == KERNFS_DIR) {
+		if (!++kn->dir.rev)
+			kn->dir.rev++;
+	}
+}
+
+static inline bool kernfs_dir_changed(struct kernfs_node *kn,
+				      struct dentry *dentry)
+{
+	if (kernfs_type(kn) == KERNFS_DIR) {
+		if (kn->dir.rev != dentry->d_time)
+			return true;
+	}
+	return false;
+}
+
 extern const struct super_operations kernfs_sops;
 extern struct kmem_cache *kernfs_node_cache, *kernfs_iattrs_cache;
 
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 9e8ca8743c26..7947acb1163d 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -98,6 +98,11 @@ struct kernfs_elem_dir {
 	 * better directly in kernfs_node but is here to save space.
 	 */
 	struct kernfs_root	*root;
+	/*
+	 * Monotonic revision counter, used to identify if a directory
+	 * node has changed during revalidation.
+	 */
+	unsigned long rev;
 };
 
 struct kernfs_elem_symlink {


