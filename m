Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A65728D67
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 03:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238131AbjFIB6r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 21:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238101AbjFIB6o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:58:44 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A123730CD;
        Thu,  8 Jun 2023 18:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686275921; x=1717811921;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=mpVamIpHuf/gQT+r5lR2dxcikhasXCd2orfPB6DhhTE=;
  b=D5QVKQaE3vmEkF+tGveZkQK0PSCgHlrw5UvvGeH7x0YijMiET0fPczAK
   MoOuImDOYIKOKMf+zo43B0ShtX1uXbEzfEFQ7sxpM9ZSrAD1EW/ZsBe2F
   wCpluMK/eJv6akxgAofdgZSXDE1saW6fxHwuqBUAlPcvGJhjnqTiFXkCe
   ZoiqelSlYvIdxA7OvxMu1OcY4wq6aO+dWF7mD+4Brhvkng1FvzmeifNkD
   zApEsYl7C2kNxa6sqemqFRujpurZ1ENDkqdIrqo8zkrn7mmJ8GWBYg1DD
   iEI5sJBQuwTl7dKQYyDs574dHpU+IZ+zhB6Iy42Z6bAkzSxyZnvm6zunH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="347136058"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="347136058"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 18:58:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="743316061"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="743316061"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 18:58:33 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, peterx@redhat.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2 1/6] swap: remove remnants of polling from
 read_swap_cache_async
References: <20230609005158.2421285-1-surenb@google.com>
        <20230609005158.2421285-2-surenb@google.com>
Date:   Fri, 09 Jun 2023 09:57:25 +0800
In-Reply-To: <20230609005158.2421285-2-surenb@google.com> (Suren
        Baghdasaryan's message of "Thu, 8 Jun 2023 17:51:53 -0700")
Message-ID: <877csdpfcq.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+ Ming Lei for confirmation.

Suren Baghdasaryan <surenb@google.com> writes:

> Commit [1] introduced IO polling support during swapin to reduce
> swap read latency for block devices that can be polled. However later
> commit [2] removed polling support. Therefore it seems safe to remove
> do_poll parameter in read_swap_cache_async and always call swap_readpage
> with synchronous=false waiting for IO completion in folio_lock_or_retry.
>
> [1] commit 23955622ff8d ("swap: add block io poll in swapin path")
> [2] commit 9650b453a3d4 ("block: ignore RWF_HIPRI hint for sync dio")
>
> Suggested-by: Huang Ying <ying.huang@intel.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Looks good to me!  Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> ---
>  mm/madvise.c    |  4 ++--
>  mm/swap.h       |  1 -
>  mm/swap_state.c | 12 +++++-------
>  3 files changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index b5ffbaf616f5..b1e8adf1234e 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -215,7 +215,7 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
>  			continue;
>  
>  		page = read_swap_cache_async(entry, GFP_HIGHUSER_MOVABLE,
> -					     vma, index, false, &splug);
> +					     vma, index, &splug);
>  		if (page)
>  			put_page(page);
>  	}
> @@ -252,7 +252,7 @@ static void force_shm_swapin_readahead(struct vm_area_struct *vma,
>  		rcu_read_unlock();
>  
>  		page = read_swap_cache_async(swap, GFP_HIGHUSER_MOVABLE,
> -					     NULL, 0, false, &splug);
> +					     NULL, 0, &splug);
>  		if (page)
>  			put_page(page);
>  
> diff --git a/mm/swap.h b/mm/swap.h
> index 7c033d793f15..8a3c7a0ace4f 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -46,7 +46,6 @@ struct folio *filemap_get_incore_folio(struct address_space *mapping,
>  struct page *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  				   struct vm_area_struct *vma,
>  				   unsigned long addr,
> -				   bool do_poll,
>  				   struct swap_iocb **plug);
>  struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  				     struct vm_area_struct *vma,
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index b76a65ac28b3..a3839de71f3f 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -517,15 +517,14 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>   */
>  struct page *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  				   struct vm_area_struct *vma,
> -				   unsigned long addr, bool do_poll,
> -				   struct swap_iocb **plug)
> +				   unsigned long addr, struct swap_iocb **plug)
>  {
>  	bool page_was_allocated;
>  	struct page *retpage = __read_swap_cache_async(entry, gfp_mask,
>  			vma, addr, &page_was_allocated);
>  
>  	if (page_was_allocated)
> -		swap_readpage(retpage, do_poll, plug);
> +		swap_readpage(retpage, false, plug);
>  
>  	return retpage;
>  }
> @@ -620,7 +619,7 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
>  	struct swap_info_struct *si = swp_swap_info(entry);
>  	struct blk_plug plug;
>  	struct swap_iocb *splug = NULL;
> -	bool do_poll = true, page_allocated;
> +	bool page_allocated;
>  	struct vm_area_struct *vma = vmf->vma;
>  	unsigned long addr = vmf->address;
>  
> @@ -628,7 +627,6 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
>  	if (!mask)
>  		goto skip;
>  
> -	do_poll = false;
>  	/* Read a page_cluster sized and aligned cluster around offset. */
>  	start_offset = offset & ~mask;
>  	end_offset = offset | mask;
> @@ -660,7 +658,7 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
>  	lru_add_drain();	/* Push any new pages onto the LRU now */
>  skip:
>  	/* The page was likely read above, so no need for plugging here */
> -	return read_swap_cache_async(entry, gfp_mask, vma, addr, do_poll, NULL);
> +	return read_swap_cache_async(entry, gfp_mask, vma, addr, NULL);
>  }
>  
>  int init_swap_address_space(unsigned int type, unsigned long nr_pages)
> @@ -825,7 +823,7 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
>  skip:
>  	/* The page was likely read above, so no need for plugging here */
>  	return read_swap_cache_async(fentry, gfp_mask, vma, vmf->address,
> -				     ra_info.win == 1, NULL);
> +				     NULL);
>  }
>  
>  /**
