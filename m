Return-Path: <linux-fsdevel+bounces-6287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 646A6815703
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D02F287D9C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F7C43AA0;
	Sat, 16 Dec 2023 03:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nijiqWnI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CBC42A8D
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 03:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/YlwF6jQl3AGWCNwHZroZiQJXLn/OA9Z6AEGkzv6HW8=;
	b=nijiqWnIMhK8D4E+Dsg3ln2Q7UPgn+yu9KR+e2JPEspKys0O6hVGLCnxi5pkYic8E9OCiG
	pGy+l2s15DaXeItKJ/if34iFAE3tHB6uBAO2eH431kKPbX4YcuQTfdhzqtTSV1ZoEFY5I6
	gbtEG/7AyCymx8o2Dy6NxS+GuSnt7YU=
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
Subject: [PATCH 43/50] lockdep: move held_lock to lockdep_types.h
Date: Fri, 15 Dec 2023 22:32:49 -0500
Message-ID: <20231216033300.3553457-11-kent.overstreet@linux.dev>
In-Reply-To: <20231216033300.3553457-1-kent.overstreet@linux.dev>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216033300.3553457-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

held_lock is embedded in task_struct, and we don't want sched.h pulling
in all of lockdep.h

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/lockdep.h       | 57 -----------------------------------
 include/linux/lockdep_types.h | 57 +++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index dc2844b071c2..08b0d1d9d78b 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -82,63 +82,6 @@ struct lock_chain {
 	u64				chain_key;
 };
 
-#define MAX_LOCKDEP_KEYS_BITS		13
-#define MAX_LOCKDEP_KEYS		(1UL << MAX_LOCKDEP_KEYS_BITS)
-#define INITIAL_CHAIN_KEY		-1
-
-struct held_lock {
-	/*
-	 * One-way hash of the dependency chain up to this point. We
-	 * hash the hashes step by step as the dependency chain grows.
-	 *
-	 * We use it for dependency-caching and we skip detection
-	 * passes and dependency-updates if there is a cache-hit, so
-	 * it is absolutely critical for 100% coverage of the validator
-	 * to have a unique key value for every unique dependency path
-	 * that can occur in the system, to make a unique hash value
-	 * as likely as possible - hence the 64-bit width.
-	 *
-	 * The task struct holds the current hash value (initialized
-	 * with zero), here we store the previous hash value:
-	 */
-	u64				prev_chain_key;
-	unsigned long			acquire_ip;
-	struct lockdep_map		*instance;
-	struct lockdep_map		*nest_lock;
-#ifdef CONFIG_LOCK_STAT
-	u64 				waittime_stamp;
-	u64				holdtime_stamp;
-#endif
-	/*
-	 * class_idx is zero-indexed; it points to the element in
-	 * lock_classes this held lock instance belongs to. class_idx is in
-	 * the range from 0 to (MAX_LOCKDEP_KEYS-1) inclusive.
-	 */
-	unsigned int			class_idx:MAX_LOCKDEP_KEYS_BITS;
-	/*
-	 * The lock-stack is unified in that the lock chains of interrupt
-	 * contexts nest ontop of process context chains, but we 'separate'
-	 * the hashes by starting with 0 if we cross into an interrupt
-	 * context, and we also keep do not add cross-context lock
-	 * dependencies - the lock usage graph walking covers that area
-	 * anyway, and we'd just unnecessarily increase the number of
-	 * dependencies otherwise. [Note: hardirq and softirq contexts
-	 * are separated from each other too.]
-	 *
-	 * The following field is used to detect when we cross into an
-	 * interrupt context:
-	 */
-	unsigned int irq_context:2; /* bit 0 - soft, bit 1 - hard */
-	unsigned int trylock:1;						/* 16 bits */
-
-	unsigned int read:2;        /* see lock_acquire() comment */
-	unsigned int check:1;       /* see lock_acquire() comment */
-	unsigned int hardirqs_off:1;
-	unsigned int sync:1;
-	unsigned int references:11;					/* 32 bits */
-	unsigned int pin_count;
-};
-
 /*
  * Initialization, self-test and debugging-output methods:
  */
diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index 2ebc323d345a..9c533c8d701e 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -198,6 +198,63 @@ struct lockdep_map {
 
 struct pin_cookie { unsigned int val; };
 
+#define MAX_LOCKDEP_KEYS_BITS		13
+#define MAX_LOCKDEP_KEYS		(1UL << MAX_LOCKDEP_KEYS_BITS)
+#define INITIAL_CHAIN_KEY		-1
+
+struct held_lock {
+	/*
+	 * One-way hash of the dependency chain up to this point. We
+	 * hash the hashes step by step as the dependency chain grows.
+	 *
+	 * We use it for dependency-caching and we skip detection
+	 * passes and dependency-updates if there is a cache-hit, so
+	 * it is absolutely critical for 100% coverage of the validator
+	 * to have a unique key value for every unique dependency path
+	 * that can occur in the system, to make a unique hash value
+	 * as likely as possible - hence the 64-bit width.
+	 *
+	 * The task struct holds the current hash value (initialized
+	 * with zero), here we store the previous hash value:
+	 */
+	u64				prev_chain_key;
+	unsigned long			acquire_ip;
+	struct lockdep_map		*instance;
+	struct lockdep_map		*nest_lock;
+#ifdef CONFIG_LOCK_STAT
+	u64 				waittime_stamp;
+	u64				holdtime_stamp;
+#endif
+	/*
+	 * class_idx is zero-indexed; it points to the element in
+	 * lock_classes this held lock instance belongs to. class_idx is in
+	 * the range from 0 to (MAX_LOCKDEP_KEYS-1) inclusive.
+	 */
+	unsigned int			class_idx:MAX_LOCKDEP_KEYS_BITS;
+	/*
+	 * The lock-stack is unified in that the lock chains of interrupt
+	 * contexts nest ontop of process context chains, but we 'separate'
+	 * the hashes by starting with 0 if we cross into an interrupt
+	 * context, and we also keep do not add cross-context lock
+	 * dependencies - the lock usage graph walking covers that area
+	 * anyway, and we'd just unnecessarily increase the number of
+	 * dependencies otherwise. [Note: hardirq and softirq contexts
+	 * are separated from each other too.]
+	 *
+	 * The following field is used to detect when we cross into an
+	 * interrupt context:
+	 */
+	unsigned int irq_context:2; /* bit 0 - soft, bit 1 - hard */
+	unsigned int trylock:1;						/* 16 bits */
+
+	unsigned int read:2;        /* see lock_acquire() comment */
+	unsigned int check:1;       /* see lock_acquire() comment */
+	unsigned int hardirqs_off:1;
+	unsigned int sync:1;
+	unsigned int references:11;					/* 32 bits */
+	unsigned int pin_count;
+};
+
 #else /* !CONFIG_LOCKDEP */
 
 /*
-- 
2.43.0


