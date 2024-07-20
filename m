Return-Path: <linux-fsdevel+bounces-24039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FE6938162
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jul 2024 14:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 319CC281AF9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jul 2024 12:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AF712E1E0;
	Sat, 20 Jul 2024 12:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c2PHlcKe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565E53211;
	Sat, 20 Jul 2024 12:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721480235; cv=none; b=uxSv0utn+Kp/pa7HGl7Pnxgf4/snFqCTSJTcPMTXKHkz2dC6gssKrvecVX+r0j7tS2AS7leIBV6EFR3qHgwY2an9zQBD6kifsUaqJE7bL6PDEYrt81Zy5xhNOcay9p2XEADBEJ/YEdiw4lDP46a23jaqgK2Nxi8FXrtF3Wlgwec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721480235; c=relaxed/simple;
	bh=QwEtKFRATlp+e1LcTO7aIl4RD58sCciZspqxiFvD23s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QIKkxhrYeoe30zCvf3hkHatleEoyMwoCsBUZqFOsY1hH0NhNmWzAL7C8GhXp6G+sGhd305PSZ/KrX/H8QlPmj/SvICPBF3Z3tsGqYWzN16ILxd71ifMnRFXqHyoBzprLHnMtcikZB+jgrBhdz77aSE9owchL7KEGGzIcxb3K8Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c2PHlcKe; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721480233; x=1753016233;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QwEtKFRATlp+e1LcTO7aIl4RD58sCciZspqxiFvD23s=;
  b=c2PHlcKe7/ffg2Kv5JyMxqek2Cu7OU4hrGKQX5v2wu72TtsNyFLYilOq
   TqG+VFLL/FpNZVC/cZlj/0mCQOhuzYPlgnTaKAicrys/uEckYLdmLveKH
   CH9txogR3lj6yf/OAYU8G8NgGWzKwaXzYUJeX5Bo1YkeRg86R5r8PVpqw
   JQeIzEm4d6qYGkBfKxx26366ASXzxa/LtrtXrT12dtGn6ZoEf12wFgj+9
   Eil0+qe/IBjf3Ov3uCs8fsgsHV/MzRd2cyk4kHel8WDvhZO38AGHgBGNz
   Q4a3kbgaoKquft1nYaLYppTLQoinzWJG7pkQmYPek6OtSqEN59EwaPvPt
   g==;
X-CSE-ConnectionGUID: yo3GPYKcS7OOIyOwkIW0zg==
X-CSE-MsgGUID: BVDGKOUISFSYcfj1j2xpZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11139"; a="30485691"
X-IronPort-AV: E=Sophos;i="6.09,223,1716274800"; 
   d="scan'208";a="30485691"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2024 05:57:13 -0700
X-CSE-ConnectionGUID: wzXV+QDSQOmuD+lW9pWbwQ==
X-CSE-MsgGUID: X1buisiQScCvH+2eHfbpjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,223,1716274800"; 
   d="scan'208";a="51458615"
Received: from wenjun3x-mobl1.ccr.corp.intel.com (HELO [10.124.232.196]) ([10.124.232.196])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2024 05:57:09 -0700
Message-ID: <2365dcaf-95d4-462b-9614-83ee9f7c12f6@intel.com>
Date: Sat, 20 Jul 2024 20:57:07 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] fs/file.c: add fast path in find_next_fd()
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, edumazet@google.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 pan.deng@intel.com, tianyou.li@intel.com, tim.c.chen@intel.com,
 tim.c.chen@linux.intel.com, viro@zeniv.linux.org.uk, yu.ma@intel.com
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240717145018.3972922-1-yu.ma@intel.com>
 <20240717145018.3972922-4-yu.ma@intel.com>
 <CAGudoHHQSjbeuSevyL=W=fhjOOo=bCjq4ixHfEMN_XdRLLdPbQ@mail.gmail.com>
From: "Ma, Yu" <yu.ma@intel.com>
Content-Language: en-US
In-Reply-To: <CAGudoHHQSjbeuSevyL=W=fhjOOo=bCjq4ixHfEMN_XdRLLdPbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/20/2024 1:53 AM, Mateusz Guzik wrote:
> On Wed, Jul 17, 2024 at 4:24 PM Yu Ma <yu.ma@intel.com> wrote:
>> Skip 2-levels searching via find_next_zero_bit() when there is free slot in the
>> word contains next_fd, as:
>> (1) next_fd indicates the lower bound for the first free fd.
>> (2) There is fast path inside of find_next_zero_bit() when size<=64 to speed up
>> searching.
> this is stale -- now the fast path searches up to 64 fds in the lower bitmap

Nope, this is still valid, as the searching size of the fast path inside 
of find_next_fd() is always 64, it will execute the fast path inside of 
find_next_zero_bit().


>
>> (3) After fdt is expanded (the bitmap size doubled for each time of expansion),
>> it would never be shrunk. The search size increases but there are few open fds
>> available here.
>>
>> This fast path is proposed by Mateusz Guzik <mjguzik@gmail.com>, and agreed by
>> Jan Kara <jack@suse.cz>, which is more generic and scalable than previous
>> versions.
> I think this paragraph is droppable. You already got an ack from Jan
> below, so stating he agrees with the patch is redundant. As for me I
> don't think this warrants mentioning. Just remove it, perhaps
> Christian will be willing to massage it by himself to avoid another
> series posting.

The idea of fast path for the word contains next_fd is from you, 
although this patch is small, I think it is reasonable to record here 
out of my respect. Appreciate for your guide and comments on this patch, 
I've learned a lot on the way of resolving problems :)


Regards

Yu

>> And on top of patch 1 and 2, it improves pts/blogbench-1.1.0 read by
>> 8% and write by 4% on Intel ICX 160 cores configuration with v6.10-rc7.
>>
>> Reviewed-by: Jan Kara <jack@suse.cz>
>> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
>> Signed-off-by: Yu Ma <yu.ma@intel.com>
>> ---
>>   fs/file.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/fs/file.c b/fs/file.c
>> index 1be2a5bcc7c4..729c07a4fc28 100644
>> --- a/fs/file.c
>> +++ b/fs/file.c
>> @@ -491,6 +491,15 @@ static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
>>          unsigned int maxfd = fdt->max_fds; /* always multiple of BITS_PER_LONG */
>>          unsigned int maxbit = maxfd / BITS_PER_LONG;
>>          unsigned int bitbit = start / BITS_PER_LONG;
>> +       unsigned int bit;
>> +
>> +       /*
>> +        * Try to avoid looking at the second level bitmap
>> +        */
>> +       bit = find_next_zero_bit(&fdt->open_fds[bitbit], BITS_PER_LONG,
>> +                                start & (BITS_PER_LONG - 1));
>> +       if (bit < BITS_PER_LONG)
>> +               return bit + bitbit * BITS_PER_LONG;
>>
>>          bitbit = find_next_zero_bit(fdt->full_fds_bits, maxbit, bitbit) * BITS_PER_LONG;
>>          if (bitbit >= maxfd)
>> --
>> 2.43.0
>>
>

