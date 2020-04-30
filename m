Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E41B1BEEA9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 05:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgD3D0o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 23:26:44 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50886 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726309AbgD3D0o (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 23:26:44 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EDB4D33C49F59BC82B6E;
        Thu, 30 Apr 2020 11:26:41 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 30 Apr 2020 11:26:32 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Yuqi Jin <jinyuqi@huawei.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: [RFC PATCH] fs: Move @f_count to different cacheline with @f_mode
Date:   Thu, 30 Apr 2020 11:25:32 +0800
Message-ID: <1588217132-41242-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yuqi Jin <jinyuqi@huawei.com>

__fget_files does check the @f_mode with mask variable and will do some
atomic operations on @f_count while both are on the same cacheline.
Many CPU cores do file access and it will cause much conflicts on @f_count. 
If we could make the two members into different cachelines, it shall relax
the siutations.

We have tested this on ARM64 and X86, the result is as follows:

Syscall of unixbench has been run on Huawei Kunpeng920 with this patch:
24 x System Call Overhead  1

System Call Overhead                    3160841.4 lps   (10.0 s, 1 samples)

System Benchmarks Partial Index              BASELINE       RESULT    INDEX
System Call Overhead                          15000.0    3160841.4   2107.2
                                                                   ========
System Benchmarks Index Score (Partial Only)                         2107.2

Without this patch:
24 x System Call Overhead  1

System Call Overhead                    2222456.0 lps   (10.0 s, 1 samples)

System Benchmarks Partial Index              BASELINE       RESULT    INDEX
System Call Overhead                          15000.0    2222456.0   1481.6
                                                                   ========
System Benchmarks Index Score (Partial Only)                         1481.6

And on Intel 6248 platform with this patch:
40 CPUs in system; running 24 parallel copies of tests

System Call Overhead                        4288509.1 lps   (10.0 s, 1 samples)

System Benchmarks Partial Index              BASELINE       RESULT    INDEX
System Call Overhead                          15000.0    4288509.1   2859.0
                                                                   ========
System Benchmarks Index Score (Partial Only)                         2859.0

Without this patch:
40 CPUs in system; running 24 parallel copies of tests

System Call Overhead                        3666313.0 lps   (10.0 s, 1 samples)

System Benchmarks Partial Index              BASELINE       RESULT    INDEX
System Call Overhead                          15000.0    3666313.0   2444.2
                                                                   ========
System Benchmarks Index Score (Partial Only)                         2444.2

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Yuqi Jin <jinyuqi@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4f6f59b4f22a..90e76283f0fd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -953,7 +953,6 @@ struct file {
 	 */
 	spinlock_t		f_lock;
 	enum rw_hint		f_write_hint;
-	atomic_long_t		f_count;
 	unsigned int 		f_flags;
 	fmode_t			f_mode;
 	struct mutex		f_pos_lock;
@@ -976,6 +975,7 @@ struct file {
 #endif /* #ifdef CONFIG_EPOLL */
 	struct address_space	*f_mapping;
 	errseq_t		f_wb_err;
+	atomic_long_t		f_count;
 } __randomize_layout
   __attribute__((aligned(4)));	/* lest something weird decides that 2 is OK */
 
-- 
2.7.4

