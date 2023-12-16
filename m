Return-Path: <linux-fsdevel+bounces-6260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6DE8156C7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAD732855EF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF61182C4;
	Sat, 16 Dec 2023 03:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Lj55Mo0L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7A714018
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 03:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2XkiID2+CLzOQYD7Bz1wsynJpFZEAYT3tSVjrTRZ4z8=;
	b=Lj55Mo0LMcD929wkauv0VAl43vVATsnzWM+J3oGUI/ar0ExbibBATJI9Ex1s17yuwcQsEq
	z1vlDGtmUVc6CIIBXy7jDvdn59nvo3wlVAKYmzivDHXAQEtV4qXJrU/UMbfyh12jJZMo78
	pWac8uDIn1XU0PF37u7zF7u+nQIdi+U=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	tglx@linutronix.de,
	x86@kernel.org,
	tj@kernel.org,
	peterz@infradead.org,
	mathieu.desnoyers@efficios.com,
	paulmck@kernel.org,
	keescook@chromium.org,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	will@kernel.org,
	longman@redhat.com,
	boqun.feng@gmail.com,
	brauner@kernel.org
Subject: [PATCH 16/50] sched.h: Move (spin|rwlock)_needbreak() to spinlock.h
Date: Fri, 15 Dec 2023 22:26:15 -0500
Message-ID: <20231216032651.3553101-6-kent.overstreet@linux.dev>
In-Reply-To: <20231216032651.3553101-1-kent.overstreet@linux.dev>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216032651.3553101-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This lets us kill the dependency on spinlock.h.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/sched.h    | 31 -------------------------------
 include/linux/spinlock.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5a5b7b122682..7501a3451a20 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2227,37 +2227,6 @@ static inline bool preempt_model_preemptible(void)
 	return preempt_model_full() || preempt_model_rt();
 }
 
-/*
- * Does a critical section need to be broken due to another
- * task waiting?: (technically does not depend on CONFIG_PREEMPTION,
- * but a general need for low latency)
- */
-static inline int spin_needbreak(spinlock_t *lock)
-{
-#ifdef CONFIG_PREEMPTION
-	return spin_is_contended(lock);
-#else
-	return 0;
-#endif
-}
-
-/*
- * Check if a rwlock is contended.
- * Returns non-zero if there is another task waiting on the rwlock.
- * Returns zero if the lock is not contended or the system / underlying
- * rwlock implementation does not support contention detection.
- * Technically does not depend on CONFIG_PREEMPTION, but a general need
- * for low latency.
- */
-static inline int rwlock_needbreak(rwlock_t *lock)
-{
-#ifdef CONFIG_PREEMPTION
-	return rwlock_is_contended(lock);
-#else
-	return 0;
-#endif
-}
-
 static __always_inline bool need_resched(void)
 {
 	return unlikely(tif_need_resched());
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 31d3d747a9db..0c71f06454d9 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -449,6 +449,37 @@ static __always_inline int spin_is_contended(spinlock_t *lock)
 	return raw_spin_is_contended(&lock->rlock);
 }
 
+/*
+ * Does a critical section need to be broken due to another
+ * task waiting?: (technically does not depend on CONFIG_PREEMPTION,
+ * but a general need for low latency)
+ */
+static inline int spin_needbreak(spinlock_t *lock)
+{
+#ifdef CONFIG_PREEMPTION
+	return spin_is_contended(lock);
+#else
+	return 0;
+#endif
+}
+
+/*
+ * Check if a rwlock is contended.
+ * Returns non-zero if there is another task waiting on the rwlock.
+ * Returns zero if the lock is not contended or the system / underlying
+ * rwlock implementation does not support contention detection.
+ * Technically does not depend on CONFIG_PREEMPTION, but a general need
+ * for low latency.
+ */
+static inline int rwlock_needbreak(rwlock_t *lock)
+{
+#ifdef CONFIG_PREEMPTION
+	return rwlock_is_contended(lock);
+#else
+	return 0;
+#endif
+}
+
 #define assert_spin_locked(lock)	assert_raw_spin_locked(&(lock)->rlock)
 
 #else  /* !CONFIG_PREEMPT_RT */
-- 
2.43.0


