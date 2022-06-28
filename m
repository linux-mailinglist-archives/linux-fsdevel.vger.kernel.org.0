Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81ECE55DE5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344821AbiF1LyJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 07:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344720AbiF1LyI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:54:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAE530F7F
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 04:54:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3041860C50
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 11:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3776C3411D;
        Tue, 28 Jun 2022 11:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656417246;
        bh=7Exp3uuDYftC1Kc9TUILgP5JAsyg22VZl4q5tvD5wbI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ec//1F1YD2L0Cc9RnovXioudDwi//vz3lVFTFbbIbISxIlB/gPRKuH5sQBk9Lnj32
         j+9uPYHj68c7/jzbA3/z+XFUbPjYPRTNihtEYMdKxw/kXmoBp6C5grPQKQXtgStyB3
         nXJHyrzK5nNJnLTIQthVUvDHIZbxn50IDcbZFiYh593+T3/zjkoiFpgDKoG7a34Iu8
         kzarRbwCwyIBi0yyPu/ndwAA/AKbLWQezzmCPhDTgP5Jyagpcs/6thE+konO50A5v0
         9pCGJ430lZpVLdZDT552DjIDS41h6G+MbjrL4C0Qo1V96KdpowT0/30tvjuASvEM6R
         h8PRpw6P2q3aA==
