Return-Path: <linux-fsdevel+bounces-31193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B63C992F06
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 16:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E31B1282002
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 14:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64C01D6DB9;
	Mon,  7 Oct 2024 14:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDwK+8wI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D7E1D363A
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 14:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311078; cv=none; b=E0HJYoqUS7ccs2e1G6q2f9DosqrfOlmecdESS8gewkpMYb3E1ljjpWU0XYOzd+Cdby+3folHJgpMBAollDHBAeEA3Z7/mOi1l/qOPwfnJOD6+2pm5ecbfQncrXEJWAvB5uAW8WHGpkxTmuflzJP2srkDFAGNG0K51ktTyCoKXko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311078; c=relaxed/simple;
	bh=8R3Ppx/qVhsE4sDKFFpGR2v6Jr0VnrQwdYP/9tGhGWI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=URFRuts3pknfiiXEgQOEBiUoX73tf1rRL4HHLpZ63ntu360Pt/Ruo78t/kB9bdqks+CUROX8ZKO1UcPJ/8D2ObU8OVAnXTsPVStaFcOMF2Gt17DI6Np513WPrfRJc5NrtYYzHx0zRm+/zZ4NzsYC1VVVMP/MVxU/SmyXeaiq3gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDwK+8wI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F6EC4CEC6;
	Mon,  7 Oct 2024 14:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728311077;
	bh=8R3Ppx/qVhsE4sDKFFpGR2v6Jr0VnrQwdYP/9tGhGWI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aDwK+8wIgbbXGOn5bk7q6TcENrB6WmCiBv/wTNbGycHQR9Fk93I1xVwIIisTsR0aj
	 7GAqPsUgoRH5qF/i8iGiz6Dux121Dz9Sv5bEoJ4hK7Yms2DqdfGgKQoa+Ks5ghQj+H
	 LzLAzQVIRg4SBHBaQWG152SCQWQ/ITuNu7J86mgmj7VB2+X4SUtpzdjGMFzyJwP5uh
	 rGQOmh2G8CKBlV9UDjQCA6Ylvsi7bMTIqf5RDDr+DGYwpNbuOWDUTpv/8MqoWhM+7U
	 jCGcl0ujaqkrmVvKdKpHKFhXKTP/XlmckBtQfZDn2a14F9ZAw9JTo+r3/IDBAizERy
	 YKlcm5iO/ko5A==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 07 Oct 2024 16:23:58 +0200
Subject: [PATCH v2 2/3] fs: add file_ref
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-brauner-file-rcuref-v2-2-387e24dc9163@kernel.org>
References: <20241007-brauner-file-rcuref-v2-0-387e24dc9163@kernel.org>
In-Reply-To: <20241007-brauner-file-rcuref-v2-0-387e24dc9163@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=14049; i=brauner@kernel.org;
 h=from:subject:message-id; bh=8R3Ppx/qVhsE4sDKFFpGR2v6Jr0VnrQwdYP/9tGhGWI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQzv1f8wbYy51j//icKB9Yf2jSHoc/TxSY9s27Z5Y7qd
 e37XpWqdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEdxMjQ6PxVf/lc/a/3Zjy
 bNaDmj+/rjwtTPp/tkkz8ZF4Wczy3mMM/0Ny1/R0e+jPcv2pzlMp/HCKhADn0ZvFkts/qwQkvos
 v5AIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

As atomic_inc_not_zero() is implemented with a try_cmpxchg() loop it has
O(N^2) behaviour under contention with N concurrent operations and it is
in a hot path in __fget_files_rcu().

The rcuref infrastructures remedies this problem by using an
unconditional increment relying on safe- and dead zones to make this
work and requiring rcu protection for the data structure in question.
This not just scales better it also introduces overflow protection.

However, in contrast to generic rcuref, files require a memory barrier
and thus cannot rely on *_relaxed() atomic operations and also require
to be built on atomic_long_t as having massive amounts of reference
isn't unheard of even if it is just an attack.

As suggested by Linus, add a file specific variant instead of making
this a generic library.

Files are SLAB_TYPESAFE_BY_RCU and thus don't have "regular" rcu
protection. In short, freeing of files isn't delayed until a grace
period has elapsed. Instead, they are freed immediately and thus can be
reused (multiple times) within the same grace period.

