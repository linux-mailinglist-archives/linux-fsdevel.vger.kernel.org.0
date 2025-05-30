Return-Path: <linux-fsdevel+bounces-50195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D614BAC8B23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 11:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9838616EEF8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 09:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A51224B0C;
	Fri, 30 May 2025 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="f0RARZhZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7722322B8BD
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 09:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597724; cv=none; b=HI2cO4OXsgiWkGb1M2yd9lEL16GSC3k2UmkvnBcbslqCSlzH/psJR3nvEo8P+kGG0C+5Nf6dJOVas5VS8u172XxgzZPjTtafofpAy3U6F1/muwPMQEjI1dDWclutwZyDGxe768+/Qfa3zzLW6eH3zEjCpbX3VrEB8qUP8RoIDhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597724; c=relaxed/simple;
	bh=9CHW/F/J9wY0zWhmMIE46/gcJf++4JvdpcdoqukKOXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qfsCpBvWhh6/DfbeAGCvu29U4M2+DU13I4dLl2+zWEYvFGFUbs2Cy41tWhJiqp8OVS9vYqDTvcobr6ko4faaoXJl3SQXU8alqmxRHBsVTqjp+S9JB8sOUYIRpubFzemq28cL5Bq9oSuHoGXmAfLZFmbETQ0k0uMIyLns7QwXIsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=f0RARZhZ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-310cf8f7301so1490210a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 02:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597722; x=1749202522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFn4X8pNflxKPFbQMCWiED+xW2QzJgp0gVRveKZQMVQ=;
        b=f0RARZhZLjfW/aWmcoFtrJUt9YE2tMtU6hW+dQbnlucaiQQxvRKFiRnO3h/iMy/s2v
         omUDtrkqOEt/ktuvHS7n8o/6kqJxThZBTjaanLdHcfE1r68tQrAeOHxsfRfLW3NJ1Hyd
         nd/Aive6GBoywupUoDPQdMrRdo+l8n/7/P60qKSKROcXtd+U80e0W3nNU68j1qoyhmnr
         mn1MiVkLYfoxSFIz6NDcTU0XKh6O44BoWmqcKTXh53e35VdFfXUyYkby9sBRdZExDvD8
         3ou16CG9Vt4ycR+xYcIbyYYpe5bEbsuJZozsHxU4FYXZ5gsNlVcyG2FwKzZAZMjxVrhE
         iPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597722; x=1749202522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFn4X8pNflxKPFbQMCWiED+xW2QzJgp0gVRveKZQMVQ=;
        b=mAqEvDpl3wyS5UxoFchEBwmTcAoNAUkQjoc/+6OwifKxY1dgGt+bbDgHixf4TcKxYD
         e05r81zJpUwByE8pXLyrrJxmJv5VzvmkXGKgDlrWjA+Rt8xfI5C6td+fiSOiCOx+FlYs
         a1osB4Xi15KFE+GOcGOZ6q43RoGx0DjYj8iFlxcGF6XZeT8tjzUrLFqPG10jER/dyik1
         JnEhfkqc2H/pwdEYem03RLJKBSVo0hOTKVpKFMOoNRP/fmgSoTkuPfCmvpAatzfiFO1v
         9IsZyh+bJHskrHsG2EW2ukUcFWxtUXFDiYKcMFqXGJwVhfV5OfqnagLwmeksZJ1QmIRZ
         jMIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfh0OwYRZc4rFOklbjXRCVQ+EfXHBZeeTHCu9ZdEYlS6nxPjjMnh3QWNrJOBzSQqxWogt6YoljJVAqdhBb@vger.kernel.org
X-Gm-Message-State: AOJu0YzrQrRJ6gvdGbqDsGixIQ8K3bTfL6wyxJh2nej4vJrZj6HHlY5j
	WEcI1Uurc0SBmOp8E1WJBJTGyHEca6R3TXkr6BjWqQeOwPiQW4KLf9rmyPV4e+i6/+g=
