Return-Path: <linux-fsdevel+bounces-17447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 931388ADB85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 03:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 474BE285126
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 01:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C319A12B95;
	Tue, 23 Apr 2024 01:29:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CB0107A9;
	Tue, 23 Apr 2024 01:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713835753; cv=none; b=V1GJ3HF3UE/y8pkeQVGvhWgI46dRF5Bq/tvo3hDISWu62QF5cffRdsFBa310VhdUtrxSfzLJ43iNrCHNHUtxmsvGgOAtV++kGnwid/Bvc3OmkMNy9gt8dgBlazVugssml2oHkjSgNVU9UfQV/BGj6+PyrGD9yORWBkFeiMgOyKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713835753; c=relaxed/simple;
	bh=X0YSToBjKLteWE9hLW/8J0kJTyMtIdwx2GcDwcLeWKM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LiX/XbJydPqS+a+RCdZhv/UJcQVrzFS5TKJOkcbcHHbUgeY06XkUg1q/RvN6bcJ19SQ0FSenWh+A2mAz72DVqLBtPwOMh5B8aZu2blblBoTGLIm+jSBNsC7S/51MAnAaVkzyFOYXoSX2L/4CgTtx8v+I00+t9OP2JrQfgrVFPgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VNkzX6q27z4f3m6w;
	Tue, 23 Apr 2024 09:28:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1A70B1A016E;
	Tue, 23 Apr 2024 09:29:06 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgDn_AXgDidm4QTWKg--.37601S2;
	Tue, 23 Apr 2024 09:29:05 +0800 (CST)
Subject: Re: [PATCH v4 2/4] writeback: support retrieving per group debug
 writeback stats of bdi
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, willy@infradead.org, jack@suse.cz,
 bfoster@redhat.com, tj@kernel.org, dsterba@suse.com, mjguzik@gmail.com,
 dhowells@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
References: <20240423004430.140320-1-sj@kernel.org>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <a230bbd8-da84-b213-8f63-da619098e83d@huaweicloud.com>
Date: Tue, 23 Apr 2024 09:29:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240423004430.140320-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDn_AXgDidm4QTWKg--.37601S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GF15CFW3XFWUGrWUGr4kZwb_yoWxWF1fpF
	Z8J3W5Kr4UXryxG3ZI9a9Fgry5tw40qry7XF97Aay8tr1vvr93WFyfurWFyryUAFZ3AFW3
	Aa1YvF97G3yqy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUOyCJDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/


