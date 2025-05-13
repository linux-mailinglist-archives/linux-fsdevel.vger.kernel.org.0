Return-Path: <linux-fsdevel+bounces-48888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87828AB54CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 14:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D7A4683D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 12:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B81628DEE9;
	Tue, 13 May 2025 12:33:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923001DF72E;
	Tue, 13 May 2025 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747139604; cv=none; b=bZ/ydH5tD9MAF8PNft8IllNeFZFfRIlFMtdr66CEIvOhPoJsWUbnsTfEToW29rcCg231Xr9EIwRkQt9oXmxH2LqVHxLtf9WmYYkoM3Sg1ibrDY1QA4l2acofWEjHq+MIvWkCRFVHBmwqKrz1h8pdFHGTUSIk/upuHiO8+2IHLkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747139604; c=relaxed/simple;
	bh=ZU5F8N+rQji5FbwDUVMKpeSS9/srGS2yqeyk5etfHIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=skA1pKp0/c5LH6Nm5Ts1Oo7i2F3KdjjFCTD/rjAGweBfI6fGOcnXPfKK0tzadnoVe/dNb1XrNSJYKVKWqqJHR28k5sqChsg/k5E4JVJc2TxBOCgFaqODchriLTJnAIEVpU2lrMuv5iYMHV35QfpoZRcG+/IFmG3NeZ6irEpf4cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 721171688;
	Tue, 13 May 2025 05:33:10 -0700 (PDT)
Received: from [10.1.25.187] (XHFQ2J9959.cambridge.arm.com [10.1.25.187])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EB513F5A1;
	Tue, 13 May 2025 05:33:19 -0700 (PDT)
Message-ID: <e57613f8-333a-4de4-b1a3-2d806ac8ee4f@arm.com>
Date: Tue, 13 May 2025 13:33:18 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 1/5] mm/readahead: Honour new_order in
 page_cache_ra_order()
Content-Language: en-GB
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 David Hildenbrand <david@redhat.com>, Dave Chinner <david@fromorbit.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Kalesh Singh <kaleshsingh@google.com>, Zi Yan <ziy@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, p.raghav@samsung.com
References: <20250430145920.3748738-1-ryan.roberts@arm.com>
 <20250430145920.3748738-2-ryan.roberts@arm.com>
 <nepi5e74wtghvr6a6n26rdgqaa7tzitylyoamfnzoqu6s5gq4h@zqtve2irigd6>
 <22e4167a-6ed0-4bda-86b8-a11c984f0a71@arm.com>
 <pskrpcu3lflo3pgeyfvnifcn7z2o6bsieaclntsbyvefs4ab3a@cyfnf36mccvi>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <pskrpcu3lflo3pgeyfvnifcn7z2o6bsieaclntsbyvefs4ab3a@cyfnf36mccvi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/05/2025 21:50, Pankaj Raghav (Samsung) wrote:
>>>>  
>>>
>>> So we always had a fallback to do_page_cache_ra() if the size of the
>>> readahead is less than 4 pages (16k). I think this was there because we
>>> were adding `2` to the new_order:
>>
>> If this is the reason for the magic number 4, then it's a bug in itself IMHO. 4
>> pages is only 16K when the page size is 4K; arm64 supports other page sizes. But
>> additionally, it's not just ra->size that dictates the final order of the folio;
>> it also depends on alignment in the file, EOF, etc.
>>
> 
> IIRC, initially we were not able to use order-1 folios[1], so we always
> did a fallback for any order < 2 using do_page_cache_ra(). I think that
> is where the magic order 2 (4 pages) is coming. Please someone can
> correct me if I am wrong.

Ahh, I see. That might have been where it came from, but IMHO, it still didn't
really belong there; just because the size is bigger than 4 pages, it doesn't
mean you would never want to use order-1 folios - there are alignment
considerations that can cause that. The logic in page_cache_ra_order() used to
know to avoid order-1.

> 
> But we don't have that limitation for file-backed folios anymore, so the
> fallback for ra->size < 4 is probably not needed. So the only time we do
> a fallback is if we don't support large folios.
> 
>> If we remove the fallback condition completely, things will still work out. So
>> unless someone can explain the reason for that condition (Matthew?), my vote
>> would be to remove it entirely.
> 
> I am actually fine with removing the first part of this fallback condition.
> But as I said, we still need to do a fallback if we don't support large folios.

Yep agreed. I'll make this change in the next version.

> 
> --
> Pankaj
> 
> [1] https://lore.kernel.org/all/ZH0GvxAdw1RO2Shr@casper.infradead.org/


