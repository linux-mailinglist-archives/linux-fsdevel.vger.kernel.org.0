Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135E855D92B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344957AbiF1L6e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 07:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344057AbiF1L6Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:58:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB70FCD
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 04:58:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A958EB81D2C
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 11:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70137C3411D;
        Tue, 28 Jun 2022 11:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656417500;
        bh=1VVFD6MmIq1XDAtrAvZkvzu09SfKhMbvTX6xzhVDuqA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=siedhUhqqwlvf5+jr2/1eIm0I77laHONe68U4B99qGppgN+euH69kI7tHewxcN0FP
         YyEVKRQ9TOIDVx9RBZwUDjZV+jKvxqt+oDRCD+BaiCg0vnrEFtyULwYnFSRj6i9R4k
         rmbsqNaXwpudI9sWNOWvzTg9p+m6Mb6EQoUxn/hOB2fyZRWvVXgl7KZPZJDmAiooQe
         plmed0npAnLx03atxnaHxz5U1shaj48WSkFm/nt1jLS61RjmdYGxYi5AvzMq8Eg1Bk
         wihkLWueD5CitibvKyr8gswlSEZRpZrW++CZV+o7FMjM0JIWZ/gZSddu6thK4QHKYK
         hVwmiQ3oxcvng==
Message-ID: <d85dffde64c7f272f63af0e8fe82ed58704d2953.camel@kernel.org>
Subject: Re: [PATCH 31/44] iov_iter: first_{iovec,bvec}_segment() - simplify
 a bit
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Date:   Tue, 28 Jun 2022 07:58:18 -0400
In-Reply-To: <20220622041552.737754-31-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
         <20220622041552.737754-1-viro@zeniv.linux.org.uk>
         <20220622041552.737754-31-viro@zeniv.linux.org.uk>
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
> We return length + offset in page via *size.  Don't bother - the caller
> can do that arithmetics just as well; just report the length to it.
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  lib/iov_iter.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 9ef671b101dc..0bed684d91d0 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1310,7 +1310,7 @@ static unsigned long found_ubuf_segment(unsigned lo=
ng addr,
>  					size_t len,
>  					size_t *size, size_t *start)
>  {
> -	len +=3D (*start =3D addr % PAGE_SIZE);
> +	*start =3D addr % PAGE_SIZE;
>  	*size =3D len;
>  	return addr & PAGE_MASK;
>  }
> @@ -1354,7 +1354,7 @@ static struct page *first_bvec_segment(const struct=
 iov_iter *i,
>  		len =3D maxsize;
>  	skip +=3D i->bvec->bv_offset;
>  	page =3D i->bvec->bv_page + skip / PAGE_SIZE;
> -	len +=3D (*start =3D skip % PAGE_SIZE);
> +	*start =3D skip % PAGE_SIZE;
>  	*size =3D len;
>  	return page;
>  }
> @@ -1383,9 +1383,9 @@ static ssize_t __iov_iter_get_pages_alloc(struct io=
v_iter *i,
>  			gup_flags |=3D FOLL_NOFAULT;
> =20
>  		addr =3D first_iovec_segment(i, &len, start, maxsize);
> -		if (len > maxpages * PAGE_SIZE)
> -			len =3D maxpages * PAGE_SIZE;
> -		n =3D DIV_ROUND_UP(len, PAGE_SIZE);
> +		n =3D DIV_ROUND_UP(len + *start, PAGE_SIZE);
> +		if (n > maxpages)
> +			n =3D maxpages;
>  		if (!*pages) {
>  			*pages =3D get_pages_array(n);
>  			if (!*pages)
> @@ -1394,25 +1394,25 @@ static ssize_t __iov_iter_get_pages_alloc(struct =
iov_iter *i,
>  		res =3D get_user_pages_fast(addr, n, gup_flags, *pages);
>  		if (unlikely(res <=3D 0))
>  			return res;
> -		return (res =3D=3D n ? len : res * PAGE_SIZE) - *start;
> +		return min_t(size_t, len, res * PAGE_SIZE - *start);
>  	}
>  	if (iov_iter_is_bvec(i)) {
>  		struct page **p;
>  		struct page *page;
> =20
>  		page =3D first_bvec_segment(i, &len, start, maxsize);
> -		if (len > maxpages * PAGE_SIZE)
> -			len =3D maxpages * PAGE_SIZE;
> -		n =3D DIV_ROUND_UP(len, PAGE_SIZE);
> +		n =3D DIV_ROUND_UP(len + *start, PAGE_SIZE);
> +		if (n > maxpages)
> +			n =3D maxpages;
>  		p =3D *pages;
>  		if (!p) {
>  			*pages =3D p =3D get_pages_array(n);
>  			if (!p)
>  				return -ENOMEM;
>  		}
> -		while (n--)
> +		for (int k =3D 0; k < n; k++)
>  			get_page(*p++ =3D page++);
> -		return len - *start;
> +		return min_t(size_t, len, n * PAGE_SIZE - *start);
>  	}
>  	if (iov_iter_is_pipe(i))
>  		return pipe_get_pages(i, pages, maxsize, maxpages, start);

Reviewed-by: Jeff Layton <jlayton@kernel.org>
