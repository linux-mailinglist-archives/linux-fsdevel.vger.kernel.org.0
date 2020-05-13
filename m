Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3CAB1D05C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 06:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgEMEEP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 00:04:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49300 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbgEMEEO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 00:04:14 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9CC39B0CD71847D5C5A4;
        Wed, 13 May 2020 12:04:11 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.197) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Wed, 13 May 2020
 12:04:09 +0800
Subject: Re: linux-next: manual merge of the vfs tree with the parisc-hd tree
To:     Luis Chamberlain <mcgrof@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
CC:     Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Helge Deller <deller@gmx.de>,
        "Parisc List" <linux-parisc@vger.kernel.org>, <yzaikin@google.com>,
        <linux-fsdevel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, <gregkh@linuxfoundation.org>
References: <20200511111123.68ccbaa3@canb.auug.org.au>
 <99095805-8cbe-d140-e2f1-0c5a3e84d7e7@huawei.com>
 <20200512003305.GX11244@42.do-not-panic.com>
 <87y2pxs73w.fsf@x220.int.ebiederm.org>
 <20200512172413.GC11244@42.do-not-panic.com>
 <87k11hrqzc.fsf@x220.int.ebiederm.org>
 <20200512220341.GE11244@42.do-not-panic.com>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <3ccd08a5-cac6-3ca1-ed33-3cb62c982443@huawei.com>
Date:   Wed, 13 May 2020 12:04:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200512220341.GE11244@42.do-not-panic.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/5/13 6:03, Luis Chamberlain wrote:
> On Tue, May 12, 2020 at 12:40:55PM -0500, Eric W. Biederman wrote:
>> Luis Chamberlain <mcgrof@kernel.org> writes:
>>
>>> On Tue, May 12, 2020 at 06:52:35AM -0500, Eric W. Biederman wrote:
>>>> Luis Chamberlain <mcgrof@kernel.org> writes:
>>>>
>>>>> +static struct ctl_table fs_base_table[] = {
>>>>> +	{
>>>>> +		.procname	= "fs",
>>>>> +		.mode		= 0555,
>>>>> +		.child		= fs_table,
>>>>> +	},
>>>>> +	{ }
>>>>> +};
>>>>    ^^^^^^^^^^^^^^^^^^^^^^^^ You don't need this at all.
>>>>>> +static int __init fs_procsys_init(void)
>>>>> +{
>>>>> +	struct ctl_table_header *hdr;
>>>>> +
>>>>> +	hdr = register_sysctl_table(fs_base_table);
>>>>                ^^^^^^^^^^^^^^^^^^^^^ Please use register_sysctl instead.
>>>> 	AKA
>>>>          hdr = register_sysctl("fs", fs_table);
>>>
>>> Ah, much cleaner thanks!
>>
>> It is my hope you we can get rid of register_sysctl_table one of these
>> days.  It was the original interface but today it is just a
>> compatibility wrapper.
>>
>> I unfortunately ran out of steam last time before I finished converting
>> everything over.
> 
> Let's give it one more go. I'll start with the fs stuff.
> 
>    Luis
> 
> .
> 

If we register each feature in its own feature code file using 
register() to register the sysctl interface. To avoid merge conflicts 
when different features modify sysctl.c at the same time.
that is, try to Avoid mixing code with multiple features in the same 
code file.

For example, the multiple file interfaces defined in sysctl.c by the 
hung_task feature can  be moved to hung_task.c.

Perhaps later, without centralized sysctl.c ?
Is this better?

Thanks
Xiaoming Ni

---
  include/linux/sched/sysctl.h |  8 +----
  kernel/hung_task.c           | 78 
+++++++++++++++++++++++++++++++++++++++++++-
  kernel/sysctl.c              | 50 ----------------------------
  3 files changed, 78 insertions(+), 58 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index d4f6215..bb4e0d3 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -7,14 +7,8 @@
  struct ctl_table;

  #ifdef CONFIG_DETECT_HUNG_TASK
-extern int	     sysctl_hung_task_check_count;
-extern unsigned int  sysctl_hung_task_panic;
+/* used for block/ */
  extern unsigned long sysctl_hung_task_timeout_secs;
-extern unsigned long sysctl_hung_task_check_interval_secs;
-extern int sysctl_hung_task_warnings;
-extern int proc_dohung_task_timeout_secs(struct ctl_table *table, int 
write,
-					 void __user *buffer,
-					 size_t *lenp, loff_t *ppos);
  #else
  /* Avoid need for ifdefs elsewhere in the code */
  enum { sysctl_hung_task_timeout_secs = 0 };
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 14a625c..53589f2 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -20,10 +20,10 @@
  #include <linux/utsname.h>
  #include <linux/sched/signal.h>
  #include <linux/sched/debug.h>
+#include <linux/kmemleak.h>
  #include <linux/sched/sysctl.h>

  #include <trace/events/sched.h>
-
  /*
   * The number of tasks checked:
   */
@@ -296,8 +296,84 @@ static int watchdog(void *dummy)
  	return 0;
  }

