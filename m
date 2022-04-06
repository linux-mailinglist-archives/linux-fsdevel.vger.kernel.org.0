Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563194F61CA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 16:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbiDFOfr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 10:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235206AbiDFOfY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:35:24 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D38329261;
        Tue,  5 Apr 2022 19:53:37 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KY8DN2BWCzgYF8;
        Wed,  6 Apr 2022 10:51:48 +0800 (CST)
Received: from huawei.com (10.67.174.53) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 6 Apr
 2022 10:53:31 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <mcgrof@kernel.org>, <keescook@chromium.org>, <yzaikin@google.com>,
        <liaochang1@huawei.com>, <tglx@linutronix.de>, <clg@kaod.org>,
        <nitesh@redhat.com>, <edumazet@google.com>, <peterz@infradead.org>,
        <joshdon@google.com>, <masahiroy@kernel.org>, <nathan@kernel.org>,
        <akpm@linux-foundation.org>, <vbabka@suse.cz>,
        <gustavoars@kernel.org>, <arnd@arndb.de>, <chris@chrisdown.name>,
        <dmitry.torokhov@gmail.com>, <linux@rasmusvillemoes.dk>,
        <daniel@iogearbox.net>, <john.ogness@linutronix.de>,
        <will@kernel.org>, <dave@stgolabs.net>, <frederic@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <heying24@huawei.com>, <guohanjun@huawei.com>,
        <weiyongjun1@huawei.com>
Subject: [RFC 2/3] softirq: Do throttling when softirqs use up its bandwidth
Date:   Wed, 6 Apr 2022 10:52:40 +0800
Message-ID: <20220406025241.191300-3-liaochang1@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220406025241.191300-1-liaochang1@huawei.com>
References: <20220406025241.191300-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.53]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

When kernel is about to handle pending softirqs, it will check firstly
whether softirq already use up its CPU bandwidth, Once the total duration
of softirq handling exceed the max value in the user-specified time window,
softirq will be throttled for a while, the throttling will be removed
when time window expires.

On then other hand, kernel will update the runtime of softirq on given CPU
before __do_softirq() function returns.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 kernel/softirq.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 8aac9e2631fd..6de6db794ac5 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -75,6 +75,49 @@ struct softirq_throttle {
 	raw_spinlock_t lock;
 } si_throttle;
 
+struct softirq_runtime {
+	bool	throttled;
+	unsigned long	duration;
+	unsigned long	expires;
+	raw_spinlock_t lock;
+};
+static DEFINE_PER_CPU(struct softirq_runtime, softirq_runtime);
+
+static void forward_softirq_expires(struct softirq_runtime *si_runtime)
+{
+	si_runtime->throttled = false;
+	si_runtime->duration = 0UL;
+	si_runtime->expires = jiffies +
+		msecs_to_jiffies(si_throttle.period - si_throttle.runtime);
+}
+
+static void update_softirq_runtime(unsigned long duration)
+{
+	struct softirq_runtime *si_runtime = this_cpu_ptr(&softirq_runtime);
+
+	raw_spin_lock(&si_runtime->lock);
+	si_runtime->duration += jiffies_to_msecs(duration);
+	if ((si_runtime->duration >= si_throttle.runtime) &&
+		time_before(jiffies, si_runtime->expires)) {
+		si_runtime->throttled = true;
+	}
+	raw_spin_unlock(&si_runtime->lock);
+}
+
+static bool softirq_runtime_exceeded(void)
+{
+	struct softirq_runtime *si_runtime = this_cpu_ptr(&softirq_runtime);
+
+	if ((unsigned int)si_throttle.runtime >= si_throttle.period)
+		return false;
+
+	raw_spin_lock(&si_runtime->lock);
+	if (!time_before(jiffies, si_runtime->expires))
+		forward_softirq_expires(si_runtime);
+	raw_spin_unlock(&si_runtime->lock);
+	return si_runtime->throttled;
+}
+
 static int softirq_throttle_validate(void)
 {
 	if (((int)sysctl_softirq_period_ms <= 0) ||
@@ -88,10 +131,18 @@ static int softirq_throttle_validate(void)
 static void softirq_throttle_update(void)
 {
 	unsigned long flags;
+	struct softirq_runtime *si_runtime;
 
 	raw_spin_lock_irqsave(&si_throttle.lock, flags);
 	si_throttle.period = sysctl_softirq_period_ms;
 	si_throttle.runtime = sysctl_softirq_runtime_ms;
+
+	for_each_possible_cpu(cpu, &) {
+		si_runtime = per_cpu_ptr(&softirq_runtime, cpu);
+		raw_spin_lock(&si_runtime->lock);
+		forward_softirq_expires(si_runtime);
+		raw_spin_unlock(&si_runtime->lock);
+	}
 	raw_spin_unlock_irqrestore(&si_throttle.lock, flags);
 }
 
@@ -129,9 +180,17 @@ int softirq_throttle_handler(struct ctl_table *table, int write, void *buffer,
 
 static void softirq_throttle_init(void)
 {
+	struct softirq_runtime *si_runtime;
+
 	si_throttle.period = sysctl_softirq_period_ms;
 	si_throttle.runtime = sysctl_softirq_runtime_ms;
 	raw_spin_lock_init(&si_throttle.lock);
+
+	for_each_possible_cpu(cpu) {
+		si_runtime = per_cpu_ptr(&softirq_runtime, cpu);
+		forward_softirq_expires(si_runtime);
+		raw_spin_lock_init(&si_runtime->lock);
+	}
 }
 #endif
 
@@ -592,6 +651,13 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	__u32 pending;
 	int softirq_bit;
 
+#ifdef CONFIG_SOFTIRQ_THROTTLE
+	bool exceeded = softirq_runtime_exceeded();
+
+	if (exceeded)
+		return;
+#endif
+
 	/*
 	 * Mask out PF_MEMALLOC as the current task context is borrowed for the
 	 * softirq. A softirq handled, such as network RX, might set PF_MEMALLOC
@@ -652,6 +718,10 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 		wakeup_softirqd();
 	}
 
+#ifdef CONFIG_SOFTIRQ_THROTTLE
+	update_softirq_runtime(jiffies - (end - MAX_SOFTIRQ_TIME));
+#endif
+
 	account_softirq_exit(current);
 	lockdep_softirq_end(in_hardirq);
 	softirq_handle_end();
-- 
2.17.1

