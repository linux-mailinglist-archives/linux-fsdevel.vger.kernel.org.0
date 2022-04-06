Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCF94F6537
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 18:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237619AbiDFQX3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 12:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238262AbiDFQW6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:22:58 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318D12300A6;
        Tue,  5 Apr 2022 19:28:42 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KY7j94bywz1HBSy;
        Wed,  6 Apr 2022 10:28:13 +0800 (CST)
Received: from huawei.com (10.67.174.53) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 6 Apr
 2022 10:28:38 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <mcgrof@kernel.org>, <keescook@chromium.org>, <yzaikin@google.com>,
        <liaochang1@huawei.com>, <tglx@linutronix.de>, <nitesh@redhat.com>,
        <edumazet@google.com>, <clg@kaod.org>, <tannerlove@google.com>,
        <peterz@infradead.org>, <joshdon@google.com>,
        <masahiroy@kernel.org>, <nathan@kernel.org>, <vbabka@suse.cz>,
        <akpm@linux-foundation.org>, <gustavoars@kernel.org>,
        <arnd@arndb.de>, <chris@chrisdown.name>,
        <dmitry.torokhov@gmail.com>, <linux@rasmusvillemoes.dk>,
        <daniel@iogearbox.net>, <john.ogness@linutronix.de>,
        <will@kernel.org>, <dave@stgolabs.net>, <frederic@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <heying24@huawei.com>, <guohanjun@huawei.com>,
        <weiyongjun1@huawei.com>
Subject: [RFC 1/3] softirq: Add two parameters to control CPU bandwidth for use by softirq
Date:   Wed, 6 Apr 2022 10:27:47 +0800
Message-ID: <20220406022749.184807-2-liaochang1@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220406022749.184807-1-liaochang1@huawei.com>
References: <20220406022749.184807-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.53]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Although kernel merely allow __do_softirq() run for 2ms at most, it does
not control the total running time of softirqs on given CPU. In order to
prevent softirqs from using up all CPU bandwidth and cause other task
starved, Sofitrq Throttling mechanism introduces two parameters in the
/proc file system:

/proc/sys/kernel/sofitrq_period_ms
  Defines the period in ms(millisecond) to be considered as 100% of CPU
  bandwidth, the default value is 1,000 ms(1second). Changes to the
  value of the period must be very well thought out, as too long or too
  short are beyond one's expectation.

