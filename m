Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BAC76D2A4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 17:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbjHBPne (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 11:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235299AbjHBPm1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:42:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49422689;
        Wed,  2 Aug 2023 08:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=t1/fXxbj2uJU5xas1rDU20QLxJIeGJx3IPPvaW9KT9Y=; b=2i+CcpcoXVSq4J7NqyEaRQu0MS
        DSsA4T4HQ7JZ+g7Ov6bcczZ/tpF4ZkTz9NxECM9geFk5dv1/TztPUrp17xFtlDXKLyoX3pkpemqeB
        OQPpsZdYMVdmbDglOG0I9dpqcqqeyV/XjkQ67mNuOFgWIEwDlobHlmhsm0iPi3w+6wR+6G5B1YZQP
        iWapYBcFtpmWKbvl+Jn8/7LBe0gSETLk1M6EwK0Ny2GMRQFmOIyT6N6Ad/dzBzf+vmZA2pOhMR8re
        MOaux36gSAexWnIViecm5TMwu6JeqWJ/qWyq27xWHNPjx/AhL2CBf5lfuvqnCDWkGqZsv5nzmKORQ
        JAio8dFQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qRDzG-005GLm-2Q;
        Wed, 02 Aug 2023 15:42:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH 10/12] ext4: use fs_holder_ops for the log device
Date:   Wed,  2 Aug 2023 17:41:29 +0200
Message-Id: <20230802154131.2221419-11-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230802154131.2221419-1-hch@lst.de>
References: <20230802154131.2221419-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the generic fs_holder_ops to shut down the file system when the
log device goes away instead of duplicating the logic.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/super.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 2ccb19d345c6dd..063832e2d12a8e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1096,15 +1096,6 @@ void ext4_update_dynamic_rev(struct super_block *sb)
 	 */
 }
 
-static void ext4_bdev_mark_dead(struct block_device *bdev)
-{
-	ext4_force_shutdown(bdev->bd_holder, EXT4_GOING_FLAGS_NOLOGFLUSH);
-}
-
-static const struct blk_holder_ops ext4_holder_ops = {
-	.mark_dead		= ext4_bdev_mark_dead,
-};
-
 /*
  * Open the external journal device
  */
@@ -1113,7 +1104,7 @@ static struct block_device *ext4_blkdev_get(dev_t dev, struct super_block *sb)
 	struct block_device *bdev;
 
 	bdev = blkdev_get_by_dev(dev, BLK_OPEN_READ | BLK_OPEN_WRITE, sb,
-				 &ext4_holder_ops);
+				 &fs_holder_ops);
 	if (IS_ERR(bdev))
 		goto fail;
 	return bdev;
-- 
2.39.2

