Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F2E4CFEE4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 13:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238718AbiCGMf0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 07:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242458AbiCGMfE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:35:04 -0500
Received: from out199-16.us.a.mail.aliyun.com (out199-16.us.a.mail.aliyun.com [47.90.199.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B39845064;
        Mon,  7 Mar 2022 04:33:39 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V6WEioi_1646656413;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V6WEioi_1646656413)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Mar 2022 20:33:34 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 19/21] erofs: implement fscache-based data read for data blobs
Date:   Mon,  7 Mar 2022 20:33:03 +0800
Message-Id: <20220307123305.79520-20-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220307123305.79520-1-jefflexu@linux.alibaba.com>
References: <20220307123305.79520-1-jefflexu@linux.alibaba.com>
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

This patch implements the data plane of reading data from data blob file
over fscache.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/data.c     |  3 +++
 fs/erofs/fscache.c  | 16 +++++++++++++---
 fs/erofs/internal.h |  1 +
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 1bff99576883..c5ccf55c050c 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -200,6 +200,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 	map->m_bdev = sb->s_bdev;
 	map->m_daxdev = EROFS_SB(sb)->dax_dev;
 	map->m_dax_part_off = EROFS_SB(sb)->dax_part_off;
+	map->m_ctx = EROFS_SB(sb)->bootstrap;
 
 	if (map->m_deviceid) {
 		down_read(&devs->rwsem);
@@ -211,6 +212,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 		map->m_bdev = dif->bdev;
 		map->m_daxdev = dif->dax_dev;
 		map->m_dax_part_off = dif->dax_part_off;
+		map->m_ctx = dif->ctx;
 		up_read(&devs->rwsem);
 	} else if (devs->extra_devices) {
 		down_read(&devs->rwsem);
@@ -228,6 +230,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 				map->m_bdev = dif->bdev;
 				map->m_daxdev = dif->dax_dev;
 				map->m_dax_part_off = dif->dax_part_off;
+				map->m_ctx = dif->ctx;
 				break;
 			}
 		}
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 4da148cc4484..89c533ad965e 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -70,11 +70,21 @@ static inline int erofs_fscache_get_map(struct erofs_fscache_map *fsmap,
 					struct erofs_map_blocks *map,
 					struct super_block *sb)
 {
-	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct erofs_map_dev mdev;
+	int ret;
+
+	mdev = (struct erofs_map_dev) {
+		.m_deviceid = map->m_deviceid,
+		.m_pa = map->m_pa,
+	};
+
+	ret = erofs_map_dev(sb, &mdev);
+	if (ret)
+		return ret;
 
-	fsmap->m_ctx  = sbi->bootstrap;
+	fsmap->m_ctx  = mdev.m_ctx;
+	fsmap->m_pa   = mdev.m_pa;
 	fsmap->m_la   = map->m_la;
-	fsmap->m_pa   = map->m_pa;
 	fsmap->m_llen = map->m_llen;
 
 	return 0;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 5d514c7b73cc..6ccf14952b2d 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -486,6 +486,7 @@ struct erofs_map_dev {
 	struct block_device *m_bdev;
 	struct dax_device *m_daxdev;
 	u64 m_dax_part_off;
+	struct erofs_fscache_context *m_ctx;
 
 	erofs_off_t m_pa;
 	unsigned int m_deviceid;
-- 
2.27.0

