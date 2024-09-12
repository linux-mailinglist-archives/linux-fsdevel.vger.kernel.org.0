Return-Path: <linux-fsdevel+bounces-29198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE97976FEA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 20:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D92BB22B58
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 18:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165681BE854;
	Thu, 12 Sep 2024 18:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbTJwEN8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4FD13A40F;
	Thu, 12 Sep 2024 18:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726164176; cv=none; b=OEE7NORMyzPlD4Qp/lvc/wQsIMJ2ruM+OiDQ9J3eBg1mwik0fPruTf2EKS1No6WnfgG2mYuL4uxfkuHd8LcbAuuHLhoMmpaYPdaOtc3D6LJPrGWYNFBnanWZycbQbs8lzhgjeOOnAT+Uz2JDxbA9bnDoazJ2eCTG++VRZknn7zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726164176; c=relaxed/simple;
	bh=aTQ96XEIsrqaJG45eHdwF72McOz43L38rVYY+vEBb8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=T+hPRrKxgcEXXrDdrROZEzH/TLtkm9JJCEeo/q448JjUfjVKXcT26gLxSdVHp/XCZDYgT+Vh/CqKtc+7OSo2cssoGw1CE2hv3s2MY0+A0x7KsZneYHILs2x2ec5/2r7uA5Kuy1ymPhOgK5Iz3xO8TJPjffp1K8RaSiW6RVkGQVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbTJwEN8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9905C4CEC3;
	Thu, 12 Sep 2024 18:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726164175;
	bh=aTQ96XEIsrqaJG45eHdwF72McOz43L38rVYY+vEBb8g=;
	h=From:Date:Subject:To:Cc:From;
	b=GbTJwEN8ZAIi0WdtIaVZjhfdDQCVKcJp1nNv2dFAnRY7hXbMIavUX43eVK9+XLMsj
	 f/L76SvB0Dn39nq8d0DjEacRlsgZPple6QZ06o/vtBE3swLKCcoUKX9C242XpWsGZx
	 VwjOVymEc1gaOkbtS2EUNX+5akVpDgJcmRDarK2nsOZIM8wS9gVGnzqkzLIFsf3ikB
	 dFhj1KHT/jQ2K39jo4qSrT9o6rX+OlCrEceatC2ZwX7n/UxCxiVlKEylXED5oHITcT
	 ESyejKrnqFo/QOImTu/BqzhrMcqXwQS5MTSLj/KXldPBa85riXbXuaATBbQbA+Ctf6
	 ZCcfQKLZJZ6XQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 12 Sep 2024 14:02:52 -0400
Subject: [PATCH v2] timekeeping: move multigrain timestamp floor handling
 into timekeeper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240912-mgtime-v2-1-54db84afb7a7@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMss42YC/zXMQQrCMBCF4auUWRvJxCrWlfeQLkIzTQdtIpMSl
 JK7Gwtd/o/Ht0IiYUpwa1YQypw4hhrm0MAw2eBJsasNRptWd2jU7BeeSQ1orvqite3sCer5LTT
 yZ4Mefe2J0xLlu7kZ/+tO4E5kVKioteRGdNrh+f4kCfQ6RvHQl1J+WhDCPJ0AAAA=
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel test robot <oliver.sang@intel.com>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=13069; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=aTQ96XEIsrqaJG45eHdwF72McOz43L38rVYY+vEBb8g=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm4yzOPITeQnROkNg4zZCsWbkOTvbB3AMBFm5aT
 motkTDru8mJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZuMszgAKCRAADmhBGVaC
 FeYyEADPfKdoNaF7jTs7GfvoyzTIZnwxncT73PXgPDwh4kgjc/J23tuLd3JVg/Hg2BHDljj5Pdp
 kOuvuUryqCA8JJ7zXJwBhaNykF9t9C5xATbBnFhvhgKZLT19gfnGQmHXftj0XNFNqiR29dHjOHq
 m/mo//qxboHt6siqrj3vKWTF0Hp1URLh3a4PN5tMObrjonlaWLOadiBUE9zNPx6T3zaG7JU/9sO
 5L9c0tLabl//TCZYEEbE57Q7aYx6kB/5do4o5VL8Bx9Cck+PCD9nNhrIJudoSL4mCfS/ak1InmT
 cVA+5rldoF7qbvIJaSxrcH9WleDLP8IPv7f/tzMoV2bjx88EL/Ak2X4f2r9G4AsddnEaEbp3QRh
 h+PO3geyf8FQhIV1Wjpcbfg0CMgoxcsUOHfyeRPNkg8sfCutr3D5Q4OqK0AhGUiw83nfguslEf9
 ZZ4sEAIYc9XiU8JqPV01gQ8neAeb4ymfdQYomu9IwjMFXdn2XpROtCA/hZmS66oMpLYFc6Ips/+
 ehtK9bO0EkzF2NP9beN4LRQ1FXJqeyUFbUTuKDpH9O+asboMbCIV0j0+vYLSm9UvT+I8VfC3Juz
 liWVdUYhyc6Wf7IQs7LUVw3z/EtBi8UgVZ5DEtcMPkb8yB9jLP0Y+tEaVEO/ToKXUR5oQpjMdCR
 54k1l5+e1eUkwCg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The kernel test robot reported a performance hit in some will-it-scale
