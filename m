Return-Path: <linux-fsdevel+bounces-35888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C8F9D9524
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 11:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B80D16633C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 10:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791061C4A3D;
	Tue, 26 Nov 2024 10:08:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8299F19340F;
	Tue, 26 Nov 2024 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732615722; cv=none; b=q/0SOyTNvfexWAAWgmnWuoE+aIc39k5TP+op85qz1er4O9iBrm7ASY4eF2Y85ZX8sTLPSsdIUvYYgxNnjmyluLtj/0qIf9mzabPsRcq3feg/LKz4HyTBfZINHIk1nm9nDSkExycBTfhunWT4zIBBPQeIlM05m9NE1YsNKuKwdTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732615722; c=relaxed/simple;
	bh=pIt8Uh7XfClRERpzHEdF1fpO0FNx1DOyLTgTCn5QUQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJWfZw/BMDhxKrM66J8tv8eZraCksi9tqEngh77TEdip9jV5CzjdnqACKUqb8R3lYMHvi6OXZKN5WqOCHbcGWM1Bh6/hIMor6iLmESz5ikdTI9nLQMZby/6SNaBZCTk0qzb5ZWypmF8b1iQTkwTPOzscmoj8HHczviMTit0EDoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D90021682;
	Tue, 26 Nov 2024 02:09:08 -0800 (PST)
Received: from [10.57.89.250] (unknown [10.57.89.250])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 002A03F5A1;
	Tue, 26 Nov 2024 02:08:34 -0800 (PST)
Message-ID: <7a674595-5392-4b5b-9614-79a3e9fd2773@arm.com>
Date: Tue, 26 Nov 2024 10:08:33 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 06/57] mm: Remove PAGE_SIZE compile-time constant
 assumption
Content-Language: en-GB
To: Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Christoph Lameter <cl@linux.com>, David Hildenbrand <david@redhat.com>,
 David Rientjes <rientjes@google.com>, Greg Marsden
 <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Michal Hocko <mhocko@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Miroslav Benes <mbenes@suse.cz>, Pekka Enberg <penberg@kernel.org>,
 Richard Weinberger <richard@nod.at>, Shakeel Butt <shakeel.butt@linux.dev>,
 Vignesh Raghavendra <vigneshr@ti.com>, Will Deacon <will@kernel.org>
Cc: cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-mtd@lists.infradead.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-6-ryan.roberts@arm.com>
 <d9089ef0-3abd-4148-949c-cab66890b98b@suse.cz>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <d9089ef0-3abd-4148-949c-cab66890b98b@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Vlastimil,

Sorry about the slow response to your review of this series - I'm just getting
to it now. Comment's below...

