Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936BC55E288
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345329AbiF1MVm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 08:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344426AbiF1MVk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:21:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3EE2ED5C
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 05:21:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA22460FFD
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 12:21:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D965C3411D;
        Tue, 28 Jun 2022 12:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656418898;
        bh=uvkyCXs+yv/EPMEo8D+GZIGLyviHVzLkmtpJapcCha8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tSjjjkrtd0N4ZLRauiR/IFFvm9e/Wj7dL0t7xDh7lgjt6I+P6ddRi4OoR2Xg7tYHl
         WyFuFUtzYxFklCHQLZu1WPaZ26N8+bLdE/eZltd4mjNw4EpuevoMJ+BFkFLmZ590kY
         cc1UqxOFU4JZFbxHhlmQSSPMIhwmT5EAcPmZsNy7vBpI4hf0Ka8HDt1FBdd8ejAG1m
         Vdqz4Af+nzEN8v51C3k+GSpXPKTAygvMiHLWc/E7xI3OfRLT2ZuDnjcSus6Gq1wRru
         cGzfknRO+niX6lXT4gY5uD1OT+urwy0rq0ivAElVsE/Fr7m0YvKvtyYQ0M+ixJoahp
         Pewfebze9btUA==
Message-ID: <69fce223f91cafdac3f2341a2068f6f704d24436.camel@kernel.org>
Subject: Re: [PATCH 42/44] get rid of non-advancing variants
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Date:   Tue, 28 Jun 2022 08:21:36 -0400
In-Reply-To: <20220622041552.737754-42-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
         <20220622041552.737754-1-viro@zeniv.linux.org.uk>
         <20220622041552.737754-42-viro@zeniv.linux.org.uk>
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
> mechanical change; will be further massaged in subsequent commits
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  include/linux/uio.h | 24 ++----------------------
>  lib/iov_iter.c      | 27 ++++++++++++++++++---------
>  2 files changed, 20 insertions(+), 31 deletions(-)
>=20
> diff --git a/include/linux/uio.h b/include/linux/uio.h
> index ab1cc218b9de..f2fc55f88e45 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
> @@ -245,9 +245,9 @@ void iov_iter_pipe(struct iov_iter *i, unsigned int d=
irection, struct pipe_inode
>  void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t=
 count);
>  void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct =
xarray *xarray,
>  		     loff_t start, size_t count);
> -ssize_t iov_iter_get_pages(struct iov_iter *i, struct page **pages,
> +ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
>  			size_t maxsize, unsigned maxpages, size_t *start);
> -ssize_t iov_iter_get_pages_alloc(struct iov_iter *i, struct page ***page=
s,
> +ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pag=
es,
>  			size_t maxsize, size_t *start);
>  int iov_iter_npages(const struct iov_iter *i, int maxpages);
>  void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state);
> @@ -349,24 +349,4 @@ static inline void iov_iter_ubuf(struct iov_iter *i,=
 unsigned int direction,
>  	};
>  }
> =20
> -static inline ssize_t iov_iter_get_pages2(struct iov_iter *i, struct pag=
e **pages,
> -			size_t maxsize, unsigned maxpages, size_t *start)
> -{
> -	ssize_t res =3D iov_iter_get_pages(i, pages, maxsize, maxpages, start);
> -
> -	if (res >=3D 0)
> -		iov_iter_advance(i, res);
> -	return res;
> -}
> -
> -static inline ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, stru=
ct page ***pages,
> -			size_t maxsize, size_t *start)
> -{
> -	ssize_t res =3D iov_iter_get_pages_alloc(i, pages, maxsize, start);
> -
> -	if (res >=3D 0)
> -		iov_iter_advance(i, res);
> -	return res;
> -}
> -
>  #endif
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 1c744f0c0b2c..70736b3e07c5 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1231,6 +1231,7 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
>  		left -=3D PAGE_SIZE - off;
>  		if (left <=3D 0) {
>  			buf->len +=3D maxsize;
> +			iov_iter_advance(i, maxsize);
>  			return maxsize;
>  		}
>  		buf->len =3D PAGE_SIZE;
> @@ -1250,7 +1251,9 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
>  	}
>  	if (!npages)
>  		return -EFAULT;
> -	return maxsize - left;
> +	maxsize -=3D left;
> +	iov_iter_advance(i, maxsize);
> +	return maxsize;
>  }
> =20
>  static ssize_t iter_xarray_populate_pages(struct page **pages, struct xa=
rray *xa,
> @@ -1300,7 +1303,9 @@ static ssize_t iter_xarray_get_pages(struct iov_ite=
r *i,
>  	if (nr =3D=3D 0)
>  		return 0;
> =20
> -	return min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
> +	maxsize =3D min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
> +	iov_iter_advance(i, maxsize);
> +	return maxsize;
>  }
> =20
>  /* must be done on non-empty ITER_UBUF or ITER_IOVEC one */
> @@ -1372,7 +1377,9 @@ static ssize_t __iov_iter_get_pages_alloc(struct io=
v_iter *i,
>  		res =3D get_user_pages_fast(addr, n, gup_flags, *pages);
>  		if (unlikely(res <=3D 0))
>  			return res;
> -		return min_t(size_t, maxsize, res * PAGE_SIZE - *start);
> +		maxsize =3D min_t(size_t, maxsize, res * PAGE_SIZE - *start);
> +		iov_iter_advance(i, maxsize);
> +		return maxsize;
>  	}
>  	if (iov_iter_is_bvec(i)) {
>  		struct page **p;
> @@ -1384,8 +1391,10 @@ static ssize_t __iov_iter_get_pages_alloc(struct i=
ov_iter *i,
>  			return -ENOMEM;
>  		p =3D *pages;
>  		for (int k =3D 0; k < n; k++)
> -			get_page(*p++ =3D page++);
> -		return min_t(size_t, maxsize, n * PAGE_SIZE - *start);
> +			get_page(p[k] =3D page + k);
> +		maxsize =3D min_t(size_t, maxsize, n * PAGE_SIZE - *start);
> +		iov_iter_advance(i, maxsize);
> +		return maxsize;
>  	}
>  	if (iov_iter_is_pipe(i))
>  		return pipe_get_pages(i, pages, maxsize, maxpages, start);
> @@ -1395,7 +1404,7 @@ static ssize_t __iov_iter_get_pages_alloc(struct io=
v_iter *i,
>  	return -EFAULT;
>  }
> =20
> -ssize_t iov_iter_get_pages(struct iov_iter *i,
> +ssize_t iov_iter_get_pages2(struct iov_iter *i,
>  		   struct page **pages, size_t maxsize, unsigned maxpages,
>  		   size_t *start)
>  {
> @@ -1405,9 +1414,9 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
> =20
>  	return __iov_iter_get_pages_alloc(i, &pages, maxsize, maxpages, start);
>  }
> -EXPORT_SYMBOL(iov_iter_get_pages);
> +EXPORT_SYMBOL(iov_iter_get_pages2);
> =20
> -ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
> +ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i,
>  		   struct page ***pages, size_t maxsize,
>  		   size_t *start)
>  {
> @@ -1422,7 +1431,7 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i=
,
>  	}
>  	return len;
>  }
> -EXPORT_SYMBOL(iov_iter_get_pages_alloc);
> +EXPORT_SYMBOL(iov_iter_get_pages_alloc2);
> =20
>  size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
>  			       struct iov_iter *i)

Reviewed-by: Jeff Layton <jlayton@kernel.org>
