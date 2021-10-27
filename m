Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52FB43CBEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 16:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242508AbhJ0OWC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 10:22:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40368 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242506AbhJ0OVq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635344360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NqgN2dICU4jMKUgozAxjyBKoQ/617uQcAMWmvefRExM=;
        b=MWNBC47/O2Xz/aX/+Or1dp3s0Aexx1K/Ht1JDoJNs1jaxH7mOM9Nbazq3G7Tw3Sb+Ug4MQ
        Ac1//6F2VjeJl4dexEjM3DksyaeNwX9P6skwmw2Br+O5+qMl8zVEs7eWVnTGajxMUlc0fi
        kiF4fDHCOuXprsL29CU6SElZJ5d6WDg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-RSDUdIq2PtSBfQjQKs-i6A-1; Wed, 27 Oct 2021 10:19:19 -0400
X-MC-Unique: RSDUdIq2PtSBfQjQKs-i6A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F23E108088A;
        Wed, 27 Oct 2021 14:19:18 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5137E5DF35;
        Wed, 27 Oct 2021 14:19:17 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     linux-fsdevel@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: [PATCH v4 04/13] ext4: Change handle_mount_opt() to use fs_parameter
Date:   Wed, 27 Oct 2021 16:18:48 +0200
Message-Id: <20211027141857.33657-5-lczerner@redhat.com>
In-Reply-To: <20211027141857.33657-1-lczerner@redhat.com>
References: <20211027141857.33657-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the new mount option specifications to parse the options in
handle_mount_opt(). However we're still using the old API to get the
options string.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 fs/ext4/super.c | 250 +++++++++++++++++++++++++++---------------------
 1 file changed, 143 insertions(+), 107 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 5f6ad0615a2a..66b8e8850726 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1974,7 +1974,8 @@ static const char deprecated_msg[] =
 	"Contact linux-ext4@vger.kernel.org if you think we should keep it.\n";
 
 #ifdef CONFIG_QUOTA
-static int set_qf_name(struct super_block *sb, int qtype, substring_t *args)
+static int set_qf_name(struct super_block *sb, int qtype,
+		       struct fs_parameter *param)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	char *qname, *old_qname = get_qf_name(sb, sbi, qtype);
@@ -1991,7 +1992,7 @@ static int set_qf_name(struct super_block *sb, int qtype, substring_t *args)
 			 "ignored when QUOTA feature is enabled");
 		return 1;
 	}
