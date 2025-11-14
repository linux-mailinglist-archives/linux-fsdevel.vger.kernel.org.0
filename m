Return-Path: <linux-fsdevel+bounces-68541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B9FC5F0E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 20:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54B13AE4D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 19:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C012F39CB;
	Fri, 14 Nov 2025 19:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mU8IFYUW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA9C2EC541
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 19:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763148987; cv=none; b=ENtPfP3suXByv5XbPclzY8eATmdlQ7D1tyfFDBS5xtXE9fwl83hHzJVN4fX32zzVDgoXEfUiIXLbV3mQkSs3gVIrcocZaa/I9YvGDme5wRGJzyqF42OeIi1VcdndFxxKIx9DI/kdn3ki8nhDu3CIh7XCs4Ff7MARbbdcABcf25Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763148987; c=relaxed/simple;
	bh=rui8hDHDCQYjQDpuio04Hq62leR8+4upRjLduKpcWos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aY5EVSVwIqiIZuE42GyICC7PAO9lc1lSr/0WIrHxhBq8CeKjVOfzeX2Cy7jFMQkkRSI/a0m57WLQR09QutiEa8BFcdzpX33DtN/QlEwCvVvU/shKJ7k6kzvDgcDiETPSs+Y+NXCJuT8/e677KYFHA+lyA3tzFOBHXyXN0z82x0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mU8IFYUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21F1C4CEF1;
	Fri, 14 Nov 2025 19:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763148986;
	bh=rui8hDHDCQYjQDpuio04Hq62leR8+4upRjLduKpcWos=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mU8IFYUWw07F/uQC28N2CLFMhcPB/IHxYQB3lR0HI9pQer2Cwc+f7NX1a3H26Bkd4
	 B2X34MFP5qGNEVNrfiyqx3mItOigr5bco2B+rTSX2FyBQY+PpgWvPKoFI2/KYmsXdt
	 baJv7SMcwbqk8aLYEI/aPV4DZTTaBV23ihLqDQ1WeZSvBwm37s/cmOr6Rk1Sn4kkDr
	 c7BDszuGwvFwIPQ5/jQN3bD1z9yEfVimW1HWkduU7oBqKuSrbWOcjOe5qj2Iu1m4vD
	 CKKUq5ITwnkKYD1eDznzMH65TVBDKZUm0xL5rbYZ/ryhmySjCmAYlv+NAavRYQ5xAp
	 7hEBYloe69PHg==
Message-ID: <64b43302-e8cc-4259-9fa1-e27721c0d193@kernel.org>
Date: Fri, 14 Nov 2025 20:36:20 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: consolidate order-related checks into
 folio_split_supported()
To: Wei Yang <richard.weiyang@gmail.com>
Cc: willy@infradead.org, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20251114075703.10434-1-richard.weiyang@gmail.com>
 <827fd8d8-c327-4867-9693-ec06cded55a9@kernel.org>
 <20251114150310.eua55tcgxl4mgdnp@master>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251114150310.eua55tcgxl4mgdnp@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.11.25 16:03, Wei Yang wrote:
> On Fri, Nov 14, 2025 at 09:49:34AM +0100, David Hildenbrand (Red Hat) wrote:
>> On 14.11.25 08:57, Wei Yang wrote:
>>> The primary goal of the folio_split_supported() function is to validate
>>> whether a folio is suitable for splitting and to bail out early if it is
>>> not.
>>>
>>> Currently, some order-related checks are scattered throughout the
>>> calling code rather than being centralized in folio_split_supported().
>>>
>>> This commit moves all remaining order-related validation logic into
>>> folio_split_supported(). This consolidation ensures that the function
>>> serves its intended purpose as a single point of failure and improves
>>> the clarity and maintainability of the surrounding code.
>>
>> Combining the EINVAL handling sounds reasonable.
>>
> 
> You mean:
> 
> This commit combines the EINVAL handling logic into folio_split_supported().
> This consolidation ... ?

It was not a suggestion to change, it was rather only a comment from my 
side :)

[...]

>>
>> The mapping_max_folio_order() check is new now. What is the default value of that? Is it always initialized properly?
>>
> 
> Not sure "is new now" means what?
> 
> Original check use mapping_large_folio_support() which calls
> mapping_max_folio_order(). It looks not new to me.

Right, but we did not actually care about the exact value.

IOW, we didn't check for order <= mapping_max_folio_order() before.

SO I'm just curious if that is universally fine.

-- 
Cheers

David

