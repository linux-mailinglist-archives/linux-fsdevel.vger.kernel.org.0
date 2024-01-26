Return-Path: <linux-fsdevel+bounces-9118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BA083E4BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 23:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97D81286A96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 22:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EC350A8A;
	Fri, 26 Jan 2024 22:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b6KLBbKr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0398D45974
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 22:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706306828; cv=none; b=Kxc5uf9wid9OxHUUAwP9FznezG+UbVngjuLNeR4Pjowq5Bd/rCmdsIon3Slh1y8iRWodSXmubNjsMH6sYmxC85L8GPZlQnnT1LPOd++OQndpRU5iGlgDkhFNVbJSyHW3IJeZxIkbRle/KZOjiql53ZXcdkU42eTGcMsm/eRSVP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706306828; c=relaxed/simple;
	bh=0OUrbng9hpKSc9SYikihN8HmexwMf0xE3gor+hG7oWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1hKs555KL+ePIf4L/YIHn2xGJkNEoKFqe39967jN0YtVRC0E6xeVYGeBBihszcj+rLxD+3SdS4AYUCrkPYNmpO0EzwrycUoOTciIsEq8fs/mZyqqSfXoMH+RW+wFo/tMHKCRcVjMSo9g69m86Zm+93AdEs7kGil9msjszW9EQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b6KLBbKr; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706306824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M6DdAKjqitnGGFd6TAWjZ/fZCoyj9qP3U91XnThZ1Fw=;
	b=b6KLBbKroxKYRPes2D57pZ0DbDJuzLAIZ39sD0x5r2RN1zV1D2N6BX/SkOpWkcE9grtxba
	wxjLNXCOnF0r3Om5I4Ydfg0OlDMMOCTUtNuG10SmUW3dNh7xdWCfZnWNi6hCXalMsBnzPT
	bDyTLwwg84k1sxnk4yo+D4M3Ww+2FOI=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	linux-bcachefs@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 3/5] bcachefs: bch2_time_stats_to_seq_buf()
Date: Fri, 26 Jan 2024 17:06:53 -0500
Message-ID: <20240126220655.395093-3-kent.overstreet@linux.dev>
In-Reply-To: <20240126220655.395093-1-kent.overstreet@linux.dev>
References: <20240126220655.395093-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/super.c |   2 +
 fs/bcachefs/util.c  | 129 +++++++++++++++++++++++++++++++++++++++-----
 fs/bcachefs/util.h  |   4 ++
 3 files changed, 121 insertions(+), 14 deletions(-)

diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
index da8697c79a97..e74534096cb5 100644
--- a/fs/bcachefs/super.c
+++ b/fs/bcachefs/super.c
@@ -1262,6 +1262,8 @@ static struct bch_dev *__bch2_dev_alloc(struct bch_fs *c,
 
 	bch2_time_stats_init(&ca->io_latency[READ]);
 	bch2_time_stats_init(&ca->io_latency[WRITE]);
+	ca->io_latency[READ].quantiles_enabled = true;
+	ca->io_latency[WRITE].quantiles_enabled = true;
 
 	ca->mi = bch2_mi_to_cpu(member);
 
diff --git a/fs/bcachefs/util.c b/fs/bcachefs/util.c
index c7cf9c6fcf9a..f2c8550c1331 100644
--- a/fs/bcachefs/util.c
+++ b/fs/bcachefs/util.c
@@ -505,10 +505,8 @@ static inline void pr_name_and_units(struct printbuf *out, const char *name, u64
 
 void bch2_time_stats_to_text(struct printbuf *out, struct bch2_time_stats *stats)
 {
-	const struct time_unit *u;
 	s64 f_mean = 0, d_mean = 0;
-	u64 q, last_q = 0, f_stddev = 0, d_stddev = 0;
-	int i;
+	u64 f_stddev = 0, d_stddev = 0;
 
 	if (stats->buffer) {
 		int cpu;
@@ -607,19 +605,122 @@ void bch2_time_stats_to_text(struct printbuf *out, struct bch2_time_stats *stats
 
 	printbuf_tabstops_reset(out);
 
-	i = eytzinger0_first(NR_QUANTILES);
-	u = pick_time_units(stats->quantiles.entries[i].m);
+	if (stats->quantiles_enabled) {
+		int i = eytzinger0_first(NR_QUANTILES);
+		const struct time_unit *u =
+			pick_time_units(stats->quantiles.entries[i].m);
+		u64 last_q = 0;
+
+		prt_printf(out, "quantiles (%s):\t", u->name);
+		eytzinger0_for_each(i, NR_QUANTILES) {
+			bool is_last = eytzinger0_next(i, NR_QUANTILES) == -1;
+
+			u64 q = max(stats->quantiles.entries[i].m, last_q);
+			prt_printf(out, "%llu ", div_u64(q, u->nsecs));
+			if (is_last)
+				prt_newline(out);
+			last_q = q;
+		}
+	}
+}
+
+#include <linux/seq_buf.h>
+
+static void seq_buf_time_units_aligned(struct seq_buf *out, u64 ns)
+{
+	const struct time_unit *u = pick_time_units(ns);
+
+	seq_buf_printf(out, "%8llu %s", div64_u64(ns, u->nsecs), u->name);
+}
+
+void bch2_time_stats_to_seq_buf(struct seq_buf *out, struct bch2_time_stats *stats)
+{
+	s64 f_mean = 0, d_mean = 0;
+	u64 f_stddev = 0, d_stddev = 0;
+
+	if (stats->buffer) {
+		int cpu;
 
-	prt_printf(out, "quantiles (%s):\t", u->name);
-	eytzinger0_for_each(i, NR_QUANTILES) {
-		bool is_last = eytzinger0_next(i, NR_QUANTILES) == -1;
+		spin_lock_irq(&stats->lock);
+		for_each_possible_cpu(cpu)
+			__bch2_time_stats_clear_buffer(stats, per_cpu_ptr(stats->buffer, cpu));
+		spin_unlock_irq(&stats->lock);
+	}
 
-		q = max(stats->quantiles.entries[i].m, last_q);
-		prt_printf(out, "%llu ",
-		       div_u64(q, u->nsecs));
-		if (is_last)
-			prt_newline(out);
-		last_q = q;
+	/*
+	 * avoid divide by zero
+	 */
+	if (stats->freq_stats.n) {
+		f_mean = mean_and_variance_get_mean(stats->freq_stats);
+		f_stddev = mean_and_variance_get_stddev(stats->freq_stats);
+		d_mean = mean_and_variance_get_mean(stats->duration_stats);
+		d_stddev = mean_and_variance_get_stddev(stats->duration_stats);
+	}
+
+	seq_buf_printf(out, "count: %llu\n", stats->duration_stats.n);
+
+	seq_buf_printf(out, "                       since mount        recent\n");
+
+	seq_buf_printf(out, "duration of events\n");
+
+	seq_buf_printf(out, "  min:                     ");
+	seq_buf_time_units_aligned(out, stats->min_duration);
+	seq_buf_printf(out, "\n");
+
+	seq_buf_printf(out, "  max:                     ");
+	seq_buf_time_units_aligned(out, stats->max_duration);
+	seq_buf_printf(out, "\n");
+
+	seq_buf_printf(out, "  total:                   ");
+	seq_buf_time_units_aligned(out, stats->total_duration);
+	seq_buf_printf(out, "\n");
+
+	seq_buf_printf(out, "  mean:                    ");
+	seq_buf_time_units_aligned(out, d_mean);
+	seq_buf_time_units_aligned(out, mean_and_variance_weighted_get_mean(stats->duration_stats_weighted));
+	seq_buf_printf(out, "\n");
+
+	seq_buf_printf(out, "  stddev:                  ");
+	seq_buf_time_units_aligned(out, d_stddev);
+	seq_buf_time_units_aligned(out, mean_and_variance_weighted_get_stddev(stats->duration_stats_weighted));
+	seq_buf_printf(out, "\n");
+
+	seq_buf_printf(out, "time between events\n");
+
+	seq_buf_printf(out, "  min:                     ");
+	seq_buf_time_units_aligned(out, stats->min_freq);
+	seq_buf_printf(out, "\n");
+
+	seq_buf_printf(out, "  max:                     ");
+	seq_buf_time_units_aligned(out, stats->max_freq);
+	seq_buf_printf(out, "\n");
+
+	seq_buf_printf(out, "  mean:                    ");
+	seq_buf_time_units_aligned(out, f_mean);
+	seq_buf_time_units_aligned(out, mean_and_variance_weighted_get_mean(stats->freq_stats_weighted));
+	seq_buf_printf(out, "\n");
+
+	seq_buf_printf(out, "  stddev:                  ");
+	seq_buf_time_units_aligned(out, f_stddev);
+	seq_buf_time_units_aligned(out, mean_and_variance_weighted_get_stddev(stats->freq_stats_weighted));
+	seq_buf_printf(out, "\n");
+
+	if (stats->quantiles_enabled) {
+		int i = eytzinger0_first(NR_QUANTILES);
+		const struct time_unit *u =
+			pick_time_units(stats->quantiles.entries[i].m);
+		u64 last_q = 0;
+
+		prt_printf(out, "quantiles (%s):\t", u->name);
+		eytzinger0_for_each(i, NR_QUANTILES) {
+			bool is_last = eytzinger0_next(i, NR_QUANTILES) == -1;
+
+			u64 q = max(stats->quantiles.entries[i].m, last_q);
+			seq_buf_printf(out, "%llu ", div_u64(q, u->nsecs));
+			if (is_last)
+				seq_buf_printf(out, "\n");
+			last_q = q;
+		}
 	}
 }
 #else
diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
index c3b11c3d24ea..7ff2d4fe26f6 100644
--- a/fs/bcachefs/util.h
+++ b/fs/bcachefs/util.h
@@ -382,6 +382,7 @@ struct bch2_time_stat_buffer {
 
 struct bch2_time_stats {
 	spinlock_t	lock;
+	bool		quantiles_enabled;
 	/* all fields are in nanoseconds */
 	u64             min_duration;
 	u64		max_duration;
@@ -435,6 +436,9 @@ static inline bool track_event_change(struct bch2_time_stats *stats,
 
 void bch2_time_stats_to_text(struct printbuf *, struct bch2_time_stats *);
 
+struct seq_buf;
+void bch2_time_stats_to_seq_buf(struct seq_buf *, struct bch2_time_stats *);
+
 void bch2_time_stats_exit(struct bch2_time_stats *);
 void bch2_time_stats_init(struct bch2_time_stats *);
 
-- 
2.43.0


