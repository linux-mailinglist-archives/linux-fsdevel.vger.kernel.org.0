Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05697269564
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 21:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgINTR6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 15:17:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbgINTRW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:17:22 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F44B21D7E;
        Mon, 14 Sep 2020 19:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600111035;
        bh=9GT8v41aJayrEVimcBe7OYnETYfPUvltP8JF0Wcztbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kz/sz71yEG2XXd9JWMY1OckjLJkgJq1TjENoomL9OJVefxnYOFRxrZtlvCfPArdjR
         kwuYkTQgjld12qRvcagNtyS0ndHH2ni32sJY93urAxENXDBjNy04eWRiUONjQT33YH
         T/7xxhcJdlIhOuoXVW5XSjOAVrzzPJqOLMXGIHzI=
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v3 08/16] ceph: implement -o test_dummy_encryption mount option
Date:   Mon, 14 Sep 2020 15:16:59 -0400
Message-Id: <20200914191707.380444-9-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200914191707.380444-1-jlayton@kernel.org>
References: <20200914191707.380444-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/crypto.c |  7 ++---
 fs/ceph/super.c  | 74 +++++++++++++++++++++++++++++++++++++++++++-----
 fs/ceph/super.h  |  7 ++++-
 3 files changed, 76 insertions(+), 12 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 74f07d44dbe9..879d9a0d3751 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -29,16 +29,15 @@ static bool ceph_crypt_empty_dir(struct inode *inode)
 	return ci->i_rsubdirs + ci->i_rfiles == 1;
 }
 
-static const union fscrypt_context *
-ceph_get_dummy_context(struct super_block *sb)
+static const union fscrypt_policy *ceph_get_dummy_policy(struct super_block *sb)
 {
-	return ceph_sb_to_client(sb)->dummy_enc_ctx.ctx;
+	return ceph_sb_to_client(sb)->dummy_enc_policy.policy;
 }
 
 static struct fscrypt_operations ceph_fscrypt_ops = {
 	.get_context		= ceph_crypt_get_context,
 	.set_context		= ceph_crypt_set_context,
-	.get_dummy_context	= ceph_get_dummy_context,
+	.get_dummy_policy	= ceph_get_dummy_policy,
 	.empty_dir		= ceph_crypt_empty_dir,
 	.max_namelen		= NAME_MAX,
 };
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 055180218224..eefdea360c50 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -45,6 +45,7 @@ static void ceph_put_super(struct super_block *s)
 	struct ceph_fs_client *fsc = ceph_sb_to_client(s);
 
 	dout("put_super\n");
+	fscrypt_free_dummy_policy(&fsc->dummy_enc_policy);
 	ceph_mdsc_close_sessions(fsc->mdsc);
 }
 
