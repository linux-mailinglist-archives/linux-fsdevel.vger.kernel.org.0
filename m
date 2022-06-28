Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6F355C163
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 14:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239617AbiF1MHc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 08:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238286AbiF1MHb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:07:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EC8255BB
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 05:06:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0735C60F06
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 12:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C8AC3411D;
        Tue, 28 Jun 2022 12:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656418008;
        bh=uJS87uGYaWdDsDyiKOcr19tMBMsRj3d8CYlsOmYR/74=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hLiWR9XpF0oCC8PtWPhcLoiVIH8V40M/o5w43OZGZScDnaXbZRG/Lo3NCOPjZo5oC
         ZS9D3o51PTdBa/aWYOxALpvbANaglYVJ/pLADqMv1yDlMyA/TC4bgGygmQd4KnZ+Y1
         aTTY3AYoZCkBj/XjuPQfczaaJCfyMEC8eBI6RZnmlS7YMXEkLSCpVNNI1eIYR8RYpM
         vk1MxrHs6cFwy0MUFBh6vH9MR4tT96YP4JVfTz1ouef8Ov0VDPze+a/ovMrOBRlmBE
         BY9SGkmxMMWjXdr9z120J3VWc2OCxbaUV5w+Nn9w6vAlWpR3+ZB+2pzbmtiIk14gCn
         51p/uDVm7cMag==
Message-ID: <ca533ea75a3181f437ec907e6614e9f9ff42f43d.camel@kernel.org>
Subject: Re: [PATCH 32/44] iov_iter: massage calling conventions for
 first_{iovec,bvec}_segment()
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Date:   Tue, 28 Jun 2022 08:06:46 -0400
In-Reply-To: <20220622041552.737754-32-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
         <20220622041552.737754-1-viro@zeniv.linux.org.uk>
         <20220622041552.737754-32-viro@zeniv.linux.org.uk>
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
> Pass maxsize by reference, return length via the same.
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  lib/iov_iter.c | 37 +++++++++++++++----------------------
>  1 file changed, 15 insertions(+), 22 deletions(-)
>=20
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 0bed684d91d0..fca66ecce7a0 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1306,26 +1306,22 @@ static ssize_t iter_xarray_get_pages(struct iov_i=
ter *i,
>  	return min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
>  }
> =20
> -static unsigned long found_ubuf_segment(unsigned long addr,
> -					size_t len,
> -					size_t *size, size_t *start)
> +static unsigned long found_ubuf_segment(unsigned long addr, size_t *star=
t)
>  {
>  	*start =3D addr % PAGE_SIZE;
> -	*size =3D len;
>  	return addr & PAGE_MASK;
>  }
> =20
>  /* must be done on non-empty ITER_UBUF or ITER_IOVEC one */
>  static unsigned long first_iovec_segment(const struct iov_iter *i,
> -					 size_t *size, size_t *start,
> -					 size_t maxsize)
> +					 size_t *size, size_t *start)
>  {
>  	size_t skip;
>  	long k;
> =20
>  	if (iter_is_ubuf(i)) {
>  		unsigned long addr =3D (unsigned long)i->ubuf + i->iov_offset;
> -		return found_ubuf_segment(addr, maxsize, size, start);
> +		return found_ubuf_segment(addr, start);
>  	}
> =20
>  	for (k =3D 0, skip =3D i->iov_offset; k < i->nr_segs; k++, skip =3D 0) =
{
> @@ -1334,28 +1330,26 @@ static unsigned long first_iovec_segment(const st=
ruct iov_iter *i,
> =20
>  		if (unlikely(!len))
>  			continue;
> -		if (len > maxsize)
> -			len =3D maxsize;
> -		return found_ubuf_segment(addr, len, size, start);
> +		if (*size > len)
> +			*size =3D len;
> +		return found_ubuf_segment(addr, start);
>  	}
>  	BUG(); // if it had been empty, we wouldn't get called
>  }
> =20
>  /* must be done on non-empty ITER_BVEC one */
>  static struct page *first_bvec_segment(const struct iov_iter *i,
> -				       size_t *size, size_t *start,
> -				       size_t maxsize)
> +				       size_t *size, size_t *start)
>  {
>  	struct page *page;
>  	size_t skip =3D i->iov_offset, len;
> =20
>  	len =3D i->bvec->bv_len - skip;
> -	if (len > maxsize)
> -		len =3D maxsize;
> +	if (*size > len)
> +		*size =3D len;
>  	skip +=3D i->bvec->bv_offset;
>  	page =3D i->bvec->bv_page + skip / PAGE_SIZE;
>  	*start =3D skip % PAGE_SIZE;
> -	*size =3D len;
>  	return page;
>  }
> =20
> @@ -1363,7 +1357,6 @@ static ssize_t __iov_iter_get_pages_alloc(struct io=
v_iter *i,
>  		   struct page ***pages, size_t maxsize,
>  		   unsigned int maxpages, size_t *start)
>  {
> -	size_t len;
>  	int n, res;
> =20
>  	if (maxsize > i->count)
> @@ -1382,8 +1375,8 @@ static ssize_t __iov_iter_get_pages_alloc(struct io=
v_iter *i,
>  		if (i->nofault)
>  			gup_flags |=3D FOLL_NOFAULT;
> =20
> -		addr =3D first_iovec_segment(i, &len, start, maxsize);
> -		n =3D DIV_ROUND_UP(len + *start, PAGE_SIZE);
> +		addr =3D first_iovec_segment(i, &maxsize, start);
> +		n =3D DIV_ROUND_UP(maxsize + *start, PAGE_SIZE);
>  		if (n > maxpages)
>  			n =3D maxpages;
>  		if (!*pages) {
> @@ -1394,14 +1387,14 @@ static ssize_t __iov_iter_get_pages_alloc(struct =
iov_iter *i,
>  		res =3D get_user_pages_fast(addr, n, gup_flags, *pages);
>  		if (unlikely(res <=3D 0))
>  			return res;
> -		return min_t(size_t, len, res * PAGE_SIZE - *start);
> +		return min_t(size_t, maxsize, res * PAGE_SIZE - *start);
>  	}
>  	if (iov_iter_is_bvec(i)) {
>  		struct page **p;
>  		struct page *page;
> =20
> -		page =3D first_bvec_segment(i, &len, start, maxsize);
> -		n =3D DIV_ROUND_UP(len + *start, PAGE_SIZE);
> +		page =3D first_bvec_segment(i, &maxsize, start);
> +		n =3D DIV_ROUND_UP(maxsize + *start, PAGE_SIZE);
>  		if (n > maxpages)
>  			n =3D maxpages;
>  		p =3D *pages;
> @@ -1412,7 +1405,7 @@ static ssize_t __iov_iter_get_pages_alloc(struct io=
v_iter *i,
>  		}
>  		for (int k =3D 0; k < n; k++)
>  			get_page(*p++ =3D page++);
> -		return min_t(size_t, len, n * PAGE_SIZE - *start);
> +		return min_t(size_t, maxsize, n * PAGE_SIZE - *start);
>  	}
>  	if (iov_iter_is_pipe(i))
>  		return pipe_get_pages(i, pages, maxsize, maxpages, start);

Reviewed-by: Jeff Layton <jlayton@kernel.org>
