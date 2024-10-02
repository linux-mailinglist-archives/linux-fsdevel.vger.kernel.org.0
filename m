Return-Path: <linux-fsdevel+bounces-30763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAF898E2DD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 20:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEAED1C2225D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 18:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739C5216A2E;
	Wed,  2 Oct 2024 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uN0sJaVl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B385D216A0C;
	Wed,  2 Oct 2024 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727894995; cv=none; b=ttzumjMBdgq2oOHJ7tQBzalAoszaE2tKbsbtZzrs5eZhCA0t+C5MG9cjFqnkU3qC7BlMnhg01pYZU18EcgTVIuSUdKYczE9McZOWaK3cIAWZNmaOJNxxBqO0kouZA2TDL6UctIJtAQGoFA3r24giv1e3E9TjKtweXzWqIRV3RCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727894995; c=relaxed/simple;
	bh=ZOcmZO63qqHuL49Q+t9atBGcog/gC5EgLjrW/PMakhg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jcyR1kmqbXBgFvTsO6wbXZBIbGQ5U7WCutlE8tBqSRyRF2W+G0hOG41jrhzJsQ/UhDxgfZq2DfLduyp6pXiWbRPSRwC9P9XuqQZy3a5qt+wMJcGTT/sY1J+hI0BZVVwiS2BMJaIAfbLdeK0n8W2sw+H3Jwait0ndXnE4s4h5DbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uN0sJaVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1446C4CED2;
	Wed,  2 Oct 2024 18:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727894995;
	bh=ZOcmZO63qqHuL49Q+t9atBGcog/gC5EgLjrW/PMakhg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uN0sJaVlfkQDIlYofwaD1U0q+EIAc7u2fVKHmnmjEfj92zz2uvvaoKgzFRGtxqvHE
	 ngjX5Q2kMODaiuzV9ya0CP74hoGpOWAkqSHGo8xGiQXtQhA8iMbgNYXC2fSA7+dUCS
	 GjtWEXxhxNI2F9Vp4KPydMSj6jjFlm0VB0Hc6k6pLuyOGL+Jt/b1M6pdTOsd5AfyoB
	 qCVI5M3Y0DRKXeE3VjRv2gfSCvH/OzcyiPAZ9XikVGWE43qvPOnC20u+LpyMcObJ5Y
	 t/osnFhQHp6KanTgj9zQI1sqYs8b9598Q7tvQYGcA3gKc4zwto2NrRXFDcvSDT4gY4
	 BgjQP0iYSkY1g==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 02 Oct 2024 14:49:29 -0400
Subject: [PATCH v9 01/12] timekeeping: add interfaces for handling
 timestamps with a floor value
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-mgtime-v9-1-77e2baad57ac@kernel.org>
References: <20241002-mgtime-v9-0-77e2baad57ac@kernel.org>
In-Reply-To: <20241002-mgtime-v9-0-77e2baad57ac@kernel.org>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7732; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ZOcmZO63qqHuL49Q+t9atBGcog/gC5EgLjrW/PMakhg=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm/ZXLTPbkQuW/qHxBC62nEmw/Kj2s5ttrIMx/q
 DY9Rq2hBxOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZv2VywAKCRAADmhBGVaC
 FdWkD/4qrF64NTL4UYAUHVTQ8gfFjxTRWZZnZiRwhOCVc0OpZYzPPhPhb+JPdpphxl7KYsx+toY
 iEhzApUIKOdyxqcAIk3p3lfUvGlVnwkoyqHiyy5mvuoTXCuohIvqbjacF+SkQkfK9ZB/g9L7SzZ
 BhnZjbgybiu2eEQ+jOhBhrRraZZKZNjxcR7vT/LO+yzI2sbQFXFleaOSN72+TQXxy2ACjFsVKqV
 3q7vs3Y8jGEBEP/of8s8oQUlUNTStDC0OY/i4M62Mva3koA3pjaOEdV275dWUJ48T6f17KarVhw
 XXFxMvPRkRzghabHy07G8tlUKGw77y+eBasurhUE71c9Bt4mN4aI5M9oXoIVEiiRHPP/eXyE9ly
 hhPiYVlvbYY/FqPo+rWYoB2YMFLtgO0xIfI5ZSGg9HLaOsWfTUgVEWrE7jAFSQhPd7XllhWK2mp
 wqxo2IcSNQTclQfksz/ieeoA35LzW8TRhv2TlWr0BUS+/P3o99T5KYdB320XBRV4g6OfGnmL4Ue
 HzMwo+jWZiS3APwRVflnmQdpk/+Xn9OWfrfG9DypzHYNoVf2urjwN0Jtc8qljEFTgRavqCQpS57
 zMJBVYphAH9ob0az2H3zEHEOwKhwu3Rxa31hvz41pFnDdyyvB8pJzB8/qTLVO8AP6v3eNZESL6B
 shjOHWhNJIp/QSw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Multigrain timestamps allow the kernel to use fine-grained timestamps
