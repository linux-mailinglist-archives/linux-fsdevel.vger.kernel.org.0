Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760EE64E17C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Dec 2022 20:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiLOTCj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Dec 2022 14:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiLOTCc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Dec 2022 14:02:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E042D1FCED;
        Thu, 15 Dec 2022 11:02:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 976B961EEB;
        Thu, 15 Dec 2022 19:02:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6356C433EF;
        Thu, 15 Dec 2022 19:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671130946;
        bh=RvgQ0++wR/IOMA6LXXSWoZBj4HT01wsLNsnKu9rXtk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BdNkBTkL8yaDMDg2xzwNtbyZhvzgsWiOTh3uq6lK69OX8BFuSe8mjq7V1zu4RYtQ+
         1Aaik1kA/igxVryaLEy9lgudpZWXtzWVHa86MRsNQuOAkanoRXopGRYjM8hO8ZWBjZ
         ppXGsj2CZtz8W+NQAWtu3H9WWXkOoy1lLHpf7iRAYUvZhg2Ceq5XQgDjLa0TuSZwFQ
         KgSt7XAkKy9zi0SRX179LQvQxGNtRSOsW517432/44rNVMfwtv2akM/nOP6yKxyLaE
         A+xZvMxQdE4y8v2I5OM9lD2qojDW+sq3neJ4DLRM4yVGDyFKxf8/lkIhE6u7rViB38
         4O3C1uM4Y+wbQ==
Date:   Thu, 15 Dec 2022 11:02:24 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     chao@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        fengnanchang@gmail.com, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] f2fs: Convert f2fs_write_cache_pages() to use
 filemap_get_folios_tag()
Message-ID: <Y5tvQKT8HWxngEnc@google.com>
References: <0a95ba7b-9335-ce03-0f47-5d9f4cce988f@kernel.org>
 <20221212191317.9730-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212191317.9730-1-vishal.moola@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/12, Vishal Moola (Oracle) wrote:
