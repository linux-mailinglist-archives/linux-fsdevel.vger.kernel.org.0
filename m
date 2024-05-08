Return-Path: <linux-fsdevel+bounces-19005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE60C8BF651
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 08:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937FF28245E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 06:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7461E53F;
	Wed,  8 May 2024 06:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/4ebGJl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FB4171B6;
	Wed,  8 May 2024 06:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715150097; cv=none; b=TtMV+08LaZ4JjM5R6kyZXmi3s1ND9Mq2icnTOgRi2tTT1ALEqgAxpg3s0xPCPUKnwe0q6aSXku7nWcT7nRZcGvLVTaJQjYDxrKzI5T54zr40w8EClcJKLuJ+nAhulw6B+3BdV9NC8gWEBbz+gcpRAtryL5jMePi6BiyEJnv7Z6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715150097; c=relaxed/simple;
	bh=APOtoHE0voeGHGRQZmu8ViVknqEdQFOsrAsV/taQU8o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AgHKO0T6SmBzWyARJKjeYQeLIridGgsD2XGzpeyOAIgHpK1Nia2nv4Tr0k1NC6wFXSZhUwNCS2P7yPyUUEbVvlLrq/QJSvG/yplgAaa0gqS3iA/KjL054KxqAgCznxrrGenzv7JIrd9B0FgX8HtJMHkAe855o2S+Dt7Y3d4Sm+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/4ebGJl; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715150095; x=1746686095;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=APOtoHE0voeGHGRQZmu8ViVknqEdQFOsrAsV/taQU8o=;
  b=g/4ebGJlFPrfKb8Ekggc4t+rJFkvcz309/EgzXqAOBKCXuJjm2MHvZUc
   0n1vKNhbeeO9dl7e9fjyIK7tdfzZzjtWlhrE0cWKM6tiq0qfjUhVOBzfl
   sYmQpRRmdeSgmvOqM4lCsYYWhkVtAzEe06U9juxQgRz5uLQ9tkBqLcvg0
   PQpcGj38HtfCGB7yTk4eb+R+32C0cTtZDJh4j2IU9Qo9nUi/rw3+jpxEC
   OcMXk5B4ZB28XRY99YxsI5g02o6yOgUDei9NzMExtQFgEE1mqDfx3wqz+
   82ZCxesQAGKizpp+XnKyQv4Yod6jvNlMjBvuscoPDk1zcCG2oxOixGw6M
   g==;
X-CSE-ConnectionGUID: JI9di07gTBOUUkFftxH4oQ==
X-CSE-MsgGUID: YDMy3d7HTHS8nNMaCVJrrA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11112075"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="11112075"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 23:34:55 -0700
X-CSE-ConnectionGUID: lwvudA58TuKaK1DXKi7eyA==
X-CSE-MsgGUID: herrs9BzRNaY5euN0yK5Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="28875086"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 23:34:51 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,  Kairui Song <kasong@tencent.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Matthew Wilcox <willy@infradead.org>,  Chris
 Li <chrisl@kernel.org>,  Barry Song <v-songbaohua@oppo.com>,  Ryan Roberts
 <ryan.roberts@arm.com>,  Neil Brown <neilb@suse.de>,  Minchan Kim
 <minchan@kernel.org>,  Hugh Dickins <hughd@google.com>,  David Hildenbrand
 <david@redhat.com>,  Yosry Ahmed <yosryahmed@google.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/12] mm: remove page_file_offset and folio_file_pos
In-Reply-To: <20240502084939.30250-3-ryncsn@gmail.com> (Kairui Song's message
	of "Thu, 2 May 2024 16:49:37 +0800")
References: <20240502084609.28376-1-ryncsn@gmail.com>
	<20240502084939.30250-3-ryncsn@gmail.com>
Date: Wed, 08 May 2024 14:32:59 +0800
Message-ID: <87a5l0lso4.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
> These two helpers were useful for mixed usage of swap cache and page
> cache, which help retrieve the corresponding file or swap device offset
> of a page or folio.
>
> They were introduced in commit f981c5950fa8 ("mm: methods for teaching
> filesystems about PG_swapcache pages") and used in commit d56b4ddf7781
> ("nfs: teach the NFS client how to treat PG_swapcache pages"), suppose
> to be used with direct_IO for swap over fs.
>
> But after commit e1209d3a7a67 ("mm: introduce ->swap_rw and use it
> for reads from SWP_FS_OPS swap-space"), swap with direct_IO is no more,
> and swap cache mapping is never exposed to fs.
>
> Now we have dropped all users of page_file_offset and folio_file_pos,
> so they can be deleted.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>

LGTM, Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> ---
>  include/linux/pagemap.h | 17 -----------------
>  1 file changed, 17 deletions(-)
>
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 850d32057939..a324582ea702 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -918,11 +918,6 @@ static inline loff_t page_offset(struct page *page)
>  	return ((loff_t)page->index) << PAGE_SHIFT;
>  }
>  
> -static inline loff_t page_file_offset(struct page *page)
> -{
> -	return ((loff_t)page_index(page)) << PAGE_SHIFT;
> -}
> -
>  /**
>   * folio_pos - Returns the byte position of this folio in its file.
>   * @folio: The folio.
> @@ -932,18 +927,6 @@ static inline loff_t folio_pos(struct folio *folio)
>  	return page_offset(&folio->page);
>  }
>  
> -/**
> - * folio_file_pos - Returns the byte position of this folio in its file.
> - * @folio: The folio.
> - *
> - * This differs from folio_pos() for folios which belong to a swap file.
> - * NFS is the only filesystem today which needs to use folio_file_pos().
> - */
> -static inline loff_t folio_file_pos(struct folio *folio)
> -{
> -	return page_file_offset(&folio->page);
> -}
> -
>  /*
>   * Get the offset in PAGE_SIZE (even for hugetlb folios).
>   */

