Return-Path: <linux-fsdevel+bounces-31079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A74849919DC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 21:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A022B216DA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 19:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413F615AD90;
	Sat,  5 Oct 2024 19:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="or0UVmXp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AA3231C90
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Oct 2024 19:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728155849; cv=none; b=A5XlOu7pkOvKL0O+Q2Rx2FNkL8NnN71J/tBD0kiGYTgFS7bBpGUK549M8a/0jYFZacS6eqitIQ5sphWhU2A2KjjwuTytkvdn8myjRfPkD39PfLxSvgmOu9hM/pyJoM/HObvD0KXacr2gvU21Ky9JlThU56uMXFMWRInF6JxrzmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728155849; c=relaxed/simple;
	bh=tqccy1IxHvI3nqrBN37wvGnVxn9kFVyR0JOL1B3s+UM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=shZYYK6iD+VfTs+FtMEQgdLDSXk7vLgDOjdiOxQRsBzSZSu96sTQaST7fNlv5tyVtYWTUtOwB4iW3rt9kJheb1Qv3yJo2v/D6NnqDKmseNamOZDavwlkEo+3Sz9rmi18QXmadEHmOmzrVvcaN3U5Tn5QRybpp2yeV5Rjl4r8rnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=or0UVmXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259B3C4CECE;
	Sat,  5 Oct 2024 19:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728155849;
	bh=tqccy1IxHvI3nqrBN37wvGnVxn9kFVyR0JOL1B3s+UM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=or0UVmXpMXyV13Wq1i0qQnajyf1Q3lE8rBdP8Q0X0vJcPjD7oIy+1pPCGSAPSYUz6
	 4qzj5hnk/Lxelea+E7gq4o2I99XPRA6M5hbHt48x6FU+ohZEUKEMcGo2WlwV8gh409
	 /unsvM9ouapg/TE66rE5EDretj2sAk5KST5+/ThoNwTnu/WB/XTO99Y/E41qRlwA0R
	 1VTKOlHbwcjdl6AR3Qz9mrj1olMvWYKNIk09OQ+ASUFr7dDJYDsUPvJqX4z0XS/lJG
	 aq6XiGu/C0iZjxfa18N5+c8tUVQtPdCNBeMfB2d+tN5Kt5wMeDbLbwcjwZ9qYBJ8+D
	 L5Vx+FzOo5o9Q==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 05 Oct 2024 21:16:46 +0200
Subject: [PATCH RFC 3/4] rcuref: add rcuref_long_*() helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241005-brauner-file-rcuref-v1-3-725d5e713c86@kernel.org>
References: <20241005-brauner-file-rcuref-v1-0-725d5e713c86@kernel.org>
In-Reply-To: <20241005-brauner-file-rcuref-v1-0-725d5e713c86@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
 Jann Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=10467; i=brauner@kernel.org;
 h=from:subject:message-id; bh=tqccy1IxHvI3nqrBN37wvGnVxn9kFVyR0JOL1B3s+UM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQzTjhsuKX+TVfdp0cbV+n9y2//kH1xzWmrFUUBC7eFc
 vz/yx5b3VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARn0OMDBNVtljxvNyrxMzf
 vIFPYYJLgKHCt4/79P7dnLPBcHrquiyGf8ZcbK53NjjbLeraIOuy+srrBQc6fq0Sfxotr6SWL64
 UzQUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a variant of rcuref helpers that operate on atomic_long_t instead of
atomic_t so rcuref can be used for data structures that require
atomic_long_t.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/rcuref_long.h | 165 ++++++++++++++++++++++++++++++++++++++++++++
 lib/rcuref.c                | 104 ++++++++++++++++++++++++++++
 2 files changed, 269 insertions(+)

