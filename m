Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AF055E2C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345276AbiF1MLT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 08:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345422AbiF1MLQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:11:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CF934BA8
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 05:11:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7252260FE4
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 12:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08598C3411D;
        Tue, 28 Jun 2022 12:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656418268;
        bh=3M63BTEn3gqd1OjEkOx8Im3zFebcs+g/sCxorEFQ6zo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AlJ3sOaEcLKF6S3/4xkUv3b42CmCP9EgykVNw9cnqmAZkqsynDjM/mie1KSMBd4Hd
         LWEIbtDFYyAdeUvWkqR/lXGmHgzIH5DSKuLxRBP1H+OBIkGfh7nHeURXQoQE2ka8lP
         7asyFrlHsGwzVslggt1URXkORrZ3TWwhHAnZM66DQ8l0rYAW4lRFZR2f6vmvTjiD/k
         hS23TkhczeZPCoW0kdoWzAFftHvlvKl44nxR0HAaIIH76Yp4w4motf0yNn7hirGlr2
         jaDO0Ko4znj6JNT9vm83RB7gzKE3q3eBKBT25dr/z3OjHbXQl6Yb7WEX/3JqgFNUbG
         qEv/jJtTje3tg==
Message-ID: <9ed39ba981dfa2e55df3c343788aba04acf13d09.camel@kernel.org>
Subject: Re: [PATCH 34/44] fold __pipe_get_pages() into pipe_get_pages()
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Date:   Tue, 28 Jun 2022 08:11:06 -0400
In-Reply-To: <20220622041552.737754-34-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
         <20220622041552.737754-1-viro@zeniv.linux.org.uk>
         <20220622041552.737754-34-viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2022-06-22 at 05:15 +0100, Al Viro wrote:
> ... and don't mangle maxsize there - turn the loop into counting
> one instead.  Easier to see that we won't run out of array that
> way.  Note that special treatment of the partial buffer in that
> thing is an artifact of the non-advancing semantics of
> iov_iter_get_pages() - if not for that, it would be append_pipe(),
> same as the body of the loop that follows it.  IOW, once we make
> iov_iter_get_pages() advancing, the whole thing will turn into
> 	calculate how many pages do we want
> 	allocate an array (if needed)
> 	call append_pipe() that many times.
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  lib/iov_iter.c | 75 +++++++++++++++++++++++++-------------------------
>  1 file changed, 38 insertions(+), 37 deletions(-)
>=20
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index f455b8ee0d76..9280f865fd6a 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1192,60 +1192,61 @@ static struct page **get_pages_array(size_t n)
>  	return kvmalloc_array(n, sizeof(struct page *), GFP_KERNEL);
>  }
> =20
> -static inline ssize_t __pipe_get_pages(struct iov_iter *i,
> -				size_t maxsize,
> -				struct page **pages,
> -				size_t off)
> -{
> -	struct pipe_inode_info *pipe =3D i->pipe;
> -	ssize_t left =3D maxsize;
> -
> -	if (off) {
> -		struct pipe_buffer *buf =3D pipe_buf(pipe, pipe->head - 1);
> -
> -		get_page(*pages++ =3D buf->page);
> -		left -=3D PAGE_SIZE - off;
> -		if (left <=3D 0) {
> -			buf->len +=3D maxsize;
> -			return maxsize;
> -		}
> -		buf->len =3D PAGE_SIZE;
> -	}
> -	while (!pipe_full(pipe->head, pipe->tail, pipe->max_usage)) {
> -		struct page *page =3D push_anon(pipe,
> -					      min_t(ssize_t, left, PAGE_SIZE));
> -		if (!page)
> -			break;
> -		get_page(*pages++ =3D page);
> -		left -=3D PAGE_SIZE;
> -		if (left <=3D 0)
> -			return maxsize;
> -	}
> -	return maxsize - left ? : -EFAULT;
> -}
> -
>  static ssize_t pipe_get_pages(struct iov_iter *i,
>  		   struct page ***pages, size_t maxsize, unsigned maxpages,
>  		   size_t *start)
>  {
> +	struct pipe_inode_info *pipe =3D i->pipe;
>  	unsigned int npages, off;
>  	struct page **p;
> -	size_t capacity;
> +	ssize_t left;
> +	int count;
> =20
>  	if (!sanity(i))
>  		return -EFAULT;
> =20
>  	*start =3D off =3D pipe_npages(i, &npages);
> -	capacity =3D min(npages, maxpages) * PAGE_SIZE - off;
> -	maxsize =3D min(maxsize, capacity);
> +	count =3D DIV_ROUND_UP(maxsize + off, PAGE_SIZE);
> +	if (count > npages)
> +		count =3D npages;
> +	if (count > maxpages)
> +		count =3D maxpages;
>  	p =3D *pages;
>  	if (!p) {
> -		*pages =3D p =3D get_pages_array(DIV_ROUND_UP(maxsize + off, PAGE_SIZE=
));
> +		*pages =3D p =3D get_pages_array(count);
>  		if (!p)
>  			return -ENOMEM;
>  	}
> =20
> -	return __pipe_get_pages(i, maxsize, p, off);
> +	left =3D maxsize;
> +	npages =3D 0;
> +	if (off) {
> +		struct pipe_buffer *buf =3D pipe_buf(pipe, pipe->head - 1);
> +
> +		get_page(*p++ =3D buf->page);
> +		left -=3D PAGE_SIZE - off;
> +		if (left <=3D 0) {
> +			buf->len +=3D maxsize;
> +			return maxsize;
> +		}
> +		buf->len =3D PAGE_SIZE;
> +		npages =3D 1;
> +	}
> +	for ( ; npages < count; npages++) {
> +		struct page *page;
> +		unsigned int size =3D min_t(ssize_t, left, PAGE_SIZE);
> +
> +		if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
> +			break;
> +		page =3D push_anon(pipe, size);
> +		if (!page)
> +			break;
> +		get_page(*p++ =3D page);
> +		left -=3D size;
> +	}
> +	if (!npages)
> +		return -EFAULT;
> +	return maxsize - left;
>  }
> =20
>  static ssize_t iter_xarray_populate_pages(struct page **pages, struct xa=
rray *xa,

Reviewed-by: Jeff Layton <jlayton@kernel.org>
