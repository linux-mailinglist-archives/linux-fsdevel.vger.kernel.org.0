Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6959175FB47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 17:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjGXP4O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 11:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGXP4M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:56:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27ADF8E;
        Mon, 24 Jul 2023 08:56:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3A5261231;
        Mon, 24 Jul 2023 15:56:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03878C433C8;
        Mon, 24 Jul 2023 15:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690214171;
        bh=/aFTmn5z1V6emeV4oYUCR+s8o3isT1XhkAue3pePv6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p78V6weFFOtwros4/l7SxkdjW5dhv++5GPTrCbshCiBEQiuavCKJ/Zhw0Jrat37Fu
         yqrNCz2BVc4foHI+2RuZNfyoTo0nNwNsTdCnSenuPcKHP7vL1etAreh8x3/LDkk47C
         BO5BJA+IQGUQBNPx6/XKU4RskPPDDULEKru5I0dlFNVE8qI3Ja7THauJsFyN4npweW
         fbhw+CMlCl3b5qhDSYBuSxfcJsJN4PrEMm0ajwfoBw3BtWKfMlpHxoAzwK4rtfTbi4
         +bu9nOIYzm/EXQnbAJbyT7ik5lIS+36sU/8/vvzL8JWOd30/+PuXAyKBiUPAAPQy3h
         y1ZrFatHvsb/A==
Date:   Mon, 24 Jul 2023 08:56:10 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH v4 2/9] iov_iter: Add copy_folio_from_iter_atomic()
Message-ID: <20230724155610.GA11336@frogsfrogsfrogs>
References: <20230710130253.3484695-1-willy@infradead.org>
 <20230710130253.3484695-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710130253.3484695-3-willy@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 10, 2023 at 02:02:46PM +0100, Matthew Wilcox (Oracle) wrote:
> Add a folio wrapper around copy_page_from_iter_atomic().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Wellllll crap.  I got all ready to push this to for-next, but then my
maintainer checkpatch interlock scripts pointed out that this commit
doesn't have /any/ RVB attached to it.  Apparently I forgot to tag this
one when I went through all this.

Matthew, can you please add:

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

and redo the whole branch-push and pull-request dance, please?

(Also could you put a sob tag on the tag message so that the merge
commit can have full authorship details?)

--D

> ---
>  include/linux/uio.h | 9 ++++++++-
>  lib/iov_iter.c      | 2 +-
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/uio.h b/include/linux/uio.h
> index ff81e5ccaef2..42bce38a8e87 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
> @@ -163,7 +163,7 @@ static inline size_t iov_length(const struct iovec *iov, unsigned long nr_segs)
>  	return ret;
>  }
>  
> -size_t copy_page_from_iter_atomic(struct page *page, unsigned offset,
> +size_t copy_page_from_iter_atomic(struct page *page, size_t offset,
>  				  size_t bytes, struct iov_iter *i);
>  void iov_iter_advance(struct iov_iter *i, size_t bytes);
>  void iov_iter_revert(struct iov_iter *i, size_t bytes);
> @@ -184,6 +184,13 @@ static inline size_t copy_folio_to_iter(struct folio *folio, size_t offset,
>  {
>  	return copy_page_to_iter(&folio->page, offset, bytes, i);
>  }
> +
> +static inline size_t copy_folio_from_iter_atomic(struct folio *folio,
> +		size_t offset, size_t bytes, struct iov_iter *i)
> +{
> +	return copy_page_from_iter_atomic(&folio->page, offset, bytes, i);
> +}
> +
>  size_t copy_page_to_iter_nofault(struct page *page, unsigned offset,
>  				 size_t bytes, struct iov_iter *i);
>  
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index c728b6e4fb18..8da566a549ad 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -566,7 +566,7 @@ size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
>  }
>  EXPORT_SYMBOL(iov_iter_zero);
>  
> -size_t copy_page_from_iter_atomic(struct page *page, unsigned offset,
> +size_t copy_page_from_iter_atomic(struct page *page, size_t offset,
>  		size_t bytes, struct iov_iter *i)
>  {
>  	size_t n, copied = 0;
> -- 
> 2.39.2
> 
