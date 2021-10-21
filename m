Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566DF43609A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 13:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhJULrx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 07:47:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35880 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230527AbhJULrm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 07:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634816725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H4z3BWhssTbjEiq/YlNKPYbVphLd1uaOMsBdJ0pYQQc=;
        b=evZJAvIsbvXur6V+oAE5KtSN3OJ4ELuZnvtbax9m6oxSTvyghYEchfRc3HDlay/M2FTWKj
        nI9Ff02MuDVl9M6wb37VV2f+CbecKlr2JOPbr//2T436soVAE+Lw9+9BsoFMmGDHhB9+K8
        wU0izz9arWxA9M8MSuegZUrzV5tvbag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-Gf5d3M2_P1amoy8YdY_z-w-1; Thu, 21 Oct 2021 07:45:24 -0400
X-MC-Unique: Gf5d3M2_P1amoy8YdY_z-w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E5CF8066EF;
        Thu, 21 Oct 2021 11:45:23 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 097FF652AC;
        Thu, 21 Oct 2021 11:45:21 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 08/13] ext4: get rid of super block and sbi from handle_mount_ops()
Date:   Thu, 21 Oct 2021 13:45:03 +0200
Message-Id: <20211021114508.21407-9-lczerner@redhat.com>
In-Reply-To: <20211021114508.21407-1-lczerner@redhat.com>
References: <20211021114508.21407-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

At the parsing phase of mount in the new mount api sb will not be
available. We've already removed some uses of sb and sbi, but now we
need to ged rid of the rest of it.

Use ext4_fs_context to store all of the confiruation specification so
that it can be later applied to the super block and sbi.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/super.c | 541 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 368 insertions(+), 173 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 8359215d79ee..97addca438ad 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -90,8 +90,7 @@ static struct inode *ext4_get_journal_inode(struct super_block *sb,
 static int ext4_validate_options(struct fs_context *fc);
 static int ext4_check_opt_consistency(struct fs_context *fc,
 				      struct super_block *sb);
-static void ext4_apply_quota_options(struct fs_context *fc,
-				     struct super_block *sb);
+static int ext4_apply_options(struct fs_context *fc, struct super_block *sb);
 
 /*
  * Lock ordering
@@ -2142,57 +2141,74 @@ static int ext4_sb_read_encoding(const struct ext4_super_block *es,
 }
 #endif
 
-static int ext4_set_test_dummy_encryption(struct super_block *sb,
-					  struct fs_parameter *param,
-					  bool is_remount)
+static int ext4_set_test_dummy_encryption(struct super_block *sb, char *arg)
 {
 #ifdef CONFIG_FS_ENCRYPTION
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	int err;
 
-	/*
-	 * This mount option is just for testing, and it's not worthwhile to
-	 * implement the extra complexity (e.g. RCU protection) that would be
-	 * needed to allow it to be set or changed during remount.  We do allow
-	 * it to be specified during remount, but only if there is no change.
-	 */
-	if (is_remount && !sbi->s_dummy_enc_policy.policy) {
-		ext4_msg(sb, KERN_WARNING,
-			 "Can't set test_dummy_encryption on remount");
-		return -1;
-	}
-	err = fscrypt_set_test_dummy_encryption(sb, param->string,
+	err = fscrypt_set_test_dummy_encryption(sb, arg,
 						&sbi->s_dummy_enc_policy);
 	if (err) {
-		if (err == -EEXIST)
-			ext4_msg(sb, KERN_WARNING,
-				 "Can't change test_dummy_encryption on remount");
-		else if (err == -EINVAL)
-			ext4_msg(sb, KERN_WARNING,
-				 "Value of option \"%s\" is unrecognized",
-				 param->key);
-		else
-			ext4_msg(sb, KERN_WARNING,
-				 "Error processing option \"%s\" [%d]",
-				 param->key, err);
-		return -1;
+		ext4_msg(sb, KERN_WARNING,
+			 "Error while setting test dummy encryption [%d]", err);
+		return err;
 	}
 	ext4_msg(sb, KERN_WARNING, "Test dummy encryption mode enabled");
-#else
-	ext4_msg(sb, KERN_WARNING,
-		 "Test dummy encryption mount option ignored");
 #endif
-	return 1;
+	return 0;
 }
 
+#define EXT4_SPEC_JQUOTA			(1 <<  0)
+#define EXT4_SPEC_JQFMT				(1 <<  1)
+#define EXT4_SPEC_DATAJ				(1 <<  2)
+#define EXT4_SPEC_SB_BLOCK			(1 <<  3)
+#define EXT4_SPEC_JOURNAL_DEV			(1 <<  4)
+#define EXT4_SPEC_JOURNAL_IOPRIO		(1 <<  5)
+#define EXT4_SPEC_DUMMY_ENCRYPTION		(1 <<  6)
+#define EXT4_SPEC_s_want_extra_isize		(1 <<  7)
+#define EXT4_SPEC_s_max_batch_time		(1 <<  8)
+#define EXT4_SPEC_s_min_batch_time		(1 <<  9)
+#define EXT4_SPEC_s_inode_readahead_blks	(1 << 10)
+#define EXT4_SPEC_s_li_wait_mult		(1 << 11)
+#define EXT4_SPEC_s_max_dir_size_kb		(1 << 12)
+#define EXT4_SPEC_s_stripe			(1 << 13)
+#define EXT4_SPEC_s_resuid			(1 << 14)
+#define EXT4_SPEC_s_resgid			(1 << 15)
+#define EXT4_SPEC_s_commit_interval		(1 << 16)
+#define EXT4_SPEC_s_fc_debug_max_replay		(1 << 17)
+
 struct ext4_fs_context {
 	char		*s_qf_names[EXT4_MAXQUOTAS];
+	char		*test_dummy_enc_arg;
 	int		s_jquota_fmt;	/* Format of quota to use */
+	int		mb_optimize_scan;
+#ifdef CONFIG_EXT4_DEBUG
+	int s_fc_debug_max_replay;
+#endif
 	unsigned short	qname_spec;
+	unsigned long	vals_s_flags;	/* Bits to set in s_flags */
+	unsigned long	mask_s_flags;	/* Bits changed in s_flags */
 	unsigned long	journal_devnum;
+	unsigned long	s_commit_interval;
+	unsigned long	s_stripe;
+	unsigned int	s_inode_readahead_blks;
+	unsigned int	s_want_extra_isize;
+	unsigned int	s_li_wait_mult;
+	unsigned int	s_max_dir_size_kb;
 	unsigned int	journal_ioprio;
-	int 		mb_optimize_scan;
+	unsigned int	vals_s_mount_opt;
+	unsigned int	mask_s_mount_opt;
+	unsigned int	vals_s_mount_opt2;
+	unsigned int	mask_s_mount_opt2;
+	unsigned int	vals_s_mount_flags;
+	unsigned int	mask_s_mount_flags;
 	unsigned int	opt_flags;	/* MOPT flags */
+	unsigned int	spec;
+	u32		s_max_batch_time;
+	u32		s_min_batch_time;
+	kuid_t		s_resuid;
+	kgid_t		s_resgid;
 };
 
 #ifdef CONFIG_QUOTA
@@ -2231,6 +2247,7 @@ static int note_qf_name(struct fs_context *fc, int qtype,
 	}
 	ctx->s_qf_names[qtype] = qname;
 	ctx->qname_spec |= 1 << qtype;
+	ctx->spec |= EXT4_SPEC_JQUOTA;
 	return 0;
 }
 
