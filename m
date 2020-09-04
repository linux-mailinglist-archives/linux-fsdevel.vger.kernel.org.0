Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E68825DF4A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 18:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgIDQHH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 12:07:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727921AbgIDQFr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:05:47 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBA242084D;
        Fri,  4 Sep 2020 16:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599235547;
        bh=wsDcZ4XR+68ZukfnEVYNdgpLxaWJy4Nq3uQQP/TS/+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f2sBV44zOumafv2ypv0U35LubffPLvzIAmsLVYTLOFa+YlKup0EdNiuDLMNLIFMkf
         q+7R99BGS9k1/i/1NdVscyMnnt66kMnF9PlmhVCxVBdSy3aaG23pl+ckhNnyTQjEYZ
         53OyPc93SVXuXwjrSJFwPGS95ROTYiL760oEAlK4=
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        ebiggers@kernel.org
Subject: [RFC PATCH v2 09/18] ceph: crypto context handling for ceph
Date:   Fri,  4 Sep 2020 12:05:28 -0400
Message-Id: <20200904160537.76663-10-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904160537.76663-1-jlayton@kernel.org>
References: <20200904160537.76663-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Store the fscrypt context for an inode as an encryption.ctx xattr.

Also add support for "dummy" encryption (useful for testing with
automated test harnesses like xfstests).

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/Makefile |  1 +
 fs/ceph/crypto.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/crypto.h | 24 +++++++++++++++++
 fs/ceph/inode.c  |  1 +
 fs/ceph/super.c  | 37 ++++++++++++++++++++++++++
 fs/ceph/super.h  |  7 ++++-
 6 files changed, 138 insertions(+), 1 deletion(-)
 create mode 100644 fs/ceph/crypto.c
 create mode 100644 fs/ceph/crypto.h

diff --git a/fs/ceph/Makefile b/fs/ceph/Makefile
index 50c635dc7f71..1f77ca04c426 100644
--- a/fs/ceph/Makefile
+++ b/fs/ceph/Makefile
@@ -12,3 +12,4 @@ ceph-y := super.o inode.o dir.o file.o locks.o addr.o ioctl.o \
 
 ceph-$(CONFIG_CEPH_FSCACHE) += cache.o
 ceph-$(CONFIG_CEPH_FS_POSIX_ACL) += acl.o
+ceph-$(CONFIG_FS_ENCRYPTION) += crypto.o
diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
new file mode 100644
index 000000000000..22a09d422b72
--- /dev/null
+++ b/fs/ceph/crypto.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/ceph/ceph_debug.h>
+#include <linux/xattr.h>
+#include <linux/fscrypt.h>
+
+#include "super.h"
+#include "crypto.h"
+
+static int ceph_crypt_get_context(struct inode *inode, void *ctx, size_t len)
+{
+	int ret = __ceph_getxattr(inode, CEPH_XATTR_NAME_ENCRYPTION_CONTEXT, ctx, len);
+
+	if (ret > 0)
+		inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
+	return ret;
+}
+
+static int ceph_crypt_set_context(struct inode *inode, const void *ctx, size_t len, void *fs_data)
+{
+	int ret;
+
+	WARN_ON_ONCE(fs_data);
+	ret = __ceph_setxattr(inode, CEPH_XATTR_NAME_ENCRYPTION_CONTEXT, ctx, len, XATTR_CREATE);
+	if (ret == 0)
+		inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
+	return ret;
+}
+
+static bool ceph_crypt_empty_dir(struct inode *inode)
+{
+	struct ceph_inode_info *ci = ceph_inode(inode);
+
+	return ci->i_rsubdirs + ci->i_rfiles == 1;
+}
+
+static const union fscrypt_context *
+ceph_get_dummy_context(struct super_block *sb)
+{
+	return ceph_sb_to_client(sb)->dummy_enc_ctx.ctx;
+}
+
+static struct fscrypt_operations ceph_fscrypt_ops = {
+	.key_prefix		= "ceph:",
+	.get_context		= ceph_crypt_get_context,
+	.set_context		= ceph_crypt_set_context,
+	.get_dummy_context	= ceph_get_dummy_context,
+	.empty_dir		= ceph_crypt_empty_dir,
+	.max_namelen		= NAME_MAX,
+};
+
+int ceph_fscrypt_set_ops(struct super_block *sb)
+{
+	struct ceph_fs_client *fsc = sb->s_fs_info;
+
+	fscrypt_set_ops(sb, &ceph_fscrypt_ops);
+
+	if (ceph_test_mount_opt(fsc, TEST_DUMMY_ENC)) {
+		substring_t arg = { };
+
+		/* Ewwwwwwww */
+		if (fsc->mount_options->test_dummy_encryption) {
+			arg.from = fsc->mount_options->test_dummy_encryption;
+			arg.to = arg.from + strlen(arg.from) - 1;
+		}
+
+		return fscrypt_set_test_dummy_encryption(sb, &arg, &fsc->dummy_enc_ctx);
+	}
+	return 0;
+}
diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
new file mode 100644
index 000000000000..af06dca5f5a6
--- /dev/null
+++ b/fs/ceph/crypto.h
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Ceph fscrypt functionality
+ */
+
+#ifndef _CEPH_CRYPTO_H
+#define _CEPH_CRYPTO_H
+
+#ifdef CONFIG_FS_ENCRYPTION
+
+#define	CEPH_XATTR_NAME_ENCRYPTION_CONTEXT	"encryption.ctx"
+
+int ceph_fscrypt_set_ops(struct super_block *sb);
+
+#else /* CONFIG_FS_ENCRYPTION */
+
+static inline int ceph_fscrypt_set_ops(struct super_block *sb)
+{
+	return 0;
+}
+
+#endif /* CONFIG_FS_ENCRYPTION */
+
+#endif
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 156b98bda6aa..a527c5dbf93f 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -543,6 +543,7 @@ void ceph_evict_inode(struct inode *inode)
 
 	dout("evict_inode %p ino %llx.%llx\n", inode, ceph_vinop(inode));
 
