Return-Path: <linux-fsdevel+bounces-70237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421ADC93E45
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 14:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CDD33A6826
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 13:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A86A30FC13;
	Sat, 29 Nov 2025 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IzBK0S1X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3428E30CDA8;
	Sat, 29 Nov 2025 13:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764423375; cv=none; b=mw2F03TMCFGeSXBV9YpWgcrNS9h/l/rvtoF4GMt3KPEajrzprGVfjoeCktLCvnTcwBCO7sEaDnrD8ErRIbtGXvbW4DIosaibCv25i0HZMzRUsJfHBJeZ7b1WkWRmWrnBvxHaYs8aMWWVlvnJwPkp79+DujgEO4TQRJuIsE0G+Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764423375; c=relaxed/simple;
	bh=micc+xEzEL381zPw3gTwgCAuK2LwP6aZ9As3nlhRbrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e0ruUhvt24Dvi4TnDSbc5ovAwnyBaRqWy8Nn2Cj+3CAT9+KU6rfUaeuu9asX++v22itLU/seC7OZ98RT+BR+m8M98qajVTPcmT0/+03jhBzZHaPGR+8IAW4MeNSV2cv/y+BkpBf9WbIPSxQmLhhAbYfPHt5wlfqY7ycC8JaWRrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IzBK0S1X; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=M5
	rWN/vLWDh2GXYLf53Quw7X1DAeFbrpqNgo+s5zlic=; b=IzBK0S1XVt+kf79zhu
	8a1NOkwNppcpM52AGJeE5srKwVDhvZebdku2oPVSYViFHDQSlf+JzQc2YZ1G1oSM
	TbRyiZiR+Rw2xeVfYoN3V+ZC/1DFngP7Pzr+RlUVLY8x9D+7vT4uVMdn+WM8Meym
	L5P42Gn9H2oo8UG99hlmKNcvw=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAnRXeg9ipp3CIeFw--.27069S4;
	Sat, 29 Nov 2025 21:35:32 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: anna-maria@linutronix.de,
	frederic@kernel.org,
	mingo@kernel.org,
	tglx@linutronix.de,
	kuba@kernel.org
Cc: jackzxcui1989@163.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] timers/nohz: Avoid /proc/stat idle/iowait fluctuation when cpu hotplug
Date: Sat, 29 Nov 2025 21:35:26 +0800
Message-Id: <20251129133526.1460119-3-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251129133526.1460119-1-jackzxcui1989@163.com>
References: <20251129133526.1460119-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgAnRXeg9ipp3CIeFw--.27069S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ar15Gw1xCw1DCFy7GFyxGrg_yoW7Aw4Dpr
	W7KFyag3W8Ja4jkayxAF1DWFWY9rs3Gryagr97WrsayF1jyr48Grs5tasY9FyruFWkAr47
	Wa48Wry3Kr47Ka7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UbtxDUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbCwATL1Wkq9qRqEQAA3w

The idle and iowait statistics in /proc/stat are obtained through
get_idle_time and get_iowait_time. Assuming CONFIG_NO_HZ_COMMON is
enabled, when CPU is online, the idle and iowait values use the
idle_sleeptime and iowait_sleeptime statistics from tick_cpu_sched, but
use CPUTIME_IDLE and CPUTIME_IOWAIT items from kernel_cpustat when CPU
is offline. Although /proc/stat do not print statistics of offline CPU,
it still print aggregated statistics for all possible CPUs.
tick_cpu_sched and kernel_cpustat are maintained by different logic,
leading to a significant gap. The first line of the data below shows the
/proc/stat output when only one CPU remains after CPU offline, the second
line shows the /proc/stat output after all CPUs are brought back online:

cpu  2408558 2 916619 4275883 5403 123758 64685 0 0 0
cpu  2408588 2 916693 4200737 4184 123762 64686 0 0 0