-	qname = match_strdup(args);
+	qname = kmemdup_nul(param->string, param->size, GFP_KERNEL);
 	if (!qname) {
 		ext4_msg(sb, KERN_ERR,
 			"Not enough memory for storing quotafile name");
@@ -2197,8 +2198,7 @@ static int ext4_sb_read_encoding(const struct ext4_super_block *es,
 #endif
 
 static int ext4_set_test_dummy_encryption(struct super_block *sb,
-					  const char *opt,
-					  const substring_t *arg,
+					  struct fs_parameter *param,
 					  bool is_remount)
 {
 #ifdef CONFIG_FS_ENCRYPTION
@@ -2216,7 +2216,7 @@ static int ext4_set_test_dummy_encryption(struct super_block *sb,
 			 "Can't set test_dummy_encryption on remount");
 		return -1;
 	}
-	err = fscrypt_set_test_dummy_encryption(sb, arg->from,
+	err = fscrypt_set_test_dummy_encryption(sb, param->string,
 						&sbi->s_dummy_enc_policy);
 	if (err) {
 		if (err == -EEXIST)
@@ -2224,11 +2224,12 @@ static int ext4_set_test_dummy_encryption(struct super_block *sb,
 				 "Can't change test_dummy_encryption on remount");
 		else if (err == -EINVAL)
 			ext4_msg(sb, KERN_WARNING,
-				 "Value of option \"%s\" is unrecognized", opt);
+				 "Value of option \"%s\" is unrecognized",
+				 param->key);
 		else
 			ext4_msg(sb, KERN_WARNING,
 				 "Error processing option \"%s\" [%d]",
-				 opt, err);
+				 param->key, err);
 		return -1;
 	}
 	ext4_msg(sb, KERN_WARNING, "Test dummy encryption mode enabled");
@@ -2239,41 +2240,52 @@ static int ext4_set_test_dummy_encryption(struct super_block *sb,
 	return 1;
 }
 
-struct ext4_parsed_options {
+struct ext4_fs_context {
 	unsigned long journal_devnum;
 	unsigned int journal_ioprio;
 	int mb_optimize_scan;
 };
 
-static int handle_mount_opt(struct super_block *sb, char *opt, int token,
-			    substring_t *args, struct ext4_parsed_options *parsed_opts,
-			    int is_remount)
+static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 {
-	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_fs_context *ctx = fc->fs_private;
+	struct ext4_sb_info *sbi = fc->s_fs_info;
+	struct super_block *sb = sbi->s_sb;
+	struct fs_parse_result result;
 	const struct mount_opts *m;
+	int is_remount;
 	kuid_t uid;
 	kgid_t gid;
-	int arg = 0;
+	int token;
+
+	token = fs_parse(fc, ext4_param_specs, param, &result);
+	if (token < 0)
+		return token;
+	is_remount = fc->purpose == FS_CONTEXT_FOR_RECONFIGURE;
 
 #ifdef CONFIG_QUOTA
-	if (token == Opt_usrjquota)
-		return set_qf_name(sb, USRQUOTA, &args[0]);
-	else if (token == Opt_grpjquota)
-		return set_qf_name(sb, GRPQUOTA, &args[0]);
-	else if (token == Opt_offusrjquota)
-		return clear_qf_name(sb, USRQUOTA);
-	else if (token == Opt_offgrpjquota)
-		return clear_qf_name(sb, GRPQUOTA);
+	if (token == Opt_usrjquota) {
+		if (!*param->string)
+			return clear_qf_name(sb, USRQUOTA);
+		else
+			return set_qf_name(sb, USRQUOTA, param);
+	} else if (token == Opt_grpjquota) {
+		if (!*param->string)
+			return clear_qf_name(sb, GRPQUOTA);
+		else
+			return set_qf_name(sb, GRPQUOTA, param);
+	}
 #endif
 	switch (token) {
 	case Opt_noacl:
 	case Opt_nouser_xattr:
-		ext4_msg(sb, KERN_WARNING, deprecated_msg, opt, "3.5");
+		ext4_msg(sb, KERN_WARNING, deprecated_msg, param->key, "3.5");
 		break;
 	case Opt_sb:
 		return 1;	/* handled by get_sb_block() */
 	case Opt_removed:
-		ext4_msg(sb, KERN_WARNING, "Ignoring removed %s option", opt);
+		ext4_msg(sb, KERN_WARNING, "Ignoring removed %s option",
+			 param->key);
 		return 1;
 	case Opt_abort:
 		ext4_set_mount_flag(sb, EXT4_MF_FS_ABORTED);
@@ -2294,6 +2306,12 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
 		ext4_msg(sb, KERN_ERR, "inline encryption not supported");
 #endif
 		return 1;
+	case Opt_errors:
+	case Opt_data:
+	case Opt_data_err:
+	case Opt_jqfmt:
+	case Opt_dax_type:
+		token = result.uint_32;
 	}
 
 	for (m = ext4_mount_opts; m->token != Opt_err; m++)
@@ -2302,25 +2320,23 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
 
 	if (m->token == Opt_err) {
 		ext4_msg(sb, KERN_ERR, "Unrecognized mount option \"%s\" "
-			 "or missing value", opt);
+			 "or missing value", param->key);
 		return -1;
 	}
 
 	if ((m->flags & MOPT_NO_EXT2) && IS_EXT2_SB(sb)) {
 		ext4_msg(sb, KERN_ERR,
-			 "Mount option \"%s\" incompatible with ext2", opt);
+			 "Mount option \"%s\" incompatible with ext2",
+			 param->key);
 		return -1;
 	}
 	if ((m->flags & MOPT_NO_EXT3) && IS_EXT3_SB(sb)) {
 		ext4_msg(sb, KERN_ERR,
-			 "Mount option \"%s\" incompatible with ext3", opt);
+			 "Mount option \"%s\" incompatible with ext3",
+			 param->key);
 		return -1;
 	}
 
