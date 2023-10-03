Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACF17B6A87
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 15:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbjJCN2s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 09:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbjJCN2r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:28:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258CEA3;
        Tue,  3 Oct 2023 06:28:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D63D621892;
        Tue,  3 Oct 2023 13:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696339722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y06AtrFsQ3PjPoBLSLe2+hpm0kIXInuEKE0T9W7n+MI=;
        b=d4lrfI5YfWhF4HGLALTHxj2phyE3d22SjIV8qBLYRgtYWs+T7gaOaC9s4AU0qtwfJrktxb
        e9Yf3qVSBRPBfl98BsAvLFTh7dqoODbx6K8CiIJIor8zyJ/h2imkya+vdaeHrEBwSJb785
        wf0c1MmCxQqdCoWuRh5TPX5iGDaQJEI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696339722;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y06AtrFsQ3PjPoBLSLe2+hpm0kIXInuEKE0T9W7n+MI=;
        b=SFIfmLmERxs2L2TdDSrpBEYP8v9SfC74lSa5GQ5WViAF02HYA7kKdKmfUEYBKMTbgR4MkY
        peN3nYUPd+AW71AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C6A11139F9;
        Tue,  3 Oct 2023 13:28:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QX5yMAoXHGXpOAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 03 Oct 2023 13:28:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 456D1A07CC; Tue,  3 Oct 2023 15:28:42 +0200 (CEST)
Date:   Tue, 3 Oct 2023 15:28:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 6/8] shmem: move memcg charge out of
 shmem_add_to_page_cache()
Message-ID: <20231003132842.lxniwpknqfxan5px@quack3>
References: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com>
 <4b2143c5-bf32-64f0-841-81a81158dac@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b2143c5-bf32-64f0-841-81a81158dac@google.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 29-09-23 20:31:27, Hugh Dickins wrote:
> Extract shmem's memcg charging out of shmem_add_to_page_cache(): it's
> misleading done there, because many calls are dealing with a swapcache
> page, whose memcg is nowadays always remembered while swapped out, then
> the charge re-levied when it's brought back into swapcache.
> 
> Temporarily move it back up to the shmem_get_folio_gfp() level, where
> the memcg was charged before v5.8; but the next commit goes on to move
> it back down to a new home.
> 
> In making this change, it becomes clear that shmem_swapin_folio() does
> not need to know the vma, just the fault mm (if any): call it fault_mm
> rather than charge_mm - let mem_cgroup_charge() decide whom to charge.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/shmem.c | 68 +++++++++++++++++++++++-------------------------------
>  1 file changed, 29 insertions(+), 39 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 63ba6037b23a..0a7f7b567b80 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -146,9 +146,8 @@ static unsigned long shmem_default_max_inodes(void)
>  #endif
>  
>  static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
> -			     struct folio **foliop, enum sgp_type sgp,
> -			     gfp_t gfp, struct vm_area_struct *vma,
> -			     vm_fault_t *fault_type);
> +			struct folio **foliop, enum sgp_type sgp, gfp_t gfp,
> +			struct mm_struct *fault_mm, vm_fault_t *fault_type);
>  
>  static inline struct shmem_sb_info *SHMEM_SB(struct super_block *sb)
>  {
> @@ -760,12 +759,10 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
>   */
>  static int shmem_add_to_page_cache(struct folio *folio,
>  				   struct address_space *mapping,
> -				   pgoff_t index, void *expected, gfp_t gfp,
> -				   struct mm_struct *charge_mm)
> +				   pgoff_t index, void *expected, gfp_t gfp)
>  {
>  	XA_STATE_ORDER(xas, &mapping->i_pages, index, folio_order(folio));
>  	long nr = folio_nr_pages(folio);
> -	int error;
>  
>  	VM_BUG_ON_FOLIO(index != round_down(index, nr), folio);
>  	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> @@ -776,16 +773,7 @@ static int shmem_add_to_page_cache(struct folio *folio,
>  	folio->mapping = mapping;
>  	folio->index = index;
>  
> -	if (!folio_test_swapcache(folio)) {
> -		error = mem_cgroup_charge(folio, charge_mm, gfp);
> -		if (error) {
> -			if (folio_test_pmd_mappable(folio)) {
> -				count_vm_event(THP_FILE_FALLBACK);
> -				count_vm_event(THP_FILE_FALLBACK_CHARGE);
> -			}
> -			goto error;
> -		}
> -	}
> +	gfp &= GFP_RECLAIM_MASK;
>  	folio_throttle_swaprate(folio, gfp);
>  
>  	do {
> @@ -813,15 +801,12 @@ static int shmem_add_to_page_cache(struct folio *folio,
>  	} while (xas_nomem(&xas, gfp));
>  
>  	if (xas_error(&xas)) {
> -		error = xas_error(&xas);
> -		goto error;
> +		folio->mapping = NULL;
> +		folio_ref_sub(folio, nr);
> +		return xas_error(&xas);
>  	}
>  
>  	return 0;
> -error:
> -	folio->mapping = NULL;
> -	folio_ref_sub(folio, nr);
> -	return error;
>  }
>  
>  /*
> @@ -1324,10 +1309,8 @@ static int shmem_unuse_swap_entries(struct inode *inode,
>  
>  		if (!xa_is_value(folio))
>  			continue;
> -		error = shmem_swapin_folio(inode, indices[i],
> -					  &folio, SGP_CACHE,
> -					  mapping_gfp_mask(mapping),
> -					  NULL, NULL);
> +		error = shmem_swapin_folio(inode, indices[i], &folio, SGP_CACHE,
> +					mapping_gfp_mask(mapping), NULL, NULL);
>  		if (error == 0) {
>  			folio_unlock(folio);
>  			folio_put(folio);
> @@ -1810,12 +1793,11 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
>   */
>  static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>  			     struct folio **foliop, enum sgp_type sgp,
> -			     gfp_t gfp, struct vm_area_struct *vma,
> +			     gfp_t gfp, struct mm_struct *fault_mm,
>  			     vm_fault_t *fault_type)
>  {
>  	struct address_space *mapping = inode->i_mapping;
>  	struct shmem_inode_info *info = SHMEM_I(inode);
> -	struct mm_struct *charge_mm = vma ? vma->vm_mm : NULL;
>  	struct swap_info_struct *si;
>  	struct folio *folio = NULL;
>  	swp_entry_t swap;
> @@ -1843,7 +1825,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>  		if (fault_type) {
>  			*fault_type |= VM_FAULT_MAJOR;
>  			count_vm_event(PGMAJFAULT);
> -			count_memcg_event_mm(charge_mm, PGMAJFAULT);
> +			count_memcg_event_mm(fault_mm, PGMAJFAULT);
>  		}
>  		/* Here we actually start the io */
>  		folio = shmem_swapin(swap, gfp, info, index);
> @@ -1880,8 +1862,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>  	}
>  
>  	error = shmem_add_to_page_cache(folio, mapping, index,
> -					swp_to_radix_entry(swap), gfp,
> -					charge_mm);
> +					swp_to_radix_entry(swap), gfp);
>  	if (error)
>  		goto failed;
>  
> @@ -1929,7 +1910,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>  	struct address_space *mapping = inode->i_mapping;
>  	struct shmem_inode_info *info = SHMEM_I(inode);
>  	struct shmem_sb_info *sbinfo;
> -	struct mm_struct *charge_mm;
> +	struct mm_struct *fault_mm;
>  	struct folio *folio;
>  	pgoff_t hindex;
>  	gfp_t huge_gfp;
> @@ -1946,7 +1927,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>  	}
>  
>  	sbinfo = SHMEM_SB(inode->i_sb);
> -	charge_mm = vma ? vma->vm_mm : NULL;
> +	fault_mm = vma ? vma->vm_mm : NULL;
>  
>  	folio = filemap_get_entry(mapping, index);
>  	if (folio && vma && userfaultfd_minor(vma)) {
> @@ -1958,7 +1939,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>  
>  	if (xa_is_value(folio)) {
>  		error = shmem_swapin_folio(inode, index, &folio,
> -					  sgp, gfp, vma, fault_type);
> +					   sgp, gfp, fault_mm, fault_type);
>  		if (error == -EEXIST)
>  			goto repeat;
>  
> @@ -2044,9 +2025,16 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>  	if (sgp == SGP_WRITE)
>  		__folio_set_referenced(folio);
>  
> -	error = shmem_add_to_page_cache(folio, mapping, hindex,
> -					NULL, gfp & GFP_RECLAIM_MASK,
> -					charge_mm);
> +	error = mem_cgroup_charge(folio, fault_mm, gfp);
> +	if (error) {
> +		if (folio_test_pmd_mappable(folio)) {
> +			count_vm_event(THP_FILE_FALLBACK);
> +			count_vm_event(THP_FILE_FALLBACK_CHARGE);
> +		}
> +		goto unacct;
> +	}
> +
> +	error = shmem_add_to_page_cache(folio, mapping, hindex, NULL, gfp);
>  	if (error)
>  		goto unacct;
>  
> @@ -2644,8 +2632,10 @@ int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
>  	if (unlikely(pgoff >= max_off))
>  		goto out_release;
>  
> -	ret = shmem_add_to_page_cache(folio, mapping, pgoff, NULL,
> -				      gfp & GFP_RECLAIM_MASK, dst_vma->vm_mm);
> +	ret = mem_cgroup_charge(folio, dst_vma->vm_mm, gfp);
> +	if (ret)
> +		goto out_release;
> +	ret = shmem_add_to_page_cache(folio, mapping, pgoff, NULL, gfp);
>  	if (ret)
>  		goto out_release;
>  
> -- 
> 2.35.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
