Return-Path: <linux-fsdevel+bounces-23558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D8E92E36E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 11:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46E2F1C21BD0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 09:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF88155C95;
	Thu, 11 Jul 2024 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xloc13dx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517F714039D;
	Thu, 11 Jul 2024 09:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720690163; cv=none; b=g566OY8TFStyAnu+kRD8+5akEtEO5ppDZdBbTMFHwI5VJbLxr2A1JHivnIjIWwSJq/WyrpEeNXNsTZFgnPC2GnbPKhRY3TVCXuZPiO2+sieG9FMlGdBAjLXJr00cJ0ZHd9VnNPXxeAn7TrpzRe+ApuovZHyfwI73O0e1/fRhNNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720690163; c=relaxed/simple;
	bh=Ez45eI0vWZmvYDv9iC2voRpQwzU9akAGjvrbYSvICJ8=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:Cc:
	 In-Reply-To:Content-Type; b=R0eJCZLfbhoCb0jtJYLsuNDF/Do4s1T2HN75RWczu0rEtLypsgwmAVtI6aVtqahT6uZouHVNnkFi0HFA2r2+c97mg4yLl8tYXjzdy+G7qi1zmX+pyRQNrMWmXwUCGDJW1JvpZi+hc+E8ZNhuNi1Ed+zt3a9OItk7Vj2TtcJ7Y3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xloc13dx; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720690162; x=1752226162;
  h=message-id:date:mime-version:subject:references:from:to:
   cc:in-reply-to:content-transfer-encoding;
  bh=Ez45eI0vWZmvYDv9iC2voRpQwzU9akAGjvrbYSvICJ8=;
  b=Xloc13dxLBB1+dcn4LwCxFuctjADzNY2rui35z1rpN8UOAtN9qHSE48f
   et53Aocl7V4/pikNSFQX3GcMIvXoq500HXmmNRWMCxZcsYoQeNWUjqe/B
   FSHopbtBIFXBUaHr00DENjswUOHR9rE/yd8xClh/vkfQKCFVgNVc7D+zI
   l0H/5EFvLxszkvaj0dCJ3wounWVtQKaYbZ9iyzYXKQd5uyPQCCaprdeYD
   5XZhMv90xz9psKXXxRCFtwFMvymVJcScCRaomG1ywESPMyo7SVNFxhlr8
   VBu+NjrFQMxEETbXU6Oqeoe4dPNlzJ2IUbsek/C7wZsDCBmE3ZKGujNOP
   Q==;
