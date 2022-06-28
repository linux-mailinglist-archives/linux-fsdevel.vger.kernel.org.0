Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304FD55D1C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345386AbiF1MMq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 08:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345413AbiF1MMW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:12:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2BA35866
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 05:12:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 022B1B81D2D
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 12:12:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB75BC3411D;
        Tue, 28 Jun 2022 12:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656418338;
        bh=ZZcLBB0qNIFxmfg/YJqkt3mVrCInBvVlOWFeDPUbF7s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=H6ke2dM9Dd/lfDbGW/HHKVYFWHRsgqRfsKcOLVQf6IqhHgu/R0nE60DP2aGW4Xhl3
         KUCo/jCKvo0U/7TSBJWV+fft+zztS2oUYGVR/wzZaCxk67fP/FdBZPnvs18Fv8qGjS
         uw4pEsKue9o59iCcHxxJVCGE11f/dIOjuRjA2IRgu5SnHBG6hSDdTy3rXVYqI6r7Mn
         BDomyag60TupTOK0w1K3lHOv6izPGbUv5bb1XkZdlj5cdFW99qD/Df3XXpOqmKFQyT
         jJjFaIPozSFCbxBO3MbZ8fsu1OD2LWlJCTSFTGZBLZj4OG6mVPcl0BTDNeNFVyhGuM
         LueO7g+KvqOGw==
