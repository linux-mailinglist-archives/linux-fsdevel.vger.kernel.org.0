Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4672B4360A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 13:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhJULr5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 07:47:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58840 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230105AbhJULrk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 07:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634816724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EbRGfw/Ey+UayoPati0rE5X2rV2ylYN+VNRe8ZrLibM=;
        b=W3uXJc44wHpwCOGS0CeApdC6hdjc4H7rnPbwKIIAwaWQSDmkUFSuV20QIVJbBkJXpTxyBO
        cZJQLWKAwnEN01clZpR85Shb/N0tzUU2Xx0wRr1uTgtYr8jVXTptwCT5sd8oAJUXCpofM9
        sRNGncMUg9zywsk5Fsf11Cjg0JMyexE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-ixuXlqlZOVu-fPyvA6xtpQ-1; Thu, 21 Oct 2021 07:45:20 -0400
X-MC-Unique: ixuXlqlZOVu-fPyvA6xtpQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30FF7100F942;
        Thu, 21 Oct 2021 11:45:19 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 481DC69217;
        Thu, 21 Oct 2021 11:45:18 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 05/13] ext4: Allow sb to be NULL in ext4_msg()
Date:   Thu, 21 Oct 2021 13:45:00 +0200
Message-Id: <20211021114508.21407-6-lczerner@redhat.com>
In-Reply-To: <20211021114508.21407-1-lczerner@redhat.com>
References: <20211021114508.21407-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

At the parsing phase of mount in the new mount api sb will not be
available so allow sb to be NULL in ext4_msg and use that in
handle_mount_opt().

Also change return value to appropriate -EINVAL where needed.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/super.c | 144 ++++++++++++++++++++++++++----------------------
 1 file changed, 78 insertions(+), 66 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 66b8e8850726..b3c545695f2f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -87,7 +87,7 @@ static void ext4_unregister_li_request(struct super_block *sb);
 static void ext4_clear_request_list(void);
 static struct inode *ext4_get_journal_inode(struct super_block *sb,
 					    unsigned int journal_inum);
-static int ext4_validate_options(struct super_block *sb);
+static int ext4_validate_options(struct fs_context *fc);
 
 /*
  * Lock ordering
@@ -907,14 +907,20 @@ void __ext4_msg(struct super_block *sb,
 	struct va_format vaf;
 	va_list args;
 
-	atomic_inc(&EXT4_SB(sb)->s_msg_count);
-	if (!___ratelimit(&(EXT4_SB(sb)->s_msg_ratelimit_state), "EXT4-fs"))
-		return;
+	if (sb) {
+		atomic_inc(&EXT4_SB(sb)->s_msg_count);
+		if (!___ratelimit(&(EXT4_SB(sb)->s_msg_ratelimit_state),
+				  "EXT4-fs"))
+			return;
+	}
 
 	va_start(args, fmt);
 	vaf.fmt = fmt;
 	vaf.va = &args;
-	printk("%sEXT4-fs (%s): %pV\n", prefix, sb->s_id, &vaf);
+	if (sb)
+		printk("%sEXT4-fs (%s): %pV\n", prefix, sb->s_id, &vaf);
+	else
+		printk("%sEXT4-fs: %pV\n", prefix, &vaf);
 	va_end(args);
 }
 
@@ -2279,12 +2285,12 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 	switch (token) {
 	case Opt_noacl:
 	case Opt_nouser_xattr:
-		ext4_msg(sb, KERN_WARNING, deprecated_msg, param->key, "3.5");
+		ext4_msg(NULL, KERN_WARNING, deprecated_msg, param->key, "3.5");
 		break;
 	case Opt_sb:
 		return 1;	/* handled by get_sb_block() */
 	case Opt_removed:
-		ext4_msg(sb, KERN_WARNING, "Ignoring removed %s option",
+		ext4_msg(NULL, KERN_WARNING, "Ignoring removed %s option",
 			 param->key);
 		return 1;
 	case Opt_abort:
@@ -2303,7 +2309,7 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 #ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
 		sb->s_flags |= SB_INLINECRYPT;
 #else
-		ext4_msg(sb, KERN_ERR, "inline encryption not supported");
+		ext4_msg(NULL, KERN_ERR, "inline encryption not supported");
 #endif
 		return 1;
 	case Opt_errors:
@@ -2319,22 +2325,22 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 			break;
 
 	if (m->token == Opt_err) {
-		ext4_msg(sb, KERN_ERR, "Unrecognized mount option \"%s\" "
+		ext4_msg(NULL, KERN_ERR, "Unrecognized mount option \"%s\" "
 			 "or missing value", param->key);
-		return -1;
+		return -EINVAL;
 	}
 
 	if ((m->flags & MOPT_NO_EXT2) && IS_EXT2_SB(sb)) {
-		ext4_msg(sb, KERN_ERR,
+		ext4_msg(NULL, KERN_ERR,
 			 "Mount option \"%s\" incompatible with ext2",
 			 param->key);
-		return -1;
+		return -EINVAL;
 	}
 	if ((m->flags & MOPT_NO_EXT3) && IS_EXT3_SB(sb)) {
-		ext4_msg(sb, KERN_ERR,
+		ext4_msg(NULL, KERN_ERR,
 			 "Mount option \"%s\" incompatible with ext3",
 			 param->key);
-		return -1;
+		return -EINVAL;
 	}
 
 	if (m->flags & MOPT_EXPLICIT) {
@@ -2343,28 +2349,28 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		} else if (m->mount_opt & EXT4_MOUNT_JOURNAL_CHECKSUM) {
 			set_opt2(sb, EXPLICIT_JOURNAL_CHECKSUM);
 		} else
-			return -1;
+			return -EINVAL;
 	}
 	if (m->flags & MOPT_CLEAR_ERR)
 		clear_opt(sb, ERRORS_MASK);
 	if (token == Opt_noquota && sb_any_quota_loaded(sb)) {
-		ext4_msg(sb, KERN_ERR, "Cannot change quota "
+		ext4_msg(NULL, KERN_ERR, "Cannot change quota "
 			 "options when quota turned on");
-		return -1;
+		return -EINVAL;
 	}
 
 	if (m->flags & MOPT_NOSUPPORT) {
-		ext4_msg(sb, KERN_ERR, "%s option not supported",
+		ext4_msg(NULL, KERN_ERR, "%s option not supported",
 			 param->key);
 	} else if (token == Opt_commit) {
 		if (result.uint_32 == 0)
 			sbi->s_commit_interval = JBD2_DEFAULT_MAX_COMMIT_AGE;
 		else if (result.uint_32 > INT_MAX / HZ) {
-			ext4_msg(sb, KERN_ERR,
+			ext4_msg(NULL, KERN_ERR,
 				 "Invalid commit interval %d, "
 				 "must be smaller than %d",
 				 result.uint_32, INT_MAX / HZ);
-			return -1;
+			return -EINVAL;
 		}
 		sbi->s_commit_interval = HZ * result.uint_32;
 	} else if (token == Opt_debug_want_extra_isize) {
@@ -2372,9 +2378,9 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		    (result.uint_32 < 4) ||
 		    (result.uint_32 >
 		     (sbi->s_inode_size - EXT4_GOOD_OLD_INODE_SIZE))) {
-			ext4_msg(sb, KERN_ERR,
+			ext4_msg(NULL, KERN_ERR,
 				 "Invalid want_extra_isize %d", result.uint_32);
-			return -1;
+			return -EINVAL;
 		}
 		sbi->s_want_extra_isize = result.uint_32;
 	} else if (token == Opt_max_batch_time) {
@@ -2385,10 +2391,10 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		if (result.uint_32 &&
 		    (result.uint_32 > (1 << 30) ||
 		     !is_power_of_2(result.uint_32))) {
-			ext4_msg(sb, KERN_ERR,
+			ext4_msg(NULL, KERN_ERR,
 				 "EXT4-fs: inode_readahead_blks must be "
 				 "0 or a power of 2 smaller than 2^31");
-			return -1;
+			return -EINVAL;
 		}
 		sbi->s_inode_readahead_blks = result.uint_32;
 	} else if (token == Opt_init_itable) {
@@ -2407,24 +2413,24 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 	} else if (token == Opt_resuid) {
 		uid = make_kuid(current_user_ns(), result.uint_32);
 		if (!uid_valid(uid)) {
-			ext4_msg(sb, KERN_ERR, "Invalid uid value %d",
+			ext4_msg(NULL, KERN_ERR, "Invalid uid value %d",
 				 result.uint_32);
-			return -1;
+			return -EINVAL;
 		}
 		sbi->s_resuid = uid;
 	} else if (token == Opt_resgid) {
 		gid = make_kgid(current_user_ns(), result.uint_32);
 		if (!gid_valid(gid)) {
-			ext4_msg(sb, KERN_ERR, "Invalid gid value %d",
+			ext4_msg(NULL, KERN_ERR, "Invalid gid value %d",
 				 result.uint_32);
-			return -1;
+			return -EINVAL;
 		}
 		sbi->s_resgid = gid;
 	} else if (token == Opt_journal_dev) {
 		if (is_remount) {
-			ext4_msg(sb, KERN_ERR,
+			ext4_msg(NULL, KERN_ERR,
 				 "Cannot specify journal on remount");
-			return -1;
+			return -EINVAL;
 		}
 		ctx->journal_devnum = result.uint_32;
 	} else if (token == Opt_journal_path) {
@@ -2433,16 +2439,16 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		int error;
 
 		if (is_remount) {
-			ext4_msg(sb, KERN_ERR,
+			ext4_msg(NULL, KERN_ERR,
 				 "Cannot specify journal on remount");
-			return -1;
+			return -EINVAL;
 		}
 
 		error = fs_lookup_param(fc, param, 1, &path);
 		if (error) {
-			ext4_msg(sb, KERN_ERR, "error: could not find "
+			ext4_msg(NULL, KERN_ERR, "error: could not find "
 				 "journal device path");
-			return -1;
+			return -EINVAL;
 		}
 
 		journal_inode = d_inode(path.dentry);
@@ -2450,9 +2456,9 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		path_put(&path);
 	} else if (token == Opt_journal_ioprio) {
 		if (result.uint_32 > 7) {
-			ext4_msg(sb, KERN_ERR, "Invalid journal IO priority"
+			ext4_msg(NULL, KERN_ERR, "Invalid journal IO priority"
 				 " (must be 0-7)");
-			return -1;
+			return -EINVAL;
 		}
 		ctx->journal_ioprio =
 			IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, result.uint_32);
@@ -2461,11 +2467,11 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 	} else if (m->flags & MOPT_DATAJ) {
 		if (is_remount) {
 			if (!sbi->s_journal)
-				ext4_msg(sb, KERN_WARNING, "Remounting file system with no journal so ignoring journalled data option");
+				ext4_msg(NULL, KERN_WARNING, "Remounting file system with no journal so ignoring journalled data option");
 			else if (test_opt(sb, DATA_FLAGS) != m->mount_opt) {
-				ext4_msg(sb, KERN_ERR,
+				ext4_msg(NULL, KERN_ERR,
 					 "Cannot change data mode on remount");
-				return -1;
+				return -EINVAL;
 			}
 		} else {
 			clear_opt(sb, DATA_FLAGS);
@@ -2475,12 +2481,12 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 	} else if (m->flags & MOPT_QFMT) {
 		if (sb_any_quota_loaded(sb) &&
 		    sbi->s_jquota_fmt != m->mount_opt) {
-			ext4_msg(sb, KERN_ERR, "Cannot change journaled "
+			ext4_msg(NULL, KERN_ERR, "Cannot change journaled "
 				 "quota options when quota turned on");
-			return -1;
+			return -EINVAL;
 		}
 		if (ext4_has_feature_quota(sb)) {
-			ext4_msg(sb, KERN_INFO,
+			ext4_msg(NULL, KERN_INFO,
 				 "Quota format mount options ignored "
 				 "when QUOTA feature is enabled");
 			return 1;
@@ -2497,18 +2503,18 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 			    (!(sbi->s_mount_opt & EXT4_MOUNT_DAX_ALWAYS) ||
 			     (sbi->s_mount_opt2 & EXT4_MOUNT2_DAX_NEVER))) {
 			fail_dax_change_remount:
-				ext4_msg(sb, KERN_ERR, "can't change "
+				ext4_msg(NULL, KERN_ERR, "can't change "
 					 "dax mount option while remounting");
-				return -1;
+				return -EINVAL;
 			}
 			if (is_remount &&
 			    (test_opt(sb, DATA_FLAGS) ==
 			     EXT4_MOUNT_JOURNAL_DATA)) {
-				    ext4_msg(sb, KERN_ERR, "can't mount with "
+				    ext4_msg(NULL, KERN_ERR, "can't mount with "
 					     "both data=journal and dax");
-				    return -1;
+				    return -EINVAL;
 			}
-			ext4_msg(sb, KERN_WARNING,
+			ext4_msg(NULL, KERN_WARNING,
 				"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
 			sbi->s_mount_opt |= EXT4_MOUNT_DAX_ALWAYS;
 			sbi->s_mount_opt2 &= ~EXT4_MOUNT2_DAX_NEVER;
@@ -2534,10 +2540,10 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 			break;
 		}
 #else
-		ext4_msg(sb, KERN_INFO, "dax option not supported");
+		ext4_msg(NULL, KERN_INFO, "dax option not supported");
 		sbi->s_mount_opt2 |= EXT4_MOUNT2_DAX_NEVER;
 		sbi->s_mount_opt &= ~EXT4_MOUNT_DAX_ALWAYS;
-		return -1;
+		return -EINVAL;
 #endif
 	} else if (token == Opt_data_err_abort) {
 		sbi->s_mount_opt |= m->mount_opt;
@@ -2545,9 +2551,9 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		sbi->s_mount_opt &= ~m->mount_opt;
 	} else if (token == Opt_mb_optimize_scan) {
 		if (result.int_32 != 0 && result.int_32 != 1) {
-			ext4_msg(sb, KERN_WARNING,
+			ext4_msg(NULL, KERN_WARNING,
 				 "mb_optimize_scan should be set to 0 or 1.");
-			return -1;
+			return -EINVAL;
 		}
 		ctx->mb_optimize_scan = result.int_32;
 	} else {
@@ -2560,11 +2566,11 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		if (m->flags & MOPT_CLEAR)
 			set = !set;
 		else if (unlikely(!(m->flags & MOPT_SET))) {
-			ext4_msg(sb, KERN_WARNING,
+			ext4_msg(NULL, KERN_WARNING,
 				 "buggy handling of option %s",
 				 param->key);
 			WARN_ON(1);
-			return -1;
+			return -EINVAL;
 		}
 		if (m->flags & MOPT_2) {
 			if (set != 0)
@@ -2632,12 +2638,17 @@ static int parse_options(char *options, struct super_block *sb,
 		}
 	}
 
-	return ext4_validate_options(sb);
+	ret = ext4_validate_options(&fc);
+	if (ret < 0)
+		return 0;
+
+	return 1;
 }
 
-static int ext4_validate_options(struct super_block *sb)
+static int ext4_validate_options(struct fs_context *fc)
 {
-	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_sb_info *sbi = fc->s_fs_info;
+	struct super_block *sb = sbi->s_sb;
 #ifdef CONFIG_QUOTA
 	char *usr_qf_name, *grp_qf_name;
 	/*
@@ -2646,9 +2657,9 @@ static int ext4_validate_options(struct super_block *sb)
 	 * to support legacy quotas in quota files.
 	 */
 	if (test_opt(sb, PRJQUOTA) && !ext4_has_feature_project(sb)) {
-		ext4_msg(sb, KERN_ERR, "Project quota feature not enabled. "
+		ext4_msg(NULL, KERN_ERR, "Project quota feature not enabled. "
 			 "Cannot enable project quota enforcement.");
-		return 0;
+		return -EINVAL;
 	}
 	usr_qf_name = get_qf_name(sb, sbi, USRQUOTA);
 	grp_qf_name = get_qf_name(sb, sbi, GRPQUOTA);
@@ -2660,15 +2671,15 @@ static int ext4_validate_options(struct super_block *sb)
 			clear_opt(sb, GRPQUOTA);
 
 		if (test_opt(sb, GRPQUOTA) || test_opt(sb, USRQUOTA)) {
-			ext4_msg(sb, KERN_ERR, "old and new quota "
+			ext4_msg(NULL, KERN_ERR, "old and new quota "
 					"format mixing");
-			return 0;
+			return -EINVAL;
 		}
 
 		if (!sbi->s_jquota_fmt) {
-			ext4_msg(sb, KERN_ERR, "journaled quota format "
+			ext4_msg(NULL, KERN_ERR, "journaled quota format "
 					"not specified");
-			return 0;
+			return -EINVAL;
 		}
 	}
 #endif
@@ -2676,11 +2687,12 @@ static int ext4_validate_options(struct super_block *sb)
 		int blocksize =
 			BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
 		if (blocksize < PAGE_SIZE)
-			ext4_msg(sb, KERN_WARNING, "Warning: mounting with an "
-				 "experimental mount option 'dioread_nolock' "
-				 "for blocksize < PAGE_SIZE");
+			ext4_msg(NULL, KERN_WARNING,
+				 "Warning: mounting with an experimental "
+				 "option 'dioread_nolock' for "
+				 "blocksize < PAGE_SIZE");
 	}
-	return 1;
+	return 0;
 }
 
 static inline void ext4_show_quota_options(struct seq_file *seq,
-- 
2.31.1

