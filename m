Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF75A74E1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 22:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbfICUdf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 16:33:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32784 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbfICUcR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:32:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2B70C307D88D;
        Tue,  3 Sep 2019 20:32:17 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-121-35.rdu2.redhat.com [10.10.121.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3CD460BE2;
        Tue,  3 Sep 2019 20:32:16 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 977BB20C2F; Tue,  3 Sep 2019 16:32:15 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/26] nfs: don't bother passing nfs_subversion to ->try_mount() and nfs_fs_mount_common()
Date:   Tue,  3 Sep 2019 16:31:58 -0400
Message-Id: <20190903203215.9157-10-smayhew@redhat.com>
In-Reply-To: <20190903203215.9157-1-smayhew@redhat.com>
References: <20190903203215.9157-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 03 Sep 2019 20:32:17 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/internal.h       |  6 ++----
 fs/nfs/nfs4_fs.h        |  2 +-
 fs/nfs/nfs4super.c      |  5 ++---
 fs/nfs/super.c          | 19 ++++++++-----------
 include/linux/nfs_xdr.h |  3 +--
 5 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 0c42cf685d4b..3334d0f3ecf9 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -401,12 +401,10 @@ extern struct file_system_type nfs_xdev_fs_type;
 extern struct file_system_type nfs4_referral_fs_type;
 #endif
 bool nfs_auth_info_match(const struct nfs_auth_info *, rpc_authflavor_t);
-struct dentry *nfs_try_mount(int, const char *, struct nfs_mount_info *,
-			struct nfs_subversion *);
+struct dentry *nfs_try_mount(int, const char *, struct nfs_mount_info *);
 int nfs_set_sb_security(struct super_block *, struct dentry *, struct nfs_mount_info *);
 int nfs_clone_sb_security(struct super_block *, struct dentry *, struct nfs_mount_info *);
-struct dentry *nfs_fs_mount_common(int, const char *,
-				   struct nfs_mount_info *, struct nfs_subversion *);
+struct dentry *nfs_fs_mount_common(int, const char *, struct nfs_mount_info *);
 struct dentry *nfs_fs_mount(struct file_system_type *, int, const char *, void *);
 struct dentry * nfs_xdev_mount_common(struct file_system_type *, int,
 		const char *, struct nfs_mount_info *);
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 3564da1ba8a1..67ecd7bb512f 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -517,7 +517,7 @@ extern const nfs4_stateid invalid_stateid;
 /* nfs4super.c */
 struct nfs_mount_info;
 extern struct nfs_subversion nfs_v4;
-struct dentry *nfs4_try_mount(int, const char *, struct nfs_mount_info *, struct nfs_subversion *);
+struct dentry *nfs4_try_mount(int, const char *, struct nfs_mount_info *);
 extern bool nfs4_disable_idmapping;
 extern unsigned short max_session_slots;
 extern unsigned short max_session_cb_slots;
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 88d83cab8e9b..83bca2ea566c 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -98,7 +98,7 @@ static struct dentry *
 nfs4_remote_mount(struct file_system_type *fs_type, int flags,
 		  const char *dev_name, void *info)
 {
-	return nfs_fs_mount_common(flags, dev_name, info, &nfs_v4);
+	return nfs_fs_mount_common(flags, dev_name, info);
 }
 
 struct nfs_referral_count {
@@ -216,8 +216,7 @@ static struct dentry *do_nfs4_mount(struct nfs_server *server, int flags,
 }
 
 struct dentry *nfs4_try_mount(int flags, const char *dev_name,
-			      struct nfs_mount_info *mount_info,
-			      struct nfs_subversion *nfs_mod)
+			      struct nfs_mount_info *mount_info)
 {
 	struct nfs_parsed_mount_data *data = mount_info->parsed;
 	struct dentry *res;
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 2a6b4e4b0a2d..ca6295945880 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1893,15 +1893,15 @@ static struct nfs_server *nfs_try_mount_request(struct nfs_mount_info *mount_inf
 }
 
 struct dentry *nfs_try_mount(int flags, const char *dev_name,
-			     struct nfs_mount_info *mount_info,
-			     struct nfs_subversion *nfs_mod)
+			     struct nfs_mount_info *mount_info)
 {
+	struct nfs_subversion *nfs_mod = mount_info->nfs_mod;
 	if (mount_info->parsed->need_mount)
 		mount_info->server = nfs_try_mount_request(mount_info, nfs_mod);
 	else
 		mount_info->server = nfs_mod->rpc_ops->create_server(mount_info, nfs_mod);
 
-	return nfs_fs_mount_common(flags, dev_name, mount_info, nfs_mod);
+	return nfs_fs_mount_common(flags, dev_name, mount_info);
 }
 EXPORT_SYMBOL_GPL(nfs_try_mount);
 
