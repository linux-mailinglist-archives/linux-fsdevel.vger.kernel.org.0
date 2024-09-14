Return-Path: <linux-fsdevel+bounces-29385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E78797926F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 19:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC3E1F20CD1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 17:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA85A1D54D8;
	Sat, 14 Sep 2024 17:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aD+iHFXG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2732C1D589A;
	Sat, 14 Sep 2024 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726333659; cv=none; b=Qt+sygecCntRf3fH1f5NjXEnG940+XDYMn1HKhEhhnit61GqN4HXzBCvKpOI3f+RffMvjW9Bi7PuC5072rUjFbzxqn5v27bUux5Rv4NiwegzZqrF6cp3jsB7nlmdIq5TMk5gDFPR44tmbadR1m1HsGSBabiDVkaCoAEvlg9gN+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726333659; c=relaxed/simple;
	bh=+3a+MvaEmr8jlVEnfUS/6TeXNgPVOZEguly4I5T5qLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s6ni0GAUVWKHTvJIBd1nd7tizCg4gbggIjrIxZmW8lvqh9jBP9AAfp6S86RyJ6O6TbFqVeZo0qfRGb9RH1xCDIC2313bpZy7wAVCYYumfoiVuR00P6t17TfA3bvYpAmUTfCiVsYRQP4DFGsWrk+B+CYo6FKqRF/5oWCLtNDSP+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aD+iHFXG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F96C4CECF;
	Sat, 14 Sep 2024 17:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726333658;
	bh=+3a+MvaEmr8jlVEnfUS/6TeXNgPVOZEguly4I5T5qLo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aD+iHFXGqA5JgGaTYLcJ4FNvOcGWpB4PW6RtlVSPpR24jd5+bFiFM7Pxh4qJ7JBu/
	 dYIJMiQoz4IGBxFkWI0inRm2+leKVKhkQPUsfiEYkIMZnGasQL+JLA9x0dgds+ULSU
	 6UHnPiF4cgMAYIHYTD397RggIVocHkt1rqfLCKDYAdercMlwkBqOrPnh4rMnVH2tv9
	 i2lBH38WJTEteBvsFxDp6mzkxg6PJ3Z5ju7h/GBfzNQsaAwis4exfZKYq5TQvOO4kz
	 5RJaBkotGU4z1xjOjBeeY3gXWZ4yC4qeDlfubsn5Bu1zr3Mq4cPE1xE/CqXo+y/PwG
	 uwtpVpVM9zK1g==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 14 Sep 2024 13:07:19 -0400
Subject: [PATCH v8 06/11] fs: add percpu counters for significant
 multigrain timestamp events
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240914-mgtime-v8-6-5bd872330bed@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7206; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=+3a+MvaEmr8jlVEnfUS/6TeXNgPVOZEguly4I5T5qLo=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm5cLGQYo9QregMNCy/xaR7pG6H/Plnuv5MCrll
 yGT7FFAkm2JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZuXCxgAKCRAADmhBGVaC
 FY4dEACQ30o7dm6/X64AG7zaEOxgddb96T6gDj8TDTuCswZDN4BXXzgQQ3pmW+k7IGGXxgoZv1L
 Ah6te+pdJPDzaY3XkddSkrAAGklFh7bDRhwz8fN8W003zQIHSMLCDPT1jMdThh8U6VYDLvstq3J
 fY/+GyscMLHjaven87xQGU7DXJdWqWRdXfEmP4iJzBOEWti/U/YEECZ9XLSs6OMyHAGH0VV2zZM
 v3RDk5ivfmR4OiifBN+dR6ycULQFIjHh29mfYZQZPpNiYK2ud1uLkRmmoAznFTlt73zas407QZ2
 4uiaN9PsVyHOwcraYMC5K0NeXzKPC4bm4fbnkTQ/7tLTUJ2aoNAt2tcV0aXnLNNwZQegh23JyDh
 HAAnq1W0uM6cjxXT21V03epzC8gmaprBda2pT2QpiNz5yMawOu+8d7M8DqN6HfBbWbCT3JMmSsi
 qlx05niBKzs0E1YgjmAcUG5S1RsxE+ma0nGcxRXSq9q0NziRwTw82xxPxihZ/yaF8OVPWGZ45B8
 lQjwUDqgHSkbJ2XLa1YdE0CeJXhcCqpYQux5mgJw0aWJV2aa1lJOvRxWhoX2MkKyMV268AtM/gd
 Q8nadX2GchrFtBB7Oe906n/rM7CnD+U0z7G0xGfbbZVDWb+4AdPB5Olj+iI9A9YEG7axNm6KMBJ
 VObT+RUdyFXPSzA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

