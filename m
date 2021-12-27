Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6723547FCE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Dec 2021 13:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236956AbhL0MzJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Dec 2021 07:55:09 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:53854 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236901AbhL0MzE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Dec 2021 07:55:04 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V.w7GYF_1640609701;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V.w7GYF_1640609701)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 Dec 2021 20:55:01 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 14/23] erofs: register cookie context for data blobs
Date:   Mon, 27 Dec 2021 20:54:35 +0800
Message-Id: <20211227125444.21187-15-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
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
file. Similarly, the cleanup routine shall be contained in both
.kill_sb() and .put_super() callback for the same reason.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/internal.h |  1 +
 fs/erofs/super.c    | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index f3a1aa429a93..f60577a7aade 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -52,6 +52,7 @@ struct erofs_device_info {
 	char *path;
 	struct block_device *bdev;
 	struct dax_device *dax_dev;
+	struct erofs_cookie_ctx *ctx;
 
 	u32 blocks;
 	u32 mapped_blkaddr;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 0e5964d8b24b..ea56122f7a35 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -287,6 +287,7 @@ static int erofs_init_devices(struct super_block *sb,
 	idr_for_each_entry(&sbi->devs->tree, dif, id) {
 		erofs_blk_t blk = erofs_blknr(pos);
 		struct block_device *bdev;
+		struct erofs_cookie_ctx *ctx;
 
 		if (!page || page->index != blk) {
 			if (page) {
@@ -315,7 +316,12 @@ static int erofs_init_devices(struct super_block *sb,
 			dif->bdev = bdev;
 			dif->dax_dev = fs_dax_get_by_bdev(bdev);
 		} else {
-			/* TODO: multi devs in nodev mode */
+			ctx = erofs_fscache_get_ctx(sb, dif->path);
+			if (IS_ERR(ctx)) {
+				err = PTR_ERR(ctx);
+				goto err_out;
+			}
+			dif->ctx = ctx;
 		}
 		dif->blocks = le32_to_cpu(dis->blocks);
 		dif->mapped_blkaddr = le32_to_cpu(dis->mapped_blkaddr);
@@ -755,6 +761,7 @@ static int erofs_release_device_info(int id, void *ptr, void *data)
 {
 	struct erofs_device_info *dif = ptr;
 
+	erofs_fscache_put_ctx(dif->ctx);
 	fs_put_dax(dif->dax_dev);
 	if (dif->bdev)
 		blkdev_put(dif->bdev, FMODE_READ | FMODE_EXCL);
@@ -845,6 +852,9 @@ static void erofs_put_super(struct super_block *sb)
 	iput(sbi->managed_cache);
 	sbi->managed_cache = NULL;
 #endif
+	erofs_free_dev_context(sbi->devs);
+	sbi->devs = NULL;
+
 	erofs_fscache_put_ctx(sbi->bootstrap);
 	sbi->bootstrap = NULL;
 }
-- 
2.27.0

