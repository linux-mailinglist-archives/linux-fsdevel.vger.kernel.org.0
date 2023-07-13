Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CE77517C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 06:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbjGME6d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 00:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjGME6c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:58:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642EE2116;
        Wed, 12 Jul 2023 21:58:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3B56616B0;
        Thu, 13 Jul 2023 04:58:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C28CC433C7;
        Thu, 13 Jul 2023 04:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689224310;
        bh=zQLOsEEwB5YtAHk2LsRU4v5BzGyJSpCnunDM7OgAqEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jjbVGm2JaufTUT5wk0yUZ7FwrIzclQ0fc07nSH47Sq4M5OcjqA+0OqkP//UpMUQey
         ++YhdqPVs0zvFeJrljYkbjdqRuyU0Yp5MMlOW0LMc5Af5SuWKoHjnCNWJo1CXA0V/V
         J5ozTfXFx+fGJweg1F5dGfnoFi/mYisbz44nLtF0eHOVjcdILDbS5OZwtCY//x6l4f
         dJ7DCU5JxXnfNZAfPw4r/4BhcU8nS086C/g6gKcAm5Xobj/c9Spm/2B3DcRR4IUe4y
         PBALTT61nb+23nJQ1bi01hwfSVUsv7iDpwOTj9voDvjKU9gOGWrjYET0N9EVzS6IzW
         UvkzgWDWXlZVw==
Date:   Wed, 12 Jul 2023 21:58:29 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 9/9] iomap: Copy larger chunks from userspace
Message-ID: <20230713045829.GN108251@frogsfrogsfrogs>
References: <20230710130253.3484695-1-willy@infradead.org>
 <20230710130253.3484695-10-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710130253.3484695-10-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 10, 2023 at 02:02:53PM +0100, Matthew Wilcox (Oracle) wrote:
> If we have a large folio, we can copy in larger chunks than PAGE_SIZE.
> Start at the maximum page cache size and shrink by half every time we
> hit the "we are short on memory" problem.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Looks good!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 2d3e90f4d16e..f21f1f641c4a 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -769,6 +769,7 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
>  static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  {
>  	loff_t length = iomap_length(iter);
> +	size_t chunk = PAGE_SIZE << MAX_PAGECACHE_ORDER;
>  	loff_t pos = iter->pos;
>  	ssize_t written = 0;
>  	long status = 0;
> @@ -777,15 +778,12 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  
>  	do {
>  		struct folio *folio;
> -		struct page *page;
> -		unsigned long offset;	/* Offset into pagecache page */
> -		unsigned long bytes;	/* Bytes to write to page */
> +		size_t offset;		/* Offset into folio */
> +		size_t bytes;		/* Bytes to write to folio */
>  		size_t copied;		/* Bytes copied from user */
>  
> -		offset = offset_in_page(pos);
> -		bytes = min_t(unsigned long, PAGE_SIZE - offset,
> -						iov_iter_count(i));
> -again:
> +		offset = pos & (chunk - 1);
> +		bytes = min(chunk - offset, iov_iter_count(i));
>  		status = balance_dirty_pages_ratelimited_flags(mapping,
>  							       bdp_flags);
>  		if (unlikely(status))
> @@ -815,12 +813,14 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  		if (iter->iomap.flags & IOMAP_F_STALE)
>  			break;
>  
> -		page = folio_file_page(folio, pos >> PAGE_SHIFT);
> -		if (mapping_writably_mapped(mapping))
> -			flush_dcache_page(page);
> +		offset = offset_in_folio(folio, pos);
> +		if (bytes > folio_size(folio) - offset)
> +			bytes = folio_size(folio) - offset;
>  
> -		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
> +		if (mapping_writably_mapped(mapping))
> +			flush_dcache_folio(folio);
>  
> +		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
>  		status = iomap_write_end(iter, pos, bytes, copied, folio);
>  
>  		if (unlikely(copied != status))
> @@ -836,11 +836,13 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  			 */
>  			if (copied)
>  				bytes = copied;
> -			goto again;
> +			if (chunk > PAGE_SIZE)
> +				chunk /= 2;
> +		} else {
> +			pos += status;
> +			written += status;
> +			length -= status;
>  		}
> -		pos += status;
> -		written += status;
> -		length -= status;
>  	} while (iov_iter_count(i) && length);
>  
>  	if (status == -EAGAIN) {
> -- 
> 2.39.2
> 