when an inode's attributes is being actively observed via ->getattr().
With this support, it's possible for a file to get a fine-grained
timestamp, and another modified after it to get a coarse-grained stamp
that is earlier than the fine-grained time.  If this happens then the
files can appear to have been modified in reverse order, which breaks
VFS ordering guarantees [1].

To prevent this, maintain a floor value for multigrain timestamps.
Whenever a fine-grained timestamp is handed out, record it, and when
later coarse-grained stamps are handed out, ensure they are not earlier
than that value. If the coarse-grained timestamp is earlier than the
fine-grained floor, return the floor value instead.

Add a static singleton atomic64_t into timekeeper.c that is used to
keep track of the latest fine-grained time ever handed out. This is
tracked as a monotonic ktime_t value to ensure that it isn't affected by
clock jumps. Because it is updated at different times than the rest of
the timekeeper object, the floor value is managed independently of the
timekeeper via a cmpxchg() operation, and sits on its own cacheline.

Add two new public interfaces:

- ktime_get_coarse_real_ts64_mg() fills a timespec64 with the later of the
  coarse-grained clock and the floor time

- ktime_get_real_ts64_mg() gets the fine-grained clock value, and tries
  to swap it into the floor. A timespec64 is filled with the result.

The floor value is global and updated via a single try_cmpxchg(). If
that fails then the operation raced with a concurrent update. Any
concurrent update must be later than the existing floor value, so any
racing tasks can accept any resulting floor value without retrying.

[1]: POSIX requires that files be stamped with realtime clock values, and
     makes no provision for dealing with backward clock jumps. If a backward
     realtime clock jump occurs, then files can appear to have been modified
     in reverse order.

Tested-by: Randy Dunlap <rdunlap@infradead.org> # documentation bits
Acked-by: John Stultz <jstultz@google.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/timekeeping.h |   4 ++
 kernel/time/timekeeping.c   | 105 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index fc12a9ba2c88..7aa85246c183 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -45,6 +45,10 @@ extern void ktime_get_real_ts64(struct timespec64 *tv);
 extern void ktime_get_coarse_ts64(struct timespec64 *ts);
 extern void ktime_get_coarse_real_ts64(struct timespec64 *ts);
 
