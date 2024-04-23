Return-Path: <linux-fsdevel+bounces-17445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E55228ADB42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 02:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D186284088
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 00:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB47FEACE;
	Tue, 23 Apr 2024 00:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8eBtfq9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDF2802;
	Tue, 23 Apr 2024 00:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713833074; cv=none; b=Y6wU7gq/kO70foz7rBPsG6K/uxsf+EIc9JQEhEaE3JUfLVUPLOOP2O3r0UiNbp9m6R7vCH3WjD6/1n7FNLnyFterO4YMGc+OZR5NEpg1+g0lZRW5wxo4hAQwEhaHThBvunT1IicLo9qQGZ998tACmho6npWLzu8aoYY0sIFmxC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713833074; c=relaxed/simple;
	bh=77v/z4pf5G4vO82BkGrG5tUThBqnCicr34yR2Tw/p3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLXrjSEkP0dCd55ltKIYJORn03ulSomyy8tc8OTwbXMnsYsz52TBl1zpdMkPE6GAY67c4YvNltKOtOHw3qypLT1L4gsmJA2Vtydoza8hdelRAGviKj+EAkwfVNOnuIWVxbMVxns7CXVvkTEetBAS0zz7gl7Y/HQsgqSO5GaS+/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8eBtfq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD782C113CC;
	Tue, 23 Apr 2024 00:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713833073;
	bh=77v/z4pf5G4vO82BkGrG5tUThBqnCicr34yR2Tw/p3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l8eBtfq9mJ37HXPcCtGC6rxe59aLTHv+peCLZVh0sXeHBv2fmxRJWQ8FIPxFarS67
	 RztpnbCUjEZj71WTF82E+mm6epWyqTASnJ7PblEQKbryIHC+k+qPO9E/zI2ZpK6LtA
	 S26Zdd2g6/lnLPyYE5fGo9lx63qT+IjaivOYJdWvJdV1Ms34Fcas9wFpDX3ldAbzAJ
	 6iHqZfZUox3KVGxQ6+qnHtymtLdEAgIaJiAW6xnOwTyDRdU3o6XK9yeW6AA7ZPKYhU
	 godRJb1KGT5oVfYn+AD3gbgyMYm5+f+UYbWGZKhMnUDbc6G8Ddo8jjZIaeReuPaKKV
	 44Gi9j8gKFvOg==
From: SeongJae Park <sj@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	willy@infradead.org,
	jack@suse.cz,
	bfoster@redhat.com,
	tj@kernel.org,
	dsterba@suse.com,
	mjguzik@gmail.com,
	dhowells@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] writeback: support retrieving per group debug writeback stats of bdi
Date: Mon, 22 Apr 2024 17:44:30 -0700
Message-Id: <20240423004430.140320-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240422164808.13627-3-shikemeng@huaweicloud.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Kemeng,

On Tue, 23 Apr 2024 00:48:06 +0800 Kemeng Shi <shikemeng@huaweicloud.com> wrote:

