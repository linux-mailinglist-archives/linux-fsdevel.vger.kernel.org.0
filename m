Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D526C43BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 08:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjCVHAD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 03:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCVHAC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 03:00:02 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1795018B1B;
        Tue, 21 Mar 2023 23:59:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VePpt3A_1679468391;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VePpt3A_1679468391)
          by smtp.aliyun-inc.com;
          Wed, 22 Mar 2023 14:59:57 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     viro@zeniv.linux.org.uk
Cc:     brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] fs/buffer: Remove redundant assignment to err
Date:   Wed, 22 Mar 2023 14:59:49 +0800
Message-Id: <20230322065949.29223-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Variable 'err' set but not used.

fs/buffer.c:2613:2: warning: Value stored to 'err' is never read.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4589
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/buffer.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index d759b105c1e7..c844b5b93a89 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2580,7 +2580,7 @@ int block_truncate_page(struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	struct page *page;
 	struct buffer_head *bh;
-	int err;
+	int err = 0;
 
 	blocksize = i_blocksize(inode);
 	length = offset & (blocksize - 1);
@@ -2593,9 +2593,8 @@ int block_truncate_page(struct address_space *mapping,
 	iblock = (sector_t)index << (PAGE_SHIFT - inode->i_blkbits);
 	
 	page = grab_cache_page(mapping, index);
-	err = -ENOMEM;
 	if (!page)
-		goto out;
+		return -ENOMEM;
 
 	if (!page_has_buffers(page))
 		create_empty_buffers(page, blocksize, 0);
@@ -2609,7 +2608,6 @@ int block_truncate_page(struct address_space *mapping,
 		pos += blocksize;
 	}
 
-	err = 0;
 	if (!buffer_mapped(bh)) {
 		WARN_ON(bh->b_size != blocksize);
 		err = get_block(inode, iblock, bh, 0);
@@ -2633,7 +2631,6 @@ int block_truncate_page(struct address_space *mapping,
 
 	zero_user(page, offset, length);
 	mark_buffer_dirty(bh);
-	err = 0;
 
 unlock:
 	unlock_page(page);
-- 
2.20.1.7.g153144c

