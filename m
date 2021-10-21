Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43BC243609D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 13:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhJULry (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 07:47:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:20049 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230444AbhJULrn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 07:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634816727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xfGfU7xcimvW3EZPBWmN/J9XdzmnH7mdn9EuoIpK0Go=;
        b=X370J1SGErotElfpyQx92t4SlWFkTaYfmZf+1k1421SloA1LDpGZCK8zX1eJbuJe3EMDDe
        hMV4zmgpJtKaBcQdWjhSxsYCNFjG5ZeDPElHzlh8fksxTAegFwoCn9ZEcZNNm9dEhrn69a
        /+hX8jDtTYr44mwmRK6MWlkQXQkShlA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-0iAbMkdZNm6HSH18pWGrqg-1; Thu, 21 Oct 2021 07:45:25 -0400
X-MC-Unique: 0iAbMkdZNm6HSH18pWGrqg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A61B100CCC0;
        Thu, 21 Oct 2021 11:45:24 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F1FC69217;
        Thu, 21 Oct 2021 11:45:23 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 09/13] ext4: Completely separate options parsing and sb setup
Date:   Thu, 21 Oct 2021 13:45:04 +0200
Message-Id: <20211021114508.21407-10-lczerner@redhat.com>
In-Reply-To: <20211021114508.21407-1-lczerner@redhat.com>
References: <20211021114508.21407-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The new mount api separates option parsing and super block setup into
two distinc steps and so we need to separate the options parsing out of
the ext4_fill_super() and ext4_remount().

In order to achieve this we have to create new ext4_fill_super() and
ext4_remount() functions which will serve its purpose only until we
actually do convert to the new api (as such they are only temporary for
this patch series) and move the option parsing out of the old function
which will now be renamed to __ext4_full_super() and __ext4_remount().

There is a small complication in the fact that while the mount option
parsing is going to happen before we get to __ext4_fill_super(), the
mount options stored in the super block itself needs to be applied
first, before the user specified mount options.

So with this patch we're going through the following sequence:

- parse user provided options (including sb block)
- initialize sbi and store s_sb_block if provided
- in __ext4_fill_super()
	- read the super block
	- parse and apply options specified in s_mount_opts
	- check and apply user provided options stored in ctx
	- continue with the regular ext4_fill_super operation

It's not exactly the most elegant solution, but if we still want to
support s_mount_opts we have to do it in this order.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/super.c | 399 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 264 insertions(+), 135 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 97addca438ad..fd48353e8259 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1952,29 +1952,6 @@ static const match_table_t tokens = {
 	{Opt_err, NULL},
 };
 
-static ext4_fsblk_t get_sb_block(void **data)
-{
-	ext4_fsblk_t	sb_block;
-	char		*options = (char *) *data;
-
-	if (!options || strncmp(options, "sb=", 3) != 0)
-		return 1;	/* Default location */
-
-	options += 3;
-	/* TODO: use simple_strtoll with >32bit ext4 */
-	sb_block = simple_strtoul(options, &options, 0);
-	if (*options && *options != ',') {
-		printk(KERN_ERR "EXT4-fs: Invalid sb specification: %s\n",
-		       (char *) *data);
-		return 1;
-	}
-	if (*options == ',')
-		options++;
-	*data = (void *) options;
-
-	return sb_block;
-}
-
 #define DEFAULT_JOURNAL_IOPRIO (IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, 3))
 #define DEFAULT_MB_OPTIMIZE_SCAN	(-1)
 
@@ -2177,6 +2154,7 @@ static int ext4_set_test_dummy_encryption(struct super_block *sb, char *arg)
 #define EXT4_SPEC_s_resgid			(1 << 15)
 #define EXT4_SPEC_s_commit_interval		(1 << 16)
 #define EXT4_SPEC_s_fc_debug_max_replay		(1 << 17)