Message-ID: <41e5ef1ad950f1d41fd8a46afaa34cf3ef660f9c.camel@kernel.org>
Subject: Re: [PATCH 28/44] unify the rest of
 iov_iter_get_pages()/iov_iter_get_pages_alloc() guts
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Date:   Tue, 28 Jun 2022 07:54:04 -0400
In-Reply-To: <20220622041552.737754-28-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
         <20220622041552.737754-1-viro@zeniv.linux.org.uk>
         <20220622041552.737754-28-viro@zeniv.linux.org.uk>
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
> same as for pipes and xarrays; after that iov_iter_get_pages() becomes
> a wrapper for __iov_iter_get_pages_alloc().
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  lib/iov_iter.c | 86 ++++++++++++++++----------------------------------
>  1 file changed, 28 insertions(+), 58 deletions(-)
>=20
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 07dacb274ba5..811fa09515d8 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1372,20 +1372,19 @@ static struct page *first_bvec_segment(const stru=
ct iov_iter *i,
>  	return page;
>  }
> =20
> -ssize_t iov_iter_get_pages(struct iov_iter *i,
> -		   struct page **pages, size_t maxsize, unsigned maxpages,
> -		   size_t *start)
> +static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
> +		   struct page ***pages, size_t maxsize,
> +		   unsigned int maxpages, size_t *start)
>  {
>  	size_t len;
>  	int n, res;
> =20
>  	if (maxsize > i->count)
>  		maxsize =3D i->count;
> -	if (!maxsize || !maxpages)
> +	if (!maxsize)
>  		return 0;=20
>  	if (maxsize > MAX_RW_COUNT)
>  		maxsize =3D MAX_RW_COUNT;
> -	BUG_ON(!pages);
> =20
>  	if (likely(user_backed_iter(i))) {
>  		unsigned int gup_flags =3D 0;
> @@ -1398,80 +1397,51 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
> =20
>  		addr =3D first_iovec_segment(i, &len, start, maxsize, maxpages);
>  		n =3D DIV_ROUND_UP(len, PAGE_SIZE);
> -		res =3D get_user_pages_fast(addr, n, gup_flags, pages);
> +		if (!*pages) {
> +			*pages =3D get_pages_array(n);
> +			if (!*pages)
> +				return -ENOMEM;
> +		}
> +		res =3D get_user_pages_fast(addr, n, gup_flags, *pages);
>  		if (unlikely(res <=3D 0))
>  			return res;
>  		return (res =3D=3D n ? len : res * PAGE_SIZE) - *start;
>  	}
>  	if (iov_iter_is_bvec(i)) {
> +		struct page **p;
>  		struct page *page;
> =20
>  		page =3D first_bvec_segment(i, &len, start, maxsize, maxpages);
>  		n =3D DIV_ROUND_UP(len, PAGE_SIZE);
> +		p =3D *pages;
> +		if (!p) {
> +			*pages =3D p =3D get_pages_array(n);
> +			if (!p)
> +				return -ENOMEM;
> +		}
>  		while (n--)
> -			get_page(*pages++ =3D page++);
> +			get_page(*p++ =3D page++);
>  		return len - *start;
>  	}
>  	if (iov_iter_is_pipe(i))
> -		return pipe_get_pages(i, &pages, maxsize, maxpages, start);
> +		return pipe_get_pages(i, pages, maxsize, maxpages, start);
>  	if (iov_iter_is_xarray(i))
> -		return iter_xarray_get_pages(i, &pages, maxsize, maxpages, start);
> +		return iter_xarray_get_pages(i, pages, maxsize, maxpages,
> +					     start);
>  	return -EFAULT;
>  }
> -EXPORT_SYMBOL(iov_iter_get_pages);
> =20
> -static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
> -		   struct page ***pages, size_t maxsize,
> +ssize_t iov_iter_get_pages(struct iov_iter *i,
> +		   struct page **pages, size_t maxsize, unsigned maxpages,
>  		   size_t *start)
>  {
> -	struct page **p;
> -	size_t len;
> -	int n, res;
> -
> -	if (maxsize > i->count)
> -		maxsize =3D i->count;
> -	if (!maxsize)
> +	if (!maxpages)
>  		return 0;
> -	if (maxsize > MAX_RW_COUNT)
> -		maxsize =3D MAX_RW_COUNT;
> -
> -	if (likely(user_backed_iter(i))) {
> -		unsigned int gup_flags =3D 0;
> -		unsigned long addr;
> -
> -		if (iov_iter_rw(i) !=3D WRITE)
> -			gup_flags |=3D FOLL_WRITE;
> -		if (i->nofault)
> -			gup_flags |=3D FOLL_NOFAULT;
> -
> -		addr =3D first_iovec_segment(i, &len, start, maxsize, ~0U);
> -		n =3D DIV_ROUND_UP(len, PAGE_SIZE);
> -		*pages =3D p =3D get_pages_array(n);
> -		if (!p)
> -			return -ENOMEM;
> -		res =3D get_user_pages_fast(addr, n, gup_flags, p);
> -		if (unlikely(res <=3D 0))
> -			return res;
> -		return (res =3D=3D n ? len : res * PAGE_SIZE) - *start;
> -	}
> -	if (iov_iter_is_bvec(i)) {
> -		struct page *page;
> +	BUG_ON(!pages);
> =20
> -		page =3D first_bvec_segment(i, &len, start, maxsize, ~0U);
> -		n =3D DIV_ROUND_UP(len, PAGE_SIZE);
> -		*pages =3D p =3D get_pages_array(n);
> -		if (!p)
> -			return -ENOMEM;
> -		while (n--)
> -			get_page(*p++ =3D page++);
> -		return len - *start;
> -	}
> -	if (iov_iter_is_pipe(i))
> -		return pipe_get_pages(i, pages, maxsize, ~0U, start);
> -	if (iov_iter_is_xarray(i))
> -		return iter_xarray_get_pages(i, pages, maxsize, ~0U, start);
> -	return -EFAULT;
> +	return __iov_iter_get_pages_alloc(i, &pages, maxsize, maxpages, start);
>  }
> +EXPORT_SYMBOL(iov_iter_get_pages);
> =20
>  ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
>  		   struct page ***pages, size_t maxsize,
> @@ -1481,7 +1451,7 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i=
,
> =20
>  	*pages =3D NULL;
> =20
> -	len =3D __iov_iter_get_pages_alloc(i, pages, maxsize, start);
> +	len =3D __iov_iter_get_pages_alloc(i, pages, maxsize, ~0U, start);
>  	if (len <=3D 0) {
>  		kvfree(*pages);
>  		*pages =3D NULL;

Reviewed-by: Jeff Layton <jlayton@kernel.org>
