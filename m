Return-Path: <linux-fsdevel+bounces-8749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC1183AA42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 13:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A64A5291505
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F372B77644;
	Wed, 24 Jan 2024 12:47:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AC876918;
	Wed, 24 Jan 2024 12:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706100476; cv=none; b=GXTq6axMUMLRWbfnapnLDJpe0pvsZZ3yfpZcejTj3Gff0Qx6KFWUh5SHlM3zxwv193kpuP/5AGl9ulJ4duroVM0OJGeAvfJwptUDKsksbFsF628Tb6tkftZppu5meUGlwEA6iiKf7RWjde3X9wEO1rAp53JZCo6Jukb/RCwF+ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706100476; c=relaxed/simple;
	bh=t7Xd3wxMZ8SnVi93CphbSDGFf7zPs+X1p9aSe+xXTn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=StT0qqG/DU8lO65FwGvvDNd9tydPCsF9xzXHkL0bLdfJLK9Eglk1T+aDKzsTSLyq4KIHqI8UETVuLutP7UUIk2DqCyBV5Nvbf1NSS2rBlRAf5enhbs5lrxcGEKo0IULCvVsoJDRRJM0nmdw0Ivv8VN1GNjiGxYrpsNibN0Nkwgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W.GpQgu_1706100464;
Received: from 192.168.31.58(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W.GpQgu_1706100464)
          by smtp.aliyun-inc.com;
          Wed, 24 Jan 2024 20:47:45 +0800
Message-ID: <6e6bef3d-dd26-45ce-bc4a-c04a960dfb9c@linux.alibaba.com>
Date: Wed, 24 Jan 2024 20:47:44 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: increase FUSE_MAX_MAX_PAGES limit
Content-Language: en-US
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhangjiachen.jaycee@bytedance.com
References: <20240124070512.52207-1-jefflexu@linux.alibaba.com>
 <CAJfpegs10SdtzNXJfj3=vxoAZMhksT5A1u5W5L6nKL-P2UOuLQ@mail.gmail.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJfpegs10SdtzNXJfj3=vxoAZMhksT5A1u5W5L6nKL-P2UOuLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/24/24 8:23 PM, Miklos Szeredi wrote:
> On Wed, 24 Jan 2024 at 08:05, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>
>> From: Xu Ji <laoji.jx@alibaba-inc.com>
>>
>> Increase FUSE_MAX_MAX_PAGES limit, so that the maximum data size of a
>> single request is increased.
> 
> The only worry is about where this memory is getting accounted to.
> This needs to be thought through, since the we are increasing the
> possible memory that an unprivileged user is allowed to pin.

OK that will be an issue.

> 
> 
> 
>>
>> This optimizes the write performance especially when the optimal IO size
>> of the backend store at the fuse daemon side is greater than the original
>> maximum request size (i.e. 1MB with 256 FUSE_MAX_MAX_PAGES and
>> 4096 PAGE_SIZE).
>>
>> Be noted that this only increases the upper limit of the maximum request
>> size, while the real maximum request size relies on the FUSE_INIT
>> negotiation with the fuse daemon.
>>
>> Signed-off-by: Xu Ji <laoji.jx@alibaba-inc.com>
>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>> ---
>> I'm not sure if 1024 is adequate for FUSE_MAX_MAX_PAGES, as the
>> Bytedance floks seems to had increased the maximum request size to 8M
>> and saw a ~20% performance boost.
> 
> The 20% is against the 256 pages, I guess. 

Yeah I guess so.


> It would be interesting to
> see the how the number of pages per request affects performance and
> why.

To be honest, I'm not sure the root cause of the performance boost in
bytedance's case.

While in our internal use scenario, the optimal IO size of the backend
store at the fuse server side is, e.g. 4MB, and thus if the maximum
throughput can not be achieved with current 256 pages per request. IOW
the backend store, e.g. a distributed parallel filesystem, get optimal
performance when the data is aligned at 4MB boundary.  I can ask my folk
who implements the fuse server to give more background info and the
exact performance statistics.

Thanks.



-- 
Thanks,
Jingbo