+#define EXT4_SPEC_s_sb_block			(1 << 18)
 
 struct ext4_fs_context {
 	char		*s_qf_names[EXT4_MAXQUOTAS];
@@ -2209,6 +2187,7 @@ struct ext4_fs_context {
 	u32		s_min_batch_time;
 	kuid_t		s_resuid;
 	kgid_t		s_resgid;
+	ext4_fsblk_t	s_sb_block;
 };
 
 #ifdef CONFIG_QUOTA
@@ -2323,7 +2302,14 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		ext4_msg(NULL, KERN_WARNING, deprecated_msg, param->key, "3.5");
 		break;
 	case Opt_sb:
-		return 1;	/* handled by get_sb_block() */
+		if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
+			ext4_msg(NULL, KERN_WARNING,
+				 "Ignoring %s option on remount", param->key);
+		} else {
+			ctx->s_sb_block = result.uint_32;
+			ctx->spec |= EXT4_SPEC_s_sb_block;
+		}
+		return 1;
 	case Opt_removed:
 		ext4_msg(NULL, KERN_WARNING, "Ignoring removed %s option",
 			 param->key);
@@ -2592,24 +2578,14 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 	return 1;
 }
 
-static int parse_options(char *options, struct super_block *sb,
-			 struct ext4_fs_context *ctx,
-			 int is_remount)
+static int parse_options(struct fs_context *fc, char *options)
 {
 	struct fs_parameter param;
-	struct fs_context fc;
 	int ret;
 	char *key;
 
 	if (!options)
-		return 1;
-
-	memset(&fc, 0, sizeof(fc));
-	fc.fs_private = ctx;
-	fc.s_fs_info = EXT4_SB(sb);
-
-	if (is_remount)
-		fc.purpose = FS_CONTEXT_FOR_RECONFIGURE;
+		return 0;
 
 	while ((key = strsep(&options, ",")) != NULL) {
 		if (*key) {
@@ -2628,34 +2604,83 @@ static int parse_options(char *options, struct super_block *sb,
 				param.string = kmemdup_nul(value, v_len,
 							   GFP_KERNEL);
 				if (!param.string)
-					return 0;
+					return -ENOMEM;
 				param.type = fs_value_is_string;
 			}
 
 			param.key = key;
 			param.size = v_len;
 
-			ret = handle_mount_opt(&fc, &param);
+			ret = handle_mount_opt(fc, &param);
 			if (param.string)
 				kfree(param.string);
 			if (ret < 0)
-				return 0;
+				return ret;
 		}
 	}
 
-	ret = ext4_validate_options(&fc);
+	ret = ext4_validate_options(fc);
 	if (ret < 0)
-		return 0;
+		return ret;
 
-	ret = ext4_check_opt_consistency(&fc, sb);
-	if (ret < 0)
+	return 0;
+}
+
+static int parse_apply_sb_mount_options(struct super_block *sb,
+					struct ext4_fs_context *m_ctx)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	char *s_mount_opts = NULL;
+	struct ext4_fs_context *s_ctx = NULL;
+	struct fs_context *fc = NULL;
+	int ret = -ENOMEM;
+
+	if (!sbi->s_es->s_mount_opts[0])
 		return 0;
 
-	ret = ext4_apply_options(&fc, sb);
+	s_mount_opts = kstrndup(sbi->s_es->s_mount_opts,
+				sizeof(sbi->s_es->s_mount_opts),
+				GFP_KERNEL);
+	if (!s_mount_opts)
+		return ret;
+
+	fc = kzalloc(sizeof(struct fs_context), GFP_KERNEL);
+	if (!fc)
+		goto out_free;
+
+	s_ctx = kzalloc(sizeof(struct ext4_fs_context), GFP_KERNEL);
+	if (!s_ctx)
+		goto out_free;
+
+	fc->fs_private = s_ctx;
+	fc->s_fs_info = sbi;
+
+	ret = parse_options(fc, s_mount_opts);
 	if (ret < 0)
-		return 0;
+		goto parse_failed;
 
