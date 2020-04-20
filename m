Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C87A1B17BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 22:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgDTU6R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 16:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgDTU6P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:58:15 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7A4C061A0C;
        Mon, 20 Apr 2020 13:58:15 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y24so1162304wma.4;
        Mon, 20 Apr 2020 13:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U5Mw2Gn8Zex9o2S2OWU4g0cRW7usOZWhXhWDpzM3Yks=;
        b=EyjGi1MdMsrY/J09SPR9x6f/VkBFX75NOEME9aaacw9sdhsnUFwQ2lmdNwey9/e2c1
         cf3y6Plf7up8qK5hsDOsnduTvLpVPSZjs/USWzVmfvLYwaV/LdrYhrGy3bZDQqseO58x
         AhROTmEJdYgnCPOSNfkzZrPYOug05qN/Cs9l6G2dR1Q8/U/3b6lTL42YeJS/w+EZSjGQ
         bs2sWQ72mJrqu0vFulA8jVFDaBdGktaWBhzIl26UJ8FvBBKeLdYhvGfwS9fOEtdjuy0C
         W6KqJ9PKapfnQlXcghoB7gVwv1c7/uqhOvu9aGdDlcNke2NnL8F/WoPKqxAlhBBAeGmp
         TXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U5Mw2Gn8Zex9o2S2OWU4g0cRW7usOZWhXhWDpzM3Yks=;
        b=dvLYIs84G6A8c/RTrmaMANl7tJy+TQaJW08YWj99MrwA/YwycTZ2O49fawoBK9RKer
         aH3Hb67K3nx0hSArJBM+g4Irm6YoSlP6F+bTg9QNfTT1Lk14qowUYz9mbAI4an/jjgD4
         W+VlZses63STd19gq08zHw2ZYFSNhxf2Wv0WrWSfZAjOEdP0BBOU86CDdoCydlFjCSE8
         hSaT+g3lSlEqQdzak4avdS5qfg5fLM+fVeapze4vaBAIpoezkMPorWDyws5USpCTpEXM
         Ox9Iv5vLICUaDajnN62tmxLpOp4K+Q/coWuIOovAf6T29uiEDxt0/yHCi5ivDaeLVa1K
         KflQ==
X-Gm-Message-State: AGi0PuZXLlZ02nIF61eXIb/zryFa33ouHCAvveIbYgz0qM8+jCOB/c9Z
        VdEQNzO4uM92d5i/E7zovg==
X-Google-Smtp-Source: APiQypJyCau5pgv5D+BgpIaCtjKGDgqSZW3B/V+VAngdDi5DV68Sr5KboE2OIxifqmpronMR33UdLw==
X-Received: by 2002:a1c:990d:: with SMTP id b13mr1210582wme.179.1587416294094;
        Mon, 20 Apr 2020 13:58:14 -0700 (PDT)
Received: from avx2.telecom.by ([46.53.249.74])
        by smtp.gmail.com with ESMTPSA id m8sm863069wrx.54.2020.04.20.13.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 13:58:13 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     adobriyan@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk
Subject: [PATCH 07/15] print_integer, proc: rewrite /proc/stat via print_integer()
Date:   Mon, 20 Apr 2020 23:57:35 +0300
Message-Id: <20200420205743.19964-7-adobriyan@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200420205743.19964-1-adobriyan@gmail.com>
References: <20200420205743.19964-1-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/stat.c | 136 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 83 insertions(+), 53 deletions(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 678feb7b9949..859dc49cca85 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -14,6 +14,8 @@
 #include <linux/sched/cputime.h>
 #include <linux/tick.h>
 
+#include "../../lib/print-integer.h"
+
 #ifndef arch_irq_stat_cpu
 #define arch_irq_stat_cpu(cpu) 0
 #endif
@@ -104,19 +106,30 @@ static void show_all_irqs(struct seq_file *p)
 	show_irq_gap(p, nr_irqs - next);
 }
 