So when picking a file from the file descriptor table via its file
descriptor number it is thus possible to see an elevated reference count
on file->f_count even though the file has already been recycled possibly
multiple times by another task.

To guard against this the vfs will pick the file from the file
descriptor table twice. Once before the refcount increment and once
after to compare the pointers (grossly simplified). If they match then
the file is still valid. If not the caller needs to fput() it.

The unconditional increment makes the following race possible as
illustrated by rcuref:

> Deconstruction race
> ===================
>
> The release operation must be protected by prohibiting a grace period in
> order to prevent a possible use after free:
>
>      T1                              T2
>      put()                           get()
>      // ref->refcnt = ONEREF
>      if (!atomic_add_negative(-1, &ref->refcnt))
>              return false;                           <- Not taken
>
>      // ref->refcnt == NOREF
>      --> preemption
>                                      // Elevates ref->refcnt to ONEREF
>                                      if (!atomic_add_negative(1, &ref->refcnt))
>                                              return true;                    <- taken
>
>                                      if (put(&p->ref)) { <-- Succeeds
>                                              remove_pointer(p);
>                                              kfree_rcu(p, rcu);
>                                      }
>
>              RCU grace period ends, object is freed
>
>      atomic_cmpxchg(&ref->refcnt, NOREF, DEAD);      <- UAF
>
> [...] it prevents the grace period which keeps the object alive until
> all put() operations complete.

Having files by SLAB_TYPESAFE_BY_RCU shouldn't cause any problems for
this deconstruction race. Afaict, the only interesting case would be
someone freeing the file and someone immediately recycling it within the
same grace period and reinitializing file->f_count to ONEREF while a
concurrent fput() is doing atomic_cmpxchg(&ref->refcnt, NOREF, DEAD) as
in the race above.

But this is safe from SLAB_TYPESAFE_BY_RCU's perspective and it should
be safe from rcuref's perspective.

      T1                              T2                                                    T3
      fput()                          fget()
      // f_count->refcnt = ONEREF
      if (!atomic_add_negative(-1, &f_count->refcnt))
              return false;                           <- Not taken

      // f_count->refcnt == NOREF
      --> preemption
                                      // Elevates f_count->refcnt to ONEREF
                                      if (!atomic_add_negative(1, &f_count->refcnt))
                                              return true;                    <- taken

                                      if (put(&f_count)) { <-- Succeeds
                                              remove_pointer(p);
                                              /*
                                               * Cache is SLAB_TYPESAFE_BY_RCU
                                               * so this is freed without a grace period.
                                               */
                                              kmem_cache_free(p);
                                      }

                                                                                             kmem_cache_alloc()
                                                                                             init_file() {
                                                                                                     // Sets f_count->refcnt to ONEREF
                                                                                                     rcuref_long_init(&f->f_count, 1);
                                                                                             }

                        Object has been reused within the same grace period
                        via kmem_cache_alloc()'s SLAB_TYPESAFE_BY_RCU.

      /*
       * With SLAB_TYPESAFE_BY_RCU this would be a safe UAF access and
       * it would work correctly because the atomic_cmpxchg()
       * will fail because the refcount has been reset to ONEREF by T3.
       */
      atomic_cmpxchg(&ref->refcnt, NOREF, DEAD);      <- UAF

I've been testing this with will-it-scale using fstat() on a machine
that Jens gave me access (thank you very much!):

processor       : 511
vendor_id       : AuthenticAMD
cpu family      : 25
model           : 160
model name      : AMD EPYC 9754 128-Core Processor

and I consistently get a 3-5% improvement on 256+ threads.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/file.c                | 106 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/file_ref.h | 116 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 222 insertions(+)

diff --git a/fs/file.c b/fs/file.c
index 5125607d040a2ff073e170d043124db5f444a90a..1b5fc867d8ddff856501ba49d8c751f888810330 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -20,10 +20,116 @@
 #include <linux/spinlock.h>
 #include <linux/rcupdate.h>
 #include <linux/close_range.h>
+#include <linux/file_ref.h>
 #include <net/sock.h>
 
 #include "internal.h"
 
