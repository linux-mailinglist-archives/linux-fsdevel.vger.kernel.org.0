Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F0A55E1E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344843AbiF1Lt0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 07:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344763AbiF1LtW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:49:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FED60D5
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 04:49:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 950C160C17
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 11:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E5BC3411D;
        Tue, 28 Jun 2022 11:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656416959;
        bh=ewXraRXFyGceyyfsFsm4BPyvA5iL7r9gkdCOx5w1q7I=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=K5jMMp0Pkk8MewAyTL7qvqICQFQHDCTWvLKU9tu0rNhNaTUJugOT44a5gNNdO9kRn
         DCN9YNoxUBYOi6/xulexYHwV1jdIePEKafn/dSI24+RgMxMYHhnG1/yOn2NG9JB6hZ
         2Yq5LJ8Ihy0VoGcMXSieS6+MP6LhKyvLDDBqhvSB329kWfuyNUYgWpe6td2ytOIg9i
         cnuzvUDxnUyhftpbJnx9Ktozkuw7vKmUWQx149FWXxHeh1r+D8Cu9kpL3eHUHM5MZN
         xU+EMReNj63o7SZy4ril9kgg4jLMFuOZdHfF3A3g4x+lVkebFFfZYJbk58uN9Qiq5X
         EBQVlXfuiX19Q==
Message-ID: <3e0c848c0e80f6f1095a4432939869215e9a145b.camel@kernel.org>
Subject: Re: [PATCH 26/44] unify pipe_get_pages() and pipe_get_pages_alloc()
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Date:   Tue, 28 Jun 2022 07:49:16 -0400
In-Reply-To: <20220622041552.737754-26-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
         <20220622041552.737754-1-viro@zeniv.linux.org.uk>
         <20220622041552.737754-26-viro@zeniv.linux.org.uk>
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
> 	The differences between those two are
> * pipe_get_pages() gets a non-NULL struct page ** value pointing to
> preallocated array + array size.
> * pipe_get_pages_alloc() gets an address of struct page ** variable that
> contains NULL, allocates the array and (on success) stores its address in
> that variable.
>=20
> 	Not hard to combine - always pass struct page ***, have
> the previous pipe_get_pages_alloc() caller pass ~0U as cap for
> array size.
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  lib/iov_iter.c | 49 +++++++++++++++++--------------------------------
>  1 file changed, 17 insertions(+), 32 deletions(-)
>=20
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 5c985cf2858e..1c98f2f3a581 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1187,6 +1187,11 @@ unsigned long iov_iter_gap_alignment(const struct =
iov_iter *i)
>  }
>  EXPORT_SYMBOL(iov_iter_gap_alignment);
> =20
> +static struct page **get_pages_array(size_t n)
> +{
> +	return kvmalloc_array(n, sizeof(struct page *), GFP_KERNEL);
> +}
> +
>  static inline ssize_t __pipe_get_pages(struct iov_iter *i,
>  				size_t maxsize,
>  				struct page **pages,
> @@ -1220,10 +1225,11 @@ static inline ssize_t __pipe_get_pages(struct iov=
_iter *i,
>  }
> =20
>  static ssize_t pipe_get_pages(struct iov_iter *i,
> -		   struct page **pages, size_t maxsize, unsigned maxpages,
> +		   struct page ***pages, size_t maxsize, unsigned maxpages,
>  		   size_t *start)
>  {
>  	unsigned int npages, off;
> +	struct page **p;
>  	size_t capacity;
> =20
>  	if (!sanity(i))
> @@ -1231,8 +1237,15 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
> =20
>  	*start =3D off =3D pipe_npages(i, &npages);
>  	capacity =3D min(npages, maxpages) * PAGE_SIZE - off;
> +	maxsize =3D min(maxsize, capacity);
> +	p =3D *pages;
> +	if (!p) {
> +		*pages =3D p =3D get_pages_array(DIV_ROUND_UP(maxsize + off, PAGE_SIZE=
));
> +		if (!p)
> +			return -ENOMEM;
> +	}
> =20
> -	return __pipe_get_pages(i, min(maxsize, capacity), pages, off);
> +	return __pipe_get_pages(i, maxsize, p, off);
>  }
> =20
>  static ssize_t iter_xarray_populate_pages(struct page **pages, struct xa=
rray *xa,
> @@ -1394,41 +1407,13 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
>  		return len - *start;
>  	}
>  	if (iov_iter_is_pipe(i))
> -		return pipe_get_pages(i, pages, maxsize, maxpages, start);
> +		return pipe_get_pages(i, &pages, maxsize, maxpages, start);
>  	if (iov_iter_is_xarray(i))
>  		return iter_xarray_get_pages(i, pages, maxsize, maxpages, start);
>  	return -EFAULT;
>  }
>  EXPORT_SYMBOL(iov_iter_get_pages);
> =20
> -static struct page **get_pages_array(size_t n)
> -{
> -	return kvmalloc_array(n, sizeof(struct page *), GFP_KERNEL);
> -}
> -
> -static ssize_t pipe_get_pages_alloc(struct iov_iter *i,
> -		   struct page ***pages, size_t maxsize,
> -		   size_t *start)
> -{
> -	struct page **p;
> -	unsigned int npages, off;
> -	ssize_t n;
> -
> -	if (!sanity(i))
> -		return -EFAULT;
> -
> -	*start =3D off =3D pipe_npages(i, &npages);
> -	n =3D npages * PAGE_SIZE - off;
> -	if (maxsize > n)
> -		maxsize =3D n;
> -	else
> -		npages =3D DIV_ROUND_UP(maxsize + off, PAGE_SIZE);
> -	*pages =3D p =3D get_pages_array(npages);
> -	if (!p)
> -		return -ENOMEM;
> -	return __pipe_get_pages(i, maxsize, p, off);
> -}
> -
>  static ssize_t iter_xarray_get_pages_alloc(struct iov_iter *i,
>  					   struct page ***pages, size_t maxsize,
>  					   size_t *_start_offset)
> @@ -1511,7 +1496,7 @@ static ssize_t __iov_iter_get_pages_alloc(struct io=
v_iter *i,
>  		return len - *start;
>  	}
>  	if (iov_iter_is_pipe(i))
> -		return pipe_get_pages_alloc(i, pages, maxsize, start);
> +		return pipe_get_pages(i, pages, maxsize, ~0U, start);
>  	if (iov_iter_is_xarray(i))
>  		return iter_xarray_get_pages_alloc(i, pages, maxsize, start);
>  	return -EFAULT;

Reviewed-by: Jeff Layton <jlayton@kernel.org>