New percpu counters for counting various stats around mgtimes, and a new
debugfs file for displaying them when CONFIG_DEBUG_FS is enabled:

- number of attempted ctime updates
- number of successful i_ctime_nsec swaps
- number of fine-grained timestamp fetches
- number of coarse-grained floor swaps

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c                         | 76 ++++++++++++++++++++++++++++++++++++--
 include/linux/timekeeping.h        |  1 +
 kernel/time/timekeeping.c          |  3 +-
 kernel/time/timekeeping_debug.c    | 12 ++++++
 kernel/time/timekeeping_internal.h |  3 ++
 5 files changed, 90 insertions(+), 5 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index d7da9d06921f..1f0487104c71 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -21,6 +21,8 @@
 #include <linux/list_lru.h>
 #include <linux/iversion.h>
 #include <linux/rw_hint.h>
+#include <linux/seq_file.h>
+#include <linux/debugfs.h>
 #include <trace/events/writeback.h>
 #define CREATE_TRACE_POINTS
 #include <trace/events/timestamp.h>
@@ -101,6 +103,70 @@ long get_nr_dirty_inodes(void)
 	return nr_dirty > 0 ? nr_dirty : 0;
 }
 
+#ifdef CONFIG_DEBUG_FS
+static DEFINE_PER_CPU(long, mg_ctime_updates);
+static DEFINE_PER_CPU(long, mg_fine_stamps);
+static DEFINE_PER_CPU(long, mg_ctime_swaps);
+
+static long get_mg_ctime_updates(void)
+{
+	int i;
+	long sum = 0;
+
+	for_each_possible_cpu(i)
+		sum += per_cpu(mg_ctime_updates, i);
+	return sum < 0 ? 0 : sum;
+}
+
+static long get_mg_fine_stamps(void)
+{
+	int i;
+	long sum = 0;
+
+	for_each_possible_cpu(i)
+		sum += per_cpu(mg_fine_stamps, i);
+	return sum < 0 ? 0 : sum;
+}
+
+static long get_mg_ctime_swaps(void)
+{
+	int i;
+	long sum = 0;
+
+	for_each_possible_cpu(i)
+		sum += per_cpu(mg_ctime_swaps, i);
+	return sum < 0 ? 0 : sum;
+}
+
+#define mgtime_counter_inc(__var)	this_cpu_inc(__var)
+
+static int mgts_show(struct seq_file *s, void *p)
+{
+	long ctime_updates = get_mg_ctime_updates();
+	long ctime_swaps = get_mg_ctime_swaps();
+	long fine_stamps = get_mg_fine_stamps();
+	long floor_swaps = get_mg_floor_swaps();
+
+	seq_printf(s, "%ld %ld %ld %ld\n",
+		   ctime_updates, ctime_swaps, fine_stamps, floor_swaps);
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(mgts);
+
+static int __init mg_debugfs_init(void)
+{
+	debugfs_create_file("multigrain_timestamps", S_IFREG | S_IRUGO, NULL, NULL, &mgts_fops);
+	return 0;
+}
+late_initcall(mg_debugfs_init);
+
+#else /* ! CONFIG_DEBUG_FS */
+
+#define mgtime_counter_inc()	do { } while (0)
+
+#endif /* CONFIG_DEBUG_FS */
+
 /*
  * Handle nr_inode sysctl
  */
@@ -2655,10 +2721,9 @@ EXPORT_SYMBOL(timestamp_truncate);
  *
  * If it is multigrain, then we first see if the coarse-grained timestamp is
  * distinct from what we have. If so, then we'll just use that. If we have to
- * get a fine-grained timestamp, then do so, and try to swap it into the floor.
- * We accept the new floor value regardless of the outcome of the cmpxchg.
- * After that, we try to swap the new value into i_ctime_nsec. Again, we take
- * the resulting ctime, regardless of the outcome of the swap.
+ * get a fine-grained timestamp, then do so. After that, we try to swap the new
+ * value into i_ctime_nsec. We take the resulting ctime, regardless of the
+ * outcome of the swap.
  */
 struct timespec64 inode_set_ctime_current(struct inode *inode)
 {
@@ -2687,8 +2752,10 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 		if (timespec64_compare(&now, &ctime) <= 0) {
 			ktime_get_real_ts64_mg(&now);
 			now = timestamp_truncate(now, inode);
+			mgtime_counter_inc(mg_fine_stamps);
 		}
 	}
+	mgtime_counter_inc(mg_ctime_updates);
 
 	/* No need to cmpxchg if it's exactly the same */
 	if (cns == now.tv_nsec && inode->i_ctime_sec == now.tv_sec) {
@@ -2702,6 +2769,7 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 		/* If swap occurred, then we're (mostly) done */
 		inode->i_ctime_sec = now.tv_sec;
 		trace_ctime_ns_xchg(inode, cns, now.tv_nsec, cur);
+		mgtime_counter_inc(mg_ctime_swaps);
 	} else {
 		/*
 		 * Was the change due to someone marking the old ctime QUERIED?
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 7aa85246c183..b9c8c597a073 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -48,6 +48,7 @@ extern void ktime_get_coarse_real_ts64(struct timespec64 *ts);
 /* Multigrain timestamp interfaces */
 extern void ktime_get_coarse_real_ts64_mg(struct timespec64 *ts);
 extern void ktime_get_real_ts64_mg(struct timespec64 *ts);
+extern long get_mg_floor_swaps(void);
 
 void getboottime64(struct timespec64 *ts);
 
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 16937242b904..94b0219955a2 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2440,7 +2440,7 @@ EXPORT_SYMBOL_GPL(ktime_get_coarse_real_ts64_mg);
  * regardless of the outcome of the swap. Note that this is a filesystem
  * specific interface and should be avoided outside of that context.
  */
-void ktime_get_real_ts64_mg(struct timespec64 *ts, u64 cookie)
+void ktime_get_real_ts64_mg(struct timespec64 *ts)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	ktime_t old = atomic64_read(&mg_floor);
@@ -2464,6 +2464,7 @@ void ktime_get_real_ts64_mg(struct timespec64 *ts, u64 cookie)
 	if (atomic64_try_cmpxchg(&mg_floor, &old, mono)) {
 		ts->tv_nsec = 0;
 		timespec64_add_ns(ts, nsecs);
+		mgtime_counter_inc(mg_floor_swaps);
 	} else {
 		/*
 		 * Something has changed mg_floor since "old" was
diff --git a/kernel/time/timekeeping_debug.c b/kernel/time/timekeeping_debug.c
index b73e8850e58d..9a3792072762 100644
--- a/kernel/time/timekeeping_debug.c
+++ b/kernel/time/timekeeping_debug.c
@@ -17,6 +17,9 @@
 
 #define NUM_BINS 32
 
+/* incremented every time mg_floor is updated */
+DEFINE_PER_CPU(long, mg_floor_swaps);
+
 static unsigned int sleep_time_bin[NUM_BINS] = {0};
 
 static int tk_debug_sleep_time_show(struct seq_file *s, void *data)
@@ -53,3 +56,12 @@ void tk_debug_account_sleep_time(const struct timespec64 *t)
 			   (s64)t->tv_sec, t->tv_nsec / NSEC_PER_MSEC);
 }
 
+long get_mg_floor_swaps(void)
+{
+	int i;
+	long sum = 0;
+
+	for_each_possible_cpu(i)
+		sum += per_cpu(mg_floor_swaps, i);
+	return sum < 0 ? 0 : sum;
+}
diff --git a/kernel/time/timekeeping_internal.h b/kernel/time/timekeeping_internal.h
index 4ca2787d1642..2b49332b45a5 100644
--- a/kernel/time/timekeeping_internal.h
+++ b/kernel/time/timekeeping_internal.h
@@ -11,8 +11,11 @@
  */
 #ifdef CONFIG_DEBUG_FS
 extern void tk_debug_account_sleep_time(const struct timespec64 *t);
+DECLARE_PER_CPU(long, mg_floor_swaps);
+#define mgtime_counter_inc(__var)	this_cpu_inc(__var)
 #else
 #define tk_debug_account_sleep_time(x)
+#define mgtime_counter_inc()	do { } while (0)
 #endif
 
 #ifdef CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE

-- 
2.46.0