diff --git a/include/linux/rcuref_long.h b/include/linux/rcuref_long.h
new file mode 100644
index 0000000000000000000000000000000000000000..7cedc537e5268e114f1a4221a4f1b0cb8d0e1241
--- /dev/null
+++ b/include/linux/rcuref_long.h
@@ -0,0 +1,165 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _LINUX_RCUREF_LONG_H
+#define _LINUX_RCUREF_LONG_H
+
+#include <linux/atomic.h>
+#include <linux/bug.h>
+#include <linux/limits.h>
+#include <linux/lockdep.h>
+#include <linux/preempt.h>
+#include <linux/rcupdate.h>
+#include <linux/rcuref.h>
+
+#ifdef CONFIG_64BIT
+#define RCUREF_LONG_ONEREF	0x0000000000000000U
+#define RCUREF_LONG_MAXREF	0x7FFFFFFFFFFFFFFFU
+#define RCUREF_LONG_SATURATED   0xA000000000000000U
+#define RCUREF_LONG_RELEASED    0xC000000000000000U
+#define RCUREF_LONG_DEAD	0xE000000000000000U
+#define RCUREF_LONG_NOREF	0xFFFFFFFFFFFFFFFFU
+#else
+#define RCUREF_LONG_ONEREF	RCUREF_ONEREF
+#define RCUREF_LONG_MAXREF	RCUREF_MAXREF
+#define RCUREF_LONG_SATURATED	RCUREF_SATURATED
+#define RCUREF_LONG_RELEASED	RCUREF_RELEASED
+#define RCUREF_LONG_DEAD	RCUREF_DEAD
+#define RCUREF_LONG_NOREF	RCUREF_NOREF
+#endif
+
+/**
+ * rcuref_long_init - Initialize a rcuref reference count with the given reference count
+ * @ref:	Pointer to the reference count
+ * @cnt:	The initial reference count typically '1'
+ */
+static inline void rcuref_long_init(rcuref_long_t *ref, unsigned long cnt)
+{
+	atomic_long_set(&ref->refcnt, cnt - 1);
+}
+
+/**
+ * rcuref_long_read - Read the number of held reference counts of a rcuref
+ * @ref:	Pointer to the reference count
+ *
+ * Return: The number of held references (0 ... N)
+ */
+static inline unsigned long rcuref_long_read(rcuref_long_t *ref)
+{
+	unsigned long c = atomic_long_read(&ref->refcnt);
+
+	/* Return 0 if within the DEAD zone. */
+	return c >= RCUREF_LONG_RELEASED ? 0 : c + 1;
+}
+
+__must_check bool rcuref_long_get_slowpath(rcuref_long_t *ref);
+
+/**
+ * rcuref_long_get - Acquire one reference on a rcuref reference count
+ * @ref:	Pointer to the reference count
+ *
+ * Similar to atomic_long_inc_not_zero() but saturates at RCUREF_LONG_MAXREF.
+ *
+ * Provides no memory ordering, it is assumed the caller has guaranteed the
+ * object memory to be stable (RCU, etc.). It does provide a control dependency
+ * and thereby orders future stores. See documentation in lib/rcuref.c
+ *
+ * Return:
+ *	False if the attempt to acquire a reference failed. This happens
+ *	when the last reference has been put already
+ *
+ *	True if a reference was successfully acquired
+ */
+static inline __must_check bool rcuref_long_get(rcuref_long_t *ref)
+{
+	/*
+	 * Unconditionally increase the reference count. The saturation and
+	 * dead zones provide enough tolerance for this.
+	 */
+	if (likely(!atomic_long_add_negative_relaxed(1, &ref->refcnt)))
+		return true;
+
+	/* Handle the cases inside the saturation and dead zones */
+	return rcuref_long_get_slowpath(ref);
+}
+
+__must_check bool rcuref_long_put_slowpath(rcuref_long_t *ref);
+
+/*
+ * Internal helper. Do not invoke directly.
+ */
+static __always_inline __must_check bool __rcuref_long_put(rcuref_long_t *ref)
+{
+	RCU_LOCKDEP_WARN(!rcu_read_lock_held() && preemptible(),
+			 "suspicious rcuref_put_rcusafe() usage");
+	/*
+	 * Unconditionally decrease the reference count. The saturation and
+	 * dead zones provide enough tolerance for this.
+	 */
+	if (likely(!atomic_long_add_negative_release(-1, &ref->refcnt)))
+		return false;
+
+	/*
+	 * Handle the last reference drop and cases inside the saturation
+	 * and dead zones.
+	 */
+	return rcuref_long_put_slowpath(ref);
+}
+
+/**
+ * rcuref_long_put_rcusafe -- Release one reference for a rcuref reference count RCU safe
+ * @ref:	Pointer to the reference count
+ *
+ * Provides release memory ordering, such that prior loads and stores are done
+ * before, and provides an acquire ordering on success such that free()
+ * must come after.
+ *
+ * Can be invoked from contexts, which guarantee that no grace period can
+ * happen which would free the object concurrently if the decrement drops
+ * the last reference and the slowpath races against a concurrent get() and
+ * put() pair. rcu_read_lock()'ed and atomic contexts qualify.
+ *
+ * Return:
+ *	True if this was the last reference with no future references
+ *	possible. This signals the caller that it can safely release the
+ *	object which is protected by the reference counter.
+ *
+ *	False if there are still active references or the put() raced
+ *	with a concurrent get()/put() pair. Caller is not allowed to
+ *	release the protected object.
+ */
+static inline __must_check bool rcuref_long_put_rcusafe(rcuref_long_t *ref)
+{
+	return __rcuref_long_put(ref);
+}
+
+/**
+ * rcuref_long_put -- Release one reference for a rcuref reference count
+ * @ref:	Pointer to the reference count
+ *
+ * Can be invoked from any context.
+ *
+ * Provides release memory ordering, such that prior loads and stores are done
+ * before, and provides an acquire ordering on success such that free()
+ * must come after.
+ *
+ * Return:
+ *
+ *	True if this was the last reference with no future references
+ *	possible. This signals the caller that it can safely schedule the
+ *	object, which is protected by the reference counter, for
+ *	deconstruction.
+ *
+ *	False if there are still active references or the put() raced
+ *	with a concurrent get()/put() pair. Caller is not allowed to
+ *	deconstruct the protected object.
+ */
+static inline __must_check bool rcuref_long_put(rcuref_long_t *ref)
+{
+	bool released;
+
+	preempt_disable();
+	released = __rcuref_long_put(ref);
+	preempt_enable();
+	return released;
+}
+
+#endif
diff --git a/lib/rcuref.c b/lib/rcuref.c
index 97f300eca927ced7f36fe0c932d2a9d3759809b8..01a4c317c8bb7ff24632334ddb4520aa79aa46f3 100644
--- a/lib/rcuref.c
+++ b/lib/rcuref.c
@@ -176,6 +176,7 @@
 
 #include <linux/export.h>
 #include <linux/rcuref.h>
