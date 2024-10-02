Return-Path: <linux-fsdevel+bounces-30787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EB398E4F1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 23:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F8A2822EF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 21:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6089A21791C;
	Wed,  2 Oct 2024 21:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsBmIDPP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A339E2178EE;
	Wed,  2 Oct 2024 21:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727904454; cv=none; b=KB5ppNSf9Pk+SjliNwYA7AFyKovriwbRHe2s0O6qtMVOmHQuhxW8ecTZ/6abEHcqw/+9KdecNoP6g8sXUTY1jLlE2+alciTgrslWWnMYtrIi+iVJCZRh6D3HJ5fhYqhUsz93KhOpYFibPZ5r+Vpj6XOPW+3G1vEmT0g9u+s33Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727904454; c=relaxed/simple;
	bh=2+VLMo7X+TKT3T321kqTgs4zMRtNzRRVuC4rj6DW+Cc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V2pZYl48i6DYMlSF/7y17COGt5QUQ2VO6Omsb819X7eZPBpaK5e7jaACbb35ujTwI4TJLM1HTQKxmGVjR4O/Xw6rpYIRTWRlfzmI9+RwlYjl0pCYVsxXPR7EIuKL9v0IaAI7ol8OD4SrF71lU9sbp4d/mm7vcMB6tFeWglhLHgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsBmIDPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A61C4CECE;
	Wed,  2 Oct 2024 21:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727904454;
	bh=2+VLMo7X+TKT3T321kqTgs4zMRtNzRRVuC4rj6DW+Cc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZsBmIDPP/TPJIvUs0H0Bq+7XEPNLJ1InQNnB4epFjmVdguwWioPMQS0ex58J6kYmH
	 76Fs+mTjp0aloR+UbceVmYtsF/mHxicbc7SCRZDtvaZJKzoQby83Om+uyM41nvZm2U
	 nVrZ+05fYngNpI6waazdFuGMsEZt3UJicfAl2I2GxhQTquhWAMA/wnGofhAAU3a5VR
	 1g4qISpmbhN2ycyH0JhDtn5sH+Ti4dfyVNQe5zHxioJaSlWTFWoFqTKFqhd+njgFgm
	 RZb3hLGlthcy1Pc1qAypf3RxvQisdqLX8i9f050vMPUtK5g1OUzpYfBiDFiACH3HJp
	 oLKTfZgy41pvg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 02 Oct 2024 17:27:16 -0400
Subject: [PATCH v10 01/12] timekeeping: add interfaces for handling
 timestamps with a floor value
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-mgtime-v10-1-d1c4717f5284@kernel.org>
References: <20241002-mgtime-v10-0-d1c4717f5284@kernel.org>
In-Reply-To: <20241002-mgtime-v10-0-d1c4717f5284@kernel.org>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7844; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=2+VLMo7X+TKT3T321kqTgs4zMRtNzRRVuC4rj6DW+Cc=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm/bq/pOISz++DqIaPinjQXm8r2ux+FEodDWTqw
 9MkXKbpGnyJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZv26vwAKCRAADmhBGVaC
 FSNmEAC/ux5B3D/H1d8eVc06UwpsjbzW9qWVQ+EdDb83LSfoT1OyhHOwvJc9orbEruZKyeuVp5F
 DIwOsP4z9ow//lDNM8u2BapdjY393P5MOpVBh8mYwPPpHGuTvLCcTdWKBciJC85QokG6fiWpGUh
 CgGtAIuTsvAM2qrN0FeWEslTcTg/XMSEC3FypKoEM2BTa5h2/FhZhsaOk6w/0p5eev9vVvn1uoQ
 l/YtTg8huFDZeYxEeZp5Yl3nzZGFAbl7m0XHrqGPcnOk1vErmfjY6Nbo+DBNTc+/diAsTwaQNf4
 I9IaEwbowLv5z3cEqCsUdxxEtMDvIWyDMSDphlLjhWG07WBhsneSlDyziwWQrZUl6BlewfwbfoV
 +ZctmC9Xo/48Oah8yVfgW/yhhXvIEBAzg0f++xLKNC6N1ou0jAsN+IWOW9Tuq7/nZKCDDgKSJEU
 hm4hfXDa9J6EbHhOIURnF3b6jIkhHcHDoB7kSkGoKbMrLWDOa+Cjl4m/eeLALFMnjT4vIaP8XJf
 x8u/MX+O7HX4faRyBPIU5WUP02BAUGV9gPBpt1XUJaluSUYv7Zh57l6X1a1nijk7nYm2Thwogan
 8kG5S56vOv6LQxQEsxRUL5GSFNDQ/glnMJnA2IOXQDXq55O0JYfn/iKCpgCK5WJ+l0bEVSqyCXk
 amyBDzLFVkZwj3w==
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
index fc12a9ba2c884271a75608211a72173b7ebaa24c..7aa85246c183576b039c02af4abba02b4a09ef9d 100644
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
index 5391e4167d60226dfc48c845170e36bcbeb7b292..ebfe846ebde35850c3e4d9c2cc45642c983d137f 100644
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