On 14/11/2024 10:17, Vlastimil Babka wrote:
> On 10/14/24 12:58, Ryan Roberts wrote:
>> To prepare for supporting boot-time page size selection, refactor code
>> to remove assumptions about PAGE_SIZE being compile-time constant. Code
>> intended to be equivalent when compile-time page size is active.
>>
>> Refactor "struct vmap_block" to use a flexible array for used_mmap since
>> VMAP_BBMAP_BITS is not a compile time constant for the boot-time page
>> size case.
>>
>> Update various BUILD_BUG_ON() instances to check against appropriate
>> page size limit.
>>
>> Re-define "union swap_header" so that it's no longer exactly page-sized.
>> Instead define a flexible "magic" array with a define which tells the
>> offset to where the magic signature begins.
>>
>> Consider page size limit in some CPP condditionals.
>>
>> Wrap global variables that are initialized with PAGE_SIZE derived values
>> using DEFINE_GLOBAL_PAGE_SIZE_VAR() so their initialization can be
>> deferred for boot-time page size builds.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>
>> ***NOTE***
>> Any confused maintainers may want to read the cover note here for context:
>> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
>>
>>  drivers/mtd/mtdswap.c         |  4 ++--
>>  include/linux/mm.h            |  2 +-
>>  include/linux/mm_types_task.h |  2 +-
>>  include/linux/mmzone.h        |  3 ++-
>>  include/linux/slab.h          |  7 ++++---
>>  include/linux/swap.h          | 17 ++++++++++++-----
>>  include/linux/swapops.h       |  6 +++++-
>>  mm/memcontrol.c               |  2 +-
>>  mm/memory.c                   |  4 ++--
>>  mm/mmap.c                     |  2 +-
>>  mm/page-writeback.c           |  2 +-
>>  mm/slub.c                     |  2 +-
>>  mm/sparse.c                   |  2 +-
>>  mm/swapfile.c                 |  2 +-
>>  mm/vmalloc.c                  |  7 ++++---
>>  15 files changed, 39 insertions(+), 25 deletions(-)
>>
> 
>> --- a/include/linux/swap.h
>> +++ b/include/linux/swap.h
>> @@ -132,10 +132,17 @@ static inline int current_is_kswapd(void)
>>   * bootbits...
>>   */
>>  union swap_header {
>> -	struct {
>> -		char reserved[PAGE_SIZE - 10];
>> -		char magic[10];			/* SWAP-SPACE or SWAPSPACE2 */
>> -	} magic;
>> +	/*
>> +	 * Exists conceptually, but since PAGE_SIZE may not be known at compile
>> +	 * time, we must access through pointer arithmetic at run time.
>> +	 *
>> +	 * struct {
>> +	 * 	char reserved[PAGE_SIZE - 10];
>> +	 * 	char magic[10];			   SWAP-SPACE or SWAPSPACE2
>> +	 * } magic;
>> +	 */
>> +#define SWAP_HEADER_MAGIC	(PAGE_SIZE - 10)
>> +	char magic[1];
> 
> I wonder if it makes sense to even keep this magic field anymore.
> 
>>  	struct {
>>  		char		bootbits[1024];	/* Space for disklabel etc. */
>>  		__u32		version;
>> @@ -201,7 +208,7 @@ struct swap_extent {
>>   * Max bad pages in the new format..
>>   */
>>  #define MAX_SWAP_BADPAGES \
>> -	((offsetof(union swap_header, magic.magic) - \
>> +	((SWAP_HEADER_MAGIC - \
>>  	  offsetof(union swap_header, info.badpages)) / sizeof(int))
>>  
>>  enum {
> 
> <snip>
> 
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -2931,7 +2931,7 @@ static unsigned long read_swap_header(struct swap_info_struct *p,
>>  	unsigned long swapfilepages;
>>  	unsigned long last_page;
>>  
>> -	if (memcmp("SWAPSPACE2", swap_header->magic.magic, 10)) {
>> +	if (memcmp("SWAPSPACE2", &swap_header->magic[SWAP_HEADER_MAGIC], 10)) {
> 
> I'd expect static checkers to scream here because we overflow the magic[1]
> both due to copying 10 bytes into 1 byte array and also with the insane
> offset. Hence my suggestion to drop the field and use purely pointer arithmetic.

Yeah, good point. I'll remove magic[] and use pointer arithmetic.

> 
>>  		pr_err("Unable to find swap-space signature\n");
>>  		return 0;
>>  	}
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index a0df1e2e155a8..b4fbba204603c 100644
> 
> Hm I'm actually looking at yourwip branch which also has:
> 
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -969,7 +969,7 @@ static inline int get_order_from_str(const char *size_str)
>         return -EINVAL;
>  }
> 
> -static char str_dup[PAGE_SIZE] __initdata;
> +static char str_dup[PAGE_SIZE_MAX] __initdata;
>  static int __init setup_thp_anon(char *str)
>  {
>         char *token, *range, *policy, *subtoken;
> 
> Why PAGE_SIZE_MAX? Isn't this the same case as "mm/memcontrol: Fix seq_buf
> size to save memory when PAGE_SIZE is large"

Hmm, you're probably right. I had a vague notion that "str", as passed into the
function, was guarranteed to be no bigger than PAGE_SIZE (perhaps I'm wrong). So
assumed that's where the original definition of str_dup[PAGE_SIZE] was coming from.

But I think your real question is "should the max size of str be a function of
PAGE_SIZE?". I think it could; there are more page orders that can legitimately
be described when the page size is bigger (at least for arm64). But in practice,
I'd expect any sane string for any page size to be easily within 4K.

So on that basis, I'll take your advice; changing this buffer to be 4K always.

Thanks,
Ryan