/proc/sys/kernel/softirq_runtime_ms
  Define the bandwidth available to softirqs on each CPU, the default
  values is 950 ms(0.95 second) or, in other words, 95% of the CPU
  bandwidth. Setting this value to -1 means that softirqs might use up
  to 100% CPU cycles.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 include/linux/interrupt.h |  7 ++++
 init/Kconfig              | 10 ++++++
 kernel/softirq.c          | 74 +++++++++++++++++++++++++++++++++++++++
 kernel/sysctl.c           | 16 +++++++++
 4 files changed, 107 insertions(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 9367f1cb2e3c..de6973bf72e5 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -605,6 +605,13 @@ extern void __raise_softirq_irqoff(unsigned int nr);
 extern void raise_softirq_irqoff(unsigned int nr);
 extern void raise_softirq(unsigned int nr);
 
+#ifdef CONFIG_SOFTIRQ_THROTTLE
+extern unsigned int sysctl_softirq_period_ms;
+extern int sysctl_softirq_runtime_ms;
+int softirq_throttle_handler(struct ctl_table *table, int write, void *buffer,
+		size_t *lenp, loff_t *ppos);
+#endif
+
 DECLARE_PER_CPU(struct task_struct *, ksoftirqd);
 
 static inline struct task_struct *this_cpu_ksoftirqd(void)
diff --git a/init/Kconfig b/init/Kconfig
index e9119bf54b1f..a63ebc88a199 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2393,3 +2393,13 @@ config ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 # <asm/syscall_wrapper.h>.
 config ARCH_HAS_SYSCALL_WRAPPER
 	def_bool n
+
+config SOFTIRQ_THROTTLE
+	bool "Softirq Throttling Feature"
+	help
+	  Allow to allocate bandwidth for use by softirq handling. This
+	  saftguard machanism is known as softirq throttling and is controlled
+	  by two parameters in the /proc/ file system:
+
+	  /proc/sysctl/kernel/softirq_period_ms
+	  /proc/sysctl/kernel/softirq_runtime_ms
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 41f470929e99..8aac9e2631fd 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -65,6 +65,76 @@ const char * const softirq_to_name[NR_SOFTIRQS] = {
 	"TASKLET", "SCHED", "HRTIMER", "RCU"
 };
 
+#ifdef CONFIG_SOFTIRQ_THROTTLE
+unsigned int sysctl_softirq_period_ms = 1000;
+int sysctl_softirq_runtime_ms = 950;
+
+struct softirq_throttle {
+	unsigned int period;
+	unsigned int runtime;
+	raw_spinlock_t lock;
+} si_throttle;
+
+static int softirq_throttle_validate(void)
+{
+	if (((int)sysctl_softirq_period_ms <= 0) ||
+		((sysctl_softirq_runtime_ms != -1) &&
+		 ((unsigned int)sysctl_softirq_runtime_ms > sysctl_softirq_period_ms)))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void softirq_throttle_update(void)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&si_throttle.lock, flags);
+	si_throttle.period = sysctl_softirq_period_ms;
+	si_throttle.runtime = sysctl_softirq_runtime_ms;
+	raw_spin_unlock_irqrestore(&si_throttle.lock, flags);
+}
+
+int softirq_throttle_handler(struct ctl_table *table, int write, void *buffer,
+		size_t *lenp, loff_t *ppos)
+{
+	unsigned int old_period, old_runtime;
+	static DEFINE_MUTEX(mutex);
+	int ret;
+
+	mutex_lock(&mutex);
+	old_period = sysctl_softirq_period_ms;
+	old_runtime = sysctl_softirq_runtime_ms;
+
+	ret = proc_dointvec(table, write, buffer, lenp, ppos);
+	if (ret)
+		goto undo;
+	if (!write)
+		goto done;
+
+	ret = softirq_throttle_validate();
+	if (ret)
+		goto undo;
+
+	softirq_throttle_update();
+	goto done;
+
+undo:
+	sysctl_softirq_period_ms = old_period;
+	sysctl_softirq_runtime_ms = old_runtime;
+done:
+	mutex_unlock(&mutex);
+	return ret;
+}
+
+static void softirq_throttle_init(void)
+{
+	si_throttle.period = sysctl_softirq_period_ms;
+	si_throttle.runtime = sysctl_softirq_runtime_ms;
+	raw_spin_lock_init(&si_throttle.lock);
+}
+#endif
+
 /*
  * we cannot loop indefinitely here to avoid userspace starvation,
  * but we also don't want to introduce a worst case 1/HZ latency
@@ -894,6 +964,10 @@ void __init softirq_init(void)
 {
 	int cpu;
 
+#ifdef CONFIG_SOFTIRQ_THROTTLE
+	softirq_throttle_init();
+#endif
+
 	for_each_possible_cpu(cpu) {
 		per_cpu(tasklet_vec, cpu).tail =
 			&per_cpu(tasklet_vec, cpu).head;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 5ae443b2882e..e5a9ad391cca 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1771,6 +1771,22 @@ static struct ctl_table kern_table[] = {
 		.extra1		= SYSCTL_ONE,
 	},
 #endif
+#ifdef CONFIG_SOFTIRQ_THROTTLE
+	{
+		.procname	= "softirq_period_ms",
+		.data		= &sysctl_softirq_period_ms,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= softirq_throttle_handler,
+	},
+	{
+		.procname	= "softirq_runtime_ms",
+		.data		= &sysctl_softirq_runtime_ms,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= softirq_throttle_handler,
+	},
+#endif
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 	{
 		.procname	= "sched_energy_aware",
-- 
2.17.1

