Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E978A2FD88C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 19:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbhATSfL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 13:35:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:51524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404472AbhATSaR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:30:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3F4C23432;
        Wed, 20 Jan 2021 18:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611167333;
        bh=iW6JXUHFMRLEzYMbDYfy5ob50L7y1amDRSE6w5boguM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U/U3ck5LJc29xOn8WdrfhIN+iC6j15MLYjZpQ6jwoceqdbuoIc9SZ84tkobl672da
         4q0ldNLzp8BnVI622qkWRqxQ5GQVPBdznYyIrF5J8yLetY2wL0jdgBRnQJZVlyWdSb
         S2RPPv61mbRx9v5dttz6iBFLV4mZ7dnJ26pG9XQgaINqo8ZPQhe8kloF7aW6PvVG90
         hoHkJqHRGdtD1c86oD+CTxtsAfVMOPEfp/XAByHcX82d2M4qiX+qnx/oOlrYTxWjN8
         Mj+dd9bndPXtwojLStdXsRgwjNN68L0nSVQuW3/bhxBe+JfKg7AIDPzqnzwJglFYwq
         AlP0Mwu6pnSkw==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v4 06/17] ceph: implement -o test_dummy_encryption mount option
Date:   Wed, 20 Jan 2021 13:28:36 -0500
Message-Id: <20210120182847.644850-7-jlayton@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120182847.644850-1-jlayton@kernel.org>
References: <20210120182847.644850-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/crypto.c |  6 ++++
 fs/ceph/crypto.h |  8 +++++
 fs/ceph/super.c  | 77 ++++++++++++++++++++++++++++++++++++++++++++++--
 fs/ceph/super.h  |  7 ++++-
 4 files changed, 95 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index dbe8b60fd1b0..879d9a0d3751 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -29,9 +29,15 @@ static bool ceph_crypt_empty_dir(struct inode *inode)
 	return ci->i_rsubdirs + ci->i_rfiles == 1;
 }
 
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
diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
index 189bd8424284..0dd043b56096 100644
--- a/fs/ceph/crypto.h
+++ b/fs/ceph/crypto.h
@@ -13,12 +13,20 @@
 #ifdef CONFIG_FS_ENCRYPTION
 void ceph_fscrypt_set_ops(struct super_block *sb);
 
+static inline void ceph_fscrypt_free_dummy_policy(struct ceph_fs_client *fsc)
+{
+	fscrypt_free_dummy_policy(&fsc->dummy_enc_policy);
+}
+
 #else /* CONFIG_FS_ENCRYPTION */
 
 static inline void ceph_fscrypt_set_ops(struct super_block *sb)
 {
 }
 
+static inline void ceph_fscrypt_free_dummy_policy(struct ceph_fs_client *fsc)
+{
+}
 #endif /* CONFIG_FS_ENCRYPTION */
 
 #endif
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index cdac6ff675e2..48a99da4ff97 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -45,6 +45,7 @@ static void ceph_put_super(struct super_block *s)
 	struct ceph_fs_client *fsc = ceph_sb_to_client(s);
 
 	dout("put_super\n");
+	ceph_fscrypt_free_dummy_policy(fsc);
 	ceph_mdsc_close_sessions(fsc->mdsc);
 }
 
@@ -159,6 +160,7 @@ enum {
 	Opt_quotadf,
 	Opt_copyfrom,
 	Opt_wsync,
+	Opt_test_dummy_encryption,
 };
 
 enum ceph_recover_session_mode {
@@ -197,6 +199,8 @@ static const struct fs_parameter_spec ceph_mount_parameters[] = {
 	fsparam_u32	("rsize",			Opt_rsize),
 	fsparam_string	("snapdirname",			Opt_snapdirname),
 	fsparam_string	("source",			Opt_source),
+	fsparam_flag	("test_dummy_encryption",	Opt_test_dummy_encryption),
+	fsparam_string	("test_dummy_encryption",	Opt_test_dummy_encryption),
 	fsparam_u32	("wsize",			Opt_wsize),
 	fsparam_flag_no	("wsync",			Opt_wsync),
 	{}
@@ -455,6 +459,16 @@ static int ceph_parse_mount_param(struct fs_context *fc,
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
@@ -474,6 +488,7 @@ static void destroy_mount_options(struct ceph_mount_options *args)
 	kfree(args->mds_namespace);
 	kfree(args->server_path);
 	kfree(args->fscache_uniq);
+	kfree(args->test_dummy_encryption);
 	kfree(args);
 }
 
@@ -581,6 +596,8 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
 	if (fsopt->flags & CEPH_MOUNT_OPT_ASYNC_DIROPS)
 		seq_puts(m, ",nowsync");
 
+	fscrypt_show_test_dummy_encryption(m, ',', root->d_sb);
+
 	if (fsopt->wsize != CEPH_MAX_WRITE_SIZE)
 		seq_printf(m, ",wsize=%u", fsopt->wsize);
 	if (fsopt->rsize != CEPH_MAX_READ_SIZE)
@@ -916,6 +933,52 @@ static struct dentry *open_root_dentry(struct ceph_fs_client *fsc,
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
@@ -944,6 +1007,10 @@ static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc,
 				goto out;
 		}
 
+		err = ceph_set_test_dummy_encryption(fsc->sb, fc, fsc->mount_options);
+		if (err)
+			goto out;
+
 		dout("mount opening path '%s'\n", path);
 
 		ceph_fs_debugfs_init(fsc);
@@ -1138,16 +1205,22 @@ static void ceph_free_fc(struct fs_context *fc)
 
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
 	else
 		ceph_clear_mount_opt(fsc, ASYNC_DIROPS);
 
-	sync_filesystem(fc->root->d_sb);
+	sync_filesystem(sb);
 	return 0;
 }
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index efe2e963c631..df2d9a86d156 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -17,6 +17,7 @@
 #include <linux/posix_acl.h>
 #include <linux/refcount.h>
 #include <linux/security.h>
+#include <linux/fscrypt.h>
 
 #include <linux/ceph/libceph.h>
 
@@ -44,6 +45,7 @@
 #define CEPH_MOUNT_OPT_NOQUOTADF       (1<<13) /* no root dir quota in statfs */
 #define CEPH_MOUNT_OPT_NOCOPYFROM      (1<<14) /* don't use RADOS 'copy-from' op */
 #define CEPH_MOUNT_OPT_ASYNC_DIROPS    (1<<15) /* allow async directory ops */
+#define CEPH_MOUNT_OPT_TEST_DUMMY_ENC  (1<<16) /* enable dummy encryption (for testing) */
 
 #define CEPH_MOUNT_OPT_DEFAULT			\
 	(CEPH_MOUNT_OPT_DCACHE |		\
@@ -96,6 +98,7 @@ struct ceph_mount_options {
 	char *mds_namespace;  /* default NULL */
 	char *server_path;    /* default NULL (means "/") */
 	char *fscache_uniq;   /* default NULL */
+	char *test_dummy_encryption;	/* default NULL */
 };
 
 struct ceph_fs_client {
@@ -135,9 +138,11 @@ struct ceph_fs_client {
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
-- 
2.29.2

