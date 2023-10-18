Return-Path: <linux-fsdevel+bounces-681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 863777CE4D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 19:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA7651C20B2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 17:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904B93FE25;
	Wed, 18 Oct 2023 17:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUqQBlq5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD463FB2F
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 17:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDD8C433C9;
	Wed, 18 Oct 2023 17:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697650896;
	bh=l0xHAIUUN2BOMaLZLaXQNle/CdEVUPvjoRJwRfogB3k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LUqQBlq5SbTTxc8Kx4I5i/jnPXcg/nEx9UsQqT9B+eDje7FSiAkGbhYGwQRlQFBq5
	 qVEbFGoYB6HtCUqP3zUIt+ld6j6Qti0Vb6h7iw3F8f44xPv78xT8mBKrr/YGDlufQ9
	 tndvU4bWohBgShTn/iB4jplkLEklhbyiqF8FTwc8sM4T1UzsplSeCJur567WQZbXkF
	 F3VaIwe+XEc1jHV5/4BFZD6UVt0Ts9otCsK7RVipp0nXKmd8N0NrfkdWxQulPKu5wY
	 MC9cv5D2gqFsKKlnLdO+j02QzxS5+ftCkhlMxWxW+z9Nwcgi51mkMCUSSoD22g8q1W
	 bjWwbHPGI2/yg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 18 Oct 2023 13:41:09 -0400
Subject: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231018-mgtime-v1-2-4a7a97b1f482@kernel.org>
References: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
In-Reply-To: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, John Stultz <jstultz@google.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>, 
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, Hugh Dickins <hughd@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.de>, 
 David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6981; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=l0xHAIUUN2BOMaLZLaXQNle/CdEVUPvjoRJwRfogB3k=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlMBjI+0b0/ffAFY3zqBSBgVUVHdNbNXYnmuLk7
 4JnuUitV2OJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZTAYyAAKCRAADmhBGVaC
 FQx3EACBnusFhJaHiDBDntSYskmOtKC9J0xUZA3qU6cq1/bt0CXSpLwV13odEIY6OqqXNUiFOeg
 zPsedjKHT90OgQ9De85Z2zj3ZP2Ne5Pl1IT58xW7uMWIdkIJpJ0CQAO6Ah2MYsDGPZgWIVN5ehL
 C2FXIHhVCvw0ZpRu96Vcou1wkA+eZuY1ODNnY1Y2It1eKv8HXIeCa6GKqz1YABH/YWpPrF2K4FD
 FHvvrN04Me65L/xgLUZWs/c9IuR+IkZrM3vzaUBRr2X+JYyj0EsyCiXnStSs5vSeDaJXWdceykW
 9td0tzdxB7Q4yGflpOYRwR+awAiWHytZ0pBmzjS/KO33Z8GCtb4Lmt8sIQDddhjn6sPSiO4+CdT
 pNxkoE9t1KfhEo9ekAhh4WmOcx4HoES1scAKLKN9boy8Ycb+5zSVRj7kVyO3htCXW+4wKBWtRCW
 tWuN5BDRlluKCBx+7/SVs7BgZOm2FVaN/8mdYyMr3ysA/3zjaUy3yMdsl0WtJirPH6tiByo5VpS
 9/68nBxm1oKiI1czGW4mWPuYXe1KWsPLLPKl/c60N/UK2KykHaxDCJIyLh6VSthY/pULGM4XwXq
 2JZAYsJOXw/W6f4tmwd1vQ0f2q4ue8FZJV9TLHDbpUUxncalFo2hfgqU5SCX2MttvcncAi33zDG
 rifmicacYuiP+yg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Multigrain timestamps allow VFS to request fine-grained timestamps when
there has been recent interest in the file's attributes. Unfortunately,
the coarse-grained timestamps can lag the fine-grained ones. A file
stamped with a coarse-grained timestamp after one with a fine-grained
one can appear to have been modified in reverse order. This is
problematic for programs like "make" or "rsync" which depend on being
able to compare timestamps between two different inodes.

One way to prevent this is to ensure that when we stamp a file with a
fine-grained timestamp, that we use that value to establish a floor for
any later timestamp update.

Add a new mg_nsec field to the timekeeper structure for tracking the
nsec value of the most recent multigrain timestamp, along with two new
helper functions for fetching coarse and fine grained timestamps. When
getting a fine-grained timestamp update the mg_nsec with the value that
was fetched via timekeeping_get_ns.

When fetching a coarse-grained timestamp, set the mg_nsec to
TK_MG_NSEC_IGNORE. When fetching a coarse-grained time for a multigrain
timestamp, apply the mg_nsec value if it's not set to TK_MG_NSEC_IGNORE.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/timekeeper_internal.h |  2 +
 include/linux/timekeeping.h         |  4 ++
 kernel/time/timekeeping.c           | 80 +++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+)

diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekeeper_internal.h
index 84ff2844df2a..6583b06e7d08 100644
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -55,6 +55,7 @@ struct tk_read_base {
  * @tai_offset:		The current UTC to TAI offset in seconds
  * @clock_was_set_seq:	The sequence number of clock was set events
  * @cs_was_changed_seq:	The sequence number of clocksource change events
+ * @mg_nsec:		Nanosecond delta for multigrain timestamps
  * @next_leap_ktime:	CLOCK_MONOTONIC time value of a pending leap-second
  * @raw_sec:		CLOCK_MONOTONIC_RAW  time in seconds
  * @monotonic_to_boot:	CLOCK_MONOTONIC to CLOCK_BOOTTIME offset
@@ -110,6 +111,7 @@ struct timekeeper {
 	u64			xtime_interval;
 	s64			xtime_remainder;
 	u64			raw_interval;
+	u64			mg_nsec;
 	/* The ntp_tick_length() value currently being used.
 	 * This cached copy ensures we consistently apply the tick
 	 * length for an entire tick, as ntp_tick_length may change
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index fe1e467ba046..5dc0ad619d42 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -44,6 +44,10 @@ extern void ktime_get_real_ts64(struct timespec64 *tv);
 extern void ktime_get_coarse_ts64(struct timespec64 *ts);
 extern void ktime_get_coarse_real_ts64(struct timespec64 *ts);
 
+/* multigrain timestamp support */
+void ktime_get_mg_fine_ts64(struct timespec64 *ts);
+void ktime_get_mg_coarse_ts64(struct timespec64 *ts);
+
 void getboottime64(struct timespec64 *ts);
 
 /*
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 266d02809dbb..7c20c98b1ea8 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -33,6 +33,9 @@
 #define TK_MIRROR		(1 << 1)
 #define TK_CLOCK_WAS_SET	(1 << 2)
 
+/* When mg_nsec is set to this, ignore it */
+#define TK_MG_NSEC_IGNORE	(~(0ULL))
+
 enum timekeeping_adv_mode {
 	/* Update timekeeper when a tick has passed */
 	TK_ADV_TICK,
@@ -139,6 +142,7 @@ static void tk_set_xtime(struct timekeeper *tk, const struct timespec64 *ts)
 {
 	tk->xtime_sec = ts->tv_sec;
 	tk->tkr_mono.xtime_nsec = (u64)ts->tv_nsec << tk->tkr_mono.shift;
+	tk->mg_nsec = TK_MG_NSEC_IGNORE;
 }
 
 static void tk_xtime_add(struct timekeeper *tk, const struct timespec64 *ts)
@@ -146,6 +150,7 @@ static void tk_xtime_add(struct timekeeper *tk, const struct timespec64 *ts)
 	tk->xtime_sec += ts->tv_sec;
 	tk->tkr_mono.xtime_nsec += (u64)ts->tv_nsec << tk->tkr_mono.shift;
 	tk_normalize_xtime(tk);
+	tk->mg_nsec = TK_MG_NSEC_IGNORE;
 }
 
 static void tk_set_wall_to_mono(struct timekeeper *tk, struct timespec64 wtm)
@@ -1664,6 +1669,7 @@ void __init timekeeping_init(void)
 	tk_setup_internals(tk, clock);
 
 	tk_set_xtime(tk, &wall_time);
+	tk->mg_nsec = TK_MG_NSEC_IGNORE;
 	tk->raw_sec = 0;
 
 	tk_set_wall_to_mono(tk, wall_to_mono);
@@ -2283,6 +2289,80 @@ void ktime_get_coarse_ts64(struct timespec64 *ts)
 }
 EXPORT_SYMBOL(ktime_get_coarse_ts64);
 
+/**
+ * ktime_get_mg_fine_ts64 - Returns a fine-grained time of day in a timespec64
+ * @ts: pointer to the timespec64 to be set
+ *
+ * Multigrain filesystems use a scheme where they use coarse-grained
+ * timestamps most of the time, but will use a fine-grained timestamp
+ * if the previous timestamp was queried and the coarse-grained clock
+ * hasn't ticked yet.
+ *
+ * For this case, the caller is requesting a fine-grained timestamp,
+ * so we must update the sliding mg_nsec value before returning it. This
+ * ensures that any coarse-grained timestamp updates that occur after
+ * this won't appear to have occurred before.
+ *
+ * Fills in @ts with the current fine-grained time of day, suitable for
+ * a file timestamp.
+ */
+void ktime_get_mg_fine_ts64(struct timespec64 *ts)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+	unsigned long flags;
+	u32 nsecs;
+
+	WARN_ON(timekeeping_suspended);
+
+	raw_spin_lock_irqsave(&timekeeper_lock, flags);
+	write_seqcount_begin(&tk_core.seq);
+
+	ts->tv_sec = tk->xtime_sec;
+	nsecs = timekeeping_get_ns(&tk->tkr_mono);
+	tk->mg_nsec = nsecs;
+
+	write_seqcount_end(&tk_core.seq);
+	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+
+	ts->tv_nsec = 0;
+	timespec64_add_ns(ts, nsecs);
+}
+
+/**
+ * ktime_get_mg_coarse_ts64 - Returns a coarse-grained time of day in a timespec64
+ * @ts: pointer to the timespec64 to be set
+ *
+ * Multigrain filesystems use a scheme where they use coarse-grained
+ * timestamps most of the time, but will use a fine-grained timestamp
+ * if the previous timestamp was queried and the coarse-grained clock
+ * hasn't ticked yet.
+ *
+ * For this case, the caller is requesting a coarse-grained timestamp,
+ * which will always be equal to or later than the latest fine-grained
+ * timestamp that has been handed out.
+ *
+ * Fills in @ts with the current coarse-grained time of day, suitable
+ * for a file timestamp.
+ */
+void ktime_get_mg_coarse_ts64(struct timespec64 *ts)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+	unsigned int seq;
+	u64 nsec;
+
+	do {
+		seq = read_seqcount_begin(&tk_core.seq);
+
+		*ts = tk_xtime(tk);
+		nsec = tk->mg_nsec;
+	} while (read_seqcount_retry(&tk_core.seq, seq));
+
+	if (nsec != TK_MG_NSEC_IGNORE) {
+		ts->tv_nsec = 0;
+		timespec64_add_ns(ts, nsec);
+	}
+}
+
 /*
  * Must hold jiffies_lock
  */

-- 
2.41.0