> Converted the function to use a folio_batch instead of pagevec. This is in
> preparation for the removal of find_get_pages_range_tag().
> 
> Also modified f2fs_all_cluster_page_ready to take in a folio_batch instead
> of pagevec. This does NOT support large folios. The function currently
> only utilizes folios of size 1 so this shouldn't cause any issues right
> now.
> 
> This version of the patch limits the number of pages fetched to
> F2FS_ONSTACK_PAGES. If that ever happens, update the start index here
> since filemap_get_folios_tag() updates the index to be after the last
> found folio, not necessarily the last used page.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
> 
> Let me know if you prefer this version and I'll include it in v5
> of the patch series when I rebase it after the merge window.
> 
> ---
>  fs/f2fs/data.c | 86 ++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 59 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index a71e818cd67b..1703e353f0e0 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2939,6 +2939,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>  	int ret = 0;
>  	int done = 0, retry = 0;
>  	struct page *pages[F2FS_ONSTACK_PAGES];
> +	struct folio_batch fbatch;
>  	struct f2fs_sb_info *sbi = F2FS_M_SB(mapping);
>  	struct bio *bio = NULL;
>  	sector_t last_block;
> @@ -2959,6 +2960,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>  		.private = NULL,
>  	};
>  #endif
> +	int nr_folios, p, idx;
>  	int nr_pages;
>  	pgoff_t index;
>  	pgoff_t end;		/* Inclusive */
> @@ -2969,6 +2971,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>  	int submitted = 0;
>  	int i;
>  
> +	folio_batch_init(&fbatch);
> +
>  	if (get_dirty_pages(mapping->host) <=
>  				SM_I(F2FS_M_SB(mapping))->min_hot_blocks)
>  		set_inode_flag(mapping->host, FI_HOT_DATA);
> @@ -2994,13 +2998,38 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>  		tag_pages_for_writeback(mapping, index, end);
>  	done_index = index;
>  	while (!done && !retry && (index <= end)) {
> -		nr_pages = find_get_pages_range_tag(mapping, &index, end,
> -				tag, F2FS_ONSTACK_PAGES, pages);
> -		if (nr_pages == 0)
> +		nr_pages = 0;
> +again:
> +		nr_folios = filemap_get_folios_tag(mapping, &index, end,
> +				tag, &fbatch);

Can't folio handle this internally with F2FS_ONSTACK_PAGES and pages?

> +		if (nr_folios == 0) {
> +			if (nr_pages)
> +				goto write;
>  			break;
> +		}
>  
> +		for (i = 0; i < nr_folios; i++) {
> +			struct folio* folio = fbatch.folios[i];
> +
> +			idx = 0;
> +			p = folio_nr_pages(folio);
> +add_more:
> +			pages[nr_pages] = folio_page(folio,idx);
> +			folio_ref_inc(folio);
> +			if (++nr_pages == F2FS_ONSTACK_PAGES) {
> +				index = folio->index + idx + 1;
> +				folio_batch_release(&fbatch);
> +				goto write;
> +			}
> +			if (++idx < p)
> +				goto add_more;
> +		}
> +		folio_batch_release(&fbatch);
> +		goto again;
> +write:
>  		for (i = 0; i < nr_pages; i++) {
>  			struct page *page = pages[i];
> +			struct folio *folio = page_folio(page);
>  			bool need_readd;
>  readd:
>  			need_readd = false;
> @@ -3017,7 +3046,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>  				}
>  
>  				if (!f2fs_cluster_can_merge_page(&cc,
> -								page->index)) {
> +								folio->index)) {
>  					ret = f2fs_write_multi_pages(&cc,
>  						&submitted, wbc, io_type);
>  					if (!ret)
> @@ -3026,27 +3055,28 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>  				}
>  
>  				if (unlikely(f2fs_cp_error(sbi)))
> -					goto lock_page;
> +					goto lock_folio;
>  
>  				if (!f2fs_cluster_is_empty(&cc))
> -					goto lock_page;
> +					goto lock_folio;
>  
>  				if (f2fs_all_cluster_page_ready(&cc,
>  					pages, i, nr_pages, true))
> -					goto lock_page;
> +					goto lock_folio;
>  
>  				ret2 = f2fs_prepare_compress_overwrite(
>  							inode, &pagep,
> -							page->index, &fsdata);
> +							folio->index, &fsdata);
>  				if (ret2 < 0) {
>  					ret = ret2;
>  					done = 1;
>  					break;
>  				} else if (ret2 &&
>  					(!f2fs_compress_write_end(inode,
> -						fsdata, page->index, 1) ||
> +						fsdata, folio->index, 1) ||
>  					 !f2fs_all_cluster_page_ready(&cc,
> -						pages, i, nr_pages, false))) {
> +						pages, i, nr_pages,
> +						false))) {
>  					retry = 1;
>  					break;
>  				}
> @@ -3059,46 +3089,47 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>  				break;
>  			}
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
> -lock_page:
> +lock_folio:
>  #endif
> -			done_index = page->index;
> +			done_index = folio->index;
>  retry_write:
> -			lock_page(page);
> +			folio_lock(folio);
>  
> -			if (unlikely(page->mapping != mapping)) {
> +			if (unlikely(folio->mapping != mapping)) {
>  continue_unlock:
> -				unlock_page(page);
> +				folio_unlock(folio);
>  				continue;
>  			}
>  
> -			if (!PageDirty(page)) {
> +			if (!folio_test_dirty(folio)) {
>  				/* someone wrote it for us */
>  				goto continue_unlock;
>  			}
>  
> -			if (PageWriteback(page)) {
> +			if (folio_test_writeback(folio)) {
>  				if (wbc->sync_mode != WB_SYNC_NONE)
> -					f2fs_wait_on_page_writeback(page,
> +					f2fs_wait_on_page_writeback(
> +							&folio->page,
>  							DATA, true, true);
>  				else
>  					goto continue_unlock;
>  			}
>  
> -			if (!clear_page_dirty_for_io(page))
> +			if (!folio_clear_dirty_for_io(folio))
>  				goto continue_unlock;
>  
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
>  			if (f2fs_compressed_file(inode)) {
> -				get_page(page);
> -				f2fs_compress_ctx_add_page(&cc, page);
> +				folio_get(folio);
> +				f2fs_compress_ctx_add_page(&cc, &folio->page);
>  				continue;
>  			}
>  #endif
> -			ret = f2fs_write_single_data_page(page, &submitted,
> -					&bio, &last_block, wbc, io_type,
> -					0, true);
> +			ret = f2fs_write_single_data_page(&folio->page,
> +					&submitted, &bio, &last_block,
> +					wbc, io_type, 0, true);
>  			if (ret == AOP_WRITEPAGE_ACTIVATE)
> -				unlock_page(page);
> +				folio_unlock(folio);
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
>  result:
>  #endif
> @@ -3122,7 +3153,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>  					}
>  					goto next;
>  				}
> -				done_index = page->index + 1;
> +				done_index = folio->index +
> +					folio_nr_pages(folio);
>  				done = 1;
>  				break;
>  			}
> @@ -3136,7 +3168,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>  			if (need_readd)
>  				goto readd;
>  		}
> -		release_pages(pages, nr_pages);
> +		release_pages(pages,nr_pages);
>  		cond_resched();
>  	}
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
> -- 
> 2.38.1