@@ -2623,8 +2623,7 @@ int nfs_clone_sb_security(struct super_block *s, struct dentry *mntroot,
 EXPORT_SYMBOL_GPL(nfs_clone_sb_security);
 
 struct dentry *nfs_fs_mount_common(int flags, const char *dev_name,
-				   struct nfs_mount_info *mount_info,
-				   struct nfs_subversion *nfs_mod)
+				   struct nfs_mount_info *mount_info)
 {
 	struct super_block *s;
 	struct dentry *mntroot = ERR_PTR(-ENOMEM);
@@ -2652,7 +2651,8 @@ struct dentry *nfs_fs_mount_common(int flags, const char *dev_name,
 			sb_mntdata.mntflags |= SB_SYNCHRONOUS;
 
 	/* Get a superblock - note that we may end up sharing one that already exists */
-	s = sget(nfs_mod->nfs_fs, compare_super, nfs_set_super, flags, &sb_mntdata);
+	s = sget(mount_info->nfs_mod->nfs_fs, compare_super, nfs_set_super,
+		 flags, &sb_mntdata);
 	if (IS_ERR(s)) {
 		mntroot = ERR_CAST(s);
 		goto out_err_nosb;
@@ -2738,7 +2738,7 @@ struct dentry *nfs_fs_mount(struct file_system_type *fs_type,
 	}
 	mount_info.nfs_mod = nfs_mod;
 
-	mntroot = nfs_mod->rpc_ops->try_mount(flags, dev_name, &mount_info, nfs_mod);
+	mntroot = nfs_mod->rpc_ops->try_mount(flags, dev_name, &mount_info);
 
 	put_nfs_version(nfs_mod);
 out:
@@ -2772,10 +2772,7 @@ static struct dentry *
 nfs_xdev_mount(struct file_system_type *fs_type, int flags,
 		const char *dev_name, void *raw_data)
 {
-	struct nfs_mount_info *info = raw_data;
-	struct nfs_subversion *nfs_mod = NFS_SB(info->cloned->sb)->nfs_client->cl_nfs_mod;
-
-	return nfs_fs_mount_common(flags, dev_name, info, nfs_mod);
+	return nfs_fs_mount_common(flags, dev_name, raw_data);
 }
 
 #if IS_ENABLED(CONFIG_NFS_V4)
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 9b8324ec08f3..4fdf4a523185 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1638,8 +1638,7 @@ struct nfs_rpc_ops {
 			    struct nfs_fsinfo *);
 	struct vfsmount *(*submount) (struct nfs_server *, struct dentry *,
 				      struct nfs_fh *, struct nfs_fattr *);
-	struct dentry *(*try_mount) (int, const char *, struct nfs_mount_info *,
-				     struct nfs_subversion *);
+	struct dentry *(*try_mount) (int, const char *, struct nfs_mount_info *);
 	int	(*getattr) (struct nfs_server *, struct nfs_fh *,
 			    struct nfs_fattr *, struct nfs4_label *,
 			    struct inode *);
-- 
2.17.2

