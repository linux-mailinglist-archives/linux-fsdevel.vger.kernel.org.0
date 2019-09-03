Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEACCA74AD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 22:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfICUcY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 16:32:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47358 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727423AbfICUcU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:32:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5AF56190C022;
        Tue,  3 Sep 2019 20:32:20 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-121-35.rdu2.redhat.com [10.10.121.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 271075D6B2;
        Tue,  3 Sep 2019 20:32:20 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id B1B2220D2E; Tue,  3 Sep 2019 16:32:15 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/26] nfs: get rid of mount_info ->fill_super()
Date:   Tue,  3 Sep 2019 16:32:02 -0400
Message-Id: <20190903203215.9157-14-smayhew@redhat.com>
In-Reply-To: <20190903203215.9157-1-smayhew@redhat.com>
References: <20190903203215.9157-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Tue, 03 Sep 2019 20:32:20 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

The only possible values are nfs_fill_super and nfs_clone_super.  The
latter is used only when crossing into a submount and it is almost
identical to the former; the only differences are
	* ->s_time_gran unconditionally set to 1 (even for v2 mounts).
Regression dating back to 2012, actually.
	* ->s_blocksize/->s_blocksize_bits set to that of parent.

Rather than messing with the method, stash ->s_blocksize_bits in
mount_info in submount case and after the (now unconditional)
call of nfs_fill_super() override ->s_blocksize/->s_blocksize_bits
if that has been set.

Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/internal.h  |  4 +--
 fs/nfs/namespace.c |  2 +-
 fs/nfs/nfs4super.c |  1 -
 fs/nfs/super.c     | 66 +++++++++++-----------------------------------
 4 files changed, 18 insertions(+), 55 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 444d0fc2bcca..fa737e37f7c9 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -144,7 +144,7 @@ struct nfs_mount_request {
 };
 
 struct nfs_mount_info {
-	void (*fill_super)(struct super_block *, struct nfs_mount_info *);
+	unsigned int inherited_bsize;
 	int (*set_security)(struct super_block *, struct dentry *, struct nfs_mount_info *);
 	struct nfs_parsed_mount_data *parsed;
 	struct nfs_clone_mount *cloned;
@@ -403,8 +403,6 @@ int nfs_set_sb_security(struct super_block *, struct dentry *, struct nfs_mount_
 int nfs_clone_sb_security(struct super_block *, struct dentry *, struct nfs_mount_info *);
 struct dentry *nfs_fs_mount(struct file_system_type *, int, const char *, void *);
 void nfs_kill_super(struct super_block *);
-void nfs_fill_super(struct super_block *, struct nfs_mount_info *);
-void nfs_clone_super(struct super_block *, struct nfs_mount_info *);
 
 extern struct rpc_stat nfs_rpcstat;
 
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 970f92a860ed..7bc5b9b8f5ea 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -229,7 +229,7 @@ struct vfsmount *nfs_do_submount(struct dentry *dentry, struct nfs_fh *fh,
 		.authflavor = authflavor,
 	};
 	struct nfs_mount_info mount_info = {
-		.fill_super = nfs_clone_super,
+		.inherited_bsize = sb->s_blocksize_bits,
 		.set_security = nfs_clone_sb_security,
 		.cloned = &mountdata,
 		.mntfh = fh,
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index b6cf62125380..d387c3c3b600 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -224,7 +224,6 @@ static struct dentry *nfs4_referral_mount(struct file_system_type *fs_type,
 {
 	struct nfs_clone_mount *data = raw_data;
 	struct nfs_mount_info mount_info = {
-		.fill_super = nfs_fill_super,
 		.set_security = nfs_clone_sb_security,
 		.cloned = data,
 		.nfs_mod = &nfs_v4,
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 157d340333c8..89751ce21110 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -2339,29 +2339,9 @@ nfs_remount(struct super_block *sb, int *flags, char *raw_data)
 EXPORT_SYMBOL_GPL(nfs_remount);
 
 /*
- * Initialise the common bits of the superblock
+ * Finish setting up an NFS superblock
  */
-static void nfs_initialise_sb(struct super_block *sb)
-{
-	struct nfs_server *server = NFS_SB(sb);
-
-	sb->s_magic = NFS_SUPER_MAGIC;
-
-	/* We probably want something more informative here */
-	snprintf(sb->s_id, sizeof(sb->s_id),
-		 "%u:%u", MAJOR(sb->s_dev), MINOR(sb->s_dev));
-
-	if (sb->s_blocksize == 0)
-		sb->s_blocksize = nfs_block_bits(server->wsize,
-						 &sb->s_blocksize_bits);
-
-	nfs_super_set_maxbytes(sb, server->maxfilesize);
-}
-
-/*
- * Finish setting up an NFS2/3 superblock
- */
-void nfs_fill_super(struct super_block *sb, struct nfs_mount_info *mount_info)
+static void nfs_fill_super(struct super_block *sb, struct nfs_mount_info *mount_info)
 {
 	struct nfs_parsed_mount_data *data = mount_info->parsed;
 	struct nfs_server *server = NFS_SB(sb);
@@ -2382,35 +2362,17 @@ void nfs_fill_super(struct super_block *sb, struct nfs_mount_info *mount_info)
 		sb->s_export_op = &nfs_export_ops;
 	}
 
- 	nfs_initialise_sb(sb);
-}
-EXPORT_SYMBOL_GPL(nfs_fill_super);
-
-/*
- * Finish setting up a cloned NFS2/3/4 superblock
- */
-void nfs_clone_super(struct super_block *sb,
-			    struct nfs_mount_info *mount_info)
-{
-	const struct super_block *old_sb = mount_info->cloned->sb;
-	struct nfs_server *server = NFS_SB(sb);
+	sb->s_magic = NFS_SUPER_MAGIC;
 
-	sb->s_blocksize_bits = old_sb->s_blocksize_bits;
-	sb->s_blocksize = old_sb->s_blocksize;
-	sb->s_maxbytes = old_sb->s_maxbytes;
-	sb->s_xattr = old_sb->s_xattr;
-	sb->s_op = old_sb->s_op;
-	sb->s_time_gran = 1;
-	sb->s_export_op = old_sb->s_export_op;
+	/* We probably want something more informative here */
+	snprintf(sb->s_id, sizeof(sb->s_id),
+		 "%u:%u", MAJOR(sb->s_dev), MINOR(sb->s_dev));
 
-	if (server->nfs_client->rpc_ops->version != 2) {
-		/* The VFS shouldn't apply the umask to mode bits. We will do
-		 * so ourselves when necessary.
-		 */
-		sb->s_flags |= SB_POSIXACL;
-	}
+	if (sb->s_blocksize == 0)
+		sb->s_blocksize = nfs_block_bits(server->wsize,
+						 &sb->s_blocksize_bits);
 
- 	nfs_initialise_sb(sb);
+	nfs_super_set_maxbytes(sb, server->maxfilesize);
 }
 
 static int nfs_compare_mount_options(const struct super_block *s, const struct nfs_server *b, int flags)
@@ -2676,8 +2638,13 @@ static struct dentry *nfs_fs_mount_common(int flags, const char *dev_name,
 	}
 
 	if (!s->s_root) {
+		unsigned bsize = mount_info->inherited_bsize;
 		/* initial superblock/root creation */
-		mount_info->fill_super(s, mount_info);
+		nfs_fill_super(s, mount_info);
+		if (bsize) {
+			s->s_blocksize_bits = bsize;
+			s->s_blocksize = 1U << bsize;
+		}
 		nfs_get_cache_cookie(s, mount_info->parsed, mount_info->cloned);
 		if (!(server->flags & NFS_MOUNT_UNSHARED))
 			s->s_iflags |= SB_I_MULTIROOT;
@@ -2712,7 +2679,6 @@ struct dentry *nfs_fs_mount(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *raw_data)
 {
 	struct nfs_mount_info mount_info = {
-		.fill_super = nfs_fill_super,
 		.set_security = nfs_set_sb_security,
 	};
 	struct dentry *mntroot = ERR_PTR(-ENOMEM);
-- 
2.17.2

