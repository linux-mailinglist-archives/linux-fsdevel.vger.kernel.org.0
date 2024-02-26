Return-Path: <linux-fsdevel+bounces-12746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BC386691A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 05:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCBFA1C244D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 04:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19251D54B;
	Mon, 26 Feb 2024 04:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tCuDR2Sw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA891CD36;
	Mon, 26 Feb 2024 04:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708920041; cv=none; b=U/qqIhQ+4M8wlBaf57sIFdbl5E+YT9QOvDN/px8ZQWl/duq50nNeHL2Wv8SejpuYj4zODraiM0OSZBD+cnRxf1Y5y6+R1+kvkMoRWKE9Mt47rxWwCJdtW85rmdEf3LqCgtDZY0qOCcrVDKhbhNeJjdIT8H22Tr/EtCsVEDgFLxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708920041; c=relaxed/simple;
	bh=W1YADgAk5THiSM1uyqe/zP/rQ6qN/TI8sYNYI11fN94=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kUg7l3O6hvz7YcOKX5SVqKvkXE+iM27BKzQjdHnJPHQbzIdJuWvHAOOOjRKeX+2GbaN/JGiOfCSymBLG5I2TBIAO/6Ema36Xl9bm1hbW6asWWyAVlZK4ySpiR8hOYesaoLgaQ0Xp0aOx1GzQxxMx/j3I3w5MpFTvmjY2M1HeSR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tCuDR2Sw; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708920036; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=5UnUbnWPeIVvjmVi4ZoQ6S2MTgT2ztWgxTwU5ffid2I=;
	b=tCuDR2SwIewbP34p6bjhL0xFg/dcKPlcP/Zaw5Y48rkJghuM0CiRY7xP8HXZk04XHT05vm0cP7Bi7nxt/ewhmzK5Rp5BZALeAUhIiBipzcqCGP9WbCmGRfJBEgbHqXuIBHOw1pOSPxvtLg4JX/CxnG63Y64W6bwxLrZchJez5Z0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W1AMe33_1708920034;
Received: from 30.221.148.164(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W1AMe33_1708920034)
          by smtp.aliyun-inc.com;
          Mon, 26 Feb 2024 12:00:35 +0800
Message-ID: <27b34186-bc7c-4f3c-8818-ee73eb3f82ba@linux.alibaba.com>
Date: Mon, 26 Feb 2024 12:00:34 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: increase FUSE_MAX_MAX_PAGES limit
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhangjiachen.jaycee@bytedance.com
References: <20240124070512.52207-1-jefflexu@linux.alibaba.com>
 <CAJfpegs10SdtzNXJfj3=vxoAZMhksT5A1u5W5L6nKL-P2UOuLQ@mail.gmail.com>
 <6e6bef3d-dd26-45ce-bc4a-c04a960dfb9c@linux.alibaba.com>
 <b4e6b930-ed06-4e0d-b17d-61d05381ac92@linux.alibaba.com>
In-Reply-To: <b4e6b930-ed06-4e0d-b17d-61d05381ac92@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Miklos,

On 1/26/24 2:29 PM, Jingbo Xu wrote:
> 
> 
> On 1/24/24 8:47 PM, Jingbo Xu wrote:
>>
>>
>> On 1/24/24 8:23 PM, Miklos Szeredi wrote:
>>> On Wed, 24 Jan 2024 at 08:05, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>>>
>>>> From: Xu Ji <laoji.jx@alibaba-inc.com>
>>>>
>>>> Increase FUSE_MAX_MAX_PAGES limit, so that the maximum data size of a
>>>> single request is increased.
>>>
>>> The only worry is about where this memory is getting accounted to.
>>> This needs to be thought through, since the we are increasing the
>>> possible memory that an unprivileged user is allowed to pin.
> 
> Apart from the request size, the maximum number of background requests,
> i.e. max_background (12 by default, and configurable by the fuse
> daemon), also limits the size of the memory that an unprivileged user
> can pin.  But yes, it indeed increases the number proportionally by
> increasing the maximum request size.
> 
> 
>>
>>>
>>>
>>>
>>>>
>>>> This optimizes the write performance especially when the optimal IO size
>>>> of the backend store at the fuse daemon side is greater than the original
>>>> maximum request size (i.e. 1MB with 256 FUSE_MAX_MAX_PAGES and
>>>> 4096 PAGE_SIZE).
>>>>
>>>> Be noted that this only increases the upper limit of the maximum request
>>>> size, while the real maximum request size relies on the FUSE_INIT
>>>> negotiation with the fuse daemon.
>>>>
>>>> Signed-off-by: Xu Ji <laoji.jx@alibaba-inc.com>
>>>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>>>> ---
>>>> I'm not sure if 1024 is adequate for FUSE_MAX_MAX_PAGES, as the
>>>> Bytedance floks seems to had increased the maximum request size to 8M
>>>> and saw a ~20% performance boost.
>>>
>>> The 20% is against the 256 pages, I guess. 
>>
>> Yeah I guess so.
>>
>>
>>> It would be interesting to
>>> see the how the number of pages per request affects performance and
>>> why.
>>
>> To be honest, I'm not sure the root cause of the performance boost in
>> bytedance's case.
>>
>> While in our internal use scenario, the optimal IO size of the backend
>> store at the fuse server side is, e.g. 4MB, and thus if the maximum
>> throughput can not be achieved with current 256 pages per request. IOW
>> the backend store, e.g. a distributed parallel filesystem, get optimal
>> performance when the data is aligned at 4MB boundary.  I can ask my folk
>> who implements the fuse server to give more background info and the
>> exact performance statistics.
> 
> Here are more details about our internal use case:
> 
> We have a fuse server used in our internal cloud scenarios, while the
> backend store is actually a distributed filesystem.  That is, the fuse
> server actually plays as the client of the remote distributed
> filesystem.  The fuse server forwards the fuse requests to the remote
> backing store through network, while the remote distributed filesystem
> handles the IO requests, e.g. process the data from/to the persistent store.
> 
> Then it comes the details of the remote distributed filesystem when it
> process the requested data with the persistent store.
> 
> [1] The remote distributed filesystem uses, e.g. a 8+3 mode, EC
> (ErasureCode), where each fixed sized user data is split and stored as 8
> data blocks plus 3 extra parity blocks. For example, with 512 bytes
> block size, for each 4MB user data, it's split and stored as 8 (512
> bytes) data blocks with 3 (512 bytes) parity blocks.
> 
> It also utilize the stripe technology to boost the performance, for
> example, there are 8 data disks and 3 parity disks in the above 8+3 mode
> example, in which each stripe consists of 8 data blocks and 3 parity
> blocks.
> 
> [2] To avoid data corruption on power off, the remote distributed
> filesystem commit a O_SYNC write right away once a write (fuse) request
> received.  Since the EC described above, when the write fuse request is
> not aligned on 4MB (the stripe size) boundary, say it's 1MB in size, the
> other 3MB is read from the persistent store first, then compute the
> extra 3 parity blocks with the complete 4MB stripe, and finally write
> the 8 data blocks and 3 parity blocks down.
> 
> 
> Thus the write amplification is un-neglectable and is the performance
> bottleneck when the fuse request size is less than the stripe size.
> 
> Here are some simple performance statistics with varying request size.
> With 4MB stripe size, there's ~3x bandwidth improvement when the maximum
> request size is increased from 256KB to 3.9MB, and another ~20%
> improvement when the request size is increased to 4MB from 3.9MB.
> 

gentle ping ...

I'm not sure if our using scenario described above is reasonable for
you.  Let me know if there's any other concern.


-- 
Thanks,
Jingbo