Hello
on 4/23/2024 8:44 AM, SeongJae Park wrote:
> Hi Kemeng,
> 
> On Tue, 23 Apr 2024 00:48:06 +0800 Kemeng Shi <shikemeng@huaweicloud.com> wrote:
> 
>> Add /sys/kernel/debug/bdi/xxx/wb_stats to show per group writeback stats
>> of bdi.
>>
>> Following domain hierarchy is tested:
>>                 global domain (320G)
>>                 /                 \
>>         cgroup domain1(10G)     cgroup domain2(10G)
>>                 |                 |
>> bdi            wb1               wb2
>>
>> /* per wb writeback info of bdi is collected */
>> cat /sys/kernel/debug/bdi/252:16/wb_stats
>> WbCgIno:                    1
>> WbWriteback:                0 kB
>> WbReclaimable:              0 kB
>> WbDirtyThresh:              0 kB
>> WbDirtied:                  0 kB
>> WbWritten:                  0 kB
>> WbWriteBandwidth:      102400 kBps
>> b_dirty:                    0
>> b_io:                       0
>> b_more_io:                  0
>> b_dirty_time:               0
>> state:                      1
>> WbCgIno:                 4094
>> WbWriteback:            54432 kB
>> WbReclaimable:         766080 kB
>> WbDirtyThresh:        3094760 kB
>> WbDirtied:            1656480 kB
>> WbWritten:             837088 kB
>> WbWriteBandwidth:      132772 kBps
>> b_dirty:                    1
>> b_io:                       1
>> b_more_io:                  0
>> b_dirty_time:               0
>> state:                      7
>> WbCgIno:                 4135
>> WbWriteback:            15232 kB
>> WbReclaimable:         786688 kB
>> WbDirtyThresh:        2909984 kB
>> WbDirtied:            1482656 kB
>> WbWritten:             681408 kB
>> WbWriteBandwidth:      124848 kBps
>> b_dirty:                    0
>> b_io:                       1
>> b_more_io:                  0
>> b_dirty_time:               0
>> state:                      7
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>  include/linux/writeback.h |  1 +
>>  mm/backing-dev.c          | 78 ++++++++++++++++++++++++++++++++++++++-
>>  mm/page-writeback.c       | 19 ++++++++++
>>  3 files changed, 96 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
>> index 9845cb62e40b..112d806ddbe4 100644
>> --- a/include/linux/writeback.h
>> +++ b/include/linux/writeback.h
>> @@ -355,6 +355,7 @@ int dirtytime_interval_handler(struct ctl_table *table, int write,
>>  
>>  void global_dirty_limits(unsigned long *pbackground, unsigned long *pdirty);
>>  unsigned long wb_calc_thresh(struct bdi_writeback *wb, unsigned long thresh);
>> +unsigned long cgwb_calc_thresh(struct bdi_writeback *wb);
>>  
>>  void wb_update_bandwidth(struct bdi_writeback *wb);
>>  
>> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
>> index 089146feb830..6ecd11bdce6e 100644
>> --- a/mm/backing-dev.c
>> +++ b/mm/backing-dev.c
>> @@ -155,19 +155,93 @@ static int bdi_debug_stats_show(struct seq_file *m, void *v)
>>  }
>>  DEFINE_SHOW_ATTRIBUTE(bdi_debug_stats);
>>  
>> +static void wb_stats_show(struct seq_file *m, struct bdi_writeback *wb,
>> +			  struct wb_stats *stats)
>> +{
>> +
>> +	seq_printf(m,
>> +		   "WbCgIno:           %10lu\n"
>> +		   "WbWriteback:       %10lu kB\n"
>> +		   "WbReclaimable:     %10lu kB\n"
>> +		   "WbDirtyThresh:     %10lu kB\n"
>> +		   "WbDirtied:         %10lu kB\n"
>> +		   "WbWritten:         %10lu kB\n"
>> +		   "WbWriteBandwidth:  %10lu kBps\n"
>> +		   "b_dirty:           %10lu\n"
>> +		   "b_io:              %10lu\n"
>> +		   "b_more_io:         %10lu\n"
>> +		   "b_dirty_time:      %10lu\n"
>> +		   "state:             %10lx\n\n",
>> +		   cgroup_ino(wb->memcg_css->cgroup),
> 
> I'm getting below kunit build failure from the latest mm-unstable tree, and
> 'git bisect' points this patch.
> 
>     ERROR:root:.../linux/mm/backing-dev.c: In function ‘wb_stats_show’:
>     .../linux/mm/backing-dev.c:175:20: error: implicit declaration of function ‘cgroup_ino’; did you mean ‘cgroup_init’? [-Werror=implicit-function-declaration]
>       175 |                    cgroup_ino(wb->memcg_css->cgroup),
>           |                    ^~~~~~~~~~
>           |                    cgroup_init
>     .../linux/mm/backing-dev.c:175:33: error: ‘struct bdi_writeback’ has no member named ‘memcg_css’
>       175 |                    cgroup_ino(wb->memcg_css->cgroup),
>           |                                 ^~
> 
> The kunit build config is not having CONFIG_CGROUPS.  I guess we need to check
> the case?  I confirmed below dumb change is fixing the issue, but I guess it
> could be cleaner.  May I ask your opinion?
Thanks for report the issue. As discussed before, we try to keep the same output
whether CGROUP is enable or not. So we'd better show cgroup number 0 for bdi->wb
instead remove cgroup number from output.
> 
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -160,7 +160,9 @@ static void wb_stats_show(struct seq_file *m, struct bdi_writeback *wb,
>  {
> 
>         seq_printf(m,
> +#ifdef CONFIG_CGROUPS
>                    "WbCgIno:           %10lu\n"
> +#endif
>                    "WbWriteback:       %10lu kB\n"
>                    "WbReclaimable:     %10lu kB\n"
>                    "WbDirtyThresh:     %10lu kB\n"
> @@ -172,7 +174,9 @@ static void wb_stats_show(struct seq_file *m, struct bdi_writeback *wb,
>                    "b_more_io:         %10lu\n"
>                    "b_dirty_time:      %10lu\n"
>                    "state:             %10lx\n\n",
> +#ifdef CONFIG_CGROUPS
>                    cgroup_ino(wb->memcg_css->cgroup),
> +#endif
>                    K(stats->nr_writeback),
>                    K(stats->nr_reclaimable),
>                    K(stats->wb_thresh),
> 
> 
>> +		   K(stats->nr_writeback),
>> +		   K(stats->nr_reclaimable),
>> +		   K(stats->wb_thresh),
>> +		   K(stats->nr_dirtied),
>> +		   K(stats->nr_written),
>> +		   K(wb->avg_write_bandwidth),
>> +		   stats->nr_dirty,
>> +		   stats->nr_io,
>> +		   stats->nr_more_io,
>> +		   stats->nr_dirty_time,
>> +		   wb->state);
>> +}
>> +
>> +static int cgwb_debug_stats_show(struct seq_file *m, void *v)
>> +{
>> +	struct backing_dev_info *bdi = m->private;
>> +	unsigned long background_thresh;
>> +	unsigned long dirty_thresh;
>> +	struct bdi_writeback *wb;
>> +	struct wb_stats stats;
> 
> Kunit build also shows below warning:
> 
>     .../linux/mm/backing-dev.c: In function ‘cgwb_debug_stats_show’:
>     .../linux/mm/backing-dev.c:195:25: warning: unused variable ‘stats’ [-Wunused-variable]
>       195 |         struct wb_stats stats;
>           |                         ^~~~~
> 
> I guess above line can simply removed?
Yes, this could be simply removed.

I'd submit a new series to fix this very soon.

Thanks.
> 
>> +
>> +	global_dirty_limits(&background_thresh, &dirty_thresh);
>> +
>> +	rcu_read_lock();
>> +	list_for_each_entry_rcu(wb, &bdi->wb_list, bdi_node) {
>> +		struct wb_stats stats = { .dirty_thresh = dirty_thresh };
>> +
>> +		if (!wb_tryget(wb))
>> +			continue;
>> +
>> +		collect_wb_stats(&stats, wb);
>> +
>> +		/*
>> +		 * Calculate thresh of wb in writeback cgroup which is min of
>> +		 * thresh in global domain and thresh in cgroup domain. Drop
>> +		 * rcu lock because cgwb_calc_thresh may sleep in
>> +		 * cgroup_rstat_flush. We can do so here because we have a ref.
>> +		 */
>> +		if (mem_cgroup_wb_domain(wb)) {
>> +			rcu_read_unlock();
>> +			stats.wb_thresh = min(stats.wb_thresh, cgwb_calc_thresh(wb));
>> +			rcu_read_lock();
>> +		}
>> +
>> +		wb_stats_show(m, wb, &stats);
>> +
>> +		wb_put(wb);
>> +	}
>> +	rcu_read_unlock();
>> +
>> +	return 0;
>> +}
> 
> 
> Thanks,
> SJ
> 
> [...]
> 


