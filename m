Return-Path: <linux-fsdevel+bounces-9216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 789E083EF24
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 18:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E764B1F2383B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 17:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4BC2D057;
	Sat, 27 Jan 2024 17:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBmN5a1F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B121E860;
	Sat, 27 Jan 2024 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706377545; cv=none; b=OLmFDTr/SrIVto8LMpuR7OgJwuwB1DSOvY4Oia3ueUVKxJIKGdMC71uiUAfD5x8OkeFE6WjZq0YqxgP9hkxkZyoCpE8nxeZX3bK8kkKmuiqTYNbmbQdySvZpsdr9glYaVWRd/qPU8f8hWnIsr5Ec0kDq9bM+OwlRRnznpsOhgng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706377545; c=relaxed/simple;
	bh=CfTEgkFRXJec6DJgIyvZR86BWX77LAPIfK7gZooiXvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fh0RwdHnNxa3yCTenyMEj1FkRxSc+yIRCx8hrvMRCJ8rZV6CfmtKginR+r8ecjl0HGl+KaT+16Kmk20yed+BdGt7nMbShG00wAwcnurJezpLZUKooY3fQvxwGmlsFtW/b0h0eKikWrUBVvOn2rJnpL13/cE1tWM2LkcP56V8wrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBmN5a1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABBEC433F1;
	Sat, 27 Jan 2024 17:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706377544;
	bh=CfTEgkFRXJec6DJgIyvZR86BWX77LAPIfK7gZooiXvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nBmN5a1FhlhfVRsvU8rMlhDFPilBUXvOzN2+vn+jweNZ+pRAEzDtfWxISvdD6+VWB
	 0a8zduKgnsHf6/7sXlskSoRSV/AiLI8s4Ku3vEXvYfYwiRn3d2bg3JMcYMB5i8++Zz
	 kQSi50H62V/UDN4kJZSG+KJhnkPan1a6JnChMojeROF5+hPVFGDyV+wise3nEM6/BR
	 dErjpmyCABm8O3qZAK8Gr56ASjN0pdreOanNWF1hlfPp76Iq1JhDtQkPwdI4vq5+cp
	 59xm3S1IdOFEztSQC6VkOrfQNHZVmgpi4mj8ZKX/3Q5lM/in56fPmmy7EdYzIVCHAV
	 uPCoetNJqhDfw==
Date: Sat, 27 Jan 2024 09:45:43 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Joshua Ashton <joshua@froggi.es>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-bcache@vger.kernel.org,
	linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH 3/5] bcachefs: bch2_time_stats_to_seq_buf()
Message-ID: <20240127174543.GD6184@frogsfrogsfrogs>
References: <20240126220655.395093-1-kent.overstreet@linux.dev>
 <20240126220655.395093-3-kent.overstreet@linux.dev>
 <DA69BC9C-D7FF-48F7-9F6D-EF96DC4C5C7B@froggi.es>
 <5efhxgruvtlrjiqe52kgmnduguw3tmg2jjugfzi7dhbywljrwi@zu2ndkvzunzs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5efhxgruvtlrjiqe52kgmnduguw3tmg2jjugfzi7dhbywljrwi@zu2ndkvzunzs>

On Sat, Jan 27, 2024 at 10:20:48AM -0500, Kent Overstreet wrote:
> On Sat, Jan 27, 2024 at 03:49:29AM +0000, Joshua Ashton wrote:
> > Kernel patches need descriptions.
> 
> I think this one was pretty clear from the name and type signature :)

I was mildly confused by this patch until I read the /next/ patch and
realized "Oh, patch 3 ports the timestats rendering code to seq_buf so
that patch 4 can lift it to lib/."

But I also thought the purpose of all this was kinda obvious from the
cover letter, which was why I didn't say anything yesterday afternoon.

I really don't care about these sorts of things.  IMO the obviously
interesting meat of the patchset is the patch that hoisted this to lib/
and the critical review is brainstorming how I'd use this new piece of
functionality, deciding if the api was ergonomic enough to start
prototyping upon, and sending a conditional RVB if I demonstrated enough
understanding of the problem being solved.

As for rearranging deck chairs inside fs/bcachefs, that's Kent's thing.

--D