+#include <linux/rcuref_long.h>
 
 /**
  * rcuref_get_slowpath - Slowpath of rcuref_get()
@@ -217,6 +218,46 @@ bool rcuref_get_slowpath(rcuref_t *ref)
 }
 EXPORT_SYMBOL_GPL(rcuref_get_slowpath);
 
+/**
+ * rcuref_long_get_slowpath - Slowpath of rcuref_long_get()
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
+bool rcuref_long_get_slowpath(rcuref_long_t *ref)
+{
+	unsigned long cnt = atomic_long_read(&ref->refcnt);
+
+	/*
+	 * If the reference count was already marked dead, undo the
+	 * increment so it stays in the middle of the dead zone and return
+	 * fail.
+	 */
+	if (cnt >= RCUREF_LONG_RELEASED) {
+		atomic_long_set(&ref->refcnt, RCUREF_LONG_DEAD);
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
+	if (WARN_ONCE(cnt > RCUREF_LONG_MAXREF, "rcuref saturated - leaking memory"))
+		atomic_long_set(&ref->refcnt, RCUREF_LONG_SATURATED);
+	return true;
+}
+EXPORT_SYMBOL_GPL(rcuref_long_get_slowpath);
+
 /**
  * rcuref_put_slowpath - Slowpath of __rcuref_put()
  * @ref:	Pointer to the reference count
@@ -279,3 +320,66 @@ bool rcuref_put_slowpath(rcuref_t *ref)
 	return false;
 }
 EXPORT_SYMBOL_GPL(rcuref_put_slowpath);
+
+/**
+ * rcuref_long_put_slowpath - Slowpath of __rcuref_long_put()
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
+bool rcuref_long_put_slowpath(rcuref_long_t *ref)
+{
+	unsigned long cnt = atomic_long_read(&ref->refcnt);
+
+	/* Did this drop the last reference? */
+	if (likely(cnt == RCUREF_LONG_NOREF)) {
+		/*
+		 * Carefully try to set the reference count to RCUREF_LONG_DEAD.
+		 *
+		 * This can fail if a concurrent get() operation has
+		 * elevated it again or the corresponding put() even marked
+		 * it dead already. Both are valid situations and do not
+		 * require a retry. If this fails the caller is not
+		 * allowed to deconstruct the object.
+		 */
+		if (!atomic_long_try_cmpxchg_release(&ref->refcnt, &cnt, RCUREF_LONG_DEAD))
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
+	if (WARN_ONCE(cnt >= RCUREF_LONG_RELEASED, "rcuref - imbalanced put()")) {
+		atomic_long_set(&ref->refcnt, RCUREF_LONG_DEAD);
+		return false;
+	}
+
+	/*
+	 * This is a put() operation on a saturated refcount. Restore the
+	 * mean saturation value and tell the caller to not deconstruct the
+	 * object.
+	 */
+	if (cnt > RCUREF_LONG_MAXREF)
+		atomic_long_set(&ref->refcnt, RCUREF_LONG_SATURATED);
+	return false;
+}
+EXPORT_SYMBOL_GPL(rcuref_long_put_slowpath);

-- 
2.45.2


