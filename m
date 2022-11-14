Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E29627634
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 08:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbiKNHCl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 02:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbiKNHCk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:02:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2974817E05;
        Sun, 13 Nov 2022 23:02:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA59160ED7;
        Mon, 14 Nov 2022 07:02:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E12C433D6;
        Mon, 14 Nov 2022 07:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668409358;
        bh=Sp9OPWk8Hfi27FOL8MFihV/Jb86LeP8KmL581cOjhdM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JUZjbf6wqRhzAU1OG5kzb6MdKI6X0Ndc9X1HodZERwG0/oy7V+RM6dx3vv/Ld+say
         x7yWBHYDi3nxFyWfr6o4ihOzX0xTkZjn/igAceADAT+rdAwdbORKlIGFtexIzdZV0v
         Vl8Cpu/iW8HNsaOMfGB/dJD3a2s8M6qHOzLqomQXWt4dmeV14x509iip+BF3rnEQvc
         mXMCxUSV+A0qcEh9KRr5n3wHuvZ1gCe3CImqBAqaJCRnRgsDQE2RG5cFWPAbc6kE0t
         bMcMhUUbwfdi1yzrdogyUHB1jCqu9dbmK/zoNylxqFSFFYpGASi58E7irh8XEBprTt
         QO+8q85MHHYaQ==
Message-ID: <9c01bb74-97b3-d1c0-6a5f-dc8b11113e1a@kernel.org>
Date:   Mon, 14 Nov 2022 15:02:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [f2fs-dev] [PATCH v3 14/23] f2fs: Convert
 f2fs_write_cache_pages() to use filemap_get_folios_tag()
Content-Language: en-US
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        fengnan chang <fengnanchang@gmail.com>,
        linux-fsdevel@vger.kernel.org
References: <20221017202451.4951-1-vishal.moola@gmail.com>
 <20221017202451.4951-15-vishal.moola@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221017202451.4951-15-vishal.moola@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/10/18 4:24, Vishal Moola (Oracle) wrote:
> Converted the function to use a folio_batch instead of pagevec. This is in
> preparation for the removal of find_get_pages_range_tag().
> 
> Also modified f2fs_all_cluster_page_ready to take in a folio_batch instead
> of pagevec. This does NOT support large folios. The function currently

Vishal,

It looks this patch tries to revert Fengnan's change:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=01fc4b9a6ed8eacb64e5609bab7ac963e1c7e486

How about doing some tests to evaluate its performance effect?

+Cc Fengnan Chang

Thanks,

