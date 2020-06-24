Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61AF3206F05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 10:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389285AbgFXIeW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 04:34:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6826 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387811AbgFXIeV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 04:34:21 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 760C32DC9BA1D31F18B1;
        Wed, 24 Jun 2020 16:34:18 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Wed, 24 Jun 2020 16:34:10 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Boqun Feng <boqun.feng@gmail.com>,
        Yuqi Jin <jinyuqi@huawei.com>
Subject: [PATCH RESEND] fs: Move @f_count to different cacheline with @f_mode
Date:   Wed, 24 Jun 2020 16:32:28 +0800
Message-ID: <1592987548-8653-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

get_file_rcu_many, which is called by __fget_files, has used
atomic_try_cmpxchg now and it can reduce the access number of the global
variable to improve the performance of atomic instruction compared with
atomic_cmpxchg. 

__fget_files does check the @f_mode with mask variable and will do some
atomic operations on @f_count, but both are on the same cacheline.
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

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Yuqi Jin <jinyuqi@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3f881a892ea7..0faeab5622fb 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -955,7 +955,6 @@ struct file {
 	 */
 	spinlock_t		f_lock;
 	enum rw_hint		f_write_hint;
-	atomic_long_t		f_count;
 	unsigned int 		f_flags;
 	fmode_t			f_mode;
 	struct mutex		f_pos_lock;
@@ -979,6 +978,7 @@ struct file {
 	struct address_space	*f_mapping;
 	errseq_t		f_wb_err;
 	errseq_t		f_sb_err; /* for syncfs */
+	atomic_long_t		f_count;
 } __randomize_layout
   __attribute__((aligned(4)));	/* lest something weird decides that 2 is OK */
 
-- 
2.7.4

