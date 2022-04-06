Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B796D4F5D39
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 14:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiDFMQF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 08:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiDFMOj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:14:39 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087881EA5F9;
        Wed,  6 Apr 2022 00:56:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0V9L1BOu_1649231803;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V9L1BOu_1649231803)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 06 Apr 2022 15:56:44 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com
Subject: [PATCH v8 20/20] erofs: add 'fsid' mount option
Date:   Wed,  6 Apr 2022 15:56:12 +0800
Message-Id: <20220406075612.60298-21-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220406075612.60298-1-jefflexu@linux.alibaba.com>
References: <20220406075612.60298-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce 'fsid' mount option to enable on-demand read sementics, in
which case, erofs will be mounted from data blobs. Users could specify
the name of primary data blob by this mount option.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/super.c | 48 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index a5e4de60a0d8..292b4a70ce19 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -398,6 +398,7 @@ enum {
 	Opt_dax,
 	Opt_dax_enum,
 	Opt_device,
+	Opt_fsid,
 	Opt_err
 };
 
@@ -422,6 +423,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
 	fsparam_flag("dax",             Opt_dax),
 	fsparam_enum("dax",		Opt_dax_enum, erofs_dax_param_enums),
 	fsparam_string("device",	Opt_device),
+	fsparam_string("fsid",		Opt_fsid),
 	{}
 };
 
@@ -517,6 +519,16 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		}
 		++ctx->devs->extra_devices;
 		break;
+	case Opt_fsid:
+#ifdef CONFIG_EROFS_FS_ONDEMAND
+		kfree(ctx->opt.fsid);
+		ctx->opt.fsid = kstrdup(param->string, GFP_KERNEL);
+		if (!ctx->opt.fsid)
+			return -ENOMEM;
+#else
+		errorfc(fc, "fsid option not supported");
+#endif
+		break;
 	default:
 		return -ENOPARAM;
 	}
@@ -597,9 +609,14 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	sb->s_op = &erofs_sops;
 
-	if (!sb_set_blocksize(sb, EROFS_BLKSIZ)) {
-		erofs_err(sb, "failed to set erofs blksize");
-		return -EINVAL;
+	if (erofs_is_fscache_mode(sb)) {
+		sb->s_blocksize = EROFS_BLKSIZ;
+		sb->s_blocksize_bits = LOG_BLOCK_SIZE;
+	} else {
+		if (!sb_set_blocksize(sb, EROFS_BLKSIZ)) {
+			erofs_err(sb, "failed to set erofs blksize");
+			return -EINVAL;
+		}
 	}
 
 	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
@@ -608,7 +625,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	sb->s_fs_info = sbi;
 	sbi->opt = ctx->opt;
-	sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->dax_part_off);
+	ctx->opt.fsid = NULL;
 	sbi->devs = ctx->devs;
 	ctx->devs = NULL;
 
@@ -625,6 +642,8 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		err = super_setup_bdi(sb);
 		if (err)
 			return err;
+	} else {
+		sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->dax_part_off);
 	}
 
 	err = erofs_read_superblock(sb);
@@ -684,6 +703,11 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 static int erofs_fc_get_tree(struct fs_context *fc)
 {
+	struct erofs_fs_context *ctx = fc->fs_private;
+
+	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && ctx->opt.fsid)
+		return get_tree_nodev(fc, erofs_fc_fill_super);
+
 	return get_tree_bdev(fc, erofs_fc_fill_super);
 }
 
@@ -733,6 +757,7 @@ static void erofs_fc_free(struct fs_context *fc)
 	struct erofs_fs_context *ctx = fc->fs_private;
 
 	erofs_free_dev_context(ctx->devs);
+	kfree(ctx->opt.fsid);
 	kfree(ctx);
 }
 
@@ -773,7 +798,10 @@ static void erofs_kill_sb(struct super_block *sb)
 
 	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
 
-	kill_block_super(sb);
+	if (erofs_is_fscache_mode(sb))
+		generic_shutdown_super(sb);
+	else
+		kill_block_super(sb);
 
 	sbi = EROFS_SB(sb);
 	if (!sbi)
@@ -783,6 +811,7 @@ static void erofs_kill_sb(struct super_block *sb)
 	fs_put_dax(sbi->dax_dev);
 	erofs_fscache_unregister_cookie(&sbi->s_fscache);
 	erofs_fscache_unregister_fs(sb);
+	kfree(sbi->opt.fsid);
 	kfree(sbi);
 	sb->s_fs_info = NULL;
 }
@@ -884,7 +913,10 @@ static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct super_block *sb = dentry->d_sb;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
-	u64 id = huge_encode_dev(sb->s_bdev->bd_dev);
+	u64 id = 0;
+
+	if (!erofs_is_fscache_mode(sb))
+		id = huge_encode_dev(sb->s_bdev->bd_dev);
 
 	buf->f_type = sb->s_magic;
 	buf->f_bsize = EROFS_BLKSIZ;
@@ -929,6 +961,10 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, ",dax=always");
 	if (test_opt(opt, DAX_NEVER))
 		seq_puts(seq, ",dax=never");
+#ifdef CONFIG_EROFS_FS_ONDEMAND
+	if (opt->fsid)
+		seq_printf(seq, ",fsid=%s", opt->fsid);
+#endif
 	return 0;
 }
 
-- 
2.27.0

