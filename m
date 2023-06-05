Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FD772336C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 00:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjFEW6i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 18:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjFEW6h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 18:58:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BB483;
        Mon,  5 Jun 2023 15:58:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D15F6625BE;
        Mon,  5 Jun 2023 22:58:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E088C433EF;
        Mon,  5 Jun 2023 22:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686005915;
        bh=JspuNrVvMCwSPrGBLozlENtzs82n2xz/nq46UfPRbzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZnZGU7ZHIN77mz0AD+5ym8hYRhN/GRz9pHwpKNDZSI+PdEwb2qA7N7mrclHrzDOYY
         QvRhc2n/WQGigxQnYajHjBDsFUnf22X71kcSvJBpmIMSFr8/3KrkOXzUBThokX0J57
         nTVzPQdmBnKhcYPHKjh/mYWmPBqRFY9aqlSUuXsvBQsIp4Ot/nDgYv/TzxzEbZd56W
         wreWYqYZZa/phAru8he3GnV7VBtiozIXvkEs/GjZogM2WjzJFp1yefqRjeFB/1I/PA
         7F1fEOhT9KClwWTCl1HFhfK2wWnT5vo6jTwauY/Y6c9mMpqj6nbPEMugFs1o+uLCC/
         mXgZ6zse6iQjA==
Date:   Mon, 5 Jun 2023 15:58:34 -0700
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
Subject: Re: [PATCHv7 5/6] iomap: Allocate iop in ->write_begin() early
Message-ID: <20230605225834.GH1325469@frogsfrogsfrogs>
References: <cover.1685962158.git.ritesh.list@gmail.com>
 <d2bd912ee7d2bcab0b49a0226496631ed5c82e21.1685962158.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2bd912ee7d2bcab0b49a0226496631ed5c82e21.1685962158.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 05, 2023 at 04:25:05PM +0530, Ritesh Harjani (IBM) wrote:
> We dont need to allocate an iop in ->write_begin() for writes where the
> position and length completely overlap with the given folio.
> Therefore, such cases are skipped.
> 
> Currently when the folio is uptodate, we only allocate iop at writeback
> time (in iomap_writepage_map()). This is ok until now, but when we are
> going to add support for per-block dirty state bitmap in iop, this
> could cause some performance degradation. The reason is that if we don't
> allocate iop during ->write_begin(), then we will never mark the
> necessary dirty bits in ->write_end() call. And we will have to mark all
> the bits as dirty at the writeback time, that could cause the same write
> amplification and performance problems as it is now.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Makes sense to me, but moving on to the next patch...
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index f55a339f99ec..2a97d73edb96 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -571,15 +571,24 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>  	size_t from = offset_in_folio(folio, pos), to = from + len;
>  	size_t poff, plen;
>  
> -	if (folio_test_uptodate(folio))
> +	/*
> +	 * If the write completely overlaps the current folio, then
> +	 * entire folio will be dirtied so there is no need for
> +	 * per-block state tracking structures to be attached to this folio.
> +	 */
> +	if (pos <= folio_pos(folio) &&
> +	    pos + len >= folio_pos(folio) + folio_size(folio))
>  		return 0;
> -	folio_clear_error(folio);
>  
>  	iop = iomap_iop_alloc(iter->inode, folio, iter->flags);
>  
>  	if ((iter->flags & IOMAP_NOWAIT) && !iop && nr_blocks > 1)
>  		return -EAGAIN;
>  
> +	if (folio_test_uptodate(folio))
> +		return 0;
> +	folio_clear_error(folio);
> +
>  	do {
>  		iomap_adjust_read_range(iter->inode, folio, &block_start,
>  				block_end - block_start, &poff, &plen);
> -- 
> 2.40.1
> 
