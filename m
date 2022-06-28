Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315AA55C29C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 14:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345159AbiF1MJf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 08:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235331AbiF1MJb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:09:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBDE33A36
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 05:09:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21D6A60F97
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 12:09:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91EA5C341CA;
        Tue, 28 Jun 2022 12:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656418169;
        bh=rWNhtNgvbTZ1HZaapZv4h2sdWfOHirGuxK8Xll4SwPQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aBS8SHTwyXk9wS71Sb+qA4/yr6jz0MIKQafxmp7U/owASJxb+CrILEg5vywX6qSMq
         BOLz3hn74yTkf675SyRocv9uJB9xAm4HTlRMqcRPJqDfsJ1R3g7zS4qaVgGYgDagby
         yRv2KorSGjfZSUmN7rBtDbDJ8/GY6VDKWtV1Ui0+8kP8x/j5RLaj118PFGFh2Tm5wV
         NAGOLOBlcTxSjV02j08Nr5oBoZIhr/MQ56om48E5wH36wlst0E2Lr/FW0WCyHxvtnR
         edDXxW2pYoMwKloIBqI5JIDBsLWDQF6pwlEKQQdlr/TiL8syKI7MbLy1+72V/XjI4e
         9kPtXQV2U8xfA==
Message-ID: <97b9a118a667212a968c18da8ab311280b9359a5.camel@kernel.org>
Subject: Re: [PATCH 33/44] found_iovec_segment(): just return address
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Date:   Tue, 28 Jun 2022 08:09:27 -0400
In-Reply-To: <20220622041552.737754-33-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
         <20220622041552.737754-1-viro@zeniv.linux.org.uk>
         <20220622041552.737754-33-viro@zeniv.linux.org.uk>
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

Subject line should read "first_iovec_segment"=20

On Wed, 2022-06-22 at 05:15 +0100, Al Viro wrote:
> ... and calculate the offset in the caller
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  lib/iov_iter.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
>=20
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index fca66ecce7a0..f455b8ee0d76 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1306,33 +1306,23 @@ static ssize_t iter_xarray_get_pages(struct iov_i=
ter *i,
>  	return min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
>  }
> =20
> -static unsigned long found_ubuf_segment(unsigned long addr, size_t *star=
t)
> -{
> -	*start =3D addr % PAGE_SIZE;
> -	return addr & PAGE_MASK;
> -}
> -
>  /* must be done on non-empty ITER_UBUF or ITER_IOVEC one */
>  static unsigned long first_iovec_segment(const struct iov_iter *i,
> -					 size_t *size, size_t *start)
> +					 size_t *size)
>  {
>  	size_t skip;
>  	long k;
> =20
> -	if (iter_is_ubuf(i)) {
> -		unsigned long addr =3D (unsigned long)i->ubuf + i->iov_offset;
> -		return found_ubuf_segment(addr, start);
> -	}
> +	if (iter_is_ubuf(i))
> +		return (unsigned long)i->ubuf + i->iov_offset;
> =20
>  	for (k =3D 0, skip =3D i->iov_offset; k < i->nr_segs; k++, skip =3D 0) =
{
> -		unsigned long addr =3D (unsigned long)i->iov[k].iov_base + skip;
>  		size_t len =3D i->iov[k].iov_len - skip;
> -
>  		if (unlikely(!len))
>  			continue;
>  		if (*size > len)
>  			*size =3D len;
> -		return found_ubuf_segment(addr, start);
> +		return (unsigned long)i->iov[k].iov_base + skip;
>  	}
>  	BUG(); // if it had been empty, we wouldn't get called
>  }
> @@ -1375,7 +1365,9 @@ static ssize_t __iov_iter_get_pages_alloc(struct io=
v_iter *i,
>  		if (i->nofault)
>  			gup_flags |=3D FOLL_NOFAULT;
> =20
> -		addr =3D first_iovec_segment(i, &maxsize, start);
> +		addr =3D first_iovec_segment(i, &maxsize);
> +		*start =3D addr % PAGE_SIZE;
> +		addr &=3D PAGE_MASK;
>  		n =3D DIV_ROUND_UP(maxsize + *start, PAGE_SIZE);
>  		if (n > maxpages)
>  			n =3D maxpages;

Reviewed-by: Jeff Layton <jlayton@kernel.org>
