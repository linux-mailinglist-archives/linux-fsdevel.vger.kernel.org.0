Return-Path: <linux-fsdevel+bounces-71042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD1ACB270D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 09:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C351530108B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 08:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB69302750;
	Wed, 10 Dec 2025 08:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LoXagogz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ACA3019BE;
	Wed, 10 Dec 2025 08:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765355543; cv=none; b=mWpJxLIo04a9a5TGa2L5w8o6Zo6bnog+M5DrGgtbbf5xwlFxCq4GoTaD7/l44PCs/hjxRmGLBLoYINMjFN48pVs12UqK6v/YrkryyrG98GFIUdn/dIO7t8GXKtqOHe7VNxwCi/axEH3tGP8SJLvo7nA30nIoaXLaW/J51PyRIhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765355543; c=relaxed/simple;
	bh=YwYzq3ZNgJH/DbQ6/+yRkGZryFuwx4rkEx2Vbp1saUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N04gxwpkvdiRnb1f1M0+/LmDCzOX0YoGWQpFqavXhEDNfxdZPT8RYbX55jJcbX8EIfXYoEeRbvdaJs6B799GY/sH/Rcqn9hZmxbw+rTTU0MtucepgK48LgedT1aOZyGTrmoMjugCwrXuyo2b7x6dmYnOWmN1A4hv1MaQWcw778g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LoXagogz; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=g7
	+gB9lI9GbOkdEhqySBIMfcFCIYM1iFQ1A6euL4do8=; b=LoXagogz0x8iX4Q4VN
	WJIMzCMTcdKY/QsE3ar3IwrB9qL4iWZea5T8G9ihVkuxUNj+QI7ku0oH/wgvLX+f
	doJtWdI0Z98Yr94fv0ULzHOcrf0O+HXIaMSGsIu4rdqEp70GtEv8f8D8dxWsEl8W
	vNvuteZ0lIeoSv1dFBELPgX0Y=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCnrLLpLzlpnhe8Aw--.6723S4;
	Wed, 10 Dec 2025 16:31:40 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: anna-maria@linutronix.de,
	frederic@kernel.org,
	mingo@kernel.org,
	tglx@linutronix.de,
	kuba@kernel.org
Cc: jackzxcui1989@163.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/2] timers/nohz: Avoid /proc/stat idle/iowait fluctuation when cpu hotplug
Date: Wed, 10 Dec 2025 16:31:35 +0800
Message-Id: <20251210083135.3993562-3-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251210083135.3993562-1-jackzxcui1989@163.com>
References: <20251210083135.3993562-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnrLLpLzlpnhe8Aw--.6723S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ar15Gw1xCw1DCFy7GFyxGrg_yoWxCF4rpF
	W7Kryaqr18tFyjkayxAw1DGFWYgrs5Jr9Ig397WrsayF4UZr48Grs5tr9Y9FyruFWkArW8
	Xa4rWFySkr47Ka7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRPxhLUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbCwA2vuWk5L+3KZAAA3n

The idle and iowait statistics in /proc/stat are obtained through
get_idle_time() and get_iowait_time(). Assuming CONFIG_NO_HZ_COMMON is
enabled, when CPU is online, the idle and iowait values use the
idle_sleeptime and iowait_sleeptime statistics from tick_cpu_sched, but
use CPUTIME_IDLE and CPUTIME_IOWAIT items from kernel_cpustat when CPU
is offline. Although /proc/stat do not print statistics of offline CPU,
it still print aggregated statistics of all possible CPUs.

tick_cpu_sched and kernel_cpustat are maintained by different logic,
leading to a significant gap. The first line of the data below shows the
/proc/stat output when only one CPU remains after CPU offline, the second
line shows the /proc/stat output after all CPUs are brought back online:

cpu  2408558 2 916619 4275883 5403 123758 64685 0 0 0
cpu  2408588 2 916693 4200737 4184 123762 64686 0 0 0

Obviously, other values do not experience significant fluctuations, while
idle/iowait statistics show a substantial decrease, which make system CPU
monitoring troublesome.

get_cpu_idle_time_us() calculates the latest cpu idle time based on
idle_entrytime and current time. When CPU is idle when offline, the value
return by get_cpu_idle_time_us() will continue to increase, which is
unexpected. get_cpu_iowait_time_us() has the similar calculation logic.
When CPU is in the iowait state when offline, the value return by
get_cpu_iowait_time_us() will continue to increase.

