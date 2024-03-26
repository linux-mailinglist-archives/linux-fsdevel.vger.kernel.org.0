Return-Path: <linux-fsdevel+bounces-15327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AF088C32D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 14:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239261C246D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 13:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3944973177;
	Tue, 26 Mar 2024 13:16:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6836CDA1;
	Tue, 26 Mar 2024 13:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711459003; cv=none; b=ktsWvqPQCAoNuQi+iB37jnwxXErmI7cvAOb998pN3s5jZE7TbCQyRV3H3Ue1DbdV4fKRnbZQCp/4teSMYIAczLJnechkDVhIolk/4/qPjbQA/stOVTp69GuF+KyHunI736PJ0Yre5ICszru2hSx9DrN7uyoPA0Tx7rL186ESJRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711459003; c=relaxed/simple;
	bh=afpeWrlO6T2EQlqldC/3usgBLMR4k6jh20fMWpfjhrY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=K2P6CK38GccepwlkBO0X3Lc0VYpIsbjKkL25vqbbveD5+ifNKVEK3IoJEdjnyQI+1C6pAGbvgbAP/HEdfYMSgImh5W0FLfe9GfRFnwIxCHFqDLpGhxNua6inUPbdm0JcrZXMbxGG/d+nyYuBUHyFQjYw/AEpl6WqBPR8t0fg840=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V3r0r6fxgz4f3lVs;
	Tue, 26 Mar 2024 21:16:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 0E8941A0DF6;
	Tue, 26 Mar 2024 21:16:37 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP3 (Coremail) with SMTP id _Ch0CgBHCaG0ygJmZu0RIA--.43267S2;
	Tue, 26 Mar 2024 21:16:36 +0800 (CST)
Subject: Re: [PATCH 1/6] writeback: collect stats of all wb of bdi in
 bdi_debug_stats_show
To: Brian Foster <bfoster@redhat.com>
Cc: Jan Kara <jack@suse.cz>, akpm@linux-foundation.org, tj@kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, willy@infradead.org, dsterba@suse.com,
 mjguzik@gmail.com, dhowells@redhat.com, peterz@infradead.org
References: <20240320110222.6564-1-shikemeng@huaweicloud.com>
 <20240320110222.6564-2-shikemeng@huaweicloud.com>
 <20240321180620.mbint45pbyc74vpg@quack3>
 <a684ccdb-372f-b9e6-7239-ddb42a3f5f28@huaweicloud.com>
 <Zf1ycOu3ODf2UcNw@bfoster>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <5f6302f8-2890-b7c8-e207-296cc5b452fd@huaweicloud.com>
Date: Tue, 26 Mar 2024 21:16:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zf1ycOu3ODf2UcNw@bfoster>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgBHCaG0ygJmZu0RIA--.43267S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKry7ZF1UCr4UuF43urWUtwb_yoWxXry3pF
	W5Ga15Gr4UXry3KrnIv34DXrZ3tw40qr17XFyxCay5Cr1qqF1akFy2kryj9Fy8CrWxGr1j
	va15A39xurW5tFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



