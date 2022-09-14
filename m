Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67ECA5B7EB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 03:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiINBxd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 21:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiINBxa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 21:53:30 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6B16CF53
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Sep 2022 18:53:29 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id b21so13643827plz.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Sep 2022 18:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=RtBmjBNUZvS0RgMzRUDGO5THvzbS2zrx//6TWP3NPXc=;
        b=qAnqAw8/L7vDPOoX7d4dRwgEvkS5SqRkYNqZSxJzz/qOBiv6K6P9XOAk1jnb8w9pYv
         KcIVfxw1mdCmuvEYLVXJepszcF0735Uh1tIsQb59ZMTgp6/vivSpLmBi9FK7btWO089e
         iATQ9exm0Wy9DdTte8mp+oy3Colw83lsiXrG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=RtBmjBNUZvS0RgMzRUDGO5THvzbS2zrx//6TWP3NPXc=;
        b=U+fuzue8PjU1Nt33bdHP0KxMnDJ8GaUDpL5lrvgFo+rQ9J7KS7f4emIK3fFERWa3kA
         vz5l3dXkMxOiW14jiuMCMrUiYw8M0TzA010dEiz1UHq59CUOJq/yxAEcaKs1GCb2Zsa5
         /O/Vg5TUQRU6/W80L7EIG5Z9BpGo4mECQX73i4uTODkitAq3LPgwU8I9NrT2rSWJP/0D
         ph4AkRpwvB48owfVWJnbFqmW5SaHlv0gAq6CBSw6omJk807mOtgg3Vub8EIPiGIOcX0e
         quoxCI0HA2eIGprnQVMZw60pvb0Pp214S9thN6fjLc+vGD3TAs9HWzO/mRUon8sZhgQV
         RNtA==
X-Gm-Message-State: ACrzQf1tl9CTi92xJiGcFvxzwMU+XnH5X0/IC1J6AL7kcnwMmpv6EG2D
        x2vPswJcdYTXsDa8obMqQ3mkEw==
X-Google-Smtp-Source: AMsMyM6Su9yxFun7Jkm9+A/9QsApEWdfEMuQb4mxhuBiJWsJasvWOG2MtZ2+7066YGuhgR0KaxNDCQ==
X-Received: by 2002:a17:90b:384b:b0:200:3215:878b with SMTP id nl11-20020a17090b384b00b002003215878bmr2152164pjb.176.1663120409407;
        Tue, 13 Sep 2022 18:53:29 -0700 (PDT)
Received: from localhost.localdomain (c-73-223-190-181.hsd1.ca.comcast.net. [73.223.190.181])
        by smtp.gmail.com with ESMTPSA id w189-20020a627bc6000000b0053e61633057sm8524481pfc.132.2022.09.13.18.53.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Sep 2022 18:53:29 -0700 (PDT)
From:   Joe Damato <jdamato@fastly.com>
To:     x86@kernel.org, linux-mm@kvack.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Joe Damato <jdamato@fastly.com>
Subject: [RFC 1/1] mm: Add per-task struct tlb counters
Date:   Tue, 13 Sep 2022 18:51:09 -0700
Message-Id: <1663120270-2673-2-git-send-email-jdamato@fastly.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1663120270-2673-1-git-send-email-jdamato@fastly.com>
References: <1663120270-2673-1-git-send-email-jdamato@fastly.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TLB shootdowns are tracked globally, but on a busy system it can be
difficult to disambiguate the source of TLB shootdowns.

Add two counter fields:
	- nrtlbflush: number of tlb flush events received
	- ngtlbflush: number of tlb flush events generated