Introduce get_cpu_idle_time_us_offline() as the _offline variants of
get_cpu_idle_time_us(). get_cpu_idle_time_us_offline() just return the
same value of idle_sleeptime without any calculation. In this way,
/proc/stat logic can use it to get a correct CPU idle time, which remains
unchanged during CPU offline period. Also, the aggregated statistics of
all possible CPUs printed by /proc/stat will not experience significant
fluctuation when CPU hotplug.
So as the newly added get_cpu_iowait_time_us_offline().

Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
---
 fs/proc/stat.c           |  4 +++
 include/linux/tick.h     |  4 +++
 kernel/time/tick-sched.c | 54 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 8b444e862..9920e7bfc 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -28,6 +28,8 @@ u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
 
 	if (cpu_online(cpu))
 		idle_usecs = get_cpu_idle_time_us(cpu, NULL);
+	else
+		idle_usecs = get_cpu_idle_time_us_offline(cpu);
 
 	if (idle_usecs == -1ULL)
 		/* !NO_HZ or cpu offline so we can rely on cpustat.idle */
@@ -44,6 +46,8 @@ static u64 get_iowait_time(struct kernel_cpustat *kcs, int cpu)
 
 	if (cpu_online(cpu))
 		iowait_usecs = get_cpu_iowait_time_us(cpu, NULL);
+	else
+		iowait_usecs = get_cpu_iowait_time_us_offline(cpu);
 
 	if (iowait_usecs == -1ULL)
 		/* !NO_HZ or cpu offline so we can rely on cpustat.iowait */
diff --git a/include/linux/tick.h b/include/linux/tick.h
index ac76ae9fa..e5db27657 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -139,7 +139,9 @@ extern ktime_t tick_nohz_get_next_hrtimer(void);
 extern ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next);
 extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
 extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
+extern u64 get_cpu_idle_time_us_offline(int cpu);
 extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
+extern u64 get_cpu_iowait_time_us_offline(int cpu);
 #else /* !CONFIG_NO_HZ_COMMON */
 #define tick_nohz_enabled (0)
 static inline int tick_nohz_tick_stopped(void) { return 0; }
@@ -161,7 +163,9 @@ static inline ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
 	return *delta_next;
 }
 static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
+static inline u64 get_cpu_idle_time_us_offline(int cpu) { return -1; }
 static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
+static inline u64 get_cpu_iowait_time_us_offline(int cpu) { return -1; }
 #endif /* !CONFIG_NO_HZ_COMMON */
 
 /*
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 4d089b290..2cda08f94 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -829,6 +829,33 @@ u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)
 }
 EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
 
+/**
+ * get_cpu_idle_time_us_offline - get the total idle time of an offline CPU
+ * @cpu: CPU number to query
+ *
+ * Return the idle time (since boot) for a given offline CPU, in microseconds.
+ *
+ * This function does not calculate the latest idle time based on
+ * idle_entrytime and current time like get_cpu_idle_time_us() does.
+ * If get_cpu_idle_time_us() is used to obtain idle time of an offline CPU,
+ * its value will continue to increase, which is unexpected.
+ *
+ * This time is measured via accounting rather than sampling,
+ * and is as accurate as ktime_get() is.
+ *
+ * This function returns -1 if NOHZ is not enabled.
+ */
+u64 get_cpu_idle_time_us_offline(int cpu)
+{
+	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
+
+	if (!tick_nohz_active)
+		return -1;
+
+	return ktime_to_us(ts->idle_sleeptime);
+}
+EXPORT_SYMBOL_GPL(get_cpu_idle_time_us_offline);
+
 /**
  * get_cpu_iowait_time_us - get the total iowait time of a CPU
  * @cpu: CPU number to query
@@ -855,6 +882,33 @@ u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time)
 }
 EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
 
+/**
+ * get_cpu_iowait_time_us_offline - get the total iowait time of an offline CPU
+ * @cpu: CPU number to query
+ *
+ * Return the iowait time (since boot) for a given CPU, in microseconds.
+ *
+ * This function does not calculate the latest iowait time based on
+ * idle_entrytime and current time like get_cpu_iowait_time_us() does.
+ * If get_cpu_iowait_time_us is used to obtain iowait time of an offline CPU,
+ * its value will continue to increase, which is unexpected.
+ *
+ * This time is measured via accounting rather than sampling,
+ * and is as accurate as ktime_get() is.
+ *
+ * This function returns -1 if NOHZ is not enabled.
+ */
+u64 get_cpu_iowait_time_us_offline(int cpu)
+{
+	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
+
+	if (!tick_nohz_active)
+		return -1;
+
+	return ktime_to_us(ts->iowait_sleeptime);
+}
+EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us_offline);
+
 static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
 {
 	hrtimer_cancel(&ts->sched_timer);
-- 
2.34.1


