Return-Path: <linux-fsdevel+bounces-50202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C53AC8B31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 11:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52A7317FD00
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 09:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79B022F75F;
	Fri, 30 May 2025 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bQw0UddR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896DB220F50
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 09:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597830; cv=none; b=TUR3HcmbAw9/NRKIfbJZGO887SPPUsooswA+pSy0iuUJ6NrGDWkW5ADqCosZFP35Ir8Ym0TVbpd9lIF0GtEBZQZNuVPw24N9u0eTliActMW1Z4cu7rgb8bK/qcDKOu1HHt4KS98dnT7IO1YdmAYBZHDEyTiocLNwRqtD9cO33oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597830; c=relaxed/simple;
	bh=OO8xU47yO/bdoL2deRtc+JSUSQ1CGyj22+/NieuKsMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kflxfejPGiQc4HpZ8eZH33nklBXlVY5qKGXndQ+UDJMvJqK6AjepCkJ1elAbtZaNVQLCYK0C1zevQdXgo/A//2Gssabwc2Xpe0Ms7+CKFWsdigYF96ciO691BbPGGKvYG/Oi/3+Fbz8BPTlCjXHE0TWELqKc93Sc8zlTUxwYo4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bQw0UddR; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-311d5fdf1f0so1705679a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 02:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597827; x=1749202627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ff5bIYNqY4yUnollIgoWVZucxS5phnK+GSArqqp8njA=;
        b=bQw0UddRSd0zodJFoDpQPUYtbH1/vf+TrFM/oYUAFXfqB280B0OrDjvwoGgX/58GYZ
         j4hvdO+XitJo8fkmEr2ugoXnozUApYaq5qz1miA5ra+AYe749tpVZer6npWBXRkke9rl
         4J9pA24qUUSFt3yjLUYeKiqaXphcZbGmGr4E2mI/FIppeSvb1doRHrPpaGvzlfwxVuko
         CH3ZTO94pN8EXwoy2vai6ATQnh+0Ijh8Vsj3fLcmjpHubwMPj+kp8l1Xp8olIg2p8bxo
         JmRg7UYZYAOyDt7wqRwOKkr9jUx6FV0s/w2/PQAYB/BKmaJbzssmmI2i9aOBaStyjc9s
         tz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597827; x=1749202627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ff5bIYNqY4yUnollIgoWVZucxS5phnK+GSArqqp8njA=;
        b=bgDyglLjRjin9P7gM77yO+ebG3L+UE040O8hbUZZKRVdV7mnSQqyLqN+tASYr8XaO5
         pdGGdDXOZgC70qaG72ZTrYHe5Sk9srqUCl3FAg2Z2Jec+Ifsmq2iVhvPA/ZMmMRZkA66
         zmk61CFPmp92UZIs1+Ox8gSu4Z1W9qiOkprPfVTEzsBKaSZB1oJ8mGf+rpbh9Ceps3ky
         7Js8NwMzOpOL8aP5pUfRn71Ub8Qs/Xcx+BWQ2E5bWHosaxikrp+zaaFac+JAvOjXoH4D
         Fdx1MBOBW4ug0ftA0A1yDf4V1wsYQPLfUZKwc2R/BVfxJa+5ErSrVSQx26CzYlbNt1WD
         b9PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpunbs648cyTDApgnqzWuJqSeyo8lygpxQtKw8FLIQyqreKB/sZzjEMt9AwhUQ+UrSFpIFSNghAcTBs8ou@vger.kernel.org
X-Gm-Message-State: AOJu0YwJPftx0KbvevZOT5c/BR2e0OOuOsm1p0mV8qhCouDwQsJYWnqF
	0OPy68AGv9ex30O+QL0/4Yb+B56/P+YhLajNRoUqpXMDyJFTE21+v1f3koVb0vMPzuk=
X-Gm-Gg: ASbGnctx1mpXBqNdBwK3wWUzlRX2xZFIRwHJD+YtT2lCrM0pjL10shIo01fsaGa6g4f
	1QgT/2nidAJDihfkNzFv3fDZFdXNu6mBgPKlkWl8AqYd3XcOcYufa0By6+REQunJf2it9fr38Fr
	KeIav8hE+C8tGakB7gJVb2skYWHdegPOXYU2ZacbYXy9BOkKjMdHkIPu2dxbVETfPh1xdCuMq2T
	NeSp5mZe6KrLHEjbNriPOtJ4Rb0+eIynyNMTce77cyro6KrwgHC7oKYCO7Nv1KubNTrP0PQro9E
	ioojgJUyGOv8xe+NtkCSIF7bBpbD2uShSRBZzF7qb9YNEBqByZPiDMBV1x1TfjuTheWGzXKshbm
	B0t22Meuq4Q==
