Return-Path: <linux-fsdevel+bounces-11576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B022C854E5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 17:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D537B1C284D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 16:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893ED61679;
	Wed, 14 Feb 2024 16:25:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8496A013;
	Wed, 14 Feb 2024 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927914; cv=none; b=iLdAsyJ1LmlfSM9LsBVw/OuRaOkrW+DuBE/hs5gpU1K37+xd5V3SNclI9o84bCSgHOnIExOIp1TaCq4zaKFX6eO/em1DnHMiRw65x76vRehwjwC7pBiHlLmWqUM+LTCg01k2+p0ovlqn7jDAX2ra9Ivu8FnLIUsn7aF64pDSZNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927914; c=relaxed/simple;
	bh=Iz4EgZOSFR1zigQnY5oEHTIwS7VOPzZ8Ty+S62gU0GM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HSp3LTGlL9/0OBaMaOgeXSM2e6lLzO37ktcoxVoCHqyutk07E6wayDHgowDOIkRAPuZq0Q0akK7YR6syHtT1QhE4l5+Ci2A5PHqZVPrzTyn+ckbwdPekKA8q3sZoL0ugixZGJnmVqE/D5JwVHrQ+jUpkc6AjIvVR3wy/0eX65AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4018E1FB;
	Wed, 14 Feb 2024 08:25:52 -0800 (PST)
Received: from [10.57.64.120] (unknown [10.57.64.120])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFAD03F762;
	Wed, 14 Feb 2024 08:25:08 -0800 (PST)
Message-ID: <48e15a5a-b8e8-4ed7-91df-049f5525f648@arm.com>
Date: Wed, 14 Feb 2024 16:25:07 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] mm: truncate: split huge page cache page to a
 non-zero order if possible.
Content-Language: en-GB
To: Zi Yan <ziy@nvidia.com>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, linux-mm@kvack.org,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Yang Shi <shy828301@gmail.com>,
 Yu Zhao <yuzhao@google.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Zach O'Keefe
 <zokeefe@google.com>, Hugh Dickins <hughd@google.com>,
 Mcgrof Chamberlain <mcgrof@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240213215520.1048625-1-zi.yan@sent.com>
 <20240213215520.1048625-7-zi.yan@sent.com>
 <cbb1d6a0-66dd-47d0-8733-f836fe050374@arm.com>
 <1C274CBB-C809-442E-9575-858460C0F62D@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <1C274CBB-C809-442E-9575-858460C0F62D@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/02/2024 16:19, Zi Yan wrote:
> On 14 Feb 2024, at 5:43, Ryan Roberts wrote:
> 
>> On 13/02/2024 21:55, Zi Yan wrote:
>>> From: Zi Yan <ziy@nvidia.com>
>>>
>>> To minimize the number of pages after a huge page truncation, we do not
>>> need to split it all the way down to order-0. The huge page has at most
>>> three parts, the part before offset, the part to be truncated, the part
>>> remaining at the end. Find the greatest common divisor of them to
>>> calculate the new page order from it, so we can split the huge
>>> page to this order and keep the remaining pages as large and as few as
>>> possible.
>>>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> ---
>>>  mm/truncate.c | 21 +++++++++++++++++++--
>>>  1 file changed, 19 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mm/truncate.c b/mm/truncate.c
>>> index 725b150e47ac..49ddbbf7a617 100644
>>> --- a/mm/truncate.c
>>> +++ b/mm/truncate.c
>>> @@ -21,6 +21,7 @@
>>>  #include <linux/task_io_accounting_ops.h>
>>>  #include <linux/shmem_fs.h>
>>>  #include <linux/rmap.h>
>>> +#include <linux/gcd.h>
>>>  #include "internal.h"
>>>
>>>  /*
>>> @@ -210,7 +211,8 @@ int truncate_inode_folio(struct address_space *mapping, struct folio *folio)
>>>  bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
>>>  {
>>>  	loff_t pos = folio_pos(folio);
>>> -	unsigned int offset, length;
>>> +	unsigned int offset, length, remaining;
>>> +	unsigned int new_order = folio_order(folio);
>>>
>>>  	if (pos < start)
>>>  		offset = start - pos;
>>> @@ -221,6 +223,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
>>>  		length = length - offset;
>>>  	else
>>>  		length = end + 1 - pos - offset;
>>> +	remaining = folio_size(folio) - offset - length;
>>>
>>>  	folio_wait_writeback(folio);
>>>  	if (length == folio_size(folio)) {
>>> @@ -235,11 +238,25 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
>>>  	 */
>>>  	folio_zero_range(folio, offset, length);
>>>
>>> +	/*
>>> +	 * Use the greatest common divisor of offset, length, and remaining
>>> +	 * as the smallest page size and compute the new order from it. So we
>>> +	 * can truncate a subpage as large as possible. Round up gcd to
>>> +	 * PAGE_SIZE, otherwise ilog2 can give -1 when gcd/PAGE_SIZE is 0.
>>> +	 */
>>> +	new_order = ilog2(round_up(gcd(gcd(offset, length), remaining),
>>> +				   PAGE_SIZE) / PAGE_SIZE);
>>
>> Given you have up to 2 regions remaining, isn't it possible that you want a
>> different order for both those regions (or even multiple orders within the same
>> region)? I guess you just choose gcd for simplicity?
> 
> Right. You raise the same concern as Hugh[1]. I am minimizing the call of
> split_huge_page_to_list_to_order() and you and Hugh want to minimize the
> number of folios after the split. Yours will give better outcome after split,
> but requires either multiple calls or a more sophisticated implementation
> of page split[2]. We probably can revisit this once splitting to any order
> gets wider use.

Yeah, fair enough. Sorry hadn't read Hugh's original feedback.

> 
>>> +
>>> +	/* order-1 THP not supported, downgrade to order-0 */
>>> +	if (new_order == 1)
>>> +		new_order = 0;
>>
>> I guess this would need to change if supporting order-1 file folios?
> 
> Right.
> 
>>> +
>>> +
>>>  	if (folio_has_private(folio))
>>>  		folio_invalidate(folio, offset, length);
>>>  	if (!folio_test_large(folio))
>>>  		return true;
>>> -	if (split_folio(folio) == 0)
>>> +	if (split_huge_page_to_list_to_order(&folio->page, NULL, new_order) == 0)
>>
>> I know you are discussing removing this patch, but since you created
>> split_folio_to_order() wouldn't that be better here?
> 
> Sure. Will change the patch locally.
> 
> [1] https://lore.kernel.org/linux-mm/9dd96da-efa2-5123-20d4-4992136ef3ad@google.com/
> [2] https://lore.kernel.org/linux-mm/0AC0520E-1BD2-497E-A7ED-05394400BFC9@nvidia.com/
> 
> --
> Best Regards,
> Yan, Zi