Obviously, other values do not experience significant fluctuations, while
idle/iowait statistics show a substantial decrease, which make system CPU
monitoring troublesome.
Introduce get_cpu_idle_time_us_raw and get_cpu_iowait_time_us_raw, so that
/proc/stat logic can use them to get the last raw value of idle_sleeptime
and iowait_sleeptime from tick_cpu_sched without any calculation when CPU
is offline. It avoids /proc/stat idle/iowait fluctuation when cpu hotplug.

Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
---
 fs/proc/stat.c           |  4 ++++
 include/linux/tick.h     |  4 ++++
 kernel/time/tick-sched.c | 46 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 8b444e862..de13a2e1c 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -28,6 +28,8 @@ u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
 
 	if (cpu_online(cpu))
 		idle_usecs = get_cpu_idle_time_us(cpu, NULL);
+	else
+		idle_usecs = get_cpu_idle_time_us_raw(cpu);
 
 	if (idle_usecs == -1ULL)
 		/* !NO_HZ or cpu offline so we can rely on cpustat.idle */
@@ -44,6 +46,8 @@ static u64 get_iowait_time(struct kernel_cpustat *kcs, int cpu)
 
 	if (cpu_online(cpu))
 		iowait_usecs = get_cpu_iowait_time_us(cpu, NULL);
+	else
+		iowait_usecs = get_cpu_iowait_time_us_raw(cpu);
 
 	if (iowait_usecs == -1ULL)
 		/* !NO_HZ or cpu offline so we can rely on cpustat.iowait */
diff --git a/include/linux/tick.h b/include/linux/tick.h
index ac76ae9fa..bdd38d270 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -139,7 +139,9 @@ extern ktime_t tick_nohz_get_next_hrtimer(void);
 extern ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next);
 extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
 extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
+extern u64 get_cpu_idle_time_us_raw(int cpu);
 extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
+extern u64 get_cpu_iowait_time_us_raw(int cpu);
 #else /* !CONFIG_NO_HZ_COMMON */
 #define tick_nohz_enabled (0)
 static inline int tick_nohz_tick_stopped(void) { return 0; }
@@ -161,7 +163,9 @@ static inline ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
 	return *delta_next;
 }
 static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
+static inline u64 get_cpu_idle_time_us_raw(int cpu) { return -1; }
 static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
+static inline u64 get_cpu_iowait_time_us_raw(int cpu) { return -1; }
 #endif /* !CONFIG_NO_HZ_COMMON */
 
 /*
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 4d089b290..607fc22d4 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -829,6 +829,29 @@ u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)
 }
 EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
 
+/**
+ * get_cpu_idle_time_us_raw - get the raw total idle time of a CPU
+ * @cpu: CPU number to query
+ *
+ * Return the raw idle time (since boot) for a given CPU, in
+ * microseconds.
+ *
+ * This time is measured via accounting rather than sampling,
+ * and is as accurate as ktime_get() is.
+ *
+ * This function returns -1 if NOHZ is not enabled.
+ */
+u64 get_cpu_idle_time_us_raw(int cpu)
+{
+	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
+
+	if (!tick_nohz_active)
+		return -1;
+
+	return ktime_to_us(ts->idle_sleeptime);
+}
+EXPORT_SYMBOL_GPL(get_cpu_idle_time_us_raw);
+
 /**
  * get_cpu_iowait_time_us - get the total iowait time of a CPU
  * @cpu: CPU number to query
@@ -855,6 +878,29 @@ u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time)
 }
 EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
 
+/**
+ * get_cpu_iowait_time_us_raw - get the raw total iowait time of a CPU
+ * @cpu: CPU number to query
+ *
+ * Return the raw iowait time (since boot) for a given CPU, in
+ * microseconds.
+ *
+ * This time is measured via accounting rather than sampling,
+ * and is as accurate as ktime_get() is.
+ *
+ * This function returns -1 if NOHZ is not enabled.
+ */
+u64 get_cpu_iowait_time_us_raw(int cpu)
+{
+	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
+
+	if (!tick_nohz_active)
+		return -1;
+
+	return ktime_to_us(ts->iowait_sleeptime);
+}
+EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us_raw);
+
 static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
 {
 	hrtimer_cancel(&ts->sched_timer);
-- 
2.34.1