X-Gm-Gg: ASbGncsgb8XrMderv2dRtDL0Yk/m97qlHlRbI6/S9cVCacAiKtVpLFar86LLhwG1qym
	G0He4GYz5jfOISgEyg+oRiDOVdq4A32gShS0wIUxG55Gpw4EMTMq5aB+tRR2Evd3jpj+lDMRv/B
	zLRLupvra3IcY9cXpLNfH5Yx/IQ8gay6hpBrCeGzKqeOSuGzh0MddZOUdr7GoBQ+pjbUMRh6vIG
	eP6ngZwhNfVY0EWuEeEXrRWHHMt1pKgK537eqPIFlAFNd+OXME9XjWMvIrJQZumNkTrM9iMJAQZ
	tuSvCgbeRRyKVvm5cXcOW1uz0fkhQJWi6kbDWcIGciW+Ot5FBZlwNwbMbP9aRuZ0+3X7uRzpUbQ
	VYI/LokGPjf1TiODjeyrW
X-Google-Smtp-Source: AGHT+IH46+bZCrX7K5xEEg6cSKu1TR1I7SkSliOWsHgcBqoA6CG8wyIvf12Zvpihk7VZmfu1IuwYXQ==
X-Received: by 2002:a17:90b:164b:b0:310:8d4a:4a97 with SMTP id 98e67ed59e1d1-31214ee68f2mr10223135a91.15.1748597721380;
        Fri, 30 May 2025 02:35:21 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.35.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:35:21 -0700 (PDT)
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
Subject: [RFC v2 27/35] RPAL: add epoll support
Date: Fri, 30 May 2025 17:27:55 +0800
Message-Id: <7eb30a577e2c6a4f582515357aea25260105eb18.1748594841.git.libo.gcs85@bytedance.com>
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

To support the epoll family, RPAL needs to add new logic for RPAL services
to the existing epoll logic, ensuring that user mode can execute RPAL
service-related logic through identical interfaces.

When the receiver thread calls epoll_wait(), it can set RPAL_EP_POLL_MAGIC
to notify the kernel to invoke RPAL-related logic. The kernel then sets the
receiver's state to RPAL_RECEIVER_STATE_READY and transitions it to
RPAL_RECEIVER_STATE_WAIT when the receiver is actually removed from the
runqueue, allowing the sender to perform RPAL calls on the receiver thread.

Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 arch/x86/rpal/core.c |   4 +
 fs/eventpoll.c       | 200 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/rpal.h |  21 +++++
 kernel/sched/core.c  |  17 ++++
 4 files changed, 242 insertions(+)

diff --git a/arch/x86/rpal/core.c b/arch/x86/rpal/core.c
index 47c9e551344e..6a22b9faa100 100644
--- a/arch/x86/rpal/core.c
+++ b/arch/x86/rpal/core.c
@@ -9,6 +9,7 @@
 #include <linux/rpal.h>
 #include <linux/sched/task_stack.h>
 #include <linux/pkeys.h>
+#include <linux/file.h>
 #include <asm/fsgsbase.h>
 
 #include "internal.h"
