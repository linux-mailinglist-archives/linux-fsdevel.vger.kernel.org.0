Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24A951F659
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 10:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238088AbiEIIDd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 04:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235012AbiEIHoy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 03:44:54 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DB618E20;
        Mon,  9 May 2022 00:41:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VCfaImD_1652082044;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VCfaImD_1652082044)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 09 May 2022 15:40:45 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        yinxin.x@bytedance.com, zhangjiachen.jaycee@bytedance.com,
        zhujia.zj@bytedance.com
Subject: [PATCH v11 10/22] erofs: add fscache mode check helper
Date:   Mon,  9 May 2022 15:40:16 +0800
Message-Id: <20220509074028.74954-11-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220509074028.74954-1-jefflexu@linux.alibaba.com>
References: <20220509074028.74954-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Until then erofs is exactly blockdev based filesystem.

A new fscache-based mode is going to be introduced for erofs to support
scenarios where on-demand read semantics is needed, e.g. container
image distribution. In this case, erofs could be mounted from data blobs
through fscache.

Add a helper checking which mode erofs works in, and twist the code in
preparation for the upcoming fscache mode.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/internal.h |  5 +++++
 fs/erofs/super.c    | 44 +++++++++++++++++++++++++++++---------------
 2 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index fe9564e5091e..05a97533b1e9 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -161,6 +161,11 @@ struct erofs_sb_info {
 #define set_opt(opt, option)	((opt)->mount_opt |= EROFS_MOUNT_##option)
 #define test_opt(opt, option)	((opt)->mount_opt & EROFS_MOUNT_##option)
 
+static inline bool erofs_is_fscache_mode(struct super_block *sb)
+{
+	return IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && !sb->s_bdev;
+}
+
 enum {
 	EROFS_ZIP_CACHE_DISABLED,
 	EROFS_ZIP_CACHE_READAHEAD,
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 0c4b41130c2f..724d5ff0d78c 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -259,15 +259,19 @@ static int erofs_init_devices(struct super_block *sb,
 		}
 		dis = ptr + erofs_blkoff(pos);
 
-		bdev = blkdev_get_by_path(dif->path,
-					  FMODE_READ | FMODE_EXCL,
-					  sb->s_type);
-		if (IS_ERR(bdev)) {
-			err = PTR_ERR(bdev);
-			break;
+		if (!erofs_is_fscache_mode(sb)) {
+			bdev = blkdev_get_by_path(dif->path,
+						  FMODE_READ | FMODE_EXCL,
+						  sb->s_type);
+			if (IS_ERR(bdev)) {
+				err = PTR_ERR(bdev);
+				break;
+			}
+			dif->bdev = bdev;
+			dif->dax_dev = fs_dax_get_by_bdev(bdev,
+							  &dif->dax_part_off);
 		}
-		dif->bdev = bdev;
-		dif->dax_dev = fs_dax_get_by_bdev(bdev, &dif->dax_part_off);
+
 		dif->blocks = le32_to_cpu(dis->blocks);
 		dif->mapped_blkaddr = le32_to_cpu(dis->mapped_blkaddr);
 		sbi->total_blocks += dif->blocks;
@@ -586,21 +590,28 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	sb->s_magic = EROFS_SUPER_MAGIC;
 
-	if (!sb_set_blocksize(sb, EROFS_BLKSIZ)) {
-		erofs_err(sb, "failed to set erofs blksize");
-		return -EINVAL;
-	}
-
 	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
 	if (!sbi)
 		return -ENOMEM;
 
 	sb->s_fs_info = sbi;
 	sbi->opt = ctx->opt;
-	sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->dax_part_off);
 	sbi->devs = ctx->devs;
 	ctx->devs = NULL;
 
+	if (erofs_is_fscache_mode(sb)) {
+		sb->s_blocksize = EROFS_BLKSIZ;
+		sb->s_blocksize_bits = LOG_BLOCK_SIZE;
+	} else {
+		if (!sb_set_blocksize(sb, EROFS_BLKSIZ)) {
+			erofs_err(sb, "failed to set erofs blksize");
+			return -EINVAL;
+		}
+
+		sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev,
+						  &sbi->dax_part_off);
+	}
+
 	err = erofs_read_superblock(sb);
 	if (err)
 		return err;
@@ -857,7 +868,10 @@ static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
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
-- 
2.27.0

