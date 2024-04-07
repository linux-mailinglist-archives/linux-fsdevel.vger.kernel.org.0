Return-Path: <linux-fsdevel+bounces-16311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF7B89AE1F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 04:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C9AB1C214B3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 02:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC581C10;
	Sun,  7 Apr 2024 02:48:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DFC15C0;
	Sun,  7 Apr 2024 02:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712458096; cv=none; b=EY4Kv+thLGMaHQCGJgLmusc42yL52JjKy7M8M13rv/Bb/7kItCN2d/hxwgzFeSrntLylud8YPV0Glm3T2jTS3LOJdP9QpJzlC+e2MD/rJ/WEQ+HTRfQFrkdwcR7Pcv2b4+noRCsS6AJQiAsLLZJNwRxJmD4+892kB5avdtsmwdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712458096; c=relaxed/simple;
	bh=Xicg4ksnZvNtAayzEIyLqhMBd1X4QEvw9mbwLMGJ+ag=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=btPfeZhcP8HOFKE0cW3t6LXCfY1A9jrnO3rMq47bkHfCtS4+dPpvpYY7n8zPZFSJXQ4zfB1r7gzSYiNV9ydA5Bi4TVD/v0ngMyROstQqTOhUM+/SC+22ERWkTAK09Lw7PwDwTxO7t00AzfirZDKF0yayM8vwHQCRSrqbj+uSu0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VBxV81rpJz4f3l1r;
	Sun,  7 Apr 2024 10:48:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C164A1A0DE6;
	Sun,  7 Apr 2024 10:48:08 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP4 (Coremail) with SMTP id gCh0CgBnuWtnCRJmITLdJQ--.25183S2;
	Sun, 07 Apr 2024 10:48:08 +0800 (CST)
Subject: Re: [PATCH v2 3/6] writeback: support retrieving per group debug
 writeback stats of bdi
To: Brian Foster <bfoster@redhat.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, jack@suse.cz,
 tj@kernel.org, dsterba@suse.com, mjguzik@gmail.com, dhowells@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
References: <20240327155751.3536-1-shikemeng@huaweicloud.com>
 <20240327155751.3536-4-shikemeng@huaweicloud.com> <Zga937dR5UgtSVaz@bfoster>
 <e3816f9c-0f29-a0e4-8ad8-a6acf82a06ad@huaweicloud.com>
 <Zg1wGvTeQxjqjYUG@bfoster>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <7f5a90cc-d6c5-0bb9-825a-7be15bc80878@huaweicloud.com>
Date: Sun, 7 Apr 2024 10:48:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zg1wGvTeQxjqjYUG@bfoster>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBnuWtnCRJmITLdJQ--.25183S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr4kXFyDCw17uFW7uFy3Jwb_yoWDGw1xpF
	W5J3W5Kr4UXr129rnIv3Wjqr9Iy395try7XF97A345CryDtr13tFyrGrWYkryrAryrAryU
	Za1YyrZ7urZ0yrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUrR6zUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 4/3/2024 11:04 PM, Brian Foster wrote:
> On Wed, Apr 03, 2024 at 04:49:42PM +0800, Kemeng Shi wrote:
>>
>>
>> on 3/29/2024 9:10 PM, Brian Foster wrote:
>>> On Wed, Mar 27, 2024 at 11:57:48PM +0800, Kemeng Shi wrote:
>>>> Add /sys/kernel/debug/bdi/xxx/wb_stats to show per group writeback stats
>>>> of bdi.
>>>>
>>>
>>> Hi Kemeng,
>> Hello Brian,
>>>
>>> Just a few random thoughts/comments..
>>>
>>>> Following domain hierarchy is tested:
>>>>                 global domain (320G)
>>>>                 /                 \
>>>>         cgroup domain1(10G)     cgroup domain2(10G)
>>>>                 |                 |
>>>> bdi            wb1               wb2
>>>>
>>>> /* per wb writeback info of bdi is collected */
>>>> cat /sys/kernel/debug/bdi/252:16/wb_stats
>>>> WbCgIno:                    1
>>>> WbWriteback:                0 kB
>>>> WbReclaimable:              0 kB
>>>> WbDirtyThresh:              0 kB
>>>> WbDirtied:                  0 kB
>>>> WbWritten:                  0 kB
>>>> WbWriteBandwidth:      102400 kBps
>>>> b_dirty:                    0
>>>> b_io:                       0
>>>> b_more_io:                  0
>>>> b_dirty_time:               0
>>>> state:                      1
>>>
>>> Maybe some whitespace or something between entries would improve
>>> readability?
>> Sure, I will add a whitespace in next version.
>>>
>>>> WbCgIno:                 4094
>>>> WbWriteback:            54432 kB
>>>> WbReclaimable:         766080 kB
>>>> WbDirtyThresh:        3094760 kB
>>>> WbDirtied:            1656480 kB
>>>> WbWritten:             837088 kB
>>>> WbWriteBandwidth:      132772 kBps
>>>> b_dirty:                    1
>>>> b_io:                       1
>>>> b_more_io:                  0
>>>> b_dirty_time:               0
>>>> state:                      7
>>>> WbCgIno:                 4135
>>>> WbWriteback:            15232 kB
>>>> WbReclaimable:         786688 kB
>>>> WbDirtyThresh:        2909984 kB
>>>> WbDirtied:            1482656 kB
>>>> WbWritten:             681408 kB
>>>> WbWriteBandwidth:      124848 kBps
>>>> b_dirty:                    0
>>>> b_io:                       1
>>>> b_more_io:                  0
>>>> b_dirty_time:               0
>>>> state:                      7
>>>>
>>>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>>>> ---
>>>>  include/linux/writeback.h |  1 +
>>>>  mm/backing-dev.c          | 88 +++++++++++++++++++++++++++++++++++++++
>>>>  mm/page-writeback.c       | 19 +++++++++
>>>>  3 files changed, 108 insertions(+)
>>>>
>>> ...
>>>> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
>>>> index 8daf950e6855..e3953db7d88d 100644
>>>> --- a/mm/backing-dev.c
>>>> +++ b/mm/backing-dev.c
>>>> @@ -103,6 +103,91 @@ static void collect_wb_stats(struct wb_stats *stats,
>>>>  }
>>>>  
>>>>  #ifdef CONFIG_CGROUP_WRITEBACK
>>> ...
>>>> +static int cgwb_debug_stats_show(struct seq_file *m, void *v)
>>>> +{
>>>> +	struct backing_dev_info *bdi;
>>>> +	unsigned long background_thresh;
>>>> +	unsigned long dirty_thresh;
>>>> +	struct bdi_writeback *wb;
>>>> +	struct wb_stats stats;
>>>> +
>>>> +	rcu_read_lock();
>>>> +	bdi = lookup_bdi(m);
>>>> +	if (!bdi) {
>>>> +		rcu_read_unlock();
>>>> +		return -EEXIST;
>>>> +	}
>>>> +
>>>> +	global_dirty_limits(&background_thresh, &dirty_thresh);
>>>> +
>>>> +	list_for_each_entry_rcu(wb, &bdi->wb_list, bdi_node) {
>>>> +		memset(&stats, 0, sizeof(stats));
>>>> +		stats.dirty_thresh = dirty_thresh;
>>>
>>> If you did something like the following here, wouldn't that also zero
>>> the rest of the structure?
>>>
>>> 		struct wb_stats stats = { .dirty_thresh = dirty_thresh };
>>>
>> Suer, will do it in next version.
>>>> +		collect_wb_stats(&stats, wb);
>>>> +
>>>
>>> Also, similar question as before on whether you'd want to check
>>> WB_registered or something here..
>> Still prefer to keep full debug info and user could filter out on
>> demand.
> 
> Ok. I was more wondering if that was needed for correctness. If not,
> then that seems fair enough to me.
For bdi->wb, it's unavailable after release_bdi. As bdi_debug_unregister
will block bdi_unregister, then release_bdi must not be reached yet and
it's safe to collect bdi->wb info.
For wb in cgroup, it's unavailable after cgwb_release_workfn, we could
prevent this with wb_tryget before collection.
So it's correct for per-wb stats but we add a extra wb_trget in
bdi stats in patch 2 and will do it in next version.
> 
>>>
>>>> +		if (mem_cgroup_wb_domain(wb) == NULL) {
>>>> +			wb_stats_show(m, wb, &stats);
>>>> +			continue;
>>>> +		}
>>>
>>> Can you explain what this logic is about? Is the cgwb_calc_thresh()
>>> thing not needed in this case? A comment might help for those less
>>> familiar with the implementation details.
>> If mem_cgroup_wb_domain(wb) is NULL, then it's bdi->wb, otherwise,
>> it's wb in cgroup. For bdi->wb, there is no need to do wb_tryget
>> and cgwb_calc_thresh. Will add some comment in next version.
>>>
>>> BTW, I'm also wondering if something like the following is correct
>>> and/or roughly equivalent:
>>> 	
>>> 	list_for_each_*(wb, ...) {
>>> 		struct wb_stats stats = ...;
>>>
>>> 		if (!wb_tryget(wb))
>>> 			continue;
>>>
>>> 		collect_wb_stats(&stats, wb);
>>>
>>> 		/*
>>> 		 * Extra wb_thresh magic. Drop rcu lock because ... . We
>>> 		 * can do so here because we have a ref.
>>> 		 */
>>> 		if (mem_cgroup_wb_domain(wb)) {
>>> 			rcu_read_unlock();
>>> 			stats.wb_thresh = min(stats.wb_thresh, cgwb_calc_thresh(wb));
>>> 			rcu_read_lock();
>>> 		}
>>>
>>> 		wb_stats_show(m, wb, &stats)
>>> 		wb_put(wb);
>>> 	}
>> It's correct as wb_tryget to bdi->wb has no harm. I have considered
>> to do it in this way, I change my mind to do it in new way for
>> two reason:
>> 1. Put code handling wb in cgroup more tight which could be easier
>> to maintain.
>> 2. Rmove extra wb_tryget/wb_put for wb in bdi.
>> Would this make sense to you?
> 
> Ok, well assuming it is correct the above logic is a bit more simple and
> readable to me. I think you'd just need to fill in the comment around
> the wb_thresh thing rather than i.e. having to explain we don't need to
> ref bdi->wb even though it doesn't seem to matter.
> 
> I kind of feel the same on the wb_stats file thing below just because it
> seems more consistent and available if wb_stats eventually grows more
> wb-specific data.
> 
> That said, this is subjective and not hugely important so I don't insist
> on either point. Maybe wait a bit and see if Jan or Tejun or somebody
> has any thoughts..? If nobody else expresses explicit preference then
> I'm good with it either way.
Sure, I will wait for someday and decide the way used in next version.

Thanks so much for all the advise.

Kemeng
> 
> Brian
> 
>>>
>>>> +
>>>> +		/*
>>>> +		 * cgwb_release will destroy wb->memcg_completions which
>>>> +		 * will be ued in cgwb_calc_thresh. Use wb_tryget to prevent
>>>> +		 * memcg_completions destruction from cgwb_release.
>>>> +		 */
>>>> +		if (!wb_tryget(wb))
>>>> +			continue;
>>>> +
>>>> +		rcu_read_unlock();
>>>> +		/* cgwb_calc_thresh may sleep in cgroup_rstat_flush */
>>>> +		stats.wb_thresh = min(stats.wb_thresh, cgwb_calc_thresh(wb));
>>>> +		wb_stats_show(m, wb, &stats);
>>>> +		rcu_read_lock();
>>>> +		wb_put(wb);
>>>> +	}
>>>> +	rcu_read_unlock();
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +DEFINE_SHOW_ATTRIBUTE(cgwb_debug_stats);
>>>> +
>>>> +static void cgwb_debug_register(struct backing_dev_info *bdi)
>>>> +{
>>>> +	debugfs_create_file("wb_stats", 0444, bdi->debug_dir, bdi,
>>>> +			    &cgwb_debug_stats_fops);
>>>> +}
>>>> +
>>>>  static void bdi_collect_stats(struct backing_dev_info *bdi,
>>>>  			      struct wb_stats *stats)
>>>>  {
>>>> @@ -117,6 +202,8 @@ static void bdi_collect_stats(struct backing_dev_info *bdi,
>>>>  {
>>>>  	collect_wb_stats(stats, &bdi->wb);
>>>>  }
>>>> +
>>>> +static inline void cgwb_debug_register(struct backing_dev_info *bdi) { }
>>>
>>> Could we just create the wb_stats file regardless of whether cgwb is
>>> enabled? Obviously theres only one wb in the !CGWB case and it's
>>> somewhat duplicative with the bdi stats file, but that seems harmless if
>>> the same code can be reused..? Maybe there's also a small argument for
>>> dropping the state info from the bdi stats file and moving it to
>>> wb_stats.In backing-dev.c, there are a lot "#ifdef CGWB .. #else .. #endif" to
>> avoid unneed extra cost when CGWB is not enabled.
>> I think it's better to avoid extra cost from wb_stats when CGWB is not
>> enabled. For now, we only save cpu cost to create and destroy wb_stats
>> and save memory cost to record debugfs file, we could save more in
>> future when wb_stats records more debug info.
>> Move state info from bdi stats to wb_stats make senses to me. The only
>> concern would be compatibility problem. I will add a new patch to this
>> to make this more noticeable and easier to revert.
>> Thanks a lot for review!
>>
>> Kemeng
>>>
>>> Brian
>>>
>>>>  #endif
>>>>  
>>>>  static int bdi_debug_stats_show(struct seq_file *m, void *v)
>>>> @@ -182,6 +269,7 @@ static void bdi_debug_register(struct backing_dev_info *bdi, const char *name)
>>>>  
>>>>  	debugfs_create_file("stats", 0444, bdi->debug_dir, bdi,
>>>>  			    &bdi_debug_stats_fops);
>>>> +	cgwb_debug_register(bdi);
>>>>  }
>>>>  
>>>>  static void bdi_debug_unregister(struct backing_dev_info *bdi)
>>>> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
>>>> index 0e20467367fe..3724c7525316 100644
>>>> --- a/mm/page-writeback.c
>>>> +++ b/mm/page-writeback.c
>>>> @@ -893,6 +893,25 @@ unsigned long wb_calc_thresh(struct bdi_writeback *wb, unsigned long thresh)
>>>>  	return __wb_calc_thresh(&gdtc, thresh);
>>>>  }
>>>>  
>>>> +unsigned long cgwb_calc_thresh(struct bdi_writeback *wb)
>>>> +{
>>>> +	struct dirty_throttle_control gdtc = { GDTC_INIT_NO_WB };
>>>> +	struct dirty_throttle_control mdtc = { MDTC_INIT(wb, &gdtc) };
>>>> +	unsigned long filepages, headroom, writeback;
>>>> +
>>>> +	gdtc.avail = global_dirtyable_memory();
>>>> +	gdtc.dirty = global_node_page_state(NR_FILE_DIRTY) +
>>>> +		     global_node_page_state(NR_WRITEBACK);
>>>> +
>>>> +	mem_cgroup_wb_stats(wb, &filepages, &headroom,
>>>> +			    &mdtc.dirty, &writeback);
>>>> +	mdtc.dirty += writeback;
>>>> +	mdtc_calc_avail(&mdtc, filepages, headroom);
>>>> +	domain_dirty_limits(&mdtc);
>>>> +
>>>> +	return __wb_calc_thresh(&mdtc, mdtc.thresh);
>>>> +}
>>>> +
>>>>  /*
>>>>   *                           setpoint - dirty 3
>>>>   *        f(dirty) := 1.0 + (----------------)
>>>> -- 
>>>> 2.30.0
>>>>
>>>
>>>
>>
> 
> 


