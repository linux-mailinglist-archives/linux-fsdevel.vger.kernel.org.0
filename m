Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310BA293FD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Oct 2020 17:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436763AbgJTPpK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 11:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436743AbgJTPpJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 11:45:09 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E164C061755;
        Tue, 20 Oct 2020 08:45:08 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d3so2449955wma.4;
        Tue, 20 Oct 2020 08:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9JWcw8hODuoK9CFrfdzCcqj6AmzzPAq3wC79+nVDeMI=;
        b=o2QFgXtn+p1np1aVT7zzRbaf2Frr1SjzIjrPZwg1+9ZtUGgiiIjPYRqe7xwKdzs4yi
         yDHjczRuoLIP+Iuv/gEEMJwmPXsnjLFR2BEbEHiqXPz71cTBHz5xYgrK8XfqF6aNrxvP
         P0AsmLGOYay+YjrHNhEbXcmyBD11Vsp6xTHHkwS34osFqauohLc2nGE2ynBjrBlvhSK/
         6WDxm8kgmQ7mk5pSS2hyndQz5w4T59lpa8GISmzmo8GSzahe4qM4b++vEdQXsmdARD+H
         +5zGs9qY38C9ceHYgXaKunniWy19Aq+4vo2oJtD+KTBtkGkeuVRbr4vcj2o4wlmDpmqS
         OCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9JWcw8hODuoK9CFrfdzCcqj6AmzzPAq3wC79+nVDeMI=;
        b=IdzYPCit2SDWTP0+DX2C10cqXmxdpL+2UCPfVLV8GWxHnTlDL4GnlCgde9eSMZf2zu
         Oh+aSBdyYZnTkrPFAylb1/ruEM4lltiQnLg99GbIHARz9lnJyy7TzUm5XRMjEJEL+5JS
         PHdpi4uGtWInTPCZuAEgh/u7WvwbAiT1Xuu+GbL9iFPHlWQYfXyH1Tn9y3BsS2RIMq4j
         k0y7wuY8rP6e9LpWdalEhx7cjJXXLwp/Z9H7y5SrhGFYzogv67YMPs/AUDGgH61f2aXG
         xFhWaw42wHXfjErYxrV38x19CH5qTI0Rw9atIAIpW7iaXz+6IFZRW7x/eVu8+uP20ttY
         kY4Q==
X-Gm-Message-State: AOAM532Elw38SnGzAWz4UyV7WcEQ4n5/tVz/fz2BaB0S48boiVvi5Fh6
        IN63Rwg0OmHmJVfxcatjHgs=
X-Google-Smtp-Source: ABdhPJxJbMY6a7HmBwAtdexJV4WfZiaJ4FZ523l2FgqiR2pbrz1XKZ0TG5lnq0ueY115RLEct5o9fw==
X-Received: by 2002:a1c:48c3:: with SMTP id v186mr3873408wma.16.1603208707186;
        Tue, 20 Oct 2020 08:45:07 -0700 (PDT)
Received: from stormsend.lip6.fr (dell-redha.rsr.lip6.fr. [132.227.76.3])
        by smtp.googlemail.com with ESMTPSA id y21sm3070464wma.19.2020.10.20.08.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 08:45:06 -0700 (PDT)
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
        Andrew Morton <akpm@linux-foundation.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] sched: core: x86: query frequency at each tick
Date:   Tue, 20 Oct 2020 17:44:40 +0200
Message-Id: <20201020154445.119701-3-redha.gouicem@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020154445.119701-1-redha.gouicem@gmail.com>
References: <20201020154445.119701-1-redha.gouicem@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Query the current frequency of the core during the scheduler tick.
The scheduler subsystem maintains its own copies of the aperf/mperf
structure because it will query the frequency more frequently than what
the cpufreq subsystem does. This can lead to inaccurate measurements,
but it is not problematic here.

Co-developed-by: Damien Carver <carverdamien@gmail.com>
Signed-off-by: Damien Carver <carverdamien@gmail.com>
Signed-off-by: Redha Gouicem <redha.gouicem@gmail.com>
---
 kernel/sched/core.c  | 11 +++++++++++
 kernel/sched/sched.h |  4 ++++
 2 files changed, 15 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c36dc1ae58be..d6d27a6fc23c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3976,6 +3976,15 @@ unsigned long long task_sched_runtime(struct task_struct *p)
 	return ns;
 }
 
+struct freq_sample {
+	unsigned int  khz;
+	ktime_t       time;
+	u64           aperf;
+	u64           mperf;
+};
+
+DEFINE_PER_CPU(struct freq_sample, freq_sample);
+
 /*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
@@ -3996,6 +4005,8 @@ void scheduler_tick(void)
 	update_rq_clock(rq);
 	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
 	update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);
+	rq->freq = arch_freq_get_on_cpu_from_sample(cpu,
+						    this_cpu_ptr(&freq_sample));
 	curr->sched_class->task_tick(rq, curr, 0);
 	calc_global_load_tick(rq);
 	psi_task_tick(rq);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 28709f6b0975..7d794ab756d2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1048,6 +1048,10 @@ struct rq {
 	/* Must be inspected within a rcu lock section */
 	struct cpuidle_state	*idle_state;
 #endif
+
+	/* Frequency measured at the last tick */
+	unsigned int            freq;
+
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-- 
2.28.0

