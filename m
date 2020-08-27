Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B52425439F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 12:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgH0KW2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 06:22:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40438 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728466AbgH0KWX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 06:22:23 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9002C4E592AF5C867A64;
        Thu, 27 Aug 2020 18:22:19 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 27 Aug 2020 18:22:13 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Yuqi Jin <jinyuqi@huawei.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Boqun Feng <boqun.feng@gmail.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: [PATCH] fs: Optimized fget to improve performance
Date:   Thu, 27 Aug 2020 18:19:44 +0800
Message-ID: <1598523584-25601-1-git-send-email-zhangshaokun@hisilicon.com>
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

It is well known that the performance of atomic_add is better than that of
atomic_cmpxchg.
The initial value of @f_count is 1. While @f_count is increased by 1 in
__fget_files, it will go through three phases: > 0, < 0, and = 0. When the
fixed value 0 is used as the condition for terminating the increase of 1,
only atomic_cmpxchg can be used. When we use < 0 as the condition for
stopping plus 1, we can use atomic_add to obtain better performance.

we test syscall in unixbench on Huawei Kunpeng920(arm64). We've got a 132%
performance boost. 

with this patch and the patch [1]
System Call Overhead                        9516926.2 lps   (10.0 s, 1 samples)

System Benchmarks Partial Index              BASELINE       RESULT    INDEX
System Call Overhead                          15000.0    9516926.2   6344.6
                                                                   ========
System Benchmarks Index Score (Partial Only)                         6344.6

with this patch and without the patch [1]
System Call Overhead                        5290449.3 lps   (10.0 s, 1 samples)

System Benchmarks Partial Index              BASELINE       RESULT    INDEX
System Call Overhead                          15000.0    5290449.3   3527.0
                                                                   ========
System Benchmarks Index Score (Partial Only)                         3527.0

without any patch
System Call Overhead                        4102310.5 lps   (10.0 s, 1 samples)

System Benchmarks Partial Index              BASELINE       RESULT    INDEX
System Call Overhead                          15000.0    4102310.5   2734.9
                                                                   ========
System Benchmarks Index Score (Partial Only)                         2734.9

[1] https://lkml.org/lkml/2020/6/24/283

Cc: kernel test robot <rong.a.chen@intel.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Yuqi Jin <jinyuqi@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
Hi Rong,

Can you help to test this patch individually and with [1] together on
your platform please? [1] has been tested on your platform[2].

[2] https://lkml.org/lkml/2020/7/8/227

 include/linux/fs.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index e019ea2f1347..2a9c2a30dc58 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -972,8 +972,19 @@ static inline struct file *get_file(struct file *f)
 	atomic_long_inc(&f->f_count);
 	return f;
 }
+
+static inline bool get_file_unless_negative(atomic_long_t *v, long a)
+{
+	long c = atomic_long_read(v);
+
+	if (c <= 0)
+		return 0;
+
+	return atomic_long_add_return(a, v) - 1;
+}
+
 #define get_file_rcu_many(x, cnt)	\
-	atomic_long_add_unless(&(x)->f_count, (cnt), 0)
+	get_file_unless_negative(&(x)->f_count, (cnt))
 #define get_file_rcu(x) get_file_rcu_many((x), 1)
 #define file_count(x)	atomic_long_read(&(x)->f_count)
 
-- 
2.7.4