-	if (args->from && !(m->flags & MOPT_STRING) && match_int(args, &arg))
-		return -1;
-	if (args->from && (m->flags & MOPT_GTE0) && (arg < 0))
-		return -1;
 	if (m->flags & MOPT_EXPLICIT) {
 		if (m->mount_opt & EXT4_MOUNT_DELALLOC) {
 			set_opt2(sb, EXPLICIT_DELALLOC);
@@ -2338,63 +2354,69 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
 	}
 
 	if (m->flags & MOPT_NOSUPPORT) {
-		ext4_msg(sb, KERN_ERR, "%s option not supported", opt);
+		ext4_msg(sb, KERN_ERR, "%s option not supported",
+			 param->key);
 	} else if (token == Opt_commit) {
-		if (arg == 0)
-			arg = JBD2_DEFAULT_MAX_COMMIT_AGE;
-		else if (arg > INT_MAX / HZ) {
+		if (result.uint_32 == 0)
+			sbi->s_commit_interval = JBD2_DEFAULT_MAX_COMMIT_AGE;
+		else if (result.uint_32 > INT_MAX / HZ) {
 			ext4_msg(sb, KERN_ERR,
 				 "Invalid commit interval %d, "
 				 "must be smaller than %d",
-				 arg, INT_MAX / HZ);
+				 result.uint_32, INT_MAX / HZ);
 			return -1;
 		}
-		sbi->s_commit_interval = HZ * arg;
+		sbi->s_commit_interval = HZ * result.uint_32;
 	} else if (token == Opt_debug_want_extra_isize) {
-		if ((arg & 1) ||
-		    (arg < 4) ||
-		    (arg > (sbi->s_inode_size - EXT4_GOOD_OLD_INODE_SIZE))) {
+		if ((result.uint_32 & 1) ||
+		    (result.uint_32 < 4) ||
+		    (result.uint_32 >
+		     (sbi->s_inode_size - EXT4_GOOD_OLD_INODE_SIZE))) {
 			ext4_msg(sb, KERN_ERR,
-				 "Invalid want_extra_isize %d", arg);
+				 "Invalid want_extra_isize %d", result.uint_32);
 			return -1;
 		}
-		sbi->s_want_extra_isize = arg;
+		sbi->s_want_extra_isize = result.uint_32;
 	} else if (token == Opt_max_batch_time) {
-		sbi->s_max_batch_time = arg;
+		sbi->s_max_batch_time = result.uint_32;
 	} else if (token == Opt_min_batch_time) {
-		sbi->s_min_batch_time = arg;
+		sbi->s_min_batch_time = result.uint_32;
 	} else if (token == Opt_inode_readahead_blks) {
-		if (arg && (arg > (1 << 30) || !is_power_of_2(arg))) {
+		if (result.uint_32 &&
+		    (result.uint_32 > (1 << 30) ||
+		     !is_power_of_2(result.uint_32))) {
 			ext4_msg(sb, KERN_ERR,
 				 "EXT4-fs: inode_readahead_blks must be "
 				 "0 or a power of 2 smaller than 2^31");
 			return -1;
 		}
-		sbi->s_inode_readahead_blks = arg;
+		sbi->s_inode_readahead_blks = result.uint_32;
 	} else if (token == Opt_init_itable) {
 		set_opt(sb, INIT_INODE_TABLE);
-		if (!args->from)
-			arg = EXT4_DEF_LI_WAIT_MULT;
-		sbi->s_li_wait_mult = arg;
+		sbi->s_li_wait_mult = EXT4_DEF_LI_WAIT_MULT;
+		if (param->type == fs_value_is_string)
+			sbi->s_li_wait_mult = result.uint_32;
 	} else if (token == Opt_max_dir_size_kb) {
-		sbi->s_max_dir_size_kb = arg;
+		sbi->s_max_dir_size_kb = result.uint_32;
 #ifdef CONFIG_EXT4_DEBUG
 	} else if (token == Opt_fc_debug_max_replay) {
-		sbi->s_fc_debug_max_replay = arg;
+		sbi->s_fc_debug_max_replay = result.uint_32;
 #endif
 	} else if (token == Opt_stripe) {
-		sbi->s_stripe = arg;
+		sbi->s_stripe = result.uint_32;
 	} else if (token == Opt_resuid) {
-		uid = make_kuid(current_user_ns(), arg);
+		uid = make_kuid(current_user_ns(), result.uint_32);
 		if (!uid_valid(uid)) {
-			ext4_msg(sb, KERN_ERR, "Invalid uid value %d", arg);
+			ext4_msg(sb, KERN_ERR, "Invalid uid value %d",
+				 result.uint_32);
 			return -1;
 		}
 		sbi->s_resuid = uid;
 	} else if (token == Opt_resgid) {
-		gid = make_kgid(current_user_ns(), arg);
+		gid = make_kgid(current_user_ns(), result.uint_32);
 		if (!gid_valid(gid)) {
-			ext4_msg(sb, KERN_ERR, "Invalid gid value %d", arg);
+			ext4_msg(sb, KERN_ERR, "Invalid gid value %d",
+				 result.uint_32);
 			return -1;
 		}
 		sbi->s_resgid = gid;
@@ -2404,9 +2426,8 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
 				 "Cannot specify journal on remount");
 			return -1;
 		}
-		parsed_opts->journal_devnum = arg;
+		ctx->journal_devnum = result.uint_32;
 	} else if (token == Opt_journal_path) {
-		char *journal_path;
 		struct inode *journal_inode;
 		struct path path;
 		int error;
@@ -2416,44 +2437,27 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
 				 "Cannot specify journal on remount");
 			return -1;
 		}
