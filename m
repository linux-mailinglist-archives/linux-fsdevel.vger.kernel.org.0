Return-Path: <linux-fsdevel+bounces-30769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A34C98E307
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 20:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED0B283B32
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 18:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164C521BB1B;
	Wed,  2 Oct 2024 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpAwcvtX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DCA21BAFB;
	Wed,  2 Oct 2024 18:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727895012; cv=none; b=QnJd/pwU4Nipy7lvdPgikx9A6K9hI8vHIe41XzgiIq9KACq37YHQ5cQWahKkGKaI+JSth9+N7rALw+RYZB/9Z/4Zs0dUVd6fA0GAXJOInDUxOvj631npXtZy5DR0odiLEBAE8KWRelddkE4PFpTUkPw+sOlpAWzuYcQWiGCr+ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727895012; c=relaxed/simple;
	bh=FAEtrer/wxauwCEIrxfqdGNO00oW6MLUKCATzsbfXLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D4Pj5W9hv5/Y72fcNPnXKuHwpHh/w/tJQf0s+ep4mnuEO1LFj3DzGwVEnv7SmKCWgQcR/i+QiZTmeMI9Q+EsvEjf8kPfEN9ojpJil6jMvZcv8ODC60AdBjdUGSENO67h0ScUS1l9/xtdgrp72p7F5eYVcP1Opm0M34Kp4RgacHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpAwcvtX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5535EC4CECE;
	Wed,  2 Oct 2024 18:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727895011;
	bh=FAEtrer/wxauwCEIrxfqdGNO00oW6MLUKCATzsbfXLI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fpAwcvtXD8gfXd+PRfOJ+eqsAUC72UscmwOYTBkuWJzbNNB4lEzo1BS9ykVMuQnzL
	 I1anPto2AGBaLRz0Q+v3kDGQ8gWnGoPQTXUPSI9cfLGMpD3YnDpElJIrvmztyv6fMA
	 QkHfGNeYclB/Qh3WRx1AfgQR0AKMYASoueR/HIBIZI1s2l9Xk2eqtyQkwL7IEI9Ego
	 z8V83SwLi6tetczfYZ8miK3HwZNhMdeRP5cZe9WWmUP8dRbxXA09wyqwaNZdzCUj54
	 bJ/UxGRxJ085xIavpXrM3j0Z8mU/0QaSxe60rs/RYwR4Ab5Gul1xTwAFM43qml1b0d
	 ry3eRS2sLlcWQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 02 Oct 2024 14:49:35 -0400
Subject: [PATCH v9 07/12] timekeeping: add percpu counter for tracking
 floor swap events
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-mgtime-v9-7-77e2baad57ac@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4023; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=FAEtrer/wxauwCEIrxfqdGNO00oW6MLUKCATzsbfXLI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm/ZXMjLTfOiELFgyyDhd7gxbf4QE/JplmWCrQl
 HH5l56MD7SJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZv2VzAAKCRAADmhBGVaC
 FTH4D/kBv/Pckw5cqhCOB6dqYpa9qps2pXUNeKu2ETbMkfkS9X4q8TDcK80iM/edS2D9zjeuEAx
 dlLzn6rHLiWHxyauX5kFVWDTjMISqrraFxbEX9RA1FI8Kr1OIJoYof20HadOT2uApXtnswJL680
 NjBU3qCtIic1QfxkOs3kfme3JJ7lS917DSFkrEuwGKGCMfV2ug44Ka+EmlyRaTHgaMMT/yjqTKT
 Z3ECTJCfmKPRbpbrjvphcx5vMRKpngzgPq6tlDx8qvm0hGao4wNR+cl2g4sqGFvATw4x7C/BT6v
 mSAESlBpjD7XWrhL2IvmIP6NjtPjknSe84QJjoJTDWpAeo6YZ1DzWja546B7NfCfS63N7KJ4l2+
 SRs9p4DneuGAgiH9xMkjR6Z7CpghFFebG2X7XeOOL7Qp9GR7VMiOvH859wZlSSMT/VHQStfhySU
 xgzaRuUDYuuFeDmShYt4BQ4n3eprchbdIWH9FlQ6LcH16YHY2jhkCHS8EkdEIfFk/idMVsGaIuw
 OhTptpcKtQ7BUB7DwnZ8OTq3UykDihR1UKba07UMvN3l5JRyO883UWIqauXfGygHnzK0ZBENuFO
 DkEoXCUxw3nxHTNqxHzaRdKWd4xbqcNWWrf/YtQj+A1TP7lia9MoZdQJwqzhmLEUnCClCNEoQTy
 57Aq63B6eJV6wUQ==
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
index 0223f8ec3cfb..1edac9ab1ecc 100644
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
index ebfe846ebde3..e8b713e8ce55 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2488,6 +2488,7 @@ void ktime_get_real_ts64_mg(struct timespec64 *ts)
 	if (atomic64_try_cmpxchg(&mg_floor, &old, mono)) {
 		ts->tv_nsec = 0;
 		timespec64_add_ns(ts, nsecs);
+		timekeeping_inc_mg_floor_swaps();
 	} else {
 		/*
 		 * Another task changed mg_floor since "old" was fetched.
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


