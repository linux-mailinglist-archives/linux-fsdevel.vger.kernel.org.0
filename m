Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC49B0150
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 18:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbfIKQRf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 12:17:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729004AbfIKQQX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 12:16:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6345719CF7A;
        Wed, 11 Sep 2019 16:16:23 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-122-52.rdu2.redhat.com [10.10.122.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A5625D9E2;
        Wed, 11 Sep 2019 16:16:23 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 5081420D31; Wed, 11 Sep 2019 12:16:22 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/26] nfs: get rid of ->set_security()
Date:   Wed, 11 Sep 2019 12:16:10 -0400
Message-Id: <20190911161621.19832-16-smayhew@redhat.com>
In-Reply-To: <20190911161621.19832-1-smayhew@redhat.com>
References: <20190911161621.19832-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 11 Sep 2019 16:16:23 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

it's always either nfs_set_sb_security() or nfs_clone_sb_security(),
the choice being controlled by mount_info->cloned != NULL.  No need
to add methods, especially when both instances live right next to
the caller and are never accessed anywhere else.

Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/internal.h  |  3 --
 fs/nfs/namespace.c |  1 -
 fs/nfs/nfs4super.c |  3 --
 fs/nfs/super.c     | 69 ++++++++++++++--------------------------------
 4 files changed, 21 insertions(+), 55 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index fa737e37f7c9..d512ec394559 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -145,7 +145,6 @@ struct nfs_mount_request {
 
 struct nfs_mount_info {
 	unsigned int inherited_bsize;
-	int (*set_security)(struct super_block *, struct dentry *, struct nfs_mount_info *);
 	struct nfs_parsed_mount_data *parsed;
 	struct nfs_clone_mount *cloned;
 	struct nfs_server *server;
@@ -399,8 +398,6 @@ extern struct file_system_type nfs4_referral_fs_type;
 #endif
 bool nfs_auth_info_match(const struct nfs_auth_info *, rpc_authflavor_t);
 struct dentry *nfs_try_mount(int, const char *, struct nfs_mount_info *);
-int nfs_set_sb_security(struct super_block *, struct dentry *, struct nfs_mount_info *);
-int nfs_clone_sb_security(struct super_block *, struct dentry *, struct nfs_mount_info *);
 struct dentry *nfs_fs_mount(struct file_system_type *, int, const char *, void *);
 void nfs_kill_super(struct super_block *);
 
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 7bc5b9b8f5ea..72a99f9c7390 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -230,7 +230,6 @@ struct vfsmount *nfs_do_submount(struct dentry *dentry, struct nfs_fh *fh,
 	};
 	struct nfs_mount_info mount_info = {
 		.inherited_bsize = sb->s_blocksize_bits,
-		.set_security = nfs_clone_sb_security,
 		.cloned = &mountdata,
 		.mntfh = fh,
 		.nfs_mod = NFS_SB(sb)->nfs_client->cl_nfs_mod,
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index d387c3c3b600..38f2eec7e1ad 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -201,8 +201,6 @@ struct dentry *nfs4_try_mount(int flags, const char *dev_name,
 	struct nfs_parsed_mount_data *data = mount_info->parsed;
 	struct dentry *res;
 
-	mount_info->set_security = nfs_set_sb_security;
-
 	dfprintk(MOUNT, "--> nfs4_try_mount()\n");
 
 	res = do_nfs4_mount(nfs4_create_server(mount_info),
@@ -224,7 +222,6 @@ static struct dentry *nfs4_referral_mount(struct file_system_type *fs_type,
 {
 	struct nfs_clone_mount *data = raw_data;
 	struct nfs_mount_info mount_info = {
-		.set_security = nfs_clone_sb_security,
 		.cloned = data,
 		.nfs_mod = &nfs_v4,
 	};
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 6f4983fc3937..d8702e57f7fc 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -2541,52 +2541,6 @@ static void nfs_get_cache_cookie(struct super_block *sb,
 }
 #endif
 
-int nfs_set_sb_security(struct super_block *s, struct dentry *mntroot,
-			struct nfs_mount_info *mount_info)
-{
-	int error;
-	unsigned long kflags = 0, kflags_out = 0;
-	if (NFS_SB(s)->caps & NFS_CAP_SECURITY_LABEL)
-		kflags |= SECURITY_LSM_NATIVE_LABELS;
-
-	error = security_sb_set_mnt_opts(s, mount_info->parsed->lsm_opts,
-						kflags, &kflags_out);
-	if (error)
-		goto err;
-
-	if (NFS_SB(s)->caps & NFS_CAP_SECURITY_LABEL &&
-		!(kflags_out & SECURITY_LSM_NATIVE_LABELS))
-		NFS_SB(s)->caps &= ~NFS_CAP_SECURITY_LABEL;
-err:
-	return error;
-}
-EXPORT_SYMBOL_GPL(nfs_set_sb_security);
-
-int nfs_clone_sb_security(struct super_block *s, struct dentry *mntroot,
-			  struct nfs_mount_info *mount_info)
-{
-	int error;
-	unsigned long kflags = 0, kflags_out = 0;
-
-	/* clone any lsm security options from the parent to the new sb */
-	if (d_inode(mntroot)->i_fop != &nfs_dir_operations)
-		return -ESTALE;
-
-	if (NFS_SB(s)->caps & NFS_CAP_SECURITY_LABEL)
-		kflags |= SECURITY_LSM_NATIVE_LABELS;
-
-	error = security_sb_clone_mnt_opts(mount_info->cloned->sb, s, kflags,
-			&kflags_out);
-	if (error)
-		return error;
-
-	if (NFS_SB(s)->caps & NFS_CAP_SECURITY_LABEL &&
-		!(kflags_out & SECURITY_LSM_NATIVE_LABELS))
-		NFS_SB(s)->caps &= ~NFS_CAP_SECURITY_LABEL;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(nfs_clone_sb_security);
-
 static struct dentry *nfs_fs_mount_common(int flags, const char *dev_name,
 				   struct nfs_mount_info *mount_info)
 {
@@ -2594,6 +2548,7 @@ static struct dentry *nfs_fs_mount_common(int flags, const char *dev_name,
 	struct dentry *mntroot = ERR_PTR(-ENOMEM);
 	int (*compare_super)(struct super_block *, void *) = nfs_compare_super;
 	struct nfs_server *server = mount_info->server;
+	unsigned long kflags = 0, kflags_out = 0;
 	struct nfs_sb_mountdata sb_mntdata = {
 		.mntflags = flags,
 		.server = server,
@@ -2654,7 +2609,26 @@ static struct dentry *nfs_fs_mount_common(int flags, const char *dev_name,
 	if (IS_ERR(mntroot))
 		goto error_splat_super;
 
-	error = mount_info->set_security(s, mntroot, mount_info);
+
+	if (NFS_SB(s)->caps & NFS_CAP_SECURITY_LABEL)
+		kflags |= SECURITY_LSM_NATIVE_LABELS;
+	if (mount_info->cloned) {
+		if (d_inode(mntroot)->i_fop != &nfs_dir_operations) {
+			error = -ESTALE;
+			goto error_splat_root;
+		}
+		/* clone any lsm security options from the parent to the new sb */
+		error = security_sb_clone_mnt_opts(mount_info->cloned->sb, s, kflags,
+				&kflags_out);
+	} else {
+		error = security_sb_set_mnt_opts(s, mount_info->parsed->lsm_opts,
+							kflags, &kflags_out);
+	}
+	if (error)
+		goto error_splat_root;
+	if (NFS_SB(s)->caps & NFS_CAP_SECURITY_LABEL &&
+		!(kflags_out & SECURITY_LSM_NATIVE_LABELS))
+		NFS_SB(s)->caps &= ~NFS_CAP_SECURITY_LABEL;
 	if (error)
 		goto error_splat_root;
 
@@ -2679,7 +2653,6 @@ struct dentry *nfs_fs_mount(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *raw_data)
 {
 	struct nfs_mount_info mount_info = {
-		.set_security = nfs_set_sb_security,
 	};
 	struct dentry *mntroot = ERR_PTR(-ENOMEM);
 	struct nfs_subversion *nfs_mod;
-- 
2.17.2

