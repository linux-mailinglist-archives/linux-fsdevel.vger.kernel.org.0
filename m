Return-Path: <linux-fsdevel+bounces-29380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE9697924C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 19:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8701F22752
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 17:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85421D220A;
	Sat, 14 Sep 2024 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgrESo/2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AFE1D094B;
	Sat, 14 Sep 2024 17:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726333647; cv=none; b=q3JVK/f5hNTfuWAao8gKYIbLgjxS7x9Nehi+EyXIWLIN0lG8nM2/M0XMEggpUJraeD+DkGuXqPKu7AB/afHK797hUC1HBt8WE1SgZJQhBlzgtIkCpzH8Dl5qEpUM//I8TPDIjSQuJQ0XYMpLuCl9RvLbbdUkLK5AcUB60z43lHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726333647; c=relaxed/simple;
	bh=I9/47O7qo7bvUG1tGenasxTgf1bKbVz1h75bJIuETII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Il/kKVrKldO9ZdmI7BPUvh0svpI3Z0R5k7dyILnJSXIW70et3fXzU3hmDnUhVVGSdDjKpTFhar14RNTGFXUOj8Fn2w2aiDFPKGEwNtU1rRf4TA+8j0Zl/O/HDkrdOErmj0TovADThGYo9eITZb/qI4eEEokUV+8sMIpwF+I4GXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgrESo/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B09C4CECE;
	Sat, 14 Sep 2024 17:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726333644;
	bh=I9/47O7qo7bvUG1tGenasxTgf1bKbVz1h75bJIuETII=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qgrESo/2dKlnGWdwdJt4WBacgChSPGID4vFllkaU0ksLvfh8W0/erR8TcsEd20YuZ
	 qy7LG7yQaw1+e/hwVRstO2c5SRLjUDVSP/ai1Epg+DZnh8JrRgfa5TP41U31y2xz/7
	 +080vYTYI1+3AEo46MOZstgKVgoVQmbrOFSFzlkobnc00Vjxiieldhagjt4wBVp973
	 XWYxtSPcLauiLWBgbApL12W40KgS+mjYM9Rf0aPgs+ds4DZXA4+rRSTEnRWVCNll2X
	 J3CCfCt44JNNKu6dnZep+GyBvY2msx2KWB6EgyIY2/rZe6t72Qcb7qRfabSY4kKAsr
	 o+N7Q0cpT2x6w==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 14 Sep 2024 13:07:14 -0400
Subject: [PATCH v8 01/11] timekeeping: move multigrain timestamp floor
 handling into timekeeper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240914-mgtime-v8-1-5bd872330bed@kernel.org>
References: <20240914-mgtime-v8-0-5bd872330bed@kernel.org>
In-Reply-To: <20240914-mgtime-v8-0-5bd872330bed@kernel.org>
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
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5475; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=I9/47O7qo7bvUG1tGenasxTgf1bKbVz1h75bJIuETII=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm5cLFY6lXZvZm8RxN6kOFAGtO8JT2riURAMDHv
 52tncP7VVSJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZuXCxQAKCRAADmhBGVaC
 FVmqD/42vnYgXZg5mzwCTj8STzoscinyiV3K/zfYJZXBKlhsahthN4ivhC4Pb/lyArui3/IxAQq
 EWZuccCCsliVOR5fGIXxBnGCyGUE/NFyJcgQVEdAjlz/lglEXC0qzAgFyqnBFXLjHIO/vEBN9A+
 3YgW/1rz3+jDt7H0Kfaszw9349+fGDmnzIlYg0fLqOG1l9LIdTFY7d1tCWtOxFJOhGeP+m5EUna
 +jv01w18PUKFWAnYS5w3rpbXPSkmQt/sw6EeN19nRR3QwlkumZck7VVgKrkWPzk1k1fY1omGGeN
 uu8YXrAhrI48XJ65fOyuUw4jBALv+ImDZwQGejRRPsguzETloqOXZI7HFDS+gpo52sMT22HwmgI
 XrpgwBa1uVZVVqf02ZnjHftQRwVpHryUcccG4KCDzFW1ZkTKyIjUxpqhXcEAp6jR8/Roa58umQ1
 qXMl1cHM2aIpIjH7vLxInGCDw/RpXZMST+q5+QwCvBnKs4WeJBuaI0XLBsBMmbfQhhqiKf3L+HF
 7xIK1uDDqzl9gZXVjuD8xpxGxLyhcf6BoT+dbv1E7KV5V8C8OJtRfPiuB/r6fbvaeqXDQLdlNxv
 vHj65OVIB+mRWvY0NEVU9WSQgxeWZ24UWiflRgY4sxq6+zKOkdbJNn9cAkfgQhI/GS1tqCKU3Mq
 e6rjZuBfD33jY/w==
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
 kernel/time/timekeeping.c   | 82 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

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
index 5391e4167d60..16937242b904 100644
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
@@ -2394,6 +2401,81 @@ void ktime_get_coarse_real_ts64(struct timespec64 *ts)
 }
 EXPORT_SYMBOL(ktime_get_coarse_real_ts64);
 
+/**
+ * ktime_get_coarse_real_ts64_mg - get later of coarse grained time or floor
+ * @ts: timespec64 to be filled
+ *
+ * Adjust floor to realtime and compare it to the coarse time. Fill
+ * @ts with the latest one. Note that this is a filesystem-specific
+ * interface and should be avoided outside of that context.
+ */
+void ktime_get_coarse_real_ts64_mg(struct timespec64 *ts)
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
+}
+EXPORT_SYMBOL_GPL(ktime_get_coarse_real_ts64_mg);
+
+/**
+ * ktime_get_real_ts64_mg - attempt to update floor value and return result
+ * @ts:		pointer to the timespec to be set
+ *
+ * Get a current monotonic fine-grained time value and attempt to swap
+ * it into the floor. @ts will be filled with the resulting floor value,
+ * regardless of the outcome of the swap. Note that this is a filesystem
+ * specific interface and should be avoided outside of that context.
+ */
+void ktime_get_real_ts64_mg(struct timespec64 *ts, u64 cookie)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+	ktime_t old = atomic64_read(&mg_floor);
+	ktime_t offset, mono;
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
+		 * fetched. "old" has now been updated with the
+		 * current value of mg_floor, so use that to return
+		 * the current coarse floor value.
+		 */
+		*ts = ktime_to_timespec64(ktime_add(old, offset));
+	}
+}
+EXPORT_SYMBOL_GPL(ktime_get_real_ts64_mg);
+
 void ktime_get_coarse_ts64(struct timespec64 *ts)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;

-- 
2.46.0