+	fscrypt_put_encryption_info(inode);
 	truncate_inode_pages_final(&inode->i_data);
 	clear_inode(inode);
 
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 7ec0e6d03d10..95f5a7cf60f2 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -20,6 +20,7 @@
 #include "super.h"
 #include "mds_client.h"
 #include "cache.h"
+#include "crypto.h"
 
 #include <linux/ceph/ceph_features.h>
 #include <linux/ceph/decode.h>
@@ -44,6 +45,7 @@ static void ceph_put_super(struct super_block *s)
 	struct ceph_fs_client *fsc = ceph_sb_to_client(s);
 
 	dout("put_super\n");
+	fscrypt_free_dummy_context(&fsc->dummy_enc_ctx);
 	ceph_mdsc_close_sessions(fsc->mdsc);
 }
 
@@ -159,6 +161,7 @@ enum {
 	Opt_quotadf,
 	Opt_copyfrom,
 	Opt_wsync,
+	Opt_test_dummy_encryption,
 };
 
 enum ceph_recover_session_mode {
@@ -197,6 +200,8 @@ static const struct fs_parameter_spec ceph_mount_parameters[] = {
 	fsparam_u32	("rsize",			Opt_rsize),
 	fsparam_string	("snapdirname",			Opt_snapdirname),
 	fsparam_string	("source",			Opt_source),
+	fsparam_flag_no ("test_dummy_encryption",	Opt_test_dummy_encryption),
+	fsparam_string	("test_dummy_encryption",	Opt_test_dummy_encryption),
 	fsparam_u32	("wsize",			Opt_wsize),
 	fsparam_flag_no	("wsync",			Opt_wsync),
 	{}
@@ -455,6 +460,21 @@ static int ceph_parse_mount_param(struct fs_context *fc,
 		else
 			fsopt->flags |= CEPH_MOUNT_OPT_ASYNC_DIROPS;
 		break;
+	case Opt_test_dummy_encryption:
+		kfree(fsopt->test_dummy_encryption);
+		fsopt->test_dummy_encryption = NULL;
+		if (!result.negated) {
+#ifdef CONFIG_FS_ENCRYPTION
+			fsopt->test_dummy_encryption = param->string;
+			param->string = NULL;
+			fsopt->flags |= CEPH_MOUNT_OPT_TEST_DUMMY_ENC;
+#else
+			return warnfc(fc, "FS encryption not supported: test_dummy_encryption mount option ignored");
+#endif
+		} else {
+			fsopt->flags &= ~CEPH_MOUNT_OPT_TEST_DUMMY_ENC;
+		}
+		break;
 	default:
 		BUG();
 	}
@@ -474,6 +494,7 @@ static void destroy_mount_options(struct ceph_mount_options *args)
 	kfree(args->mds_namespace);
 	kfree(args->server_path);
 	kfree(args->fscache_uniq);
+	kfree(args->test_dummy_encryption);
 	kfree(args);
 }
 
@@ -581,6 +602,8 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
 	if (fsopt->flags & CEPH_MOUNT_OPT_ASYNC_DIROPS)
 		seq_puts(m, ",nowsync");
 
+	fscrypt_show_test_dummy_encryption(m, ',', root->d_sb);
+
 	if (fsopt->wsize != CEPH_MAX_WRITE_SIZE)
 		seq_printf(m, ",wsize=%u", fsopt->wsize);
 	if (fsopt->rsize != CEPH_MAX_READ_SIZE)
@@ -984,7 +1007,12 @@ static int ceph_set_super(struct super_block *s, struct fs_context *fc)
 	s->s_time_min = 0;
 	s->s_time_max = U32_MAX;
 
+	ret = ceph_fscrypt_set_ops(s);
+	if (ret)
+		goto out;
+
 	ret = set_anon_super_fc(s, fc);
+out:
 	if (ret != 0)
 		fsc->sb = NULL;
 	return ret;
@@ -1140,6 +1168,15 @@ static int ceph_reconfigure_fc(struct fs_context *fc)
 	else
 		ceph_clear_mount_opt(fsc, ASYNC_DIROPS);
 
+	/* Don't allow test_dummy_encryption to change on remount */
+	if (fsopt->flags & CEPH_MOUNT_OPT_TEST_DUMMY_ENC) {
+		if (!ceph_test_mount_opt(fsc, TEST_DUMMY_ENC))
+			return -EEXIST;
+	} else {
+		if (ceph_test_mount_opt(fsc, TEST_DUMMY_ENC))
+			return -EEXIST;
+	}
+
 	sync_filesystem(fc->root->d_sb);
 	return 0;
 }
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index b3aa2395b66e..3b8ffa6aee46 100644
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
+	struct fscrypt_dummy_context dummy_enc_ctx;
+#endif
 };
 
-
 /*
  * File i/o capability.  This tracks shared state with the metadata
  * server that allows us to cache or writeback attributes or to read
-- 
2.26.2

