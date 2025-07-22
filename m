Return-Path: <linux-fsdevel+bounces-55662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 184E8B0D6CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 12:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2638C3AEBF4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 10:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0733B2E2652;
	Tue, 22 Jul 2025 10:03:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C772DCF4F;
	Tue, 22 Jul 2025 10:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178606; cv=none; b=kfKidLanpLoy0TG6SqMsNpkzZjcED7dgU8y0a8Rc3vca2dOmuJ9PoprX3a0HrNz80ZcaWM11TLAnzcjmRp7WGHuZBiSGBJfgqE0e2N+Nq35l8IY1y7evzd8ANrnyKRZLLx28Urh3YYrgzQ/pqWhc3SRqd5IbJDfdJavx1+2idHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178606; c=relaxed/simple;
	bh=KRSoslysxubJvKlodptdIN8Cr0CnxifhWfGSE9GeFgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DS7NUo5jum4zgLfAp5akCOycPs23yX9zwxdq5D/NVWdYOr6B8k4as3SwrINj4ZNqLOEQU6S1aP5GG6LTXVT4WjXzi+hEqJH4iZ4s9cRa/WIb6Lme2p9q9akKP4A+9K3EN5MogwVsx7q4r4BgX11jNucMKUX2Qk08JUsnYyNZXsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC462152B;
	Tue, 22 Jul 2025 03:03:18 -0700 (PDT)
Received: from [10.57.0.201] (unknown [10.57.0.201])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1B363F59E;
	Tue, 22 Jul 2025 03:03:21 -0700 (PDT)
Message-ID: <c93b34ca-1abf-4db0-90f9-3802ac02c25a@arm.com>
Date: Tue, 22 Jul 2025 11:03:18 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Excessive page cache occupies DMA32 memory
To: Greg KH <gregkh@linuxfoundation.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Matthew Wilcox <willy@infradead.org>,
 Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Manivannan Sadhasivam <mani@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, kernel@collabora.com,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <766ef20e-7569-46f3-aa3c-b576e4bab4c6@collabora.com>
 <aH51JnZ8ZAqZ6N5w@casper.infradead.org>
 <2025072238-unplanted-movable-7dfb@gregkh>
 <91fc0c41-6d25-4f60-9de3-23d440fc8e00@collabora.com>
 <2025072234-cork-unadvised-24d3@gregkh>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <2025072234-cork-unadvised-24d3@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-07-22 8:24 am, Greg KH wrote:
> On Tue, Jul 22, 2025 at 11:05:11AM +0500, Muhammad Usama Anjum wrote:
>> Adding ath/mhi and dma API developers to the discussion.
>>
>> On 7/22/25 10:32 AM, Greg KH wrote:
>>> On Mon, Jul 21, 2025 at 06:13:10PM +0100, Matthew Wilcox wrote:
>>>> On Mon, Jul 21, 2025 at 08:03:12PM +0500, Muhammad Usama Anjum wrote:
>>>>> Hello,
>>>>>
>>>>> When 10-12GB our of total 16GB RAM is being used as page cache
>>>>> (active_file + inactive_file) at suspend time, the drivers fail to allocate
>>>>> dma memory at resume as dma memory is either occupied by the page cache or
>>>>> fragmented. Example:
>>>>>
>>>>> kworker/u33:5: page allocation failure: order:7, mode:0xc04(GFP_NOIO|GFP_DMA32), nodemask=(null),cpuset=/,mems_allowed=0
>>>>
>>>> Just to be clear, this is not a page cache problem.  The driver is asking
>>>> us to do a 512kB allocation without doing I/O!  This is a ridiculous
>>>> request that should be expected to fail.
>>>>
>>>> The solution, whatever it may be, is not related to the page cache.
>>>> I reject your diagnosis.  Almost all of the page cache is clean and
>>>> could be dropped (as far as I can tell from the output below).
>>>>
>>>> Now, I'm not too familiar with how the page allocator chooses to fail
>>>> this request.  Maybe it should be trying harder to drop bits of the page
>>>> cache.  Maybe it should be doing some compaction.
>> That's very thoughtful. I'll look at the page allocator why isn't it dropping
>> cache or doing compaction.
>>
>>>> I am not inclined to
>>>> go digging on your behalf, because frankly I'm offended by the suggestion
>>>> that the page cache is at fault.
>> I apologize—that wasn't my intention.
>>
>>>>
>>>> Perhaps somebody else will help you, or you can dig into this yourself.
>>>
>>> I'm with Matthew, this really looks like a driver bug somehow.  If there
>>> is page cache memory that is "clean", the driver should be able to
>>> access it just fine if really required.
>>>
>>> What exact driver(s) is having this problem?  What is the exact error,
>>> and on what lines of code?
>> The issue occurs on both ath11k and mhi drivers during resume, when
>> dma_alloc_coherent(GFP_KERNEL) fails and returns -ENOMEM. This failure has
>> been observed at multiple points in these drivers.
>>
>> For example, in the mhi driver, the failure is triggered when the
>> MHI's st_worker gets scheduled-in at resume.
>>
>> mhi_pm_st_worker()
>> -> mhi_fw_load_handler()
>>     -> mhi_load_image_bhi()
>>        -> mhi_alloc_bhi_buffer()
>>           -> dma_alloc_coherent(GFP_KERNEL) returns -ENOMEM
> 
> And what is the exact size you are asking for here?
> What is the dma ops set to for your system?  Are you sure that is
> working properly for your platform?  What platform is this exactly?
> 
> The driver isn't asking for DMA32 here, so that shouldn't be the issue,
> so why do you feel it is?  Have you tried using the tracing stuff for
> dma allocations to see exactly what is going on for this failure?

I'm guessing the device has a 32-bit DMA mask, and the allocation ends 
up in __dma_direct_alloc_pages() such that that adds GFP_DMA32 in order 
to try to satisfy the mask via regular page allocation. How GFP_KERNEL 
turns into GFP_NOIO, though, given that the DMA layer certainly isn't 
(knowingly) messing with __GFP_IO or __GFP_FS, is more of a mystery... I 
suppose "during resume" is the red flag there - is this worker perhaps 
trying to run too early in some restricted context before the rest of 
the system has fully woken up?

Thanks,
Robin.

> 
> I think you need to do a bit more debugging :)
> 
> thanks,
> 
> greg k-h


