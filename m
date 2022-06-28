Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640CB55C928
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 14:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243647AbiF1L4P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 07:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344908AbiF1L4N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:56:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5145931353
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 04:56:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B29BB808C0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 11:56:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E468BC341CA;
        Tue, 28 Jun 2022 11:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656417368;
        bh=scYoXGTf57l+96rQ4SMOfNpE5i8JzGBwIYpwE5KG4Yg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=laeThc3aXIXjSXsKEp+AqQ6weBcEPn1MlxfEwhcu7KGc47S5h73Kl/bVNxkV4L6nK
         YmqVRdbDeNaYNr0vIi6GzYvM7wgtrWOZNrqFzwT7qNz3o6l9C8HaNZx8AS8/06KS2j
         do67NjC6YmiUQ5VonNeeCP2wBs9rY+ZSOsIzge8vyttHmWVsNFomHvcN5HAqIy23QZ
         k72YBn6IvJLn9IziEQ4cDfgYBFkZPP86buNJbn01uB61ckU5qMi4bgpyd/wU/AOr2u
         XP53l67csm7tTpM2LhEQavoVm7qFQEWB7YFPoQy09BiB6Cy9uKSBDcBybYy1ZAaoXl
         GSzUpzX0fL/hQ==
Message-ID: <70b0b524f692c5bf42b1ec05df59e99b42dd5562.camel@kernel.org>
Subject: Re: [PATCH 30/44] iov_iter: lift dealing with maxpages out of
 first_{iovec,bvec}_segment()
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Date:   Tue, 28 Jun 2022 07:56:06 -0400
In-Reply-To: <20220622041552.737754-30-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
         <20220622041552.737754-1-viro@zeniv.linux.org.uk>
         <20220622041552.737754-30-viro@zeniv.linux.org.uk>
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
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  lib/iov_iter.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>=20
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 92a566f839f9..9ef671b101dc 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1308,12 +1308,9 @@ static ssize_t iter_xarray_get_pages(struct iov_it=
er *i,
> =20
>  static unsigned long found_ubuf_segment(unsigned long addr,
>  					size_t len,
> -					size_t *size, size_t *start,
> -					unsigned maxpages)
> +					size_t *size, size_t *start)
>  {
>  	len +=3D (*start =3D addr % PAGE_SIZE);
> -	if (len > maxpages * PAGE_SIZE)
> -		len =3D maxpages * PAGE_SIZE;
>  	*size =3D len;
>  	return addr & PAGE_MASK;
>  }
> @@ -1321,14 +1318,14 @@ static unsigned long found_ubuf_segment(unsigned =
long addr,
>  /* must be done on non-empty ITER_UBUF or ITER_IOVEC one */
>  static unsigned long first_iovec_segment(const struct iov_iter *i,
>  					 size_t *size, size_t *start,
> -					 size_t maxsize, unsigned maxpages)
> +					 size_t maxsize)
>  {
>  	size_t skip;
>  	long k;
> =20
>  	if (iter_is_ubuf(i)) {
>  		unsigned long addr =3D (unsigned long)i->ubuf + i->iov_offset;
> -		return found_ubuf_segment(addr, maxsize, size, start, maxpages);
> +		return found_ubuf_segment(addr, maxsize, size, start);
>  	}
> =20
>  	for (k =3D 0, skip =3D i->iov_offset; k < i->nr_segs; k++, skip =3D 0) =
{
> @@ -1339,7 +1336,7 @@ static unsigned long first_iovec_segment(const stru=
ct iov_iter *i,
>  			continue;
>  		if (len > maxsize)
>  			len =3D maxsize;
> -		return found_ubuf_segment(addr, len, size, start, maxpages);
> +		return found_ubuf_segment(addr, len, size, start);
>  	}
>  	BUG(); // if it had been empty, we wouldn't get called
>  }
> @@ -1347,7 +1344,7 @@ static unsigned long first_iovec_segment(const stru=
ct iov_iter *i,
>  /* must be done on non-empty ITER_BVEC one */
>  static struct page *first_bvec_segment(const struct iov_iter *i,
>  				       size_t *size, size_t *start,
> -				       size_t maxsize, unsigned maxpages)
> +				       size_t maxsize)
>  {
>  	struct page *page;
>  	size_t skip =3D i->iov_offset, len;
> @@ -1358,8 +1355,6 @@ static struct page *first_bvec_segment(const struct=
 iov_iter *i,
>  	skip +=3D i->bvec->bv_offset;
>  	page =3D i->bvec->bv_page + skip / PAGE_SIZE;
>  	len +=3D (*start =3D skip % PAGE_SIZE);
> -	if (len > maxpages * PAGE_SIZE)
> -		len =3D maxpages * PAGE_SIZE;
>  	*size =3D len;
>  	return page;
>  }
> @@ -1387,7 +1382,9 @@ static ssize_t __iov_iter_get_pages_alloc(struct io=
v_iter *i,
>  		if (i->nofault)
>  			gup_flags |=3D FOLL_NOFAULT;
> =20
> -		addr =3D first_iovec_segment(i, &len, start, maxsize, maxpages);
> +		addr =3D first_iovec_segment(i, &len, start, maxsize);
> +		if (len > maxpages * PAGE_SIZE)
> +			len =3D maxpages * PAGE_SIZE;
>  		n =3D DIV_ROUND_UP(len, PAGE_SIZE);
>  		if (!*pages) {
>  			*pages =3D get_pages_array(n);
> @@ -1403,7 +1400,9 @@ static ssize_t __iov_iter_get_pages_alloc(struct io=
v_iter *i,
>  		struct page **p;
>  		struct page *page;
> =20
> -		page =3D first_bvec_segment(i, &len, start, maxsize, maxpages);
> +		page =3D first_bvec_segment(i, &len, start, maxsize);
> +		if (len > maxpages * PAGE_SIZE)
> +			len =3D maxpages * PAGE_SIZE;
>  		n =3D DIV_ROUND_UP(len, PAGE_SIZE);
>  		p =3D *pages;
>  		if (!p) {

Reviewed-by: Jeff Layton <jlayton@kernel.org>