> Add /sys/kernel/debug/bdi/xxx/wb_stats to show per group writeback stats
> of bdi.
> 
> Following domain hierarchy is tested:
>                 global domain (320G)
>                 /                 \
>         cgroup domain1(10G)     cgroup domain2(10G)
>                 |                 |
> bdi            wb1               wb2
> 
> /* per wb writeback info of bdi is collected */
> cat /sys/kernel/debug/bdi/252:16/wb_stats
> WbCgIno:                    1
> WbWriteback:                0 kB
> WbReclaimable:              0 kB
> WbDirtyThresh:              0 kB
> WbDirtied:                  0 kB
> WbWritten:                  0 kB
> WbWriteBandwidth:      102400 kBps
> b_dirty:                    0
> b_io:                       0
> b_more_io:                  0
> b_dirty_time:               0
> state:                      1
> WbCgIno:                 4094
> WbWriteback:            54432 kB
> WbReclaimable:         766080 kB
> WbDirtyThresh:        3094760 kB
> WbDirtied:            1656480 kB
> WbWritten:             837088 kB
> WbWriteBandwidth:      132772 kBps
> b_dirty:                    1
> b_io:                       1
> b_more_io:                  0
> b_dirty_time:               0
> state:                      7
> WbCgIno:                 4135
> WbWriteback:            15232 kB
> WbReclaimable:         786688 kB
> WbDirtyThresh:        2909984 kB
> WbDirtied:            1482656 kB
> WbWritten:             681408 kB
> WbWriteBandwidth:      124848 kBps
> b_dirty:                    0
> b_io:                       1
> b_more_io:                  0
> b_dirty_time:               0
> state:                      7
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  include/linux/writeback.h |  1 +
>  mm/backing-dev.c          | 78 ++++++++++++++++++++++++++++++++++++++-
>  mm/page-writeback.c       | 19 ++++++++++
>  3 files changed, 96 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index 9845cb62e40b..112d806ddbe4 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -355,6 +355,7 @@ int dirtytime_interval_handler(struct ctl_table *table, int write,
>  
>  void global_dirty_limits(unsigned long *pbackground, unsigned long *pdirty);
>  unsigned long wb_calc_thresh(struct bdi_writeback *wb, unsigned long thresh);
> +unsigned long cgwb_calc_thresh(struct bdi_writeback *wb);
>  
>  void wb_update_bandwidth(struct bdi_writeback *wb);
>  
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 089146feb830..6ecd11bdce6e 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -155,19 +155,93 @@ static int bdi_debug_stats_show(struct seq_file *m, void *v)
>  }
>  DEFINE_SHOW_ATTRIBUTE(bdi_debug_stats);
>  
> +static void wb_stats_show(struct seq_file *m, struct bdi_writeback *wb,
> +			  struct wb_stats *stats)
> +{
> +
> +	seq_printf(m,
> +		   "WbCgIno:           %10lu\n"
> +		   "WbWriteback:       %10lu kB\n"
> +		   "WbReclaimable:     %10lu kB\n"
> +		   "WbDirtyThresh:     %10lu kB\n"
> +		   "WbDirtied:         %10lu kB\n"
> +		   "WbWritten:         %10lu kB\n"
> +		   "WbWriteBandwidth:  %10lu kBps\n"
> +		   "b_dirty:           %10lu\n"
> +		   "b_io:              %10lu\n"
> +		   "b_more_io:         %10lu\n"
> +		   "b_dirty_time:      %10lu\n"
> +		   "state:             %10lx\n\n",
> +		   cgroup_ino(wb->memcg_css->cgroup),

I'm getting below kunit build failure from the latest mm-unstable tree, and
'git bisect' points this patch.

    ERROR:root:.../linux/mm/backing-dev.c: In function ‘wb_stats_show’:
    .../linux/mm/backing-dev.c:175:20: error: implicit declaration of function ‘cgroup_ino’; did you mean ‘cgroup_init’? [-Werror=implicit-function-declaration]
      175 |                    cgroup_ino(wb->memcg_css->cgroup),
          |                    ^~~~~~~~~~
          |                    cgroup_init
    .../linux/mm/backing-dev.c:175:33: error: ‘struct bdi_writeback’ has no member named ‘memcg_css’
      175 |                    cgroup_ino(wb->memcg_css->cgroup),
          |                                 ^~

The kunit build config is not having CONFIG_CGROUPS.  I guess we need to check
the case?  I confirmed below dumb change is fixing the issue, but I guess it
could be cleaner.  May I ask your opinion?

--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -160,7 +160,9 @@ static void wb_stats_show(struct seq_file *m, struct bdi_writeback *wb,
 {

        seq_printf(m,
+#ifdef CONFIG_CGROUPS
                   "WbCgIno:           %10lu\n"
+#endif
                   "WbWriteback:       %10lu kB\n"
                   "WbReclaimable:     %10lu kB\n"
                   "WbDirtyThresh:     %10lu kB\n"
@@ -172,7 +174,9 @@ static void wb_stats_show(struct seq_file *m, struct bdi_writeback *wb,
                   "b_more_io:         %10lu\n"
                   "b_dirty_time:      %10lu\n"
                   "state:             %10lx\n\n",
+#ifdef CONFIG_CGROUPS
                   cgroup_ino(wb->memcg_css->cgroup),
+#endif
                   K(stats->nr_writeback),
                   K(stats->nr_reclaimable),
                   K(stats->wb_thresh),


> +		   K(stats->nr_writeback),
> +		   K(stats->nr_reclaimable),
> +		   K(stats->wb_thresh),
> +		   K(stats->nr_dirtied),
> +		   K(stats->nr_written),
> +		   K(wb->avg_write_bandwidth),
> +		   stats->nr_dirty,
> +		   stats->nr_io,
> +		   stats->nr_more_io,
> +		   stats->nr_dirty_time,
> +		   wb->state);
> +}
> +
> +static int cgwb_debug_stats_show(struct seq_file *m, void *v)
> +{
> +	struct backing_dev_info *bdi = m->private;
> +	unsigned long background_thresh;
> +	unsigned long dirty_thresh;
> +	struct bdi_writeback *wb;
> +	struct wb_stats stats;

Kunit build also shows below warning:

    .../linux/mm/backing-dev.c: In function ‘cgwb_debug_stats_show’:
    .../linux/mm/backing-dev.c:195:25: warning: unused variable ‘stats’ [-Wunused-variable]
      195 |         struct wb_stats stats;
          |                         ^~~~~

I guess above line can simply removed?

> +
> +	global_dirty_limits(&background_thresh, &dirty_thresh);
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(wb, &bdi->wb_list, bdi_node) {
> +		struct wb_stats stats = { .dirty_thresh = dirty_thresh };
> +
> +		if (!wb_tryget(wb))
> +			continue;
> +
> +		collect_wb_stats(&stats, wb);
> +
> +		/*
> +		 * Calculate thresh of wb in writeback cgroup which is min of
> +		 * thresh in global domain and thresh in cgroup domain. Drop
> +		 * rcu lock because cgwb_calc_thresh may sleep in
> +		 * cgroup_rstat_flush. We can do so here because we have a ref.
> +		 */
> +		if (mem_cgroup_wb_domain(wb)) {
> +			rcu_read_unlock();
> +			stats.wb_thresh = min(stats.wb_thresh, cgwb_calc_thresh(wb));
> +			rcu_read_lock();
> +		}
> +
> +		wb_stats_show(m, wb, &stats);
> +
> +		wb_put(wb);
> +	}
> +	rcu_read_unlock();
> +
> +	return 0;
> +}


Thanks,
SJ

[...]

