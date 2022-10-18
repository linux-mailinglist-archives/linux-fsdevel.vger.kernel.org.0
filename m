Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4705760348A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 23:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiJRVCj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 17:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiJRVCi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 17:02:38 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B7F622288;
        Tue, 18 Oct 2022 14:02:27 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au [49.181.106.210])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 967678AE0CC;
        Wed, 19 Oct 2022 08:01:53 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oktii-003bE7-4J; Wed, 19 Oct 2022 08:01:52 +1100
Date:   Wed, 19 Oct 2022 08:01:52 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 04/23] page-writeback: Convert write_cache_pages() to use
 filemap_get_folios_tag()
Message-ID: <20221018210152.GH2703033@dread.disaster.area>
References: <20220901220138.182896-1-vishal.moola@gmail.com>
 <20220901220138.182896-5-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901220138.182896-5-vishal.moola@gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=634f1443
        a=j6JUzzrSC7wlfFge/rmVbg==:117 a=j6JUzzrSC7wlfFge/rmVbg==:17
        a=kj9zAlcOel0A:10 a=Qawa6l4ZSaYA:10 a=pGLkceISAAAA:8 a=7-415B0cAAAA:8
        a=K-JhRxFi-CGouRt9WdAA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 01, 2022 at 03:01:19PM -0700, Vishal Moola (Oracle) wrote:
> Converted function to use folios throughout. This is in preparation for
> the removal of find_get_pages_range_tag().
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  mm/page-writeback.c | 44 +++++++++++++++++++++++---------------------
>  1 file changed, 23 insertions(+), 21 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 032a7bf8d259..087165357a5a 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2285,15 +2285,15 @@ int write_cache_pages(struct address_space *mapping,
>  	int ret = 0;
>  	int done = 0;
>  	int error;
> -	struct pagevec pvec;
> -	int nr_pages;
> +	struct folio_batch fbatch;
> +	int nr_folios;
>  	pgoff_t index;
>  	pgoff_t end;		/* Inclusive */
>  	pgoff_t done_index;
>  	int range_whole = 0;
>  	xa_mark_t tag;
>  
> -	pagevec_init(&pvec);
> +	folio_batch_init(&fbatch);
>  	if (wbc->range_cyclic) {
>  		index = mapping->writeback_index; /* prev offset */
>  		end = -1;
> @@ -2313,17 +2313,18 @@ int write_cache_pages(struct address_space *mapping,
>  	while (!done && (index <= end)) {
>  		int i;
>  
> -		nr_pages = pagevec_lookup_range_tag(&pvec, mapping, &index, end,
> -				tag);
> -		if (nr_pages == 0)
> +		nr_folios = filemap_get_folios_tag(mapping, &index, end,
> +				tag, &fbatch);

This can find and return dirty multi-page folios if the filesystem
enables them in the mapping at instantiation time, right?

> +
> +		if (nr_folios == 0)
>  			break;
>  
> -		for (i = 0; i < nr_pages; i++) {
> -			struct page *page = pvec.pages[i];
> +		for (i = 0; i < nr_folios; i++) {
> +			struct folio *folio = fbatch.folios[i];
>  
> -			done_index = page->index;
> +			done_index = folio->index;
>  
> -			lock_page(page);
> +			folio_lock(folio);
>  
>  			/*
>  			 * Page truncated or invalidated. We can freely skip it
> @@ -2333,30 +2334,30 @@ int write_cache_pages(struct address_space *mapping,
>  			 * even if there is now a new, dirty page at the same
>  			 * pagecache address.
>  			 */
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
> -					wait_on_page_writeback(page);
> +					folio_wait_writeback(folio);
>  				else
>  					goto continue_unlock;
>  			}
>  
> -			BUG_ON(PageWriteback(page));
> -			if (!clear_page_dirty_for_io(page))
> +			BUG_ON(folio_test_writeback(folio));
> +			if (!folio_clear_dirty_for_io(folio))
>  				goto continue_unlock;
>  
>  			trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
> -			error = (*writepage)(page, wbc, data);
> +			error = writepage(&folio->page, wbc, data);

Yet, IIUC, this treats all folios as if they are single page folios.
i.e. it passes the head page of a multi-page folio to a callback
that will treat it as a single PAGE_SIZE page, because that's all
the writepage callbacks are currently expected to be passed...

So won't this break writeback of dirty multipage folios?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
