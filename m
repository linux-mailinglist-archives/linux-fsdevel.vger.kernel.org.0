Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C134926C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 14:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242919AbiARNNP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 08:13:15 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:62358 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242879AbiARNMw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:12:52 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V2C2axr_1642511556;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V2C2axr_1642511556)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 18 Jan 2022 21:12:37 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/20] erofs: register cookie context for data blobs
Date:   Tue, 18 Jan 2022 21:12:13 +0800
Message-Id: <20220118131216.85338-18-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220118131216.85338-1-jefflexu@linux.alibaba.com>
References: <20220118131216.85338-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Similar to the multi device mode, erofs could be mounted from multiple
blob files (one bootstrap blob file and optional multiple data blob
files). In this case, each device slot contains the path of
corresponding data blob file.

This patch registers corresponding cookie context for each data blob
file.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/internal.h |  1 +
 fs/erofs/super.c    | 27 +++++++++++++++++++--------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 548f928b0ded..5d514c7b73cc 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -53,6 +53,7 @@ struct erofs_device_info {
 	struct block_device *bdev;
 	struct dax_device *dax_dev;
 	u64 dax_part_off;
+	struct erofs_fscache_context *ctx;
 
 	u32 blocks;
 	u32 mapped_blkaddr;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 8c5783c6f71f..f058a04a00c7 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -250,6 +250,7 @@ static int erofs_init_devices(struct super_block *sb,
 	down_read(&sbi->devs->rwsem);
 	idr_for_each_entry(&sbi->devs->tree, dif, id) {
 		struct block_device *bdev;
+		struct erofs_fscache_context *ctx;
 
 		ptr = erofs_read_metabuf(&buf, sb, erofs_blknr(pos),
 					 EROFS_KMAP);
@@ -259,15 +260,24 @@ static int erofs_init_devices(struct super_block *sb,
 		}
 		dis = ptr + erofs_blkoff(pos);
 
-		bdev = blkdev_get_by_path(dif->path,
-					  FMODE_READ | FMODE_EXCL,
-					  sb->s_type);
-		if (IS_ERR(bdev)) {
-			err = PTR_ERR(bdev);
-			break;
+		if (erofs_bdev_mode(sb)) {
+			bdev = blkdev_get_by_path(dif->path,
+						  FMODE_READ | FMODE_EXCL,
+						  sb->s_type);
+			if (IS_ERR(bdev)) {
+				err = PTR_ERR(bdev);
+				break;
+			}
+			dif->bdev = bdev;
+			dif->dax_dev = fs_dax_get_by_bdev(bdev, &dif->dax_part_off);
+		} else {
+			ctx = erofs_fscache_get_ctx(sb, dif->path, false);
+			if (IS_ERR(ctx)) {
+				err = PTR_ERR(ctx);
+				break;
+			}
+			dif->ctx = ctx;
 		}
-		dif->bdev = bdev;
-		dif->dax_dev = fs_dax_get_by_bdev(bdev, &dif->dax_part_off);
 		dif->blocks = le32_to_cpu(dis->blocks);
 		dif->mapped_blkaddr = le32_to_cpu(dis->mapped_blkaddr);
 		sbi->total_blocks += dif->blocks;
@@ -694,6 +704,7 @@ static int erofs_release_device_info(int id, void *ptr, void *data)
 {
 	struct erofs_device_info *dif = ptr;
 
+	erofs_fscache_put_ctx(dif->ctx);
 	fs_put_dax(dif->dax_dev);
 	if (dif->bdev)
 		blkdev_put(dif->bdev, FMODE_READ | FMODE_EXCL);
-- 
2.27.0