tests due to the multigrain timestamp patches.  My own testing showed
about a 7% drop in performance on the pipe1_threads test, and the data
showed that coarse_ctime() was slowing down current_time().

Move the multigrain timestamp floor tracking word into timekeeper.c. Add
two new public interfaces: The first fills a timespec64 with the later
of the coarse-grained clock and the floor time, and the second gets a
fine-grained time and tries to swap it into the floor and fills a
timespec64 with the result.

The first function returns an opaque cookie that is suitable for passing
to the second, which will use it as the "old" value in the cmpxchg.

With this patch on top of the multigrain series, the will-it-scale
pipe1_threads microbenchmark shows these averages on my test rig:

	v6.11-rc7:			103561295 (baseline)
	v6.11-rc7 + mgtime + this:	101357203 (~2% performance drop)

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202409091303.31b2b713-oliver.sang@intel.com
Suggested-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
This version moves more of the floor handling into the timekeeper code.

Some of the earlier concern was about mixing different time value types
in the same interface. This sort of still does that, but it does it
using an opaque cookie value instead, which I'm hoping will make the
interfaces a little cleaner. Using an opaque cookie also means that we
can change the underlying implementation at will, without breaking the
callers.

If this approach looks OK, it's probably best for me to just respin the
entire series and have Christian drop the old and pick up the new. That
should reduce some of the unnecessary churn in fs/inode.c.
---
Changes in v2:
- move floor handling completely into timekeeper code
- add new interfaces for multigrain timestamp handling
- Link to v1: https://lore.kernel.org/r/20240911-mgtime-v1-1-e4aedf1d0d15@kernel.org
---
 fs/inode.c                  | 105 +++++++++++++-------------------------------
 include/linux/timekeeping.h |   4 ++
 kernel/time/timekeeping.c   |  77 ++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+), 75 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index f0fbfd470d8e..3c7e16935bac 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -65,13 +65,6 @@ static unsigned int i_hash_shift __ro_after_init;
 static struct hlist_head *inode_hashtable __ro_after_init;
 static __cacheline_aligned_in_smp DEFINE_SPINLOCK(inode_hash_lock);
 
