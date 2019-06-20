Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBFE4D1CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2019 17:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfFTPPq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jun 2019 11:15:46 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44530 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726512AbfFTPPp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jun 2019 11:15:45 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8B25BEEF051135EFB448;
        Thu, 20 Jun 2019 23:15:42 +0800 (CST)
Received: from [127.0.0.1] (10.184.225.177) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Thu, 20 Jun 2019
 23:15:33 +0800
To:     <corbet@lwn.net>, <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
CC:     <akpm@linux-foundation.org>, <manfred@colorfullife.com>,
        <jwilk@jwilk.net>, <dvyukov@google.com>, <feng.tang@intel.com>,
        <sunilmut@microsoft.com>, <quentin.perret@arm.com>,
        <linux@leemhuis.info>, <alex.popov@linux.com>,
        <tglx@linutronix.de>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        "wangxiaogang (F)" <wangxiaogang3@huawei.com>,
        "Zhoukang (A)" <zhoukang7@huawei.com>,
        Mingfangsen <mingfangsen@huawei.com>, <tedheadster@gmail.com>,
        Eric Dumazet <edumazet@google.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: [PATCH next] softirq: enable MAX_SOFTIRQ_TIME tuning with sysctl
 max_softirq_time_usecs
Message-ID: <f274f85a-bbb6-3e32-b293-1d5d7f27a98f@huawei.com>
Date:   Thu, 20 Jun 2019 23:14:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.225.177]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Zhiqiang liu <liuzhiqiang26@huawei.com>

In __do_softirq func, MAX_SOFTIRQ_TIME was set to 2ms via experimentation by
commit c10d73671 ("softirq: reduce latencies") in 2013, which was designed
to reduce latencies for various network workloads. The key reason is that the
maximum number of microseconds in one NAPI polling cycle in net_rx_action func
was set to 2 jiffies, so different HZ settting will lead to different latencies.

However, commit 7acf8a1e8 ("Replace 2 jiffies with sysctl netdev_budget_usecs
to enable softirq tuning") adopts netdev_budget_usecs to tun maximum number of
microseconds in one NAPI polling cycle. So the latencies of net_rx_action can be
controlled by sysadmins to copy with hardware changes over time.

Correspondingly, the MAX_SOFTIRQ_TIME should be able to be tunned by sysadmins,
who knows best about hardware performance, for excepted tradeoff between latence
and fairness.

Here, we add sysctl variable max_softirq_time_usecs to replace MAX_SOFTIRQ_TIME
with 2ms default value.

Signed-off-by: Zhiqiang liu <liuzhiqiang26@huawei.com>
---
 Documentation/sysctl/kernel.txt |  7 +++++++
 kernel/softirq.c                | 10 ++++++----
 kernel/sysctl.c                 |  9 +++++++++
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/Documentation/sysctl/kernel.txt b/Documentation/sysctl/kernel.txt
index f0c86fbb3b48..647233faf896 100644
--- a/Documentation/sysctl/kernel.txt
+++ b/Documentation/sysctl/kernel.txt
@@ -44,6 +44,7 @@ show up in /proc/sys/kernel:
 - kexec_load_disabled
 - kptr_restrict
 - l2cr                        [ PPC only ]
+- max_softirq_time_usecs
 - modprobe                    ==> Documentation/debugging-modules.txt
 - modules_disabled
 - msg_next_id		      [ sysv ipc ]
@@ -445,6 +446,12 @@ This flag controls the L2 cache of G3 processor boards. If

 ==============================================================

+max_softirq_time_usecs:
+Maximum number of microseconds to break the loop of restarting softirq
+processing for at most MAX_SOFTIRQ_RESTART times in __do_softirq().
+
+==============================================================
+
 modules_disabled:

 A toggle value indicating if modules are allowed to be loaded
diff --git a/kernel/softirq.c b/kernel/softirq.c
index a6b81c6b6bff..32f93d82e2e8 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -199,8 +199,9 @@ EXPORT_SYMBOL(__local_bh_enable_ip);

 /*
  * We restart softirq processing for at most MAX_SOFTIRQ_RESTART times,
- * but break the loop if need_resched() is set or after 2 ms.
- * The MAX_SOFTIRQ_TIME provides a nice upper bound in most cases, but in
+ * but break the loop if need_resched() is set or after
+ * max_softirq_time_usecs usecs.
+ * The max_softirq_time_usecs provides a nice upper bound in most cases, but in
  * certain cases, such as stop_machine(), jiffies may cease to
  * increment and so we need the MAX_SOFTIRQ_RESTART limit as
  * well to make sure we eventually return from this method.
@@ -210,7 +211,7 @@ EXPORT_SYMBOL(__local_bh_enable_ip);
  * we want to handle softirqs as soon as possible, but they
  * should not be able to lock up the box.
  */
-#define MAX_SOFTIRQ_TIME  msecs_to_jiffies(2)
+unsigned int __read_mostly max_softirq_time_usecs = 2000;
 #define MAX_SOFTIRQ_RESTART 10

 #ifdef CONFIG_TRACE_IRQFLAGS
@@ -248,7 +249,8 @@ static inline void lockdep_softirq_end(bool in_hardirq) { }

 asmlinkage __visible void __softirq_entry __do_softirq(void)
 {
-	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
+	unsigned long end = jiffies +
+		usecs_to_jiffies(max_softirq_time_usecs);
 	unsigned long old_flags = current->flags;
 	int max_restart = MAX_SOFTIRQ_RESTART;
 	struct softirq_action *h;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 1beca96fb625..db4bc18f84de 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -118,6 +118,7 @@ extern unsigned int sysctl_nr_open_min, sysctl_nr_open_max;
 #ifndef CONFIG_MMU
 extern int sysctl_nr_trim_pages;
 #endif
+extern unsigned int max_softirq_time_usecs;

 /* Constants used for minimum and  maximum */
 #ifdef CONFIG_LOCKUP_DETECTOR
@@ -1276,6 +1277,14 @@ static struct ctl_table kern_table[] = {
 		.extra2		= &one,
 	},
 #endif
+	{
+		.procname	= "max_softirq_time_usecs",
+		.data		= &max_softirq_time_usecs,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler   = proc_dointvec_minmax,
+		.extra1		= &zero,
+	},
 	{ }
 };

-- 
2.19.1

