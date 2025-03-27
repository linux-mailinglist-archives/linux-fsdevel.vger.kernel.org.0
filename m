Return-Path: <linux-fsdevel+bounces-45134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1771A73421
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 15:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D25017BE73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 14:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EA4217703;
	Thu, 27 Mar 2025 14:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="shRbftR1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3118620CCFD;
	Thu, 27 Mar 2025 14:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743084944; cv=none; b=DfV18fqPQOMlDdHD6+kdt82E7PNcz8kX1XtieP+ivuI8/XMdHPnmxRsiiNxcXb1tKVqem1yCvppOZ79n6QTkZBXoyMYHLWYCyUX+4sZRfQvLxKh/CAb//xwl02UhfE/0t3YLQcsayBh9ExvYWEdX/oQZXjYwaVgslzIZdg/l8xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743084944; c=relaxed/simple;
	bh=aK0BXGeEBRrg9wG5GiYW/OtSFnBWJxKTOuBDkNguWr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6fYp4UejD6eB63wTF9w79wMISyqroGmPRDcvSGGX72CcjVdDi9v2eixPnKkjujYXfZ6xeziCZP9MZGQwDxJ9WUxJW6ZV+G5PkZypm2H4tejPbX+QSynexHq6ZeVcL1xVI8E1ni6gNmSVYmBrHnFTMQsB5JAR1tVgUTWOYmN1t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=shRbftR1; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1743084942;
	bh=aK0BXGeEBRrg9wG5GiYW/OtSFnBWJxKTOuBDkNguWr0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:From;
	b=shRbftR19ePwWslzn5X95N7WRTkAI72WybEGPuBkqjQX70WrkKGfEnAPG2H4dzCkR
	 iSpIXv3AH1SqJGIiGvbjg0F/zlowfaydppjbb2oeFfGGxpZgWfAuhgp6tuw2IrnJuh
	 NB64Sp8BimDM1/6VUMNQQeqsZixRL38jDzNVnTbA=
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by lamorak.hansenpartnership.com (Postfix) with ESMTP id 8F3DD1C0015;
	Thu, 27 Mar 2025 10:15:41 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mcgrof@kernel.org,
	jack@suse.cz,
	hch@infradead.org,
	david@fromorbit.com,
	rafael@kernel.org,
	djwong@kernel.org,
	pavel@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun.feng@gmail.com
Subject: [RFC PATCH 1/4] locking/percpu-rwsem: add freezable alternative to down_read
Date: Thu, 27 Mar 2025 10:06:10 -0400
Message-ID: <20250327140613.25178-2-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250327140613.25178-1-James.Bottomley@HansenPartnership.com>
References: <20250327140613.25178-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Percpu-rwsems are used for superblock locking.  However, we know the
read percpu-rwsem we take for sb_start_write() on a frozen filesystem
needs not to inhibit system from suspending or hibernating.  That
means it needs to wait with TASK_UNINTERRUPTIBLE | TASK_FREEZABLE.

Introduce a new percpu_down_read_freezable() that allows us to control
whether TASK_FREEZABLE is added to the wait flags.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---

