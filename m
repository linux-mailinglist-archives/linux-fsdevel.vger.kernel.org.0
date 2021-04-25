Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F7F36A6B0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Apr 2021 12:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhDYKe0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Apr 2021 06:34:26 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:48085 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229466AbhDYKe0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Apr 2021 06:34:26 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UWgfM-0_1619346808;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UWgfM-0_1619346808)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 25 Apr 2021 18:33:35 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] fs: direct-io: Remove redundant assignment to retval
Date:   Sun, 25 Apr 2021 18:33:27 +0800
Message-Id: <1619346807-47104-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Variable retval is set to zero but this value is never read as it is
overwritten with a new value later on, hence it is a redundant
assignment and can be removed.

Cleans up the following clang-analyzer warning:

fs/direct-io.c:1245:2: warning: Value stored to 'retval' is never read
[clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/direct-io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index b2e86e7..b348264 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1242,7 +1242,6 @@ static inline int drop_refcount(struct dio *dio)
 	 */
 	inode_dio_begin(inode);
 
-	retval = 0;
 	sdio.blkbits = blkbits;
 	sdio.blkfactor = i_blkbits - blkbits;
 	sdio.block_in_file = offset >> blkbits;
-- 
1.8.3.1

