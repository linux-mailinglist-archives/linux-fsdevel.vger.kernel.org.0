Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85103293FD2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Oct 2020 17:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436748AbgJTPpF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 11:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436743AbgJTPpF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 11:45:05 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3B5C061755;
        Tue, 20 Oct 2020 08:45:03 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 13so2291783wmf.0;
        Tue, 20 Oct 2020 08:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0MEzLA4ps4DnbBY/k9ap4B4wApccT4YDXE6Yuya3wrU=;
        b=EPr9vdgXoMBAOmTLMIa+/gA1zkqZHPaEdP3AFG0yLxEVUzPeaHwZY4rKWNF5tf270v
         ddzdKUzfOgbM0ZHwQs0iSJYW6p44RTkG9FEUuDeXx0fCvqcV5/34kxzrZHPWcTYJohFT
         O/+WZAxw8banZ6ua/IsVQBRpBdPyKh7/fK6Ysoo0XF5rsUI0JP4cubtCzz/0rB1vOqeE
         +aAJLYuIpMW0EmVtEamCdlQRivxsJ8/87WWp782LCd3yNqAkEbxaah4eAbPFBt8p+aDZ
         M1mk+VlBYnEPSRJ8bpSpVWERMMGvFJ20CQ9+bSnckQgOcQfzWJFafJNBooY/xqf1mriz
         x19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0MEzLA4ps4DnbBY/k9ap4B4wApccT4YDXE6Yuya3wrU=;
        b=AH+M7iEtuvZc+I2tw9er7EdV8nHwZUQhtEkxLbYhaM14vc8KSbhRWy55zPNYasamcj
         PQPIEYI370ua7y/OrLi4bmFPIXmV/KcCkx63sRfpvinR9I/7aP8fm967NJGG+KsaT6iH
         6QChmiG9HyiHJea6s6TASnsADOw7QRV78ZWs3q/89aHoKGHeQtwAPsHelVKyY3FeR+qF
         v/jS43tGP3xmjCz9e6hgdhMzfUHs+/gB4dHtkBwDU6q6NS7N22n8TsVEgojaPu6KpIqE
         ZvgBiMMbQv7RFhhGvVrGvQmtaPBgM/RDxcD65u3mPfNiQ7Q3IXNiCoS4UC2ilvOPKDvF
         /oMQ==
X-Gm-Message-State: AOAM530BzvnLxf3dbCSf40ARRuQ4uY35X+xKZwzuvlI2xFvx89Uu3LXJ
        crqPb5yMMCTo5flG/0onvro=
X-Google-Smtp-Source: ABdhPJwISNFUaFdP9X2T5hYgzriznkIbMrVdXqhZFdWDWErPzBAj2PAbI9UsHFB8MPGI5rcb3Ggnhg==
X-Received: by 2002:a05:600c:2302:: with SMTP id 2mr3533803wmo.111.1603208702259;
        Tue, 20 Oct 2020 08:45:02 -0700 (PDT)
Received: from stormsend.lip6.fr (dell-redha.rsr.lip6.fr. [132.227.76.3])
        by smtp.googlemail.com with ESMTPSA id y21sm3070464wma.19.2020.10.20.08.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 08:45:01 -0700 (PDT)
From:   Redha Gouicem <redha.gouicem@gmail.com>
Cc:     julien.sopena@lip6.fr, julia.lawall@inria.fr,
        gilles.muller@inria.fr, carverdamien@gmail.com,
        jean-pierre.lozi@oracle.com, baptiste.lepers@sydney.edu.au,
        nicolas.palix@univ-grenoble-alpes.fr,
        willy.zwaenepoel@sydney.edu.au,
        Redha Gouicem <redha.gouicem@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/3] cpufreq: x86: allow external frequency measures
Date:   Tue, 20 Oct 2020 17:44:39 +0200
Message-Id: <20201020154445.119701-2-redha.gouicem@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020154445.119701-1-redha.gouicem@gmail.com>
References: <20201020154445.119701-1-redha.gouicem@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow other subsystems to query the current frequency from the CPU without
affecting the cached value of cpufreq. The subsystems doing this will need
to maintain their own version of struct aperfmperf_sample.

