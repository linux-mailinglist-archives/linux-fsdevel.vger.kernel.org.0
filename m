Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1921D7A2985
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 23:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237831AbjIOVdc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 17:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237728AbjIOVdN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:33:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB0B18D;
        Fri, 15 Sep 2023 14:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=thUa+GI8LogBnk2itZ6HfrgnIy9fcg1//Qc9u4UGwh8=; b=FylAZt6NRWKeXs49zjVqb5xpZE
        MQ1ezlENpkCtY1xG8O9m+S6v3geuBLsuoU/jZZ6rOdB1Uri4HZNCRooRQVJkI8iiVZvRZb0SVlvUC
        t1N1i7YlV9BJnxC7pbJi/AeGw6Bauh6rpOThcOvQpHro8p9gSJzt6bWPCox4T/DKPjbTEgztYEG0Q
        ovruUkG34tjzemunuH6MjFwxtgishAiMLG7Goa84fzGJSWMlbuBL5yGFkPBdNAeKX3PSQM9khO7BM
        qlgx9+sV2oGyt3gWnXEvOMlapwuJvm0PZ3sj/e2AoKG7wERS0hYHBEOe0M2SD/9LoJn7Djncb7jHi
        MW5A3D3A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qhGQq-00BQnU-17;
        Fri, 15 Sep 2023 21:32:56 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hch@infradead.org, djwong@kernel.org, dchinner@redhat.com,
        kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com
Cc:     willy@infradead.org, brauner@kernel.org, hare@suse.de,
        ritesh.list@gmail.com, rgoldwyn@suse.com, jack@suse.cz,
        ziy@nvidia.com, ryan.roberts@arm.com, patches@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, p.raghav@samsung.com,
        da.gomez@samsung.com, dan.helmick@samsung.com, mcgrof@kernel.org
Subject: [RFC v2 06/10] bdev: simplify coexistance
Date:   Fri, 15 Sep 2023 14:32:50 -0700
Message-Id: <20230915213254.2724586-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230915213254.2724586-1-mcgrof@kernel.org>
References: <20230915213254.2724586-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that we have a bdev inode aops easily switch between buffer-heads
and iomap we can simplify our requirement. This also enables usage
of xfs on devices which for example have a physical block size greater
than page size but the logical block size is only 4k or lower.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/bdev.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index bf3cfc02aaf9..d9236eb149a4 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -143,13 +143,6 @@ static void set_init_blocksize(struct block_device *bdev)
 	}
 }
 
-static int bdev_bsize_limit(struct block_device *bdev)
-{
-	if (bdev->bd_inode->i_data.a_ops == &def_blk_aops_iomap)
-		return 1 << (PAGE_SHIFT + MAX_PAGECACHE_ORDER);
-	return PAGE_SIZE;
-}
-
 #ifdef CONFIG_BUFFER_HEAD
 static void bdev_aops_set(struct block_device *bdev,
 			  const struct address_space_operations *aops)
@@ -205,8 +198,10 @@ static int sb_bdev_aops_set(struct super_block *sb)
 
 int set_blocksize(struct block_device *bdev, int size)
 {
+	unsigned int bdev_size_limit = 1 << (PAGE_SHIFT + MAX_PAGECACHE_ORDER);
+
 	/* Size must be a power of two, and between 512 and supported order */
-	if (size > bdev_bsize_limit(bdev) || size < 512 || !is_power_of_2(size))
+	if (size > bdev_size_limit || size < 512 || !is_power_of_2(size))
 		return -EINVAL;
 
 	/* Size cannot be smaller than the size supported by the device */
-- 
2.39.2

