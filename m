Return-Path: <linux-fsdevel+bounces-22522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB68D91858C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 17:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77425283086
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 15:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB2A18A935;
	Wed, 26 Jun 2024 15:18:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88604C14F;
	Wed, 26 Jun 2024 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719415116; cv=none; b=lKN/8niEYa3P9Ltoyra5o85jxgkYG0+24hI5eC2GxjFOApc0/7ONNdk4RbJYeQAhp/g4SWsR6qM5vacBgZlfG77pCtd0iBgTQzJnxcdJ6lbVF5NhEes09glNYY3IeOrAlWl9szGq+OJPDP7gXSHNf6766C+M6c0TFVEt8zzfzPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719415116; c=relaxed/simple;
	bh=xzGK5gElFzDIuGerOh8d5h+3JYL39U2ZTdXAHj6B4z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kF0Gxtq6Ze3mjBBlFt26bVQFiQhzTPVT8DpGsanjdVIhjUF+SIUBBTIMm6AgHQ41YGd1EcyoC7NV//I618l3HzhM7IDDjP22mTLnQy5RAGaz7TPdcvG9JW/21ApYvpmLcL0QhR2Yqmvp849n4uV1LVhB9MUR80ZYn8MftBkaIis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C24B339;
	Wed, 26 Jun 2024 08:18:53 -0700 (PDT)
Received: from [10.57.73.149] (unknown [10.57.73.149])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62AF03F73B;
	Wed, 26 Jun 2024 08:18:26 -0700 (PDT)
Message-ID: <5a31d145-19cd-4a35-9211-dc5091069596@arm.com>
Date: Wed, 26 Jun 2024 16:18:24 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] kpageflags: fix wrong KPF_THP on non-pmd-mappable
 compound pages
Content-Language: en-GB
To: Matthew Wilcox <willy@infradead.org>
Cc: Zi Yan <ziy@nvidia.com>, ran xiaokai <ranxiaokai627@163.com>,
 akpm@linux-foundation.org, vbabka@suse.cz, svetly.todorov@memverge.com,
 ran.xiaokai@zte.com.cn, baohua@kernel.org, peterx@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
References: <20240626024924.1155558-1-ranxiaokai627@163.com>
 <20240626024924.1155558-3-ranxiaokai627@163.com>
 <D29M7U8SPSYJ.39VMTRSKXW140@nvidia.com>
 <1907a8c0-9860-4ca0-be59-bec0e772332b@arm.com>
 <Znwwrnk77J0xfNxu@casper.infradead.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Znwwrnk77J0xfNxu@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/06/2024 16:15, Matthew Wilcox wrote:
> On Wed, Jun 26, 2024 at 12:07:04PM +0100, Ryan Roberts wrote:
>> On 26/06/2024 04:06, Zi Yan wrote:
>>> On Tue Jun 25, 2024 at 10:49 PM EDT, ran xiaokai wrote:
>>>> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>>>>
>>>> KPF_COMPOUND_HEAD and KPF_COMPOUND_TAIL are set on "common" compound
>>>> pages, which means of any order, but KPF_THP should only be set
>>>> when the folio is a 2M pmd mappable THP. 
>>
>> Why should KPF_THP only be set on 2M THP? What problem does it cause as it is
>> currently configured?
>>
>> I would argue that mTHP is still THP so should still have the flag. And since
>> these smaller mTHP sizes are disabled by default, only mTHP-aware user space
>> will be enabling them, so I'll naively state that it should not cause compat
>> issues as is.
>>
>> Also, the script at tools/mm/thpmaps relies on KPF_THP being set for all mTHP
>> sizes to function correctly. So that would need to be reworked if making this
>> change.
> 
> I told you you'd run into trouble calling them "mTHP" ...

"There are two hard things in computer science; naming, cache invalidation and
off-by-one errors"

