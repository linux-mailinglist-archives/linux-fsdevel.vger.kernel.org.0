Return-Path: <linux-fsdevel+bounces-23200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9479289B5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 15:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E144C1C23B27
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 13:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBFC14D433;
	Fri,  5 Jul 2024 13:31:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EB914659D;
	Fri,  5 Jul 2024 13:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186275; cv=none; b=syISishtu6lts2Ld/QqeC3XIpiYQRO2aR1dq3JIkQ2Dl162hZxWflfFxVIKper5pkOK5s/jbTvzPj4NPrVpfIuN2nyWtp5+QYXbh7TogsNqj+aKROH+1FTjCHvwwOfVWKMltg3VtHStqvMaaNSP5UVgR3Ac4I6lT2e6JxQriNmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186275; c=relaxed/simple;
	bh=xCug+VBhHtQMhds5DcaiOaD1U8IKIttktt/mKzhQHRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHm+J9gHKcEYu04QQjuBFgu4WvEdJ649aYvdG/OOR9RCH2yinyMgalOqrdFSgfSQ10FS7tKkcPOvVQ/EPxUYNn5YKIMfKIhni/CbQmAhvh3DTEEcfEyGr9j4GilwofwRokrfagkz7N6/3vu8ck5Dud2gjt71294nvto2wjDGpcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA57E367;
	Fri,  5 Jul 2024 06:31:37 -0700 (PDT)
Received: from [10.57.74.223] (unknown [10.57.74.223])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07DCA3F762;
	Fri,  5 Jul 2024 06:31:09 -0700 (PDT)
Message-ID: <1e0e89ea-3130-42b0-810d-f52da2affe51@arm.com>
Date: Fri, 5 Jul 2024 14:31:08 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/10] fs: Allow fine-grained control of folio sizes
Content-Language: en-GB
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Dave Chinner <david@fromorbit.com>
Cc: Matthew Wilcox <willy@infradead.org>, chandan.babu@oracle.com,
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240705132418.gk7oeucdisat3sq5@quentin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/07/2024 14:24, Pankaj Raghav (Samsung) wrote:
>>> I suggest you handle it better than this.  If the device is asking for a
>>> blocksize > PMD_SIZE, you should fail to mount it.
>>
>> That's my point: we already do that.
>>
>> The largest block size we support is 64kB and that's way smaller
>> than PMD_SIZE on all platforms and we always check for bs > ps 
>> support at mount time when the filesystem bs > ps.
>>
>> Hence we're never going to set the min value to anything unsupported
>> unless someone makes a massive programming mistake. At which point,
>> we want a *hard, immediate fail* so the developer notices their
>> mistake immediately. All filesystems and block devices need to
>> behave this way so the limits should be encoded as asserts in the
>> function to trigger such behaviour.
> 
> I agree, this kind of bug will be encountered only during developement 
> and not during actual production due to the limit we have fs block size
> in XFS.
> 
>>
>>> If the device is
>>> asking for a blocksize > PAGE_SIZE and CONFIG_TRANSPARENT_HUGEPAGE is
>>> not set, you should also decline to mount the filesystem.
>>
>> What does CONFIG_TRANSPARENT_HUGEPAGE have to do with filesystems
>> being able to use large folios?
>>
>> If that's an actual dependency of using large folios, then we're at
>> the point where the mm side of large folios needs to be divorced
>> from CONFIG_TRANSPARENT_HUGEPAGE and always supported.
>> Alternatively, CONFIG_TRANSPARENT_HUGEPAGE needs to selected by the
>> block layer and also every filesystem that wants to support
>> sector/blocks sizes larger than PAGE_SIZE.  IOWs, large folio
>> support needs to *always* be enabled on systems that say
>> CONFIG_BLOCK=y.
> 
> Why CONFIG_BLOCK? I think it is enough if it comes from the FS side
> right? And for now, the only FS that needs that sort of bs > ps 
> guarantee is XFS with this series. Other filesystems such as bcachefs 
> that call mapping_set_large_folios() only enable it as an optimization
> and it is not needed for the filesystem to function.
> 
> So this is my conclusion from the conversation:
> - Add a dependency in Kconfig on THP for XFS until we fix the dependency
>   of large folios on THP

THP isn't supported on some arches, so isn't this effectively saying XFS can no
longer be used with those arches, even if the bs <= ps? I think while pagecache
large folios depend on THP, you need to make this a mount-time check in the FS?

But ideally, MAX_PAGECACHE_ORDER would be set to 0 for
!CONFIG_TRANSPARENT_HUGEPAGE so you can just check against that and don't have
to worry about THP availability directly.

Willy; Why is MAX_PAGECACHE_ORDER set to 8 when THP is disabled currently?

> - Add a BUILD_BUG_ON(XFS_MAX_BLOCKSIZE > MAX_PAGECACHE_ORDER)
> - Add a WARN_ON_ONCE() and clamp the min and max value in
>   mapping_set_folio_order_range() ?
> 
> Let me know what you all think @willy, @dave and @ryan.
> 
> --
> Pankaj


