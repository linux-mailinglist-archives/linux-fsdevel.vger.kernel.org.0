Return-Path: <linux-fsdevel+bounces-16313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B3389AE32
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 05:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FCA2B22AA1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 03:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C4411181;
	Sun,  7 Apr 2024 03:13:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD6F10A0A;
	Sun,  7 Apr 2024 03:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712459629; cv=none; b=NYoMrM+WiFNgNPq8sMAUOPbxopKIQSKODY8v8jK0UbPe2zXUguUdIocdLllZnO+oMEXIMZrs9DQ0xDTDRG3C2vTMOrbb3yS9A+U5mFIBZDBURwLaNbhfP2JcBzo8hvC3c26T3eoUwoRCh2xZ0ghv7kH3I5i/GEeRFtxpfvC39gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712459629; c=relaxed/simple;
	bh=yJe8X8J68cHa2gvIMU5bJdS9Gcj3O1sw/lxHUWoIo+g=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OepkQlXiNTT9iz+G/olJYF7BkgBGhJsef9vIFXKCofjYuz5QttdF7ltBauoUtRhWn5t3PrhIaJfVuQepXyWDAHD2KFL3vI7OzCnNSpRpKtJSGgMCDDAc8Uu/hYRj+w/sO5mLZXzAiEMpINMuVU0Q5ViaHxZ+eYAnv/2fWvkiu54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VBy3f3Gxbz4f3lgF;
	Sun,  7 Apr 2024 11:13:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id F07051A0568;
	Sun,  7 Apr 2024 11:13:42 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgAnRQ5lDxJmd0M4JQ--.28098S2;
	Sun, 07 Apr 2024 11:13:42 +0800 (CST)
Subject: Re: [PATCH v2 3/6] writeback: support retrieving per group debug
 writeback stats of bdi
To: Jan Kara <jack@suse.cz>, Brian Foster <bfoster@redhat.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, tj@kernel.org,
 dsterba@suse.com, mjguzik@gmail.com, dhowells@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
References: <20240327155751.3536-1-shikemeng@huaweicloud.com>
 <20240327155751.3536-4-shikemeng@huaweicloud.com> <Zga937dR5UgtSVaz@bfoster>
 <e3816f9c-0f29-a0e4-8ad8-a6acf82a06ad@huaweicloud.com>
 <Zg1wGvTeQxjqjYUG@bfoster> <20240404090753.q3iugmqeeqig64db@quack3>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <6bf2280d-bce1-c1c5-3b25-8cfc7e1fa81d@huaweicloud.com>
Date: Sun, 7 Apr 2024 11:13:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240404090753.q3iugmqeeqig64db@quack3>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAnRQ5lDxJmd0M4JQ--.28098S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKw1xCF48ZF1rKw4Duw43trb_yoW7AryUp3
	Wqg3W7Kr4DXw1IkwnFv34jv34IyrZ5JryUXr9rG345CF90qFn3ZF4rGFW5uFy5ZrW8Aw4U
	Zw4jyrZxW3y5tFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



