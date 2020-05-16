Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DBF1D5DEC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 May 2020 04:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgEPCcb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 22:32:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4795 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726247AbgEPCcb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 22:32:31 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2FE1DED90303D5753C03;
        Sat, 16 May 2020 10:32:27 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.197) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Sat, 16 May 2020
 10:32:19 +0800
Subject: Re: [PATCH 2/4] proc/sysctl: add shared variables -1
To:     Kees Cook <keescook@chromium.org>
CC:     <mcgrof@kernel.org>, <yzaikin@google.com>, <adobriyan@gmail.com>,
        <mingo@kernel.org>, <peterz@infradead.org>,
        <akpm@linux-foundation.org>, <yamada.masahiro@socionext.com>,
        <bauerman@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <skhan@linuxfoundation.org>, <dvyukov@google.com>,
        <svens@stackframe.org>, <joel@joelfernandes.org>,
        <tglx@linutronix.de>, <Jisheng.Zhang@synaptics.com>,
        <pmladek@suse.com>, <bigeasy@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <wangle6@huawei.com>
References: <1589517224-123928-1-git-send-email-nixiaoming@huawei.com>
 <1589517224-123928-3-git-send-email-nixiaoming@huawei.com>
 <202005150105.33CAEEA6C5@keescook>
 <88f3078b-9419-b9c6-e789-7d6e50ca2cef@huawei.com>
 <202005150904.743BB3E52@keescook>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <ab5f75d4-4d69-7b95-e6bd-ba8fd9792d94@huawei.com>
Date:   Sat, 16 May 2020 10:32:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <202005150904.743BB3E52@keescook>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/5/16 0:05, Kees Cook wrote:
> On Fri, May 15, 2020 at 05:06:28PM +0800, Xiaoming Ni wrote:
>> On 2020/5/15 16:06, Kees Cook wrote:
>>> On Fri, May 15, 2020 at 12:33:42PM +0800, Xiaoming Ni wrote:
>>>> Add the shared variable SYSCTL_NEG_ONE to replace the variable neg_one
>>>> used in both sysctl_writes_strict and hung_task_warnings.
>>>>
>>>> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
>>>> ---
>>>>    fs/proc/proc_sysctl.c     | 2 +-
>>>>    include/linux/sysctl.h    | 1 +
>>>>    kernel/hung_task_sysctl.c | 3 +--
>>>>    kernel/sysctl.c           | 3 +--
>>>
>>> How about doing this refactoring in advance of the extraction patch?
>> Before  advance of the extraction patch, neg_one is only used in one file,
>> does it seem to have no value for refactoring?
> 
> I guess it doesn't matter much, but I think it's easier to review in the
> sense that neg_one is first extracted and then later everything else is
> moved.
> 
Later, when more features sysctl interface is moved to the code file, 
there will be more variables that need to be extracted.
So should I only extract the neg_one variable here, or should I extract 
all the variables used by multiple features?

  fs/proc/proc_sysctl.c  |  2 +-
  include/linux/sysctl.h | 11 ++++++++---
  kernel/sysctl.c        | 37 ++++++++++++++++---------------------
  3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index b6f5d45..3f77e64 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -23,7 +23,7 @@
  static const struct inode_operations proc_sys_dir_operations;

  /* shared constants to be used in various sysctls */
-const int sysctl_vals[] = { 0, 1, INT_MAX };
+const int sysctl_vals[] = { -1, 0, 1, 2, 4, 100, 1000, INT_MAX };
  EXPORT_SYMBOL(sysctl_vals);

  /* Support for permanently empty directories */
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 43f8ef9..bf97c30 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -38,9 +38,14 @@
  struct ctl_dir;

  /* Keep the same order as in fs/proc/proc_sysctl.c */