@@ -160,6 +161,7 @@ enum {
 	Opt_quotadf,
 	Opt_copyfrom,
 	Opt_wsync,
+	Opt_test_dummy_encryption,
 };
 
 enum ceph_recover_session_mode {
@@ -198,6 +200,8 @@ static const struct fs_parameter_spec ceph_mount_parameters[] = {
 	fsparam_u32	("rsize",			Opt_rsize),
 	fsparam_string	("snapdirname",			Opt_snapdirname),
 	fsparam_string	("source",			Opt_source),
+	fsparam_flag	("test_dummy_encryption",	Opt_test_dummy_encryption),
+	fsparam_string	("test_dummy_encryption",	Opt_test_dummy_encryption),
 	fsparam_u32	("wsize",			Opt_wsize),
 	fsparam_flag_no	("wsync",			Opt_wsync),
 	{}
@@ -456,6 +460,16 @@ static int ceph_parse_mount_param(struct fs_context *fc,
 		else
 			fsopt->flags |= CEPH_MOUNT_OPT_ASYNC_DIROPS;
 		break;
+	case Opt_test_dummy_encryption:
+		kfree(fsopt->test_dummy_encryption);
+#ifdef CONFIG_FS_ENCRYPTION
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
@@ -475,6 +489,7 @@ static void destroy_mount_options(struct ceph_mount_options *args)
 	kfree(args->mds_namespace);
 	kfree(args->server_path);
 	kfree(args->fscache_uniq);
+	kfree(args->test_dummy_encryption);
 	kfree(args);
 }
 
@@ -582,6 +597,8 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
 	if (fsopt->flags & CEPH_MOUNT_OPT_ASYNC_DIROPS)
 		seq_puts(m, ",nowsync");
 
+	fscrypt_show_test_dummy_encryption(m, ',', root->d_sb);
+
 	if (fsopt->wsize != CEPH_MAX_WRITE_SIZE)
 		seq_printf(m, ",wsize=%u", fsopt->wsize);
 	if (fsopt->rsize != CEPH_MAX_READ_SIZE)
@@ -964,6 +981,43 @@ static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc,
 	return ERR_PTR(err);
 }
 
+#ifdef CONFIG_FS_ENCRYPTION
+static int ceph_set_test_dummy_encryption(struct super_block *sb, struct fs_context *fc,
+						struct ceph_mount_options *fsopt)
+{
+	struct ceph_fs_client *fsc = sb->s_fs_info;
+
+	if (fsopt->flags & CEPH_MOUNT_OPT_TEST_DUMMY_ENC) {
+		substring_t arg = { };
+
+		/*
+		 * No changing encryption context on remount. Note that
+		 * fscrypt_set_test_dummy_encryption will validate the version
+		 * string passed in (if any).
+		 */
+		if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE && !fsc->dummy_enc_policy.policy)
+			return -EEXIST;
+
+		/* Ewwwwwwww */
+		if (fsc->mount_options->test_dummy_encryption) {
+			arg.from = fsc->mount_options->test_dummy_encryption;
+			arg.to = arg.from + strlen(arg.from) - 1;
+		}
+		return fscrypt_set_test_dummy_encryption(sb, &arg, &fsc->dummy_enc_policy);
+	} else {
+		if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE && fsc->dummy_enc_policy.policy)
+			return -EEXIST;
+	}
+	return 0;
+}
+#else
+static inline int ceph_set_test_dummy_encryption(struct super_block *sb, struct fs_context *fc,
+						struct ceph_mount_options *fsopt)
+{
+	return 0;
+}
+#endif
+
 static int ceph_set_super(struct super_block *s, struct fs_context *fc)
 {
 	struct ceph_fs_client *fsc = s->s_fs_info;
@@ -985,12 +1039,12 @@ static int ceph_set_super(struct super_block *s, struct fs_context *fc)
 	s->s_time_min = 0;
 	s->s_time_max = U32_MAX;
 
-	ret = ceph_fscrypt_set_ops(s);
-	if (ret)
-		goto out;
+	ceph_fscrypt_set_ops(s);
 
-	ret = set_anon_super_fc(s, fc);
-	if (ret != 0)
+	ret = ceph_set_test_dummy_encryption(s, fc, fsc->mount_options);
+	if (!ret)
+		ret = set_anon_super_fc(s, fc);
+	if (ret)
 		fsc->sb = NULL;
 	return ret;
 }
@@ -1136,16 +1190,22 @@ static void ceph_free_fc(struct fs_context *fc)
 
 static int ceph_reconfigure_fc(struct fs_context *fc)
 {
+	int err;
 	struct ceph_parse_opts_ctx *pctx = fc->fs_private;
 	struct ceph_mount_options *fsopt = pctx->opts;
-	struct ceph_fs_client *fsc = ceph_sb_to_client(fc->root->d_sb);
+	struct super_block *sb = fc->root->d_sb;
+	struct ceph_fs_client *fsc = ceph_sb_to_client(sb);
 
 	if (fsopt->flags & CEPH_MOUNT_OPT_ASYNC_DIROPS)
 		ceph_set_mount_opt(fsc, ASYNC_DIROPS);
 	else
 		ceph_clear_mount_opt(fsc, ASYNC_DIROPS);
 
-	sync_filesystem(fc->root->d_sb);
+	err = ceph_set_test_dummy_encryption(sb, fc, fsopt);
+	if (err)
+		return err;
+
+	sync_filesystem(sb);
 	return 0;
 }
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index cc39cc36de77..11032b30a14f 100644
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
2.26.2