on 3/22/2024 7:58 PM, Brian Foster wrote:
> On Fri, Mar 22, 2024 at 03:51:27PM +0800, Kemeng Shi wrote:
>>
>>
>> on 3/22/2024 2:06 AM, Jan Kara wrote:
>>> On Wed 20-03-24 19:02:17, Kemeng Shi wrote:
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
>>>
>>> Looks mostly good, one comment below:
>>>
>>>> ---
>>>>  mm/backing-dev.c | 93 ++++++++++++++++++++++++++++++++++++------------
>>>>  1 file changed, 70 insertions(+), 23 deletions(-)
>>>>
>>>> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
>>>> index 5f2be8c8df11..788702b6c5dd 100644
>>>> --- a/mm/backing-dev.c
>>>> +++ b/mm/backing-dev.c
>>>> @@ -39,6 +39,19 @@ struct workqueue_struct *bdi_wq;
>>>>  #include <linux/debugfs.h>
>>>>  #include <linux/seq_file.h>
>>>>  
>>>> +struct wb_stats {
>>>> +	unsigned long nr_dirty;
>>>> +	unsigned long nr_io;
>>>> +	unsigned long nr_more_io;
>>>> +	unsigned long nr_dirty_time;
>>>> +	unsigned long nr_writeback;
>>>> +	unsigned long nr_reclaimable;
>>>> +	unsigned long nr_dirtied;
>>>> +	unsigned long nr_written;
>>>> +	unsigned long dirty_thresh;
>>>> +	unsigned long wb_thresh;
>>>> +};
>>>> +
>>>>  static struct dentry *bdi_debug_root;
>>>>  
>>>>  static void bdi_debug_init(void)
>>>> @@ -46,31 +59,65 @@ static void bdi_debug_init(void)
>>>>  	bdi_debug_root = debugfs_create_dir("bdi", NULL);
>>>>  }
>>>>  
>>>> -static int bdi_debug_stats_show(struct seq_file *m, void *v)
>>>> +static void collect_wb_stats(struct wb_stats *stats,
>>>> +			     struct bdi_writeback *wb)
>>>>  {
>>>> -	struct backing_dev_info *bdi = m->private;
>>>> -	struct bdi_writeback *wb = &bdi->wb;
>>>> -	unsigned long background_thresh;
>>>> -	unsigned long dirty_thresh;
>>>> -	unsigned long wb_thresh;
>>>> -	unsigned long nr_dirty, nr_io, nr_more_io, nr_dirty_time;
>>>>  	struct inode *inode;
>>>>  
>>>> -	nr_dirty = nr_io = nr_more_io = nr_dirty_time = 0;
>>>>  	spin_lock(&wb->list_lock);
>>>>  	list_for_each_entry(inode, &wb->b_dirty, i_io_list)
>>>> -		nr_dirty++;
>>>> +		stats->nr_dirty++;
>>>>  	list_for_each_entry(inode, &wb->b_io, i_io_list)
>>>> -		nr_io++;
>>>> +		stats->nr_io++;
>>>>  	list_for_each_entry(inode, &wb->b_more_io, i_io_list)
>>>> -		nr_more_io++;
>>>> +		stats->nr_more_io++;
>>>>  	list_for_each_entry(inode, &wb->b_dirty_time, i_io_list)
>>>>  		if (inode->i_state & I_DIRTY_TIME)
>>>> -			nr_dirty_time++;
>>>> +			stats->nr_dirty_time++;
>>>>  	spin_unlock(&wb->list_lock);
>>>>  
>>>> +	stats->nr_writeback += wb_stat(wb, WB_WRITEBACK);
>>>> +	stats->nr_reclaimable += wb_stat(wb, WB_RECLAIMABLE);
>>>> +	stats->nr_dirtied += wb_stat(wb, WB_DIRTIED);
>>>> +	stats->nr_written += wb_stat(wb, WB_WRITTEN);
>>>> +	stats->wb_thresh += wb_calc_thresh(wb, stats->dirty_thresh);
>>>> +}
>>>> +
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
>>>
>>> So AFAICT this function can race against
>>>   bdi_unregister() -> wb_shutdown(&bdi->wb)
>>>
>>> because that doesn't take the cgwb_release_mutex. So we either need the RCU
>>> protection as Brian suggested or cgwb_lock or something. But given
>>> collect_wb_stats() can take a significant amount of time (traversing all
>>> the lists etc.) I think we'll need something more clever.
>> Sorry for missing this. I only pay attention to wb in cgroup as there is no
>> much change to how we use bdi->wb.
>> It seems that there was always a race between orginal bdi_debug_stats_show and
>> release of bdi as following
>> cat /.../stats
>> bdi_debug_stats_show
>> 			bdi_unregister
>> 			bdi_put
>> 			  release_bdi
>> 			    kfree(bdi)
>>   use after free
>>
>> I will fix this in next version. Thanks!
>>
> 
Hi Brian
> BTW, I thought this was kind of the point of the tryget in the writeback
> path. I.e., the higher level loop runs under rcu_read_lock(), but in the
> case it needs to cycle the rcu lock it acquires a reference to the wb,
> and then can use that wb to continue the loop once the rcu lock is
> reacquired. IIUC, this works because the rcu list removal keeps the list
> ->next pointer sane and then the ref keeps the wb memory from being
> freed. A tryget of any wb's that have been shutdown fails because the
> percpu ref counter has been killedFor bdi->wb, tryget seems not helpful to protect race as wb_tryget does
nothing for bdi->wb. For wb in cgroup, this works fine.
> 
> So I _think_ this means that for the stat collection use case, you could
> protect the overall walk with rcu as Jan alludes above, but then maybe
> use a combination of need_resched()/cond_resched_rcu() and wb_tryget()
> to introduce resched points and avoid holding lock(s) for too long.
Sure, I will protect race with rcu in next version!
> 
> Personally, I wonder if since this is mainly debug code we could just
> get away with doing the simple thing of trying for a ref on each wb
> unconditionally rather than only in a need_resched() case, but maybe
> there are reasons not to do that... hm?
Agreed, I also prefer simple debug code with no need_resched. Will do
it unless someone is against this.

Thansk a lot for the helpful information!
Kemeng
> 
> Brian
> 
>>>
>>> 								Honza
>>>
>>
> 


