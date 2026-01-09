Return-Path: <linux-fsdevel+bounces-72977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCD8D06D80
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 03:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05139300FA35
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 02:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913A330ACEE;
	Fri,  9 Jan 2026 02:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="m1fgjGaY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803AE1DE4CE;
	Fri,  9 Jan 2026 02:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767925298; cv=none; b=XZLljoXtCMbiiLPpJrbCNuvsaWBsHPtmKKVmuiXfNaOBeCzhgufqrHIuMcZ9X3NdefQNDWL23rit11bfI3fUdEI9mvyX4jfGBbK3CMmRmkyY6sRYBFNxKUE3XnuI36KcFAQ5NRlx9yDEG6vxKjNy0CRYlydUUHiJZn7gHdASPx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767925298; c=relaxed/simple;
	bh=69cRou50UcMC4HPt9c4gDpYw2o0Pxfjzw5jspG3AQEU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lnEIveXDqGnJiTW+IjXkZIlEj74itrkQhNkaifMOhl71jS5PpvI7oLcT7dKd/3LJefHkMVQWgSlY5IvVLH2byUZ1IgVmhBMMKXryp9gDQBhiuRZlMUjSVmRJdHJ+RWOuUDLmxZdmnQX2+LcUjjMCIeBHgWf+FxlA9mDc3+oC8SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=m1fgjGaY; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767925293; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=+z7PVhgPKAZcW90ZDK3JBww2UMZHLGiOnKKlRCWEp84=;
	b=m1fgjGaYq+j7LY1mZwCZsGParrcEPF5gnDZY+/YUoxIe/v2HhxChVbDeBHCdw8r1e7ZoAWkUKbnwyMfnFRtqCr8NuVgt1lQ9PbX/zkVM84887rZwrVHthy1D+cNZzBk2Wz0KFPuiSGzsM/IYYoI3SLe9yHTm93YmIgHTrNSBNzw=
Received: from 30.221.147.42(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WweTPXS_1767925292 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 09 Jan 2026 10:21:32 +0800
Message-ID: <1fa83cdf-010b-4e95-9dcc-0e9f5cefa68b@linux.alibaba.com>
Date: Fri, 9 Jan 2026 10:21:31 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: invalidate the page cache after direct write
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: Bernd Schubert <bernd@bsbernd.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org, bschubert@ddn.com
Cc: linux-kernel@vger.kernel.org
References: <20260106075234.63364-1-jefflexu@linux.alibaba.com>
 <b6cfc411-8d2e-45c2-b237-e79f71016bbb@bsbernd.com>
 <5b9fd5cb-2494-4dbd-8779-82525cb46bf4@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <5b9fd5cb-2494-4dbd-8779-82525cb46bf4@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Bernd,

On 1/9/26 10:13 AM, Jingbo Xu wrote:
> 
> 
> On 1/9/26 12:16 AM, Bernd Schubert wrote:
>>
>> The side effect should only come without FOPEN_DIRECT_IO. Could you add
>> this diff to avoid it?
>>
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index d6ae3b4652f8..c04296316a82 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -1177,7 +1177,13 @@ static ssize_t fuse_send_write(struct fuse_io_args *ia, loff_t pos,
>>         written = ia->write.out.size;
>>         if (!err && written > count)
>>                 err = -EIO;
>> -       if (!err && written && mapping->nrpages) {
>> +
>> +       /*
>> +        * without FOPEN_DIRECT_IO generic_file_direct_write() does the
>> +        * invalidation for us
>> +        */
>> +       if (!err && written && mapping->nrpages &&
>> +           (ff->open_flags & FOPEN_DIRECT_IO)) {
>>                 /*
>>                  * As in generic_file_direct_write(), invalidate after the
>>                  * write, to invalidate read-ahead cache that may have competed
>>
> 
> Actually I think it's more complicated:
> 
> ```
> /*
>  * without FOPEN_DIRECT_IO generic_file_direct_write() does the
>  * invalidation for synchronous write.
>  */
> if (!err && written && mapping->nrpages &&
>     ((ff->open_flags & FOPEN_DIRECT_IO) || !io->blocking)) {
> ```
> 
> I will send v2 soon if you feel good about the above diff.
> 

Sorry I just realized that the invalidation for asynchronous write will
be done in fuse_aio_complete() of v1 patch.

I will apply the diff you suggested and send v2 soon.

-- 
Thanks,
Jingbo


