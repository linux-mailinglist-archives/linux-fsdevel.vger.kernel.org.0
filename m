Return-Path: <linux-fsdevel+bounces-30476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5714398BA38
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 12:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B675FB2265F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 10:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6204A1BF810;
	Tue,  1 Oct 2024 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="di+Ntkta"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB5A1BF7EC;
	Tue,  1 Oct 2024 10:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727780353; cv=none; b=GrHmAtJe2tHYwOJqfs06fhAVvW30uGFTXC4oBUnIlyAmk5xGOC9p6M1Rumsm51rd1i8stn90/HJISrrQNTYuguZD7QzFjKMXFxdTDjeG9RY9hHCgr2S3Oi+TB2w4778J/MiC8KPJg4/UqNjOIHml1JAqpE3pnQjF2DYOuJDNnjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727780353; c=relaxed/simple;
	bh=Dyhqpi3r2jE4Qp9OIe8aVuLXfVqzINBPByhzwJGovx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=be9E75rV+LWP0OYNvi6w59P+2QZm4Wr+WGFqSOEoj//UFmxjKZGouwqKsMAOYUppIUZlUqv2Rrr5DwsPxJmqlhBWdvWi5RT3YeRZ9nJIDrrZ6ib+W7MLk7pO9CQvDdEGEJMSDai9h9PKeFlV3AI0X3rtBhOMiBNyLl1LtEUumu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=di+Ntkta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D676DC4CED1;
	Tue,  1 Oct 2024 10:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727780353;
	bh=Dyhqpi3r2jE4Qp9OIe8aVuLXfVqzINBPByhzwJGovx0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=di+Ntkta84XIbICT1l6uHEZQqcJAWyuEkz56XDUMly44w/9xQ2bM53vsliOMIyNCY
	 WFZn0iYiL+n2Am2GBNpYLLGzJZTei41kMfnCjKXAGL5+0Kjd9b4Lt6CI4iWbhpmG2d
	 VonfbrVQIEV8jsfwNJ5Mj9v/c7o31NnoSV1WAqv/nBIXVbbW8KG16DvSATspUnUieR
	 d2C+aaJF5j9nFIyonHxYD1CChWF6buB3hjeqpFSbgHAPikLudDgCuflPomFx1Sjw1y
	 cNl6EADebtp4b5OqDvoz9O8qUSnTiSWj3lfjrGwBGUyH4qcPsWesmPEVq119GT5KqI
	 SXviJqRrkTDvg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 01 Oct 2024 06:58:55 -0400
Subject: [PATCH v8 01/12] timekeeping: add interfaces for handling
 timestamps with a floor value
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-mgtime-v8-1-903343d91bc3@kernel.org>
References: <20241001-mgtime-v8-0-903343d91bc3@kernel.org>
In-Reply-To: <20241001-mgtime-v8-0-903343d91bc3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7181; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Dyhqpi3r2jE4Qp9OIe8aVuLXfVqzINBPByhzwJGovx0=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm+9X5JtTXeFjUK9UuoZQvQI8+qcObCx94f/dTY
 /S/ZWh1uamJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZvvV+QAKCRAADmhBGVaC
 FSXQD/4lCar2TPcWziWfbWJoJLmUiOIURbAaVR6eJgKLBKHOgr9JM3SpvS1z6bDZU5a7tpyQvS7
 YEwCjNF/vVWqnVGaNq9gSku9USOKNV4bvpJtatqhqKkYJGW99o6FoD0oP1M/hgJOtgZ4y4Ue0QE
 +I1FGS3T0QiJLp7T0QRNE548J5KdjyzC8d1vWEKHBoQaYuQNHOANILK2sx+7Ll9GmtR3oFKM6FZ
 vAb9Uq9cZiMCQH96uRU9SwOI7xRmv+s9wDvcVEmJ/C5sOfatL+SW1C9BH2scMXRXPeOHouFG24e
 Kssf4xMp6TxLT3pnQERfygw1v3T7JiSand39N+0sLQgE0Udb4XnXtTUQ86OOSeqmfg7lIQlq+fz
 RYk48ZGEWYokMxJBNf1zyXtAR6GHpECJ4+eWQsgZ3gh/vRjtepMfPyaQggBoAu9bcqZJzUdA7B4
 PTKzVJlkCzn8FY/a8Wh/J7xzRBS9xds9fqTlTYLyBrxE7sIvG/7KXXbq/9rBSTJ3nZMrKrv3gzG
 pNmJlvToQsJSSGSiZJZxdt97nI2B4DD4xAo87YdPd+1rxtE3PzeiF2KGu0Fdg+xA+GivAJc2v3t
 HamDS6Ofti8G/RFQGXJhwpAPytOmoiBVhg8iETXmCBzB5kFpn66ywgDs1zySURdVisrTq+6Qvxx
 f5+y8P3aSPKiW+w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Multigrain timestamps allow the kernel to use fine-grained timestamps
