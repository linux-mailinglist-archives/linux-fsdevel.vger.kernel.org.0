Return-Path: <linux-fsdevel+bounces-17449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0543F8ADB9D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 03:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998981F22B69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 01:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E03134B2;
	Tue, 23 Apr 2024 01:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l3FIUBrF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61974125C0;
	Tue, 23 Apr 2024 01:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713836596; cv=none; b=ITBYFDrBCFjj9atsmbCNeqZKg46DpbzmOFY/obvvkXLIyNCxOpTjT11ygeuCHhioBm99WCU/tiRi/A7CYVZwOk2FBPS5FXCl5orWD6cO7yPPXBEPRjVsfejpTyRxruCqyx8JZP/S8oQAjOcFO0njWrVir96zXxEyv1TRc+t6Xlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713836596; c=relaxed/simple;
	bh=ovR/fTZaiy0FdoQF8M5FT2JPmb4Z72Q0cZC3jzVUYgM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SGS5iN4cHUYYiLUq5aT5CRMQS7GIj+NXdRr7TOJs1c4FIl6+0VhTcCt/JuMQaCJ9lltLfwMaB60X0q1CJ7Y0ZxXVGYRUg5Bba+DmeLr9B7RppT48TfjvRj6dPTHKmQkCleplGEPwYGSVZcv4jLCIoLZpBUbqR54sIbYUJ86D6OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l3FIUBrF; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713836594; x=1745372594;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ovR/fTZaiy0FdoQF8M5FT2JPmb4Z72Q0cZC3jzVUYgM=;
  b=l3FIUBrFFhJgKpIHNVjtGo2Pz0Y/TDdiYVERtJCPethaSWsgghWA7bBD
   RpPLr4CU1wNiQwAkLS2QLsLnXbqwlVZB5q2a+djScj0nz73QkD0sNqs8D
   Esz9O3+wMarnjG5nIPceZMLLGRKEt4/nyY93O0mAPC57tIR7FAhCSWuEm
   U/UEVDlxjFOX+Kn+QbsEsVxVFzwCoBDZi3WO0EcteCIkQRBQp1oyC8nds
   9Pr3roUzAoqJ43+n8z+2RNVeE4f3yHDBhUYzpRBJBIFCDAQEJ81nMrYcI
   I3HirGW+n3lJLqLkleDT28lQyuP8Eryz8B1qmFijk/s5xOvNntOJkL0Bq
   g==;
X-CSE-ConnectionGUID: 7ddMnC9WQdiY59C+RH1jKQ==
X-CSE-MsgGUID: EzLMEHIuTkG4jtZ67gEEsQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="26860202"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="26860202"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 18:43:13 -0700
X-CSE-ConnectionGUID: dcZRDwN0RoaTXrPXjf4Q3A==
X-CSE-MsgGUID: cRKEKfZwTxSjh9fsfV3c4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="28874803"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 18:43:10 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,  Kairui Song <kasong@tencent.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Matthew Wilcox <willy@infradead.org>,  Chris
 Li <chrisl@kernel.org>,  Barry Song <v-songbaohua@oppo.com>,  Ryan Roberts
 <ryan.roberts@arm.com>,  Neil Brown <neilb@suse.de>,  Minchan Kim
 <minchan@kernel.org>,  Hugh Dickins <hughd@google.com>,  David Hildenbrand
 <david@redhat.com>,  Yosry Ahmed <yosryahmed@google.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] mm/swap: get the swap file offset directly
In-Reply-To: <20240417160842.76665-7-ryncsn@gmail.com> (Kairui Song's message
	of "Thu, 18 Apr 2024 00:08:40 +0800")
References: <20240417160842.76665-1-ryncsn@gmail.com>
	<20240417160842.76665-7-ryncsn@gmail.com>
Date: Tue, 23 Apr 2024 09:41:17 +0800
Message-ID: <87mspkx3cy.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Kairui Song <ryncsn@gmail.com> writes:

> From: Kairui Song <kasong@tencent.com>
>
> folio_file_pos and page_file_offset are for mixed usage of swap cache
> and page cache, it can't be page cache here, so introduce a new helper
> to get the swap offset in swap file directly.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/page_io.c | 6 +++---
>  mm/swap.h    | 5 +++++
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/mm/page_io.c b/mm/page_io.c
> index ae2b49055e43..93de5aadb438 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -279,7 +279,7 @@ static void sio_write_complete(struct kiocb *iocb, long ret)
>  		 * be temporary.
>  		 */
>  		pr_err_ratelimited("Write error %ld on dio swapfile (%llu)\n",
> -				   ret, page_file_offset(page));
> +				   ret, swap_file_pos(page_swap_entry(page)));
>  		for (p = 0; p < sio->pages; p++) {
>  			page = sio->bvec[p].bv_page;
>  			set_page_dirty(page);
> @@ -298,7 +298,7 @@ static void swap_writepage_fs(struct folio *folio, struct writeback_control *wbc
>  	struct swap_iocb *sio = NULL;
>  	struct swap_info_struct *sis = swp_swap_info(folio->swap);
>  	struct file *swap_file = sis->swap_file;
> -	loff_t pos = folio_file_pos(folio);
> +	loff_t pos = swap_file_pos(folio->swap);
>  
>  	count_swpout_vm_event(folio);
>  	folio_start_writeback(folio);
> @@ -429,7 +429,7 @@ static void swap_read_folio_fs(struct folio *folio, struct swap_iocb **plug)
>  {
>  	struct swap_info_struct *sis = swp_swap_info(folio->swap);
>  	struct swap_iocb *sio = NULL;
> -	loff_t pos = folio_file_pos(folio);
> +	loff_t pos = swap_file_pos(folio->swap);
>  
>  	if (plug)
>  		sio = *plug;
> diff --git a/mm/swap.h b/mm/swap.h
> index fc2f6ade7f80..2de83729aaa8 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -7,6 +7,11 @@ struct mempolicy;
>  #ifdef CONFIG_SWAP
>  #include <linux/blk_types.h> /* for bio_end_io_t */
>  
> +static inline loff_t swap_file_pos(swp_entry_t entry)
> +{
> +	return ((loff_t)swp_offset(entry)) << PAGE_SHIFT;
> +}
> +
>  /* linux/mm/page_io.c */
>  int sio_pool_init(void);
>  struct swap_iocb;

I feel that the file concept for swap is kind of confusing.  From the
file cache point of view, one "struct address space" conresponds to one
file.  If so, we have a simple file system on a swap device (block
device backed or file backed), where the size of each file is 64M.  The
swap entry encode the file system (swap_type), the file name
(swap_offset >> SWAP_ADDRESS_SPACE_SHIFT), and the offset in file (lower
bits of swap_offset).

If the above definition is good, it's better to rename swap_file_pos()
to swap_dev_pos(), because it returns the swap device position of the
swap entry.

And, when we reaches consensus on the swap file related concept, we may
document it somewhere and review all naming in swap code to cleanup.

--
Best Regards,
Huang, Ying

