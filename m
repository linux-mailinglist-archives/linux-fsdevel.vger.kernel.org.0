Return-Path: <linux-fsdevel+bounces-23145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BAF927A82
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 17:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 194391F26949
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 15:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDCB1B1433;
	Thu,  4 Jul 2024 15:52:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BDF1E485;
	Thu,  4 Jul 2024 15:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720108341; cv=none; b=DWBikzEQQb8CcJQL+1fuR6sBHrbD3ldjUxk0VND5OcfJYHPiyJ/n2T2GLSiw3XklK/Yi2xQsd6KtuAModsGjXbr9iCcJ/nj86aUKxS6Lwt5AP/fWeiDCx/QJ4njlI7t3ksyHTyKraC6e29hPTntYBgzras/Fa0SYLqroIwzHl3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720108341; c=relaxed/simple;
	bh=v/JZndJ3TSeZn+H9Ggq0qeNbT49AQLqAKBK8nHHxHT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KLryVxRMggE8UyG8fSB2htHpMGcEj1xWtYuK5JwuiemIU1MgOCSmUkUvKlRVtno2ltBL72oMsZma113VHi+lBuyxFZ0W4r29C2rKWgqBayA40WKuAMV2kMi7/Z7M4mBP7bvcHLIE3r8IyYaPkicrIH2FTwTQBgZKZHWBakfYCDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51A45367;
	Thu,  4 Jul 2024 08:52:43 -0700 (PDT)
Received: from [10.1.29.168] (XHFQ2J9959.cambridge.arm.com [10.1.29.168])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45BC53F762;
	Thu,  4 Jul 2024 08:52:15 -0700 (PDT)
Message-ID: <4b6ca560-03e7-4fd2-8b4b-acfc75bdb925@arm.com>
Date: Thu, 4 Jul 2024 16:52:13 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/10] fs: Allow fine-grained control of folio sizes
Content-Language: en-GB
To: Matthew Wilcox <willy@infradead.org>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, david@fromorbit.com,
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Zoa9rQbEUam467-q@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/07/2024 16:20, Matthew Wilcox wrote:
> On Thu, Jul 04, 2024 at 01:23:20PM +0100, Ryan Roberts wrote:
>>> -	AS_LARGE_FOLIO_SUPPORT = 6,
>>
>> nit: this removed enum is still referenced in a comment further down the file.
> 
> Thanks.  Pankaj, let me know if you want me to send you a patch or if
> you'll do it directly.
> 
>>> +	/* Bits 16-25 are used for FOLIO_ORDER */
>>> +	AS_FOLIO_ORDER_BITS = 5,
>>> +	AS_FOLIO_ORDER_MIN = 16,
>>> +	AS_FOLIO_ORDER_MAX = AS_FOLIO_ORDER_MIN + AS_FOLIO_ORDER_BITS,
>>
>> nit: These 3 new enums seem a bit odd.
> 
> Yes, this is "too many helpful suggestions" syndrome.  It made a lot
> more sense originally.

Well now you can add my "helpful" suggestion to that list :)

> 
> https://lore.kernel.org/linux-fsdevel/ZlUQcEaP3FDXpCge@dread.disaster.area/
> 
>>> +static inline void mapping_set_folio_order_range(struct address_space *mapping,
>>> +						 unsigned int min,
>>> +						 unsigned int max)
>>> +{
>>> +	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
>>> +		return;
>>> +
>>> +	if (min > MAX_PAGECACHE_ORDER)
>>> +		min = MAX_PAGECACHE_ORDER;
>>> +	if (max > MAX_PAGECACHE_ORDER)
>>> +		max = MAX_PAGECACHE_ORDER;
>>> +	if (max < min)
>>> +		max = min;
>>
>> It seems strange to silently clamp these? Presumably for the bs>ps usecase,
>> whatever values are passed in are a hard requirement? So wouldn't want them to
>> be silently reduced. (Especially given the recent change to reduce the size of
>> MAX_PAGECACHE_ORDER to less then PMD size in some cases).
> 
> Hm, yes.  We should probably make this return an errno.  Including
> returning an errno for !IS_ENABLED() and min > 0.

Right.

> 
>>> -	if (new_order < MAX_PAGECACHE_ORDER) {
>>> +	if (new_order < mapping_max_folio_order(mapping)) {
>>>  		new_order += 2;
>>> -		new_order = min_t(unsigned int, MAX_PAGECACHE_ORDER, new_order);
>>> +		new_order = min(mapping_max_folio_order(mapping), new_order);
>>>  		new_order = min_t(unsigned int, new_order, ilog2(ra->size));
>>
>> I wonder if its possible that ra->size could ever be less than
>> mapping_min_folio_order()? Do you need to handle that?
> 
> I think we take care of that in later patches? 

Yes I saw that once I got to it. You can ignore this.

> This patch is mostly
> about honouring the max properly and putting in the infrastructure for
> the min, but not doing all the necessary work for min.