+/**
+ * __file_ref_get - Slowpath of file_ref_get()
+ * @ref:	Pointer to the reference count
+ *
+ * Invoked when the reference count is outside of the valid zone.
+ *
+ * Return:
+ *	False if the reference count was already marked dead
+ *
+ *	True if the reference count is saturated, which prevents the
+ *	object from being deconstructed ever.
+ */
+bool __file_ref_get(file_ref_t *ref)
+{
+	unsigned long cnt;
+
+	/*
+	 * If the reference count was already marked dead, undo the
+	 * increment so it stays in the middle of the dead zone and return
+	 * fail.
+	 */
+	cnt = atomic_long_read(&ref->refcnt);
+	if (cnt >= FILE_REF_RELEASED) {
+		atomic_long_set(&ref->refcnt, FILE_REF_DEAD);
+		return false;
+	}
+
+	/*
+	 * If it was saturated, warn and mark it so. In case the increment
+	 * was already on a saturated value restore the saturation
+	 * marker. This keeps it in the middle of the saturation zone and
+	 * prevents the reference count from overflowing. This leaks the
+	 * object memory, but prevents the obvious reference count overflow
+	 * damage.
+	 */
+	if (WARN_ONCE(cnt > FILE_REF_MAXREF, "leaking memory because file reference count is saturated"))
+		atomic_long_set(&ref->refcnt, FILE_REF_SATURATED);
+	return true;
+}
+EXPORT_SYMBOL_GPL(__file_ref_get);
+
+/**
+ * __file_ref_put - Slowpath of file_ref_put()
+ * @ref:	Pointer to the reference count
+ *
+ * Invoked when the reference count is outside of the valid zone.
+ *
+ * Return:
+ *	True if this was the last reference with no future references
+ *	possible. This signals the caller that it can safely schedule the
+ *	object, which is protected by the reference counter, for
+ *	deconstruction.
+ *
+ *	False if there are still active references or the put() raced
+ *	with a concurrent get()/put() pair. Caller is not allowed to
+ *	deconstruct the protected object.
+ */
+bool __file_ref_put(file_ref_t *ref)
+{
+	unsigned long cnt;
+
+	/* Did this drop the last reference? */
+	cnt = atomic_long_read(&ref->refcnt);
+	if (likely(cnt == FILE_REF_NOREF)) {
+		/*
+		 * Carefully try to set the reference count to FILE_REF_DEAD.
+		 *
+		 * This can fail if a concurrent get() operation has
+		 * elevated it again or the corresponding put() even marked
+		 * it dead already. Both are valid situations and do not
+		 * require a retry. If this fails the caller is not
+		 * allowed to deconstruct the object.
+		 */
+		if (!atomic_long_try_cmpxchg_release(&ref->refcnt, &cnt, FILE_REF_DEAD))
+			return false;
+
+		/*
+		 * The caller can safely schedule the object for
+		 * deconstruction. Provide acquire ordering.
+		 */
+		smp_acquire__after_ctrl_dep();
+		return true;
+	}
+
+	/*
+	 * If the reference count was already in the dead zone, then this
+	 * put() operation is imbalanced. Warn, put the reference count back to
+	 * DEAD and tell the caller to not deconstruct the object.
+	 */
+	if (WARN_ONCE(cnt >= FILE_REF_RELEASED, "imbalanced put on file reference count")) {
+		atomic_long_set(&ref->refcnt, FILE_REF_DEAD);
+		return false;
+	}
+
+	/*
+	 * This is a put() operation on a saturated refcount. Restore the
+	 * mean saturation value and tell the caller to not deconstruct the
+	 * object.
+	 */
+	if (cnt > FILE_REF_MAXREF)
+		atomic_long_set(&ref->refcnt, FILE_REF_SATURATED);
+	return false;
+}
+EXPORT_SYMBOL_GPL(__file_ref_put);
+
 unsigned int sysctl_nr_open __read_mostly = 1024*1024;
 unsigned int sysctl_nr_open_min = BITS_PER_LONG;
 /* our min() is unusable in constant expressions ;-/ */
