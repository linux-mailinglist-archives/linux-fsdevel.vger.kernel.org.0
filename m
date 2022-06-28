Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE0555D3BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243997AbiF1LuG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 07:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239438AbiF1LuF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:50:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E45F74
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 04:50:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6B99609D0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 11:50:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AFBC341CA;
        Tue, 28 Jun 2022 11:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656417003;
        bh=p5kCKkIZYbPDyOInvkTcyT2axlg7jpWwcO1KxJK54M8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Fw8IP6HJ/JW2yV4t3//VLKuc0Yg7/p0fVfdEX0HAiakevauPbOHX9hpiAsHzOAI4x
         A7QCO9oL1MnFOlMdZWIZaZ3fYb0PCUh72iy+tpCiSGVzm2PHnZGeRiyw6z9sxN7kXw
         0fk11M87ikg/goLShUUx8tLazgrX4vVUCfhED9APP7PYAjFwXOynOwwNEVsWCUcgnr
         ZMXY5LIOyYNqkAfOcJ+PeWppj0zrLSKCubYWJ3ZbZcA5qKXD1FeYjINw0xPPfDqO1Y
         6OYFcDEWju2gsP5cTENSLkAhKAqd8R9+ojLtudZzKRQABGpuzGHFAxTH4pIJ3CQB+m
         JWJs0HAQesXSQ==
Message-ID: <6a8dace941ca29717b21fba98dfb865f3423af67.camel@kernel.org>
Subject: Re: [PATCH 27/44] unify xarray_get_pages() and
 xarray_get_pages_alloc()
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Date:   Tue, 28 Jun 2022 07:50:01 -0400
In-Reply-To: <20220622041552.737754-27-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
         <20220622041552.737754-1-viro@zeniv.linux.org.uk>
         <20220622041552.737754-27-viro@zeniv.linux.org.uk>
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
> same as for pipes
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  lib/iov_iter.c | 49 ++++++++++---------------------------------------
>  1 file changed, 10 insertions(+), 39 deletions(-)
>=20
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 1c98f2f3a581..07dacb274ba5 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1276,7 +1276,7 @@ static ssize_t iter_xarray_populate_pages(struct pa=
ge **pages, struct xarray *xa
>  }
> =20
>  static ssize_t iter_xarray_get_pages(struct iov_iter *i,
> -				     struct page **pages, size_t maxsize,
> +				     struct page ***pages, size_t maxsize,
>  				     unsigned maxpages, size_t *_start_offset)
>  {
>  	unsigned nr, offset;
> @@ -1301,7 +1301,13 @@ static ssize_t iter_xarray_get_pages(struct iov_it=
er *i,
>  	if (count > maxpages)
>  		count =3D maxpages;
> =20
> -	nr =3D iter_xarray_populate_pages(pages, i->xarray, index, count);
> +	if (!*pages) {
> +		*pages =3D get_pages_array(count);
> +		if (!*pages)
> +			return -ENOMEM;
> +	}
> +
> +	nr =3D iter_xarray_populate_pages(*pages, i->xarray, index, count);
>  	if (nr =3D=3D 0)
>  		return 0;
> =20
> @@ -1409,46 +1415,11 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
>  	if (iov_iter_is_pipe(i))
>  		return pipe_get_pages(i, &pages, maxsize, maxpages, start);
>  	if (iov_iter_is_xarray(i))
> -		return iter_xarray_get_pages(i, pages, maxsize, maxpages, start);
> +		return iter_xarray_get_pages(i, &pages, maxsize, maxpages, start);
>  	return -EFAULT;
>  }
>  EXPORT_SYMBOL(iov_iter_get_pages);
> =20
> -static ssize_t iter_xarray_get_pages_alloc(struct iov_iter *i,
> -					   struct page ***pages, size_t maxsize,
> -					   size_t *_start_offset)
> -{
> -	struct page **p;
> -	unsigned nr, offset;
> -	pgoff_t index, count;
> -	size_t size =3D maxsize;
> -	loff_t pos;
> -
> -	pos =3D i->xarray_start + i->iov_offset;
> -	index =3D pos >> PAGE_SHIFT;
> -	offset =3D pos & ~PAGE_MASK;
> -	*_start_offset =3D offset;
> -
> -	count =3D 1;
> -	if (size > PAGE_SIZE - offset) {
> -		size -=3D PAGE_SIZE - offset;
> -		count +=3D size >> PAGE_SHIFT;
> -		size &=3D ~PAGE_MASK;
> -		if (size)
> -			count++;
> -	}
> -
> -	*pages =3D p =3D get_pages_array(count);
> -	if (!p)
> -		return -ENOMEM;
> -
> -	nr =3D iter_xarray_populate_pages(p, i->xarray, index, count);
> -	if (nr =3D=3D 0)
> -		return 0;
> -
> -	return min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
> -}
> -
>  static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
>  		   struct page ***pages, size_t maxsize,
>  		   size_t *start)
> @@ -1498,7 +1469,7 @@ static ssize_t __iov_iter_get_pages_alloc(struct io=
v_iter *i,
>  	if (iov_iter_is_pipe(i))
>  		return pipe_get_pages(i, pages, maxsize, ~0U, start);
>  	if (iov_iter_is_xarray(i))
> -		return iter_xarray_get_pages_alloc(i, pages, maxsize, start);
> +		return iter_xarray_get_pages(i, pages, maxsize, ~0U, start);
>  	return -EFAULT;
>  }
> =20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
