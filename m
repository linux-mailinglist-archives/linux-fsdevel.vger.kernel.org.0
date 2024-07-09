Return-Path: <linux-fsdevel+bounces-23361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD1392B1CF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 10:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FDA21F22433
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 08:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5E615251B;
	Tue,  9 Jul 2024 08:11:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A42150989;
	Tue,  9 Jul 2024 08:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720512719; cv=none; b=SKGY3DwF4f0ZrDBauU0c9+Fv3DuilFFsWzVXSAuCm2TcIfvUu13ohioQzjVWtRpXJGGri+t7y8lMWUC/BqM41Ts8b5QC0kvzHFSjtYI7/xp4ZDhf/9JoIXYYYZQeeSBjz5ky0TK56vX6AU6JPjILAXLMxfYyZg5uimT7au0JJXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720512719; c=relaxed/simple;
	bh=9mkaxcF5z3MsbBIatfvSZnnhBaUAl4BQaJa1bAPXQKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m5+4Mi2hU1r+jutGjl4OaY2lrQ0Gmxc/vQS++s/+zddzlVbuk68Qn+aWWP7ihulZH+mnoi7FgTSQI7mwUE85RNhM31i5pFtiyiTJ8QQg9Y2zDy+UG5mU2tmHUddELT46NmIQm5xHI3nVlt2M3PrvHyA7Kt6P7vtJ5H6SGse4NRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBAE81042;
	Tue,  9 Jul 2024 01:12:21 -0700 (PDT)
Received: from [10.57.76.194] (unknown [10.57.76.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AA763F762;
	Tue,  9 Jul 2024 01:11:53 -0700 (PDT)
Message-ID: <5875f5ea-4d83-4691-914c-15834338410e@arm.com>
Date: Tue, 9 Jul 2024 09:11:51 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/10] fs: Allow fine-grained control of folio sizes
Content-Language: en-GB
To: Dave Chinner <david@fromorbit.com>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Matthew Wilcox <willy@infradead.org>, chandan.babu@oracle.com,
 djwong@kernel.org, brauner@kernel.org, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
 linux-mm@kvack.org, john.g.garry@oracle.com, linux-fsdevel@vger.kernel.org,
 hare@suse.de, p.raghav@samsung.com, mcgrof@kernel.org, gost.dev@samsung.com,
 cl@os.amperecomputing.com, linux-xfs@vger.kernel.org, hch@lst.de,
 Zi Yan <zi.yan@sent.com>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-2-kernel@pankajraghav.com>
 <cb644a36-67a7-4692-b002-413e70ac864a@arm.com>
 <Zoa9rQbEUam467-q@casper.infradead.org>
 <Zocc+6nIQzfUTPpd@dread.disaster.area>
 <Zoc2rCPC5thSIuoR@casper.infradead.org>
 <Zod3ZQizBL7MyWEA@dread.disaster.area>
 <20240705132418.gk7oeucdisat3sq5@quentin>
 <1e0e89ea-3130-42b0-810d-f52da2affe51@arm.com>
 <ZoxvzXA1wcGDlQS2@dread.disaster.area>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZoxvzXA1wcGDlQS2@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/07/2024 00:01, Dave Chinner wrote:
> On Fri, Jul 05, 2024 at 02:31:08PM +0100, Ryan Roberts wrote:
>> On 05/07/2024 14:24, Pankaj Raghav (Samsung) wrote:
>>>>> I suggest you handle it better than this.  If the device is asking for a
>>>>> blocksize > PMD_SIZE, you should fail to mount it.
>>>>
>>>> That's my point: we already do that.
>>>>
>>>> The largest block size we support is 64kB and that's way smaller
>>>> than PMD_SIZE on all platforms and we always check for bs > ps 
>>>> support at mount time when the filesystem bs > ps.
>>>>
>>>> Hence we're never going to set the min value to anything unsupported
>>>> unless someone makes a massive programming mistake. At which point,
>>>> we want a *hard, immediate fail* so the developer notices their
>>>> mistake immediately. All filesystems and block devices need to
>>>> behave this way so the limits should be encoded as asserts in the
>>>> function to trigger such behaviour.
>>>
>>> I agree, this kind of bug will be encountered only during developement 
>>> and not during actual production due to the limit we have fs block size
>>> in XFS.
>>>
>>>>
>>>>> If the device is
>>>>> asking for a blocksize > PAGE_SIZE and CONFIG_TRANSPARENT_HUGEPAGE is
>>>>> not set, you should also decline to mount the filesystem.
>>>>
>>>> What does CONFIG_TRANSPARENT_HUGEPAGE have to do with filesystems
>>>> being able to use large folios?
>>>>
>>>> If that's an actual dependency of using large folios, then we're at
>>>> the point where the mm side of large folios needs to be divorced
>>>> from CONFIG_TRANSPARENT_HUGEPAGE and always supported.
>>>> Alternatively, CONFIG_TRANSPARENT_HUGEPAGE needs to selected by the
>>>> block layer and also every filesystem that wants to support
>>>> sector/blocks sizes larger than PAGE_SIZE.  IOWs, large folio
>>>> support needs to *always* be enabled on systems that say
>>>> CONFIG_BLOCK=y.
>>>
>>> Why CONFIG_BLOCK? I think it is enough if it comes from the FS side
>>> right? And for now, the only FS that needs that sort of bs > ps 
>>> guarantee is XFS with this series. Other filesystems such as bcachefs 
>>> that call mapping_set_large_folios() only enable it as an optimization
>>> and it is not needed for the filesystem to function.
>>>
>>> So this is my conclusion from the conversation:
>>> - Add a dependency in Kconfig on THP for XFS until we fix the dependency
>>>   of large folios on THP
>>
>> THP isn't supported on some arches, so isn't this effectively saying XFS can no
>> longer be used with those arches, even if the bs <= ps?
> 
> I'm good with that - we're already long past the point where we try
> to support XFS on every linux platform. Indeed, we've recent been
> musing about making XFS depend on 64 bit only - 32 bit systems don't
> have the memory capacity to run the full xfs tool chain (e.g.
> xfs_repair) on filesystems over about a TB in size, and they are
> greatly limited in kernel memory and vmap areas, both of which XFS
> makes heavy use of. Basically, friends don't let friends use XFS on
> 32 bit systems, and that's been true for about 20 years now.
> 
> Our problem is the test matrix - if we now have to explicitly test
> XFS both with and without large folios enabled to support these
> platforms, we've just doubled our test matrix. The test matrix is
> already far too large to robustly cover, so anything that requires
> doubling the number of kernel configs we have to test is, IMO, a
> non-starter.
> 
> That's why we really don't support XFS on 32 bit systems anymore and
> why we're talking about making that official with a config option.
> If we're at the point where XFS will now depend on large folios (i.e
> THP), then we need to seriously consider reducing the supported
> arches to just those that support both 64 bit and THP. If niche
> arches want to support THP, or enable large folios without the need
> for THP, then they can do that work and then they get XFS for
> free.
> 
> Just because an arch might run a Linux kernel, it doesn't mean we
> have to support XFS on it....

OK. I was just pointing out the impact of adding this Kconfig dependency. If
that impact is explicitly considered and desired, then great. I'll leave you to it.

Thanks,
Ryan

> 
> -Dave.


