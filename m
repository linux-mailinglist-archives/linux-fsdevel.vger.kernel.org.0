Return-Path: <linux-fsdevel+bounces-23138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4C192794A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 16:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2590F1F212F7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 14:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FAB1B11E9;
	Thu,  4 Jul 2024 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i6zKCv/8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581D61AED39;
	Thu,  4 Jul 2024 14:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720104668; cv=none; b=RbG8Qp6Mre4/m64FfuTmrggnyBHmGo79s3TZBjizUELH3T/u2vAYNlbZCjGBGILLTluwlXZ8L42LPNYtrVTvrK2KsG5zuWU48Qr+7axfKBRvEz8WmgVYopESXrbaioOA2MlM6xwcS+VGFj5HRMjxYQX6XKAvqIvHHIfL5YoSIZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720104668; c=relaxed/simple;
	bh=4aIUzlaYQvG/VJsbxJG3Am5fN0bAnSPXlEFqrWm1hMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RTMmSo6C+LNUVWt1WaZEQKjFid9K8zGYWODQUiB4CCBGb6gA9JAh1UX2KV3fVe3hvyMlNy8CSLZyR5te9KHd3S+iDPB6UFDhcm0Nn8uohiawWPdm2Ltm2PCzxZeVohLakOuGSvLOpnV6jYTuRdo2n9ZIOqyvl5vuBP5g0fZcTG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i6zKCv/8; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720104667; x=1751640667;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4aIUzlaYQvG/VJsbxJG3Am5fN0bAnSPXlEFqrWm1hMA=;
  b=i6zKCv/8/qHVKJ7izBHGSTCBLuss47oi9AAC0tQ4l3ilXWovbW7CZL5y
   +4F/Jq56FB1+j6o8NtsklJ2edJot2HIDc0taLO9QjxV0rmsW258PC4LuQ
   cgf/Fahjvwh2MU7tTOdXZAVah3GCNUx8B7jjrG2opHNdDWvPFyO7YcUDw
   N5926wwkeleJfg7qs6Fr/B7bfj/6nADxzH/acZ4a1DZdM03RNeAY0/yRu
   +HmT890XW1txu15TOiNL48Bc9bx4ZUm5GPfIdbcyRG+/Wbh/lAklc5Ctb
   3VKh2lS0/HsfCojsKiqegZq9C8jEOlVsna6fnTmxjyhJiUb9CiYKVW/NI
   Q==;
X-CSE-ConnectionGUID: zqb8u2NQRjC9DbaRJF35Mw==
X-CSE-MsgGUID: l27g2O8zTVWDRzoGOGFXvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="17526102"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17526102"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 07:51:07 -0700
X-CSE-ConnectionGUID: rx0Hi2IJT/atYiwvVcFlLg==
X-CSE-MsgGUID: NLwy62dwQWW2WRWUlzaIzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="46557546"
Received: from yma27-mobl.ccr.corp.intel.com (HELO [10.124.248.81]) ([10.124.248.81])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 07:51:01 -0700
Message-ID: <e7718d5c-e160-4850-b980-3c8c227159a5@intel.com>
Date: Thu, 4 Jul 2024 22:50:58 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] fs/file.c: add fast path in find_next_fd()
To: Jan Kara <jack@suse.cz>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, mjguzik@gmail.com,
 edumazet@google.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, pan.deng@intel.com, tianyou.li@intel.com,
 tim.c.chen@intel.com, tim.c.chen@linux.intel.com, yu.ma@intel.com
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240703143311.2184454-1-yu.ma@intel.com>
 <20240703143311.2184454-4-yu.ma@intel.com>
 <20240704100308.6hczzyqhmpty4avx@quack3>
Content-Language: en-US
From: "Ma, Yu" <yu.ma@intel.com>
In-Reply-To: <20240704100308.6hczzyqhmpty4avx@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/4/2024 6:03 PM, Jan Kara wrote:
> On Wed 03-07-24 10:33:11, Yu Ma wrote:
>> There is available fd in the lower 64 bits of open_fds bitmap for most cases
>> when we look for an available fd slot. Skip 2-levels searching via
>> find_next_zero_bit() for this common fast path.
>>
>> Look directly for an open bit in the lower 64 bits of open_fds bitmap when a
>> free slot is available there, as:
>> (1) The fd allocation algorithm would always allocate fd from small to large.
>> Lower bits in open_fds bitmap would be used much more frequently than higher
>> bits.
>> (2) After fdt is expanded (the bitmap size doubled for each time of expansion),
>> it would never be shrunk. The search size increases but there are few open fds
>> available here.
>> (3) There is fast path inside of find_next_zero_bit() when size<=64 to speed up
>> searching.
>>
>> As suggested by Mateusz Guzik <mjguzik gmail.com> and Jan Kara <jack@suse.cz>,
>> update the fast path from alloc_fd() to find_next_fd(). With which, on top of
>> patch 1 and 2, pts/blogbench-1.1.0 read is improved by 13% and write by 7% on
>> Intel ICX 160 cores configuration with v6.10-rc6.
>>
>> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
>> Signed-off-by: Yu Ma <yu.ma@intel.com>
> Nice! The patch looks good to me. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> One style nit below:
>
>> diff --git a/fs/file.c b/fs/file.c
>> index a15317db3119..f25eca311f51 100644
>> --- a/fs/file.c
>> +++ b/fs/file.c
>> @@ -488,6 +488,11 @@ struct files_struct init_files = {
>>   
>>   static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
>>   {
>> +	unsigned int bit;
> Empty line here please to separate variable declaration and code...

Thanks Honza, copy that :)

>
>> +	bit = find_next_zero_bit(fdt->open_fds, BITS_PER_LONG, start);
>> +	if (bit < BITS_PER_LONG)
>> +		return bit;
>> +
>>   	unsigned int maxfd = fdt->max_fds; /* always multiple of BITS_PER_LONG */
>>   	unsigned int maxbit = maxfd / BITS_PER_LONG;
>>   	unsigned int bitbit = start / BITS_PER_LONG;
> 									Honza

