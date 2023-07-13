Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322407517A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 06:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbjGMEmL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 00:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbjGMEmK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:42:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A6019B9;
        Wed, 12 Jul 2023 21:42:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9A0E619B0;
        Thu, 13 Jul 2023 04:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C57AC433C8;
        Thu, 13 Jul 2023 04:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689223328;
        bh=eykB0apE7Xtvo5kC4MX3hePLLE/Wk4V+dfp++PZB/LM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rTCMvPQzs1N43zu/PfsS27WZpGjCTw4Z1vl2ea4LIrVbOcXoJkenx3UTNchJFW2z3
         WdP3fnxixTNpB+GvUDRU1uOXt6T6DduX5qnWPbvf31WD265RfqmP07PwPhhGuO1yCh
         lrhMyyKhM2RSgsfNGebrf3xlr4Z688Qp3MY4GHrwS4UzyQ8JD1JJdRH4XJ8XGSGQOe
         zbFfyTdDIA2iNROJyNXFb0VedorSmQzyKww7+CBCnr1MqR3ZuDj45GIckazW1qQ7kl
         /giYHYk2by6rFDEB54/JBbB9gyw3bv1JkHLEnPXCphsZQF0+Y/1w6Z9SDhOPcI/meY
         4jHtD7Cp/Bu+w==
Date:   Wed, 12 Jul 2023 21:42:07 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH v4 1/9] iov_iter: Handle compound highmem pages in
 copy_page_from_iter_atomic()
Message-ID: <20230713044207.GH108251@frogsfrogsfrogs>
References: <20230710130253.3484695-1-willy@infradead.org>
 <20230710130253.3484695-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710130253.3484695-2-willy@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 10, 2023 at 02:02:45PM +0100, Matthew Wilcox (Oracle) wrote:
> copy_page_from_iter_atomic() already handles !highmem compound
> pages correctly, but if we are passed a highmem compound page,
> each base page needs to be mapped & unmapped individually.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Yikes.  Does this want a fixes tag?

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  lib/iov_iter.c | 43 ++++++++++++++++++++++++++++---------------
>  1 file changed, 28 insertions(+), 15 deletions(-)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index b667b1e2f688..c728b6e4fb18 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -566,24 +566,37 @@ size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
>  }
>  EXPORT_SYMBOL(iov_iter_zero);
>  
> -size_t copy_page_from_iter_atomic(struct page *page, unsigned offset, size_t bytes,
> -				  struct iov_iter *i)
> +size_t copy_page_from_iter_atomic(struct page *page, unsigned offset,
> +		size_t bytes, struct iov_iter *i)
>  {
> -	char *kaddr = kmap_atomic(page), *p = kaddr + offset;
> -	if (!page_copy_sane(page, offset, bytes)) {
> -		kunmap_atomic(kaddr);
> +	size_t n, copied = 0;
> +
> +	if (!page_copy_sane(page, offset, bytes))
>  		return 0;
> -	}
> -	if (WARN_ON_ONCE(!i->data_source)) {
> -		kunmap_atomic(kaddr);
> +	if (WARN_ON_ONCE(!i->data_source))
>  		return 0;
> -	}
> -	iterate_and_advance(i, bytes, base, len, off,
> -		copyin(p + off, base, len),
> -		memcpy_from_iter(i, p + off, base, len)
> -	)
> -	kunmap_atomic(kaddr);
> -	return bytes;
> +
> +	do {
> +		char *p;
> +
> +		n = bytes - copied;
> +		if (PageHighMem(page)) {
> +			page += offset / PAGE_SIZE;
> +			offset %= PAGE_SIZE;
> +			n = min_t(size_t, n, PAGE_SIZE - offset);
> +		}
> +
> +		p = kmap_atomic(page) + offset;
> +		iterate_and_advance(i, n, base, len, off,
> +			copyin(p + off, base, len),
> +			memcpy_from_iter(i, p + off, base, len)
> +		)
> +		kunmap_atomic(p);
> +		copied += n;
> +		offset += n;
> +	} while (PageHighMem(page) && copied != bytes && n > 0);
> +
> +	return copied;
>  }
>  EXPORT_SYMBOL(copy_page_from_iter_atomic);
>  
> -- 
> 2.39.2
> 
