Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA5C4CFEDE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 13:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242455AbiCGMfX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 07:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbiCGMfI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:35:08 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17444A3FF;
        Mon,  7 Mar 2022 04:33:41 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V6WFbID_1646656416;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V6WFbID_1646656416)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Mar 2022 20:33:37 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 21/21] erofs: add 'uuid' mount option
Date:   Mon,  7 Mar 2022 20:33:05 +0800
Message-Id: <20220307123305.79520-22-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220307123305.79520-1-jefflexu@linux.alibaba.com>
References: <20220307123305.79520-1-jefflexu@linux.alibaba.com>
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

Introduce 'uuid' mount option to enable on-demand read sementics. In
this case, erofs could be mounted from blob files instead of blkdev.
By then users could specify the path of bootstrap blob file containing
the complete erofs image.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/super.c | 44 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 2942029a7049..8bc4b782f9a9 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -400,6 +400,7 @@ enum {
 	Opt_dax,
 	Opt_dax_enum,
 	Opt_device,
+	Opt_uuid,
 	Opt_err
 };
 
@@ -424,6 +425,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
 	fsparam_flag("dax",             Opt_dax),
 	fsparam_enum("dax",		Opt_dax_enum, erofs_dax_param_enums),
 	fsparam_string("device",	Opt_device),
+	fsparam_string("uuid",		Opt_uuid),
 	{}
 };
 
@@ -519,6 +521,12 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		}
 		++ctx->devs->extra_devices;
 		break;
+	case Opt_uuid:
+		kfree(ctx->opt.uuid);
+		ctx->opt.uuid = kstrdup(param->string, GFP_KERNEL);
+		if (!ctx->opt.uuid)
+			return -ENOMEM;
+		break;
 	default:
 		return -ENOPARAM;
 	}
@@ -593,9 +601,14 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	sb->s_magic = EROFS_SUPER_MAGIC;
 
-	if (!sb_set_blocksize(sb, EROFS_BLKSIZ)) {
-		erofs_err(sb, "failed to set erofs blksize");
-		return -EINVAL;
+	if (erofs_bdev_mode(sb)) {
+		if (!sb_set_blocksize(sb, EROFS_BLKSIZ)) {
+			erofs_err(sb, "failed to set erofs blksize");
+			return -EINVAL;
+		}
+	} else {
+		sb->s_blocksize = EROFS_BLKSIZ;
+		sb->s_blocksize_bits = LOG_BLOCK_SIZE;
 	}
 
 	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
@@ -604,11 +617,12 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	sb->s_fs_info = sbi;
 	sbi->opt = ctx->opt;
-	sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->dax_part_off);
 	sbi->devs = ctx->devs;
 	ctx->devs = NULL;
 
-	if (!erofs_bdev_mode(sb)) {
+	if (erofs_bdev_mode(sb)) {
+		sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->dax_part_off);
+	} else {
 		struct erofs_fscache_context *bootstrap;
 
 		bootstrap = erofs_fscache_get_ctx(sb, ctx->opt.uuid, true);
@@ -620,6 +634,8 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		err = super_setup_bdi(sb);
 		if (err)
 			return err;
+
+		sbi->dax_dev = NULL;
 	}
 
 	err = erofs_read_superblock(sb);
@@ -682,6 +698,11 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 static int erofs_fc_get_tree(struct fs_context *fc)
 {
+	struct erofs_fs_context *ctx = fc->fs_private;
+
+	if (ctx->opt.uuid)
+		return get_tree_nodev(fc, erofs_fc_fill_super);
+
 	return get_tree_bdev(fc, erofs_fc_fill_super);
 }
 
@@ -731,6 +752,7 @@ static void erofs_fc_free(struct fs_context *fc)
 	struct erofs_fs_context *ctx = fc->fs_private;
 
 	erofs_free_dev_context(ctx->devs);
+	kfree(ctx->opt.uuid);
 	kfree(ctx);
 }
 
@@ -771,7 +793,10 @@ static void erofs_kill_sb(struct super_block *sb)
 
 	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
 
-	kill_block_super(sb);
+	if (erofs_bdev_mode(sb))
+		kill_block_super(sb);
+	else
+		generic_shutdown_super(sb);
 
 	sbi = EROFS_SB(sb);
 	if (!sbi)
@@ -889,7 +914,12 @@ static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct super_block *sb = dentry->d_sb;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
-	u64 id = huge_encode_dev(sb->s_bdev->bd_dev);
+	u64 id;
+
+	if (erofs_bdev_mode(sb))
+		id = huge_encode_dev(sb->s_bdev->bd_dev);
+	else
+		id = 0; /* TODO */
 
 	buf->f_type = sb->s_magic;
 	buf->f_bsize = EROFS_BLKSIZ;
-- 
2.27.0