-		journal_path = match_strdup(&args[0]);
-		if (!journal_path) {
-			ext4_msg(sb, KERN_ERR, "error: could not dup "
-				"journal device string");
-			return -1;
-		}
 
-		error = kern_path(journal_path, LOOKUP_FOLLOW, &path);
+		error = fs_lookup_param(fc, param, 1, &path);
 		if (error) {
 			ext4_msg(sb, KERN_ERR, "error: could not find "
-				"journal device path: error %d", error);
-			kfree(journal_path);
+				 "journal device path");
 			return -1;
 		}
 
 		journal_inode = d_inode(path.dentry);
-		if (!S_ISBLK(journal_inode->i_mode)) {
-			ext4_msg(sb, KERN_ERR, "error: journal path %s "
-				"is not a block device", journal_path);
-			path_put(&path);
-			kfree(journal_path);
-			return -1;
-		}
-
-		parsed_opts->journal_devnum = new_encode_dev(journal_inode->i_rdev);
+		ctx->journal_devnum = new_encode_dev(journal_inode->i_rdev);
 		path_put(&path);
-		kfree(journal_path);
 	} else if (token == Opt_journal_ioprio) {
-		if (arg > 7) {
+		if (result.uint_32 > 7) {
 			ext4_msg(sb, KERN_ERR, "Invalid journal IO priority"
 				 " (must be 0-7)");
 			return -1;
 		}
-		parsed_opts->journal_ioprio =
-			IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, arg);
+		ctx->journal_ioprio =
+			IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, result.uint_32);
 	} else if (token == Opt_test_dummy_encryption) {
-		return ext4_set_test_dummy_encryption(sb, opt, &args[0],
-						      is_remount);
+		return ext4_set_test_dummy_encryption(sb, param, is_remount);
 	} else if (m->flags & MOPT_DATAJ) {
 		if (is_remount) {
 			if (!sbi->s_journal)
@@ -2540,30 +2544,35 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
 	} else if (token == Opt_data_err_ignore) {
 		sbi->s_mount_opt &= ~m->mount_opt;
 	} else if (token == Opt_mb_optimize_scan) {
-		if (arg != 0 && arg != 1) {
+		if (result.int_32 != 0 && result.int_32 != 1) {
 			ext4_msg(sb, KERN_WARNING,
 				 "mb_optimize_scan should be set to 0 or 1.");
 			return -1;
 		}
-		parsed_opts->mb_optimize_scan = arg;
+		ctx->mb_optimize_scan = result.int_32;
 	} else {
-		if (!args->from)
-			arg = 1;
+		unsigned int set = 0;
+
+		if ((param->type == fs_value_is_flag) ||
+		    result.uint_32 > 0)
+			set = 1;
+
 		if (m->flags & MOPT_CLEAR)
-			arg = !arg;
+			set = !set;
 		else if (unlikely(!(m->flags & MOPT_SET))) {
 			ext4_msg(sb, KERN_WARNING,
-				 "buggy handling of option %s", opt);
+				 "buggy handling of option %s",
+				 param->key);
 			WARN_ON(1);
 			return -1;
 		}
 		if (m->flags & MOPT_2) {
-			if (arg != 0)
+			if (set != 0)
 				sbi->s_mount_opt2 |= m->mount_opt;
 			else
 				sbi->s_mount_opt2 &= ~m->mount_opt;
 		} else {
-			if (arg != 0)
+			if (set != 0)
 				sbi->s_mount_opt |= m->mount_opt;
 			else
 				sbi->s_mount_opt &= ~m->mount_opt;
@@ -2573,29 +2582,56 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
 }
 
 static int parse_options(char *options, struct super_block *sb,
-			 struct ext4_parsed_options *ret_opts,
+			 struct ext4_fs_context *ret_opts,
 			 int is_remount)
 {
-	substring_t args[MAX_OPT_ARGS];
-	int token;
-	char *p;
+	struct fs_parameter param;
+	struct fs_context fc;
+	int ret;
+	char *key;
 
 	if (!options)
 		return 1;
 
-	while ((p = strsep(&options, ",")) != NULL) {
-		if (!*p)
-			continue;
-		/*
-		 * Initialize args struct so we know whether arg was
-		 * found; some options take optional arguments.
-		 */
-		args[0].to = args[0].from = NULL;
-		token = match_token(p, tokens, args);
-		if (handle_mount_opt(sb, p, token, args, ret_opts,
-				     is_remount) < 0)
-			return 0;
+	memset(&fc, 0, sizeof(fc));
+	fc.fs_private = ret_opts;
+	fc.s_fs_info = EXT4_SB(sb);
+
+	if (is_remount)
+		fc.purpose = FS_CONTEXT_FOR_RECONFIGURE;
+
+	while ((key = strsep(&options, ",")) != NULL) {
+		if (*key) {
+			size_t v_len = 0;
+			char *value = strchr(key, '=');
+
+			param.type = fs_value_is_flag;
+			param.string = NULL;
+
+			if (value) {
+				if (value == key)
+					continue;
+
+				*value++ = 0;
+				v_len = strlen(value);
+				param.string = kmemdup_nul(value, v_len,
+							   GFP_KERNEL);
+				if (!param.string)
+					return 0;
+				param.type = fs_value_is_string;
+			}
+
+			param.key = key;
+			param.size = v_len;
+
+			ret = handle_mount_opt(&fc, &param);
+			if (param.string)
+				kfree(param.string);
+			if (ret < 0)
+				return 0;
+		}
 	}
+
 	return ext4_validate_options(sb);
 }
 
@@ -4051,7 +4087,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	__u64 blocks_count;
 	int err = 0;
 	ext4_group_t first_not_zeroed;
-	struct ext4_parsed_options parsed_opts;
+	struct ext4_fs_context parsed_opts;
 
 	/* Set defaults for the variables that will be set during parsing */
 	parsed_opts.journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
@@ -5893,7 +5929,7 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	char *to_free[EXT4_MAXQUOTAS];
 #endif
 	char *orig_data = kstrdup(data, GFP_KERNEL);
-	struct ext4_parsed_options parsed_opts;
+	struct ext4_fs_context parsed_opts;
 
 	parsed_opts.journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
 	parsed_opts.journal_devnum = 0;
-- 
2.31.1

