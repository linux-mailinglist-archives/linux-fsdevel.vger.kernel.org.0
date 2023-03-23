Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0946C5CAB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 03:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjCWCdK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 22:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjCWCdJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 22:33:09 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1D32CC53;
        Wed, 22 Mar 2023 19:33:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VeSSihz_1679538780;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VeSSihz_1679538780)
          by smtp.aliyun-inc.com;
          Thu, 23 Mar 2023 10:33:04 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     viro@zeniv.linux.org.uk
Cc:     brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH v2] fs/buffer: Remove redundant assignment to err
Date:   Thu, 23 Mar 2023 10:32:59 +0800
Message-Id: <20230323023259.6924-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Changes in v2:
  -Remove unused out label.

 fs/buffer.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index d759b105c1e7..b3eb905f87d6 100644
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
@@ -2633,12 +2631,11 @@ int block_truncate_page(struct address_space *mapping,
 
 	zero_user(page, offset, length);
 	mark_buffer_dirty(bh);
-	err = 0;
 
 unlock:
 	unlock_page(page);
 	put_page(page);
-out:
+
 	return err;
 }
 EXPORT_SYMBOL(block_truncate_page);
-- 
2.20.1.7.g153144c

