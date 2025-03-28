Return-Path: <linux-fsdevel+bounces-45211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 839C9A74BEF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 15:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949513AF50A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 13:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540D5221F09;
	Fri, 28 Mar 2025 13:50:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77947221555;
	Fri, 28 Mar 2025 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743169858; cv=none; b=XpwSljEvdmB01nPsorg8yQT909+vq9ltPM/AoYoV0y5UyifGuOnA7u+Vs61Q7/oNzObRD10UtXesD8tiqSIfHQivwRQ33Wxhg/ribD68EZ04oPjSgauwYKZPDca8i0nIDsdjOJZSkqgjG4oOPNgwJ2nipU31zhZRtHv0TOItsRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743169858; c=relaxed/simple;
	bh=kB0O55JTvtBtlL5U/x7kW4cl6qxP+ll8Aivlmj9ntwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y6w5zxyX+T+cIEFzfnCoxIWtC9FNm1BaxcqrYhJqAGlCFPf3OiQGCf3FmT0dw+x5jcCzTBH7fQnCNlPTEyFSCIOcLRhptnAwdLpwcZ9hpjxb3TLLUdYmot2C6aTYeKvGRBf636+ytCLBHzb7Yq+41rZU0PT3ckJwg5n5OLFlqKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98F041691;
	Fri, 28 Mar 2025 06:50:59 -0700 (PDT)
Received: from [10.57.87.112] (unknown [10.57.87.112])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1646F3F63F;
	Fri, 28 Mar 2025 06:50:52 -0700 (PDT)
Message-ID: <ef307875-1fa1-45f4-8e42-ab78d87b3582@arm.com>
Date: Fri, 28 Mar 2025 13:50:51 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/filemap: Allow arch to request folio size for exec
 memory
Content-Language: en-GB
To: Zi Yan <ziy@nvidia.com>
Cc: Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Dave Chinner <david@fromorbit.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20250327160700.1147155-1-ryan.roberts@arm.com>
 <Z-WAbWfZzG1GA-4n@casper.infradead.org>
 <731D8D6E-52A0-4144-A2BB-7243BFACC92D@nvidia.com>
 <dfc06a39-3d92-4995-ab06-c552e351f7c8@arm.com>
 <8DEB30F0-52D0-4857-9BAC-CDAC045A396E@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <8DEB30F0-52D0-4857-9BAC-CDAC045A396E@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/03/2025 09:32, Zi Yan wrote:
> On 28 Mar 2025, at 9:09, Ryan Roberts wrote:
> 
>> On 27/03/2025 20:07, Zi Yan wrote:
>>> On 27 Mar 2025, at 12:44, Matthew Wilcox wrote:
>>>
>>>> On Thu, Mar 27, 2025 at 04:06:58PM +0000, Ryan Roberts wrote:
>>>>> So let's special-case the read(ahead) logic for executable mappings. The
>>>>> trade-off is performance improvement (due to more efficient storage of
>>>>> the translations in iTLB) vs potential read amplification (due to
>>>>> reading too much data around the fault which won't be used), and the
>>>>> latter is independent of base page size. I've chosen 64K folio size for
>>>>> arm64 which benefits both the 4K and 16K base page size configs and
>>>>> shouldn't lead to any read amplification in practice since the old
>>>>> read-around path was (usually) reading blocks of 128K. I don't
>>>>> anticipate any write amplification because text is always RO.
>>>>
>>>> Is there not also the potential for wasted memory due to ELF alignment?
>>>> Kalesh talked about it in the MM BOF at the same time that Ted and I
>>>> were discussing it in the FS BOF.  Some coordination required (like
>>>> maybe Kalesh could have mentioned it to me rathere than assuming I'd be
>>>> there?)
>>>>
>>>>> +#define arch_exec_folio_order() ilog2(SZ_64K >> PAGE_SHIFT)
>>>>
>>>> I don't think the "arch" really adds much value here.
>>>>
>>>> #define exec_folio_order()	get_order(SZ_64K)
>>>
>>> How about AMD’s PTE coalescing, which does PTE compression at
>>> 16KB or 32KB level? It covers 4 16KB and 2 32KB, at least it will
>>> not hurt AMD PTE coalescing. Starting with 64KB across all arch
>>> might be simpler to see the performance impact. Just a comment,
>>> no objection. :)
>>
>> exec_folio_order() is defined per-architecture and SZ_64K is the arm64 preferred
>> size. At the moment x86 is not opted in, but they could choose to opt in with
>> 32K (or whatever else makese sense) if the HW supports coalescing.
> 
> Oh, I missed that part. I thought, since arch_ is not there, it was the same
> for all arch.
> >>
>> I'm not sure if you thought this was global and are arguing against that, or if
>> you are arguing for it to be global because it will more easily show us
>> performance regressions earlier if x86 is doing this too?
> 
> I thought it was global. It might be OK to set it global and let different arch
> to optimize it as it rolls out. Opt-in might be "never" until someone looks
> into it, but if it is global and it changes performance, people will notice
> and look into it.

Ahh now that we are both clear, I'd prefer to stick with the policy as
implemented; exec_folio_order() defaults to "use the existing readahead method"
but can be overridden by arches (arm64) that want specific behaviour (64K folios).

> 
> --
> Best Regards,
> Yan, Zi


