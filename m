Return-Path: <linux-fsdevel+bounces-30788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A49AD98E4F8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 23:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D44F281B0D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 21:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C26621B429;
	Wed,  2 Oct 2024 21:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3mMkbdg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455A621949F;
	Wed,  2 Oct 2024 21:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727904457; cv=none; b=gp79FopKyihvvWMGDgBzSsB3sxzCnHG5ffkLCcRq6SyldOjyNBdEt1x+QGdh6WruWGnF6zytcLTDVgxZO+XfOhKZ7zw1aximmKLpU0PGkLsnQr7OxeIj5lZcsqGp/MczEJLl5qVEPjiMYAcSIkLq0gKmRuXUYROZTKnArzEltoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727904457; c=relaxed/simple;
	bh=b4XkKth37w2ravUWOahimfnL3UOfVbEBD3lD+3rp+1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sM8cNeimZ6CgS18RXKmY6Jy0PbJpKTF+bO/Psl05blLIX2xH5oCAW0jqHxoTXMN909tmpguKX/aVIM01nrYFjntoRYPr56sJRQUeLUOYjHBJfYdVmG7kra7jj2dwBlJizsFff6d7pIo8h5N31zyMtHLK1pz+vwWtSNrrBZW42js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3mMkbdg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55601C4CED1;
	Wed,  2 Oct 2024 21:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727904456;
	bh=b4XkKth37w2ravUWOahimfnL3UOfVbEBD3lD+3rp+1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G3mMkbdg0nkDEyn6L/6plWzGy8rzM311X3HHbMz6R3Ai1VYHlupggE7MRYdxecBcW
	 Xvk6ll6KZR/g9zl7uCaka+nNH7x9Tm/RIkT5vO6uSHNqrUjFrtM95g8heH5M+lCE55
	 F8sgy2iJ9fYi2MZGAAxh7tC2DGiC+V5GkjwU7zP25bmpQ/aYrgzhRDQUPnIsshqeKy
	 O7Jkn3FCOz/3z+OTJtQd0O6UxWljUiDGrmddv3D/etWQiDuDYhcmmN0fD6Ll8pFgyi
	 DBGz2Fo7ZjiuVE0X7WaIHym/aM5Pjo+l4xsKTeBPi+9qboJDAz98MsoDdHe55s5REo
	 dVuTX5zzfKQ1A==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 02 Oct 2024 17:27:17 -0400
Subject: [PATCH v10 02/12] timekeeping: add percpu counter for tracking
 floor swap events
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-mgtime-v10-2-d1c4717f5284@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3634; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=b4XkKth37w2ravUWOahimfnL3UOfVbEBD3lD+3rp+1s=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm/bq/KG7g3gRmiuGWZ6tpbobqHKVwsPLvCl1+2
 PakkzoH/7uJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZv26vwAKCRAADmhBGVaC
 FZRZD/4yysdw6oqodqdrDqoDwQHs/Q4CF/xQT2tRHqA4QItHNsZTxwidAffBRsnGrGPeTIgeMCM
 eYGyGB9p4u3XxLEb8dhRFOW1RBgcQ/Cjr8cpZH6SZLYpRAk6GIcclb7JSx0Z+ZsLsb3raxWip/q
 aQkME57KDFHa5SU4k6wWAI43OaKhloW9psmHOc+VuX08saDovMS29GzzdVVAjB04fD6FVnJ0bOw
 LhNaYNNOKXmuoYPbwXaeS79CaJBEsoC4hSLmofWpFHtXZSM0eMXenbt01hkg0YPIERLodPld9rp
 iR7KGQ74j0CMmpjZaG/iu8mh33FVzNhkaSdq0w4OuN8UNcCDibrHS5/mOt4wdm3uhMR74E6vON+
 0hkVua/1WjZWCbWA9MiE7S8g3sORCoVEP2BIlNBS3fMnIDVCW9YjyntS4bsTRJnYK5cVmuROgko
 7sLr656frMTXl0fy01yglfhU+MXQcqqrmxOiXyRELla8YEX+AKon8oWhvegEV/KJV2LWq3sc2PJ
 TaaxJQMW9FMLYqn5/ddC7uMEmiMU4fHMlL7JHWzMIzBCVTUE4F3nzpMWHemwN+a44HbOhkzhyQc
 0gsIzOEweoF4Kk/yBwXoIpBJneQyP9cglaRlMWlyaD4SLndBdD4EgyTrBtFMAYZncjdhhZwr8Uz
 ptEgKiXkkzgo4IQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The mgtime_floor value is a global variable for tracking the latest