-	return 1;
+	ret = ext4_check_opt_consistency(fc, sb);
+	if (ret < 0) {
+parse_failed:
+		ext4_msg(sb, KERN_WARNING,
+			 "failed to parse options in superblock: %s",
+			 s_mount_opts);
+		ret = 0;
+		goto out_free;
+	}
+
+	if (s_ctx->spec & EXT4_SPEC_JOURNAL_DEV)
+		m_ctx->journal_devnum = s_ctx->journal_devnum;
+	if (s_ctx->spec & EXT4_SPEC_JOURNAL_IOPRIO)
+		m_ctx->journal_ioprio = s_ctx->journal_ioprio;
+
+	ret = ext4_apply_options(fc, sb);
+
+out_free:
+	kfree(s_ctx);
+	kfree(fc);
+	kfree(s_mount_opts);
+	return ret;
 }
 
 static void ext4_apply_quota_options(struct fs_context *fc,
@@ -4350,21 +4375,53 @@ static void ext4_setup_csum_trigger(struct super_block *sb,
 	sbi->s_journal_triggers[type].tr_triggers.t_frozen = trigger;
 }
 
-static int ext4_fill_super(struct super_block *sb, void *data, int silent)
+static void ext4_free_sbi(struct ext4_sb_info *sbi)
+{
+	if (!sbi)
+		return;
+
+	kfree(sbi->s_blockgroup_lock);
+	fs_put_dax(sbi->s_daxdev);
+	kfree(sbi);
+}
+
+static struct ext4_sb_info *ext4_alloc_sbi(struct super_block *sb)
+{
+	struct ext4_sb_info *sbi;
+
+	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
+	if (!sbi)
+		return NULL;
+
+	sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev);
+
+	sbi->s_blockgroup_lock =
+		kzalloc(sizeof(struct blockgroup_lock), GFP_KERNEL);
+
+	if (!sbi->s_blockgroup_lock)
+		goto err_out;
+
+	sb->s_fs_info = sbi;
+	sbi->s_sb = sb;
+	return sbi;
+err_out:
+	fs_put_dax(sbi->s_daxdev);
+	kfree(sbi);
+	return NULL;
+}
+
+static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb,
+			     int silent)
 {
-	struct dax_device *dax_dev = fs_dax_get_by_bdev(sb->s_bdev);
-	char *orig_data = kstrdup(data, GFP_KERNEL);
 	struct buffer_head *bh, **group_desc;
 	struct ext4_super_block *es = NULL;
-	struct ext4_sb_info *sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct flex_groups **flex_groups;
 	ext4_fsblk_t block;
-	ext4_fsblk_t sb_block = get_sb_block(&data);
 	ext4_fsblk_t logical_sb_block;
 	unsigned long offset = 0;
 	unsigned long def_mount_opts;
 	struct inode *root;
-	const char *descr;
 	int ret = -ENOMEM;
 	int blocksize, clustersize;
 	unsigned int db_count;
@@ -4373,32 +4430,16 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	__u64 blocks_count;
 	int err = 0;
 	ext4_group_t first_not_zeroed;
-	struct ext4_fs_context parsed_opts = {0};
+	struct ext4_fs_context *ctx = fc->fs_private;
 
 	/* Set defaults for the variables that will be set during parsing */
-	parsed_opts.journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
-	parsed_opts.journal_devnum = 0;
-	parsed_opts.mb_optimize_scan = DEFAULT_MB_OPTIMIZE_SCAN;
-
-	if ((data && !orig_data) || !sbi)
-		goto out_free_base;
+	ctx->journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
+	ctx->mb_optimize_scan = DEFAULT_MB_OPTIMIZE_SCAN;
 
-	sbi->s_daxdev = dax_dev;
-	sbi->s_blockgroup_lock =
-		kzalloc(sizeof(struct blockgroup_lock), GFP_KERNEL);
-	if (!sbi->s_blockgroup_lock)
-		goto out_free_base;
-
-	sb->s_fs_info = sbi;
-	sbi->s_sb = sb;
 	sbi->s_inode_readahead_blks = EXT4_DEF_INODE_READAHEAD_BLKS;
-	sbi->s_sb_block = sb_block;
 	sbi->s_sectors_written_start =
 		part_stat_read(sb->s_bdev, sectors[STAT_WRITE]);
 
-	/* Cleanup superblock name */
-	strreplace(sb->s_id, '/', '!');
-
 	/* -EINVAL is default */
 	ret = -EINVAL;
 	blocksize = sb_min_blocksize(sb, EXT4_MIN_BLOCK_SIZE);
@@ -4412,10 +4453,10 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	 * block sizes.  We need to calculate the offset from buffer start.
 	 */
 	if (blocksize != EXT4_MIN_BLOCK_SIZE) {
-		logical_sb_block = sb_block * EXT4_MIN_BLOCK_SIZE;
+		logical_sb_block = sbi->s_sb_block * EXT4_MIN_BLOCK_SIZE;
 		offset = do_div(logical_sb_block, blocksize);
 	} else {
-		logical_sb_block = sb_block;
+		logical_sb_block = sbi->s_sb_block;
 	}
 
 	bh = ext4_sb_bread_unmovable(sb, logical_sb_block);
@@ -4620,21 +4661,18 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		}
 	}
 