> only utilizes folios of size 1 so this shouldn't cause any issues right
> now.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>   fs/f2fs/compress.c | 13 +++++----
>   fs/f2fs/data.c     | 69 +++++++++++++++++++++++++---------------------
>   fs/f2fs/f2fs.h     |  5 ++--
>   3 files changed, 47 insertions(+), 40 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index d315c2de136f..7af6c923e0aa 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -842,10 +842,11 @@ bool f2fs_cluster_can_merge_page(struct compress_ctx *cc, pgoff_t index)
>   	return is_page_in_cluster(cc, index);
>   }
>   
> -bool f2fs_all_cluster_page_ready(struct compress_ctx *cc, struct page **pages,
> -				int index, int nr_pages, bool uptodate)
> +bool f2fs_all_cluster_page_ready(struct compress_ctx *cc,
> +				struct folio_batch *fbatch,
> +				int index, int nr_folios, bool uptodate)
>   {
> -	unsigned long pgidx = pages[index]->index;
> +	unsigned long pgidx = fbatch->folios[index]->index;
>   	int i = uptodate ? 0 : 1;
>   
>   	/*
> @@ -855,13 +856,13 @@ bool f2fs_all_cluster_page_ready(struct compress_ctx *cc, struct page **pages,
>   	if (uptodate && (pgidx % cc->cluster_size))
>   		return false;
>   
> -	if (nr_pages - index < cc->cluster_size)
> +	if (nr_folios - index < cc->cluster_size)
>   		return false;
>   
>   	for (; i < cc->cluster_size; i++) {
> -		if (pages[index + i]->index != pgidx + i)
> +		if (fbatch->folios[index + i]->index != pgidx + i)
>   			return false;
> -		if (uptodate && !PageUptodate(pages[index + i]))
> +		if (uptodate && !folio_test_uptodate(fbatch->folios[index + i]))
>   			return false;
>   	}
>   
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index a71e818cd67b..7511578b73c3 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2938,7 +2938,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>   {
>   	int ret = 0;
>   	int done = 0, retry = 0;
> -	struct page *pages[F2FS_ONSTACK_PAGES];
> +	struct folio_batch fbatch;
>   	struct f2fs_sb_info *sbi = F2FS_M_SB(mapping);
>   	struct bio *bio = NULL;
>   	sector_t last_block;
> @@ -2959,7 +2959,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>   		.private = NULL,
>   	};
>   #endif
> -	int nr_pages;
> +	int nr_folios;
>   	pgoff_t index;
>   	pgoff_t end;		/* Inclusive */
>   	pgoff_t done_index;
> @@ -2969,6 +2969,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>   	int submitted = 0;
>   	int i;
>   
> +	folio_batch_init(&fbatch);
> +
>   	if (get_dirty_pages(mapping->host) <=
>   				SM_I(F2FS_M_SB(mapping))->min_hot_blocks)
>   		set_inode_flag(mapping->host, FI_HOT_DATA);
> @@ -2994,13 +2996,13 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>   		tag_pages_for_writeback(mapping, index, end);
>   	done_index = index;
>   	while (!done && !retry && (index <= end)) {
> -		nr_pages = find_get_pages_range_tag(mapping, &index, end,
> -				tag, F2FS_ONSTACK_PAGES, pages);
> -		if (nr_pages == 0)
> +		nr_folios = filemap_get_folios_tag(mapping, &index, end,
> +				tag, &fbatch);
> +		if (nr_folios == 0)
>   			break;
>   
> -		for (i = 0; i < nr_pages; i++) {
> -			struct page *page = pages[i];
> +		for (i = 0; i < nr_folios; i++) {
> +			struct folio *folio = fbatch.folios[i];
>   			bool need_readd;
>   readd:
>   			need_readd = false;
> @@ -3017,7 +3019,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>   				}
>   
>   				if (!f2fs_cluster_can_merge_page(&cc,
> -								page->index)) {
> +								folio->index)) {
>   					ret = f2fs_write_multi_pages(&cc,
>   						&submitted, wbc, io_type);
>   					if (!ret)
> @@ -3026,27 +3028,28 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>   				}
>   
>   				if (unlikely(f2fs_cp_error(sbi)))
> -					goto lock_page;
> +					goto lock_folio;
>   
>   				if (!f2fs_cluster_is_empty(&cc))
> -					goto lock_page;
> +					goto lock_folio;
>   
>   				if (f2fs_all_cluster_page_ready(&cc,
> -					pages, i, nr_pages, true))
> -					goto lock_page;
> +					&fbatch, i, nr_folios, true))
> +					goto lock_folio;
>   
>   				ret2 = f2fs_prepare_compress_overwrite(
>   							inode, &pagep,
> -							page->index, &fsdata);
> +							folio->index, &fsdata);
>   				if (ret2 < 0) {
>   					ret = ret2;
>   					done = 1;
>   					break;
>   				} else if (ret2 &&
>   					(!f2fs_compress_write_end(inode,
> -						fsdata, page->index, 1) ||
> +						fsdata, folio->index, 1) ||
>   					 !f2fs_all_cluster_page_ready(&cc,
> -						pages, i, nr_pages, false))) {
> +						&fbatch, i, nr_folios,
> +						false))) {
>   					retry = 1;
>   					break;
>   				}
> @@ -3059,46 +3062,47 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>   				break;
>   			}
>   #ifdef CONFIG_F2FS_FS_COMPRESSION
> -lock_page:
> +lock_folio:
>   #endif
> -			done_index = page->index;
> +			done_index = folio->index;
>   retry_write:
> -			lock_page(page);
> +			folio_lock(folio);
>   
> -			if (unlikely(page->mapping != mapping)) {
> +			if (unlikely(folio->mapping != mapping)) {
>   continue_unlock:
> -				unlock_page(page);
> +				folio_unlock(folio);
>   				continue;
>   			}
>   
> -			if (!PageDirty(page)) {
> +			if (!folio_test_dirty(folio)) {
>   				/* someone wrote it for us */
>   				goto continue_unlock;
>   			}
>   
> -			if (PageWriteback(page)) {
> +			if (folio_test_writeback(folio)) {
>   				if (wbc->sync_mode != WB_SYNC_NONE)
> -					f2fs_wait_on_page_writeback(page,
> +					f2fs_wait_on_page_writeback(
> +							&folio->page,
>   							DATA, true, true);
>   				else
>   					goto continue_unlock;
>   			}
>   
> -			if (!clear_page_dirty_for_io(page))
> +			if (!folio_clear_dirty_for_io(folio))
>   				goto continue_unlock;
>   
>   #ifdef CONFIG_F2FS_FS_COMPRESSION
>   			if (f2fs_compressed_file(inode)) {
> -				get_page(page);
> -				f2fs_compress_ctx_add_page(&cc, page);
> +				folio_get(folio);
> +				f2fs_compress_ctx_add_page(&cc, &folio->page);
>   				continue;
>   			}
>   #endif
> -			ret = f2fs_write_single_data_page(page, &submitted,
> -					&bio, &last_block, wbc, io_type,
> -					0, true);
> +			ret = f2fs_write_single_data_page(&folio->page,
> +					&submitted, &bio, &last_block,
> +					wbc, io_type, 0, true);
>   			if (ret == AOP_WRITEPAGE_ACTIVATE)
> -				unlock_page(page);
> +				folio_unlock(folio);
>   #ifdef CONFIG_F2FS_FS_COMPRESSION
>   result:
>   #endif
> @@ -3122,7 +3126,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>   					}
>   					goto next;
>   				}
> -				done_index = page->index + 1;
> +				done_index = folio->index +
> +					folio_nr_pages(folio);
>   				done = 1;
>   				break;
>   			}
> @@ -3136,7 +3141,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>   			if (need_readd)
>   				goto readd;
>   		}
> -		release_pages(pages, nr_pages);
> +		folio_batch_release(&fbatch);
>   		cond_resched();
>   	}
>   #ifdef CONFIG_F2FS_FS_COMPRESSION
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index e6355a5683b7..d7bfb88fa341 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4226,8 +4226,9 @@ void f2fs_end_read_compressed_page(struct page *page, bool failed,
>   				block_t blkaddr, bool in_task);
>   bool f2fs_cluster_is_empty(struct compress_ctx *cc);
>   bool f2fs_cluster_can_merge_page(struct compress_ctx *cc, pgoff_t index);
> -bool f2fs_all_cluster_page_ready(struct compress_ctx *cc, struct page **pages,
> -				int index, int nr_pages, bool uptodate);
> +bool f2fs_all_cluster_page_ready(struct compress_ctx *cc,
> +		struct folio_batch *fbatch, int index, int nr_folios,
> +		bool uptodate);
>   bool f2fs_sanity_check_cluster(struct dnode_of_data *dn);
>   void f2fs_compress_ctx_add_page(struct compress_ctx *cc, struct page *page);
>   int f2fs_write_multi_pages(struct compress_ctx *cc,