-#define SYSCTL_ZERO	((void *)&sysctl_vals[0])
-#define SYSCTL_ONE	((void *)&sysctl_vals[1])
-#define SYSCTL_INT_MAX	((void *)&sysctl_vals[2])
+#define SYSCTL_NEG_ONE	((void *)&sysctl_vals[0])
+#define SYSCTL_ZERO	((void *)&sysctl_vals[1])
+#define SYSCTL_ONE	((void *)&sysctl_vals[2])
+#define SYSCTL_TWO	((void *)&sysctl_vals[3])
+#define SYSCTL_FOUR	((void *)&sysctl_vals[4])
+#define SYSCTL_ONE_HUNDRED	((void *)&sysctl_vals[5])
+#define SYSCTL_ONE_THOUSAND	((void *)&sysctl_vals[6])
+#define SYSCTL_INT_MAX	((void *)&sysctl_vals[7])

  extern const int sysctl_vals[];

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 5dd6d01..efe6172 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -118,14 +118,9 @@

  /* Constants used for minimum and  maximum */

-static int __maybe_unused neg_one = -1;
-static int __maybe_unused two = 2;
-static int __maybe_unused four = 4;
  static unsigned long zero_ul;
  static unsigned long one_ul = 1;
  static unsigned long long_max = LONG_MAX;
-static int one_hundred = 100;
-static int one_thousand = 1000;
  #ifdef CONFIG_PRINTK
  static int ten_thousand = 10000;
  #endif
@@ -534,7 +529,7 @@ static int sysrq_sysctl_handler(struct ctl_table 
*table, int write,
  		.maxlen		= sizeof(int),
  		.mode		= 0644,
  		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &neg_one,
+		.extra1		= SYSCTL_NEG_ONE,
  		.extra2		= SYSCTL_ONE,
  	},
  #endif