when an inode's attributes is being actively observed via ->getattr().
With this support, it's possible for a file to get a fine-grained
timestamp, and another modified after it to get a coarse-grained stamp
that is earlier than the fine-grained time.  If this happens then the
files can appear to have been modified in reverse order, which breaks
VFS ordering guarantees.

To prevent this, maintain a floor value for multigrain timestamps.
Whenever a fine-grained timestamp is handed out, record it, and when
coarse-grained stamps are handed out, ensure they are not earlier than
that value. If the coarse-grained timestamp is earlier than the
fine-grained floor, return the floor value instead.

Add a static singleton atomic64_t into timekeeper.c that we can use to
keep track of the latest fine-grained time ever handed out. This is
tracked as a monotonic ktime_t value to ensure that it isn't affected by
clock jumps. Because it is updated at different times than the rest of
the timekeeper object, the floor value is managed independently of the
timekeeper via a cmpxchg() operation, and sits on its own cacheline.

This patch also adds two new public interfaces:

- ktime_get_coarse_real_ts64_mg() fills a timespec64 with the later of the
  coarse-grained clock and the floor time

- ktime_get_real_ts64_mg() gets the fine-grained clock value, and tries
  to swap it into the floor. A timespec64 is filled with the result.

Since the floor is global, take care to avoid updating it unless it's
absolutely necessary. If we do the cmpxchg and find that the value has
been updated since we fetched it, then we discard the fine-grained time
that was fetched in favor of the recent update.

Note that the VFS ordering guarantees assume that the realtime clock
does not experience a backward jump. POSIX requires that we stamp files
using realtime clock values, so if a backward clock jump occurs, then
files can appear to have been modified in reverse order.

Tested-by: Randy Dunlap <rdunlap@infradead.org> # documentation bits
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/timekeeping.h |  4 ++
 kernel/time/timekeeping.c   | 96 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

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
index 7e6f409bf311..37004a4758cf 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -114,6 +114,22 @@ static struct tk_fast tk_fast_raw  ____cacheline_aligned = {
 	.base[1] = FAST_TK_INIT,
 };
 
+/*
+ * Multigrain timestamps require that we keep track of the latest fine-grained
+ * timestamp that has been issued, and never return a coarse-grained timestamp
+ * that is earlier than that value.
+ *
+ * mg_floor represents the latest fine-grained time that we have handed out as
+ * a timestamp on the system. Tracked as a monotonic ktime_t, and converted to
+ * the realtime clock on an as-needed basis.
+ *
+ * This ensures that we never issue a timestamp earlier than one that has
+ * already been issued, as long as the realtime clock never experiences a
+ * backward clock jump. If the realtime clock is set to an earlier time, then
+ * realtime timestamps can appear to go backward.
+ */
+static __cacheline_aligned_in_smp atomic64_t mg_floor;
+
 static inline void tk_normalize_xtime(struct timekeeper *tk)
 {
 	while (tk->tkr_mono.xtime_nsec >= ((u64)NSEC_PER_SEC << tk->tkr_mono.shift)) {
@@ -2394,6 +2410,86 @@ void ktime_get_coarse_real_ts64(struct timespec64 *ts)
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
+EXPORT_SYMBOL_GPL(ktime_get_coarse_real_ts64_mg);
+
+/**
+ * ktime_get_real_ts64_mg - attempt to update floor value and return result
+ * @ts:		pointer to the timespec to be set
+ *
+ * Get a monotonic fine-grained time value and attempt to swap it into the
+ * floor. If it succeeds then accept the new floor value. If it fails
+ * then another task raced in during the interim time and updated the floor.
+ * That value is just as valid, so accept that value in this case.
+ *
+ * @ts will be filled with the resulting floor value, regardless of
+ * the outcome of the swap. Note that this is a filesystem specific interface
+ * and should be avoided outside of that context.
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
+	 * Attempt to update the floor with the new time value. Accept the
+	 * resulting floor value regardless of the outcome of the swap.
+	 */
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
2.46.2


