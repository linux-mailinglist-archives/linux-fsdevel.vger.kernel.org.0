Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2878855C4DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 14:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbiF0Sk0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jun 2022 14:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240209AbiF0Sgb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jun 2022 14:36:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A964E18E18
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jun 2022 11:31:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F35561311
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jun 2022 18:31:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D8DC3411D;
        Mon, 27 Jun 2022 18:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656354706;
        bh=rBI342hwevrERNk1h8wuHgD8tV64txxYKKgCaO+4cqI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BLSEG6YjRvrMWXffrg2Atjg0OoL8YkpebnnF5gCkIrbrjCjA+mTCk22ALat008lEn
         yEukSyJaZ4om69h+BUnIKwR/yIvp4dNSvL71/lWpV+DNOyvlXxIMqGiK1f1Hzxdg+Y
         qng7KSAkzpCLm7zNulXLDJViso80qh0xnPyOBKx8B9RnuccovqNsWEobnG0XutuUgy
         E6fmyFg+Inylq5uZLlQEsoCf/vPw00sTDkHgrdIE8hwAXG0Y29ZLD3VeIO7cD6OrTk
         uKcF1Vf3e8Hi6Q1OMba2gs/xKN7ltaX0gzKEKzAFw2DfCJgZ4KhPB6QkED/wumLhlK
         rc/8nWIPODc3g==
