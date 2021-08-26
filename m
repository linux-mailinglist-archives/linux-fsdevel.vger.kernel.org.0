Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A855D3F8BD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 18:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243153AbhHZQVV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 12:21:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243117AbhHZQVN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 12:21:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4405B610FD;
        Thu, 26 Aug 2021 16:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629994826;
        bh=/gnibIb0ERkf3uxMn0kCjs8KJPuf9Owbp+glp7R9ylo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JVi2NMNQ9Ae79ceY4EbdAeYLe0Hh7ksA6AQCtsCvJC97OAb63gOssJCLRzxJ8VJpf
         hn6G+k3DPGeKi9jA6cYz/7ho3fBnrgfGb79pqyUefNylVWvNbRiSx7r9PI0OSJB8a3
         hh825b1qvWkPc+4kGPAZMx+jIwvK8KW/BVH5THJfUtHz01VuregSYgM89EZykKzR0x
         v5hF/3mrC2xTKuaCC/K4R6NKlf8iA3fdNcn1xHWtqZkQJdwtf5HSIoB+2p8OW90CvW
         PzdwBaDjk5pdGc2C4C+Xr9L2w8vm3+PtCd0cBYNW5IhSFuCp59Aq8sY2d9/Gz/9blu
         dTKBtJziwo+Lw==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com, xiubli@redhat.com, lhenriques@suse.de,
        khiremat@redhat.com, ebiggers@kernel.org
Subject: [RFC PATCH v8 10/24] ceph: implement -o test_dummy_encryption mount option
Date:   Thu, 26 Aug 2021 12:20:00 -0400
Message-Id: <20210826162014.73464-11-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210826162014.73464-1-jlayton@kernel.org>
References: <20210826162014.73464-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/crypto.c | 53 ++++++++++++++++++++++++++++++++
 fs/ceph/crypto.h | 26 ++++++++++++++++
 fs/ceph/inode.c  | 10 ++++--
 fs/ceph/super.c  | 79 ++++++++++++++++++++++++++++++++++++++++++++++--
 fs/ceph/super.h  | 12 +++++++-
 fs/ceph/xattr.c  |  3 ++
 6 files changed, 177 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index cdca7660f835..a3129ce34a79 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -4,6 +4,7 @@
 #include <linux/fscrypt.h>
 
 #include "super.h"
+#include "mds_client.h"
 #include "crypto.h"
 
 static int ceph_crypt_get_context(struct inode *inode, void *ctx, size_t len)
@@ -64,9 +65,20 @@ static bool ceph_crypt_empty_dir(struct inode *inode)
 	return ci->i_rsubdirs + ci->i_rfiles == 1;
 }
 
+void ceph_fscrypt_free_dummy_policy(struct ceph_fs_client *fsc)
+{
+	fscrypt_free_dummy_policy(&fsc->dummy_enc_policy);
+}
+
+static const union fscrypt_policy *ceph_get_dummy_policy(struct super_block *sb)
+{
+	return ceph_sb_to_client(sb)->dummy_enc_policy.policy;
+}
+
 static struct fscrypt_operations ceph_fscrypt_ops = {
 	.get_context		= ceph_crypt_get_context,
 	.set_context		= ceph_crypt_set_context,
+	.get_dummy_policy	= ceph_get_dummy_policy,
 	.empty_dir		= ceph_crypt_empty_dir,
 	.max_namelen		= NAME_MAX,
 };
@@ -75,3 +87,44 @@ void ceph_fscrypt_set_ops(struct super_block *sb)
 {
 	fscrypt_set_ops(sb, &ceph_fscrypt_ops);
 }
