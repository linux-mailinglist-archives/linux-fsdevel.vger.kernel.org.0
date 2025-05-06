Return-Path: <linux-fsdevel+bounces-48218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DDCAAC0DC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 12:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 532211C26E9A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 10:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D508266B44;
	Tue,  6 May 2025 10:05:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15490262FD3;
	Tue,  6 May 2025 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746525940; cv=none; b=ewuSQ0GrW7Lmfcpj/KFJ6nAM5Uyib9KiiXZjBPIbie35FRPAngzg7yNuNp10+5Zj1q/ZPOIvNpbL+6kJCYQtmWXM/EI1rg0LoNcMMpipFHKuqPG7YahnvV3Xpx0rLPbhsT+lksw68ptal8+9xnP2QoixZ2qnyjgWQbmNdLYtFcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746525940; c=relaxed/simple;
	bh=cO+ESA8xlpPTuXuVM1MtTA6UZ8uvRadu715Dnt4GB7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dwDRZi4hXFskrvz06PZHgPud2yNtUwSQ9In820nIhOS+VlWVFCjbRFP/dkR412iaQihAAIyfL0jfVOLUfXWJeCEchB6USw/EMaGn9g36WDBrjbhV7MQdVW7VMaWWLxW2tHtgyMovpU1469NgkelkwVkL8zG8fr3+Re5t2DI3pgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1D0B113E;
	Tue,  6 May 2025 03:05:28 -0700 (PDT)
Received: from [10.57.93.118] (unknown [10.57.93.118])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 158083F5A1;
	Tue,  6 May 2025 03:05:35 -0700 (PDT)
Message-ID: <2a90ec6c-1725-4c32-8819-c46e8c0e4630@arm.com>
Date: Tue, 6 May 2025 11:05:34 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 0/5] Readahead tweaks for larger folios
Content-Language: en-GB
To: Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 David Hildenbrand <david@redhat.com>, Dave Chinner <david@fromorbit.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Kalesh Singh <kaleshsingh@google.com>, Zi Yan <ziy@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20250430145920.3748738-1-ryan.roberts@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250430145920.3748738-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/04/2025 15:59, Ryan Roberts wrote:
> Hi All,
> 
> This RFC series adds some tweaks to readahead so that it does a better job of
> ramping up folio sizes as readahead extends further into the file. And it
> additionally special-cases executable mappings to allow the arch to request a
> preferred folio size for text.
> 
> Previous versions of the series focussed on the latter part only (large folios
> for text). See [3]. But after discussion with Matthew Wilcox last week, we
> decided that we should really be fixing some of the unintended behaviours in how
> a folio size is selected in general before special-casing for text. As a result
> patches 1-4 make folio size selection behave more sanely, then patch 5
> introduces large folios for text. Patch 5 depends on patch 1, but does not
> depend on patches 2-4.
> 
> ---
> 
> I'm leaving this marked as RFC for now as I intend to do more testing, and
> haven't yet updated the benchmark results in patch 5 (although I expect them to
> be similar).

Thanks Jan, David and Anshuman for the reviews! I'll do the suggested changes
and complete my testing, then aim to post again against -rc1, to hopefully get
it into linux-next.

Thanks,
Ryan


> 
> Applies on top of Monday's mm-unstable (b18dec6a6ad3) and passes all mm
> kselftests.
> 
> Changes since v3 [3]
> ====================
> 
>  - Added patchs 1-4 to do better job of ramping up folio order
>  - In patch 5:
>    - Confine readahead blocks to vma boundaries (per Kalesh)
>    - Rename arch_exec_folio_order() to exec_folio_order() (per Matthew)
>    - exec_folio_order() now returns unsigned int and defaults to order-0
>      (per Matthew)
>    - readahead size is honoured (including when disabled)
> 
> Changes since v2 [2]
> ====================
> 
>  - Rename arch_wants_exec_folio_order() to arch_exec_folio_order() (per Andrew)
>  - Fixed some typos (per Andrew)
> 
> Changes since v1 [1]
> ====================
> 
>  - Remove "void" from arch_wants_exec_folio_order() macro args list
> 
> [1] https://lore.kernel.org/linux-mm/20240111154106.3692206-1-ryan.roberts@arm.com/
> [2] https://lore.kernel.org/all/20240215154059.2863126-1-ryan.roberts@arm.com/
> [3] https://lore.kernel.org/linux-mm/20250327160700.1147155-1-ryan.roberts@arm.com/
> 
> Thanks,
> Ryan
> 
> Ryan Roberts (5):
>   mm/readahead: Honour new_order in page_cache_ra_order()
>   mm/readahead: Terminate async readahead on natural boundary
>   mm/readahead: Make space in struct file_ra_state
>   mm/readahead: Store folio order in struct file_ra_state
>   mm/filemap: Allow arch to request folio size for exec memory
> 
>  arch/arm64/include/asm/pgtable.h |  8 +++++
>  include/linux/fs.h               |  4 ++-
>  include/linux/pgtable.h          | 11 +++++++
>  mm/filemap.c                     | 55 ++++++++++++++++++++++++--------
>  mm/internal.h                    |  3 +-
>  mm/readahead.c                   | 27 +++++++++-------
>  6 files changed, 81 insertions(+), 27 deletions(-)
> 
> --
> 2.43.0
> 


