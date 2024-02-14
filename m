Return-Path: <linux-fsdevel+bounces-11536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3B2854788
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 11:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CEC01C226C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 10:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6E418C3A;
	Wed, 14 Feb 2024 10:50:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751CC13FFC;
	Wed, 14 Feb 2024 10:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707907826; cv=none; b=tLA2itbq4+xIuQJ65eFGo+2EmPOr8wtSNG++R79T05k5+btLggOqN4GVMLqLf+D2jpCRgdzE8sqlBlKs6Ruh5tNoWofGYbkhxtdib30/kJ5IMP2nMTxsgtTketFd1tDZF7KBkDJ7fMEcEtCbrCt2Mj3w9oS8VvqTu3NXhntpSFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707907826; c=relaxed/simple;
	bh=sS/qjzjbnPW2D6JeEd3oPGOZMUVRw2tXtw9oHmDmz8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QKik7S27g9BL0ar1V082dmJCZyHsv0TGTgD6P/dh/1JbJCGPcscaJNt3+k10W+ub8LSYhC3hrP6v/EYEkmRshHVhOmll+SFHM2wbFK/e3JmLqVlUQDsocPKqPUVejs/cbFdKEZR7Zy//pfVbh1yoGflwYjMV/6ys02CCFe70CDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7259D1FB;
	Wed, 14 Feb 2024 02:51:04 -0800 (PST)
Received: from [10.57.64.120] (unknown [10.57.64.120])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 541673F766;
	Wed, 14 Feb 2024 02:50:20 -0800 (PST)
Message-ID: <66d4b27f-85e4-458e-8d66-54f800c5c65f@arm.com>
Date: Wed, 14 Feb 2024 10:50:18 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] Split a folio to any lower order folios
Content-Language: en-GB
To: Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, linux-mm@kvack.org,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Zach O'Keefe
 <zokeefe@google.com>, Hugh Dickins <hughd@google.com>,
 Mcgrof Chamberlain <mcgrof@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240213215520.1048625-1-zi.yan@sent.com>
 <659e1abb-40d0-42ba-ba0a-8256d7eb1c5a@redhat.com>
 <F4470D3A-DC2C-4A6A-B65C-1C94D732A60E@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <F4470D3A-DC2C-4A6A-B65C-1C94D732A60E@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/02/2024 22:31, Zi Yan wrote:
> On 13 Feb 2024, at 17:21, David Hildenbrand wrote:
> 
>> On 13.02.24 22:55, Zi Yan wrote:
>>> From: Zi Yan <ziy@nvidia.com>
>>>
>>> Hi all,
>>>
>>> File folio supports any order and multi-size THP is upstreamed[1], so both
>>> file and anonymous folios can be >0 order. Currently, split_huge_page()
>>> only splits a huge page to order-0 pages, but splitting to orders higher than
>>> 0 is going to better utilize large folios. In addition, Large Block
>>> Sizes in XFS support would benefit from it[2]. This patchset adds support for
>>> splitting a large folio to any lower order folios and uses it during file
>>> folio truncate operations.
>>>
>>> For Patch 6, Hugh did not like my approach to minimize the number of
>>> folios for truncate[3]. I would like to get more feedback, especially
>>> from FS people, on it to decide whether to keep it or not.
>>
>> I'm curious, would it make sense to exclude the "more" controversial parts (i.e., patch #6) for now, and focus on the XFS use case only?
> 
> Sure. Patch 6 was there to make use of split_huge_page_to_list_to_order().
> Now we have multi-size THP and XFS use cases, it can be dropped.

What are your plans for how to determine when to split THP and to what order? I
don't see anything in this series that would split anon THP to non-zero order?

We have talked about using hints from user space in the past (e.g.  mremap,
munmap, madvise, etc). But chrome has a use case where it temporarily mprotects
a single (4K) page as part of garbage collection (IIRC). If you eagerly split on
that hint, you will have lost the benefits of the large folio when it later
mprotects back to the original setting.

I guess David will suggest this would be a good use case for the khugepaged-lite
machanism we have been talking about. I dunno - it seems wasteful to split then
collapse again.

Or perhaps you're considering doing something clever in deferred split?

> 
> --
> Best Regards,
> Yan, Zi