+
+int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
+				 struct ceph_acl_sec_ctx *as)
+{
+	int ret, ctxsize;
+	bool encrypted = false;
+	struct ceph_inode_info *ci = ceph_inode(inode);
+
+	ret = fscrypt_prepare_new_inode(dir, inode, &encrypted);
+	if (ret)
+		return ret;
+	if (!encrypted)
+		return 0;
+
+	as->fscrypt_auth = kzalloc(sizeof(*as->fscrypt_auth), GFP_KERNEL);
+	if (!as->fscrypt_auth)
+		return -ENOMEM;
+
+	ctxsize = fscrypt_context_for_new_inode(as->fscrypt_auth->cfa_blob, inode);
+	if (ctxsize < 0)
+		return ctxsize;
+
+	as->fscrypt_auth->cfa_version = cpu_to_le32(CEPH_FSCRYPT_AUTH_VERSION);
+	as->fscrypt_auth->cfa_blob_len = cpu_to_le32(ctxsize);
+
+	WARN_ON_ONCE(ci->fscrypt_auth);
+	kfree(ci->fscrypt_auth);
+	ci->fscrypt_auth_len = ceph_fscrypt_auth_len(as->fscrypt_auth);
+	ci->fscrypt_auth = kmemdup(as->fscrypt_auth, ci->fscrypt_auth_len, GFP_KERNEL);
+	if (!ci->fscrypt_auth)
+		return -ENOMEM;
+
+	inode->i_flags |= S_ENCRYPTED;
+
+	return 0;
+}
+
+void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req, struct ceph_acl_sec_ctx *as)
+{
+	swap(req->r_fscrypt_auth, as->fscrypt_auth);
+}
diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
index 6dca674f79b8..cb00fe42d5b7 100644
--- a/fs/ceph/crypto.h
+++ b/fs/ceph/crypto.h
@@ -8,6 +8,10 @@
 
 #include <linux/fscrypt.h>
 
+struct ceph_fs_client;
+struct ceph_acl_sec_ctx;
+struct ceph_mds_request;
+
 struct ceph_fscrypt_auth {
 	__le32	cfa_version;
 	__le32	cfa_blob_len;
@@ -25,12 +29,34 @@ static inline u32 ceph_fscrypt_auth_len(struct ceph_fscrypt_auth *fa)
 #ifdef CONFIG_FS_ENCRYPTION
 void ceph_fscrypt_set_ops(struct super_block *sb);
 
+void ceph_fscrypt_free_dummy_policy(struct ceph_fs_client *fsc);
+
+int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
+				 struct ceph_acl_sec_ctx *as);
+void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req, struct ceph_acl_sec_ctx *as);
+
 #else /* CONFIG_FS_ENCRYPTION */
 
 static inline void ceph_fscrypt_set_ops(struct super_block *sb)
 {
 }
 
+static inline void ceph_fscrypt_free_dummy_policy(struct ceph_fs_client *fsc)
+{
+}
+
+static inline int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
+						struct ceph_acl_sec_ctx *as)
+{
+	if (IS_ENCRYPTED(dir))
+		return -EOPNOTSUPP;
+	return 0;
+}
+
+static inline void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req,
+						struct ceph_acl_sec_ctx *as_ctx)
+{
+}
 #endif /* CONFIG_FS_ENCRYPTION */
 
 #endif
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index ae800372e42d..3cb941fc334c 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -83,12 +83,17 @@ struct inode *ceph_new_inode(struct inode *dir, struct dentry *dentry,
 			goto out_err;
 	}
 
+	inode->i_state = 0;
+	inode->i_mode = *mode;
+
 	err = ceph_security_init_secctx(dentry, *mode, as_ctx);
 	if (err < 0)
 		goto out_err;
 
-	inode->i_state = 0;
-	inode->i_mode = *mode;
+	err = ceph_fscrypt_prepare_context(dir, inode, as_ctx);
+	if (err)
+		goto out_err;
+
 	return inode;
 out_err:
 	iput(inode);
@@ -101,6 +106,7 @@ void ceph_as_ctx_to_req(struct ceph_mds_request *req, struct ceph_acl_sec_ctx *a
 		req->r_pagelist = as_ctx->pagelist;
 		as_ctx->pagelist = NULL;
 	}
