Return-Path: <linux-fsdevel+bounces-23362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D144D92B22F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 10:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005F21C22202
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 08:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFC6152E0F;
	Tue,  9 Jul 2024 08:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lXDguvEA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5B914290;
	Tue,  9 Jul 2024 08:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720513930; cv=none; b=L7IsHOKSZIsJdRU5jd/Md5k4pmo+8EiOTFRGFobBjmp5VF1nS0pcuDJiMOquK5qpWISM0Yiy+Fl7ERfauoRoYzzFHsTsb0wNSm/6ggN8bOslqCYYaTdQ8RgbafNt7dfdSRM8+gUpsjL68oYeeSNBu8H2Kd79qfnRVvaG2OT/yhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720513930; c=relaxed/simple;
	bh=EJdp+wJBv45BvCTyu+j+WgqZztpkq0r6Q35LEWnQ+/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vEdZ2nQGWXP+8U178HcXSPa7vQ63NX10zTiPP9GhOySHuvS5PlB3MxWts3m8mfTacgASaHnXBdHI3dE7m3DDwcczTq9++3xwi1brTY/rKVCeDLEWEoFsTFAIXE2WM4MBVNPPRxz01pcIF2mai1H5KWdoTOC2w2VauusJnFcEf3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lXDguvEA; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720513928; x=1752049928;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EJdp+wJBv45BvCTyu+j+WgqZztpkq0r6Q35LEWnQ+/Y=;
  b=lXDguvEAYrugz1Xq18QRiCJURws3WjIKUgZM9++LKflBHAEB1au1KxAi
   N+I7jdC1a91VAXgsg+zwXWK2BGeDr5LlnMyqAZrkBDEi1qpvqOCqDGte7
   QevVv/WXTRM/IWo8dyDxVdKZ4lG5HlB7xj3QPzg2oCYyc7tqQG8CqAvgu
   IVAXuyXslDyOfNx4CYzhAwC6A5WPm7iiR6qRC6I9zHsgGOk9ZMI7fN8gq
   LVToRH0j6rRtdwSUpddvDPKX04+Px4J9RkCqxayEsjgj/wN0oZjWOy451
   HKdqKXqsE/4vXlpTn8LVhVi4+EXLS5brg6/ilYeP73yyhPAEwdVG5SvXs
   w==;
X-CSE-ConnectionGUID: sGdDw2jQR4KBoCLRFr6orA==
X-CSE-MsgGUID: TrcWsZM6Ttmsa2uKLAwtEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17885174"
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="17885174"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 01:32:08 -0700
X-CSE-ConnectionGUID: BY32i6+ySUWWKjgq2aq9/g==
X-CSE-MsgGUID: eYpp1U4HSWCON/8IkLQWvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="47760888"
Received: from yma27-mobl.ccr.corp.intel.com (HELO [10.124.248.81]) ([10.124.248.81])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 01:32:03 -0700
Message-ID: <1296ef8d-dade-46e5-8571-e7dba158f405@intel.com>
Date: Tue, 9 Jul 2024 16:32:01 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] fs/file.c: add fast path in find_next_fd()
To: Jan Kara <jack@suse.cz>, Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, edumazet@google.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 pan.deng@intel.com, tianyou.li@intel.com, tim.c.chen@intel.com,
 tim.c.chen@linux.intel.com, yu.ma@intel.com
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240703143311.2184454-1-yu.ma@intel.com>
 <20240703143311.2184454-4-yu.ma@intel.com>
 <CAGudoHH_P4LGaVN1N4j8FNTH_eDm3SDL7azMc25+HY2_XgjvJQ@mail.gmail.com>
 <20240704215507.mr6st2d423lvkepu@quack3>
 <3c7a0cd7-1dd2-4762-a2dd-67e6b6a82df7@intel.com>
From: "Ma, Yu" <yu.ma@intel.com>
Content-Language: en-US
In-Reply-To: <3c7a0cd7-1dd2-4762-a2dd-67e6b6a82df7@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/5/2024 3:56 PM, Ma, Yu wrote:
> I had something like this in mind:
>>> diff --git a/fs/file.c b/fs/file.c
>>> index a3b72aa64f11..4d3307e39db7 100644
>>> --- a/fs/file.c
>>> +++ b/fs/file.c
>>> @@ -489,6 +489,16 @@ static unsigned int find_next_fd(struct fdtable
>>> *fdt, unsigned int start)
>>>          unsigned int maxfd = fdt->max_fds; /* always multiple of
>>> BITS_PER_LONG */
>>>          unsigned int maxbit = maxfd / BITS_PER_LONG;
>>>          unsigned int bitbit = start / BITS_PER_LONG;
>>> +       unsigned int bit;
>>> +
>>> +       /*
>>> +        * Try to avoid looking at the second level map.
>>> +        */
>>> +       bit = find_next_zero_bit(&fdt->open_fds[bitbit], BITS_PER_LONG,
>>> +                               start & (BITS_PER_LONG - 1));
>>> +       if (bit < BITS_PER_LONG) {
>>> +               return bit + bitbit * BITS_PER_LONG;
>>> +       }
>> Drat, you're right. I missed that Ma did not add the proper offset to
>> open_fds. *This* is what I meant :)
>>
>>                                 Honza
>
> Just tried this on v6.10-rc6, the improvement on top of patch 1 and 
> patch 2 is 7% for read and 3% for write, less than just check first word.
>
> Per my understanding, its performance would be better if we can find 
> free bit in the same word of next_fd with high possibility, but 
> next_fd just represents the lowest possible free bit. If fds are 
> open/close frequently and randomly, that might not always be the case, 
> next_fd may be distributed randomly, for example, 0-65 are occupied, 
> fd=3 is returned, next_fd will be set to 3, next time when 3 is 
> allocated, next_fd will be set to 4, while the actual first free bit 
> is 66 , when 66 is allocated, and fd=5 is returned, then the above 
> process would be went through again.
>
> Yu
>
Hi Guzik, Honza,

Do we have any more comment or idea regarding to the fast path? Thanks 
for your time and any feedback :)


Regards

Yu