-/*
- * This represents the latest fine-grained time that we have handed out as a
- * timestamp on the system. Tracked as a monotonic value, and converted to the
- * realtime clock on an as-needed basis.
- */
-static __cacheline_aligned_in_smp atomic64_t ctime_floor;
-
 /*
  * Empty aops. Can be used for the cases where the user does not
  * define any of the address_space operations.
@@ -2255,25 +2248,6 @@ int file_remove_privs(struct file *file)
 }
 EXPORT_SYMBOL(file_remove_privs);
 
-/**
- * coarse_ctime - return the current coarse-grained time
- * @floor: current (monotonic) ctime_floor value
- *
- * Get the coarse-grained time, and then determine whether to
- * return it or the current floor value. Returns the later of the
- * floor and coarse grained timestamps, converted to realtime
- * clock value.
- */
-static ktime_t coarse_ctime(ktime_t floor)
-{
-	ktime_t coarse = ktime_get_coarse();
-
-	/* If coarse time is already newer, return that */
-	if (!ktime_after(floor, coarse))
-		return ktime_get_coarse_real();
-	return ktime_mono_to_real(floor);
-}
-
 /**
  * current_time - Return FS time (possibly fine-grained)
  * @inode: inode.
@@ -2284,11 +2258,11 @@ static ktime_t coarse_ctime(ktime_t floor)
  */
 struct timespec64 current_time(struct inode *inode)
 {
-	ktime_t floor = atomic64_read(&ctime_floor);
-	ktime_t now = coarse_ctime(floor);
-	struct timespec64 now_ts = ktime_to_timespec64(now);
+	struct timespec64 now;
 	u32 cns;
 
+	ktime_get_coarse_real_ts64_mg(&now);
+
 	if (!is_mgtime(inode))
 		goto out;
 
@@ -2299,11 +2273,11 @@ struct timespec64 current_time(struct inode *inode)
 		 * If there is no apparent change, then
 		 * get a fine-grained timestamp.
 		 */
-		if (now_ts.tv_nsec == (cns & ~I_CTIME_QUERIED))
-			ktime_get_real_ts64(&now_ts);
+		if (now.tv_nsec == (cns & ~I_CTIME_QUERIED))
+			ktime_get_real_ts64(&now);
 	}
 out:
-	return timestamp_truncate(now_ts, inode);
+	return timestamp_truncate(now, inode);
 }
 EXPORT_SYMBOL(current_time);
 
@@ -2745,7 +2719,7 @@ EXPORT_SYMBOL(timestamp_truncate);
  *
  * Set the inode's ctime to the current value for the inode. Returns the
  * current value that was assigned. If this is not a multigrain inode, then we
- * just set it to whatever the coarse_ctime is.
+ * set it to the later of the coarse time and floor value.
  *
  * If it is multigrain, then we first see if the coarse-grained timestamp is
  * distinct from what we have. If so, then we'll just use that. If we have to