+/* Multigrain timestamp interfaces */
+extern void ktime_get_coarse_real_ts64_mg(struct timespec64 *ts);
+extern void ktime_get_real_ts64_mg(struct timespec64 *ts);
+
 void getboottime64(struct timespec64 *ts);
 
 /*
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 5391e4167d60..ebfe846ebde3 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -114,6 +114,24 @@ static struct tk_fast tk_fast_raw  ____cacheline_aligned = {
 	.base[1] = FAST_TK_INIT,
 };
 
+/*
+ * Multigrain timestamps require tracking the latest fine-grained timestamp
+ * that has been issued, and never returning a coarse-grained timestamp that is
+ * earlier than that value.
+ *
+ * mg_floor represents the latest fine-grained time that has been handed out as
+ * a file timestamp on the system. This is tracked as a monotonic ktime_t, and
+ * converted to a realtime clock value on an as-needed basis.
+ *
+ * Maintaining mg_floor ensures the multigrain interfaces never issue a
+ * timestamp earlier than one that has been previously issued.
+ *
+ * The exception to this rule is when there is a backward realtime clock jump. If
+ * such an event occurs, a timestamp can appear to be earlier than a previous one.
+ */
+
+static __cacheline_aligned_in_smp atomic64_t mg_floor;
+
 static inline void tk_normalize_xtime(struct timekeeper *tk)
 {
 	while (tk->tkr_mono.xtime_nsec >= ((u64)NSEC_PER_SEC << tk->tkr_mono.shift)) {
@@ -2394,6 +2412,93 @@ void ktime_get_coarse_real_ts64(struct timespec64 *ts)
 }
 EXPORT_SYMBOL(ktime_get_coarse_real_ts64);
 
+/**
+ * ktime_get_coarse_real_ts64_mg - return latter of coarse grained time or floor
+ * @ts: timespec64 to be filled
+ *
+ * Fetch the global mg_floor value, convert it to realtime and
+ * compare it to the current coarse-grained time. Fill @ts with
+ * whichever is latest. Note that this is a filesystem-specific
+ * interface and should be avoided outside of that context.
+ */
+void ktime_get_coarse_real_ts64_mg(struct timespec64 *ts)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+	u64 floor = atomic64_read(&mg_floor);
+	ktime_t f_real, offset, coarse;
+	unsigned int seq;
+
+	do {
+		seq = read_seqcount_begin(&tk_core.seq);
+		*ts = tk_xtime(tk);
+		offset = tk_core.timekeeper.offs_real;
+	} while (read_seqcount_retry(&tk_core.seq, seq));
+
+	coarse = timespec64_to_ktime(*ts);
+	f_real = ktime_add(floor, offset);
+	if (ktime_after(f_real, coarse))
+		*ts = ktime_to_timespec64(f_real);
+}
+
+/**
+ * ktime_get_real_ts64_mg - attempt to update floor value and return result
+ * @ts:		pointer to the timespec to be set
+ *
+ * Get a monotonic fine-grained time value and attempt to swap it into
+ * mg_floor. If that succeeds then accept the new floor value. If it fails
+ * then another task raced in during the interim time and updated the floor.
+ * Since any update to the floor must be later than the previous floor,
+ * either outcome is acceptable.
+ *
+ * Typically this will be called after calling ktime_get_coarse_real_ts64_mg(),
+ * and determining that the resulting coarse-grained timestamp did not effect
+ * a change in the ctime. Any more recent floor value would effect a change to
+ * the ctime, so there is no need to retry the atomic64_try_cmpxchg() on failure.
+ *
+ * @ts will be filled with the latest floor value, regardless of the outcome of
+ * the cmpxchg. Note that this is a filesystem specific interface and should be
+ * avoided outside of that context.
+ */
+void ktime_get_real_ts64_mg(struct timespec64 *ts)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+	ktime_t old = atomic64_read(&mg_floor);
+	ktime_t offset, mono;
+	unsigned int seq;
+	u64 nsecs;
+
+	do {
+		seq = read_seqcount_begin(&tk_core.seq);
+
+		ts->tv_sec = tk->xtime_sec;
+		mono = tk->tkr_mono.base;
+		nsecs = timekeeping_get_ns(&tk->tkr_mono);
+		offset = tk_core.timekeeper.offs_real;
+	} while (read_seqcount_retry(&tk_core.seq, seq));
+
+	mono = ktime_add_ns(mono, nsecs);
+
+	/*
+	 * Attempt to update the floor with the new time value. As any
+	 * update must be later then the existing floor, and would effect
+	 * a change to the ctime from the perspective of the current task,
+	 * accept the resulting floor value regardless of the outcome of
+	 * the swap.
+	 */
+	if (atomic64_try_cmpxchg(&mg_floor, &old, mono)) {
+		ts->tv_nsec = 0;
+		timespec64_add_ns(ts, nsecs);
+	} else {
+		/*
+		 * Another task changed mg_floor since "old" was fetched.
+		 * "old" has been updated with the latest value of "mg_floor".
+		 * That value is newer than the previous floor value, which
+		 * is enough to effect a change to the ctime. Accept it.
+		 */
+		*ts = ktime_to_timespec64(ktime_add(old, offset));
+	}
+}
+
 void ktime_get_coarse_ts64(struct timespec64 *ts)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;

-- 
2.46.2