@@ -2246,15 +2263,35 @@ static int unnote_qf_name(struct fs_context *fc, int qtype)
 
 	ctx->s_qf_names[qtype] = NULL;
 	ctx->qname_spec |= 1 << qtype;
+	ctx->spec |= EXT4_SPEC_JQUOTA;
 	return 0;
 }
 #endif
 
+#define EXT4_SET_CTX(name)						\
+static inline void ctx_set_##name(struct ext4_fs_context *ctx, int flag)\
+{									\
+	ctx->mask_s_##name |= flag;					\
+	ctx->vals_s_##name |= flag;					\
+}									\
+static inline void ctx_clear_##name(struct ext4_fs_context *ctx, int flag)\
+{									\
+	ctx->mask_s_##name |= flag;					\
+	ctx->vals_s_##name &= ~flag;					\
+}									\
+static inline bool ctx_test_##name(struct ext4_fs_context *ctx, int flag)\
+{									\
+	return ((ctx->vals_s_##name & flag) != 0);			\
+}									\
+
+EXT4_SET_CTX(flags);
+EXT4_SET_CTX(mount_opt);
+EXT4_SET_CTX(mount_opt2);
+EXT4_SET_CTX(mount_flags);
+
 static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct ext4_fs_context *ctx = fc->fs_private;
-	struct ext4_sb_info *sbi = fc->s_fs_info;
-	struct super_block *sb = sbi->s_sb;
 	struct fs_parse_result result;
 	const struct mount_opts *m;
 	int is_remount;
@@ -2292,20 +2329,20 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 			 param->key);
 		return 1;
 	case Opt_abort:
-		ext4_set_mount_flag(sb, EXT4_MF_FS_ABORTED);
+		ctx_set_mount_flags(ctx, EXT4_MF_FS_ABORTED);
 		return 1;
 	case Opt_i_version:
-		sb->s_flags |= SB_I_VERSION;
+		ctx_set_flags(ctx, SB_I_VERSION);
 		return 1;
 	case Opt_lazytime:
-		sb->s_flags |= SB_LAZYTIME;
+		ctx_set_flags(ctx, SB_LAZYTIME);
 		return 1;
 	case Opt_nolazytime:
-		sb->s_flags &= ~SB_LAZYTIME;
+		ctx_clear_flags(ctx, SB_LAZYTIME);
 		return 1;
 	case Opt_inlinecrypt:
 #ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
-		sb->s_flags |= SB_INLINECRYPT;
+		ctx_set_flags(ctx, SB_INLINECRYPT);
 #else
 		ext4_msg(NULL, KERN_ERR, "inline encryption not supported");
 #endif
@@ -2332,21 +2369,22 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 
 	if (m->flags & MOPT_EXPLICIT) {
 		if (m->mount_opt & EXT4_MOUNT_DELALLOC) {
-			set_opt2(sb, EXPLICIT_DELALLOC);
+			ctx_set_mount_opt2(ctx, EXT4_MOUNT2_EXPLICIT_DELALLOC);
 		} else if (m->mount_opt & EXT4_MOUNT_JOURNAL_CHECKSUM) {
-			set_opt2(sb, EXPLICIT_JOURNAL_CHECKSUM);
+			ctx_set_mount_opt2(ctx,
+				       EXT4_MOUNT2_EXPLICIT_JOURNAL_CHECKSUM);
 		} else
 			return -EINVAL;
 	}
 	if (m->flags & MOPT_CLEAR_ERR)
-		clear_opt(sb, ERRORS_MASK);
+		ctx_clear_mount_opt(ctx, EXT4_MOUNT_ERRORS_MASK);
 
 	if (m->flags & MOPT_NOSUPPORT) {
 		ext4_msg(NULL, KERN_ERR, "%s option not supported",
 			 param->key);
 	} else if (token == Opt_commit) {
 		if (result.uint_32 == 0)
-			sbi->s_commit_interval = JBD2_DEFAULT_MAX_COMMIT_AGE;
+			ctx->s_commit_interval = JBD2_DEFAULT_MAX_COMMIT_AGE;
 		else if (result.uint_32 > INT_MAX / HZ) {
 			ext4_msg(NULL, KERN_ERR,
 				 "Invalid commit interval %d, "
@@ -2354,21 +2392,22 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 				 result.uint_32, INT_MAX / HZ);
 			return -EINVAL;
 		}
-		sbi->s_commit_interval = HZ * result.uint_32;
+		ctx->s_commit_interval = HZ * result.uint_32;
+		ctx->spec |= EXT4_SPEC_s_commit_interval;
 	} else if (token == Opt_debug_want_extra_isize) {
-		if ((result.uint_32 & 1) ||
-		    (result.uint_32 < 4) ||
-		    (result.uint_32 >
-		     (sbi->s_inode_size - EXT4_GOOD_OLD_INODE_SIZE))) {
+		if ((result.uint_32 & 1) || (result.uint_32 < 4)) {
 			ext4_msg(NULL, KERN_ERR,
 				 "Invalid want_extra_isize %d", result.uint_32);
 			return -EINVAL;
 		}
-		sbi->s_want_extra_isize = result.uint_32;
+		ctx->s_want_extra_isize = result.uint_32;
+		ctx->spec |= EXT4_SPEC_s_want_extra_isize;
 	} else if (token == Opt_max_batch_time) {
-		sbi->s_max_batch_time = result.uint_32;
+		ctx->s_max_batch_time = result.uint_32;
+		ctx->spec |= EXT4_SPEC_s_max_batch_time;
 	} else if (token == Opt_min_batch_time) {
-		sbi->s_min_batch_time = result.uint_32;
+		ctx->s_min_batch_time = result.uint_32;
+		ctx->spec |= EXT4_SPEC_s_min_batch_time;
 	} else if (token == Opt_inode_readahead_blks) {
 		if (result.uint_32 &&
 		    (result.uint_32 > (1 << 30) ||
@@ -2378,20 +2417,25 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 				 "0 or a power of 2 smaller than 2^31");
 			return -EINVAL;
 		}
-		sbi->s_inode_readahead_blks = result.uint_32;
+		ctx->s_inode_readahead_blks = result.uint_32;
+		ctx->spec |= EXT4_SPEC_s_inode_readahead_blks;
 	} else if (token == Opt_init_itable) {
-		set_opt(sb, INIT_INODE_TABLE);
-		sbi->s_li_wait_mult = EXT4_DEF_LI_WAIT_MULT;
+		ctx_set_mount_opt(ctx, EXT4_MOUNT_INIT_INODE_TABLE);
+		ctx->s_li_wait_mult = EXT4_DEF_LI_WAIT_MULT;
 		if (param->type == fs_value_is_string)
-			sbi->s_li_wait_mult = result.uint_32;
+			ctx->s_li_wait_mult = result.uint_32;
+		ctx->spec |= EXT4_SPEC_s_li_wait_mult;
 	} else if (token == Opt_max_dir_size_kb) {
-		sbi->s_max_dir_size_kb = result.uint_32;
+		ctx->s_max_dir_size_kb = result.uint_32;
+		ctx->spec |= EXT4_SPEC_s_max_dir_size_kb;
 #ifdef CONFIG_EXT4_DEBUG
 	} else if (token == Opt_fc_debug_max_replay) {
-		sbi->s_fc_debug_max_replay = result.uint_32;
+		ctx->s_fc_debug_max_replay = result.uint_32;
+		ctx->spec |= EXT4_SPEC_s_fc_debug_max_replay;
 #endif
 	} else if (token == Opt_stripe) {
-		sbi->s_stripe = result.uint_32;
+		ctx->s_stripe = result.uint_32;
+		ctx->spec |= EXT4_SPEC_s_stripe;
 	} else if (token == Opt_resuid) {
 		uid = make_kuid(current_user_ns(), result.uint_32);
 		if (!uid_valid(uid)) {
@@ -2399,7 +2443,8 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 				 result.uint_32);
 			return -EINVAL;
 		}
-		sbi->s_resuid = uid;
+		ctx->s_resuid = uid;
+		ctx->spec |= EXT4_SPEC_s_resuid;
 	} else if (token == Opt_resgid) {
 		gid = make_kgid(current_user_ns(), result.uint_32);
 		if (!gid_valid(gid)) {
@@ -2407,7 +2452,8 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 				 result.uint_32);
 			return -EINVAL;
 		}
-		sbi->s_resgid = gid;
+		ctx->s_resgid = gid;
+		ctx->spec |= EXT4_SPEC_s_resgid;
 	} else if (token == Opt_journal_dev) {
 		if (is_remount) {
 			ext4_msg(NULL, KERN_ERR,
@@ -2415,6 +2461,7 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 			return -EINVAL;
 		}
 		ctx->journal_devnum = result.uint_32;
+		ctx->spec |= EXT4_SPEC_JOURNAL_DEV;
 	} else if (token == Opt_journal_path) {
 		struct inode *journal_inode;
 		struct path path;
@@ -2435,6 +2482,7 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 
 		journal_inode = d_inode(path.dentry);
 		ctx->journal_devnum = new_encode_dev(journal_inode->i_rdev);
+		ctx->spec |= EXT4_SPEC_JOURNAL_DEV;
 		path_put(&path);
 	} else if (token == Opt_journal_ioprio) {
 		if (result.uint_32 > 7) {
@@ -2444,24 +2492,37 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		}
 		ctx->journal_ioprio =
 			IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, result.uint_32);
+		ctx->spec |= EXT4_SPEC_JOURNAL_IOPRIO;
 	} else if (token == Opt_test_dummy_encryption) {
-		return ext4_set_test_dummy_encryption(sb, param, is_remount);
-	} else if (m->flags & MOPT_DATAJ) {
-		if (is_remount) {
-			if (!sbi->s_journal)
-				ext4_msg(NULL, KERN_WARNING, "Remounting file system with no journal so ignoring journalled data option");
-			else if (test_opt(sb, DATA_FLAGS) != m->mount_opt) {
-				ext4_msg(NULL, KERN_ERR,
-					 "Cannot change data mode on remount");
-				return -EINVAL;
-			}
-		} else {
-			clear_opt(sb, DATA_FLAGS);
-			sbi->s_mount_opt |= m->mount_opt;
+#ifdef CONFIG_FS_ENCRYPTION
+		if (param->type == fs_value_is_flag) {
+			ctx->spec |= EXT4_SPEC_DUMMY_ENCRYPTION;
+			ctx->test_dummy_enc_arg = NULL;
+			return 1;
+		}
+		if (*param->string &&
+		    !(!strcmp(param->string, "v1") ||
+		      !strcmp(param->string, "v2"))) {
+			ext4_msg(NULL, KERN_WARNING,
+				 "Value of option \"%s\" is unrecognized",
+				 param->key);
+			return -EINVAL;
 		}
+		ctx->spec |= EXT4_SPEC_DUMMY_ENCRYPTION;
+		ctx->test_dummy_enc_arg = kmemdup_nul(param->string, param->size,
+						      GFP_KERNEL);
+#else
+		ext4_msg(NULL, KERN_WARNING,
+			 "Test dummy encryption mount option ignored");
+#endif
+	} else if (m->flags & MOPT_DATAJ) {
+		ctx_clear_mount_opt(ctx, EXT4_MOUNT_DATA_FLAGS);
+		ctx_set_mount_opt(ctx, m->mount_opt);
+		ctx->spec |= EXT4_SPEC_DATAJ;
 #ifdef CONFIG_QUOTA
 	} else if (m->flags & MOPT_QFMT) {
 		ctx->s_jquota_fmt = m->mount_opt;
+		ctx->spec |= EXT4_SPEC_JQFMT;
 #endif
 	} else if (token == Opt_dax || token == Opt_dax_always ||
 		   token == Opt_dax_inode || token == Opt_dax_never) {
@@ -2469,56 +2530,30 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		switch (token) {
 		case Opt_dax:
 		case Opt_dax_always:
-			if (is_remount &&
-			    (!(sbi->s_mount_opt & EXT4_MOUNT_DAX_ALWAYS) ||
-			     (sbi->s_mount_opt2 & EXT4_MOUNT2_DAX_NEVER))) {
-			fail_dax_change_remount:
-				ext4_msg(NULL, KERN_ERR, "can't change "
-					 "dax mount option while remounting");
-				return -EINVAL;
-			}
-			if (is_remount &&
-			    (test_opt(sb, DATA_FLAGS) ==
-			     EXT4_MOUNT_JOURNAL_DATA)) {
-				    ext4_msg(NULL, KERN_ERR, "can't mount with "
-					     "both data=journal and dax");
-				    return -EINVAL;
-			}
-			ext4_msg(NULL, KERN_WARNING,
-				"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
-			sbi->s_mount_opt |= EXT4_MOUNT_DAX_ALWAYS;
-			sbi->s_mount_opt2 &= ~EXT4_MOUNT2_DAX_NEVER;
+			ctx_set_mount_opt(ctx, m->mount_opt);
+			ctx_clear_mount_opt2(ctx, EXT4_MOUNT2_DAX_NEVER);
 			break;
 		case Opt_dax_never:
-			if (is_remount &&
-			    (!(sbi->s_mount_opt2 & EXT4_MOUNT2_DAX_NEVER) ||
-			     (sbi->s_mount_opt & EXT4_MOUNT_DAX_ALWAYS)))
-				goto fail_dax_change_remount;
-			sbi->s_mount_opt2 |= EXT4_MOUNT2_DAX_NEVER;
-			sbi->s_mount_opt &= ~EXT4_MOUNT_DAX_ALWAYS;
+			ctx_set_mount_opt2(ctx, m->mount_opt);
+			ctx_clear_mount_opt(ctx, EXT4_MOUNT_DAX_ALWAYS);
 			break;
 		case Opt_dax_inode:
-			if (is_remount &&
-			    ((sbi->s_mount_opt & EXT4_MOUNT_DAX_ALWAYS) ||
-			     (sbi->s_mount_opt2 & EXT4_MOUNT2_DAX_NEVER) ||
-			     !(sbi->s_mount_opt2 & EXT4_MOUNT2_DAX_INODE)))
-				goto fail_dax_change_remount;
-			sbi->s_mount_opt &= ~EXT4_MOUNT_DAX_ALWAYS;
-			sbi->s_mount_opt2 &= ~EXT4_MOUNT2_DAX_NEVER;
+			ctx_clear_mount_opt(ctx, EXT4_MOUNT_DAX_ALWAYS);
+			ctx_clear_mount_opt2(ctx, EXT4_MOUNT2_DAX_NEVER);
 			/* Strictly for printing options */
-			sbi->s_mount_opt2 |= EXT4_MOUNT2_DAX_INODE;
+			ctx_set_mount_opt2(ctx, m->mount_opt);
 			break;
 		}
 #else
 		ext4_msg(NULL, KERN_INFO, "dax option not supported");
-		sbi->s_mount_opt2 |= EXT4_MOUNT2_DAX_NEVER;
-		sbi->s_mount_opt &= ~EXT4_MOUNT_DAX_ALWAYS;
+		ctx_set_mount_opt2(ctx, EXT4_MOUNT2_DAX_NEVER);
+		ctx_clear_mount_opt(ctx, EXT4_MOUNT_DAX_ALWAYS);
 		return -EINVAL;
 #endif
 	} else if (token == Opt_data_err_abort) {
-		sbi->s_mount_opt |= m->mount_opt;
+		ctx_set_mount_opt(ctx, m->mount_opt);
 	} else if (token == Opt_data_err_ignore) {
-		sbi->s_mount_opt &= ~m->mount_opt;
+		ctx_clear_mount_opt(ctx, m->mount_opt);
 	} else if (token == Opt_mb_optimize_scan) {
 		if (result.int_32 != 0 && result.int_32 != 1) {
 			ext4_msg(NULL, KERN_WARNING,
@@ -2544,14 +2579,14 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		}
 		if (m->flags & MOPT_2) {
 			if (set != 0)
-				sbi->s_mount_opt2 |= m->mount_opt;
+				ctx_set_mount_opt2(ctx, m->mount_opt);
 			else
-				sbi->s_mount_opt2 &= ~m->mount_opt;
+				ctx_clear_mount_opt2(ctx, m->mount_opt);
 		} else {
 			if (set != 0)
-				sbi->s_mount_opt |= m->mount_opt;
+				ctx_set_mount_opt(ctx, m->mount_opt);
 			else
-				sbi->s_mount_opt &= ~m->mount_opt;
+				ctx_clear_mount_opt(ctx, m->mount_opt);
 		}
 	}
 	return 1;
@@ -2616,8 +2651,9 @@ static int parse_options(char *options, struct super_block *sb,
 	if (ret < 0)
 		return 0;
 
-	if (ctx->qname_spec)
-		ext4_apply_quota_options(&fc, sb);
+	ret = ext4_apply_options(&fc, sb);
+	if (ret < 0)
+		return 0;
 
 	return 1;
 }
@@ -2626,20 +2662,30 @@ static void ext4_apply_quota_options(struct fs_context *fc,
 				     struct super_block *sb)
 {
 #ifdef CONFIG_QUOTA
+	bool quota_feature = ext4_has_feature_quota(sb);
 	struct ext4_fs_context *ctx = fc->fs_private;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	char *qname;
 	int i;
 
-	for (i = 0; i < EXT4_MAXQUOTAS; i++) {
-		if (!(ctx->qname_spec & (1 << i)))
-			continue;
-		qname = ctx->s_qf_names[i]; /* May be NULL */
-		ctx->s_qf_names[i] = NULL;
-		kfree(sbi->s_qf_names[i]);
-		rcu_assign_pointer(sbi->s_qf_names[i], qname);
-		set_opt(sb, QUOTA);
+	if (quota_feature)
+		return;
+
+	if (ctx->spec & EXT4_SPEC_JQUOTA) {
+		for (i = 0; i < EXT4_MAXQUOTAS; i++) {
+			if (!(ctx->qname_spec & (1 << i)))
+				continue;
+
+			qname = ctx->s_qf_names[i]; /* May be NULL */
+			ctx->s_qf_names[i] = NULL;
+			kfree(sbi->s_qf_names[i]);
+			rcu_assign_pointer(sbi->s_qf_names[i], qname);
+			set_opt(sb, QUOTA);
+		}
 	}
+
+	if (ctx->spec & EXT4_SPEC_JQFMT)
+		sbi->s_jquota_fmt = ctx->s_jquota_fmt;
 #endif
 }
 
@@ -2654,17 +2700,36 @@ static int ext4_check_quota_consistency(struct fs_context *fc,
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	bool quota_feature = ext4_has_feature_quota(sb);
 	bool quota_loaded = sb_any_quota_loaded(sb);
-	int i;
+	bool usr_qf_name, grp_qf_name, usrquota, grpquota;
+	int quota_flags, i;
+
+	/*
+	 * We do the test below only for project quotas. 'usrquota' and
+	 * 'grpquota' mount options are allowed even without quota feature
+	 * to support legacy quotas in quota files.
+	 */
+	if (ctx_test_mount_opt(ctx, EXT4_MOUNT_PRJQUOTA) &&
+	    !ext4_has_feature_project(sb)) {
+		ext4_msg(NULL, KERN_ERR, "Project quota feature not enabled. "
+			 "Cannot enable project quota enforcement.");
+		return -EINVAL;
+	}
+
+	quota_flags = EXT4_MOUNT_QUOTA | EXT4_MOUNT_USRQUOTA |
+		      EXT4_MOUNT_GRPQUOTA | EXT4_MOUNT_PRJQUOTA;
+	if (quota_loaded &&
+	    ctx->mask_s_mount_opt & quota_flags &&
+	    !ctx_test_mount_opt(ctx, quota_flags))
+		goto err_quota_change;
 
-	if (ctx->qname_spec && quota_loaded) {
-		if (quota_feature)
-			goto err_feature;
+	if (ctx->spec & EXT4_SPEC_JQUOTA) {
 
 		for (i = 0; i < EXT4_MAXQUOTAS; i++) {
 			if (!(ctx->qname_spec & (1 << i)))
 				continue;
 
-			if (!!sbi->s_qf_names[i] != !!ctx->s_qf_names[i])
+			if (quota_loaded &&
+			    !!sbi->s_qf_names[i] != !!ctx->s_qf_names[i])
 				goto err_jquota_change;
 
 			if (sbi->s_qf_names[i] && ctx->s_qf_names[i] &&
@@ -2672,17 +2737,60 @@ static int ext4_check_quota_consistency(struct fs_context *fc,
 				   ctx->s_qf_names[i]) != 0)
 				goto err_jquota_specified;
 		}
+
+		if (quota_feature) {
+			ext4_msg(NULL, KERN_INFO,
+				 "Ext4: Journaled quota options ignored when "
+				 "QUOTA feature is enabled");
+			return 0;
+		}
 	}
 
-	if (ctx->s_jquota_fmt) {
+	if (ctx->spec & EXT4_SPEC_JQFMT) {
 		if (sbi->s_jquota_fmt != ctx->s_jquota_fmt && quota_loaded)
-			goto err_quota_change;
+			goto err_jquota_change;
 		if (quota_feature) {
 			ext4_msg(NULL, KERN_INFO, "Quota format mount options "
 				 "ignored when QUOTA feature is enabled");
 			return 0;
 		}
 	}
+
+	/* Make sure we don't mix old and new quota format */
+	usr_qf_name = (get_qf_name(sb, sbi, USRQUOTA) ||
+		       ctx->s_qf_names[USRQUOTA]);
+	grp_qf_name = (get_qf_name(sb, sbi, GRPQUOTA) ||
+		       ctx->s_qf_names[GRPQUOTA]);
+
+	usrquota = (ctx_test_mount_opt(ctx, EXT4_MOUNT_USRQUOTA) ||
+		    test_opt(sb, USRQUOTA));
+
+	grpquota = (ctx_test_mount_opt(ctx, EXT4_MOUNT_GRPQUOTA) ||
+		    test_opt(sb, GRPQUOTA));
+
+	if (usr_qf_name) {
+		ctx_clear_mount_opt(ctx, EXT4_MOUNT_USRQUOTA);
+		usrquota = false;
+	}
+	if (grp_qf_name) {
+		ctx_clear_mount_opt(ctx, EXT4_MOUNT_GRPQUOTA);
+		grpquota = false;
+	}
+
+	if (usr_qf_name || grp_qf_name) {
+		if (usrquota || grpquota) {
+			ext4_msg(NULL, KERN_ERR, "old and new quota "
+				 "format mixing");
+			return -EINVAL;
+		}
+
+		if (!(ctx->spec & EXT4_SPEC_JQFMT || sbi->s_jquota_fmt)) {
+			ext4_msg(NULL, KERN_ERR, "journaled quota format "
+				 "not specified");
+			return -EINVAL;
+		}
+	}
+
 	return 0;
 
 err_quota_change:
@@ -2696,10 +2804,6 @@ static int ext4_check_quota_consistency(struct fs_context *fc,
 err_jquota_specified:
 	ext4_msg(NULL, KERN_ERR, "Ext4: Quota file already specified");
 	return -EINVAL;
-err_feature:
-	ext4_msg(NULL, KERN_ERR, "Ext4: Journaled quota options ignored "
-		 "when QUOTA feature is enabled");
-	return 0;
 #else
 	return 0;
 #endif
@@ -2709,6 +2813,8 @@ static int ext4_check_opt_consistency(struct fs_context *fc,
 				      struct super_block *sb)
 {
 	struct ext4_fs_context *ctx = fc->fs_private;
+	struct ext4_sb_info *sbi = fc->s_fs_info;
+	int is_remount = fc->purpose == FS_CONTEXT_FOR_RECONFIGURE;
 
 	if ((ctx->opt_flags & MOPT_NO_EXT2) && IS_EXT2_SB(sb)) {
 		ext4_msg(NULL, KERN_ERR,
@@ -2721,57 +2827,146 @@ static int ext4_check_opt_consistency(struct fs_context *fc,
 		return -EINVAL;
 	}
 
+	if (ctx->s_want_extra_isize >
+	    (sbi->s_inode_size - EXT4_GOOD_OLD_INODE_SIZE)) {
+		ext4_msg(NULL, KERN_ERR,
+			 "Invalid want_extra_isize %d",
+			 ctx->s_want_extra_isize);
+		return -EINVAL;
+	}
+
+	if (ctx_test_mount_opt(ctx, EXT4_MOUNT_DIOREAD_NOLOCK)) {
+		int blocksize =
+			BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
+		if (blocksize < PAGE_SIZE)
+			ext4_msg(NULL, KERN_WARNING, "Warning: mounting with an "
+				 "experimental mount option 'dioread_nolock' "
+				 "for blocksize < PAGE_SIZE");
+	}
+
+#ifdef CONFIG_FS_ENCRYPTION
+	/*
+	 * This mount option is just for testing, and it's not worthwhile to
+	 * implement the extra complexity (e.g. RCU protection) that would be
+	 * needed to allow it to be set or changed during remount.  We do allow
+	 * it to be specified during remount, but only if there is no change.
+	 */
+	if ((ctx->spec & EXT4_SPEC_DUMMY_ENCRYPTION) &&
+	    is_remount && !sbi->s_dummy_enc_policy.policy) {
+		ext4_msg(NULL, KERN_WARNING,
+			 "Can't set test_dummy_encryption on remount");
+		return -1;
+	}
+#endif
+
+	if ((ctx->spec & EXT4_SPEC_DATAJ) && is_remount) {
+		if (!sbi->s_journal) {
+			ext4_msg(NULL, KERN_WARNING,
+				 "Remounting file system with no journal "
+				 "so ignoring journalled data option");
+			ctx_clear_mount_opt(ctx, EXT4_MOUNT_DATA_FLAGS);
+		} else if (ctx->mask_s_mount_opt & EXT4_MOUNT_DATA_FLAGS) {
+			ext4_msg(NULL, KERN_ERR, "Cannot change data mode "
+				 "on remount");
+			return -EINVAL;
+		}
+	}
+
+	if (is_remount) {
+		if (ctx_test_mount_opt(ctx, EXT4_MOUNT_DAX_ALWAYS) &&
+		    (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA)) {
+			ext4_msg(NULL, KERN_ERR, "can't mount with "
+				 "both data=journal and dax");
+			return -EINVAL;
+		}
+
+		if (ctx_test_mount_opt(ctx, EXT4_MOUNT_DAX_ALWAYS) &&
+		    (!(sbi->s_mount_opt & EXT4_MOUNT_DAX_ALWAYS) ||
+		     (sbi->s_mount_opt2 & EXT4_MOUNT2_DAX_NEVER))) {
+fail_dax_change_remount:
+			ext4_msg(NULL, KERN_ERR, "can't change "
+				 "dax mount option while remounting");
+			return -EINVAL;
+		} else if (ctx_test_mount_opt2(ctx, EXT4_MOUNT2_DAX_NEVER) &&
+			 (!(sbi->s_mount_opt2 & EXT4_MOUNT2_DAX_NEVER) ||
+			  (sbi->s_mount_opt & EXT4_MOUNT_DAX_ALWAYS))) {
+			goto fail_dax_change_remount;
+		} else if (ctx_test_mount_opt2(ctx, EXT4_MOUNT2_DAX_INODE) &&
+			   ((sbi->s_mount_opt & EXT4_MOUNT_DAX_ALWAYS) ||
+			    (sbi->s_mount_opt2 & EXT4_MOUNT2_DAX_NEVER) ||
+			    !(sbi->s_mount_opt2 & EXT4_MOUNT2_DAX_INODE))) {
+			goto fail_dax_change_remount;
+		}
+	}
+
 	return ext4_check_quota_consistency(fc, sb);
 }
 
-static int ext4_validate_options(struct fs_context *fc)
+static int ext4_apply_options(struct fs_context *fc, struct super_block *sb)
 {
+	struct ext4_fs_context *ctx = fc->fs_private;
 	struct ext4_sb_info *sbi = fc->s_fs_info;
-	struct super_block *sb = sbi->s_sb;
+	int ret = 0;
+
+	sbi->s_mount_opt &= ~ctx->mask_s_mount_opt;
+	sbi->s_mount_opt |= ctx->vals_s_mount_opt;
+	sbi->s_mount_opt2 &= ~ctx->mask_s_mount_opt2;
+	sbi->s_mount_opt2 |= ctx->vals_s_mount_opt2;
+	sbi->s_mount_flags &= ~ctx->mask_s_mount_flags;
+	sbi->s_mount_flags |= ctx->vals_s_mount_flags;
+	sb->s_flags &= ~ctx->mask_s_flags;
+	sb->s_flags |= ctx->vals_s_flags;
+
+#define APPLY(X) ({ if (ctx->spec & EXT4_SPEC_##X) sbi->X = ctx->X; })
+	APPLY(s_commit_interval);
+	APPLY(s_stripe);
+	APPLY(s_max_batch_time);
+	APPLY(s_min_batch_time);
+	APPLY(s_want_extra_isize);
+	APPLY(s_inode_readahead_blks);
+	APPLY(s_max_dir_size_kb);
+	APPLY(s_li_wait_mult);
+	APPLY(s_resgid);
+	APPLY(s_resuid);
+
+#ifdef CONFIG_EXT4_DEBUG
+	APPLY(s_fc_debug_max_replay);
+#endif
+
+	ext4_apply_quota_options(fc, sb);
+
+	if (ctx->spec & EXT4_SPEC_DUMMY_ENCRYPTION)
+		ret = ext4_set_test_dummy_encryption(sb, ctx->test_dummy_enc_arg);
+
+	return ret;
+}
+
+
+static int ext4_validate_options(struct fs_context *fc)
+{
+	struct ext4_fs_context *ctx = fc->fs_private;
 #ifdef CONFIG_QUOTA
 	char *usr_qf_name, *grp_qf_name;
-	/*
-	 * We do the test below only for project quotas. 'usrquota' and
-	 * 'grpquota' mount options are allowed even without quota feature
-	 * to support legacy quotas in quota files.
-	 */
-	if (test_opt(sb, PRJQUOTA) && !ext4_has_feature_project(sb)) {
-		ext4_msg(NULL, KERN_ERR, "Project quota feature not enabled. "
-			 "Cannot enable project quota enforcement.");
-		return -EINVAL;
-	}
-	usr_qf_name = get_qf_name(sb, sbi, USRQUOTA);
-	grp_qf_name = get_qf_name(sb, sbi, GRPQUOTA);
+
+	usr_qf_name = ctx->s_qf_names[USRQUOTA];
+	grp_qf_name = ctx->s_qf_names[GRPQUOTA];
+
 	if (usr_qf_name || grp_qf_name) {
-		if (test_opt(sb, USRQUOTA) && usr_qf_name)
-			clear_opt(sb, USRQUOTA);
+		if (ctx_test_mount_opt(ctx, EXT4_MOUNT_USRQUOTA) && usr_qf_name)
+			ctx_clear_mount_opt(ctx, EXT4_MOUNT_USRQUOTA);
 
-		if (test_opt(sb, GRPQUOTA) && grp_qf_name)
-			clear_opt(sb, GRPQUOTA);
+		if (ctx_test_mount_opt(ctx, EXT4_MOUNT_GRPQUOTA) && grp_qf_name)
+			ctx_clear_mount_opt(ctx, EXT4_MOUNT_GRPQUOTA);
 
-		if (test_opt(sb, GRPQUOTA) || test_opt(sb, USRQUOTA)) {
+		if (ctx_test_mount_opt(ctx, EXT4_MOUNT_USRQUOTA) ||
+		    ctx_test_mount_opt(ctx, EXT4_MOUNT_GRPQUOTA)) {
 			ext4_msg(NULL, KERN_ERR, "old and new quota "
-					"format mixing");
-			return -EINVAL;
-		}
-
-		if (!sbi->s_jquota_fmt) {
-			ext4_msg(NULL, KERN_ERR, "journaled quota format "
-					"not specified");
+				 "format mixing");
 			return -EINVAL;
 		}
 	}
 #endif
-	if (test_opt(sb, DIOREAD_NOLOCK)) {
-		int blocksize =
-			BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
-		if (blocksize < PAGE_SIZE)
-			ext4_msg(NULL, KERN_WARNING,
-				 "Warning: mounting with an experimental "
-				 "option 'dioread_nolock' for "
-				 "blocksize < PAGE_SIZE");
-	}
-	return 0;
+	return 1;
 }
 
 static inline void ext4_show_quota_options(struct seq_file *seq,
-- 
2.31.1

