Return-Path: <linux-fsdevel+bounces-21933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7023090F4DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 19:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CDF5B222E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 17:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3190E155A23;
	Wed, 19 Jun 2024 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FclR8giC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03211C3E;
	Wed, 19 Jun 2024 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718816999; cv=none; b=JNmEWPqvTKNSxz8vMw8I47SMQSvUnPAXTuYzh/6JRX4pKzaOno9JwdpqwMAZwBgIikckanI8TPrzmwUL2Ih/GoPwMftnHlTrhISai4kxOXWipv6M9YxFFLvJe+43O72islX0nSjrPoSf/pLAip2Wq0AYDlwFcArK7l3ooi8kbiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718816999; c=relaxed/simple;
	bh=zwhIa2Tzx0+wGQlJWCxens0OIx8tCG7Ay9QzvVgv0/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJBZWrYHA3FcIBdT9R9Zd3k94fsDdxW1X7e3EN/vhMH3hHdHLpOmnofA+k2UeJ/1gYh/TInHopNsR4noepUFprpBeKMH1j1cxYOoEVL/NIaWG0OErjq7qfb853Qlvl4UumQUqKu3Fm7c4WAToXOs7Ujx02BgO00yMjG05wLRV5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FclR8giC; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718816998; x=1750352998;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zwhIa2Tzx0+wGQlJWCxens0OIx8tCG7Ay9QzvVgv0/w=;
  b=FclR8giC7cesWPY81GwHEQf/OURVrWzTA1N6z/t3p4pRZyzfUJAz1v7Y
   9yUGJnzIHrV62hFNN2wYkyHPxgPrS85CiROgbUv9zdAMcyH7kCnzKuyhv
   L6qd6wG0OOc7mxf8lN5oljlOLdfoIla45F7p3xTFwx7EP1FRnhL8/+Int
   PUAbzHHZKPvkC/m4P0Z3HBnRLXvumTvA0XK43pLiT0YzdI1XqjB8bqY4j
   dvrEqF7AJr74xyd0ybhgFXcKFFBMpgupYPBn3s9cwn5bYceqA18e7KFuT
   40kLdZQW/tf3rR2vy0OZCsKrqu8aUTOZLD1KUfJaV2DP0yAwPDikabbyW
   g==;
X-CSE-ConnectionGUID: a3yEfC/4TR2hM+PZzWuH5w==
X-CSE-MsgGUID: v6pNowWUQtGN6C2mwdIdew==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15745076"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="15745076"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 10:09:57 -0700
X-CSE-ConnectionGUID: 2inXw1JhRji7XLO7A2TBNQ==
X-CSE-MsgGUID: 6J6WLotvRZmkXvEH4ta9Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="46350976"
Received: from junlanba-mobl.ccr.corp.intel.com (HELO [10.124.229.108]) ([10.124.229.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 10:09:52 -0700
Message-ID: <aa0f9982-d88a-4613-8d96-41abb6905c06@intel.com>
Date: Thu, 20 Jun 2024 01:09:47 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RE: [PATCH 1/3] fs/file.c: add fast path in alloc_fd()
To: David Laight <David.Laight@ACULAB.COM>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "brauner@kernel.org" <brauner@kernel.org>, "jack@suse.cz" <jack@suse.cz>,
 Mateusz Guzik <mjguzik@gmail.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
 "tim.c.chen@intel.com" <tim.c.chen@intel.com>,
 "pan.deng@intel.com" <pan.deng@intel.com>,
 "tianyou.li@intel.com" <tianyou.li@intel.com>, yu.ma@intel.com
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240614163416.728752-2-yu.ma@intel.com>
 <218ccf06e7104eb580023fb69c395d3e@AcuMS.aculab.com>
From: "Ma, Yu" <yu.ma@intel.com>
Content-Language: en-US
In-Reply-To: <218ccf06e7104eb580023fb69c395d3e@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/19/2024 6:36 PM, David Laight wrote:
> From: Yu Ma <yu.ma@intel.com>
>> Sent: 14 June 2024 17:34
>>
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
>> With the fast path added in alloc_fd() through one-time bitmap searching,
>> pts/blogbench-1.1.0 read is improved by 20% and write by 10% on Intel ICX 160
>> cores configuration with v6.8-rc6.
>>
>> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
>> Signed-off-by: Yu Ma <yu.ma@intel.com>
>> ---
>>   fs/file.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/file.c b/fs/file.c
>> index 3b683b9101d8..e8d2f9ef7fd1 100644
>> --- a/fs/file.c
>> +++ b/fs/file.c
>> @@ -510,8 +510,13 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
>>   	if (fd < files->next_fd)
>>   		fd = files->next_fd;
>>
>> -	if (fd < fdt->max_fds)
>> +	if (fd < fdt->max_fds) {
>> +		if (~fdt->open_fds[0]) {
>> +			fd = find_next_zero_bit(fdt->open_fds, BITS_PER_LONG, fd);
>> +			goto success;
>> +		}
>>   		fd = find_next_fd(fdt, fd);
>> +	}
> Hmm...
> How well does that work when the initial fd is > 64?
>
> Since there is exactly one call to find_next_fd() and it is static and should
> be inlined doesn't this optimisation belong inside find_next_fd().
>
> Plausibly find_next_fd() just needs rewriting.
The consideration for this fast path is as stated in commit, for 
scenarios like fd>64, it means that fast path already worked in the 
first 64 bits for fast return and all other times when any fd<64 gets 
recycled and then allocated. For some cases like a process opened more 
than 64 fds and kept occupied, the extra cost would be a conditional 
statement which can be benefit from branch prediction, as Guzik 
suggests, we'll copy Eric for benchmark to check the effect if it is 
available.  For the code, it's more efficient to be here outside of 
find_next_fd() for jumping to fast return. Besides, identified by Guzik, 
find_next_fd() itself could be improved with inlined calls inside for 
better performance, story for another patch :)
>
> Or, possibly. even inside an inlinable copy of find_next_zero-bit()
> (although a lot of callers won't be 'hot' enough for the inlined bloat
> being worth while).
As mentioned, current find_next_zero_bit() already has a fast path 
inside to handle the searching size <= 64, and it has been utilized here 
for fast return.
>
> 	David
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>