X-CSE-ConnectionGUID: /+hLMd5jRvOvTNmkhwqJiA==
X-CSE-MsgGUID: 20OVsiXAQ56h53cp0UaGLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="28651643"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="28651643"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 02:29:21 -0700
X-CSE-ConnectionGUID: 83SxTHjcTcOl5ltQZdRcwg==
X-CSE-MsgGUID: 0ikLMkX/Q1+3583xpKwHng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="48397425"
Received: from yma27-mobl.ccr.corp.intel.com (HELO [10.124.229.108]) ([10.124.229.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 02:29:17 -0700
Message-ID: <eb2808fe-6f11-4bc2-8931-fcd8bd89600a@intel.com>
Date: Thu, 11 Jul 2024 17:27:42 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] fs/file.c: add fast path in find_next_fd()
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240703143311.2184454-1-yu.ma@intel.com>
 <20240703143311.2184454-4-yu.ma@intel.com>
 <CAGudoHH_P4LGaVN1N4j8FNTH_eDm3SDL7azMc25+HY2_XgjvJQ@mail.gmail.com>
 <20240704215507.mr6st2d423lvkepu@quack3>
 <3c7a0cd7-1dd2-4762-a2dd-67e6b6a82df7@intel.com>
 <1296ef8d-dade-46e5-8571-e7dba158f405@intel.com>
 <CAGudoHGJrRi_UZ2wv2dG9U9VGasHW203O4nQHkE9KkaWJJ61WQ@mail.gmail.com>
 <0b928778df827f7ea948931c3358616c8e7f26f7.camel@linux.intel.com>
From: "Ma, Yu" <yu.ma@intel.com>
Content-Language: en-US
To: Tim Chen <tim.c.chen@linux.intel.com>, Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk, brauner@kernel.org,
 edumazet@google.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, pan.deng@intel.com, tianyou.li@intel.com,
 tim.c.chen@intel.com, yu.ma@intel.com
In-Reply-To: <0b928778df827f7ea948931c3358616c8e7f26f7.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/11/2024 7:40 AM, Tim Chen wrote:
> On Tue, 2024-07-09 at 12:17 +0200, Mateusz Guzik wrote:
>> Right, forgot to respond.
>>
>> I suspect the different result is either because of mere variance
>> between reboots or blogbench using significantly less than 100 fds at
>> any given time -- I don't have an easy way to test at your scale at
>> the moment. You could probably test that by benching both approaches
>> while switching them at runtime with a static_branch. However, I don't
>> know if that effort is warranted atm.
>>
>> So happens I'm busy with other stuff and it is not my call to either
>> block or let this in, so I'm buggering off.
>>
>> On Tue, Jul 9, 2024 at 10:32 AM Ma, Yu <yu.ma@intel.com> wrote:
>>>
>>> On 7/5/2024 3:56 PM, Ma, Yu wrote:
>>>> I had something like this in mind:
>>>>>> diff --git a/fs/file.c b/fs/file.c
>>>>>> index a3b72aa64f11..4d3307e39db7 100644
>>>>>> --- a/fs/file.c
>>>>>> +++ b/fs/file.c
>>>>>> @@ -489,6 +489,16 @@ static unsigned int find_next_fd(struct fdtable
>>>>>> *fdt, unsigned int start)
>>>>>>           unsigned int maxfd = fdt->max_fds; /* always multiple of
>>>>>> BITS_PER_LONG */
>>>>>>           unsigned int maxbit = maxfd / BITS_PER_LONG;
>>>>>>           unsigned int bitbit = start / BITS_PER_LONG;
>>>>>> +       unsigned int bit;
>>>>>> +
>>>>>> +       /*
>>>>>> +        * Try to avoid looking at the second level map.
>>>>>> +        */
>>>>>> +       bit = find_next_zero_bit(&fdt->open_fds[bitbit], BITS_PER_LONG,
>>>>>> +                               start & (BITS_PER_LONG - 1));
>>>>>> +       if (bit < BITS_PER_LONG) {
>>>>>> +               return bit + bitbit * BITS_PER_LONG;
>>>>>> +       }
> I think this approach based on next_fd quick check is more generic and scalable.
>
> It just happen for blogbench, just checking the first 64 bit allow a quicker
> skip to the two level search where this approach, next_fd may be left
> in a 64 word that actually has no open bits and we are doing useless search
> in find_next_zero_bit(). Perhaps we should check full_fds_bits to make sure
> there are empty slots before we do
> find_next_zero_bit() fast path.  Something like
>
> 	if (!test_bit(bitbit, fdt->full_fds_bits)) {
> 		bit = find_next_zero_bit(&fdt->open_fds[bitbit], BITS_PER_LONG,
> 					start & (BITS_PER_LONG - 1));
> 		if (bit < BITS_PER_LONG)
> 			return bit + bitbit * BITS_PER_LONG;
> 	}
> Tim

Yes, agree that it scales better, I'll update v4 with fast path for the 
word contains next_fd and send out for review soon

>>>>> Drat, you're right. I missed that Ma did not add the proper offset to
>>>>> open_fds. *This* is what I meant :)
>>>>>
>>>>>                                  Honza
>>>> Just tried this on v6.10-rc6, the improvement on top of patch 1 and
>>>> patch 2 is 7% for read and 3% for write, less than just check first word.
>>>>
>>>> Per my understanding, its performance would be better if we can find
>>>> free bit in the same word of next_fd with high possibility, but
>>>> next_fd just represents the lowest possible free bit. If fds are
>>>> open/close frequently and randomly, that might not always be the case,
>>>> next_fd may be distributed randomly, for example, 0-65 are occupied,
>>>> fd=3 is returned, next_fd will be set to 3, next time when 3 is
>>>> allocated, next_fd will be set to 4, while the actual first free bit
>>>> is 66 , when 66 is allocated, and fd=5 is returned, then the above
>>>> process would be went through again.
>>>>
>>>> Yu
>>>>
>>> Hi Guzik, Honza,
>>>
>>> Do we have any more comment or idea regarding to the fast path? Thanks
>>> for your time and any feedback :)
>>>
>>>
>>> Regards
>>>
>>> Yu
>>>
>>