X-Google-Smtp-Source: AGHT+IGPAReH+gj/mAHjw8Fc+v5rLzKHU0DKOTk3FhYthS79DtKAel685Vp30oKSxbQ9599VbyBn4A==
X-Received: by 2002:a17:90b:4d:b0:311:be51:bdec with SMTP id 98e67ed59e1d1-3125036326fmr2501710a91.11.1748597826688;
        Fri, 30 May 2025 02:37:06 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.36.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:37:06 -0700 (PDT)
From: Bo Li <libo.gcs85@bytedance.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	luto@kernel.org,
	kees@kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	peterz@infradead.org
Cc: dietmar.eggemann@arm.com,
	hpa@zytor.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	jannh@google.com,
	pfalcato@suse.de,
	riel@surriel.com,
	harry.yoo@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	duanxiongchun@bytedance.com,
	yinhongbo@bytedance.com,
	dengliang.1214@bytedance.com,
	xieyongji@bytedance.com,
	chaiwen.cc@bytedance.com,
	songmuchun@bytedance.com,
	yuanzhu@bytedance.com,
	chengguozhu@bytedance.com,
	sunjiadong.lff@bytedance.com,
	Bo Li <libo.gcs85@bytedance.com>
Subject: [RFC v2 34/35] RPAL: enable fast epoll wait
Date: Fri, 30 May 2025 17:28:02 +0800
Message-Id: <b13520ef51366f6c25c50f05de7210d37fcd9489.1748594841.git.libo.gcs85@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1748594840.git.libo.gcs85@bytedance.com>
References: <cover.1748594840.git.libo.gcs85@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a kernel event occurs during an RPAL call and triggers a lazy switch,
the kernel context switches from the sender to the receiver. When the
receiver later returns from user space to the sender, a second lazy switch
is required to switch the kernel context back to the sender. In the current
implementation, after the second lazy switch, the receiver returns to user
space via rpal_kernel_ret() and then calls epoll_wait() from user space to
re-enter the kernel. This causes the receiver to be unable to process epoll
events for a long period, degrading performance.

This patch introduces a fast epoll wait feature. During the second lazy
switch, the kernel configures epoll-related data structures so that the
receiver can directly enter the epoll wait state without first returning
to user space and then calling epoll_wait(). The patch adds a new state
RPAL_RECEIVER_STATE_READY_LS, which is used to mark that the receiver can
transition to RPAL_RECEIVER_STATE_WAIT during the second lazy switch. The
kernel then performs this state transition in rpal_lazy_switch_tail().

Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 arch/x86/rpal/core.c |  29 ++++++++++++-
 fs/eventpoll.c       | 101 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/rpal.h |   3 ++
 kernel/sched/core.c  |  13 +++++-
 4 files changed, 143 insertions(+), 3 deletions(-)

diff --git a/arch/x86/rpal/core.c b/arch/x86/rpal/core.c
index 2ac5d932f69c..7b6efde23e48 100644
--- a/arch/x86/rpal/core.c
+++ b/arch/x86/rpal/core.c
@@ -51,7 +51,25 @@ void rpal_lazy_switch_tail(struct task_struct *tsk)
 		atomic_cmpxchg(&rcc->receiver_state, rpal_build_call_state(tsk->rpal_sd),
 			       RPAL_RECEIVER_STATE_LAZY_SWITCH);
 	} else {
+		/* tsk is receiver */
+		int state;
+
+		rcc = tsk->rpal_rd->rcc;
+		state = atomic_read(&rcc->receiver_state);
+		/* receiver may be scheduled on another cpu after unlock. */
 		rpal_unlock_cpu(tsk);
+		/*
+		 * We must not use RPAL_RECEIVER_STATE_READY instead of
+		 * RPAL_RECEIVER_STATE_READY_LS. As receiver may at
+		 * TASK_RUNNING state and then call epoll_wait() again,
+		 * the state may become RPAL_RECEIVER_STATE_READY, we should
+		 * not changed its state to RPAL_RECEIVER_STATE_WAIT since
+		 * the state is set by another RPAL call.
+		 */
+		if (state == RPAL_RECEIVER_STATE_READY_LS)
+			atomic_cmpxchg(&rcc->receiver_state,
+				       RPAL_RECEIVER_STATE_READY_LS,
+				       RPAL_RECEIVER_STATE_WAIT);
 		rpal_unlock_cpu(current);
 	}
 }