+	ceph_fscrypt_as_ctx_to_req(req, as_ctx);
 }
 
 /**
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 5949f1bddeb5..ce6a306ba0e7 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -45,6 +45,7 @@ static void ceph_put_super(struct super_block *s)
 	struct ceph_fs_client *fsc = ceph_sb_to_client(s);
 
 	dout("put_super\n");
+	ceph_fscrypt_free_dummy_policy(fsc);
 	ceph_mdsc_close_sessions(fsc->mdsc);
 }
 
@@ -160,6 +161,7 @@ enum {
 	Opt_quotadf,
 	Opt_copyfrom,
 	Opt_wsync,
+	Opt_test_dummy_encryption,
 };
 
 enum ceph_recover_session_mode {
@@ -187,6 +189,7 @@ static const struct fs_parameter_spec ceph_mount_parameters[] = {
 	fsparam_string	("fsc",				Opt_fscache), // fsc=...
 	fsparam_flag_no ("ino32",			Opt_ino32),
 	fsparam_string	("mds_namespace",		Opt_mds_namespace),
+	fsparam_string	("mon_addr",			Opt_mon_addr),
 	fsparam_flag_no ("poolperm",			Opt_poolperm),
 	fsparam_flag_no ("quotadf",			Opt_quotadf),
 	fsparam_u32	("rasize",			Opt_rasize),
@@ -198,7 +201,8 @@ static const struct fs_parameter_spec ceph_mount_parameters[] = {
 	fsparam_u32	("rsize",			Opt_rsize),
 	fsparam_string	("snapdirname",			Opt_snapdirname),
 	fsparam_string	("source",			Opt_source),
-	fsparam_string	("mon_addr",			Opt_mon_addr),
+	fsparam_flag	("test_dummy_encryption",	Opt_test_dummy_encryption),
+	fsparam_string	("test_dummy_encryption",	Opt_test_dummy_encryption),
 	fsparam_u32	("wsize",			Opt_wsize),
 	fsparam_flag_no	("wsync",			Opt_wsync),
 	{}
@@ -567,6 +571,16 @@ static int ceph_parse_mount_param(struct fs_context *fc,
 		else
 			fsopt->flags |= CEPH_MOUNT_OPT_ASYNC_DIROPS;
 		break;
+	case Opt_test_dummy_encryption:
+#ifdef CONFIG_FS_ENCRYPTION
+		kfree(fsopt->test_dummy_encryption);
+		fsopt->test_dummy_encryption = param->string;
+		param->string = NULL;
+		fsopt->flags |= CEPH_MOUNT_OPT_TEST_DUMMY_ENC;
+#else
+		warnfc(fc, "FS encryption not supported: test_dummy_encryption mount option ignored");
+#endif
+		break;
 	default:
 		BUG();
 	}
@@ -587,6 +601,7 @@ static void destroy_mount_options(struct ceph_mount_options *args)
 	kfree(args->server_path);
 	kfree(args->fscache_uniq);
 	kfree(args->mon_addr);
+	kfree(args->test_dummy_encryption);
 	kfree(args);
 }
 
@@ -702,6 +717,8 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
 	if (!(fsopt->flags & CEPH_MOUNT_OPT_ASYNC_DIROPS))
 		seq_puts(m, ",wsync");
 
+	fscrypt_show_test_dummy_encryption(m, ',', root->d_sb);
+
 	if (fsopt->wsize != CEPH_MAX_WRITE_SIZE)
 		seq_printf(m, ",wsize=%u", fsopt->wsize);
 	if (fsopt->rsize != CEPH_MAX_READ_SIZE)
@@ -1037,6 +1054,52 @@ static struct dentry *open_root_dentry(struct ceph_fs_client *fsc,
 	return root;
 }
 
+#ifdef CONFIG_FS_ENCRYPTION
+static int ceph_set_test_dummy_encryption(struct super_block *sb, struct fs_context *fc,
+						struct ceph_mount_options *fsopt)
+{
+	struct ceph_fs_client *fsc = sb->s_fs_info;
+
+	/*
+	 * No changing encryption context on remount. Note that
+	 * fscrypt_set_test_dummy_encryption will validate the version
+	 * string passed in (if any).
+	 */
+	if (fsopt->flags & CEPH_MOUNT_OPT_TEST_DUMMY_ENC) {
+		int err = 0;
+
+		if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE && !fsc->dummy_enc_policy.policy) {
+			errorfc(fc, "Can't set test_dummy_encryption on remount");
+			return -EEXIST;
+		}
+
+		err = fscrypt_set_test_dummy_encryption(sb,
+							fsc->mount_options->test_dummy_encryption,
+							&fsc->dummy_enc_policy);
+		if (err) {
+			if (err == -EEXIST)
+				errorfc(fc, "Can't change test_dummy_encryption on remount");
+			else if (err == -EINVAL)
+				errorfc(fc, "Value of option \"%s\" is unrecognized",
+					fsc->mount_options->test_dummy_encryption);
+			else
+				errorfc(fc, "Error processing option \"%s\" [%d]",
+					fsc->mount_options->test_dummy_encryption, err);
+			return err;
+		}
+		warnfc(fc, "test_dummy_encryption mode enabled");
+	}
+	return 0;
+}
+#else
+static inline int ceph_set_test_dummy_encryption(struct super_block *sb, struct fs_context *fc,
+						struct ceph_mount_options *fsopt)
+{
+	warnfc(fc, "test_dummy_encryption mode ignored");
+	return 0;
+}
+#endif
+
 /*
  * mount: join the ceph cluster, and open root directory.
  */
@@ -1065,6 +1128,10 @@ static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc,
 				goto out;
 		}
 
