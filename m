Return-Path: <linux-fsdevel+bounces-16003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AEE8969AD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 10:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11C77B2944B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 08:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B8F6EB53;
	Wed,  3 Apr 2024 08:50:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875ED70CA6;
	Wed,  3 Apr 2024 08:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712134223; cv=none; b=EZ06PO96aGnHXvo2qMhoDfXe+4H2FohlQMTUaFSPHTc3tRsN/X3gEfA0kTGqGfFMZXSKEU2T4Uf42/NiIhB5Bw9ks1eQnJR1T+hVSp1T2lYnlsXQMJxUVi/lImTCT8wFM3ElbRzG3GjxmOP8GfuC/Haqkb9d96LedwumjzH65xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712134223; c=relaxed/simple;
	bh=j6PVjnhEwFnTM08n6aItl3eHzcT4fMKyQysaXwS7MUI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=EfnsrhFeVLr2ou5PRHIPD2TDrgOzt4+30LJDk3PPqaYDQLFrKS5VnYiL0uSGhZub/AW1P8+NPJKhZ/7OJMmZIwXotUIfFlxnGKLLzJ+bGLZWP9H2jP7vBLA8c/fy549/RvoTp5SvuGzV6hIWg4eWVBQpPkhxTJMcTqM47knuYFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4V8djt1bSHz4f3kny;
	Wed,  3 Apr 2024 16:50:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B82B31A0568;
	Wed,  3 Apr 2024 16:50:16 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgD3Ew1HGA1mt0KtIw--.56654S2;
	Wed, 03 Apr 2024 16:50:16 +0800 (CST)
Subject: Re: [PATCH 6/6] writeback: remove unneeded GDTC_INIT_NO_WB
To: Jan Kara <jack@suse.cz>
Cc: Tejun Heo <tj@kernel.org>, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 willy@infradead.org, bfoster@redhat.com, dsterba@suse.com,
 mjguzik@gmail.com, dhowells@redhat.com, peterz@infradead.org
References: <20240320110222.6564-1-shikemeng@huaweicloud.com>
 <20240320110222.6564-7-shikemeng@huaweicloud.com>
 <Zfr9my_tfxO-N6HS@mtj.duckdns.org>
 <becdb16b-a318-ec05-61d2-d190541ae997@huaweicloud.com>
 <20240327093309.ejuzjus2zcixb4qt@quack3>
 <c2fc01e2-f15a-d331-6c4f-64319f3adc8a@huaweicloud.com>
 <20240402135306.kluke2jjcmh5f4ei@quack3>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <50663bca-3851-42bb-ef1d-5fee8fc7b9b6@huaweicloud.com>
Date: Wed, 3 Apr 2024 16:50:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240402135306.kluke2jjcmh5f4ei@quack3>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgD3Ew1HGA1mt0KtIw--.56654S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAw47Zw13Cw4fAw18Cr45KFg_yoW5ZFWfpF
	W3Xa1DKay5Ja4SqrnIgwn7Xa1rKrZ7t347X3s0kw4UArs5Krn7Krnrta1rCF17Ar1xXw1j
	vFW3tas7Za1UCFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW8JVW3JwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUOyCJDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 4/2/2024 9:53 PM, Jan Kara wrote:
> On Thu 28-03-24 09:49:59, Kemeng Shi wrote:
>> on 3/27/2024 5:33 PM, Jan Kara wrote:
>>> On Thu 21-03-24 15:12:21, Kemeng Shi wrote:
>>>>
>>>>
>>>> on 3/20/2024 11:15 PM, Tejun Heo wrote:
>>>>> Hello,
>>>>>
>>>>> On Wed, Mar 20, 2024 at 07:02:22PM +0800, Kemeng Shi wrote:
>>>>>> We never use gdtc->dom set with GDTC_INIT_NO_WB, just remove unneeded
>>>>>> GDTC_INIT_NO_WB
>>>>>>
>>>>>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>>>>> ...
>>>>>>  void global_dirty_limits(unsigned long *pbackground, unsigned long *pdirty)
>>>>>>  {
>>>>>> -	struct dirty_throttle_control gdtc = { GDTC_INIT_NO_WB };
>>>>>> +	struct dirty_throttle_control gdtc = { };
>>>>>
>>>>> Even if it's currently not referenced, wouldn't it still be better to always
>>>>> guarantee that a dtc's dom is always initialized? I'm not sure what we get
>>>>> by removing this.
>>>> As we explicitly use GDTC_INIT_NO_WB to set global_wb_domain before
>>>> calculating dirty limit with domain_dirty_limits, I intuitively think the
>>>> dirty limit calculation in domain_dirty_limits is related to
>>>> global_wb_domain when CONFIG_WRITEBACK_CGROUP is enabled while the truth
>>>> is not. So this is a little confusing to me.
>>>
>> Hi Jan,
>>> I'm not sure I understand your confusion. domain_dirty_limits() calculates
>>> the dirty limit (and background dirty limit) for the dirty_throttle_control
>>> passed in. If you pass dtc initialized with GDTC_INIT[_NO_WB], it will
>>> compute global dirty limits. If the dtc passed in is initialized with
>>> MDTC_INIT() it will compute cgroup specific dirty limits.
>> No doubt about this.
>>>
>>> Now because domain_dirty_limits() does not scale the limits based on each
>>> device throughput - that is done only later in __wb_calc_thresh() to avoid> relatively expensive computations when we don't need them - and also
>>> because the effective dirty limit (dtc->dom->dirty_limit) is not updated by
>>> domain_dirty_limits(), domain_dirty_limits() does not need dtc->dom at all.
>> Acutally, here is the thing confusing me. For wb_calc_thresh, we always pass
>> dtc initialized with a wb (GDTC_INIT(wb) or MDTC_INIT(wb,..). The dtc
>> initialized with _NO_WB is only passed to domain_dirty_limits. However, The
>> dom initialized by _NO_WB for domain_dirty_limits is not needed at all.
>>> But that is a technical detail of implementation and I don't want this
>>> technical detail to be relied on by even more code.
>> Yes, I agree with this. So I wonder if it's acceptable to simply define
>> GDTC_INIT_NO_WB to empty for now instead of remove defination of
>> GDTC_INIT_NO_WB. When implementation of domain_dirty_limits() or any
>> other low level function in future using GDTC_INIT(_NO_WB) changes to
>> need dtc->domain, we re-define GDTC_INIT_NO_WB to proper value.
>> As this only looks confusing to me. I will drop this one in next version
>> if you still prefer to keep definatino of GDTC_INIT_NO_WB in the old way.
> 
> Yeah, please keep the code as is for now. I agree this needs some cleanups
> but what you suggest is IMHO not an improvement.
Sure, will drop this in next version.

Thanks,
Kemeng
> 
> 								Honza
> 


