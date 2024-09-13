Return-Path: <linux-fsdevel+bounces-29318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C580F9781A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 15:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5293A1F21CC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 13:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D211DC194;
	Fri, 13 Sep 2024 13:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSnStM37"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4551DC053;
	Fri, 13 Sep 2024 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235663; cv=none; b=uPtZwPhpWRVCmCpSEQiKt0hasFWeSIIlu83oWASmB1j5x6twpdDFQSb02DVix21NYJcLp0pRjEteAsudqj5Y2HSFGDoS8XCmVvijypS6DHSA5dQGsAUZMtB8M5S0vFBqCYt17WCcBdJ/ER4pNy+trQP8GA28WorwLhp83sd1MiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235663; c=relaxed/simple;
	bh=1wQqjayOZU9OU7OIyp79413cwp1jIKED+/ddvabpxRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J625yz485ik744zandWN7v2VUWVaI+So3RZlFas0DKLm0t2orry5fklVcFTrr5zAfq87eSVO8Y8T4ZFXLEhDLMXquStn4bs7l2fH8stoez8XsNw6D9fcGnQ4WgoYbqac6SYE/i91mrIohIX5/DTem+bPrvxXwpwQBoFVvUiCM/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSnStM37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1FF1C4CECE;
	Fri, 13 Sep 2024 13:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726235663;
	bh=1wQqjayOZU9OU7OIyp79413cwp1jIKED+/ddvabpxRE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MSnStM37sPnp9DXk4F6EIH6b72VjVzSahHG8G3GrAM200gv2K3Q39nAW3S5z3EOtE
	 YdNIC+JimHrlIa7gtqOhHM521Fior7jUBndNkAbd529aesrqar5Nwxs7WMIQ1ynSLt
	 qyp+qe8ZzfaDvLGTiVAMQR3llWrqqGicXXd510d8kigpkfYCkdYbPmnFL3hn6uh/Ky
	 B+htVPC9d6ON+9bsUM8ujYAuur0rLfdN14R7QQrFOKUU/8LHZCEe6GPNCR+eU0Tunv
	 caCGQZZBsW3OvNBhbBOihZkDcWUqE0qreZ8YpbezQZVWmOMSC/JMhMgDnV9wpxSoYW
	 NZ50YB4avb+8Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 13 Sep 2024 09:54:10 -0400
Subject: [PATCH v7 01/11] timekeeping: move multigrain timestamp floor
 handling into timekeeper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-mgtime-v7-1-92d4020e3b00@kernel.org>
References: <20240913-mgtime-v7-0-92d4020e3b00@kernel.org>
In-Reply-To: <20240913-mgtime-v7-0-92d4020e3b00@kernel.org>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Chandan Babu R <chandan.babu@oracle.com>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5382; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=1wQqjayOZU9OU7OIyp79413cwp1jIKED+/ddvabpxRE=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm5EQHdrxoA4Zv70eWUKOVfFaSb4FDc6+mmDM7U
 djCsOXWJIqJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZuREBwAKCRAADmhBGVaC
 FahsD/kBt0wSc8RQuJxojIJblnZIg2g0aJ85YqPnmoTQvcCecxKf6H0dOsXyVro9MKCuVISYgOy
 RfqTSz7o4LRR/lbBCwc7T2w3n0WRmW4SM2LpjyJBP7pxAvnzVaoXcBkkxE0OOEl6QnBnGqBvkah
 n3pXUc0xiOQarhuwPSzTNc8oRsz0UD6nk5p0pFdyFwnsi9CeVXkWat6VjuOW/iKnvjdz0mW3lAs
 uqb8yLh139vG5amFjLrdGvlUc1zuSoFqy+psf+DNCdq/thiUJdueGvjN/pNooci0W4j09oXs5bV
 dCyMx7CanVzHwG8k8HP/TBR/HFXopkhtTMZavqvTmNx/LqK1IV1m5g+4mMNZn1zEiv7pjMzgzVT
 Op7Rk8bqkRddOdSlWbUPnE1bSaSRE7cd2RDX9BThB6UT0a3eiePLw1J9me1BdjWpHwdWek0OuRI
 ar8r0yN4lrmoUl3qWKFCyqLOAXsxqzihaAbJexTcpSBF+8t+WwD+laHMrtLMWKNVbbJAdhiSQxv
 w9IXUdEcB/NTRfacm1UeULZsgoMMXqWNZ2WFORMx1wgI3Df6PpBnwaoQ+Ot5P248reTCTnkKBdO
 1BPzWFcTt+qzByEH0lJMjIT6kNjOL8nU5Z52XyHttqAYCIyPpWxjWtaSAsRQK+TWrUCtfVw3nbp
 ko5CuOLpgy0RNxA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

For multigrain timestamps, we must keep track of the latest timestamp
that has ever been handed out, and never hand out a coarse time below
that value.

Add a static singleton atomic64_t into timekeeper.c that we can use to
keep track of the latest fine-grained time ever handed out. This is
tracked as a monotonic ktime_t value to ensure that it isn't affected by
clock jumps.

Add two new public interfaces:

- ktime_get_coarse_real_ts64_mg() fills a timespec64 with the later of the
  coarse-grained clock and the floor time

- ktime_get_real_ts64_mg() gets the fine-grained clock value, and tries
  to swap it into the floor. A timespec64 is filled with the result.

Since the floor is global, we take great pains to avoid updating it
unless it's absolutely necessary. If we do the cmpxchg and find that the
value has been updated since we fetched it, then we discard the
fine-grained time that was fetched in favor of the recent update.

To maximize the window of this occurring when multiple tasks are racing
to update the floor, ktime_get_coarse_real_ts64_mg returns a cookie
value that represents the state of the floor tracking word, and
ktime_get_real_ts64_mg accepts a cookie value that it uses as the "old"
value when calling cmpxchg().

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/timekeeping.h |  4 +++
 kernel/time/timekeeping.c   | 81 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

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
index 5391e4167d60..ee11006a224f 100644
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
@@ -2394,6 +2401,80 @@ void ktime_get_coarse_real_ts64(struct timespec64 *ts)
 }
 EXPORT_SYMBOL(ktime_get_coarse_real_ts64);
 
+/**
+ * ktime_get_coarse_real_ts64_mg - get later of coarse grained time or floor
+ * @ts: timespec64 to be filled
+ *
+ * Adjust floor to realtime and compare it to the coarse time. Fill
+ * @ts with the latest one. Returns opaque cookie suitable for passing
+ * to ktime_get_real_ts64_mg().
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
+
+	if (atomic64_try_cmpxchg(&mg_floor, &old, mono)) {
+		ts->tv_nsec = 0;
+		timespec64_add_ns(ts, nsecs);
+	} else {
+		/*
+		 * Something has changed mg_floor since "old" was
+		 * fetched. That value is just as valid, so accept it.
+		 */
+		*ts = ktime_to_timespec64(ktime_add(old, offset));
+	}
+}
+EXPORT_SYMBOL(ktime_get_real_ts64_mg);
+
 void ktime_get_coarse_ts64(struct timespec64 *ts)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;

-- 
2.46.0


