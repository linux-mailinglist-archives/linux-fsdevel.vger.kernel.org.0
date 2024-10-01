Return-Path: <linux-fsdevel+bounces-30482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C64F98BA63
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 13:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F9B81C235CE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 11:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F071C3F1C;
	Tue,  1 Oct 2024 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5NsA4Y3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C11A1C3317;
	Tue,  1 Oct 2024 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727780370; cv=none; b=ExMjlUlUxzfG1jPrv6mzfns9I656UsbsSRXSN7PgBFZsyVCV7qmuRLIn4bH7viuie3mV1obJUMrWpgwYTsmTFUiXBYQBnsBKj7k81H+2S8qydBOcekCFUiRfQpgUI1JFvTTYcBxoy9UMfjdGm2pfYHIL/fNGD6fMwevM0uCvris=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727780370; c=relaxed/simple;
	bh=JL2gW+C3kDxbRAGj0jMp5iB8JHuDuhS4rvTtieX78oY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ot923FjRpnISbqovd3kLNtvs99pFAu1P9MkIozcdVJBKleMgI4/yMrsKRAdsY6Kzgo14ZGLryZB0Bz6i1pxMI3w7hvhoCM4iq1twvupIDFUw0vhUsZLyhW2EvKwFaoazEaeTb5iunKR+8rYAB2tvFToQBCwttOL76s9pl1SriWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5NsA4Y3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECCCC4CECE;
	Tue,  1 Oct 2024 10:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727780370;
	bh=JL2gW+C3kDxbRAGj0jMp5iB8JHuDuhS4rvTtieX78oY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B5NsA4Y3xe03GSebvPrrYvgPoGZbnw6mZTFF2+mbaE21jaWD0FJgt1XHCPTAvrT79
	 vPgqIbRwjLzaOimrju2AKsv/b/gSgB/4RSN0bLwKzrtHXHaDqtAnXqCJO2jpq2RqmX
	 X6wO1EBN+PbuMQ86TBeql6QF8WTGyZ5Z00YdTsluw0mp4xGe3a07TAoeUMe6v2oxQv
	 nVlXaK0ssXyss4VOzkZpjy37wUHfRBGsBv4J2GUWKNvzUSzUOk8cj7BRdZFIKFS+aJ
	 vlLE50z3y5Llg/g8PlVvgDXTNVTBWwx4haJ2pHrfwkMGwuWWBl6P4sGfxxbpzF0K6U
	 VFKXOjSzzaz3Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 01 Oct 2024 06:59:01 -0400
Subject: [PATCH v8 07/12] timekeeping: add percpu counter for tracking
 floor swap events
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-mgtime-v8-7-903343d91bc3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4015; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=JL2gW+C3kDxbRAGj0jMp5iB8JHuDuhS4rvTtieX78oY=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm+9X6x1c8e9tak6oUEGlf0VU1qI9Vs0dKdL9Nd
 tgbNV9wo0aJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZvvV+gAKCRAADmhBGVaC
 Fc1QD/9eMcfRLjkeM4PSq5q9wbdZwKH0ZnxF0our+6FybuPq3dyRBmPN35tLdFGBtPY7yqdWFwS
 Rs/LS0WNRMUDhr1mdiuuzBDAl87afaQm6m0Ss/fKkpUFhmk/6FI30AQA1Y6CGK6rBPZYvpRMd+t
 xgQ8SEf51BB4aQuerAYSVbDxfIaQqxooQW4UxsVhihhRpZSz79bvs9BpfTRl7CbRAPptD7zgobF
 R7mUD1bo7p1UmgGdLuhyprr+Jx7N7pdA9YQpQ08sy/92KZ+vcdGFCcsOkuq10gXYaRdVyf/PRfC
 rRDl9JHOqi1KNQBD9zb4sWygsFJGWWPQ2CW9bYimEWy0wCKUZoEouWvbzEq4spMhwAoFngdHDsS
 Bz0hFemqy9Xm0kWfhA2Nfr2napvBTjUBhmHeTbT55Nfpt1HF/UZUInHDF9AdCKxXHuQ+vQSgAhY
 zjBXOOKmI6/5Qt1tfZh/5yUgcInlYWTFh5JfBEPO8heF5DaWba7euvt0rMdn7cjfKd4yUuyR29s
 oxz6la25xBwO/N9eJtho78xkfye21spBGiN+rs91RekoH21kMmErBfxm5wrhx2AsEg1f8GUUDnQ
 DlZ8agBEXLchtmo9h03ROpDuc/ljD3laUG05Nf9rBOcUWDcUaN4Fh4A5/crNSXCfsrkG2Taaleh
 he48A3qyAV/DzSQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The mgtime_floor value is a global variable for tracking the latest
