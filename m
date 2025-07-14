Return-Path: <linux-fsdevel+bounces-54809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36984B0386A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 09:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3C8188FA17
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 07:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4812367DF;
	Mon, 14 Jul 2025 07:54:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6C11E32C3;
	Mon, 14 Jul 2025 07:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752479684; cv=none; b=ob1mwy3PO9V/xf+zT/C9kRVeCYhoP00DcV8PeeaJLP5gf87Bn+nTUXkNNKJQvJF4fqGylBtKL0v5u3PdXvsBMgHJN0pAfmOnNsk8drfZFR0ZDcM04+H+Cx1Ff9h4Z86/rcpDUisYIh0oTrq1Way/G0MwC35nWiPGd0O07zJo8ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752479684; c=relaxed/simple;
	bh=LKmkiCjB6BwPZTEgjz3OMDum/iCBGoS907gFeSagfR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nonWRS/0QYIAyORdk7igAbdvVRM+KnfSWrM+nHcuBbpcRTHiaJMdQ0hGAIZ+Ux3eNPj22pcOHN+pvBoxqgZj5X2Q7JlqrfuyEFIB3vpFsAd62V0A084yJLGlpVoWAwttoOgUseBSR4/OYdYEM/GzOWGCCeV1w4vgJ3zW3Z+vqRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2772A1D70;
	Mon, 14 Jul 2025 00:54:31 -0700 (PDT)
Received: from [10.57.83.2] (unknown [10.57.83.2])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60B533F6A8;
	Mon, 14 Jul 2025 00:54:38 -0700 (PDT)
Message-ID: <1d515808-6589-4aa1-a363-f16bb6209b36@arm.com>
Date: Mon, 14 Jul 2025 08:54:36 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] readahead: Use folio_nr_pages() instead of shift
 operation
Content-Language: en-GB
To: Andrew Morton <akpm@linux-foundation.org>,
 Chi Zhiling <chizhiling@163.com>
Cc: David Hildenbrand <david@redhat.com>, willy@infradead.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Chi Zhiling <chizhiling@kylinos.cn>
References: <20250710060451.3535957-1-chizhiling@163.com>
 <479b493c-92c4-424a-a5c0-1c29a4325d15@redhat.com>
 <661ccfa4-a5ad-4370-a7f5-e17968d8a46e@163.com>
 <20250712152544.07f236ec277290c70a2a862f@linux-foundation.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250712152544.07f236ec277290c70a2a862f@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/07/2025 23:25, Andrew Morton wrote:
> On Sat, 12 Jul 2025 10:23:32 +0800 Chi Zhiling <chizhiling@163.com> wrote:
> 
>> On 2025/7/12 00:15, David Hildenbrand wrote:
>>> On 10.07.25 08:04, Chi Zhiling wrote:
>>>> From: Chi Zhiling <chizhiling@kylinos.cn>
>>>>
>>>> folio_nr_pages() is faster helper function to get the number of pages
>>>> when NR_PAGES_IN_LARGE_FOLIO is enabled.
>>>>
>>>> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
>>>> ---
>>>>   mm/readahead.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/readahead.c b/mm/readahead.c
>>>> index 95a24f12d1e7..406756d34309 100644
>>>> --- a/mm/readahead.c
>>>> +++ b/mm/readahead.c
>>>> @@ -649,7 +649,7 @@ void page_cache_async_ra(struct readahead_control 
>>>> *ractl,
>>>>        * Ramp up sizes, and push forward the readahead window.
>>>>        */
>>>>       expected = round_down(ra->start + ra->size - ra->async_size,
>>>> -            1UL << folio_order(folio));
>>>> +            folio_nr_pages(folio));
>>>>       if (index == expected) {
>>>>           ra->start += ra->size;
>>>>           /*
>>>
>>> This should probably get squashed in Ryans commit?
>>
>> I have no objection, it's up to Ryan.
> 
> "Ryans commit" is now c4602f9fa77f ("mm/readahead: store folio order in
> struct file_ra_state") in mm-stable.  I'd prefer not to rebase for this!
> 

Sorry about that... the function was previously using foilio_order() and storing
in a local variable and using it in 2 places, one of which was "1UL << order".
Because the other user went away I just moved the folio_order() call inline. But
agree folio_nr_pages() is better. FWIW:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>


