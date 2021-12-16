Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC26477F7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 22:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241763AbhLPVpJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 16:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237631AbhLPVoZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:44:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC2AC08E6DF;
        Thu, 16 Dec 2021 13:43:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B8F161F9A;
        Thu, 16 Dec 2021 21:43:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB210C36AE2;
        Thu, 16 Dec 2021 21:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639690996;
        bh=+OesseL9+8IhwYVrl5VuIRe5XfUosJ8w79J9FNaaKXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SVD6AztPK7hK9N7qAbWvqRRQuaOpZEqldpPwoYClQfQku+aQvNZheTq3HyRFnj0mC
         WPR0Bx/20rSossdAKJ9UPe3+rBzQWJw9Crm6+gpheRs3yZmoAnxY0A6vkJs8A1PVUn
         A5syAIhxyqiuPWnMu3qo/H/rNFJGwjOiCMJHZKAOOYkR5IKqe/HFkkLOieLZnfyo99
         bs2wMYZh2ad2yNPdNNgZRUDYRB5Tu562PRHWGCg8FsEuPM8G3fVM7oyDvEbNSeZly7
         c0srGBES0CP0Jo6LLjz+j1Y8JNF3Tw7S12u7/1QAeY6bo4B69TQpCPvUsB1T4dOkPY
         AY/llqietP2Pg==
Date:   Thu, 16 Dec 2021 13:43:16 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 15/25] iomap: Allow iomap_write_begin() to be called
 with the full length
Message-ID: <20211216214316.GE27664@magnolia>
References: <20211216210715.3801857-1-willy@infradead.org>
 <20211216210715.3801857-16-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216210715.3801857-16-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 16, 2021 at 09:07:05PM +0000, Matthew Wilcox (Oracle) wrote:
> In the future, we want write_begin to know the entire length of the
> write so that it can choose to allocate large folios.  Pass the full
> length in from __iomap_zero_iter() and limit it where necessary.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Seems reasonable,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 8d7a67655b60..b1ded5204d1c 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -619,6 +619,9 @@ static int iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>  	if (fatal_signal_pending(current))
>  		return -EINTR;
>  
> +	if (!mapping_large_folio_support(iter->inode->i_mapping))
> +		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
> +
>  	if (page_ops && page_ops->page_prepare) {
>  		status = page_ops->page_prepare(iter->inode, pos, len);
>  		if (status)
> @@ -632,6 +635,8 @@ static int iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>  		goto out_no_page;
>  	}
>  	folio = page_folio(page);
> +	if (pos + len > folio_pos(folio) + folio_size(folio))
> +		len = folio_pos(folio) + folio_size(folio) - pos;
>  
>  	if (srcmap->type == IOMAP_INLINE)
>  		status = iomap_write_begin_inline(iter, page);
> @@ -891,11 +896,13 @@ static s64 __iomap_zero_iter(struct iomap_iter *iter, loff_t pos, u64 length)
>  	struct page *page;
>  	int status;
>  	unsigned offset = offset_in_page(pos);
> -	unsigned bytes = min_t(u64, PAGE_SIZE - offset, length);
> +	unsigned bytes = min_t(u64, UINT_MAX, length);
>  
>  	status = iomap_write_begin(iter, pos, bytes, &page);
>  	if (status)
>  		return status;
> +	if (bytes > PAGE_SIZE - offset)
> +		bytes = PAGE_SIZE - offset;
>  
>  	zero_user(page, offset, bytes);
>  	mark_page_accessed(page);
> -- 
> 2.33.0
> 