Since this is an RFC, added the percpu-rwsem maintainers for
information and guidance to check if we're on the right track or
whether they would prefer an alternative API.
---
 include/linux/percpu-rwsem.h  | 20 ++++++++++++++++----
 kernel/locking/percpu-rwsem.c | 13 ++++++++-----
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index c012df33a9f0..a55fe709b832 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -42,9 +42,10 @@ is_static struct percpu_rw_semaphore name = {				\
 #define DEFINE_STATIC_PERCPU_RWSEM(name)	\
 	__DEFINE_PERCPU_RWSEM(name, static)
 
-extern bool __percpu_down_read(struct percpu_rw_semaphore *, bool);
+extern bool __percpu_down_read(struct percpu_rw_semaphore *, bool, bool);
 
-static inline void percpu_down_read(struct percpu_rw_semaphore *sem)
+static inline void percpu_down_read_internal(struct percpu_rw_semaphore *sem,
+					     bool freezable)
 {
 	might_sleep();
 
@@ -62,7 +63,7 @@ static inline void percpu_down_read(struct percpu_rw_semaphore *sem)
 	if (likely(rcu_sync_is_idle(&sem->rss)))
 		this_cpu_inc(*sem->read_count);
 	else
-		__percpu_down_read(sem, false); /* Unconditional memory barrier */
+		__percpu_down_read(sem, false, freezable); /* Unconditional memory barrier */
 	/*
 	 * The preempt_enable() prevents the compiler from
 	 * bleeding the critical section out.
@@ -70,6 +71,17 @@ static inline void percpu_down_read(struct percpu_rw_semaphore *sem)
 	preempt_enable();
 }
 
+static inline void percpu_down_read(struct percpu_rw_semaphore *sem)
+{
+	percpu_down_read_internal(sem, false);
+}
+
+static inline void percpu_down_read_freezable(struct percpu_rw_semaphore *sem,
+					      bool freeze)
+{
+	percpu_down_read_internal(sem, freeze);
+}
+
 static inline bool percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
 {
 	bool ret = true;
@@ -81,7 +93,7 @@ static inline bool percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
 	if (likely(rcu_sync_is_idle(&sem->rss)))
 		this_cpu_inc(*sem->read_count);
 	else
-		ret = __percpu_down_read(sem, true); /* Unconditional memory barrier */
+		ret = __percpu_down_read(sem, true, false); /* Unconditional memory barrier */
 	preempt_enable();
 	/*
 	 * The barrier() from preempt_enable() prevents the compiler from
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index 6083883c4fe0..890837b73476 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -138,7 +138,8 @@ static int percpu_rwsem_wake_function(struct wait_queue_entry *wq_entry,
 	return !reader; /* wake (readers until) 1 writer */
 }
 
-static void percpu_rwsem_wait(struct percpu_rw_semaphore *sem, bool reader)
+static void percpu_rwsem_wait(struct percpu_rw_semaphore *sem, bool reader,
+			      bool freeze)
 {
 	DEFINE_WAIT_FUNC(wq_entry, percpu_rwsem_wake_function);
 	bool wait;
@@ -156,7 +157,8 @@ static void percpu_rwsem_wait(struct percpu_rw_semaphore *sem, bool reader)
 	spin_unlock_irq(&sem->waiters.lock);
 
 	while (wait) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
+		set_current_state(TASK_UNINTERRUPTIBLE |
+				  freeze ? TASK_FREEZABLE : 0);
 		if (!smp_load_acquire(&wq_entry.private))
 			break;
 		schedule();
@@ -164,7 +166,8 @@ static void percpu_rwsem_wait(struct percpu_rw_semaphore *sem, bool reader)
 	__set_current_state(TASK_RUNNING);
 }
 
-bool __sched __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
+bool __sched __percpu_down_read(struct percpu_rw_semaphore *sem, bool try,
+				bool freeze)
 {
 	if (__percpu_down_read_trylock(sem))
 		return true;
@@ -174,7 +177,7 @@ bool __sched __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
 
 	trace_contention_begin(sem, LCB_F_PERCPU | LCB_F_READ);
 	preempt_enable();
-	percpu_rwsem_wait(sem, /* .reader = */ true);
+	percpu_rwsem_wait(sem, /* .reader = */ true, freeze);
 	preempt_disable();
 	trace_contention_end(sem, 0);
 
@@ -237,7 +240,7 @@ void __sched percpu_down_write(struct percpu_rw_semaphore *sem)
 	 */
 	if (!__percpu_down_write_trylock(sem)) {
 		trace_contention_begin(sem, LCB_F_PERCPU | LCB_F_WRITE);
-		percpu_rwsem_wait(sem, /* .reader = */ false);
+		percpu_rwsem_wait(sem, /* .reader = */ false, false);
 		contended = true;
 	}
 
-- 
2.43.0