@@ -865,7 +860,7 @@ static int sysrq_sysctl_handler(struct ctl_table 
*table, int write,
  		.mode		= 0644,
  		.proc_handler	= proc_dointvec_minmax_sysadmin,
  		.extra1		= SYSCTL_ZERO,
-		.extra2		= &two,
+		.extra2		= SYSCTL_TWO,
  	},
  #endif
  	{
@@ -1043,7 +1038,7 @@ static int sysrq_sysctl_handler(struct ctl_table 
*table, int write,
  		.mode		= 0644,
  		.proc_handler	= perf_cpu_time_max_percent_handler,
  		.extra1		= SYSCTL_ZERO,
-		.extra2		= &one_hundred,
+		.extra2		= SYSCTL_ONE_HUNDRED,
  	},
  	{
  		.procname	= "perf_event_max_stack",
@@ -1061,7 +1056,7 @@ static int sysrq_sysctl_handler(struct ctl_table 
*table, int write,
  		.mode		= 0644,
  		.proc_handler	= perf_event_max_stack_handler,
  		.extra1		= SYSCTL_ZERO,
-		.extra2		= &one_thousand,
+		.extra2		= SYSCTL_ONE_THOUSAND,
  	},
  #endif
  	{
@@ -1136,7 +1131,7 @@ static int sysrq_sysctl_handler(struct ctl_table 
*table, int write,
  		.mode		= 0644,
  		.proc_handler	= proc_dointvec_minmax,
  		.extra1		= SYSCTL_ZERO,
-		.extra2		= &two,
+		.extra2		= SYSCTL_TWO,
  	},
  	{
  		.procname	= "panic_on_oom",
@@ -1145,7 +1140,7 @@ static int sysrq_sysctl_handler(struct ctl_table 
*table, int write,
  		.mode		= 0644,
  		.proc_handler	= proc_dointvec_minmax,
  		.extra1		= SYSCTL_ZERO,
-		.extra2		= &two,
+		.extra2		= SYSCTL_TWO,
  	},
  	{
  		.procname	= "oom_kill_allocating_task",
@@ -1190,7 +1185,7 @@ static int sysrq_sysctl_handler(struct ctl_table 
*table, int write,
  		.mode		= 0644,
  		.proc_handler	= dirty_background_ratio_handler,
  		.extra1		= SYSCTL_ZERO,
-		.extra2		= &one_hundred,
+		.extra2		= SYSCTL_ONE_HUNDRED,
  	},
  	{
  		.procname	= "dirty_background_bytes",
@@ -1207,7 +1202,7 @@ static int sysrq_sysctl_handler(struct ctl_table 
*table, int write,
  		.mode		= 0644,
  		.proc_handler	= dirty_ratio_handler,
  		.extra1		= SYSCTL_ZERO,
-		.extra2		= &one_hundred,
+		.extra2		= SYSCTL_ONE_HUNDRED,
  	},
  	{
  		.procname	= "dirty_bytes",
@@ -1247,7 +1242,7 @@ static int sysrq_sysctl_handler(struct ctl_table 
*table, int write,
  		.mode		= 0644,
  		.proc_handler	= proc_dointvec_minmax,
  		.extra1		= SYSCTL_ZERO,
-		.extra2		= &one_hundred,
+		.extra2		= SYSCTL_ONE_HUNDRED,
  	},
  #ifdef CONFIG_HUGETLB_PAGE
  	{
@@ -1304,7 +1299,7 @@ static int sysrq_sysctl_handler(struct ctl_table 
*table, int write,
  		.mode		= 0200,
  		.proc_handler	= drop_caches_sysctl_handler,
  		.extra1		= SYSCTL_ONE,
-		.extra2		= &four,
+		.extra2		= SYSCTL_FOUR,
  	},
  #ifdef CONFIG_COMPACTION
  	{
@@ -1357,7 +1352,7 @@ static int sysrq_sysctl_handler(struct ctl_table 
*table, int write,
  		.mode		= 0644,
  		.proc_handler	= watermark_scale_factor_sysctl_handler,
  		.extra1		= SYSCTL_ONE,
-		.extra2		= &one_thousand,
+		.extra2		= SYSCTL_ONE_THOUSAND,
  	},
  	{
  		.procname	= "percpu_pagelist_fraction",
@@ -1436,7 +1431,7 @@ static int sysrq_sysctl_handler(struct ctl_table 
*table, int write,
  		.mode		= 0644,
  		.proc_handler	= sysctl_min_unmapped_ratio_sysctl_handler,
  		.extra1		= SYSCTL_ZERO,
-		.extra2		= &one_hundred,
+		.extra2		= SYSCTL_ONE_HUNDRED,
  	},
  	{
  		.procname	= "min_slab_ratio",
@@ -1445,7 +1440,7 @@ static int sysrq_sysctl_handler(struct ctl_table 
*table, int write,
  		.mode		= 0644,
  		.proc_handler	= sysctl_min_slab_ratio_sysctl_handler,
  		.extra1		= SYSCTL_ZERO,
-		.extra2		= &one_hundred,
+		.extra2		= SYSCTL_ONE_HUNDRED,
  	},
  #endif
  #ifdef CONFIG_SMP
@@ -1728,7 +1723,7 @@ static int sysrq_sysctl_handler(struct ctl_table 
*table, int write,
  		.mode		= 0600,
  		.proc_handler	= proc_dointvec_minmax,
  		.extra1		= SYSCTL_ZERO,
-		.extra2		= &two,
+		.extra2		= SYSCTL_TWO,
  	},
  	{
  		.procname	= "protected_regular",
@@ -1737,7 +1732,7 @@ static int sysrq_sysctl_handler(struct ctl_table 
*table, int write,
  		.mode		= 0600,
  		.proc_handler	= proc_dointvec_minmax,
  		.extra1		= SYSCTL_ZERO,
-		.extra2		= &two,
+		.extra2		= SYSCTL_TWO,
  	},
  	{
  		.procname	= "suid_dumpable",
@@ -1746,7 +1741,7 @@ static int sysrq_sysctl_handler(struct ctl_table 
*table, int write,
  		.mode		= 0644,
  		.proc_handler	= proc_dointvec_minmax_coredump,
  		.extra1		= SYSCTL_ZERO,
-		.extra2		= &two,
+		.extra2		= SYSCTL_TWO,
  	},
  #if defined(CONFIG_BINFMT_MISC) || defined(CONFIG_BINFMT_MISC_MODULE)
  	{



