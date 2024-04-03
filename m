Return-Path: <linux-fsdevel+bounces-15994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6149E896720
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 09:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84DF61C209AB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 07:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B675D91E;
	Wed,  3 Apr 2024 07:49:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE698286A6;
	Wed,  3 Apr 2024 07:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130556; cv=none; b=Uj7PFkxI1GpOBkhAP9rykcZWpGCsICAcPHi5BmdAwbQsYJTuXZozWuNptIk7nFij2XXoQgLIgPFXRJlNU0KwlckeE7U6QJTMUXMsCNpGazLW1b04IyF0u1CBS191+bX2QCsxqCLti/k4AH5rJqNt+EnFhcqlctVC7Ge5PmORo+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130556; c=relaxed/simple;
	bh=EPw59Nj1eeTLPR830UfffcQk/hCu65cgSEMB6Rtx9SU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=W/5dO/PDBhyJ9USnbGIzLLRgjm3KK75r7PCOobrqhLFiSUD4Mb0sC14D6AlUDljDA9/84IvMusrq2W5H/FB7dGqij20cUI+fGsxu443BpRD7DW9ErbJRlXf04ac6Jy7bEEj2mVVh3QkWnz1PuqP74HsiFoxtFtdBTG5XHlYezK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V8cMJ6pFmz4f3m7J;
	Wed,  3 Apr 2024 15:49:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 56A551A0BDA;
	Wed,  3 Apr 2024 15:49:09 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgCnwwzzCQ1m7OeoIw--.47991S2;
	Wed, 03 Apr 2024 15:49:09 +0800 (CST)
Subject: Re: [PATCH v2 2/6] writeback: collect stats of all wb of bdi in
 bdi_debug_stats_show
To: Brian Foster <bfoster@redhat.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, jack@suse.cz,
 tj@kernel.org, dsterba@suse.com, mjguzik@gmail.com, dhowells@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
References: <20240327155751.3536-1-shikemeng@huaweicloud.com>
 <20240327155751.3536-3-shikemeng@huaweicloud.com> <Zga8Sf1DIxMevdcw@bfoster>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <9a9fe07e-d7f4-19f7-a6fb-28ae0ca4c25e@huaweicloud.com>
Date: Wed, 3 Apr 2024 15:49:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zga8Sf1DIxMevdcw@bfoster>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgCnwwzzCQ1m7OeoIw--.47991S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WryfWr17JFykur1rAF4ktFb_yoW7tw47pF
	ZxGwn3Gr48XF1xWFnxuFWjqryYqw4Sqry7tF9ayFWUCFn8urn0yFyxW345CFy5CrZ7Crya
	van8uF97C3yktaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 3/29/2024 9:04 PM, Brian Foster wrote:
> On Wed, Mar 27, 2024 at 11:57:47PM +0800, Kemeng Shi wrote:
>> /sys/kernel/debug/bdi/xxx/stats is supposed to show writeback information
>> of whole bdi, but only writeback information of bdi in root cgroup is
>> collected. So writeback information in non-root cgroup are missing now.
>> To be more specific, considering following case:
>>
>> /* create writeback cgroup */
>> cd /sys/fs/cgroup
>> echo "+memory +io" > cgroup.subtree_control
>> mkdir group1
>> cd group1
>> echo $$ > cgroup.procs
>> /* do writeback in cgroup */
>> fio -name test -filename=/dev/vdb ...
>> /* get writeback info of bdi */
>> cat /sys/kernel/debug/bdi/xxx/stats
>> The cat result unexpectedly implies that there is no writeback on target
>> bdi.
>>
>> Fix this by collecting stats of all wb in bdi instead of only wb in
>> root cgroup.
>>
>> Following domain hierarchy is tested:
>>                 global domain (320G)
>>                 /                 \
>>         cgroup domain1(10G)     cgroup domain2(10G)
>>                 |                 |
>> bdi            wb1               wb2
>>
>> /* all writeback info of bdi is successfully collected */
>> cat stats
>> BdiWriteback:             2912 kB
>> BdiReclaimable:        1598464 kB
>> BdiDirtyThresh:      167479028 kB
>> DirtyThresh:         195038532 kB
>> BackgroundThresh:     32466728 kB
>> BdiDirtied:           19141696 kB
>> BdiWritten:           17543456 kB
>> BdiWriteBandwidth:     1136172 kBps
>> b_dirty:                     2
>> b_io:                        0
>> b_more_io:                   1
>> b_dirty_time:                0
>> bdi_list:                    1
>> state:                       1
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>  mm/backing-dev.c | 100 +++++++++++++++++++++++++++++++++--------------
>>  1 file changed, 71 insertions(+), 29 deletions(-)
>>
>> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
>> index 70f02959f3bd..8daf950e6855 100644
>> --- a/mm/backing-dev.c
>> +++ b/mm/backing-dev.c
> ...
>> @@ -65,16 +78,54 @@ static struct backing_dev_info *lookup_bdi(struct seq_file *m)
>>  	return NULL;
>>  }
>>  
>> +static void collect_wb_stats(struct wb_stats *stats,
>> +			     struct bdi_writeback *wb)
>> +{
>> +	struct inode *inode;
>> +
>> +	spin_lock(&wb->list_lock);
>> +	list_for_each_entry(inode, &wb->b_dirty, i_io_list)
>> +		stats->nr_dirty++;
>> +	list_for_each_entry(inode, &wb->b_io, i_io_list)
>> +		stats->nr_io++;
>> +	list_for_each_entry(inode, &wb->b_more_io, i_io_list)
>> +		stats->nr_more_io++;
>> +	list_for_each_entry(inode, &wb->b_dirty_time, i_io_list)
>> +		if (inode->i_state & I_DIRTY_TIME)
>> +			stats->nr_dirty_time++;
>> +	spin_unlock(&wb->list_lock);
>> +
>> +	stats->nr_writeback += wb_stat(wb, WB_WRITEBACK);
>> +	stats->nr_reclaimable += wb_stat(wb, WB_RECLAIMABLE);
>> +	stats->nr_dirtied += wb_stat(wb, WB_DIRTIED);
>> +	stats->nr_written += wb_stat(wb, WB_WRITTEN);
>> +	stats->wb_thresh += wb_calc_thresh(wb, stats->dirty_thresh);
> 
> Kinda nitty question, but is this a sum of per-wb writeback thresholds?
> If so, do you consider that useful information vs. the per-wb threshold
> data presumably exposed in the next patch?
It's sum of per-wb wirteback thresholds in global domain. For each wb,
it's threshold is min of threshold in global domain and threshold in
cgroup domain (if any). As the debug data of bdi existed before writeback
cgroup was introduced, so it would be better to show bdi threshold in global
domain which is more compatible.
> 
> I'm not really that worried about what debug data we expose, it just
> seems a little odd. How would you document this value in a sentence or
> two, for example?
I think it could simply be "threshold of bdi in global domain".
> 
>> +}
>> +
>> +#ifdef CONFIG_CGROUP_WRITEBACK
>> +static void bdi_collect_stats(struct backing_dev_info *bdi,
>> +			      struct wb_stats *stats)
>> +{
>> +	struct bdi_writeback *wb;
>> +
>> +	list_for_each_entry_rcu(wb, &bdi->wb_list, bdi_node)
>> +		collect_wb_stats(stats, wb);
> 
> Depending on discussion on the previous patch and whether the higher
> level rcu protection in bdi_debug_stats_show() is really necessary, it
> might make more sense to move it here.
Sure, will do it in next version.
> 
> I'm also wondering if you'd want to check the state of the individual wb
> (i.e. WB_registered?) before reading it..?
I think it't better to keep full debug info. The user could filter it out
with state in debug info anyway.
> 
>> +}
>> +#else
>> +static void bdi_collect_stats(struct backing_dev_info *bdi,
>> +			      struct wb_stats *stats)
>> +{
>> +	collect_wb_stats(stats, &bdi->wb);
>> +}
>> +#endif
> ...
>> @@ -115,18 +157,18 @@ static int bdi_debug_stats_show(struct seq_file *m, void *v)
>>  		   "b_dirty_time:       %10lu\n"
>>  		   "bdi_list:           %10u\n"
>>  		   "state:              %10lx\n",
>> -		   (unsigned long) K(wb_stat(wb, WB_WRITEBACK)),
>> -		   (unsigned long) K(wb_stat(wb, WB_RECLAIMABLE)),
>> -		   K(wb_thresh),
>> +		   K(stats.nr_writeback),
>> +		   K(stats.nr_reclaimable),
>> +		   K(stats.wb_thresh),
>>  		   K(dirty_thresh),
>>  		   K(background_thresh),
>> -		   (unsigned long) K(wb_stat(wb, WB_DIRTIED)),
>> -		   (unsigned long) K(wb_stat(wb, WB_WRITTEN)),
>> -		   (unsigned long) K(wb->write_bandwidth),
>> -		   nr_dirty,
>> -		   nr_io,
>> -		   nr_more_io,
>> -		   nr_dirty_time,
>> +		   K(stats.nr_dirtied),
>> +		   K(stats.nr_written),
>> +		   K(tot_bw),
>> +		   stats.nr_dirty,
>> +		   stats.nr_io,
>> +		   stats.nr_more_io,
>> +		   stats.nr_dirty_time,
>>  		   !list_empty(&bdi->bdi_list), bdi->wb.state);
> 
> Is it worth showing a list count here rather than list_empty() state?
Actually, I don't know how this info was supposed to be used. So I keep it in
old way for compatibility...
As for bdi count, it would be easy to retrieve by counting the bdi number under
/sys/kernel/debug/bdi/.
As for wb count, it would be easy to count with wb_stats.
So I still prefer to keep it in old way for compatibility or just simply remove
it if the list_empty() state is not needed.
Thansk for the review and all advise. Look forward to your reply.

Kemeng

> 
> Brian
> 
>>  
>>  	rcu_read_unlock();
>> -- 
>> 2.30.0
>>
> 