This is useful if you need to query frequency more frequently than
APERFMPERF_CACHE_THRESHOLD_MS but don't want to mess with the current
caching behavior.

Even though querying too frequently may render the measures inaccurate, it
is still useful if your subsystem tolerates this inaccuracy.

Co-developed-by: Damien Carver <carverdamien@gmail.com>
Signed-off-by: Damien Carver <carverdamien@gmail.com>
Signed-off-by: Redha Gouicem <redha.gouicem@gmail.com>
---
 arch/x86/kernel/cpu/aperfmperf.c | 31 +++++++++++++++++++++++++++----
 drivers/cpufreq/cpufreq.c        |  5 +++++
 include/linux/cpufreq.h          |  1 +
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index e2f319dc992d..c3be81d689f4 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -36,11 +36,11 @@ static DEFINE_PER_CPU(struct aperfmperf_sample, samples);
  * unless we already did it within 10ms
  * calculate kHz, save snapshot
  */
-static void aperfmperf_snapshot_khz(void *dummy)
+static void aperfmperf_snapshot_khz(void *prev_sample)
 {
 	u64 aperf, aperf_delta;
 	u64 mperf, mperf_delta;
-	struct aperfmperf_sample *s = this_cpu_ptr(&samples);
+	struct aperfmperf_sample *s = prev_sample;
 	unsigned long flags;
 
 	local_irq_save(flags);
@@ -72,7 +72,8 @@ static bool aperfmperf_snapshot_cpu(int cpu, ktime_t now, bool wait)
 	if (time_delta < APERFMPERF_CACHE_THRESHOLD_MS)
 		return true;
 
-	smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, wait);
+	smp_call_function_single(cpu, aperfmperf_snapshot_khz,
+				 per_cpu_ptr(&samples, cpu), wait);
 
 	/* Return false if the previous iteration was too long ago. */
 	return time_delta <= APERFMPERF_STALE_THRESHOLD_MS;
@@ -131,7 +132,29 @@ unsigned int arch_freq_get_on_cpu(int cpu)
 		return per_cpu(samples.khz, cpu);
 
 	msleep(APERFMPERF_REFRESH_DELAY_MS);
-	smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, 1);
+	smp_call_function_single(cpu, aperfmperf_snapshot_khz,
+				 per_cpu_ptr(&samples, cpu), 1);
 
 	return per_cpu(samples.khz, cpu);
 }
+
+unsigned int arch_freq_get_on_cpu_from_sample(int cpu, void *sample)
+{
+	struct aperfmperf_sample *s = sample;
+
+	if (!sample)
+		return 0;
+
+	if (!cpu_khz)
+		return 0;
+
+	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
+		return 0;
+
+	if (!housekeeping_cpu(cpu, HK_FLAG_MISC))
+		return 0;
+
+	smp_call_function_single(cpu, aperfmperf_snapshot_khz, s, 1);
+
+	return s->khz;
+}
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 02ab56b2a0d8..36e6dbd87317 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -695,6 +695,11 @@ __weak unsigned int arch_freq_get_on_cpu(int cpu)
 	return 0;
 }
 
+__weak unsigned int arch_freq_get_on_cpu_from_sample(int cpu, void *sample)
+{
+	return 0;
+}
+
 static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
 {
 	ssize_t ret;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 8f141d4c859c..129083684ca0 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1005,6 +1005,7 @@ static inline void sched_cpufreq_governor_change(struct cpufreq_policy *policy,
 
 extern void arch_freq_prepare_all(void);
 extern unsigned int arch_freq_get_on_cpu(int cpu);
+extern unsigned int arch_freq_get_on_cpu_from_sample(int cpu, void *sample);
 
 extern void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
 				unsigned long max_freq);
-- 
2.28.0