fine-grained timestamp handed out. Because it's a global, track the
number of times that a new floor value is assigned.

Add a new percpu counter to the timekeeping code to track the number of
floor swap events that have occurred. A later patch will add a debugfs
file to display this counter alongside other stats involving multigrain
timestamps.

Tested-by: Randy Dunlap <rdunlap@infradead.org> # documentation bits
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/timekeeping.h        |  1 +
 kernel/time/timekeeping.c          |  1 +
 kernel/time/timekeeping_debug.c    | 14 ++++++++++++++
 kernel/time/timekeeping_internal.h | 15 +++++++++++++++
 4 files changed, 31 insertions(+)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 7aa85246c183576b039c02af4abba02b4a09ef9d..84a035e86ac811f9e7b1649246b71c9296519149 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -48,6 +48,7 @@ extern void ktime_get_coarse_real_ts64(struct timespec64 *ts);
 /* Multigrain timestamp interfaces */
 extern void ktime_get_coarse_real_ts64_mg(struct timespec64 *ts);
 extern void ktime_get_real_ts64_mg(struct timespec64 *ts);
+extern unsigned long timekeeping_get_mg_floor_swaps(void);
 
 void getboottime64(struct timespec64 *ts);
 
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index ebfe846ebde35850c3e4d9c2cc45642c983d137f..e8b713e8ce5553f9e7de96c8e7c089714e0aa7a4 100644
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
index b73e8850e58d9c5b291559f475e67c7ed47c2db3..36d359cad7ca1d821bf42f59b3e50f89b14afd40 100644
--- a/kernel/time/timekeeping_debug.c
+++ b/kernel/time/timekeeping_debug.c
@@ -17,6 +17,9 @@
 
 #define NUM_BINS 32
 
+/* incremented every time mg_floor is updated */
+DEFINE_PER_CPU(unsigned long, timekeeping_mg_floor_swaps);
+
 static unsigned int sleep_time_bin[NUM_BINS] = {0};
 
 static int tk_debug_sleep_time_show(struct seq_file *s, void *data)
@@ -53,3 +56,14 @@ void tk_debug_account_sleep_time(const struct timespec64 *t)
 			   (s64)t->tv_sec, t->tv_nsec / NSEC_PER_MSEC);
 }
 
+unsigned long timekeeping_get_mg_floor_swaps(void)
+{
+	unsigned long sum = 0;
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		sum += data_race(per_cpu(timekeeping_mg_floor_swaps, cpu));
+
+	return sum;
+}
+
diff --git a/kernel/time/timekeeping_internal.h b/kernel/time/timekeeping_internal.h
index 4ca2787d1642e2f52bf985607ca3b03785cf9a50..0bbae825bc0226e4eed64e73fe3b454986c7573f 100644
--- a/kernel/time/timekeeping_internal.h
+++ b/kernel/time/timekeeping_internal.h
@@ -10,9 +10,24 @@
  * timekeeping debug functions
  */
 #ifdef CONFIG_DEBUG_FS
+
+DECLARE_PER_CPU(unsigned long, timekeeping_mg_floor_swaps);
+
+static inline void timekeeping_inc_mg_floor_swaps(void)
+{
+	this_cpu_inc(timekeeping_mg_floor_swaps);
+}
+
 extern void tk_debug_account_sleep_time(const struct timespec64 *t);
+
 #else
+
 #define tk_debug_account_sleep_time(x)
+
+static inline void timekeeping_inc_mg_floor_swaps(void)
+{
+}
+
 #endif
 
 #ifdef CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE

-- 
2.46.2


