Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D8E324C5A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 10:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbhBYJA1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 04:00:27 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:44716 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232673AbhBYJA0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 04:00:26 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UPXLGam_1614243582;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UPXLGam_1614243582)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 25 Feb 2021 16:59:43 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] direct-io: Using kmem_cache_zalloc() instead of kmem_cache_alloc() and memset()
Date:   Thu, 25 Feb 2021 16:59:41 +0800
Message-Id: <1614243581-50870-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix the following coccicheck warning:
./fs/direct-io.c:1155:7-23: WARNING: kmem_cache_zalloc should be used
for dio, instead of kmem_cache_alloc/memset

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/direct-io.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 0957e1b..6ec2935 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1152,7 +1152,7 @@ static inline int drop_refcount(struct dio *dio)
 	if (iov_iter_rw(iter) == READ && !count)
 		return 0;
 
-	dio = kmem_cache_alloc(dio_cache, GFP_KERNEL);
+	dio = kmem_cache_zalloc(dio_cache, GFP_KERNEL);
 	if (!dio)
 		return -ENOMEM;
 	/*
@@ -1160,8 +1160,6 @@ static inline int drop_refcount(struct dio *dio)
 	 * performance regression in a database benchmark.  So, we take
 	 * care to only zero out what's needed.
 	 */
-	memset(dio, 0, offsetof(struct dio, pages));
-
 	dio->flags = flags;
 	if (dio->flags & DIO_LOCKING && iov_iter_rw(iter) == READ) {
 		/* will be released by direct_io_worker */
-- 
1.8.3.1