-	if (sbi->s_es->s_mount_opts[0]) {
-		char *s_mount_opts = kstrndup(sbi->s_es->s_mount_opts,
-					      sizeof(sbi->s_es->s_mount_opts),
-					      GFP_KERNEL);
-		if (!s_mount_opts)
-			goto failed_mount;
-		if (!parse_options(s_mount_opts, sb, &parsed_opts, 0)) {
-			ext4_msg(sb, KERN_WARNING,
-				 "failed to parse options in superblock: %s",
-				 s_mount_opts);
-		}
-		kfree(s_mount_opts);
-	}
+	err = parse_apply_sb_mount_options(sb, ctx);
+	if (err < 0)
+		goto failed_mount;
+
 	sbi->s_def_mount_opt = sbi->s_mount_opt;
-	if (!parse_options((char *) data, sb, &parsed_opts, 0))
+
+	err = ext4_check_opt_consistency(fc, sb);
+	if (err < 0)
+		goto failed_mount;
+
+	err = ext4_apply_options(fc, sb);
+	if (err < 0)
 		goto failed_mount;
 
 #ifdef CONFIG_UNICODE
@@ -4773,7 +4811,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		goto failed_mount;
 	}
 
-	if (dax_supported(dax_dev, sb->s_bdev, blocksize, 0,
+	if (dax_supported(sbi->s_daxdev, sb->s_bdev, blocksize, 0,
 			bdev_nr_sectors(sb->s_bdev)))
 		set_bit(EXT4_FLAGS_BDEV_IS_DAX, &sbi->s_ext4_flags);
 
@@ -4811,7 +4849,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 			goto failed_mount;
 		}
 
-		logical_sb_block = sb_block * EXT4_MIN_BLOCK_SIZE;
+		logical_sb_block = sbi->s_sb_block * EXT4_MIN_BLOCK_SIZE;
 		offset = do_div(logical_sb_block, blocksize);
 		bh = ext4_sb_bread_unmovable(sb, logical_sb_block);
 		if (IS_ERR(bh)) {
@@ -5127,7 +5165,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	 * root first: it may be modified in the journal!
 	 */
 	if (!test_opt(sb, NOLOAD) && ext4_has_feature_journal(sb)) {
-		err = ext4_load_journal(sb, es, parsed_opts.journal_devnum);
+		err = ext4_load_journal(sb, es, ctx->journal_devnum);
 		if (err)
 			goto failed_mount3a;
 	} else if (test_opt(sb, NOLOAD) && !sb_rdonly(sb) &&
@@ -5227,7 +5265,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		goto failed_mount_wq;
 	}
 
-	set_task_ioprio(sbi->s_journal->j_task, parsed_opts.journal_ioprio);
+	set_task_ioprio(sbi->s_journal->j_task, ctx->journal_ioprio);
 
 	sbi->s_journal->j_submit_inode_data_buffers =
 		ext4_journal_submit_inode_data_buffers;
@@ -5339,9 +5377,9 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	 * turned off by passing "mb_optimize_scan=0". This can also be
 	 * turned on forcefully by passing "mb_optimize_scan=1".
 	 */
-	if (parsed_opts.mb_optimize_scan == 1)
+	if (ctx->mb_optimize_scan == 1)
 		set_opt2(sb, MB_OPTIMIZE_SCAN);
-	else if (parsed_opts.mb_optimize_scan == 0)
+	else if (ctx->mb_optimize_scan == 0)
 		clear_opt2(sb, MB_OPTIMIZE_SCAN);
 	else if (sbi->s_groups_count >= MB_DEFAULT_LINEAR_SCAN_THRESHOLD)
 		set_opt2(sb, MB_OPTIMIZE_SCAN);
@@ -5443,15 +5481,6 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		if (err)
 			goto failed_mount9;
 	}
-	if (EXT4_SB(sb)->s_journal) {
-		if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA)
-			descr = " journalled data mode";
-		else if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_ORDERED_DATA)
-			descr = " ordered data mode";
-		else
-			descr = " writeback data mode";
-	} else
-		descr = "out journal";
 
 	if (test_opt(sb, DISCARD)) {
 		struct request_queue *q = bdev_get_queue(sb->s_bdev);
@@ -5461,14 +5490,6 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 				 "the device does not support discard");
 	}
 
