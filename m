Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F6334F473
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 00:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbhC3Wol (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 18:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbhC3Wo1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 18:44:27 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E4EC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Mar 2021 15:44:24 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id cx5so9025594qvb.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Mar 2021 15:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yB9UXx4euC3dVXDwExAh5VQzx8TVjtxe2UHS0AN58TQ=;
        b=aQamFp1Zhjay23SpYkC7BS7c6FNQ6us330jhOYcr/0sFTHugimuYHz4PRTsH9VScit
         yVQQrU5ilvT8kk/DUwXONR/SqfUZ3Km+QcgP7KFTxTlzH2jKxOW4NbzWJyyfIuRbjxNh
         DsSOVQQLpwYHwrqwmB406grnXG13/rLzHLc9kirSpWVPNSMiUkkccjo+oB8w+M5BvCHF
         rq+97GQg+yMoPUD9Tq+rUmdVf+O+IF4oKBNpULufz8Aspbad5vGNI4rHsWvEmYC56Ttn
         f17CK3Q12VvkcbIg0wimMFqxEggg/TEcUTCoJgLs1V/TRdGv4lsxWtaYE/5XvzRiUtba
         dsjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yB9UXx4euC3dVXDwExAh5VQzx8TVjtxe2UHS0AN58TQ=;
        b=cLDccrGpoc9G8K1b9oPb+HBCHXrQkYCD9gnxYkREVlF6a4ktO6ph3rAR/Rq96Bctqp
         Du6rUIZHcaoZM3ihYgqHF8WqlfcVmIJsbrVSs66xUE24RZBaFX1S7OmdnlhGBoDnqA8F
         QJAN2+R8L88ZZxhFamPUXuhcJDs853ULzRM1yIuf1qPImKi2/+8/TbmE8ERXdg+81tNI
         XGXUk+SAOyAOEuqiU83RboLi/MGEoWSggpnGM45soqQGtYMchm+a11NxMFkdZFcmUu/j
         thPQ7C5wiy6pTz0REcbys7BgGmuB2LMO+JIOzs2gwi/17fd+QPgHJ6gll0Qp85d3Tgk+
         RYnA==
X-Gm-Message-State: AOAM531kX15VdkQ2feG7R5N7NY6Cg8phQN8w5TmUR4o/aNO6LUkzwnVP
        9sczMLgL1iWgtHy+lr9uYAgKq+zFlc3PdRJXhoinNw==
X-Google-Smtp-Source: ABdhPJxrPKTkhsCw0bpzF/F2wqfMm9+pMnRnbscf7NowWDBijWWeyXFgsd+ZYWkwK/YF9kZ1bhXKRJ1Gcl4UkYv6so4=
X-Received: by 2002:ad4:4ae6:: with SMTP id cp6mr196533qvb.43.1617144263775;
 Tue, 30 Mar 2021 15:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210323035706.572953-1-joshdon@google.com> <20210324112739.GO15768@suse.de>
 <CABk29Nv7qwWcn4nUe_cxH-pJnppUVjHan+f-iHc8hEyPJ37jxA@mail.gmail.com>
In-Reply-To: <CABk29Nv7qwWcn4nUe_cxH-pJnppUVjHan+f-iHc8hEyPJ37jxA@mail.gmail.com>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 30 Mar 2021 15:44:12 -0700
Message-ID: <CABk29NsQ21F3A6EPmCf+pJG7ojDFog9zD-ri8LO8OVW6sXeusQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched: Warn on long periods of pending need_resched
To:     Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Oleg Rombakh <olegrom@google.com>, linux-doc@vger.kernel.org,
        Paul Turner <pjt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Peter,

Since you've already pulled the need_resched warning patch into your
tree, I'm including just the diff based on that patch (in response to
Mel's comments) below. This should be squashed into the original
patch.

Thanks,
Josh

---
From 85796b4d299b1cf3f99bde154a356ce1061221b7 Mon Sep 17 00:00:00 2001
From: Josh Don <joshdon@google.com>
Date: Mon, 22 Mar 2021 20:57:06 -0700
Subject: [PATCH] fixup: sched: Warn on long periods of pending need_resched

---
 kernel/sched/core.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6fdf15eebc0d..c07a4c17205f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -61,17 +61,13 @@ const_debug unsigned int sysctl_sched_features =

 /*
  * Print a warning if need_resched is set for the given duration (if
- * resched_latency_warn_enabled is set).
+ * LATENCY_WARN is enabled).
  *
  * If sysctl_resched_latency_warn_once is set, only one warning will be shown
  * per boot.
- *
- * Resched latency will be ignored for the first resched_boot_quiet_sec, to
- * reduce false alarms.
  */
-int sysctl_resched_latency_warn_ms = 100;
-int sysctl_resched_latency_warn_once = 1;
-static const long resched_boot_quiet_sec = 600;
+__read_mostly int sysctl_resched_latency_warn_ms = 100;
+__read_mostly int sysctl_resched_latency_warn_once = 1;
 #endif /* CONFIG_SCHED_DEBUG */

 /*
@@ -4542,20 +4538,19 @@ unsigned long long task_sched_runtime(struct
task_struct *p)
 }

 #ifdef CONFIG_SCHED_DEBUG
-static u64 resched_latency_check(struct rq *rq)
+static u64 cpu_resched_latency(struct rq *rq)
 {
  int latency_warn_ms = READ_ONCE(sysctl_resched_latency_warn_ms);
- u64 need_resched_latency, now = rq_clock(rq);
+ u64 resched_latency, now = rq_clock(rq);
  static bool warned_once;

  if (sysctl_resched_latency_warn_once && warned_once)
  return 0;

- if (!need_resched() || WARN_ON_ONCE(latency_warn_ms < 2))
+ if (!need_resched() || !latency_warn_ms)
  return 0;

- /* Disable this warning for the first few mins after boot */
- if (now < resched_boot_quiet_sec * NSEC_PER_SEC)
+ if (system_state == SYSTEM_BOOTING)
  return 0;

  if (!rq->last_seen_need_resched_ns) {
@@ -4565,13 +4560,13 @@ static u64 resched_latency_check(struct rq *rq)
  }

  rq->ticks_without_resched++;
- need_resched_latency = now - rq->last_seen_need_resched_ns;
- if (need_resched_latency <= latency_warn_ms * NSEC_PER_MSEC)
+ resched_latency = now - rq->last_seen_need_resched_ns;
+ if (resched_latency <= latency_warn_ms * NSEC_PER_MSEC)
  return 0;

  warned_once = true;

- return need_resched_latency;
+ return resched_latency;
 }

 static int __init setup_resched_latency_warn_ms(char *str)
@@ -4588,7 +4583,7 @@ static int __init setup_resched_latency_warn_ms(char *str)
 }
 __setup("resched_latency_warn_ms=", setup_resched_latency_warn_ms);
 #else
-static inline u64 resched_latency_check(struct rq *rq) { return 0; }
+static inline u64 cpu_resched_latency(struct rq *rq) { return 0; }
 #endif /* CONFIG_SCHED_DEBUG */

 /*
@@ -4614,7 +4609,7 @@ void scheduler_tick(void)
  update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);
  curr->sched_class->task_tick(rq, curr, 0);
  if (sched_feat(LATENCY_WARN))
- resched_latency = resched_latency_check(rq);
+ resched_latency = cpu_resched_latency(rq);
  calc_global_load_tick(rq);

  rq_unlock(rq, &rf);
-- 
2.31.0.291.g576ba9dcdaf-goog