Message-ID: <b2f0b9e66f43dcadf5970ee781c22b1a01b4c2b5.camel@kernel.org>
Subject: Re: [PATCH 35/44] iov_iter: saner helper for page array allocation
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Date:   Tue, 28 Jun 2022 08:12:16 -0400
In-Reply-To: <20220622041552.737754-35-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
         <20220622041552.737754-1-viro@zeniv.linux.org.uk>
         <20220622041552.737754-35-viro@zeniv.linux.org.uk>
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
> All call sites of get_pages_array() are essenitally identical now.
> Replace with common helper...
>=20
> Returns number of slots available in resulting array or 0 on OOM;
> it's up to the caller to make sure it doesn't ask to zero-entry
> array (i.e. neither maxpages nor size are allowed to be zero).
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  lib/iov_iter.c | 77 +++++++++++++++++++++-----------------------------
>  1 file changed, 32 insertions(+), 45 deletions(-)
>=20
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 9280f865fd6a..1c744f0c0b2c 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1187,9 +1187,20 @@ unsigned long iov_iter_gap_alignment(const struct =
iov_iter *i)
>  }
>  EXPORT_SYMBOL(iov_iter_gap_alignment);
> =20
> -static struct page **get_pages_array(size_t n)
> +static int want_pages_array(struct page ***res, size_t size,
> +			    size_t start, unsigned int maxpages)
>  {
> -	return kvmalloc_array(n, sizeof(struct page *), GFP_KERNEL);
> +	unsigned int count =3D DIV_ROUND_UP(size + start, PAGE_SIZE);
> +
> +	if (count > maxpages)
> +		count =3D maxpages;
> +	WARN_ON(!count);	// caller should've prevented that
> +	if (!*res) {
> +		*res =3D kvmalloc_array(count, sizeof(struct page *), GFP_KERNEL);
> +		if (!*res)
> +			return 0;
> +	}
> +	return count;
>  }
> =20
>  static ssize_t pipe_get_pages(struct iov_iter *i,
> @@ -1197,27 +1208,20 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
>  		   size_t *start)
>  {
>  	struct pipe_inode_info *pipe =3D i->pipe;
> -	unsigned int npages, off;
> +	unsigned int npages, off, count;
>  	struct page **p;
>  	ssize_t left;
> -	int count;
> =20
>  	if (!sanity(i))
>  		return -EFAULT;
> =20
>  	*start =3D off =3D pipe_npages(i, &npages);
> -	count =3D DIV_ROUND_UP(maxsize + off, PAGE_SIZE);
> -	if (count > npages)
> -		count =3D npages;
> -	if (count > maxpages)
> -		count =3D maxpages;
> +	if (!npages)
> +		return -EFAULT;
> +	count =3D want_pages_array(pages, maxsize, off, min(npages, maxpages));
> +	if (!count)
> +		return -ENOMEM;
>  	p =3D *pages;
> -	if (!p) {
> -		*pages =3D p =3D get_pages_array(count);
> -		if (!p)
> -			return -ENOMEM;
> -	}
> -
>  	left =3D maxsize;
>  	npages =3D 0;
>  	if (off) {
> @@ -1280,9 +1284,8 @@ static ssize_t iter_xarray_get_pages(struct iov_ite=
r *i,
>  				     struct page ***pages, size_t maxsize,
>  				     unsigned maxpages, size_t *_start_offset)
>  {
> -	unsigned nr, offset;
> -	pgoff_t index, count;
> -	size_t size =3D maxsize;
> +	unsigned nr, offset, count;
> +	pgoff_t index;
>  	loff_t pos;
> =20
>  	pos =3D i->xarray_start + i->iov_offset;
> @@ -1290,16 +1293,9 @@ static ssize_t iter_xarray_get_pages(struct iov_it=
er *i,
>  	offset =3D pos & ~PAGE_MASK;
>  	*_start_offset =3D offset;
> =20
> -	count =3D DIV_ROUND_UP(size + offset, PAGE_SIZE);
> -	if (count > maxpages)
> -		count =3D maxpages;
> -
> -	if (!*pages) {
> -		*pages =3D get_pages_array(count);
> -		if (!*pages)
> -			return -ENOMEM;
> -	}
> -
> +	count =3D want_pages_array(pages, maxsize, offset, maxpages);
> +	if (!count)
> +		return -ENOMEM;
>  	nr =3D iter_xarray_populate_pages(*pages, i->xarray, index, count);
>  	if (nr =3D=3D 0)
>  		return 0;
> @@ -1348,7 +1344,7 @@ static ssize_t __iov_iter_get_pages_alloc(struct io=
v_iter *i,
>  		   struct page ***pages, size_t maxsize,
>  		   unsigned int maxpages, size_t *start)
>  {
> -	int n, res;
> +	unsigned int n;
> =20
>  	if (maxsize > i->count)
>  		maxsize =3D i->count;
> @@ -1360,6 +1356,7 @@ static ssize_t __iov_iter_get_pages_alloc(struct io=
v_iter *i,
>  	if (likely(user_backed_iter(i))) {
>  		unsigned int gup_flags =3D 0;
>  		unsigned long addr;
> +		int res;
> =20
>  		if (iov_iter_rw(i) !=3D WRITE)
>  			gup_flags |=3D FOLL_WRITE;
> @@ -1369,14 +1366,9 @@ static ssize_t __iov_iter_get_pages_alloc(struct i=
ov_iter *i,
>  		addr =3D first_iovec_segment(i, &maxsize);
>  		*start =3D addr % PAGE_SIZE;
>  		addr &=3D PAGE_MASK;
> -		n =3D DIV_ROUND_UP(maxsize + *start, PAGE_SIZE);
> -		if (n > maxpages)
> -			n =3D maxpages;
> -		if (!*pages) {
> -			*pages =3D get_pages_array(n);
> -			if (!*pages)
> -				return -ENOMEM;
> -		}
> +		n =3D want_pages_array(pages, maxsize, *start, maxpages);
> +		if (!n)
> +			return -ENOMEM;
>  		res =3D get_user_pages_fast(addr, n, gup_flags, *pages);
>  		if (unlikely(res <=3D 0))
>  			return res;
> @@ -1387,15 +1379,10 @@ static ssize_t __iov_iter_get_pages_alloc(struct =
iov_iter *i,
>  		struct page *page;
> =20
>  		page =3D first_bvec_segment(i, &maxsize, start);
> -		n =3D DIV_ROUND_UP(maxsize + *start, PAGE_SIZE);
> -		if (n > maxpages)
> -			n =3D maxpages;
> +		n =3D want_pages_array(pages, maxsize, *start, maxpages);
> +		if (!n)
> +			return -ENOMEM;
>  		p =3D *pages;
> -		if (!p) {
> -			*pages =3D p =3D get_pages_array(n);
> -			if (!p)
> -				return -ENOMEM;
> -		}
>  		for (int k =3D 0; k < n; k++)
>  			get_page(*p++ =3D page++);
>  		return min_t(size_t, maxsize, n * PAGE_SIZE - *start);

Reviewed-by: Jeff Layton <jlayton@kernel.org>
