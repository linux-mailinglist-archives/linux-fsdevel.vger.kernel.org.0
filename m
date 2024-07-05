Return-Path: <linux-fsdevel+bounces-23191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAA892849E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 11:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178601F21054
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 09:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2441148312;
	Fri,  5 Jul 2024 09:03:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCBA146595;
	Fri,  5 Jul 2024 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720170219; cv=none; b=PvHs8TpOGarB5rFvhj7OyKA6RhoFXVyYsTpEQIAes7apeQCFV5WZtwXdvlYWxkScYNmiBxomOsXJCiyKKMq5uFj8xvYYoBIa3zKYgnEqdBpwoxc7NZM1neBJdaylS/yCZK8k0ISBVokA9WtpThRKtHOx6ThFcqnM88fxaRgPTBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720170219; c=relaxed/simple;
	bh=yNvAgV4SPQTtkN8fNXBGOMuGF0J3NFl0Do+tQqT3Igs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B7imWMB2zKN5iVnlkdIwAe4hkiZvkGP+0bdWgH80NcM/eFO0T9Bp6HdDwheFIXzDBeT8DOechzei69mJK7zJNN8Lq9PdT7frCgXPQ6tZBQzGgt/w3dlpawW5I70b5XiidyjahduP1PL4z6J/kisCCnd/PT9CbTggPZCCECWJC/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5AD8367;
	Fri,  5 Jul 2024 02:04:01 -0700 (PDT)
Received: from [10.57.74.223] (unknown [10.57.74.223])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 813DD3F762;
	Fri,  5 Jul 2024 02:03:33 -0700 (PDT)
Message-ID: <03b9ea6c-a3c4-41e8-ad47-4e82344da419@arm.com>
Date: Fri, 5 Jul 2024 10:03:31 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/10] fs: Allow fine-grained control of folio sizes
Content-Language: en-GB
To: Dave Chinner <david@fromorbit.com>, Matthew Wilcox <willy@infradead.org>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 chandan.babu@oracle.com, djwong@kernel.org, brauner@kernel.org,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 yang@os.amperecomputing.com, linux-mm@kvack.org, john.g.garry@oracle.com,
 linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
 mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
 linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <zi.yan@sent.com>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-2-kernel@pankajraghav.com>
 <cb644a36-67a7-4692-b002-413e70ac864a@arm.com>
 <Zoa9rQbEUam467-q@casper.infradead.org>
 <Zocc+6nIQzfUTPpd@dread.disaster.area>
 <Zoc2rCPC5thSIuoR@casper.infradead.org>
 <Zod3ZQizBL7MyWEA@dread.disaster.area>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Zod3ZQizBL7MyWEA@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/07/2024 05:32, Dave Chinner wrote:
> On Fri, Jul 05, 2024 at 12:56:28AM +0100, Matthew Wilcox wrote:
>> On Fri, Jul 05, 2024 at 08:06:51AM +1000, Dave Chinner wrote:
>>>>> It seems strange to silently clamp these? Presumably for the bs>ps usecase,
>>>>> whatever values are passed in are a hard requirement? So wouldn't want them to
>>>>> be silently reduced. (Especially given the recent change to reduce the size of
>>>>> MAX_PAGECACHE_ORDER to less then PMD size in some cases).
>>>>
>>>> Hm, yes.  We should probably make this return an errno.  Including
>>>> returning an errno for !IS_ENABLED() and min > 0.
>>>
>>> What are callers supposed to do with an error? In the case of
>>> setting up a newly allocated inode in XFS, the error would be
>>> returned in the middle of a transaction and so this failure would
>>> result in a filesystem shutdown.
>>
>> I suggest you handle it better than this.  If the device is asking for a
>> blocksize > PMD_SIZE, you should fail to mount it.

A detail, but MAX_PAGECACHE_ORDER may be smaller than PMD_SIZE even on systems
with CONFIG_TRANSPARENT_HUGEPAGE as of a fix that is currently in mm-unstable:

	#ifdef CONFIG_TRANSPARENT_HUGEPAGE
	#define PREFERRED_MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
	#else
	#define PREFERRED_MAX_PAGECACHE_ORDER	8
	#endif

	/*
	 * xas_split_alloc() does not support arbitrary orders. This implies no
	 * 512MB THP on ARM64 with 64KB base page size.
	 */
	#define MAX_XAS_ORDER		(XA_CHUNK_SHIFT * 2 - 1)
	#define MAX_PAGECACHE_ORDER	min(MAX_XAS_ORDER,
					    PREFERRED_MAX_PAGECACHE_ORDER)

But that also implies that the page cache can handle up to order-8 without
CONFIG_TRANSPARENT_HUGEPAGE so sounds like there isn't a dependcy on
CONFIG_TRANSPARENT_HUGEPAGE in this respect?



> 
> That's my point: we already do that.
> 
> The largest block size we support is 64kB and that's way smaller
> than PMD_SIZE on all platforms and we always check for bs > ps 
> support at mount time when the filesystem bs > ps.
> 
> Hence we're never going to set the min value to anything unsupported
> unless someone makes a massive programming mistake. At which point,
> we want a *hard, immediate fail* so the developer notices their
> mistake immediately. All filesystems and block devices need to
> behave this way so the limits should be encoded as asserts in the
> function to trigger such behaviour.
> 
>> If the device is
>> asking for a blocksize > PAGE_SIZE and CONFIG_TRANSPARENT_HUGEPAGE is
>> not set, you should also decline to mount the filesystem.
> 
> What does CONFIG_TRANSPARENT_HUGEPAGE have to do with filesystems
> being able to use large folios?
> 
> If that's an actual dependency of using large folios, then we're at
> the point where the mm side of large folios needs to be divorced
> from CONFIG_TRANSPARENT_HUGEPAGE and always supported.
> Alternatively, CONFIG_TRANSPARENT_HUGEPAGE needs to selected by the
> block layer and also every filesystem that wants to support
> sector/blocks sizes larger than PAGE_SIZE.  IOWs, large folio
> support needs to *always* be enabled on systems that say
> CONFIG_BLOCK=y.
> 
> I'd much prefer the former occurs, because making the block layer
> and filesystems dependent on an mm feature they don't actually use
> is kinda weird...
> 
> -Dave.
> 