fine-grained timestamp handed out. Because it's a global, track the
number of times that a new floor value is assigned.

Add a new percpu counter to the timekeeping code to track the number of
floor swap events that have occurred. Display that as a fourth integer
in /sys/kernel/debug/multigrain_timestamps.

Tested-by: Randy Dunlap <rdunlap@infradead.org> # documentation bits
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c                         |  5 +++--
 include/linux/timekeeping.h        |  1 +
 kernel/time/timekeeping.c          |  1 +
 kernel/time/timekeeping_debug.c    | 13 +++++++++++++
 kernel/time/timekeeping_internal.h |  9 +++++++++
 5 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index e46f7170851b..93a9365cc22d 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -145,9 +145,10 @@ static int mgts_show(struct seq_file *s, void *p)
 	unsigned long ctime_updates = get_mg_ctime_updates();
 	unsigned long ctime_swaps = get_mg_ctime_swaps();
 	unsigned long fine_stamps = get_mg_fine_stamps();
+	unsigned long floor_swaps = timekeeping_get_mg_floor_swaps();
 
-	seq_printf(s, "%lu %lu %lu\n",
-		   ctime_updates, ctime_swaps, fine_stamps);
+	seq_printf(s, "%lu %lu %lu %lu\n",
+		   ctime_updates, ctime_swaps, fine_stamps, floor_swaps);
 	return 0;
 }
 
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 7aa85246c183..84a035e86ac8 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -48,6 +48,7 @@ extern void ktime_get_coarse_real_ts64(struct timespec64 *ts);
 /* Multigrain timestamp interfaces */
 extern void ktime_get_coarse_real_ts64_mg(struct timespec64 *ts);
 extern void ktime_get_real_ts64_mg(struct timespec64 *ts);
+extern unsigned long timekeeping_get_mg_floor_swaps(void);
 
 void getboottime64(struct timespec64 *ts);
 
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 37004a4758cf..c8a934c1c8aa 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2478,6 +2478,7 @@ void ktime_get_real_ts64_mg(struct timespec64 *ts)
 	if (atomic64_try_cmpxchg(&mg_floor, &old, mono)) {
 		ts->tv_nsec = 0;
 		timespec64_add_ns(ts, nsecs);
+		timekeeping_inc_mg_floor_swaps();
 	} else {
 		/*
 		 * Something has changed mg_floor since "old" was
diff --git a/kernel/time/timekeeping_debug.c b/kernel/time/timekeeping_debug.c
index b73e8850e58d..b731621ad811 100644
--- a/kernel/time/timekeeping_debug.c
+++ b/kernel/time/timekeeping_debug.c
@@ -17,6 +17,9 @@
 
 #define NUM_BINS 32
 
+/* incremented every time mg_floor is updated */
+DEFINE_PER_CPU(unsigned long, timekeeping_mg_floor_swaps);
+
 static unsigned int sleep_time_bin[NUM_BINS] = {0};
 
 static int tk_debug_sleep_time_show(struct seq_file *s, void *data)
@@ -53,3 +56,13 @@ void tk_debug_account_sleep_time(const struct timespec64 *t)
 			   (s64)t->tv_sec, t->tv_nsec / NSEC_PER_MSEC);
 }
 
+unsigned long timekeeping_get_mg_floor_swaps(void)
+{
+	int i;
+	unsigned long sum = 0;
+
+	for_each_possible_cpu(i)
+		sum += per_cpu(timekeeping_mg_floor_swaps, i);
+	return sum < 0 ? 0 : sum;
+}
+
diff --git a/kernel/time/timekeeping_internal.h b/kernel/time/timekeeping_internal.h
index 4ca2787d1642..f53e76d5ee7c 100644
--- a/kernel/time/timekeeping_internal.h
+++ b/kernel/time/timekeeping_internal.h
@@ -10,9 +10,18 @@
  * timekeeping debug functions
  */
 #ifdef CONFIG_DEBUG_FS
+DECLARE_PER_CPU(unsigned long, timekeeping_mg_floor_swaps);
+static inline void timekeeping_inc_mg_floor_swaps(void)
+{
+	this_cpu_inc(timekeeping_mg_floor_swaps);
+}
+
 extern void tk_debug_account_sleep_time(const struct timespec64 *t);
 #else
 #define tk_debug_account_sleep_time(x)
+static inline void timekeeping_inc_mg_floor_swaps(void)
+{
+}
 #endif
 
 #ifdef CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE

-- 
2.46.2