diff --git a/include/linux/file_ref.h b/include/linux/file_ref.h
new file mode 100644
index 0000000000000000000000000000000000000000..ff3f36eac0efffd21f6298c42102e41c1422212d
--- /dev/null
+++ b/include/linux/file_ref.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _LINUX_FILE_REF_H
+#define _LINUX_FILE_REF_H
+
+#ifdef CONFIG_64BIT
+#define FILE_REF_ONEREF		0x0000000000000000U
+#define FILE_REF_MAXREF		0x7FFFFFFFFFFFFFFFU
+#define FILE_REF_SATURATED	0xA000000000000000U
+#define FILE_REF_RELEASED	0xC000000000000000U
+#define FILE_REF_DEAD		0xE000000000000000U
+#define FILE_REF_NOREF		0xFFFFFFFFFFFFFFFFU
+#else
+#define FILE_REF_ONEREF		0x00000000U
+#define FILE_REF_MAXREF		0x7FFFFFFFU
+#define FILE_REF_SATURATED	0xA0000000U
+#define FILE_REF_RELEASED	0xC0000000U
+#define FILE_REF_DEAD		0xE0000000U
+#define FILE_REF_NOREF		0xFFFFFFFFU
+#endif
+
+typedef struct {
+#ifdef CONFIG_64BIT
+	atomic64_t refcnt;
+#else
+	atomic_t refcnt;
+#endif
+} file_ref_t;
+
+/**
+ * file_ref_init - Initialize a file reference count
+ * @ref: Pointer to the reference count
+ * @cnt: The initial reference count typically '1'
+ */
+static inline void file_ref_init(file_ref_t *ref, unsigned long cnt)
+{
+	atomic_long_set(&ref->refcnt, cnt - 1);
+}
+
+bool __file_ref_get(file_ref_t *ref);
+bool __file_ref_put(file_ref_t *ref);
+
+/**
+ * file_ref_get - Acquire one reference on a file
+ * @ref: Pointer to the reference count
+ *
+ * Similar to atomic_inc_not_zero() but saturates at FILE_REF_MAXREF.
+ *
+ * Provides full memory ordering.
+ *
+ * Return: False if the attempt to acquire a reference failed. This happens
+ *         when the last reference has been put already. True if a reference
+ *         was successfully acquired
+ */
+static __always_inline __must_check bool file_ref_get(file_ref_t *ref)
+{
+	/*
+	 * Unconditionally increase the reference count with full
+	 * ordering. The saturation and dead zones provide enough
+	 * tolerance for this.
+	 */
+	if (likely(!atomic_long_add_negative(1, &ref->refcnt)))
+		return true;
+
+	/* Handle the cases inside the saturation and dead zones */
+	return __file_ref_get(ref);
+}
+
+/**
+ * file_ref_put -- Release a file reference
+ * @ref:	Pointer to the reference count
+ *
+ * Provides release memory ordering, such that prior loads and stores
+ * are done before, and provides an acquire ordering on success such
+ * that free() must come after.
+ *
+ * Return: True if this was the last reference with no future references
+ *         possible. This signals the caller that it can safely release
+ *         the object which is protected by the reference counter.
+ *         False if there are still active references or the put() raced
+ *         with a concurrent get()/put() pair. Caller is not allowed to
+ *         release the protected object.
+ */
+static __always_inline __must_check bool file_ref_put(file_ref_t *ref)
+{
+	bool released;
+
+	preempt_disable();
+	/*
+	 * Unconditionally decrease the reference count. The saturation
+	 * and dead zones provide enough tolerance for this. If this
+	 * fails then we need to handle the last reference drop and
+	 * cases inside the saturation and dead zones.
+	 */
+	if (likely(!atomic_long_add_negative_release(-1, &ref->refcnt)))
+		released = false;
+	else
+		released = __file_ref_put(ref);
+	preempt_enable();
+	return released;
+}
+
+/**
+ * file_ref_read - Read the number of file references
+ * @ref: Pointer to the reference count
+ *
+ * Return: The number of held references (0 ... N)
+ */
+static inline unsigned long file_ref_read(file_ref_t *ref)
+{
+	unsigned long c = atomic_long_read(&ref->refcnt);
+
+	/* Return 0 if within the DEAD zone. */
+	return c >= FILE_REF_RELEASED ? 0 : c + 1;
+}
+
+#endif

-- 
2.45.2


