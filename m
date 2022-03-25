Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33994E7333
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 13:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359044AbiCYMZM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 08:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359054AbiCYMYu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:24:50 -0400
Received: from out199-6.us.a.mail.aliyun.com (out199-6.us.a.mail.aliyun.com [47.90.199.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2126CD64FC;
        Fri, 25 Mar 2022 05:22:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0V89Vk8X_1648210973;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V89Vk8X_1648210973)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Mar 2022 20:22:54 +0800
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
Subject: [PATCH v6 19/22] erofs: register cookie context for data blobs
Date:   Fri, 25 Mar 2022 20:22:20 +0800
Message-Id: <20220325122223.102958-20-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220325122223.102958-1-jefflexu@linux.alibaba.com>
References: <20220325122223.102958-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Similar to the multi device mode, erofs could be mounted from multiple
blob files (one bootstrap blob file and optional multiple data blob
files). In this case, each device slot contains the path of
corresponding data blob file.

Registers corresponding cookie context for each data blob file.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/internal.h |  1 +
 fs/erofs/super.c    | 30 ++++++++++++++++++++++--------
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 6537ededed51..94a118caf580 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -52,6 +52,7 @@ struct erofs_device_info {
 	struct block_device *bdev;
 	struct dax_device *dax_dev;
 	u64 dax_part_off;
+	struct erofs_fscache *blob;
 
 	u32 blocks;
 	u32 mapped_blkaddr;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index de5aeda4aea0..9a6f35e0c22b 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -259,15 +259,28 @@ static int erofs_init_devices(struct super_block *sb,
 		}
 		dis = ptr + erofs_blkoff(pos);
 
-		bdev = blkdev_get_by_path(dif->path,
-					  FMODE_READ | FMODE_EXCL,
-					  sb->s_type);
-		if (IS_ERR(bdev)) {
-			err = PTR_ERR(bdev);
-			break;
+		if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) &&
+		    erofs_is_nodev_mode(sb)) {
+			struct erofs_fscache *blob;
+
+			blob = erofs_fscache_get(sb, dif->path, false);
+			if (IS_ERR(blob)) {
+				err = PTR_ERR(blob);
+				break;
+			}
+			dif->blob = blob;
+		} else {
+			bdev = blkdev_get_by_path(dif->path,
+						  FMODE_READ | FMODE_EXCL,
+						  sb->s_type);
+			if (IS_ERR(bdev)) {
+				err = PTR_ERR(bdev);
+				break;
+			}
+			dif->bdev = bdev;
+			dif->dax_dev = fs_dax_get_by_bdev(bdev, &dif->dax_part_off);
 		}
-		dif->bdev = bdev;
-		dif->dax_dev = fs_dax_get_by_bdev(bdev, &dif->dax_part_off);
+
 		dif->blocks = le32_to_cpu(dis->blocks);
 		dif->mapped_blkaddr = le32_to_cpu(dis->mapped_blkaddr);
 		sbi->total_blocks += dif->blocks;
@@ -694,6 +707,7 @@ static int erofs_release_device_info(int id, void *ptr, void *data)
 {
 	struct erofs_device_info *dif = ptr;
 
+	erofs_fscache_put(dif->blob);
 	fs_put_dax(dif->dax_dev);
 	if (dif->bdev)
 		blkdev_put(dif->bdev, FMODE_READ | FMODE_EXCL);
-- 
2.27.0

