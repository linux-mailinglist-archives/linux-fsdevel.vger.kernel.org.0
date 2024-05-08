Return-Path: <linux-fsdevel+bounces-19004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 820E78BF640
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 08:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CB771C224D1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 06:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403B6182C5;
	Wed,  8 May 2024 06:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TQgn9kBN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D90C384;
	Wed,  8 May 2024 06:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715149836; cv=none; b=lMvflIY09WGyG81WKOqpldgWHt7guTyh1CoOAuxkl79hvgv7aiyFqPtPHGmjjkQMDLGQ9d+H6dEXuvAqqqHmgpYcgXpFxcfKWCwbydTBPMvnCAIsNRNhCWc45YqJFAeF91xZyGB8X4Sf9ugGmFxhGmYdHUofOkQ8mVFqt2IkZEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715149836; c=relaxed/simple;
	bh=5jxRy94UaFRt03ZEYe2d4KvQGZLYJ8qOnRbCZ8mahzk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=amnz5KLsk3hmGjZ3aabQyUxyOLY3xDxLo563Py2rquvi4cBABFaxHds7TaKc6pvg1vdiNnhkiFWNJPZRQ6EmpWAFAcHhX5OclJ7UB53OyCoin8BzVCQdTRq3CA41Dh2NR0xcvd3z6w5zf127qSxayXQBbi5gK31dS6lJx4IeKQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TQgn9kBN; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715149835; x=1746685835;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=5jxRy94UaFRt03ZEYe2d4KvQGZLYJ8qOnRbCZ8mahzk=;
  b=TQgn9kBNX2uiNerJtvLzEymcI8qFf6VKsADBDQIDoV+LOTtimW4NQFB5
   A/AaUjbMHqURq68G0Znj172BM94zjEzNT2icP6cJTlkYOEXm90QCKdaZn
   mQAP/iZYyuMIP/TYgeaoW8XDk7PA4/pk1+2SM24Mf+s79tfsPxiMJf7Dr
   YHmluYgy8qDKy86MnKvlzFujdV1wJQ7/bRrWre49WOGAnB5xVGXGvD6Fg
   xQeqdsuKREqjczdOQtbUMeqsighoN8PwEiuEZx68GS+BHQ58CVsEcPoIk
   3e8SK4CaibBkqXlMnWlcb2Br8hKQL4OeiapVAaRyL28CBWHU+pgARCgMh
   A==;
X-CSE-ConnectionGUID: 8qyn6g5MRuSkoUTNh7uN7w==
X-CSE-MsgGUID: t+FF2jRhSwO1XKRot+tMhw==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="10856015"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="10856015"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 23:30:34 -0700
X-CSE-ConnectionGUID: aQ/0s7eNRzG6JHjbKHdLBg==
X-CSE-MsgGUID: dak9a4neSL+mA6jf6j99og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="33330313"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 23:30:30 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,  Kairui Song <kasong@tencent.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Matthew Wilcox <willy@infradead.org>,  Chris
 Li <chrisl@kernel.org>,  Barry Song <v-songbaohua@oppo.com>,  Ryan Roberts
 <ryan.roberts@arm.com>,  Neil Brown <neilb@suse.de>,  Minchan Kim
 <minchan@kernel.org>,  Hugh Dickins <hughd@google.com>,  David Hildenbrand
 <david@redhat.com>,  Yosry Ahmed <yosryahmed@google.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/12] mm/swap: get the swap device offset directly
In-Reply-To: <20240502084939.30250-2-ryncsn@gmail.com> (Kairui Song's message
	of "Thu, 2 May 2024 16:49:36 +0800")
References: <20240502084609.28376-1-ryncsn@gmail.com>
	<20240502084939.30250-2-ryncsn@gmail.com>
Date: Wed, 08 May 2024 14:28:38 +0800
Message-ID: <87edaclsvd.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
> to get the swap offset in swap device directly.
>
> Need to include swapops.h in mm/swap.h to ensure swp_offset is always
> defined before use.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>

LGTM!  Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> ---
>  mm/page_io.c | 6 +++---
>  mm/swap.h    | 9 +++++++++
>  2 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 46c603dddf04..a360857cf75d 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -280,7 +280,7 @@ static void sio_write_complete(struct kiocb *iocb, long ret)
>  		 * be temporary.
>  		 */
>  		pr_err_ratelimited("Write error %ld on dio swapfile (%llu)\n",
> -				   ret, page_file_offset(page));
> +				   ret, swap_dev_pos(page_swap_entry(page)));
>  		for (p = 0; p < sio->pages; p++) {
>  			page = sio->bvec[p].bv_page;
>  			set_page_dirty(page);
> @@ -299,7 +299,7 @@ static void swap_writepage_fs(struct folio *folio, struct writeback_control *wbc
>  	struct swap_iocb *sio = NULL;
>  	struct swap_info_struct *sis = swp_swap_info(folio->swap);
>  	struct file *swap_file = sis->swap_file;
> -	loff_t pos = folio_file_pos(folio);
> +	loff_t pos = swap_dev_pos(folio->swap);
>  
>  	count_swpout_vm_event(folio);
>  	folio_start_writeback(folio);
> @@ -430,7 +430,7 @@ static void swap_read_folio_fs(struct folio *folio, struct swap_iocb **plug)
>  {
>  	struct swap_info_struct *sis = swp_swap_info(folio->swap);
>  	struct swap_iocb *sio = NULL;
> -	loff_t pos = folio_file_pos(folio);
> +	loff_t pos = swap_dev_pos(folio->swap);
>  
>  	if (plug)
>  		sio = *plug;
> diff --git a/mm/swap.h b/mm/swap.h
> index fc2f6ade7f80..82023ab93205 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -5,6 +5,7 @@
>  struct mempolicy;
>  
>  #ifdef CONFIG_SWAP
> +#include <linux/swapops.h> /* for swp_offset */
>  #include <linux/blk_types.h> /* for bio_end_io_t */
>  
>  /* linux/mm/page_io.c */
> @@ -31,6 +32,14 @@ extern struct address_space *swapper_spaces[];
>  	(&swapper_spaces[swp_type(entry)][swp_offset(entry) \
>  		>> SWAP_ADDRESS_SPACE_SHIFT])
>  
> +/*
> + * Return the swap device position of the swap entry.
> + */
> +static inline loff_t swap_dev_pos(swp_entry_t entry)
> +{
> +	return ((loff_t)swp_offset(entry)) << PAGE_SHIFT;
> +}
> +
>  void show_swap_cache_info(void);
>  bool add_to_swap(struct folio *folio);
>  void *get_shadow_from_swap_cache(swp_entry_t entry);

