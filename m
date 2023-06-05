Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E41B723344
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 00:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjFEWgP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 18:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjFEWgO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 18:36:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470B3102;
        Mon,  5 Jun 2023 15:36:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC0DF619D3;
        Mon,  5 Jun 2023 22:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28751C433EF;
        Mon,  5 Jun 2023 22:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686004572;
        bh=cwUEns7KAY4PHjnKjH+/5OXXLrX+QfvT0ibYV7X6Y0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VOXBkaIUW8TWoRL0PMhUAhB5fDXVUOIc2fR4+WdHc8EAXaa7lpAu5Yv9wiuGDo0ij
         5z4vhOYaJXFRvp03aCJRf5fyd/NKRANDqw+5osbCfEZc3oMfSRJUUxL4gRckVhIrqq
         WsQ1OhvIGt37npypahuJmmUdOaPuS1Vw9O93z+58vj04X79KQQNoMiNe7QiKMf/TAc
         7QNY4FUW58Qq6d1P2XcO7zuR57bPJEwbk7Kn+PQu001ldmOGw06n8IiacNo5yRwEO9
         O6I2XiWOA7s69BfeoV/0EpEu07LS9aT+AmRivGDY7O4Gzd2DOvVm8gk9xJZwfIHAkY
         ieMhavnfDydpQ==
Date:   Mon, 5 Jun 2023 15:36:11 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv7 1/6] iomap: Rename iomap_page_create/release() to
 iomap_iop_alloc/free()
Message-ID: <20230605223611.GE1325469@frogsfrogsfrogs>
References: <cover.1685962158.git.ritesh.list@gmail.com>
 <d06abc56a48e3ac7d8c0619fee57506f36fcca5b.1685962158.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d06abc56a48e3ac7d8c0619fee57506f36fcca5b.1685962158.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 05, 2023 at 04:25:01PM +0530, Ritesh Harjani (IBM) wrote:
> This patch renames the iomap_page_create/release() functions to
> iomap_iop_alloc/free() calls. Later patches adds more functions for
> handling iop structure with iomap_iop_** naming conventions.
> Hence iomap_iop_alloc/free() makes more sense to be consistent with all
> APIs.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/iomap/buffered-io.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 063133ec77f4..4567bdd4fff9 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -43,8 +43,8 @@ static inline struct iomap_page *to_iomap_page(struct folio *folio)
>  
>  static struct bio_set iomap_ioend_bioset;
>  
> -static struct iomap_page *
> -iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
> +static struct iomap_page *iomap_iop_alloc(struct inode *inode,

Personally I preferred iop_alloc, but as I wasn't around to make to that
point during the v6 review I'll let this slide.  iomap_iop_* it is.

(I invoke maintainer privilege and will rename the structure to
iomap_folio and iop->iof since the objects no longer track /only/ a
single page state.)

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +				struct folio *folio, unsigned int flags)
>  {
>  	struct iomap_page *iop = to_iomap_page(folio);
>  	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
> @@ -69,7 +69,7 @@ iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
>  	return iop;
>  }
>  
> -static void iomap_page_release(struct folio *folio)
> +static void iomap_iop_free(struct folio *folio)
>  {
>  	struct iomap_page *iop = folio_detach_private(folio);
>  	struct inode *inode = folio->mapping->host;
> @@ -231,7 +231,7 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
>  	if (WARN_ON_ONCE(size > iomap->length))
>  		return -EIO;
>  	if (offset > 0)
> -		iop = iomap_page_create(iter->inode, folio, iter->flags);
> +		iop = iomap_iop_alloc(iter->inode, folio, iter->flags);
>  	else
>  		iop = to_iomap_page(folio);
>  
> @@ -269,7 +269,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
>  		return iomap_read_inline_data(iter, folio);
>  
>  	/* zero post-eof blocks as the page may be mapped */
> -	iop = iomap_page_create(iter->inode, folio, iter->flags);
> +	iop = iomap_iop_alloc(iter->inode, folio, iter->flags);
>  	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
>  	if (plen == 0)
>  		goto done;
> @@ -490,7 +490,7 @@ bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags)
>  	 */
>  	if (folio_test_dirty(folio) || folio_test_writeback(folio))
>  		return false;
> -	iomap_page_release(folio);
> +	iomap_iop_free(folio);
>  	return true;
>  }
>  EXPORT_SYMBOL_GPL(iomap_release_folio);
> @@ -507,12 +507,12 @@ void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
>  	if (offset == 0 && len == folio_size(folio)) {
>  		WARN_ON_ONCE(folio_test_writeback(folio));
>  		folio_cancel_dirty(folio);
> -		iomap_page_release(folio);
> +		iomap_iop_free(folio);
>  	} else if (folio_test_large(folio)) {
>  		/* Must release the iop so the page can be split */
>  		WARN_ON_ONCE(!folio_test_uptodate(folio) &&
>  			     folio_test_dirty(folio));
> -		iomap_page_release(folio);
> +		iomap_iop_free(folio);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(iomap_invalidate_folio);
> @@ -559,7 +559,8 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>  		return 0;
>  	folio_clear_error(folio);
>  
> -	iop = iomap_page_create(iter->inode, folio, iter->flags);
> +	iop = iomap_iop_alloc(iter->inode, folio, iter->flags);
> +
>  	if ((iter->flags & IOMAP_NOWAIT) && !iop && nr_blocks > 1)
>  		return -EAGAIN;
>  
> @@ -1612,7 +1613,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  		struct writeback_control *wbc, struct inode *inode,
>  		struct folio *folio, u64 end_pos)
>  {
> -	struct iomap_page *iop = iomap_page_create(inode, folio, 0);
> +	struct iomap_page *iop = iomap_iop_alloc(inode, folio, 0);
>  	struct iomap_ioend *ioend, *next;
>  	unsigned len = i_blocksize(inode);
>  	unsigned nblocks = i_blocks_per_folio(inode, folio);
> -- 
> 2.40.1
> 
