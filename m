Return-Path: <linux-fsdevel+bounces-25305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5352B94A94A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 16:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C139288B3E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 14:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9248B339B1;
	Wed,  7 Aug 2024 14:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3rD/oBEt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dM7MuUQ+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A682F3E;
	Wed,  7 Aug 2024 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039397; cv=none; b=qSYjiRlJzGOIG4OUaaZMKMItgff2j1yZ5k2WYauS0i85TyigoNSwlM0uXg2uXUdXbnwNakCxF9zrSuviAWQLG4kN1nru3dDvn2Qe8MzXDYruWrqEtkQroH/gA6smE6jRt1CKTtRPdE/z9+hwGBoAsSSR7cLfDZYXuUATW/hWTcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039397; c=relaxed/simple;
	bh=U12eLVD5wtjMX5rL/WKU0g2FW9OoxlvfZrEjW6GkCCg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ulm7GRMrhQUkNpV+/sryV5NntkDBjn6QDC0cfAZRhDRwAWdLodWBzP16dwhOo5G6hcrhpEUt5uqT52ZPSVlaUgw+nqIq+lQXs+dYMMZgsLdcCEq46aBXNy0/Jmb7D6m17cgVB6KGj9SQbeufjf3XRAArkcw5N8/I6TM9tKJc3F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3rD/oBEt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dM7MuUQ+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723039393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DywaQRErmQJfWd/IK1mxzffl3LQqN6pOKPdiVYcdznA=;
	b=3rD/oBEtesn8jpyxLW+ffgh33MZxDnZlZ92mD0kRiiXh3CRdhGSJJf583v1V/bZcLrcLS8
	YaE7NZeNkTxfLPBO/U0QvKEbsiz99qZf/fMUkRAYdtm+2qsIAlnwKGgojwE/EqLcJ32YYj
	1t0GbAZD16BF+uTSTl2k0quymE5CuwpfjIGPlwWeMWsPq/WoGSJl+9QBWI8GHNQ6mqyoEl
	Q/klCT6VtjSAh7llK5BCpGhUVYx+NFu/eqsRj51Joi5zTtTEiHIYirB6qA0CNqwwLMehNM
	5UOgIWlHQwqYvrsiPvxQGJKD0zDJuzbyH2kAiFbj3nHkV9aXo2C+JiFRaDotJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723039393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DywaQRErmQJfWd/IK1mxzffl3LQqN6pOKPdiVYcdznA=;
	b=dM7MuUQ+ENLvdIQ3sJTd9IiAEATJM88pnP03Y6+xOKYmuqOcyM0sTpWVkcu0V4/X7Zt3zn
	DHz9B7KjmCI4PMCQ==
To: Peter Zijlstra <peterz@infradead.org>, "Darrick J. Wong"
 <djwong@kernel.org>
Cc: Chandan Babu R <chandanbabu@kernel.org>, Matthew Wilcox
 <willy@infradead.org>, xfs <linux-xfs@vger.kernel.org>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: Re: Are jump labels broken on 6.11-rc1?
In-Reply-To: <20240806103808.GT37996@noisy.programming.kicks-ass.net>
References: <20240730033849.GH6352@frogsfrogsfrogs>
 <87o76f9vpj.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20240730132626.GV26599@noisy.programming.kicks-ass.net>
 <20240731001950.GN6352@frogsfrogsfrogs>
 <20240731031033.GP6352@frogsfrogsfrogs>
 <20240731053341.GQ6352@frogsfrogsfrogs>
 <20240731105557.GY33588@noisy.programming.kicks-ass.net>
 <20240805143522.GA623936@frogsfrogsfrogs>
 <20240806094413.GS37996@noisy.programming.kicks-ass.net>
 <20240806103808.GT37996@noisy.programming.kicks-ass.net>
