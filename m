Return-Path: <linux-fsdevel+bounces-15062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEF388678C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 08:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32563B2447A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 07:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17EF1BDC8;
	Fri, 22 Mar 2024 07:33:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2761B95F;
	Fri, 22 Mar 2024 07:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711092782; cv=none; b=AQUcSbN1PPgUQB2d96isi+zooMLuefdDczD2RgJQtdd/3HXA1lc3wQOKWQUTjbwyxhA9O+/h/pVk1zpZEh3HgvtLfJnHqcpwwqt8Lq1xAuZwuX9TX3+/9R8thcnc+BupCUUHD08ZNtU+F0s4HrZaDrbnAYFGmRKAUwyVxxqkEcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711092782; c=relaxed/simple;
	bh=Uw6NjcIjpSJqpQ0my7eAGfr1wcChFHlQ8yD7LrMuYjk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fQzr4kjVyERlrKWQOnMX6OLUJbwROp037G6R6SbJCxblFxYeGIM11DR9IWdMUmi28dpmvHCcR//3VaVJqTdbxmCgMhY4wLAvA22f46Cl/Aon/uH92A/u1ghJxRdYmXyZZvrHkcwx8w5BoMamtqL2HriZlOqRN3NDBJiNTLX7fiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V1DZD1MVzz4f3yyh;
	Fri, 22 Mar 2024 15:32:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1B1771A016E;
	Fri, 22 Mar 2024 15:32:56 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP4 (Coremail) with SMTP id gCh0CgCH2GokNP1lvARjHw--.61377S2;
	Fri, 22 Mar 2024 15:32:53 +0800 (CST)
Subject: Re: [PATCH 1/6] writeback: collect stats of all wb of bdi in
 bdi_debug_stats_show
To: Brian Foster <bfoster@redhat.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 willy@infradead.org, jack@suse.cz, dsterba@suse.com, mjguzik@gmail.com,
 dhowells@redhat.com, peterz@infradead.org
References: <20240320110222.6564-1-shikemeng@huaweicloud.com>
 <20240320110222.6564-2-shikemeng@huaweicloud.com> <Zfriwb03HCRWJ24q@bfoster>
 <3d08c249-1b12-f82b-2662-a6fa2b888011@huaweicloud.com>
 <Zfwjo_ZQH_LFZ1Rc@bfoster>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <74742888-5f3a-9554-3d9c-1dcdf7813ef6@huaweicloud.com>
Date: Fri, 22 Mar 2024 15:32:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zfwjo_ZQH_LFZ1Rc@bfoster>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCH2GokNP1lvARjHw--.61377S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKry7ZF1UCr4UuF43GFWUXFb_yoWxGr18pa
	y5G3WxGr4UXr1fKrnIva4jqr9xtw4rtry7Xr97A3yUGF1qyFnIkF1xGa4UuryrCrWxJF1U
	Za15uFyfu3yYyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1zuWJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 3/21/2024 8:10 PM, Brian Foster wrote:
> On Thu, Mar 21, 2024 at 11:44:40AM +0800, Kemeng Shi wrote:
>>
>>
>> on 3/20/2024 9:21 PM, Brian Foster wrote:
>>> On Wed, Mar 20, 2024 at 07:02:17PM +0800, Kemeng Shi wrote:
>>>> /sys/kernel/debug/bdi/xxx/stats is supposed to show writeback information
>>>> of whole bdi, but only writeback information of bdi in root cgroup is
>>>> collected. So writeback information in non-root cgroup are missing now.
>>>> To be more specific, considering following case:
>>>>
>>>> /* create writeback cgroup */
>>>> cd /sys/fs/cgroup
>>>> echo "+memory +io" > cgroup.subtree_control
>>>> mkdir group1
>>>> cd group1
>>>> echo $$ > cgroup.procs
>>>> /* do writeback in cgroup */
>>>> fio -name test -filename=/dev/vdb ...
>>>> /* get writeback info of bdi */
>>>> cat /sys/kernel/debug/bdi/xxx/stats
>>>> The cat result unexpectedly implies that there is no writeback on target
>>>> bdi.
>>>>
>>>> Fix this by collecting stats of all wb in bdi instead of only wb in
>>>> root cgroup.
>>>>
>>>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>>>> ---
>>>>  mm/backing-dev.c | 93 ++++++++++++++++++++++++++++++++++++------------
>>>>  1 file changed, 70 insertions(+), 23 deletions(-)
>>>>
>>>> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
>>>> index 5f2be8c8df11..788702b6c5dd 100644
>>>> --- a/mm/backing-dev.c
>>>> +++ b/mm/backing-dev.c
>>> ...
>>>> @@ -46,31 +59,65 @@ static void bdi_debug_init(void)
>>>>  	bdi_debug_root = debugfs_create_dir("bdi", NULL);
>>>>  }
>>>>  
>>> ...
>>>> +#ifdef CONFIG_CGROUP_WRITEBACK
>>>> +static void bdi_collect_stats(struct backing_dev_info *bdi,
>>>> +			      struct wb_stats *stats)
>>>> +{
>>>> +	struct bdi_writeback *wb;
>>>> +
>>>> +	/* protect wb from release */
>>>> +	mutex_lock(&bdi->cgwb_release_mutex);
>>>> +	list_for_each_entry(wb, &bdi->wb_list, bdi_node)
>>>> +		collect_wb_stats(stats, wb);
>>>> +	mutex_unlock(&bdi->cgwb_release_mutex);
>>>> +}
>>>> +#else
>>>> +static void bdi_collect_stats(struct backing_dev_info *bdi,
>>>> +			      struct wb_stats *stats)
>>>> +{
>>>> +	collect_wb_stats(stats, &bdi->wb);
>>>> +}
>>>> +#endif
>>>> +
>>>
>>> I'm not familiar enough with the cgwb code to say for sure (and I'd
>>> probably wait for more high level feedback before worrying too much
>>> about this), but do we need the ifdef here just to iterate ->wb_list?
>>> >From looking at the code, it appears bdi->wb ends up on the list while
>>> the bdi is registered for both cases, so that distinction seems
>>> unnecessary. WRT to wb release protection, I wonder if this could use a
>> Currently, we have ifdef trying to remove unnecessary cost when
>> CONFIG_CGROUP_WRITEBACK is not enabled, see defination of cgwb_bdi_register
>> and cgwb_remove_from_bdi_list for example. So I try to define bdi_collect_stats
>> in similar way.
>>> combination of rcu_read_lock()/list_for_each_safe() and wb_tryget() on
>>> each wb before collecting its stats..? See how bdi_split_work_to_wbs()
>>> works, for example.
>> The combination of rcu_read_lock()/list_for_each_safe() and wb_tryget()
>> should work fine.
>> With ifdef, bdi_collect_stats takes no extra cost when CONFIG_CGROUP_WRITEBACK
>> is not enabled and is consistent with existing code style, so I still prefer
>> this way. Yes, The extra cost is not a big deal as it only exists in debug mode,
>> so it's acceptable to use the suggested combination in next version if you are
>> still strongly aganst this.
>>
> 
> Ok. I also previously missed that there are two implementations of
> bdi_split_work_to_wbs() based on CGROUP_WRITEBACK. It seems reasonable
> enough to me to follow that precedent for the !CGROUP_WRITEBACK case.
> 
> It still seems to make more sense to me to walk the list similar to how
> bdi_split_work_to_wbs() does for the CGROUP_WRITEBACK enabled case. Do
> you agree?
Sure, I agree with this and will do it in next version. Thansk!