+enum {
+	USER,
+	NICE,
+	SYSTEM,
+	IDLE,
+	IOWAIT,
+	IRQ,
+	SOFTIRQ,
+	STEAL,
+	GUEST,
+	GUEST_NICE,
+
+	NR_VAL
+};
+
 static int show_stat(struct seq_file *p, void *v)
 {
+	u64 val[NR_VAL] = {};
 	int i, j;
-	u64 user, nice, system, idle, iowait, irq, softirq, steal;
-	u64 guest, guest_nice;
 	u64 sum = 0;
 	u64 sum_softirq = 0;
 	unsigned int per_softirq_sums[NR_SOFTIRQS] = {0};
 	struct timespec64 boottime;
 
-	user = nice = system = idle = iowait =
-		irq = softirq = steal = 0;
-	guest = guest_nice = 0;
 	getboottime64(&boottime);
 
 	for_each_possible_cpu(i) {
@@ -125,16 +138,16 @@ static int show_stat(struct seq_file *p, void *v)
 
 		kcpustat_cpu_fetch(&kcpustat, i);
 
-		user		+= cpustat[CPUTIME_USER];
-		nice		+= cpustat[CPUTIME_NICE];
-		system		+= cpustat[CPUTIME_SYSTEM];
-		idle		+= get_idle_time(&kcpustat, i);
-		iowait		+= get_iowait_time(&kcpustat, i);
-		irq		+= cpustat[CPUTIME_IRQ];
-		softirq		+= cpustat[CPUTIME_SOFTIRQ];
-		steal		+= cpustat[CPUTIME_STEAL];
-		guest		+= cpustat[CPUTIME_GUEST];
-		guest_nice	+= cpustat[CPUTIME_GUEST_NICE];
+		val[USER]	+= cpustat[CPUTIME_USER];
+		val[NICE]	+= cpustat[CPUTIME_NICE];
+		val[SYSTEM]	+= cpustat[CPUTIME_SYSTEM];
+		val[IDLE]	+= get_idle_time(&kcpustat, i);
+		val[IOWAIT]	+= get_iowait_time(&kcpustat, i);
+		val[IRQ]	+= cpustat[CPUTIME_IRQ];
+		val[SOFTIRQ]	+= cpustat[CPUTIME_SOFTIRQ];
+		val[STEAL]	+= cpustat[CPUTIME_STEAL];
+		val[GUEST]	+= cpustat[CPUTIME_GUEST];
+		val[GUEST_NICE]	+= cpustat[CPUTIME_GUEST_NICE];
 		sum		+= kstat_cpu_irqs_sum(i);
 		sum		+= arch_irq_stat_cpu(i);
 
@@ -147,47 +160,55 @@ static int show_stat(struct seq_file *p, void *v)
 	}
 	sum += arch_irq_stat();
 
-	seq_put_decimal_ull(p, "cpu  ", nsec_to_clock_t(user));
-	seq_put_decimal_ull(p, " ", nsec_to_clock_t(nice));
-	seq_put_decimal_ull(p, " ", nsec_to_clock_t(system));
-	seq_put_decimal_ull(p, " ", nsec_to_clock_t(idle));
-	seq_put_decimal_ull(p, " ", nsec_to_clock_t(iowait));
-	seq_put_decimal_ull(p, " ", nsec_to_clock_t(irq));
-	seq_put_decimal_ull(p, " ", nsec_to_clock_t(softirq));
-	seq_put_decimal_ull(p, " ", nsec_to_clock_t(steal));
-	seq_put_decimal_ull(p, " ", nsec_to_clock_t(guest));
-	seq_put_decimal_ull(p, " ", nsec_to_clock_t(guest_nice));
-	seq_putc(p, '\n');
+	{
+		char buf[4 + NR_VAL * (1 + 20) + 1];
+		char *q = buf + sizeof(buf);
+
+		*--q = '\n';
+		for (i = NR_VAL - 1; i >= 0; i--) {
+			q = _print_integer_u64(q, nsec_to_clock_t(val[i]));
+			*--q = ' ';
+		}
+		q = memcpy(q - 4, "cpu ", 4);
+
+		seq_write(p, q, buf + sizeof(buf) - q);
+	}
 
 	for_each_online_cpu(i) {
 		struct kernel_cpustat kcpustat;
 		u64 *cpustat = kcpustat.cpustat;
+		char buf[3 + 10 + NR_VAL * (1 + 20) + 1];
+		char *q = buf + sizeof(buf);
 
 		kcpustat_cpu_fetch(&kcpustat, i);
 
-		/* Copy values here to work around gcc-2.95.3, gcc-2.96 */
-		user		= cpustat[CPUTIME_USER];
-		nice		= cpustat[CPUTIME_NICE];
-		system		= cpustat[CPUTIME_SYSTEM];
-		idle		= get_idle_time(&kcpustat, i);
-		iowait		= get_iowait_time(&kcpustat, i);
-		irq		= cpustat[CPUTIME_IRQ];
-		softirq		= cpustat[CPUTIME_SOFTIRQ];
-		steal		= cpustat[CPUTIME_STEAL];
-		guest		= cpustat[CPUTIME_GUEST];
-		guest_nice	= cpustat[CPUTIME_GUEST_NICE];
-		seq_printf(p, "cpu%d", i);
-		seq_put_decimal_ull(p, " ", nsec_to_clock_t(user));
-		seq_put_decimal_ull(p, " ", nsec_to_clock_t(nice));
-		seq_put_decimal_ull(p, " ", nsec_to_clock_t(system));
-		seq_put_decimal_ull(p, " ", nsec_to_clock_t(idle));
-		seq_put_decimal_ull(p, " ", nsec_to_clock_t(iowait));
-		seq_put_decimal_ull(p, " ", nsec_to_clock_t(irq));
-		seq_put_decimal_ull(p, " ", nsec_to_clock_t(softirq));
-		seq_put_decimal_ull(p, " ", nsec_to_clock_t(steal));
-		seq_put_decimal_ull(p, " ", nsec_to_clock_t(guest));
-		seq_put_decimal_ull(p, " ", nsec_to_clock_t(guest_nice));
-		seq_putc(p, '\n');
+		*--q = '\n';
+		q = _print_integer_u64(q, nsec_to_clock_t(cpustat[CPUTIME_GUEST_NICE]));
+		*--q = ' ';
+		q = _print_integer_u64(q, nsec_to_clock_t(cpustat[CPUTIME_GUEST]));
+		*--q = ' ';
+		q = _print_integer_u64(q, nsec_to_clock_t(cpustat[CPUTIME_STEAL]));
+		*--q = ' ';
+		q = _print_integer_u64(q, nsec_to_clock_t(cpustat[CPUTIME_SOFTIRQ]));
+		*--q = ' ';
+		q = _print_integer_u64(q, nsec_to_clock_t(cpustat[CPUTIME_IRQ]));
+		*--q = ' ';
+		q = _print_integer_u64(q, nsec_to_clock_t(cpustat[CPUTIME_IRQ]));
+		*--q = ' ';
+		q = _print_integer_u64(q, nsec_to_clock_t(get_iowait_time(&kcpustat, i)));
+		*--q = ' ';
+		q = _print_integer_u64(q, nsec_to_clock_t(get_idle_time(&kcpustat, i)));
+		*--q = ' ';
+		q = _print_integer_u64(q, nsec_to_clock_t(cpustat[CPUTIME_SYSTEM]));
+		*--q = ' ';
+		q = _print_integer_u64(q, nsec_to_clock_t(cpustat[CPUTIME_NICE]));
+		*--q = ' ';
+		q = _print_integer_u64(q, nsec_to_clock_t(cpustat[CPUTIME_USER]));
+		*--q = ' ';
+		q = _print_integer_u32(q, i);
+		q = memcpy(q - 3, "cpu", 3);
+
+		seq_write(p, q, buf + sizeof(buf) - q);
 	}
 	seq_put_decimal_ull(p, "intr ", (unsigned long long)sum);
 
@@ -205,11 +226,20 @@ static int show_stat(struct seq_file *p, void *v)
 		nr_running(),
 		nr_iowait());
 
-	seq_put_decimal_ull(p, "softirq ", (unsigned long long)sum_softirq);
+	{
+		char buf[8 + 20 + (1 + 10) * NR_SOFTIRQS + 1];
+		char *q = buf + sizeof(buf);
 
-	for (i = 0; i < NR_SOFTIRQS; i++)
-		seq_put_decimal_ull(p, " ", per_softirq_sums[i]);
-	seq_putc(p, '\n');
+		*--q = '\n';
+		for (i = NR_SOFTIRQS - 1; i >= 0; i--) {
+			q = _print_integer_u32(q, per_softirq_sums[i]);
+			*--q = ' ';
+		}
+		q = _print_integer_u64(q, sum_softirq);
+		q = memcpy(q - 8, "softirq ", 8);
+
+		seq_write(p, q, buf + sizeof(buf) - q);
+	}
 
 	return 0;
 }
-- 
2.24.1