on 4/4/2024 5:07 PM, Jan Kara wrote:
> On Wed 03-04-24 11:04:58, Brian Foster wrote:
>> On Wed, Apr 03, 2024 at 04:49:42PM +0800, Kemeng Shi wrote:
>>> on 3/29/2024 9:10 PM, Brian Foster wrote:
>>>> On Wed, Mar 27, 2024 at 11:57:48PM +0800, Kemeng Shi wrote:
>>>>> +		collect_wb_stats(&stats, wb);
>>>>> +
>>>>
>>>> Also, similar question as before on whether you'd want to check
>>>> WB_registered or something here..
>>> Still prefer to keep full debug info and user could filter out on
>>> demand.
>>
>> Ok. I was more wondering if that was needed for correctness. If not,
>> then that seems fair enough to me.
>>
>>>>> +		if (mem_cgroup_wb_domain(wb) == NULL) {
>>>>> +			wb_stats_show(m, wb, &stats);
>>>>> +			continue;
>>>>> +		}
>>>>
>>>> Can you explain what this logic is about? Is the cgwb_calc_thresh()
>>>> thing not needed in this case? A comment might help for those less
>>>> familiar with the implementation details.
>>> If mem_cgroup_wb_domain(wb) is NULL, then it's bdi->wb, otherwise,
>>> it's wb in cgroup. For bdi->wb, there is no need to do wb_tryget
>>> and cgwb_calc_thresh. Will add some comment in next version.
>>>>
>>>> BTW, I'm also wondering if something like the following is correct
>>>> and/or roughly equivalent:
>>>> 	
>>>> 	list_for_each_*(wb, ...) {
>>>> 		struct wb_stats stats = ...;
>>>>
>>>> 		if (!wb_tryget(wb))
>>>> 			continue;
>>>>
>>>> 		collect_wb_stats(&stats, wb);
>>>>
>>>> 		/*
>>>> 		 * Extra wb_thresh magic. Drop rcu lock because ... . We
>>>> 		 * can do so here because we have a ref.
>>>> 		 */
>>>> 		if (mem_cgroup_wb_domain(wb)) {
>>>> 			rcu_read_unlock();
>>>> 			stats.wb_thresh = min(stats.wb_thresh, cgwb_calc_thresh(wb));
>>>> 			rcu_read_lock();
>>>> 		}
>>>>
>>>> 		wb_stats_show(m, wb, &stats)
>>>> 		wb_put(wb);
>>>> 	}
>>> It's correct as wb_tryget to bdi->wb has no harm. I have considered
>>> to do it in this way, I change my mind to do it in new way for
>>> two reason:
>>> 1. Put code handling wb in cgroup more tight which could be easier
>>> to maintain.
>>> 2. Rmove extra wb_tryget/wb_put for wb in bdi.
>>> Would this make sense to you?
>>
>> Ok, well assuming it is correct the above logic is a bit more simple and
>> readable to me. I think you'd just need to fill in the comment around
>> the wb_thresh thing rather than i.e. having to explain we don't need to
>> ref bdi->wb even though it doesn't seem to matter.
>>
>> I kind of feel the same on the wb_stats file thing below just because it
>> seems more consistent and available if wb_stats eventually grows more
>> wb-specific data.
>>
>> That said, this is subjective and not hugely important so I don't insist
>> on either point. Maybe wait a bit and see if Jan or Tejun or somebody
>> has any thoughts..? If nobody else expresses explicit preference then
>> I'm good with it either way.
> 
> No strong opinion from me really.
> 
>>>>> +static void cgwb_debug_register(struct backing_dev_info *bdi)
>>>>> +{
>>>>> +	debugfs_create_file("wb_stats", 0444, bdi->debug_dir, bdi,
>>>>> +			    &cgwb_debug_stats_fops);
>>>>> +}
>>>>> +
>>>>>  static void bdi_collect_stats(struct backing_dev_info *bdi,
>>>>>  			      struct wb_stats *stats)
>>>>>  {
>>>>> @@ -117,6 +202,8 @@ static void bdi_collect_stats(struct backing_dev_info *bdi,
>>>>>  {
>>>>>  	collect_wb_stats(stats, &bdi->wb);
>>>>>  }
>>>>> +
>>>>> +static inline void cgwb_debug_register(struct backing_dev_info *bdi) { }
>>>>
>>>> Could we just create the wb_stats file regardless of whether cgwb is
>>>> enabled? Obviously theres only one wb in the !CGWB case and it's
>>>> somewhat duplicative with the bdi stats file, but that seems harmless if
>>>> the same code can be reused..? Maybe there's also a small argument for
>>>> dropping the state info from the bdi stats file and moving it to
>>>> wb_stats.In backing-dev.c, there are a lot "#ifdef CGWB .. #else .. #endif" to
>>> avoid unneed extra cost when CGWB is not enabled.
>>> I think it's better to avoid extra cost from wb_stats when CGWB is not
>>> enabled. For now, we only save cpu cost to create and destroy wb_stats
>>> and save memory cost to record debugfs file, we could save more in
>>> future when wb_stats records more debug info.
> 
> Well, there's the other side that you don't have to think whether the
> kernel has CGWB enabled or not when asking a customer to gather the
> writeback debug info - you can always ask for wb_stats. Also if you move
> the wb->state to wb_stats only it will become inaccessible with CGWB
> disabled. So I agree with Brian that it is better to provide wb_stats also
> with CGWB disabled (and we can just implement wb_stats for !CGWB case with
> the same function as bdi_stats).
> 
> That being said all production kernels I have seen do have CGWB enabled so
> I don't care that much about this...
It's acceptable to me if the extra cost is tolerable.
> 
>>> Move state info from bdi stats to wb_stats make senses to me. The only
>>> concern would be compatibility problem. I will add a new patch to this
>>> to make this more noticeable and easier to revert.
> 
> Yeah, I don't think we care much about debugfs compatibility but I think
> removing state from bdi_stats is not worth the inconsistency between
> wb_stats and bdi_stats in the !CGWB case.
OK, I will simply keep wb_stats even CGWB is not enabled while keep state
in both bdi_stats and wb_stats if Braian doesn't against in recent dasy.

Kemeng
> 
> 								Honza
> 