-	if (___ratelimit(&ext4_mount_msg_ratelimit, "EXT4-fs mount"))
-		ext4_msg(sb, KERN_INFO, "mounted filesystem with%s. "
-			 "Opts: %.*s%s%s. Quota mode: %s.", descr,
-			 (int) sizeof(sbi->s_es->s_mount_opts),
-			 sbi->s_es->s_mount_opts,
-			 *sbi->s_es->s_mount_opts ? "; " : "", orig_data,
-			 ext4_quota_mode(sb));
-
 	if (es->s_error_count)
 		mod_timer(&sbi->s_err_report, jiffies + 300*HZ); /* 5 minutes */
 
@@ -5479,7 +5500,6 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	atomic_set(&sbi->s_warning_count, 0);
 	atomic_set(&sbi->s_msg_count, 0);
 
-	kfree(orig_data);
 	return 0;
 
 cantfind_ext4:
@@ -5565,14 +5585,92 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	ext4_blkdev_remove(sbi);
 out_fail:
 	sb->s_fs_info = NULL;
-	kfree(sbi->s_blockgroup_lock);
-out_free_base:
-	kfree(sbi);
-	kfree(orig_data);
-	fs_put_dax(dax_dev);
 	return err ? err : ret;
 }
 
+static void cleanup_ctx(struct ext4_fs_context *ctx)
+{
+	int i;
+
+	if (!ctx)
+		return;
+
+	for (i = 0; i < EXT4_MAXQUOTAS; i++) {
+		kfree(ctx->s_qf_names[i]);
+	}
+
+	kfree(ctx->test_dummy_enc_arg);
+}
+
+static int ext4_fill_super(struct super_block *sb, void *data, int silent)
+{
+	struct ext4_fs_context ctx;
+	struct ext4_sb_info *sbi;
+	struct fs_context fc;
+	const char *descr;
+	char *orig_data;
+	int ret = -ENOMEM;
+
+	orig_data = kstrdup(data, GFP_KERNEL);
+	if (data && !orig_data)
+		return -ENOMEM;
+
+	/* Cleanup superblock name */
+	strreplace(sb->s_id, '/', '!');
+
+	memset(&fc, 0, sizeof(fc));
+	memset(&ctx, 0, sizeof(ctx));
+	fc.fs_private = &ctx;
+
+	ret = parse_options(&fc, (char *) data);
+	if (ret < 0)
+		goto free_data;
+
+	sbi = ext4_alloc_sbi(sb);
+	if (!sbi) {
+		ret = -ENOMEM;
+		goto free_data;
+	}
+
+	fc.s_fs_info = sbi;
+
+	sbi->s_sb_block = 1;	/* Default super block location */
+	if (ctx.spec & EXT4_SPEC_s_sb_block)
+		sbi->s_sb_block = ctx.s_sb_block;
+
+	ret = __ext4_fill_super(&fc, sb, silent);
+	if (ret < 0)
+		goto free_sbi;
+
+	if (EXT4_SB(sb)->s_journal) {
+		if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA)
+			descr = " journalled data mode";
+		else if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_ORDERED_DATA)
+			descr = " ordered data mode";
+		else
+			descr = " writeback data mode";
+	} else
+		descr = "out journal";
+
+	if (___ratelimit(&ext4_mount_msg_ratelimit, "EXT4-fs mount"))
+		ext4_msg(sb, KERN_INFO, "mounted filesystem with%s. "
+			 "Opts: %.*s%s%s. Quota mode: %s.", descr,
+			 (int) sizeof(sbi->s_es->s_mount_opts),
+			 sbi->s_es->s_mount_opts,
+			 *sbi->s_es->s_mount_opts ? "; " : "", orig_data,
+			 ext4_quota_mode(sb));
+
+	kfree(orig_data);
+	cleanup_ctx(&ctx);
+	return 0;
+free_sbi:
+	ext4_free_sbi(sbi);
+free_data:
+	kfree(orig_data);
+	cleanup_ctx(&ctx);
+	return ret;
+}
+
 /*
  * Setup any per-fs journal parameters now.  We'll do this both on
  * initial mount, once the journal has been initialised but before we've
@@ -6201,8 +6299,10 @@ struct ext4_mount_options {
 #endif
 };
 
-static int ext4_remount(struct super_block *sb, int *flags, char *data)
+static int __ext4_remount(struct fs_context *fc, struct super_block *sb,
+			  int *flags)
 {
+	struct ext4_fs_context *ctx = fc->fs_private;
 	struct ext4_super_block *es;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	unsigned long old_sb_flags, vfs_flags;
@@ -6214,14 +6314,8 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	int i, j;
 	char *to_free[EXT4_MAXQUOTAS];
 #endif
-	char *orig_data = kstrdup(data, GFP_KERNEL);
-	struct ext4_fs_context parsed_opts;
-
-	parsed_opts.journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
-	parsed_opts.journal_devnum = 0;
 
-	if (data && !orig_data)
-		return -ENOMEM;
+	ctx->journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
 
 	/* Store the original options */
 	old_sb_flags = sb->s_flags;
