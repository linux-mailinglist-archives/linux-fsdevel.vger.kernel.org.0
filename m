Return-Path: <linux-fsdevel+bounces-23186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B322928345
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 09:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AC731F24F87
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 07:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B5F14532A;
	Fri,  5 Jul 2024 07:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JMxsYB3s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9AB1C6A0;
	Fri,  5 Jul 2024 07:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720166219; cv=none; b=cNuPZ3MxC3JUk+FELZ1Lp6hdZDA1zJiKPr5ZLA+YuOrnq5ufu9NGyxjMSBxIUlWLNqpGEwbvh0kPiUmrxdFB5+SAo+9a1Mmo7Y17WG/F5MD2HE6xdEhgQ8+LA1nWMazW/C1yNjibo5yDgpkZddOK0O2NvRh8d7u7SxgwU8spH40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720166219; c=relaxed/simple;
	bh=hCvfg0zvvZqrmaaLkvO3aWMBzPwR0Yr7Ge+MkJRbztk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K5+2x/4mNcW8Tti0UZroRJFFGaie6hiP2XCkpnj7ypxj+tReah5jHUkklg0APTQGR1XCZF8V/QuWQowojSusjB6Mzjjlsz5ZBwGX1ZV/GpbMwAAJqi/6v+zTytDlxNB/qeXiSmclc31Tyk3TNyl/47/TexRMDZQOmeBAs1U5Tlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JMxsYB3s; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720166217; x=1751702217;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hCvfg0zvvZqrmaaLkvO3aWMBzPwR0Yr7Ge+MkJRbztk=;
  b=JMxsYB3sBzem8k9GpyKFwjhCGpRO+cMSv4MYbpC1xeN2VmjDHZlZdXhC
   RijIBWJXrwkhkTRWKy7lqWYOlCiuIWwcaQQfpePJCkLAEnpCkvmR+279U
   sRuudD1hAj+rmvBsDuw4zAhAohiTmsAvgCIE/cciOr7NOgbddSwa9Gms9
   otQhK7zdkc2PvlRU6tSfF6wDeZGGNMEwQPxowBUu0DCWtJf7xRU6GFaYA
   XNJZG3CmSkPcHDinp6o1DDf96HO/zgszmv21Aj+DLISkuJLxw4D0+hm4/
   3lbBmDQRo7FakUQ7rEgl+dpzKTIPAXZxbQrOkXyhd1dYeaRYGzxtT1e9B
   A==;
X-CSE-ConnectionGUID: G6//7+K5TWaZrnUmy7R4AQ==
X-CSE-MsgGUID: ogo6IoEHQFe1TWVOyiiing==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="34893143"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="34893143"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 00:56:57 -0700
X-CSE-ConnectionGUID: 6BUlqzXfQTWVg7bBz2ZclA==
X-CSE-MsgGUID: XrOYx2nvQeytygsZxIGmiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="46705592"
Received: from unknown (HELO [10.238.4.224]) ([10.238.4.224])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 00:56:54 -0700
Message-ID: <3c7a0cd7-1dd2-4762-a2dd-67e6b6a82df7@intel.com>
Date: Fri, 5 Jul 2024 15:56:52 +0800
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
From: "Ma, Yu" <yu.ma@intel.com>
Content-Language: en-US
In-Reply-To: <20240704215507.mr6st2d423lvkepu@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/5/2024 5:55 AM, Jan Kara wrote:
> On Thu 04-07-24 19:44:10, Mateusz Guzik wrote:
>> On Wed, Jul 3, 2024 at 4:07 PM Yu Ma <yu.ma@intel.com> wrote:
>>> There is available fd in the lower 64 bits of open_fds bitmap for most cases
>>> when we look for an available fd slot. Skip 2-levels searching via
>>> find_next_zero_bit() for this common fast path.
>>>
>>> Look directly for an open bit in the lower 64 bits of open_fds bitmap when a
>>> free slot is available there, as:
>>> (1) The fd allocation algorithm would always allocate fd from small to large.
>>> Lower bits in open_fds bitmap would be used much more frequently than higher
>>> bits.
>>> (2) After fdt is expanded (the bitmap size doubled for each time of expansion),
>>> it would never be shrunk. The search size increases but there are few open fds
>>> available here.
>>> (3) There is fast path inside of find_next_zero_bit() when size<=64 to speed up
>>> searching.
>>>
>>> As suggested by Mateusz Guzik <mjguzik gmail.com> and Jan Kara <jack@suse.cz>,
>>> update the fast path from alloc_fd() to find_next_fd(). With which, on top of
>>> patch 1 and 2, pts/blogbench-1.1.0 read is improved by 13% and write by 7% on
>>> Intel ICX 160 cores configuration with v6.10-rc6.
>>>
>>> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
>>> Signed-off-by: Yu Ma <yu.ma@intel.com>
>>> ---
>>>   fs/file.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/fs/file.c b/fs/file.c
>>> index a15317db3119..f25eca311f51 100644
>>> --- a/fs/file.c
>>> +++ b/fs/file.c
>>> @@ -488,6 +488,11 @@ struct files_struct init_files = {
>>>
>>>   static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
>>>   {
>>> +       unsigned int bit;
>>> +       bit = find_next_zero_bit(fdt->open_fds, BITS_PER_LONG, start);
>>> +       if (bit < BITS_PER_LONG)
>>> +               return bit;
>>> +
>>>          unsigned int maxfd = fdt->max_fds; /* always multiple of BITS_PER_LONG */
>>>          unsigned int maxbit = maxfd / BITS_PER_LONG;
>>>          unsigned int bitbit = start / BITS_PER_LONG;
>>> --
>>> 2.43.0
>>>
>> I had something like this in mind:
>> diff --git a/fs/file.c b/fs/file.c
>> index a3b72aa64f11..4d3307e39db7 100644
>> --- a/fs/file.c
>> +++ b/fs/file.c
>> @@ -489,6 +489,16 @@ static unsigned int find_next_fd(struct fdtable
>> *fdt, unsigned int start)
>>          unsigned int maxfd = fdt->max_fds; /* always multiple of
>> BITS_PER_LONG */
>>          unsigned int maxbit = maxfd / BITS_PER_LONG;
>>          unsigned int bitbit = start / BITS_PER_LONG;
>> +       unsigned int bit;
>> +
>> +       /*
>> +        * Try to avoid looking at the second level map.
>> +        */
>> +       bit = find_next_zero_bit(&fdt->open_fds[bitbit], BITS_PER_LONG,
>> +                               start & (BITS_PER_LONG - 1));
>> +       if (bit < BITS_PER_LONG) {
>> +               return bit + bitbit * BITS_PER_LONG;
>> +       }
> Drat, you're right. I missed that Ma did not add the proper offset to
> open_fds. *This* is what I meant :)
>
> 								Honza

Just tried this on v6.10-rc6, the improvement on top of patch 1 and 
patch 2 is 7% for read and 3% for write, less than just check first word.

Per my understanding, its performance would be better if we can find 
free bit in the same word of next_fd with high possibility, but next_fd 
just represents the lowest possible free bit. If fds are open/close 
frequently and randomly, that might not always be the case, next_fd may 
be distributed randomly, for example, 0-65 are occupied, fd=3 is 
returned, next_fd will be set to 3, next time when 3 is allocated, 
next_fd will be set to 4, while the actual first free bit is 66 , when 
66 is allocated, and fd=5 is returned, then the above process would be 
went through again.

Yu


