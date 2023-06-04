Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5835C72193B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jun 2023 20:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjFDS34 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jun 2023 14:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjFDS3z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jun 2023 14:29:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63916AB;
        Sun,  4 Jun 2023 11:29:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9B0960CA4;
        Sun,  4 Jun 2023 18:29:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD8CC433D2;
        Sun,  4 Jun 2023 18:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685903393;
        bh=dMCpKfeX51oljhVsWeUcNu7hDjnmNmLzjzU6wsdsxyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u4N1WukrYRUtPXlewiBqa1agnma0JlBuXdLAPmigcuUlmsoi7hBBdHuMP4wLQ2U9R
         SHWc6xZXmoQwkBVGx0DkrPVcGF1wDwMPCebCYT+h4k5OjlKhq/xuMIkq/+kts8ck2i
         SXlDzGR1PibpCYPTpAiGw/MsVeoQtYbfm5q2KC7stY5OGofU+sEgXT5Vm0DFcDATPa
         0/TO4eE+hVM/SElv028l51/DIB7d5RnWjQnrks3YzkWKoYsixR2ry7LBCVnYZlobtl
         GyaksWwndbq4eCTGnps902FtoM3DscpIGuTg3/QTfxJf7Jzyb7gkYdMoqRXwSsioeC
         fNN4qPOInlogg==
Date:   Sun, 4 Jun 2023 11:29:52 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 7/7] iomap: Copy larger chunks from userspace
Message-ID: <20230604182952.GH72241@frogsfrogsfrogs>
References: <20230602222445.2284892-1-willy@infradead.org>
 <20230602222445.2284892-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602222445.2284892-8-willy@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 02, 2023 at 11:24:44PM +0100, Matthew Wilcox (Oracle) wrote:
> If we have a large folio, we can copy in larger chunks than PAGE_SIZE.
> Start at the maximum page cache size and shrink by half every time we
> hit the "we are short on memory" problem.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/iomap/buffered-io.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index a10f9c037515..10434b07e0f9 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -768,6 +768,7 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
>  static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  {
>  	loff_t length = iomap_length(iter);
> +	size_t chunk = PAGE_SIZE << MAX_PAGECACHE_ORDER;
>  	loff_t pos = iter->pos;
>  	ssize_t written = 0;
>  	long status = 0;
> @@ -776,15 +777,13 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  
>  	do {
>  		struct folio *folio;
> -		struct page *page;
> -		unsigned long offset;	/* Offset into pagecache page */
> -		unsigned long bytes;	/* Bytes to write to page */
> +		size_t offset;		/* Offset into folio */
> +		unsigned long bytes;	/* Bytes to write to folio */
>  		size_t copied;		/* Bytes copied from user */
>  
> -		offset = offset_in_page(pos);
> -		bytes = min_t(unsigned long, PAGE_SIZE - offset,
> -						iov_iter_count(i));
>  again:
> +		offset = pos & (chunk - 1);
> +		bytes = min(chunk - offset, iov_iter_count(i));
>  		status = balance_dirty_pages_ratelimited_flags(mapping,
>  							       bdp_flags);
>  		if (unlikely(status))
> @@ -814,11 +813,14 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  		if (iter->iomap.flags & IOMAP_F_STALE)
>  			break;
>  
> -		page = folio_file_page(folio, pos >> PAGE_SHIFT);
> +		offset = offset_in_folio(folio, pos);
> +		if (bytes > folio_size(folio) - offset)
> +			bytes = folio_size(folio) - offset;
> +
>  		if (mapping_writably_mapped(mapping))
> -			flush_dcache_page(page);
> +			flush_dcache_folio(folio);
>  
> -		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
> +		copied = copy_page_from_iter_atomic(&folio->page, offset, bytes, i);

I think I've gotten lost in the weeds.  Does copy_page_from_iter_atomic
actually know how to deal with a multipage folio?  AFAICT it takes a
page, kmaps it, and copies @bytes starting at @offset in the page.  If
a caller feeds it a multipage folio, does that all work correctly?  Or
will the pagecache split multipage folios as needed to make it work
right?

If we create a 64k folio at pos 0 and then want to write a byte at pos
40k, does __filemap_get_folio break up the 64k folio so that the folio
returned by iomap_get_folio starts at 40k?  Or can the iter code handle
jumping ten pages into a 16-page folio and I just can't see it?

(Allergies suddenly went from 0 to 9, engage breaindead mode...)

--D

>  
>  		status = iomap_write_end(iter, pos, bytes, copied, folio);
>  
> @@ -835,6 +837,8 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  			 */
>  			if (copied)
>  				bytes = copied;
> +			if (chunk > PAGE_SIZE)
> +				chunk /= 2;
>  			goto again;
>  		}
>  		pos += status;
> -- 
> 2.39.2
> 