@@ -6242,14 +6336,13 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 			if (!old_opts.s_qf_names[i]) {
 				for (j = 0; j < i; j++)
 					kfree(old_opts.s_qf_names[j]);
-				kfree(orig_data);
 				return -ENOMEM;
 			}
 		} else
 			old_opts.s_qf_names[i] = NULL;
 #endif
 	if (sbi->s_journal && sbi->s_journal->j_task->io_context)
-		parsed_opts.journal_ioprio =
+		ctx->journal_ioprio =
 			sbi->s_journal->j_task->io_context->ioprio;
 
 	/*
@@ -6260,10 +6353,7 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	vfs_flags = SB_LAZYTIME | SB_I_VERSION;
 	sb->s_flags = (sb->s_flags & ~vfs_flags) | (*flags & vfs_flags);
 
-	if (!parse_options(data, sb, &parsed_opts, 1)) {
-		err = -EINVAL;
-		goto restore_opts;
-	}
+	ext4_apply_options(fc, sb);
 
 	if ((old_opts.s_mount_opt & EXT4_MOUNT_JOURNAL_CHECKSUM) ^
 	    test_opt(sb, JOURNAL_CHECKSUM)) {
@@ -6310,7 +6400,7 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 
 	if (sbi->s_journal) {
 		ext4_init_journal_params(sb, sbi->s_journal);
-		set_task_ioprio(sbi->s_journal->j_task, parsed_opts.journal_ioprio);
+		set_task_ioprio(sbi->s_journal->j_task, ctx->journal_ioprio);
 	}
 
 	/* Flush outstanding errors before changing fs state */
@@ -6475,9 +6565,6 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	 */
 	*flags = (*flags & ~vfs_flags) | (sb->s_flags & vfs_flags);
 
-	ext4_msg(sb, KERN_INFO, "re-mounted. Opts: %s. Quota mode: %s.",
-		 orig_data, ext4_quota_mode(sb));
-	kfree(orig_data);
 	return 0;
 
 restore_opts:
@@ -6503,10 +6590,52 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 #endif
 	if (!ext4_has_feature_mmp(sb) || sb_rdonly(sb))
 		ext4_stop_mmpd(sbi);
-	kfree(orig_data);
 	return err;
 }
 
+static int ext4_remount(struct super_block *sb, int *flags, char *data)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_fs_context ctx;
+	struct fs_context fc;
+	char *orig_data;
+	int ret;
+
+	orig_data = kstrdup(data, GFP_KERNEL);
+	if (data && !orig_data)
+		return -ENOMEM;
+
+	memset(&fc, 0, sizeof(fc));
+	memset(&ctx, 0, sizeof(ctx));
+
+	fc.fs_private = &ctx;
+	fc.purpose = FS_CONTEXT_FOR_RECONFIGURE;
+	fc.s_fs_info = sbi;
+
+	ret = parse_options(&fc, (char *) data);
+	if (ret < 0)
+		goto err_out;
+
+	ret = ext4_check_opt_consistency(&fc, sb);
+	if (ret < 0)
+		goto err_out;
+
+	ret = __ext4_remount(&fc, sb, flags);
+	if (ret < 0)
+		goto err_out;
+
+	ext4_msg(sb, KERN_INFO, "re-mounted. Opts: %s. Quota mode: %s.",
+		 orig_data, ext4_quota_mode(sb));
+	cleanup_ctx(&ctx);
+	kfree(orig_data);
+	return 0;
+
+err_out:
+	cleanup_ctx(&ctx);
+	kfree(orig_data);
+	return ret;
+}
+
 #ifdef CONFIG_QUOTA
 static int ext4_statfs_project(struct super_block *sb,
 			       kprojid_t projid, struct kstatfs *buf)
-- 
2.31.1

