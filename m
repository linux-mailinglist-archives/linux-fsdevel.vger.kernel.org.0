Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855BD2571B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 03:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgHaBwt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Aug 2020 21:52:49 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:38415 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726454AbgHaBws (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Aug 2020 21:52:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01353;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U7IVksK_1598838766;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U7IVksK_1598838766)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 31 Aug 2020 09:52:46 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH] [RFC] exec: the vma passed to shift_arg_pages() must not have next
Date:   Mon, 31 Aug 2020 09:51:21 +0800
Message-Id: <20200831015121.20036-1-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We can divide vma_adjust() into two categories based on whether the
*insert* is NULL or not. And when *insert* is NULL, it has two users:
mremap() and shift_arg_pages().

For the second vma_adjust() in shift_arg_pages(), the vma must not have
next. Otherwise vma_adjust() would expand next->vm_start instead of just
shift the vma.

Fortunately, shift_arg_pages() is only used in setup_arg_pages() to move
stack, which is placed on the top of the address range. This means the
vma is not expected to have a next.

Since mremap() calls vma_adjust() to expand itself, shift_arg_pages() is
the only case it may fall into mprotect case 4 by accident. Let's add a
BUG_ON() and comment to inform the following audience.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 fs/exec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index a91003e28eaa..3ff44ab0d112 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -682,6 +682,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
 	struct mmu_gather tlb;
 
 	BUG_ON(new_start > new_end);
+	BUG_ON(vma->vm_next);
 
 	/*
 	 * ensure there are no vmas between where we want to go
@@ -726,6 +727,8 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
 
 	/*
 	 * Shrink the vma to just the new range.  Always succeeds.
+	 * Since !vma->vm_next, __vma_adjust() would not go to mprotect case
+	 * 4 to expand next.
 	 */
 	vma_adjust(vma, new_start, new_end, vma->vm_pgoff, NULL);
 
-- 
2.20.1 (Apple Git-117)