+		err = ceph_set_test_dummy_encryption(fsc->sb, fc, fsc->mount_options);
+		if (err)
+			goto out;
+
 		dout("mount opening path '%s'\n", path);
 
 		ceph_fs_debugfs_init(fsc);
@@ -1262,9 +1329,15 @@ static void ceph_free_fc(struct fs_context *fc)
 
 static int ceph_reconfigure_fc(struct fs_context *fc)
 {
+	int err;
 	struct ceph_parse_opts_ctx *pctx = fc->fs_private;
 	struct ceph_mount_options *fsopt = pctx->opts;
-	struct ceph_fs_client *fsc = ceph_sb_to_client(fc->root->d_sb);
+	struct super_block *sb = fc->root->d_sb;
+	struct ceph_fs_client *fsc = ceph_sb_to_client(sb);
+
+	err = ceph_set_test_dummy_encryption(sb, fc, fsopt);
+	if (err)
+		return err;
 
 	if (fsopt->flags & CEPH_MOUNT_OPT_ASYNC_DIROPS)
 		ceph_set_mount_opt(fsc, ASYNC_DIROPS);
@@ -1278,7 +1351,7 @@ static int ceph_reconfigure_fc(struct fs_context *fc)
 		pr_notice("ceph: monitor addresses recorded, but not used for reconnection");
 	}
 
-	sync_filesystem(fc->root->d_sb);
+	sync_filesystem(sb);
 	return 0;
 }
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index bc74c0b19c4f..5b0731958fbc 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -17,6 +17,7 @@
 #include <linux/posix_acl.h>
 #include <linux/refcount.h>
 #include <linux/security.h>
+#include <linux/fscrypt.h>
 
 #include <linux/ceph/libceph.h>
 
@@ -25,6 +26,8 @@
 #include <linux/fscache.h>
 #endif
 
+#include "crypto.h"
+
 /* f_type in struct statfs */
 #define CEPH_SUPER_MAGIC 0x00c36400
 
@@ -45,6 +48,7 @@
 #define CEPH_MOUNT_OPT_NOQUOTADF       (1<<13) /* no root dir quota in statfs */
 #define CEPH_MOUNT_OPT_NOCOPYFROM      (1<<14) /* don't use RADOS 'copy-from' op */
 #define CEPH_MOUNT_OPT_ASYNC_DIROPS    (1<<15) /* allow async directory ops */
+#define CEPH_MOUNT_OPT_TEST_DUMMY_ENC  (1<<16) /* enable dummy encryption (for testing) */
 
 #define CEPH_MOUNT_OPT_DEFAULT			\
 	(CEPH_MOUNT_OPT_DCACHE |		\
@@ -101,6 +105,7 @@ struct ceph_mount_options {
 	char *server_path;    /* default NULL (means "/") */
 	char *fscache_uniq;   /* default NULL */
 	char *mon_addr;
+	char *test_dummy_encryption;	/* default NULL */
 };
 
 struct ceph_fs_client {
@@ -140,9 +145,11 @@ struct ceph_fs_client {
 #ifdef CONFIG_CEPH_FSCACHE
 	struct fscache_cookie *fscache;
 #endif
+#ifdef CONFIG_FS_ENCRYPTION
+	struct fscrypt_dummy_policy dummy_enc_policy;
+#endif
 };
 
-
 /*
  * File i/o capability.  This tracks shared state with the metadata
  * server that allows us to cache or writeback attributes or to read
@@ -1068,6 +1075,9 @@ struct ceph_acl_sec_ctx {
 #ifdef CONFIG_CEPH_FS_SECURITY_LABEL
 	void *sec_ctx;
 	u32 sec_ctxlen;
+#endif
+#ifdef CONFIG_FS_ENCRYPTION
+	struct ceph_fscrypt_auth *fscrypt_auth;
 #endif
 	struct ceph_pagelist *pagelist;
 };
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 159a1ffa4f4b..a2a1b47313f2 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1381,6 +1381,9 @@ void ceph_release_acl_sec_ctx(struct ceph_acl_sec_ctx *as_ctx)
 #endif
 #ifdef CONFIG_CEPH_FS_SECURITY_LABEL
 	security_release_secctx(as_ctx->sec_ctx, as_ctx->sec_ctxlen);
+#endif
+#ifdef CONFIG_FS_ENCRYPTION
+	kfree(as_ctx->fscrypt_auth);
 #endif
 	if (as_ctx->pagelist)
 		ceph_pagelist_release(as_ctx->pagelist);
-- 
2.31.1