@@ -63,8 +81,14 @@ void rpal_kernel_ret(struct pt_regs *regs)
 	int state;
 
 	if (rpal_test_current_thread_flag(RPAL_RECEIVER_BIT)) {
-		rcc = current->rpal_rd->rcc;
-		regs->ax = rpal_try_send_events(current->rpal_rd->ep, rcc);
+		struct rpal_receiver_data *rrd = current->rpal_rd;
+
+		rcc = rrd->rcc;
+		if (rcc->timeout > 0)
+			hrtimer_cancel(&rrd->ep_sleeper.timer);
+		rpal_remove_ep_wait_list(rrd);
+		regs->ax = rpal_try_send_events(rrd->ep, rcc);
+		fdput(rrd->f);
 		atomic_xchg(&rcc->receiver_state, RPAL_RECEIVER_STATE_KERNEL_RET);
 	} else {
 		tsk = current->rpal_sd->receiver;
@@ -173,6 +197,7 @@ rpal_do_kernel_context_switch(struct task_struct *next, struct pt_regs *regs)
 		 * Otherwise, sender's user context will be corrupted.
 		 */
 		rebuild_receiver_stack(current->rpal_rd, regs);
+		rpal_fast_ep_poll(current->rpal_rd, regs);
 		rpal_schedule(next);
 		rpal_clear_task_thread_flag(prev, RPAL_LAZY_SWITCHED_BIT);
 		prev->rpal_rd->sender = NULL;
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 791321639561..b70c1cd82335 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2143,6 +2143,107 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 }
 
 #ifdef CONFIG_RPAL