Message-ID: <e46a19732c6da589ee4efe14e37429f1a30b6f9a.camel@kernel.org>
Subject: Re: [PATCH 08/44] copy_page_{to,from}_iter(): switch iovec variants
 to generic
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Date:   Mon, 27 Jun 2022 14:31:44 -0400
In-Reply-To: <20220622041552.737754-8-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
         <20220622041552.737754-1-viro@zeniv.linux.org.uk>
         <20220622041552.737754-8-viro@zeniv.linux.org.uk>
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
> we can do copyin/copyout under kmap_local_page(); it shouldn't overflow
> the kmap stack - the maximal footprint increase only by one here.
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  lib/iov_iter.c | 191 ++-----------------------------------------------
>  1 file changed, 4 insertions(+), 187 deletions(-)
>=20
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 6dd5330f7a99..4c658a25e29c 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -168,174 +168,6 @@ static int copyin(void *to, const void __user *from=
, size_t n)
>  	return n;
>  }
> =20
> -static size_t copy_page_to_iter_iovec(struct page *page, size_t offset, =
size_t bytes,
> -			 struct iov_iter *i)
> -{
> -	size_t skip, copy, left, wanted;
> -	const struct iovec *iov;
> -	char __user *buf;
> -	void *kaddr, *from;
> -
> -	if (unlikely(bytes > i->count))
> -		bytes =3D i->count;
> -
> -	if (unlikely(!bytes))
> -		return 0;
> -
> -	might_fault();
> -	wanted =3D bytes;
> -	iov =3D i->iov;
> -	skip =3D i->iov_offset;
> -	buf =3D iov->iov_base + skip;
> -	copy =3D min(bytes, iov->iov_len - skip);
> -
> -	if (IS_ENABLED(CONFIG_HIGHMEM) && !fault_in_writeable(buf, copy)) {
> -		kaddr =3D kmap_atomic(page);
> -		from =3D kaddr + offset;
> -
> -		/* first chunk, usually the only one */
> -		left =3D copyout(buf, from, copy);
> -		copy -=3D left;
> -		skip +=3D copy;
> -		from +=3D copy;
> -		bytes -=3D copy;
> -
> -		while (unlikely(!left && bytes)) {
> -			iov++;
> -			buf =3D iov->iov_base;
> -			copy =3D min(bytes, iov->iov_len);
> -			left =3D copyout(buf, from, copy);
> -			copy -=3D left;
> -			skip =3D copy;
> -			from +=3D copy;
> -			bytes -=3D copy;
> -		}
> -		if (likely(!bytes)) {
> -			kunmap_atomic(kaddr);
> -			goto done;
> -		}
> -		offset =3D from - kaddr;
> -		buf +=3D copy;
> -		kunmap_atomic(kaddr);
> -		copy =3D min(bytes, iov->iov_len - skip);
> -	}
> -	/* Too bad - revert to non-atomic kmap */
> -
> -	kaddr =3D kmap(page);
> -	from =3D kaddr + offset;
> -	left =3D copyout(buf, from, copy);
> -	copy -=3D left;
> -	skip +=3D copy;
> -	from +=3D copy;
> -	bytes -=3D copy;
> -	while (unlikely(!left && bytes)) {
> -		iov++;
> -		buf =3D iov->iov_base;
> -		copy =3D min(bytes, iov->iov_len);
> -		left =3D copyout(buf, from, copy);
> -		copy -=3D left;
> -		skip =3D copy;
> -		from +=3D copy;
> -		bytes -=3D copy;
> -	}
> -	kunmap(page);
> -
> -done:
> -	if (skip =3D=3D iov->iov_len) {
> -		iov++;
> -		skip =3D 0;
> -	}
> -	i->count -=3D wanted - bytes;
> -	i->nr_segs -=3D iov - i->iov;
> -	i->iov =3D iov;
> -	i->iov_offset =3D skip;
> -	return wanted - bytes;
> -}
> -
> -static size_t copy_page_from_iter_iovec(struct page *page, size_t offset=
, size_t bytes,
> -			 struct iov_iter *i)
> -{
> -	size_t skip, copy, left, wanted;
> -	const struct iovec *iov;
> -	char __user *buf;
> -	void *kaddr, *to;
> -
> -	if (unlikely(bytes > i->count))
> -		bytes =3D i->count;
> -
> -	if (unlikely(!bytes))
> -		return 0;
> -
> -	might_fault();
> -	wanted =3D bytes;
> -	iov =3D i->iov;
> -	skip =3D i->iov_offset;
> -	buf =3D iov->iov_base + skip;
> -	copy =3D min(bytes, iov->iov_len - skip);
> -
> -	if (IS_ENABLED(CONFIG_HIGHMEM) && !fault_in_readable(buf, copy)) {
> -		kaddr =3D kmap_atomic(page);
> -		to =3D kaddr + offset;
> -
> -		/* first chunk, usually the only one */
> -		left =3D copyin(to, buf, copy);
> -		copy -=3D left;
> -		skip +=3D copy;
> -		to +=3D copy;
> -		bytes -=3D copy;
> -
> -		while (unlikely(!left && bytes)) {
> -			iov++;
> -			buf =3D iov->iov_base;
> -			copy =3D min(bytes, iov->iov_len);
> -			left =3D copyin(to, buf, copy);
> -			copy -=3D left;
> -			skip =3D copy;
> -			to +=3D copy;
> -			bytes -=3D copy;
> -		}
> -		if (likely(!bytes)) {
> -			kunmap_atomic(kaddr);
> -			goto done;
> -		}
> -		offset =3D to - kaddr;
> -		buf +=3D copy;
> -		kunmap_atomic(kaddr);
> -		copy =3D min(bytes, iov->iov_len - skip);
> -	}
> -	/* Too bad - revert to non-atomic kmap */
> -
> -	kaddr =3D kmap(page);
> -	to =3D kaddr + offset;
> -	left =3D copyin(to, buf, copy);
> -	copy -=3D left;
> -	skip +=3D copy;
> -	to +=3D copy;
> -	bytes -=3D copy;
> -	while (unlikely(!left && bytes)) {
> -		iov++;
> -		buf =3D iov->iov_base;
> -		copy =3D min(bytes, iov->iov_len);
> -		left =3D copyin(to, buf, copy);
> -		copy -=3D left;
> -		skip =3D copy;
> -		to +=3D copy;
> -		bytes -=3D copy;
> -	}
> -	kunmap(page);
> -
> -done:
> -	if (skip =3D=3D iov->iov_len) {
> -		iov++;
> -		skip =3D 0;
> -	}
> -	i->count -=3D wanted - bytes;
> -	i->nr_segs -=3D iov - i->iov;
> -	i->iov =3D iov;
> -	i->iov_offset =3D skip;
> -	return wanted - bytes;
> -}
> -
>  #ifdef PIPE_PARANOIA
>  static bool sanity(const struct iov_iter *i)
>  {
> @@ -848,24 +680,14 @@ static inline bool page_copy_sane(struct page *page=
, size_t offset, size_t n)
>  static size_t __copy_page_to_iter(struct page *page, size_t offset, size=
_t bytes,
>  			 struct iov_iter *i)
>  {
> -	if (likely(iter_is_iovec(i)))
> -		return copy_page_to_iter_iovec(page, offset, bytes, i);
> -	if (iov_iter_is_bvec(i) || iov_iter_is_kvec(i) || iov_iter_is_xarray(i)=
) {
> +	if (unlikely(iov_iter_is_pipe(i))) {
> +		return copy_page_to_iter_pipe(page, offset, bytes, i);
> +	} else {
>  		void *kaddr =3D kmap_local_page(page);
>  		size_t wanted =3D _copy_to_iter(kaddr + offset, bytes, i);
>  		kunmap_local(kaddr);
>  		return wanted;
>  	}
> -	if (iov_iter_is_pipe(i))
> -		return copy_page_to_iter_pipe(page, offset, bytes, i);
> -	if (unlikely(iov_iter_is_discard(i))) {
> -		if (unlikely(i->count < bytes))
> -			bytes =3D i->count;
> -		i->count -=3D bytes;
> -		return bytes;
> -	}
> -	WARN_ON(1);
> -	return 0;
>  }
> =20
>  size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
> @@ -896,17 +718,12 @@ EXPORT_SYMBOL(copy_page_to_iter);
>  size_t copy_page_from_iter(struct page *page, size_t offset, size_t byte=
s,
>  			 struct iov_iter *i)
>  {
> -	if (unlikely(!page_copy_sane(page, offset, bytes)))
> -		return 0;
> -	if (likely(iter_is_iovec(i)))
> -		return copy_page_from_iter_iovec(page, offset, bytes, i);
> -	if (iov_iter_is_bvec(i) || iov_iter_is_kvec(i) || iov_iter_is_xarray(i)=
) {
> +	if (page_copy_sane(page, offset, bytes)) {
>  		void *kaddr =3D kmap_local_page(page);
>  		size_t wanted =3D _copy_from_iter(kaddr + offset, bytes, i);
>  		kunmap_local(kaddr);
>  		return wanted;
>  	}
> -	WARN_ON(1);
>  	return 0;
>  }
>  EXPORT_SYMBOL(copy_page_from_iter);

Love it.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