@@ -2756,16 +2730,16 @@ EXPORT_SYMBOL(timestamp_truncate);
  */
 struct timespec64 inode_set_ctime_current(struct inode *inode)
 {
-	ktime_t now, floor = atomic64_read(&ctime_floor);
-	struct timespec64 now_ts;
+	struct timespec64 now;
 	u32 cns, cur;
+	u64 cookie;
 
-	now = coarse_ctime(floor);
+	cookie = ktime_get_coarse_real_ts64_mg(&now);
 
 	/* Just return that if this is not a multigrain fs */
 	if (!is_mgtime(inode)) {
-		now_ts = timestamp_truncate(ktime_to_timespec64(now), inode);
-		inode_set_ctime_to_ts(inode, now_ts);
+		now = timestamp_truncate(now, inode);
+		inode_set_ctime_to_ts(inode, now);
 		goto out;
 	}
 
@@ -2776,44 +2750,27 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 	 */
 	cns = smp_load_acquire(&inode->i_ctime_nsec);
 	if (cns & I_CTIME_QUERIED) {
-		ktime_t ctime = ktime_set(inode->i_ctime_sec, cns & ~I_CTIME_QUERIED);
-
-		if (!ktime_after(now, ctime)) {
-			ktime_t old, fine;
+		struct timespec64 ctime = { .tv_sec = inode->i_ctime_sec,
+					    .tv_nsec = cns & ~I_CTIME_QUERIED };
 
-			/* Get a fine-grained time */
-			fine = ktime_get();
-			mgtime_counter_inc(mg_fine_stamps);
-
-			/*
-			 * If the cmpxchg works, we take the new floor value. If
-			 * not, then that means that someone else changed it after we
-			 * fetched it but before we got here. That value is just
-			 * as good, so keep it.
-			 */
-			old = floor;
-			if (atomic64_try_cmpxchg(&ctime_floor, &old, fine))
-				mgtime_counter_inc(mg_floor_swaps);
-			else
-				fine = old;
-			now = ktime_mono_to_real(fine);
-		}
+		if (timespec64_compare(&now, &ctime) <= 0)
+			ktime_get_real_ts64_mg(&now, cookie);
 	}
 	mgtime_counter_inc(mg_ctime_updates);
-	now_ts = timestamp_truncate(ktime_to_timespec64(now), inode);
-	cur = cns;
+	now = timestamp_truncate(now, inode);
 
 	/* No need to cmpxchg if it's exactly the same */
-	if (cns == now_ts.tv_nsec && inode->i_ctime_sec == now_ts.tv_sec) {
-		trace_ctime_xchg_skip(inode, &now_ts);
+	if (cns == now.tv_nsec && inode->i_ctime_sec == now.tv_sec) {
+		trace_ctime_xchg_skip(inode, &now);
 		goto out;
 	}
+	cur = cns;
 retry:
 	/* Try to swap the nsec value into place. */
-	if (try_cmpxchg(&inode->i_ctime_nsec, &cur, now_ts.tv_nsec)) {
+	if (try_cmpxchg(&inode->i_ctime_nsec, &cur, now.tv_nsec)) {
 		/* If swap occurred, then we're (mostly) done */
-		inode->i_ctime_sec = now_ts.tv_sec;
-		trace_ctime_ns_xchg(inode, cns, now_ts.tv_nsec, cur);
+		inode->i_ctime_sec = now.tv_sec;
+		trace_ctime_ns_xchg(inode, cns, now.tv_nsec, cur);
 		mgtime_counter_inc(mg_ctime_swaps);
 	} else {
 		/*
@@ -2827,11 +2784,11 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 			goto retry;
 		}
 		/* Otherwise, keep the existing ctime */
-		now_ts.tv_sec = inode->i_ctime_sec;
-		now_ts.tv_nsec = cur & ~I_CTIME_QUERIED;
+		now.tv_sec = inode->i_ctime_sec;
+		now.tv_nsec = cur & ~I_CTIME_QUERIED;
 	}
 out:
-	return now_ts;
+	return now;
 }
 EXPORT_SYMBOL(inode_set_ctime_current);
 
@@ -2854,8 +2811,7 @@ EXPORT_SYMBOL(inode_set_ctime_current);
  */
 struct timespec64 inode_set_ctime_deleg(struct inode *inode, struct timespec64 update)
 {
-	ktime_t now, floor = atomic64_read(&ctime_floor);
-	struct timespec64 now_ts, cur_ts;
+	struct timespec64 now, cur_ts;
 	u32 cur, old;
 
 	/* pairs with try_cmpxchg below */
@@ -2867,12 +2823,11 @@ struct timespec64 inode_set_ctime_deleg(struct inode *inode, struct timespec64 u
 	if (timespec64_compare(&update, &cur_ts) <= 0)
 		return cur_ts;
 
-	now = coarse_ctime(floor);
-	now_ts = ktime_to_timespec64(now);
+	ktime_get_coarse_real_ts64_mg(&now);
 
 	/* Clamp the update to "now" if it's in the future */
-	if (timespec64_compare(&update, &now_ts) > 0)
-		update = now_ts;
+	if (timespec64_compare(&update, &now) > 0)
+		update = now;
 
 	update = timestamp_truncate(update, inode);
 
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index fc12a9ba2c88..cf2293158c65 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -45,6 +45,10 @@ extern void ktime_get_real_ts64(struct timespec64 *tv);
 extern void ktime_get_coarse_ts64(struct timespec64 *ts);
 extern void ktime_get_coarse_real_ts64(struct timespec64 *ts);
 
+/* Multigrain timestamp interfaces */
+extern u64 ktime_get_coarse_real_ts64_mg(struct timespec64 *ts);
+extern void ktime_get_real_ts64_mg(struct timespec64 *ts, u64 cookie);
+
 void getboottime64(struct timespec64 *ts);
 
 /*
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 5391e4167d60..bb039c9d525e 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -114,6 +114,13 @@ static struct tk_fast tk_fast_raw  ____cacheline_aligned = {
 	.base[1] = FAST_TK_INIT,
 };
 
+/*
+ * This represents the latest fine-grained time that we have handed out as a
+ * timestamp on the system. Tracked as a monotonic ktime_t, and converted to the
+ * realtime clock on an as-needed basis.
+ */
+static __cacheline_aligned_in_smp atomic64_t mg_floor;
+
 static inline void tk_normalize_xtime(struct timekeeper *tk)
 {
 	while (tk->tkr_mono.xtime_nsec >= ((u64)NSEC_PER_SEC << tk->tkr_mono.shift)) {
@@ -2394,6 +2401,76 @@ void ktime_get_coarse_real_ts64(struct timespec64 *ts)
 }
 EXPORT_SYMBOL(ktime_get_coarse_real_ts64);
 
+/**
+ * ktime_get_coarse_real_ts64_mg - get later of coarse grained time or floor
+ * @ts: timespec64 to be filled
+ *
+ * Adjust floor to realtime and compare it to the coarse time. Fill
+ * @ts with the latest one. Returns opaque cookie suitable to pass
+ * to ktime_get_real_ts64_mg.
+ */
+u64 ktime_get_coarse_real_ts64_mg(struct timespec64 *ts)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+	u64 floor = atomic64_read(&mg_floor);
+	ktime_t f_real, offset, coarse;
+	unsigned int seq;
+
+	WARN_ON(timekeeping_suspended);
+
+	do {
+		seq = read_seqcount_begin(&tk_core.seq);
+		*ts = tk_xtime(tk);
+		offset = *offsets[TK_OFFS_REAL];
+	} while (read_seqcount_retry(&tk_core.seq, seq));
+
+	coarse = timespec64_to_ktime(*ts);
+	f_real = ktime_add(floor, offset);
+	if (ktime_after(f_real, coarse))
+		*ts = ktime_to_timespec64(f_real);
+	return floor;
+}
+EXPORT_SYMBOL_GPL(ktime_get_coarse_real_ts64_mg);
+
+/**
+ * ktime_get_real_ts64_mg - attempt to update floor value and return result
+ * @ts:		pointer to the timespec to be set
+ * @cookie:	opaque cookie from earlier call to ktime_get_coarse_real_ts64_mg()
+ *
+ * Get a current monotonic fine-grained time value and attempt to swap
+ * it into the floor using @cookie as the "old" value. @ts will be
+ * filled with the resulting floor value, regardless of the outcome of
+ * the swap.
+ */
+void ktime_get_real_ts64_mg(struct timespec64 *ts, u64 cookie)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+	ktime_t offset, mono, old = (ktime_t)cookie;
+	unsigned int seq;
+	u64 nsecs;
+
+	WARN_ON(timekeeping_suspended);
+
+	do {
+		seq = read_seqcount_begin(&tk_core.seq);
+
+		ts->tv_sec = tk->xtime_sec;
+		mono = tk->tkr_mono.base;
+		nsecs = timekeeping_get_ns(&tk->tkr_mono);
+		offset = *offsets[TK_OFFS_REAL];
+	} while (read_seqcount_retry(&tk_core.seq, seq));
+
+	mono = ktime_add_ns(mono, nsecs);
+	if (atomic64_try_cmpxchg(&mg_floor, &old, mono)) {
+		ts->tv_nsec = 0;
+		timespec64_add_ns(ts, nsecs);
+	} else {
+		*ts = ktime_to_timespec64(ktime_add(old, offset));
+	}
+
+}
+EXPORT_SYMBOL(ktime_get_real_ts64_mg);
+
 void ktime_get_coarse_ts64(struct timespec64 *ts)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;

---
base-commit: 18348a38102a4efca57186740afb33f08e5f4609
change-id: 20240912-mgtime-c1280600a9a3

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


