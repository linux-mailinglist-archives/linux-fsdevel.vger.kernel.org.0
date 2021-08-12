Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C074B3EA635
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 16:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237871AbhHLOIe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 10:08:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50874 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237854AbhHLOId (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 10:08:33 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6402922274;
        Thu, 12 Aug 2021 14:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628777287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bWrEfhAUPriTkCX9SwoZ7gkosxfv2T0pzM8MltxBGxY=;
        b=lQHfePu8meNm3yCKhVrDfoO24fiebt4DetmWYyNq7H2LEqpdzmnTZ4C0VTq0rE2JFfqlvx
        z/bdWQLUZCDN2+FWxb5kxI2+DGhRCi4z0NISrnYuAoywXBGun678qFT+LPcFVIIgQ3W9V3
        O4I6KjNqYFH9Qkpi6lkJaGkXpgKNMY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628777287;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bWrEfhAUPriTkCX9SwoZ7gkosxfv2T0pzM8MltxBGxY=;
        b=OO0Y5gZ709Gm/auWOQz5mu1xX0wmWJmwXtHni2OcLfQ49oYrWGbNb/J2W7DLDxvhJ1gMEq
        77WXalOeFVQdPECA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 4CC1D13A90;
        Thu, 12 Aug 2021 14:08:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id CPn3EUcrFWGUXgAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 12 Aug 2021 14:08:07 +0000
Subject: Re: [PATCH v14 066/138] mm/writeback: Add __folio_end_writeback()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-67-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <f9d112a9-d318-05d0-8518-1e7964e49fea@suse.cz>
Date:   Thu, 12 Aug 2021 16:08:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-67-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> test_clear_page_writeback() is actually an mm-internal function, although
> it's named as if it's a pagecache function.  Move it to mm/internal.h,
> rename it to __folio_end_writeback() and change the return type to bool.
> 
> The conversion from page to folio is mostly about accounting the number
> of pages being written back, although it does eliminate a couple of
> calls to compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/page-flags.h |  1 -
>  mm/filemap.c               |  2 +-
>  mm/internal.h              |  1 +
>  mm/page-writeback.c        | 29 +++++++++++++++--------------
>  4 files changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index ddb660688086..6f9d1f26b1ef 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -655,7 +655,6 @@ static __always_inline void SetPageUptodate(struct page *page)
>  
>  CLEARPAGEFLAG(Uptodate, uptodate, PF_NO_TAIL)
>  
> -int test_clear_page_writeback(struct page *page);
>  int __test_set_page_writeback(struct page *page, bool keep_write);
>  
>  #define test_set_page_writeback(page)			\
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 5c4e3185ecb3..a74c69a938ab 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1535,7 +1535,7 @@ void folio_end_writeback(struct folio *folio)
>  	 * reused before the folio_wake().
>  	 */
>  	folio_get(folio);
> -	if (!test_clear_page_writeback(&folio->page))
> +	if (!__folio_end_writeback(folio))
>  		BUG();
>  
>  	smp_mb__after_atomic();
> diff --git a/mm/internal.h b/mm/internal.h
> index fa31a7f0ed79..08e8a28994d1 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -43,6 +43,7 @@ static inline void *folio_raw_mapping(struct folio *folio)
>  
>  vm_fault_t do_swap_page(struct vm_fault *vmf);
>  void folio_rotate_reclaimable(struct folio *folio);
> +bool __folio_end_writeback(struct folio *folio);
>  
>  void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
>  		unsigned long floor, unsigned long ceiling);
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index e542ea37d605..8d5d7921b157 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -583,7 +583,7 @@ static void wb_domain_writeout_add(struct wb_domain *dom,
>  
>  /*
>   * Increment @wb's writeout completion count and the global writeout
> - * completion count. Called from test_clear_page_writeback().
> + * completion count. Called from __folio_end_writeback().
>   */
>  static inline void __wb_writeout_add(struct bdi_writeback *wb, long nr)
>  {
> @@ -2731,27 +2731,28 @@ int clear_page_dirty_for_io(struct page *page)
>  }
>  EXPORT_SYMBOL(clear_page_dirty_for_io);
>  
> -int test_clear_page_writeback(struct page *page)
> +bool __folio_end_writeback(struct folio *folio)
>  {
> -	struct address_space *mapping = page_mapping(page);
> -	int ret;
> +	long nr = folio_nr_pages(folio);
> +	struct address_space *mapping = folio_mapping(folio);
> +	bool ret;
>  
> -	lock_page_memcg(page);
> +	folio_memcg_lock(folio);
>  	if (mapping && mapping_use_writeback_tags(mapping)) {
>  		struct inode *inode = mapping->host;
>  		struct backing_dev_info *bdi = inode_to_bdi(inode);
>  		unsigned long flags;
>  
>  		xa_lock_irqsave(&mapping->i_pages, flags);
> -		ret = TestClearPageWriteback(page);
> +		ret = folio_test_clear_writeback(folio);
>  		if (ret) {
> -			__xa_clear_mark(&mapping->i_pages, page_index(page),
> +			__xa_clear_mark(&mapping->i_pages, folio_index(folio),
>  						PAGECACHE_TAG_WRITEBACK);
>  			if (bdi->capabilities & BDI_CAP_WRITEBACK_ACCT) {
>  				struct bdi_writeback *wb = inode_to_wb(inode);
>  
> -				dec_wb_stat(wb, WB_WRITEBACK);
> -				__wb_writeout_add(wb, 1);
> +				wb_stat_mod(wb, WB_WRITEBACK, -nr);
> +				__wb_writeout_add(wb, nr);
>  			}
>  		}
>  
> @@ -2761,14 +2762,14 @@ int test_clear_page_writeback(struct page *page)
>  
>  		xa_unlock_irqrestore(&mapping->i_pages, flags);
>  	} else {
> -		ret = TestClearPageWriteback(page);
> +		ret = folio_test_clear_writeback(folio);
>  	}
>  	if (ret) {
> -		dec_lruvec_page_state(page, NR_WRITEBACK);
> -		dec_zone_page_state(page, NR_ZONE_WRITE_PENDING);
> -		inc_node_page_state(page, NR_WRITTEN);
> +		lruvec_stat_mod_folio(folio, NR_WRITEBACK, -nr);
> +		zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr);
> +		node_stat_mod_folio(folio, NR_WRITTEN, nr);
>  	}
> -	unlock_page_memcg(page);
> +	folio_memcg_unlock(folio);
>  	return ret;
>  }
>  
> 

