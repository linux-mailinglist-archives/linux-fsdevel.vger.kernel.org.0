Return-Path: <linux-fsdevel+bounces-49668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 893DDAC0AA9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 13:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17AA3B3EA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 11:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E8E28A41F;
	Thu, 22 May 2025 11:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJgLFVYb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAF2DF58;
	Thu, 22 May 2025 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747913510; cv=none; b=YF9wGltR8/2fJgTBvUjTYQoHc0aAXni4oepdrPkeop6mlJ7axc4TQpWKNhTkTGtcnTVdxGzmrzFimurdYdSK6NNVLs1ao0xyaCYPqB8Fkgtgk2lhcJMyUoAvaTEIipUTpp/gzwVx7dZx3/PdeErwgl64is4TPq/O7cjAxe9bml8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747913510; c=relaxed/simple;
	bh=Wh+9CNaey11qCTmNEpnWhOiC2XWB0qsO84H2HRuVPj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOzciMCr44glWceMsdPSVsjnNfpC94ufHDCyGYash+Dy6LwJt0rHRzZOw2ruXkLMmdJngwooiEw3p+6OqEgNCNZQR4uDSVg7fnFaNDc3Iv9FieLbfmY/AGiOKUgL1Dcb9GDsLrajcTwYSm8aQVMT554UMdIjvP7LFzLFa5qJurQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJgLFVYb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007A2C4CEE4;
	Thu, 22 May 2025 11:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747913510;
	bh=Wh+9CNaey11qCTmNEpnWhOiC2XWB0qsO84H2HRuVPj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OJgLFVYbYw/6KZT3isNE0iv42H39HSgV9c7TFTiIbYYRGDX5/+DY272LQlVLJ5oTD
	 vp9ZRnB6iuPnHxnWbFWv5tw0E3LLqdpWd4Jwz28Ow0xG7Q/I7REvBvAt/ZQ9pcre15
	 1FdKK1ZBIqsJMuWrT6l06GjK0HxHnL+32qrjY2vEodKWXeVPkaQvv5dcG9mvYsp6Vc
	 Gyj8B6gIkvduc6fKxuMsn8vp8PczW2q/JtuMTDo7/S0EzEXnLKvLCOf+3ojmuwcfFX
	 Mom1vfQ+SZNfMA+Zwvbl7S/Cw+9m0H+3spja5fSOPR7kyvic3VG7aeF5c0bTmDb4BB
	 sXvyGBd49XZJQ==
Date: Thu, 22 May 2025 14:31:36 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Ryan Roberts <ryan.roberts@arm.com>, Michal Hocko <mhocko@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Zi Yan <ziy@nvidia.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>, gost.dev@samsung.com,
	kernel@pankajraghav.com, hch@lst.de, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, willy@infradead.org, x86@kernel.org,
	mcgrof@kernel.org
Subject: Re: [RFC v2 0/2] add THP_HUGE_ZERO_PAGE_ALWAYS config option
Message-ID: <aC8LGDwJXvlDl866@kernel.org>
References: <20250522090243.758943-1-p.raghav@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522090243.758943-1-p.raghav@samsung.com>

Hi Pankaj,

On Thu, May 22, 2025 at 11:02:41AM +0200, Pankaj Raghav wrote:
> There are many places in the kernel where we need to zeroout larger
> chunks but the maximum segment we can zeroout at a time by ZERO_PAGE
> is limited by PAGE_SIZE.
> 
> This concern was raised during the review of adding Large Block Size support
> to XFS[1][2].
> 
> This is especially annoying in block devices and filesystems where we
> attach multiple ZERO_PAGEs to the bio in different bvecs. With multipage
> bvec support in block layer, it is much more efficient to send out
> larger zero pages as a part of a single bvec.
> 
> Some examples of places in the kernel where this could be useful:
> - blkdev_issue_zero_pages()
> - iomap_dio_zero()
> - vmalloc.c:zero_iter()
> - rxperf_process_call()
> - fscrypt_zeroout_range_inline_crypt()
> - bch2_checksum_update()
> ...
> 
> We already have huge_zero_folio that is allocated on demand, and it will be
> deallocated by the shrinker if there are no users of it left.
> 
> But to use huge_zero_folio, we need to pass a mm struct and the
> put_folio needs to be called in the destructor. This makes sense for
> systems that have memory constraints but for bigger servers, it does not
> matter if the PMD size is reasonable (like x86).
> 
> Add a config option THP_HUGE_ZERO_PAGE_ALWAYS that will always allocate
> the huge_zero_folio, and it will never be freed. This makes using the
> huge_zero_folio without having to pass any mm struct and a call to put_folio
> in the destructor.

I don't think this config option should be tied to THP. It's perfectly
sensible to have a configuration with HUGETLB and without THP.
 
> I have converted blkdev_issue_zero_pages() as an example as a part of
> this series.
> 
> I will send patches to individual subsystems using the huge_zero_folio
> once this gets upstreamed.
> 
> Looking forward to some feedback.
> 
> [1] https://lore.kernel.org/linux-xfs/20231027051847.GA7885@lst.de/
> [2] https://lore.kernel.org/linux-xfs/ZitIK5OnR7ZNY0IG@infradead.org/
> 
> Changes since v1:
> - Added the config option based on the feedback from David.
> - Removed iomap patches so that I don't clutter this series with too
>   many subsystems.
> 
> Pankaj Raghav (2):
>   mm: add THP_HUGE_ZERO_PAGE_ALWAYS config option
>   block: use mm_huge_zero_folio in __blkdev_issue_zero_pages()
> 
>  arch/x86/Kconfig |  1 +
>  block/blk-lib.c  | 15 +++++++++---
>  mm/Kconfig       | 12 +++++++++
>  mm/huge_memory.c | 63 ++++++++++++++++++++++++++++++++++++++----------
>  4 files changed, 74 insertions(+), 17 deletions(-)
> 
> 
> base-commit: f1f6aceb82a55f87d04e2896ac3782162e7859bd
> -- 
> 2.47.2
> 
> 

-- 
Sincerely yours,
Mike.