Expose those fields in /proc/[pid]/stat so that they can be analyzed
alongside similar metrics (e.g. min_flt and maj_flt).

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 arch/x86/mm/tlb.c            | 2 ++
 fs/proc/array.c              | 9 +++++++++
 include/linux/sched.h        | 6 ++++++
 include/linux/sched/signal.h | 1 +
 kernel/exit.c                | 6 ++++++
 kernel/fork.c                | 1 +
 6 files changed, 25 insertions(+)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index c1e31e9..58f7c59 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -745,6 +745,7 @@ static void flush_tlb_func(void *info)
 	if (!local) {
 		inc_irq_stat(irq_tlb_count);
 		count_vm_tlb_event(NR_TLB_REMOTE_FLUSH_RECEIVED);
+		current->nrtlbflush++;
 
 		/* Can only happen on remote CPUs */
 		if (f->mm && f->mm != loaded_mm)
@@ -895,6 +896,7 @@ STATIC_NOPV void native_flush_tlb_multi(const struct cpumask *cpumask,
 	 * would not happen.
 	 */
 	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH);
+	current->ngtlbflush++;
 	if (info->end == TLB_FLUSH_ALL)
 		trace_tlb_flush(TLB_REMOTE_SEND_IPI, TLB_FLUSH_ALL);
 	else
diff --git a/fs/proc/array.c b/fs/proc/array.c
index 49283b81..435afdc 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -469,6 +469,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	unsigned long long start_time;
 	unsigned long cmin_flt = 0, cmaj_flt = 0;
 	unsigned long  min_flt = 0,  maj_flt = 0;
+	unsigned long ngtlbflush = 0, nrtlbflush = 0;
 	u64 cutime, cstime, utime, stime;
 	u64 cgtime, gtime;
 	unsigned long rsslim = 0;
@@ -530,11 +531,15 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 			do {
 				min_flt += t->min_flt;
 				maj_flt += t->maj_flt;
+				ngtlbflush += t->ngtlbflush;
+				nrtlbflush += t->nrtlbflush;
 				gtime += task_gtime(t);
 			} while_each_thread(task, t);
 
 			min_flt += sig->min_flt;
 			maj_flt += sig->maj_flt;
+			ngtlbflush += sig->ngtlbflush;
+			nrtlbflush += sig->nrtlbflush;
 			thread_group_cputime_adjusted(task, &utime, &stime);
 			gtime += sig->gtime;
 
@@ -554,6 +559,8 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	if (!whole) {
 		min_flt = task->min_flt;
 		maj_flt = task->maj_flt;
+		nrtlbflush = task->nrtlbflush;
+		ngtlbflush = task->ngtlbflush;
 		task_cputime_adjusted(task, &utime, &stime);
 		gtime = task_gtime(task);
 	}
@@ -643,6 +650,8 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	else
 		seq_puts(m, " 0");
 
+	seq_put_decimal_ull(m, " ", ngtlbflush);
+	seq_put_decimal_ull(m, " ", nrtlbflush);
 	seq_putc(m, '\n');
 	if (mm)
 		mmput(mm);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5cdf746..2a0d879 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1047,6 +1047,12 @@ struct task_struct {
 	unsigned long			min_flt;
 	unsigned long			maj_flt;
 
+	/* Number of TLB flushes generated by this task */
+	unsigned long			ngtlbflush;
+
+	/* Number of TLB flushes received by this task */
+	unsigned long			nrtlbflush;
+
 	/* Empty if CONFIG_POSIX_CPUTIMERS=n */
 	struct posix_cputimers		posix_cputimers;
 
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 2009926..4e0b09c 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -189,6 +189,7 @@ struct signal_struct {
 	struct prev_cputime prev_cputime;
 	unsigned long nvcsw, nivcsw, cnvcsw, cnivcsw;
 	unsigned long min_flt, maj_flt, cmin_flt, cmaj_flt;
+	unsigned long ngtlbflush, nrtlbflush;
 	unsigned long inblock, oublock, cinblock, coublock;
 	unsigned long maxrss, cmaxrss;
 	struct task_io_accounting ioac;
diff --git a/kernel/exit.c b/kernel/exit.c
index 35e0a31..5a72755 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -141,6 +141,8 @@ static void __exit_signal(struct task_struct *tsk)
 	sig->gtime += task_gtime(tsk);
 	sig->min_flt += tsk->min_flt;
 	sig->maj_flt += tsk->maj_flt;
+	sig->ngtlbflush += tsk->ngtlbflush;
+	sig->nrtlbflush += tsk->nrtlbflush;
 	sig->nvcsw += tsk->nvcsw;
 	sig->nivcsw += tsk->nivcsw;
 	sig->inblock += task_io_get_inblock(tsk);
@@ -1095,6 +1097,10 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
 			p->min_flt + sig->min_flt + sig->cmin_flt;
 		psig->cmaj_flt +=
 			p->maj_flt + sig->maj_flt + sig->cmaj_flt;
+		psig->ngtlbflush +=
+			p->ngtlbflush + sig->ngtlbflush;
+		psig->nrtlbflush +=
+			p->nrtlbflush + sig->nrtlbflush;
 		psig->cnvcsw +=
 			p->nvcsw + sig->nvcsw + sig->cnvcsw;
 		psig->cnivcsw +=
diff --git a/kernel/fork.c b/kernel/fork.c
index b339918..5fa9f64 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1555,6 +1555,7 @@ static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
 	struct mm_struct *mm, *oldmm;
 
 	tsk->min_flt = tsk->maj_flt = 0;
+	tsk->ngtlbflush = tsk->nrtlbflush = 0;
 	tsk->nvcsw = tsk->nivcsw = 0;
 #ifdef CONFIG_DETECT_HUNG_TASK
 	tsk->last_switch_count = tsk->nvcsw + tsk->nivcsw;
-- 
2.7.4

