Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 133782829A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 18:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731293AbfEWQSF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 12:18:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37042 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730860AbfEWQSE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 12:18:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1AC6F308A104;
        Thu, 23 May 2019 16:18:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-142.rdu2.redhat.com [10.10.121.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96C5317162;
        Thu, 23 May 2019 16:18:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 15/23] nfs: get rid of ->set_security()
From:   David Howells <dhowells@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     Al Viro <viro@zeniv.linux.org.uk>, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 23 May 2019 17:18:01 +0100
Message-ID: <155862828182.26654.5120276809942525177.stgit@warthog.procyon.org.uk>
In-Reply-To: <155862813755.26654.563679411147031501.stgit@warthog.procyon.org.uk>
References: <155862813755.26654.563679411147031501.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 23 May 2019 16:18:04 +0000 (UTC)
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

 fs/nfs/internal.h  |    3 --
 fs/nfs/namespace.c |    1 -
 fs/nfs/nfs4super.c |    3 --
 fs/nfs/super.c     |   69 ++++++++++++++++------------------------------------
 4 files changed, 21 insertions(+), 55 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 61a480c06a76..1665e0935241 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -144,7 +144,6 @@ struct nfs_mount_request {
 
 struct nfs_mount_info {
 	unsigned int inherited_bsize;
-	int (*set_security)(struct super_block *, struct dentry *, struct nfs_mount_info *);
 	struct nfs_parsed_mount_data *parsed;
 	struct nfs_clone_mount *cloned;
 	struct nfs_server *server;
@@ -398,8 +397,6 @@ extern struct file_system_type nfs4_referral_fs_type;
 #endif
 bool nfs_auth_info_match(const struct nfs_auth_info *, rpc_authflavor_t);
 struct dentry *nfs_try_mount(int, const char *, struct nfs_mount_info *);
-int nfs_set_sb_security(struct super_block *, struct dentry *, struct nfs_mount_info *);
-int nfs_clone_sb_security(struct super_block *, struct dentry *, struct nfs_mount_info *);
 struct dentry *nfs_fs_mount(struct file_system_type *, int, const char *, void *);
 void nfs_kill_super(struct super_block *);
 
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 26f99ac5f5be..1c4cb8914b20 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -229,7 +229,6 @@ struct vfsmount *nfs_do_submount(struct dentry *dentry, struct nfs_fh *fh,
 	};
 	struct nfs_mount_info mount_info = {
 		.inherited_bsize = sb->s_blocksize_bits,
-		.set_security = nfs_clone_sb_security,
 		.cloned = &mountdata,
 		.mntfh = fh,
 		.nfs_mod = NFS_SB(sb)->nfs_client->cl_nfs_mod,
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index aaae3b6f93b6..513861b38b72 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -200,8 +200,6 @@ struct dentry *nfs4_try_mount(int flags, const char *dev_name,
 	struct nfs_parsed_mount_data *data = mount_info->parsed;
 	struct dentry *res;
 
-	mount_info->set_security = nfs_set_sb_security;
-
 	dfprintk(MOUNT, "--> nfs4_try_mount()\n");
 
 	res = do_nfs4_mount(nfs4_create_server(mount_info),
@@ -223,7 +221,6 @@ static struct dentry *nfs4_referral_mount(struct file_system_type *fs_type,
 {
 	struct nfs_clone_mount *data = raw_data;
 	struct nfs_mount_info mount_info = {
-		.set_security = nfs_clone_sb_security,
 		.cloned = data,
 		.nfs_mod = &nfs_v4,
 	};
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index a78f409e7634..37e922324e99 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -2518,52 +2518,6 @@ static void nfs_get_cache_cookie(struct super_block *sb,
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
@@ -2571,6 +2525,7 @@ static struct dentry *nfs_fs_mount_common(int flags, const char *dev_name,
 	struct dentry *mntroot = ERR_PTR(-ENOMEM);
 	int (*compare_super)(struct super_block *, void *) = nfs_compare_super;
 	struct nfs_server *server = mount_info->server;
+	unsigned long kflags = 0, kflags_out = 0;
 	struct nfs_sb_mountdata sb_mntdata = {
 		.mntflags = flags,
 		.server = server,
@@ -2631,7 +2586,26 @@ static struct dentry *nfs_fs_mount_common(int flags, const char *dev_name,
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
 
@@ -2656,7 +2630,6 @@ struct dentry *nfs_fs_mount(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *raw_data)
 {
 	struct nfs_mount_info mount_info = {
-		.set_security = nfs_set_sb_security,
 	};
 	struct dentry *mntroot = ERR_PTR(-ENOMEM);
 	struct nfs_subversion *nfs_mod;