Date: Wed, 07 Aug 2024 16:03:12 +0200
Message-ID: <875xsc4ehr.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Aug 06 2024 at 12:38, Peter Zijlstra wrote:
> On Tue, Aug 06, 2024 at 11:44:13AM +0200, Peter Zijlstra wrote:
> I've ended up with this, not exactly pretty :/
>
> -static bool static_key_slow_try_dec(struct static_key *key)
> +static bool static_key_dec(struct static_key *key, bool fast)
>  {
>  	int v;
>  
> @@ -268,31 +268,45 @@ static bool static_key_slow_try_dec(struct static_key *key)
>  	v = atomic_read(&key->enabled);
>  	do {
>  		/*
> -		 * Warn about the '-1' case though; since that means a
> -		 * decrement is concurrent with a first (0->1) increment. IOW
> -		 * people are trying to disable something that wasn't yet fully
> -		 * enabled. This suggests an ordering problem on the user side.
> +		 * Warn about the '-1' case; since that means a decrement is
> +		 * concurrent with a first (0->1) increment. IOW people are
> +		 * trying to disable something that wasn't yet fully enabled.
> +		 * This suggests an ordering problem on the user side.
> +		 *
> +		 * Warn about the '0' case; simple underflow.
> +		 *
> +		 * Neither case should succeed and change things.

Which is confusing because the fastpath will drop down into the slowpath
due to this.

> +		 */
> +		if (WARN_ON_ONCE(v <= 0))
> +			return false;

This forces the fastpath into the slowpath. I assume this on purpose to
handle the concurrent 'first enable (enabled == -1)'. But hell this is
not comprehensible without a comment.

>  static void __static_key_slow_dec_cpuslocked(struct static_key *key)
>  {
>  	lockdep_assert_cpus_held();
>  
> -	if (static_key_slow_try_dec(key))
> +	if (static_key_dec(key, true)) // dec-not-one

Eeew.

Something like the below?

Thanks,

        tglx
---
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -168,8 +168,8 @@ bool static_key_slow_inc_cpuslocked(stru
 		jump_label_update(key);
 		/*
 		 * Ensure that when static_key_fast_inc_not_disabled() or
-		 * static_key_slow_try_dec() observe the positive value,
-		 * they must also observe all the text changes.
+		 * static_key_dec() observe the positive value, they must also
+		 * observe all the text changes.
 		 */
 		atomic_set_release(&key->enabled, 1);
 	} else {
@@ -250,49 +250,71 @@ void static_key_disable(struct static_ke
 }
 EXPORT_SYMBOL_GPL(static_key_disable);
 
-static bool static_key_slow_try_dec(struct static_key *key)
+static bool static_key_dec(struct static_key *key, bool dec_not_one)
 {
-	int v;
+	int v = atomic_read(&key->enabled);
 
-	/*
-	 * Go into the slow path if key::enabled is less than or equal than
-	 * one. One is valid to shut down the key, anything less than one
-	 * is an imbalance, which is handled at the call site.
-	 *
-	 * That includes the special case of '-1' which is set in
-	 * static_key_slow_inc_cpuslocked(), but that's harmless as it is
-	 * fully serialized in the slow path below. By the time this task
-	 * acquires the jump label lock the value is back to one and the
-	 * retry under the lock must succeed.
-	 */
-	v = atomic_read(&key->enabled);
 	do {
 		/*
-		 * Warn about the '-1' case though; since that means a
-		 * decrement is concurrent with a first (0->1) increment. IOW
-		 * people are trying to disable something that wasn't yet fully
-		 * enabled. This suggests an ordering problem on the user side.
+		 * Warn about the '-1' case; since that means a decrement is
+		 * concurrent with a first (0->1) increment. IOW people are
+		 * trying to disable something that wasn't yet fully enabled.
+		 * This suggests an ordering problem on the user side.
+		 *
+		 * Warn about the '0' case; simple underflow.
 		 */
-		WARN_ON_ONCE(v < 0);
-		if (v <= 1)
-			return false;
+		if (WARN_ON_ONCE(v <= 0))
+			return v;
+
+		if (dec_not_one && v == 1)
+			return v;
+
 	} while (!likely(atomic_try_cmpxchg(&key->enabled, &v, v - 1)));
 
-	return true;
+	return v;
+}
+
+/*
+ * Fastpath: Decrement if the reference count is greater than one
+ *
+ * Returns false, if the reference count is 1 or -1 to force the caller
+ * into the slowpath.
+ *
+ * The -1 case is to handle a decrement during a concurrent first enable,
+ * which sets the count to -1 in static_key_slow_inc_cpuslocked(). As the
+ * slow path is serialized the caller will observe 1 once it acquired the
+ * jump_label_mutex, so the slow path can succeed.
+ */
+static bool static_key_dec_not_one(struct static_key *key)
+{
+	int v = static_key_dec(key, true);
+
+	return v != 1 && v != -1;
+}
+
+/*
+ * Slowpath: Decrement and test whether the refcount hit 0.
+ *
+ * Returns true if the refcount hit zero, i.e. the previous value was one.
+ */
+static bool static_key_dec_and_test(struct static_key *key)
+{
+	int v = static_key_dec(key, false);
+
+	lockdep_assert_held(&jump_label_mutex);
+	return v == 1;
 }
 
 static void __static_key_slow_dec_cpuslocked(struct static_key *key)
 {
 	lockdep_assert_cpus_held();
 
-	if (static_key_slow_try_dec(key))
+	if (static_key_dec_not_one(key))
 		return;
 
 	guard(mutex)(&jump_label_mutex);
-	if (atomic_cmpxchg(&key->enabled, 1, 0) == 1)
+	if (static_key_dec_and_test(key))
 		jump_label_update(key);
-	else
-		WARN_ON_ONCE(!static_key_slow_try_dec(key));
 }
 
 static void __static_key_slow_dec(struct static_key *key)
@@ -329,7 +351,7 @@ void __static_key_slow_dec_deferred(stru
 {
 	STATIC_KEY_CHECK_USE(key);
 
-	if (static_key_slow_try_dec(key))
+	if (static_key_dec_not_one(key))
 		return;
 
 	schedule_delayed_work(work, timeout);