+/*
+ * This is needed for proc_doulongvec_minmax of 
sysctl_hung_task_timeout_secs
+ * and hung_task_check_interval_secs
+ */
+static unsigned long hung_task_timeout_max = (LONG_MAX / HZ);
+static int __maybe_unused neg_one = -1;
+static struct ctl_table hung_task_sysctls[] = {
+	{
+		.procname	= "hung_task_panic",
+		.data		= &sysctl_hung_task_panic,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+	{
+		.procname	= "hung_task_check_count",
+		.data		= &sysctl_hung_task_check_count,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+	},
+	{
+		.procname	= "hung_task_timeout_secs",
+		.data		= &sysctl_hung_task_timeout_secs,
+		.maxlen		= sizeof(unsigned long),
+		.mode		= 0644,
+		.proc_handler	= proc_dohung_task_timeout_secs,
+		.extra2		= &hung_task_timeout_max,
+	},
+	{
+		.procname	= "hung_task_check_interval_secs",
+		.data		= &sysctl_hung_task_check_interval_secs,
+		.maxlen		= sizeof(unsigned long),
+		.mode		= 0644,
+		.proc_handler	= proc_dohung_task_timeout_secs,
+		.extra2		= &hung_task_timeout_max,
+	},
+	{
+		.procname	= "hung_task_warnings",
+		.data		= &sysctl_hung_task_warnings,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &neg_one,
+	},
+	{}
+};
+
+/* get /proc/sys/kernel root */
+static struct ctl_table sysctls_root[] = {
+	{
+		.procname       = "kernel",
+		.mode           = 0555,
+		.child          = hung_task_sysctls,
+	},
+	{}
+};
+
+static int __init hung_task_sysctl_init(void)
+{
+	struct ctl_table_header *srt = register_sysctl_table(sysctls_root);
+
+	if (!srt)
+		return -ENOMEM;
+	kmemleak_not_leak(srt);
+	return 0;
+}
+
  static int __init hung_task_init(void)
  {
+	int ret = hung_task_sysctl_init();
+
+	if (ret != 0)
+		return ret;
+
  	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);

  	/* Disable hung task detector on suspend */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 8a176d8..45a1153 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -149,13 +149,6 @@
  static int ngroups_max = NGROUPS_MAX;
  static const int cap_last_cap = CAP_LAST_CAP;

-/*
- * This is needed for proc_doulongvec_minmax of 
sysctl_hung_task_timeout_secs
- * and hung_task_check_interval_secs
- */
-#ifdef CONFIG_DETECT_HUNG_TASK
-static unsigned long hung_task_timeout_max = (LONG_MAX/HZ);
-#endif

  #ifdef CONFIG_INOTIFY_USER
  #include <linux/inotify.h>
@@ -1085,49 +1078,6 @@ static int sysrq_sysctl_handler(struct ctl_table 
*table, int write,
  		.proc_handler	= proc_dointvec,
  	},
  #endif
-#ifdef CONFIG_DETECT_HUNG_TASK
-	{
-		.procname	= "hung_task_panic",
-		.data		= &sysctl_hung_task_panic,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-	{
-		.procname	= "hung_task_check_count",
-		.data		= &sysctl_hung_task_check_count,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-	},
-	{
-		.procname	= "hung_task_timeout_secs",
-		.data		= &sysctl_hung_task_timeout_secs,
-		.maxlen		= sizeof(unsigned long),
-		.mode		= 0644,
-		.proc_handler	= proc_dohung_task_timeout_secs,
-		.extra2		= &hung_task_timeout_max,
-	},
-	{
-		.procname	= "hung_task_check_interval_secs",
-		.data		= &sysctl_hung_task_check_interval_secs,
-		.maxlen		= sizeof(unsigned long),
-		.mode		= 0644,
-		.proc_handler	= proc_dohung_task_timeout_secs,
-		.extra2		= &hung_task_timeout_max,
-	},
-	{
-		.procname	= "hung_task_warnings",
-		.data		= &sysctl_hung_task_warnings,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &neg_one,
-	},
-#endif
  #ifdef CONFIG_RT_MUTEXES
  	{
  		.procname	= "max_lock_depth",
-- 
1.8.5.6


