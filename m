Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FB873F399
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 06:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjF0EnZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 00:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjF0Em0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:42:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2432A3AB5;
        Mon, 26 Jun 2023 21:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J9Qjh0LX2s6qZOttfC56stOAGkypOrOI+0uVjPVfqCA=; b=IY3N3Zn4wZ1gijmYE9QDvFalsP
        9Gp6qKihOpI+6fenEe0mutGKT716nolrAUYI5KTWjqQ4XdGblrwBl/mj+z75sHDvqonFl5uj0/HOT
        4paw/yYCrChQgsixkR+4JQCDdeDQcjUiv9gZssthBXZ1fRUDiJT1T5iSjDaE5CIYOk8y6oTS8MhQw
        Bt7mw7koLvrWqcPuoWUDqHKzc4JWRUm4+kTl6LfjwLxatvRguT3uVqy3Z9tqwFaTjUsERlvkrzuGG
        Yb5pWSqD9JLfSwg6PP6idOBITJv9WU110bTtf87AVL2Yfvw4QtZwIAv+U5hZZqT6VUf9R2LyZLzUZ
        V4mvY6rQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qE0UN-00BiYN-0z;
        Tue, 27 Jun 2023 04:39:39 +0000
Date:   Mon, 26 Jun 2023 21:39:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 09/12] writeback: Factor writeback_iter_next() out of
 write_cache_pages()
Message-ID: <ZJpoCy7oWtqy2FoW@infradead.org>
References: <20230626173521.459345-1-willy@infradead.org>
 <20230626173521.459345-10-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626173521.459345-10-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 06:35:18PM +0100, Matthew Wilcox (Oracle) wrote:
> Pull the post-processing of the writepage_t callback into a
> separate function.  That means changing writeback_finish() to
> return NULL, and writeback_get_next() to call writeback_finish()
> when we naturally run out of folios.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/page-writeback.c | 84 ++++++++++++++++++++++++---------------------
>  1 file changed, 44 insertions(+), 40 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 659df2b5c7c0..ef61d7006c5e 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2360,7 +2360,7 @@ void tag_pages_for_writeback(struct address_space *mapping,
>  }
>  EXPORT_SYMBOL(tag_pages_for_writeback);
>  
> -static int writeback_finish(struct address_space *mapping,
> +static struct folio *writeback_finish(struct address_space *mapping,
>  		struct writeback_control *wbc, bool done)
>  {
>  	folio_batch_release(&wbc->fbatch);
> @@ -2375,7 +2375,7 @@ static int writeback_finish(struct address_space *mapping,
>  	if (wbc->range_cyclic || (wbc->range_whole && wbc->nr_to_write > 0))
>  		mapping->writeback_index = wbc->done_index;
>  
> -	return wbc->err;
> +	return NULL;

Having a return value that is always NULL feels a bit weird vs just
doing that return in the caller.

> +static struct folio *writeback_iter_next(struct address_space *mapping,
> +		struct writeback_control *wbc, struct folio *folio, int error)
> +{
> +	if (unlikely(error)) {
> +		/*
> +		 * Handle errors according to the type of writeback.
> +		 * There's no need to continue for background writeback.
> +		 * Just push done_index past this folio so media
> +		 * errors won't choke writeout for the entire file.
> +		 * For integrity writeback, we must process the entire
> +		 * dirty set regardless of errors because the fs may
> +		 * still have state to clear for each folio.  In that
> +		 * case we continue processing and return the first error.
> +		 */
> +		if (error == AOP_WRITEPAGE_ACTIVATE) {
> +			folio_unlock(folio);
> +			error = 0;

Note there really shouldn't be any need for this in outside of the
legacy >writepage case.  But it might make sense to delay the removal
until after ->writepage is gone to avoid bugs in conversions.

> +		} else if (wbc->sync_mode != WB_SYNC_ALL) {
> +			wbc->err = error;
> +			wbc->done_index = folio->index +
> +					folio_nr_pages(folio);

Btw, I wonder if a folio_next_index helper for this might be useful
as it's a pattern we have in a few places.