@@ -63,6 +64,7 @@ void rpal_kernel_ret(struct pt_regs *regs)
 
 	if (rpal_test_current_thread_flag(RPAL_RECEIVER_BIT)) {
 		rcc = current->rpal_rd->rcc;
+		regs->ax = rpal_try_send_events(current->rpal_rd->ep, rcc);
 		atomic_xchg(&rcc->receiver_state, RPAL_RECEIVER_STATE_KERNEL_RET);
 	} else {
 		tsk = current->rpal_sd->receiver;
@@ -142,6 +144,7 @@ rpal_do_kernel_context_switch(struct task_struct *next, struct pt_regs *regs)
 	struct task_struct *prev = current;
 
 	if (rpal_test_task_thread_flag(next, RPAL_LAZY_SWITCHED_BIT)) {
+		rpal_resume_ep(next);
 		current->rpal_sd->receiver = next;
 		rpal_lock_cpu(current);
 		rpal_lock_cpu(next);
@@ -154,6 +157,7 @@ rpal_do_kernel_context_switch(struct task_struct *next, struct pt_regs *regs)
 		 */
 		rebuild_sender_stack(current->rpal_sd, regs);
 		rpal_schedule(next);
+		fdput(next->rpal_rd->f);
 	} else {
 		update_dst_stack(next, regs);
 		/*
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index d4dbffdedd08..437cd5764c03 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -38,6 +38,7 @@
 #include <linux/compat.h>
 #include <linux/rculist.h>
 #include <linux/capability.h>
+#include <linux/rpal.h>
 #include <net/busy_poll.h>
 
 /*
@@ -2141,6 +2142,187 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 	}
 }
 
+#ifdef CONFIG_RPAL
+
+void rpal_resume_ep(struct task_struct *tsk)
+{
+	struct rpal_receiver_data *rrd = tsk->rpal_rd;
+	struct eventpoll *ep = (struct eventpoll *)rrd->ep;
+	struct rpal_receiver_call_context *rcc = rrd->rcc;
+
+	if (rcc->timeout > 0) {
+		hrtimer_cancel(&rrd->ep_sleeper.timer);
+		destroy_hrtimer_on_stack(&rrd->ep_sleeper.timer);
+	}
+	if (!list_empty_careful(&rrd->ep_wait.entry)) {
+		write_lock(&ep->lock);
+		__remove_wait_queue(&ep->wq, &rrd->ep_wait);
+		write_unlock(&ep->lock);
+	}
+}
+
+int rpal_try_send_events(void *ep, struct rpal_receiver_call_context *rcc)
+{
+	int eavail;
+	int res = 0;
+
+	res = ep_send_events(ep, rcc->events, rcc->maxevents);
+	if (res > 0)
+		ep_suspend_napi_irqs(ep);
+
+	eavail = ep_events_available(ep);
+	if (!eavail) {
+		atomic_and(~RPAL_KERNEL_PENDING, &rcc->ep_pending);
+		/* check again to avoid data race on RPAL_KERNEL_PENDING */
+		eavail = ep_events_available(ep);
+		if (eavail)
+			atomic_or(RPAL_KERNEL_PENDING, &rcc->ep_pending);
+	}
+	return res;
+}
+
+static int rpal_schedule_hrtimeout_range_clock(ktime_t *expires, u64 delta,
+					       const enum hrtimer_mode mode,
+					       clockid_t clock_id)
+{
+	struct hrtimer_sleeper *t = &current->rpal_rd->ep_sleeper;
+
+	/*
+	 * Optimize when a zero timeout value is given. It does not
+	 * matter whether this is an absolute or a relative time.
+	 */
+	if (expires && *expires == 0) {
+		__set_current_state(TASK_RUNNING);
+		return 0;
+	}
+
+	/*
+	 * A NULL parameter means "infinite"
+	 */
+	if (!expires) {
+		schedule();
+		return -EINTR;
+	}
+
+	hrtimer_setup_sleeper_on_stack(t, clock_id, mode);
+	hrtimer_set_expires_range_ns(&t->timer, *expires, delta);
+	hrtimer_sleeper_start_expires(t, mode);
+
+	if (likely(t->task))
+		schedule();
+
+	hrtimer_cancel(&t->timer);
+	destroy_hrtimer_on_stack(&t->timer);
+
+	__set_current_state(TASK_RUNNING);
+
+	return !t->task ? 0 : -EINTR;
+}
+
+static int rpal_ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
+			int maxevents, struct timespec64 *timeout)
+{
+	int res = 0, eavail, timed_out = 0;
+	u64 slack = 0;
+	struct rpal_receiver_data *rrd = current->rpal_rd;
+	wait_queue_entry_t *wait = &rrd->ep_wait;
+	ktime_t expires, *to = NULL;
+
+	rrd->ep = ep;
+
+	lockdep_assert_irqs_enabled();
+
+	if (timeout && (timeout->tv_sec | timeout->tv_nsec)) {
+		slack = select_estimate_accuracy(timeout);
+		to = &expires;
+		*to = timespec64_to_ktime(*timeout);
+	} else if (timeout) {
+		timed_out = 1;
+	}
+
+	eavail = ep_events_available(ep);
+
+	while (1) {
+		if (eavail) {
+			res = rpal_try_send_events(ep, rrd->rcc);
+			if (res) {
+				atomic_xchg(&rrd->rcc->receiver_state,
+					    RPAL_RECEIVER_STATE_RUNNING);
+				return res;
+			}
+		}
+
+		if (timed_out) {
+			atomic_xchg(&rrd->rcc->receiver_state,
+				    RPAL_RECEIVER_STATE_RUNNING);
+			return 0;
+		}
+
+		eavail = ep_busy_loop(ep);
+		if (eavail)
+			continue;
+
+		if (signal_pending(current)) {
+			atomic_xchg(&rrd->rcc->receiver_state,
+				    RPAL_RECEIVER_STATE_RUNNING);
+			return -EINTR;
+		}
+
+		init_wait(wait);
+		wait->func = rpal_ep_autoremove_wake_function;
+		wait->private = rrd;
+		write_lock_irq(&ep->lock);
+
+		atomic_xchg(&rrd->rcc->receiver_state,
+			    RPAL_RECEIVER_STATE_READY);
+		__set_current_state(TASK_INTERRUPTIBLE);
+
+		eavail = ep_events_available(ep);
+		if (!eavail)
+			__add_wait_queue_exclusive(&ep->wq, wait);
+
+		write_unlock_irq(&ep->lock);
+
+		if (!eavail && ep_schedule_timeout(to)) {
+			if (RPAL_USER_PENDING & atomic_read(&rrd->rcc->ep_pending)) {
+				timed_out = 1;
+			} else {
+				timed_out =
+					!rpal_schedule_hrtimeout_range_clock(
+						to, slack, HRTIMER_MODE_ABS,
+						CLOCK_MONOTONIC);
+			}
+		}
+		atomic_cmpxchg(&rrd->rcc->receiver_state,
+			       RPAL_RECEIVER_STATE_READY,
+			       RPAL_RECEIVER_STATE_RUNNING);
+		__set_current_state(TASK_RUNNING);
+
+		/*
+		 * We were woken up, thus go and try to harvest some events.
+		 * If timed out and still on the wait queue, recheck eavail
+		 * carefully under lock, below.
+		 */
+		eavail = 1;
+
+		if (!list_empty_careful(&wait->entry)) {
+			write_lock_irq(&ep->lock);
+			/*
+			 * If the thread timed out and is not on the wait queue,
+			 * it means that the thread was woken up after its
+			 * timeout expired before it could reacquire the lock.
+			 * Thus, when wait.entry is empty, it needs to harvest
+			 * events.
+			 */
+			if (timed_out)
+				eavail = list_empty(&wait->entry);
+			__remove_wait_queue(&ep->wq, wait);
+			write_unlock_irq(&ep->lock);
+		}
+	}
+}
+#endif
+
 /**
  * ep_loop_check_proc - verify that adding an epoll file inside another
  *                      epoll structure does not violate the constraints, in
@@ -2529,7 +2711,25 @@ static int do_epoll_wait(int epfd, struct epoll_event __user *events,
 	ep = fd_file(f)->private_data;
 
 	/* Time to fish for events ... */
