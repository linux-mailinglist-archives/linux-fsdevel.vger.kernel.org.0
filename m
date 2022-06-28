Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60EC55D351
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244356AbiF1Lrs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 07:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345140AbiF1LrT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:47:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A422FFED
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 04:45:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07C5EB81BEF
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 11:45:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CECC3411D;
        Tue, 28 Jun 2022 11:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656416726;
        bh=1MUvF4wrBkh16lmNSPkipbT+k8ENsVlDWCG2Q0tEloU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Qe45Qcsrw5dP7AKzkcAY9suJfTZ9kVSt8DIOMUg6GNphzBWyrqFuFgPj3GMZ8U00S
         ToWh7kdmjM8+wwHNz5husxXjn4ec3NnrZp5F81u8vcfHRWUV7swfhJyMGLJzlld71F
         YnLxaG/n105lWrvVWhoy7oqVz0o5rtOxvXwsQUr3pgUIZs3N1gvpx1xCgLI74UVrSh
         KmfnFtcNEt1yY0Xv2Q2bacg5G0sHY7ch3a9VcjiC9i1YjXEPn42Vn6HNaRhGxe6NIi
         exPV583Teu4Il24IdRtjKsv27Xo7d0mnuKqiknX4jKQY6d3KfZvef5PKx4/i8eP1vK
         5HIm5Nd9PLx+A==
Message-ID: <38dd6d58a7915bdc234db8f7c1082ca9da01b1df.camel@kernel.org>
Subject: Re: [PATCH 24/44] iov_iter_get_pages_alloc(): lift freeing pages
 array on failure exits into wrapper
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Date:   Tue, 28 Jun 2022 07:45:24 -0400
In-Reply-To: <20220622041552.737754-24-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
         <20220622041552.737754-1-viro@zeniv.linux.org.uk>
         <20220622041552.737754-24-viro@zeniv.linux.org.uk>
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
> Incidentally, ITER_XARRAY did *not* free the sucker in case when
> iter_xarray_populate_pages() returned 0...
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  lib/iov_iter.c | 38 ++++++++++++++++++++++----------------
>  1 file changed, 22 insertions(+), 16 deletions(-)
>=20
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index c3fb7853dbe8..9c25661684c6 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1425,15 +1425,10 @@ static ssize_t pipe_get_pages_alloc(struct iov_it=
er *i,
>  		maxsize =3D n;
>  	else
>  		npages =3D DIV_ROUND_UP(maxsize + off, PAGE_SIZE);
> -	p =3D get_pages_array(npages);
> +	*pages =3D p =3D get_pages_array(npages);
>  	if (!p)
>  		return -ENOMEM;
> -	n =3D __pipe_get_pages(i, maxsize, p, off);
> -	if (n > 0)
> -		*pages =3D p;
> -	else
> -		kvfree(p);
> -	return n;
> +	return __pipe_get_pages(i, maxsize, p, off);
>  }
> =20
>  static ssize_t iter_xarray_get_pages_alloc(struct iov_iter *i,
> @@ -1463,10 +1458,9 @@ static ssize_t iter_xarray_get_pages_alloc(struct =
iov_iter *i,
>  			count++;
>  	}
> =20
> -	p =3D get_pages_array(count);
> +	*pages =3D p =3D get_pages_array(count);
>  	if (!p)
>  		return -ENOMEM;
> -	*pages =3D p;
> =20
>  	nr =3D iter_xarray_populate_pages(p, i->xarray, index, count);
>  	if (nr =3D=3D 0)
> @@ -1475,7 +1469,7 @@ static ssize_t iter_xarray_get_pages_alloc(struct i=
ov_iter *i,
>  	return min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
>  }
> =20
> -ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
> +static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
>  		   struct page ***pages, size_t maxsize,
>  		   size_t *start)
>  {
> @@ -1501,16 +1495,12 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter =
*i,
> =20
>  		addr =3D first_iovec_segment(i, &len, start, maxsize, ~0U);
>  		n =3D DIV_ROUND_UP(len, PAGE_SIZE);
> -		p =3D get_pages_array(n);
> +		*pages =3D p =3D get_pages_array(n);
>  		if (!p)
>  			return -ENOMEM;
>  		res =3D get_user_pages_fast(addr, n, gup_flags, p);
> -		if (unlikely(res <=3D 0)) {
> -			kvfree(p);
> -			*pages =3D NULL;
> +		if (unlikely(res <=3D 0))
>  			return res;
> -		}
> -		*pages =3D p;
>  		return (res =3D=3D n ? len : res * PAGE_SIZE) - *start;
>  	}
>  	if (iov_iter_is_bvec(i)) {
> @@ -1531,6 +1521,22 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *=
i,
>  		return iter_xarray_get_pages_alloc(i, pages, maxsize, start);
>  	return -EFAULT;
>  }
> +
> +ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
> +		   struct page ***pages, size_t maxsize,
> +		   size_t *start)
> +{
> +	ssize_t len;
> +
> +	*pages =3D NULL;
> +
> +	len =3D __iov_iter_get_pages_alloc(i, pages, maxsize, start);
> +	if (len <=3D 0) {
> +		kvfree(*pages);
> +		*pages =3D NULL;
> +	}
> +	return len;
> +}
>  EXPORT_SYMBOL(iov_iter_get_pages_alloc);
> =20
>  size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,


Reviewed-by: Jeff Layton <jlayton@kernel.org>