Kemeng
> 
> Brian
> 
>>>
>>> Also I see a patch conflict/compile error on patch 2 due to
>>> __wb_calc_thresh() only taking one parameter in my tree. What's the
>>> baseline commit for this series?
>>>
>> Sorry for missing this, this seris is based on another patchset [1] which is still
>> under review.
>> Look forward to your reply!
>>
>> Thansk
>> Kemeng
>>
>> [1] https://lore.kernel.org/lkml/20240123183332.876854-1-shikemeng@huaweicloud.com/T/#mc6455784a63d0f8aa1a2f5aff325abcdf9336b76
>>
>>> Brian
>>>
>>>> +static int bdi_debug_stats_show(struct seq_file *m, void *v)
>>>> +{
>>>> +	struct backing_dev_info *bdi = m->private;
>>>> +	unsigned long background_thresh;
>>>> +	unsigned long dirty_thresh;
>>>> +	struct wb_stats stats;
>>>> +	unsigned long tot_bw;
>>>> +
>>>>  	global_dirty_limits(&background_thresh, &dirty_thresh);
>>>> -	wb_thresh = wb_calc_thresh(wb, dirty_thresh);
>>>> +
>>>> +	memset(&stats, 0, sizeof(stats));
>>>> +	stats.dirty_thresh = dirty_thresh;
>>>> +	bdi_collect_stats(bdi, &stats);
>>>> +
>>>> +	tot_bw = atomic_long_read(&bdi->tot_write_bandwidth);
>>>>  
>>>>  	seq_printf(m,
>>>>  		   "BdiWriteback:       %10lu kB\n"
>>>> @@ -87,18 +134,18 @@ static int bdi_debug_stats_show(struct seq_file *m, void *v)
>>>>  		   "b_dirty_time:       %10lu\n"
>>>>  		   "bdi_list:           %10u\n"
>>>>  		   "state:              %10lx\n",
>>>> -		   (unsigned long) K(wb_stat(wb, WB_WRITEBACK)),
>>>> -		   (unsigned long) K(wb_stat(wb, WB_RECLAIMABLE)),
>>>> -		   K(wb_thresh),
>>>> +		   K(stats.nr_writeback),
>>>> +		   K(stats.nr_reclaimable),
>>>> +		   K(stats.wb_thresh),
>>>>  		   K(dirty_thresh),
>>>>  		   K(background_thresh),
>>>> -		   (unsigned long) K(wb_stat(wb, WB_DIRTIED)),
>>>> -		   (unsigned long) K(wb_stat(wb, WB_WRITTEN)),
>>>> -		   (unsigned long) K(wb->write_bandwidth),
>>>> -		   nr_dirty,
>>>> -		   nr_io,
>>>> -		   nr_more_io,
>>>> -		   nr_dirty_time,
>>>> +		   K(stats.nr_dirtied),
>>>> +		   K(stats.nr_written),
>>>> +		   K(tot_bw),
>>>> +		   stats.nr_dirty,
>>>> +		   stats.nr_io,
>>>> +		   stats.nr_more_io,
>>>> +		   stats.nr_dirty_time,
>>>>  		   !list_empty(&bdi->bdi_list), bdi->wb.state);
>>>>  
>>>>  	return 0;
>>>> -- 
>>>> 2.30.0
>>>>
>>>>
>>>
>>>
>>
> 
> 


