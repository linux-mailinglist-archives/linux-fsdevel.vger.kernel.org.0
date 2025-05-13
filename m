Return-Path: <linux-fsdevel+bounces-48830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A40AAB4F8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 11:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3133D1888BA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 09:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6606721B9C2;
	Tue, 13 May 2025 09:19:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D6A21ADB5;
	Tue, 13 May 2025 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747127986; cv=none; b=n9MMp8dPKWI4f5sqG4NRdUEtnv/niyA0qUDWdFxW22A4cTvh7sbfdKgeInmLfyrBwAvvJPLETe4ZA6JP54sL9krFHdA/cYVAECtfQJPkB32lF7G6m6VqGCDPO52czkvKR4zlMsHIT35qwTAS99bOY/nkUa8WAkbZKYctSumV2ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747127986; c=relaxed/simple;
	bh=5YrABFzbKb8Src/u5OGMIShsQQLYX37Y/4zalAnMTa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UI9czNUJWj6BG7JbSM7BgDwrpGUwfg2Rn4LAZgVT5nCWjvYgnuw1MTq1XW4loreCqfGZSsA2J8J8BCv2q5FeHC8GfQrrIG8CJ2etUMNTg+IDfHJ0qk3Scc8WvbeGJGxK7IHMlZk2y5ggGlGbtoA98HcjVuu8wtPPMQzQSqmGCqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0522168F;
	Tue, 13 May 2025 02:19:32 -0700 (PDT)
Received: from [10.57.90.222] (unknown [10.57.90.222])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09E603F673;
	Tue, 13 May 2025 02:19:41 -0700 (PDT)
Message-ID: <56655ac1-a650-43d8-8080-a03c250474d3@arm.com>
Date: Tue, 13 May 2025 10:19:40 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] binfmt_elf: Move brk for static PIE even if ASLR
 disabled
Content-Language: en-GB
To: Kees Cook <kees@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Ali Saidi <alisaidi@amazon.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-hardening@vger.kernel.org
References: <20250502001820.it.026-kees@kernel.org>
 <87f80506-eeb3-4848-adc9-8a030b5f4136@arm.com>
 <a786b348-7622-4c62-bfdc-f04e05066184@arm.com>
 <202505121340.7CA14D4C@keescook>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <202505121340.7CA14D4C@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/05/2025 21:40, Kees Cook wrote:
> On Mon, May 12, 2025 at 04:17:12PM +0100, Ryan Roberts wrote:
>> Hi Andrew,
>>
>>
>> On 02/05/2025 11:01, Ryan Roberts wrote:
>>> On 02/05/2025 01:18, Kees Cook wrote:
>>>> In commit bbdc6076d2e5 ("binfmt_elf: move brk out of mmap when doing
>>>> direct loader exec"), the brk was moved out of the mmap region when
>>>> loading static PIE binaries (ET_DYN without INTERP). The common case
>>>> for these binaries was testing new ELF loaders, so the brk needed to
>>>> be away from mmap to avoid colliding with stack, future mmaps (of the
>>>> loader-loaded binary), etc. But this was only done when ASLR was enabled,
>>>> in an attempt to minimize changes to memory layouts.
>>>>
>>>> After adding support to respect alignment requirements for static PIE
>>>> binaries in commit 3545deff0ec7 ("binfmt_elf: Honor PT_LOAD alignment
>>>> for static PIE"), it became possible to have a large gap after the
>>>> final PT_LOAD segment and the top of the mmap region. This means that
>>>> future mmap allocations might go after the last PT_LOAD segment (where
>>>> brk might be if ASLR was disabled) instead of before them (where they
>>>> traditionally ended up).
>>>>
>>>> On arm64, running with ASLR disabled, Ubuntu 22.04's "ldconfig" binary,
>>>> a static PIE, has alignment requirements that leaves a gap large enough
>>>> after the last PT_LOAD segment to fit the vdso and vvar, but still leave
>>>> enough space for the brk (which immediately follows the last PT_LOAD
>>>> segment) to be allocated by the binary.
>>>>
>>>> fffff7f20000-fffff7fde000 r-xp 00000000 fe:02 8110426 /sbin/ldconfig.real
>>>> fffff7fee000-fffff7ff5000 rw-p 000be000 fe:02 8110426 /sbin/ldconfig.real
>>>> fffff7ff5000-fffff7ffa000 rw-p 00000000 00:00 0
>>>> ***[brk will go here at fffff7ffa000]***
>>>> fffff7ffc000-fffff7ffe000 r--p 00000000 00:00 0       [vvar]
>>>> fffff7ffe000-fffff8000000 r-xp 00000000 00:00 0       [vdso]
>>>> fffffffdf000-1000000000000 rw-p 00000000 00:00 0      [stack]
>>>>
>>>> After commit 0b3bc3354eb9 ("arm64: vdso: Switch to generic storage
>>>> implementation"), the arm64 vvar grew slightly, and suddenly the brk
>>>> collided with the allocation.
>>>>
>>>> fffff7f20000-fffff7fde000 r-xp 00000000 fe:02 8110426 /sbin/ldconfig.real
>>>> fffff7fee000-fffff7ff5000 rw-p 000be000 fe:02 8110426 /sbin/ldconfig.real
>>>> fffff7ff5000-fffff7ffa000 rw-p 00000000 00:00 0
>>>> ***[oops, no room any more, vvar is at fffff7ffa000!]***
>>>> fffff7ffa000-fffff7ffe000 r--p 00000000 00:00 0       [vvar]
>>>> fffff7ffe000-fffff8000000 r-xp 00000000 00:00 0       [vdso]
>>>> fffffffdf000-1000000000000 rw-p 00000000 00:00 0      [stack]
>>
>> This change is fixing a pretty serious bug that appeared in v6.15-rc1 so I was
>> hoping it would make it into the v6.15 final release. I'm guessing mm is the
>> correct route in? But I don't currently see this in linus's tree or in any of
>> your mm- staging branches. Is there still time to get this in?
> 
> I'll be sending it to Linus this week. I've been letting it bake in
> -next for a while just to see if anything shakes out.

Sorry, Kees - my bad! For some reason, I thought this would go via the mm tree.
Thanks again for jumping on this.

