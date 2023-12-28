Return-Path: <linux-fsdevel+bounces-7010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB0081FB97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 23:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9049528571F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 22:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0555610A05;
	Thu, 28 Dec 2023 22:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KHXXKQZp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9EB107BC;
	Thu, 28 Dec 2023 22:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kQ+uKuyxhmcjSMG7LN+mZVJSxMAB8MaVFuhiW7JiPfc=; b=KHXXKQZpOt9etWodUQCdGaQE2b
	9KJWxMzCTUUh3sxe3Y75CnkuzFp+l8AW3f2sSmKRCwanS720bp2Un6aHnAfX/z9/JtIRsMh/ypcC5
	HGPs9M3qxsME+51W0rachnSOIb1ljosSCeax34cSZhyDvMN9xXfGsgmfoJ07Tp04fdpCh7WOs94G3
	lDJy6Gv/cJRx890dse2nws3lBy7fN4fiz2GxWU+PvZ9Z1byTi2FrmfL2YqA9W/iWUnz91UC/s61J2
	rSp8EQVu0uwUogN9IGCIUxZNxIetjAEg0lVuPElVdTrxavbxOqCYBBf5UhihqmCqxUVyPc7jTGZDF
	27uLB1Mg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rIyjT-005dpL-R0; Thu, 28 Dec 2023 22:20:03 +0000
Date: Thu, 28 Dec 2023 22:20:03 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Maria Yu <quic_aiquny@quicinc.com>, kernel@quicinc.com,
	quic_pkondeti@quicinc.com, keescook@chromium.or,
	viro@zeniv.linux.org.uk, brauner@kernel.org, oleg@redhat.com,
	dhowells@redhat.com, jarkko@kernel.org, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] kernel: Introduce a write lock/unlock wrapper for
 tasklist_lock
Message-ID: <ZY30k7OCtxrdR9oP@casper.infradead.org>
References: <20231213101745.4526-1-quic_aiquny@quicinc.com>
 <ZXnaNSrtaWbS2ivU@casper.infradead.org>
 <87o7eu7ybq.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7eu7ybq.fsf@email.froward.int.ebiederm.org>

On Wed, Dec 13, 2023 at 12:27:05PM -0600, Eric W. Biederman wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> > I think the right way to fix this is to pass a boolean flag to
> > queued_write_lock_slowpath() to let it know whether it can re-enable
> > interrupts while checking whether _QW_WAITING is set.
> 
> Yes.  It seems to make sense to distinguish between write_lock_irq and
> write_lock_irqsave and fix this for all of write_lock_irq.

I wasn't planning on doing anything here, but Hillf kind of pushed me into
it.  I think it needs to be something like this.  Compile tested only.
If it ends up getting used,

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
index 75b8f4601b28..1152e080c719 100644
--- a/include/asm-generic/qrwlock.h
+++ b/include/asm-generic/qrwlock.h
@@ -33,8 +33,8 @@
 /*
  * External function declarations
  */
-extern void queued_read_lock_slowpath(struct qrwlock *lock);
-extern void queued_write_lock_slowpath(struct qrwlock *lock);
+void queued_read_lock_slowpath(struct qrwlock *lock);
+void queued_write_lock_slowpath(struct qrwlock *lock, bool irq);
 
 /**
  * queued_read_trylock - try to acquire read lock of a queued rwlock
@@ -98,7 +98,21 @@ static inline void queued_write_lock(struct qrwlock *lock)
 	if (likely(atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED)))
 		return;
 
-	queued_write_lock_slowpath(lock);
+	queued_write_lock_slowpath(lock, false);
+}
+
+/**
+ * queued_write_lock_irq - acquire write lock of a queued rwlock
+ * @lock : Pointer to queued rwlock structure
+ */
+static inline void queued_write_lock_irq(struct qrwlock *lock)
+{
+	int cnts = 0;
+	/* Optimize for the unfair lock case where the fair flag is 0. */
+	if (likely(atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED)))
+		return;
+
+	queued_write_lock_slowpath(lock, true);
 }
 
 /**
@@ -138,6 +152,7 @@ static inline int queued_rwlock_is_contended(struct qrwlock *lock)
  */
 #define arch_read_lock(l)		queued_read_lock(l)
 #define arch_write_lock(l)		queued_write_lock(l)