> > 
> > On January 26, 2024 10:06:53 PM GMT, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > >Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > >---
> > > fs/bcachefs/super.c |   2 +
> > > fs/bcachefs/util.c  | 129 +++++++++++++++++++++++++++++++++++++++-----
> > > fs/bcachefs/util.h  |   4 ++
> > > 3 files changed, 121 insertions(+), 14 deletions(-)
> > >
> > >diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
> > >index da8697c79a97..e74534096cb5 100644
> > >--- a/fs/bcachefs/super.c
> > >+++ b/fs/bcachefs/super.c
> > >@@ -1262,6 +1262,8 @@ static struct bch_dev *__bch2_dev_alloc(struct bch_fs *c,
> > > 
> > > 	bch2_time_stats_init(&ca->io_latency[READ]);
> > > 	bch2_time_stats_init(&ca->io_latency[WRITE]);
> > >+	ca->io_latency[READ].quantiles_enabled = true;
> > >+	ca->io_latency[WRITE].quantiles_enabled = true;
> > > 
> > > 	ca->mi = bch2_mi_to_cpu(member);
> > > 
> > >diff --git a/fs/bcachefs/util.c b/fs/bcachefs/util.c
> > >index c7cf9c6fcf9a..f2c8550c1331 100644
> > >--- a/fs/bcachefs/util.c
> > >+++ b/fs/bcachefs/util.c
> > >@@ -505,10 +505,8 @@ static inline void pr_name_and_units(struct printbuf *out, const char *name, u64
> > > 
> > > void bch2_time_stats_to_text(struct printbuf *out, struct bch2_time_stats *stats)
> > > {
> > >-	const struct time_unit *u;
> > > 	s64 f_mean = 0, d_mean = 0;
> > >-	u64 q, last_q = 0, f_stddev = 0, d_stddev = 0;
> > >-	int i;
> > >+	u64 f_stddev = 0, d_stddev = 0;
> > > 
> > > 	if (stats->buffer) {
> > > 		int cpu;
> > >@@ -607,19 +605,122 @@ void bch2_time_stats_to_text(struct printbuf *out, struct bch2_time_stats *stats
> > > 
> > > 	printbuf_tabstops_reset(out);
> > > 
> > >-	i = eytzinger0_first(NR_QUANTILES);
> > >-	u = pick_time_units(stats->quantiles.entries[i].m);
> > >+	if (stats->quantiles_enabled) {
> > >+		int i = eytzinger0_first(NR_QUANTILES);
> > >+		const struct time_unit *u =
> > >+			pick_time_units(stats->quantiles.entries[i].m);
> > >+		u64 last_q = 0;
> > >+
> > >+		prt_printf(out, "quantiles (%s):\t", u->name);
> > >+		eytzinger0_for_each(i, NR_QUANTILES) {
> > >+			bool is_last = eytzinger0_next(i, NR_QUANTILES) == -1;
> > >+
> > >+			u64 q = max(stats->quantiles.entries[i].m, last_q);
> > >+			prt_printf(out, "%llu ", div_u64(q, u->nsecs));
> > >+			if (is_last)
> > >+				prt_newline(out);
> > >+			last_q = q;
> > >+		}
> > >+	}
> > >+}
> > >+
> > >+#include <linux/seq_buf.h>
> > >+
> > >+static void seq_buf_time_units_aligned(struct seq_buf *out, u64 ns)
> > >+{
> > >+	const struct time_unit *u = pick_time_units(ns);
> > >+
> > >+	seq_buf_printf(out, "%8llu %s", div64_u64(ns, u->nsecs), u->name);
> > >+}
> > >+
> > >+void bch2_time_stats_to_seq_buf(struct seq_buf *out, struct bch2_time_stats *stats)
> > >+{
> > >+	s64 f_mean = 0, d_mean = 0;
> > >+	u64 f_stddev = 0, d_stddev = 0;
> > >+
> > >+	if (stats->buffer) {
> > >+		int cpu;
> > > 
> > >-	prt_printf(out, "quantiles (%s):\t", u->name);
> > >-	eytzinger0_for_each(i, NR_QUANTILES) {
> > >-		bool is_last = eytzinger0_next(i, NR_QUANTILES) == -1;
> > >+		spin_lock_irq(&stats->lock);
> > >+		for_each_possible_cpu(cpu)
> > >+			__bch2_time_stats_clear_buffer(stats, per_cpu_ptr(stats->buffer, cpu));
> > >+		spin_unlock_irq(&stats->lock);
> > >+	}
> > > 
> > >-		q = max(stats->quantiles.entries[i].m, last_q);
> > >-		prt_printf(out, "%llu ",
> > >-		       div_u64(q, u->nsecs));
> > >-		if (is_last)
> > >-			prt_newline(out);
> > >-		last_q = q;
> > >+	/*
> > >+	 * avoid divide by zero
> > >+	 */
> > >+	if (stats->freq_stats.n) {
> > >+		f_mean = mean_and_variance_get_mean(stats->freq_stats);
> > >+		f_stddev = mean_and_variance_get_stddev(stats->freq_stats);
> > >+		d_mean = mean_and_variance_get_mean(stats->duration_stats);
> > >+		d_stddev = mean_and_variance_get_stddev(stats->duration_stats);
> > >+	}
> > >+
> > >+	seq_buf_printf(out, "count: %llu\n", stats->duration_stats.n);
> > >+
> > >+	seq_buf_printf(out, "                       since mount        recent\n");
> > >+
> > >+	seq_buf_printf(out, "duration of events\n");
> > >+
> > >+	seq_buf_printf(out, "  min:                     ");
> > >+	seq_buf_time_units_aligned(out, stats->min_duration);
> > >+	seq_buf_printf(out, "\n");
> > >+
> > >+	seq_buf_printf(out, "  max:                     ");
> > >+	seq_buf_time_units_aligned(out, stats->max_duration);
> > >+	seq_buf_printf(out, "\n");
> > >+
> > >+	seq_buf_printf(out, "  total:                   ");
> > >+	seq_buf_time_units_aligned(out, stats->total_duration);
> > >+	seq_buf_printf(out, "\n");
> > >+
> > >+	seq_buf_printf(out, "  mean:                    ");
> > >+	seq_buf_time_units_aligned(out, d_mean);
> > >+	seq_buf_time_units_aligned(out, mean_and_variance_weighted_get_mean(stats->duration_stats_weighted));
> > >+	seq_buf_printf(out, "\n");
> > >+
> > >+	seq_buf_printf(out, "  stddev:                  ");
> > >+	seq_buf_time_units_aligned(out, d_stddev);
> > >+	seq_buf_time_units_aligned(out, mean_and_variance_weighted_get_stddev(stats->duration_stats_weighted));
> > >+	seq_buf_printf(out, "\n");
> > >+
> > >+	seq_buf_printf(out, "time between events\n");
> > >+
> > >+	seq_buf_printf(out, "  min:                     ");
> > >+	seq_buf_time_units_aligned(out, stats->min_freq);
> > >+	seq_buf_printf(out, "\n");
> > >+
> > >+	seq_buf_printf(out, "  max:                     ");
> > >+	seq_buf_time_units_aligned(out, stats->max_freq);
> > >+	seq_buf_printf(out, "\n");
> > >+
> > >+	seq_buf_printf(out, "  mean:                    ");
> > >+	seq_buf_time_units_aligned(out, f_mean);
> > >+	seq_buf_time_units_aligned(out, mean_and_variance_weighted_get_mean(stats->freq_stats_weighted));
> > >+	seq_buf_printf(out, "\n");
> > >+
> > >+	seq_buf_printf(out, "  stddev:                  ");
> > >+	seq_buf_time_units_aligned(out, f_stddev);
> > >+	seq_buf_time_units_aligned(out, mean_and_variance_weighted_get_stddev(stats->freq_stats_weighted));
> > >+	seq_buf_printf(out, "\n");
> > >+
> > >+	if (stats->quantiles_enabled) {
> > >+		int i = eytzinger0_first(NR_QUANTILES);
> > >+		const struct time_unit *u =
> > >+			pick_time_units(stats->quantiles.entries[i].m);
> > >+		u64 last_q = 0;
> > >+
> > >+		prt_printf(out, "quantiles (%s):\t", u->name);
> > >+		eytzinger0_for_each(i, NR_QUANTILES) {
> > >+			bool is_last = eytzinger0_next(i, NR_QUANTILES) == -1;
> > >+
> > >+			u64 q = max(stats->quantiles.entries[i].m, last_q);
> > >+			seq_buf_printf(out, "%llu ", div_u64(q, u->nsecs));
> > >+			if (is_last)
> > >+				seq_buf_printf(out, "\n");
> > >+			last_q = q;
> > >+		}
> > > 	}
> > > }
> > > #else
> > >diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
> > >index c3b11c3d24ea..7ff2d4fe26f6 100644
> > >--- a/fs/bcachefs/util.h
> > >+++ b/fs/bcachefs/util.h
> > >@@ -382,6 +382,7 @@ struct bch2_time_stat_buffer {
> > > 
> > > struct bch2_time_stats {
> > > 	spinlock_t	lock;
> > >+	bool		quantiles_enabled;
> > > 	/* all fields are in nanoseconds */
> > > 	u64             min_duration;
> > > 	u64		max_duration;
> > >@@ -435,6 +436,9 @@ static inline bool track_event_change(struct bch2_time_stats *stats,
> > > 
> > > void bch2_time_stats_to_text(struct printbuf *, struct bch2_time_stats *);
> > > 
> > >+struct seq_buf;
> > >+void bch2_time_stats_to_seq_buf(struct seq_buf *, struct bch2_time_stats *);
> > >+
> > > void bch2_time_stats_exit(struct bch2_time_stats *);
> > > void bch2_time_stats_init(struct bch2_time_stats *);
> > > 
> > >-- 
> > >2.43.0
> > >
> > >
> > 
> > - Joshie 🐸✨
> 