+static void *rpal_get_eventpoll(struct rpal_receiver_data *rrd, struct pt_regs *regs)
+{
+	struct rpal_receiver_call_context *rcc = rrd->rcc;
+	int epfd = rcc->epfd;
+	struct epoll_event __user *events = rcc->events;
+	int maxevents = rcc->maxevents;
+	struct file *file;
+
+	if (maxevents <= 0 || maxevents > EP_MAX_EVENTS) {
+		regs->ax = -EINVAL;
+		return NULL;
+	}
+
+	if (!access_ok(events, maxevents * sizeof(struct epoll_event))) {
+		regs->ax = -EFAULT;
+		return NULL;
+	}
+
+	rrd->f = fdget(epfd);
+	file = fd_file(rrd->f);
+	if (!file) {
+		regs->ax = -EBADF;
+		return NULL;
+	}
+
+	if (!is_file_epoll(file)) {
+		regs->ax = -EINVAL;
+		fdput(rrd->f);
+		return NULL;
+	}
+
+	rrd->ep = file->private_data;
+	return rrd->ep;
+}
+
+void rpal_fast_ep_poll(struct rpal_receiver_data *rrd, struct pt_regs *regs)
+{
+	struct eventpoll *ep;
+	struct rpal_receiver_call_context *rcc = rrd->rcc;
+	ktime_t ts = 0;
+	struct hrtimer *ht = &rrd->ep_sleeper.timer;
+	int state;
+	int avail;
+
+	regs->orig_ax = __NR_epoll_wait;
+	ep = rpal_get_eventpoll(rrd, regs);
+
+	if (!ep || signal_pending(current) ||
+	    unlikely(ep_events_available(ep)) ||
+	    atomic_read(&rcc->ep_pending) || unlikely(rcc->timeout == 0)) {
+		INIT_LIST_HEAD(&rrd->ep_wait.entry);
+	} else {
+		/*
+		 * Here we use RPAL_RECEIVER_STATE_READY_LS to avoid conflict with
+		 * RPAL_RECEIVER_STATE_READY. As the RPAL_RECEIVER_STATE_READY_LS
+		 * is convert to RPAL_RECEIVER_STATE_WAIT in rpal_lazy_switch_tail(),
+		 * it is possible the receiver is woken at that time. Thus,
+		 * rpal_lazy_switch_tail() should figure out whether the receiver
+		 * state is set by lazy switch or not. See rpal_lazy_switch_tail()
+		 * for details.
+		 */
+		state = atomic_xchg(&rcc->receiver_state, RPAL_RECEIVER_STATE_READY_LS);
+		if (unlikely(state != RPAL_RECEIVER_STATE_LAZY_SWITCH))
+			rpal_err("%s: unexpected state: %d\n", __func__, state);
+		init_waitqueue_func_entry(&rrd->ep_wait, rpal_ep_autoremove_wake_function);
+		rrd->ep_wait.private = rrd;
+		INIT_LIST_HEAD(&rrd->ep_wait.entry);
+		write_lock(&ep->lock);
+		set_current_state(TASK_INTERRUPTIBLE);
+		avail = ep_events_available(ep);
+		if (!avail)
+			__add_wait_queue_exclusive(&ep->wq, &rrd->ep_wait);
+		write_unlock(&ep->lock);
+		if (avail) {
+			/* keep state consistent when we enter rpal_kernel_ret() */
+			atomic_set(&rcc->receiver_state,
+				   RPAL_RECEIVER_STATE_LAZY_SWITCH);
+			set_current_state(TASK_RUNNING);
+			return;
+		}
+
+		if (rcc->timeout > 0) {
+			rrd->ep_sleeper.task = rrd->rcd.bp_task;
+			ts = ms_to_ktime(rcc->timeout);
+			hrtimer_start(ht, ts, HRTIMER_MODE_REL);
+		}
+	}
+}
+
+void rpal_remove_ep_wait_list(struct rpal_receiver_data *rrd)
+{
+	struct eventpoll *ep = (struct eventpoll *)rrd->ep;
+	wait_queue_entry_t *wait = &rrd->ep_wait;
+
+	if (!list_empty_careful(&wait->entry)) {
+		write_lock_irq(&ep->lock);
+		__remove_wait_queue(&ep->wq, wait);
+		write_unlock_irq(&ep->lock);
+	}
+}
+
 void *rpal_get_epitemep(wait_queue_entry_t *wait)
 {
 	struct epitem *epi = ep_item_from_wait(wait);
diff --git a/include/linux/rpal.h b/include/linux/rpal.h
index f5f4da63f28c..676113f0ba1f 100644
--- a/include/linux/rpal.h
+++ b/include/linux/rpal.h
@@ -126,6 +126,7 @@ enum rpal_receiver_state {
 	RPAL_RECEIVER_STATE_WAIT,
 	RPAL_RECEIVER_STATE_CALL,
 	RPAL_RECEIVER_STATE_LAZY_SWITCH,
+	RPAL_RECEIVER_STATE_READY_LS,
 	RPAL_RECEIVER_STATE_MAX,
 };
 
@@ -627,4 +628,6 @@ void rpal_resume_ep(struct task_struct *tsk);
 void *rpal_get_epitemep(wait_queue_entry_t *wait);
 int rpal_get_epitemfd(wait_queue_entry_t *wait);
 int rpal_try_send_events(void *ep, struct rpal_receiver_call_context *rcc);
+void rpal_remove_ep_wait_list(struct rpal_receiver_data *rrd);
+void rpal_fast_ep_poll(struct rpal_receiver_data *rrd, struct pt_regs *regs);
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d6f8e0d76fc0..1728b04d1387 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3965,6 +3965,11 @@ static bool rpal_check_state(struct task_struct *p)
 		case RPAL_RECEIVER_STATE_LAZY_SWITCH:
 		case RPAL_RECEIVER_STATE_RUNNING:
 			break;
+		/*
+		 * Allow RPAL_RECEIVER_STATE_READY_LS to be woken will cause irq
+		 * being enabled in rpal_unlock_cpu.
+		 */
+		case RPAL_RECEIVER_STATE_READY_LS:
 		case RPAL_RECEIVER_STATE_CALL:
 			rpal_set_task_thread_flag(p, RPAL_WAKE_BIT);
 			ret = false;
@@ -11403,7 +11408,13 @@ void __sched notrace rpal_schedule(struct task_struct *next)
 
 	prev_state = READ_ONCE(prev->__state);
 	if (prev_state) {
-		try_to_block_task(rq, prev, &prev_state);
+		if (!try_to_block_task(rq, prev, &prev_state)) {
+			/*
+			 * As the task enter TASK_RUNNING state, we should clean up
+			 * RPAL_RECEIVER_STATE_READY_LS status.
+			 */
+			rpal_check_ready_state(prev, RPAL_RECEIVER_STATE_READY_LS);
+		}
 		switch_count = &prev->nvcsw;
 	}
 
-- 
2.20.1