+#define arch_write_lock_irq(l)		queued_write_lock_irq(l)
 #define arch_read_trylock(l)		queued_read_trylock(l)
 #define arch_write_trylock(l)		queued_write_trylock(l)
 #define arch_read_unlock(l)		queued_read_unlock(l)
diff --git a/include/linux/rwlock.h b/include/linux/rwlock.h
index c0ef596f340b..897010b6ba0a 100644
--- a/include/linux/rwlock.h
+++ b/include/linux/rwlock.h
@@ -33,6 +33,7 @@ do {								\
  extern int do_raw_read_trylock(rwlock_t *lock);
  extern void do_raw_read_unlock(rwlock_t *lock) __releases(lock);
  extern void do_raw_write_lock(rwlock_t *lock) __acquires(lock);
+ extern void do_raw_write_lock_irq(rwlock_t *lock) __acquires(lock);
  extern int do_raw_write_trylock(rwlock_t *lock);
  extern void do_raw_write_unlock(rwlock_t *lock) __releases(lock);
 #else
@@ -40,6 +41,7 @@ do {								\
 # define do_raw_read_trylock(rwlock)	arch_read_trylock(&(rwlock)->raw_lock)
 # define do_raw_read_unlock(rwlock)	do {arch_read_unlock(&(rwlock)->raw_lock); __release(lock); } while (0)
 # define do_raw_write_lock(rwlock)	do {__acquire(lock); arch_write_lock(&(rwlock)->raw_lock); } while (0)
+# define do_raw_write_lock_irq(rwlock)	do {__acquire(lock); arch_write_lock_irq(&(rwlock)->raw_lock); } while (0)
 # define do_raw_write_trylock(rwlock)	arch_write_trylock(&(rwlock)->raw_lock)
 # define do_raw_write_unlock(rwlock)	do {arch_write_unlock(&(rwlock)->raw_lock); __release(lock); } while (0)
 #endif
diff --git a/include/linux/rwlock_api_smp.h b/include/linux/rwlock_api_smp.h
index dceb0a59b692..6257976dfb72 100644
--- a/include/linux/rwlock_api_smp.h
+++ b/include/linux/rwlock_api_smp.h
@@ -193,7 +193,7 @@ static inline void __raw_write_lock_irq(rwlock_t *lock)
 	local_irq_disable();
 	preempt_disable();
 	rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
-	LOCK_CONTENDED(lock, do_raw_write_trylock, do_raw_write_lock);
+	LOCK_CONTENDED(lock, do_raw_write_trylock, do_raw_write_lock_irq);
 }
 
 static inline void __raw_write_lock_bh(rwlock_t *lock)
diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index d2ef312a8611..6c644a71b01d 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -61,9 +61,10 @@ EXPORT_SYMBOL(queued_read_lock_slowpath);
 
 /**
  * queued_write_lock_slowpath - acquire write lock of a queued rwlock
- * @lock : Pointer to queued rwlock structure
+ * @lock: Pointer to queued rwlock structure
+ * @irq: True if we can enable interrupts while spinning
  */
-void __lockfunc queued_write_lock_slowpath(struct qrwlock *lock)
+void __lockfunc queued_write_lock_slowpath(struct qrwlock *lock, bool irq)
 {
 	int cnts;
 
@@ -82,7 +83,11 @@ void __lockfunc queued_write_lock_slowpath(struct qrwlock *lock)
 
 	/* When no more readers or writers, set the locked flag */
 	do {
+		if (irq)
+			local_irq_enable();
 		cnts = atomic_cond_read_relaxed(&lock->cnts, VAL == _QW_WAITING);
+		if (irq)
+			local_irq_disable();
 	} while (!atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED));
 unlock:
 	arch_spin_unlock(&lock->wait_lock);
diff --git a/kernel/locking/spinlock_debug.c b/kernel/locking/spinlock_debug.c
index 87b03d2e41db..bf94551d7435 100644
--- a/kernel/locking/spinlock_debug.c
+++ b/kernel/locking/spinlock_debug.c
@@ -212,6 +212,13 @@ void do_raw_write_lock(rwlock_t *lock)
 	debug_write_lock_after(lock);
 }
 
+void do_raw_write_lock_irq(rwlock_t *lock)
+{
+	debug_write_lock_before(lock);
+	arch_write_lock_irq(&lock->raw_lock);
+	debug_write_lock_after(lock);
+}
+
 int do_raw_write_trylock(rwlock_t *lock)
 {
 	int ret = arch_write_trylock(&lock->raw_lock);