+#ifdef CONFIG_RPAL
+	/*
+	 * For RPAL task, if it is a receiver and it set MAGIC in shared memory,
+	 * We think it is prepared for rpal calls. Therefore, we need to handle
+	 * it differently.
+	 *
+	 * In other cases, RPAL task always plays like a normal task.
+	 */
+	if (rpal_current_service() &&
+	    rpal_test_current_thread_flag(RPAL_RECEIVER_BIT) &&
+	    current->rpal_rd->rcc->rpal_ep_poll_magic == RPAL_EP_POLL_MAGIC) {
+		current->rpal_rd->f = f;
+		return rpal_ep_poll(ep, events, maxevents, to);
+	} else {
+		return ep_poll(ep, events, maxevents, to);
+	}
+#else
 	return ep_poll(ep, events, maxevents, to);
+#endif
 }
 
 SYSCALL_DEFINE4(epoll_wait, int, epfd, struct epoll_event __user *, events,
diff --git a/include/linux/rpal.h b/include/linux/rpal.h
index f2474cb53abe..5912ffec6e28 100644
--- a/include/linux/rpal.h
+++ b/include/linux/rpal.h
@@ -16,6 +16,8 @@
 #include <linux/hashtable.h>
 #include <linux/atomic.h>
 #include <linux/sizes.h>
+#include <linux/file.h>
+#include <linux/hrtimer.h>
 
 #define RPAL_ERROR_MSG "rpal error: "
 #define rpal_err(x...) pr_err(RPAL_ERROR_MSG x)
@@ -89,6 +91,7 @@ enum {
 };
 
 #define RPAL_ERROR_MAGIC 0x98CC98CC
+#define RPAL_EP_POLL_MAGIC 0xCC98CC98
 
 #define RPAL_SID_SHIFT 24
 #define RPAL_ID_SHIFT 8
@@ -103,6 +106,9 @@ enum {
 #define RPAL_PKRU_UNION 1
 #define RPAL_PKRU_INTERSECT 2
 
+#define RPAL_KERNEL_PENDING 0x1
+#define RPAL_USER_PENDING 0x2
+
 extern unsigned long rpal_cap;
 
 enum rpal_task_flag_bits {
@@ -282,6 +288,12 @@ struct rpal_receiver_call_context {
 	int receiver_id;
 	atomic_t receiver_state;
 	atomic_t sender_state;
+	atomic_t ep_pending;
+	int rpal_ep_poll_magic;
+	int epfd;
+	void __user *events;
+	int maxevents;
+	int timeout;
 };
 
 /* recovery point for sender */
@@ -325,6 +337,10 @@ struct rpal_receiver_data {
 	struct rpal_shared_page *rsp;
 	struct rpal_receiver_call_context *rcc;
 	struct task_struct *sender;
+	void *ep;
+	struct fd f;
+	struct hrtimer_sleeper ep_sleeper;
+	wait_queue_entry_t ep_wait;
 };
 
 struct rpal_sender_data {
@@ -574,4 +590,9 @@ __rpal_switch_to(struct task_struct *prev_p, struct task_struct *next_p);
 asmlinkage __visible void rpal_schedule_tail(struct task_struct *prev);
 int do_rpal_mprotect_pkey(unsigned long start, size_t len, int pkey);
 void rpal_set_pku_schedule_tail(struct task_struct *prev);
+int rpal_ep_autoremove_wake_function(wait_queue_entry_t *curr,
+	unsigned int mode, int wake_flags,
+	void *key);
+void rpal_resume_ep(struct task_struct *tsk);
+int rpal_try_send_events(void *ep, struct rpal_receiver_call_context *rcc);
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index eb5d5bd51597..486d59bdd3fc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6794,6 +6794,23 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 #define SM_RTLOCK_WAIT		2
 
 #ifdef CONFIG_RPAL
+int rpal_ep_autoremove_wake_function(wait_queue_entry_t *curr,
+				     unsigned int mode, int wake_flags,
+				     void *key)
+{
+	struct rpal_receiver_data *rrd = curr->private;
+	struct task_struct *tsk = rrd->rcd.bp_task;
+	int ret;
+
+	ret = try_to_wake_up(tsk, mode, wake_flags);
+
+	list_del_init_careful(&curr->entry);
+	if (!ret)
+		atomic_or(RPAL_KERNEL_PENDING, &rrd->rcc->ep_pending);
+
+	return 1;
+}
+
 static inline void rpal_check_ready_state(struct task_struct *tsk, int state)
 {
 	if (rpal_test_task_thread_flag(tsk, RPAL_RECEIVER_BIT)) {
-- 
2.20.1


