Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECB85A98A1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 15:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbiIANYf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 09:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbiIANYL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:24:11 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CCE1DA4F;
        Thu,  1 Sep 2022 06:24:00 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MJMBf4dwJznTsB;
        Thu,  1 Sep 2022 21:21:30 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 1 Sep
 2022 21:23:57 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <cluster-devel@redhat.com>,
        <ntfs3@lists.linux.dev>, <ocfs2-devel@oss.oracle.com>,
        <reiserfs-devel@vger.kernel.org>, <jack@suse.cz>
CC:     <tytso@mit.edu>, <akpm@linux-foundation.org>, <axboe@kernel.dk>,
        <viro@zeniv.linux.org.uk>, <rpeterso@redhat.com>,
        <agruenba@redhat.com>, <almaz.alexandrovich@paragon-software.com>,
        <mark@fasheh.com>, <dushistov@mail.ru>, <hch@infradead.org>,
        <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH v2 01/14] fs/buffer: remove __breadahead_gfp()
Date:   Thu, 1 Sep 2022 21:34:52 +0800
Message-ID: <20220901133505.2510834-2-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220901133505.2510834-1-yi.zhang@huawei.com>
References: <20220901133505.2510834-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

No one use __breadahead_gfp() and sb_breadahead_unmovable() any more,
remove them.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/buffer.c                 | 11 -----------
 include/linux/buffer_head.h |  8 --------
 2 files changed, 19 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 55e762a58eb6..a0b70b3239f3 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1348,17 +1348,6 @@ void __breadahead(struct block_device *bdev, sector_t block, unsigned size)
 }
 EXPORT_SYMBOL(__breadahead);
 
-void __breadahead_gfp(struct block_device *bdev, sector_t block, unsigned size,
-		      gfp_t gfp)
-{
-	struct buffer_head *bh = __getblk_gfp(bdev, block, size, gfp);
-	if (likely(bh)) {
-		ll_rw_block(REQ_OP_READ | REQ_RAHEAD, 1, &bh);
-		brelse(bh);
-	}
-}
-EXPORT_SYMBOL(__breadahead_gfp);
-
 /**
  *  __bread_gfp() - reads a specified block and returns the bh
  *  @bdev: the block_device to read from
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 089c9ade4325..c3863c417b00 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -214,8 +214,6 @@ struct buffer_head *__getblk_gfp(struct block_device *bdev, sector_t block,
 void __brelse(struct buffer_head *);
 void __bforget(struct buffer_head *);
 void __breadahead(struct block_device *, sector_t block, unsigned int size);
-void __breadahead_gfp(struct block_device *, sector_t block, unsigned int size,
-		  gfp_t gfp);
 struct buffer_head *__bread_gfp(struct block_device *,
 				sector_t block, unsigned size, gfp_t gfp);
 void invalidate_bh_lrus(void);
@@ -340,12 +338,6 @@ sb_breadahead(struct super_block *sb, sector_t block)
 	__breadahead(sb->s_bdev, block, sb->s_blocksize);
 }
 
-static inline void
-sb_breadahead_unmovable(struct super_block *sb, sector_t block)
-{
-	__breadahead_gfp(sb->s_bdev, block, sb->s_blocksize, 0);
-}
-
 static inline struct buffer_head *
 sb_getblk(struct super_block *sb, sector_t block)
 {
-- 
2.31.1

