Return-Path: <linux-fsdevel+bounces-45165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4260FA73F46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 21:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D90371703AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 20:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9A31CEAA3;
	Thu, 27 Mar 2025 20:23:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FEC1C84B7;
	Thu, 27 Mar 2025 20:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743107004; cv=none; b=RXPKPpu3DX9hcwvWL3cF+hDG9NYycxh8aW/+quTqKTdxZpZIjTAOFuZaOUA7b3XxJ843HwxwKN3l7tsjuMfGZbti04wJ/jLCZ+waUUOEZBBppaJ4LsNwINBydD/N9z4D+hwwioWL7oSDn+Ep0iM2GiPUz4Fk+nSt6+BTcP4IZPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743107004; c=relaxed/simple;
	bh=M8X/u5Ol7Vve/jFOayTpPJNz9VSFpL6D8TqnZ2j6Kzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6BQlzJOilAp3hSSiUWed7Y3vdXzuLbquJdnVACmK0nPsYSlG55N06H67ZNrSV0CRTFTQ/TIDJHEAH7kT8q1WVJVTj4dfZny+o7adatCTNoAGKMMbj4dJdxCl6ZFsUPCgh3v+dwKKSQC1ANRd1aG6j6fmNVXTOlZsAvdqZexRQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C4271762;
	Thu, 27 Mar 2025 13:23:25 -0700 (PDT)
Received: from [10.57.86.101] (unknown [10.57.86.101])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0CEA3F694;
	Thu, 27 Mar 2025 13:23:17 -0700 (PDT)
Message-ID: <5131c7ad-cc37-44fc-8672-5866ecbef65b@arm.com>
Date: Thu, 27 Mar 2025 16:23:14 -0400
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
To: Matthew Wilcox <willy@infradead.org>,
 Kalesh Singh <kaleshsingh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Dave Chinner <david@fromorbit.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20250327160700.1147155-1-ryan.roberts@arm.com>
 <Z-WAbWfZzG1GA-4n@casper.infradead.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Z-WAbWfZzG1GA-4n@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+ Kalesh

On 27/03/2025 12:44, Matthew Wilcox wrote:
> On Thu, Mar 27, 2025 at 04:06:58PM +0000, Ryan Roberts wrote:
>> So let's special-case the read(ahead) logic for executable mappings. The
>> trade-off is performance improvement (due to more efficient storage of
>> the translations in iTLB) vs potential read amplification (due to
>> reading too much data around the fault which won't be used), and the
>> latter is independent of base page size. I've chosen 64K folio size for
>> arm64 which benefits both the 4K and 16K base page size configs and
>> shouldn't lead to any read amplification in practice since the old
>> read-around path was (usually) reading blocks of 128K. I don't
>> anticipate any write amplification because text is always RO.
> 
> Is there not also the potential for wasted memory due to ELF alignment?

I think this is an orthogonal issue? My change isn't making that any worse.

> Kalesh talked about it in the MM BOF at the same time that Ted and I
> were discussing it in the FS BOF.  Some coordination required (like
> maybe Kalesh could have mentioned it to me rathere than assuming I'd be
> there?)

I was at Kalesh's talk. David H suggested that a potential solution might be for
readahead to ask the fs where the next hole is and then truncate readahead to
avoid reading the hole. Given it's padding, nothing should directly fault it in
so it never ends up in the page cache. Not sure if you discussed anything like
that if you were talking in parallel?

Anyway, I'm not sure if you're suggesting these changes need to be considered as
one somehow or if you're just mentioning it given it is loosely related? My view
is that this change is an improvement indepently and could go in much sooner.

> 
>> +#define arch_exec_folio_order() ilog2(SZ_64K >> PAGE_SHIFT)
> 
> I don't think the "arch" really adds much value here.

I was following the pattern used by arch_wants_old_prefaulted_pte(),
arch_has_hw_pte_young(), etc. But I think you're right. I'll change as you suggest.

> 
> #define exec_folio_order()	get_order(SZ_64K)

ooh... get_order()... nice.

> 
>> +#ifndef arch_exec_folio_order
>> +/*
>> + * Returns preferred minimum folio order for executable file-backed memory. Must
>> + * be in range [0, PMD_ORDER]. Negative value implies that the HW has no
>> + * preference and mm will not special-case executable memory in the pagecache.
>> + */
>> +static inline int arch_exec_folio_order(void)
>> +{
>> +	return -1;
>> +}
> 
> This feels a bit fragile.  I often expect to be able to store an order
> in an unsigned int.  Why not return 0 instead?

Well 0 is a valid order, no? I think we have had the "is order signed or
unsigned" argument before. get_order() returns a signed int :)

Personally I'd prefer to keep it signed and use a negative value as the
sentinel. I don't think 0 is the right choice because it's a valid order. How
about returning unsigned int and use UINT_MAX as the sentinel?

#define EXEC_FOLIO_ORDER_NONE	UINT_MAX

static inline unsigned int arch_exec_folio_order(void)
{
	return EXEC_FOLIO_ORDER_NONE;
}

Thanks,
Ryan


