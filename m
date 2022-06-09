Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81760545297
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 19:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344602AbiFIRFJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 13:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237847AbiFIRFI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:05:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E696B0D0E;
        Thu,  9 Jun 2022 10:05:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFB486198A;
        Thu,  9 Jun 2022 17:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7CFC34114;
        Thu,  9 Jun 2022 17:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654794306;
        bh=TyXSDd71ITvKQbVh8Cn4dAI1JmsPDXjiP1sZFC/KfUM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rhg3JZaXznf78tW/tdEvAZeK/jwmr6IJEVpWLJd1VzkAPNn8y6eM+SNyfgZyDXy6e
         lzNm1gVEVN6ZxDQI0KQgBKkvEzQ+MruELC+MDfMaYKEPkGtGnbNol3EH4cG6y7wszl
         RSNzsHsZGrDFkVBcL2W3CtahOkx0VPF8D5bRAHWyKUNBAnwvCdaHOOoRWWBPCZ/LB0
         EdTtz6w1OAan7q0dkZFoSIYs5zY7KpT60WZA/RwiE64PBTEnog/9i09qZAd8i/ZqaL
         lUBjad8+Mef5m3Dvqhc486tjVH/i4T9OHs7pJmqLnpyFS54OL7mg+W6iz0arPzr7AY
         /TBgqR61XVDlQ==
Message-ID: <480f3b02d2cda67cb2a1b68e88afa03e95809b8c.camel@kernel.org>
Subject: Re: [PATCH] iov_iter: Fix iter_xarray_get_pages{,_alloc}()
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Gao Xiang <xiang@kernel.org>, linux-afs@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net, devel@lists.orangefs.org,
        linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 09 Jun 2022 13:05:03 -0400
In-Reply-To: <165476202136.3999992.433442175457370240.stgit@warthog.procyon.org.uk>
References: <165476202136.3999992.433442175457370240.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2022-06-09 at 09:07 +0100, David Howells wrote:
> The maths at the end of iter_xarray_get_pages() to calculate the actual
> size doesn't work under some circumstances, such as when it's been asked =
to
> extract a partial single page.  Various terms of the equation cancel out
> and you end up with actual =3D=3D offset.  The same issue exists in
> iter_xarray_get_pages_alloc().
>=20
> Fix these to just use min() to select the lesser amount from between the
> amount of page content transcribed into the buffer, minus the offset, and
> the size limit specified.
>=20
> This doesn't appear to have caused a problem yet upstream because network
> filesystems aren't getting the pages from an xarray iterator, but rather
> passing it directly to the socket, which just iterates over it.  Cachefil=
es
> *does* do DIO from one to/from ext4/xfs/btrfs/etc. but it always asks for
> whole pages to be written or read.
>=20
> Fixes: 7ff5062079ef ("iov_iter: Add ITER_XARRAY")
> Reported-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Alexander Viro <viro@zeniv.linux.org.uk>
> cc: Dominique Martinet <asmadeus@codewreck.org>
> cc: Mike Marshall <hubcap@omnibond.com>
> cc: Gao Xiang <xiang@kernel.org>
> cc: linux-afs@lists.infradead.org
> cc: v9fs-developer@lists.sourceforge.net
> cc: devel@lists.orangefs.org
> cc: linux-erofs@lists.ozlabs.org
> cc: linux-cachefs@redhat.com
> cc: linux-fsdevel@vger.kernel.org
> ---
>=20
>  lib/iov_iter.c |   20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
>=20
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 834e1e268eb6..814f65fd0c42 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1434,7 +1434,7 @@ static ssize_t iter_xarray_get_pages(struct iov_ite=
r *i,
>  {
>  	unsigned nr, offset;
>  	pgoff_t index, count;
> -	size_t size =3D maxsize, actual;
> +	size_t size =3D maxsize;
>  	loff_t pos;
> =20
>  	if (!size || !maxpages)
> @@ -1461,13 +1461,7 @@ static ssize_t iter_xarray_get_pages(struct iov_it=
er *i,
>  	if (nr =3D=3D 0)
>  		return 0;
> =20
> -	actual =3D PAGE_SIZE * nr;
> -	actual -=3D offset;
> -	if (nr =3D=3D count && size > 0) {
> -		unsigned last_offset =3D (nr > 1) ? 0 : offset;
> -		actual -=3D PAGE_SIZE - (last_offset + size);
> -	}
> -	return actual;
> +	return min(nr * PAGE_SIZE - offset, maxsize);
>  }
> =20
>  /* must be done on non-empty ITER_IOVEC one */
> @@ -1602,7 +1596,7 @@ static ssize_t iter_xarray_get_pages_alloc(struct i=
ov_iter *i,
>  	struct page **p;
>  	unsigned nr, offset;
>  	pgoff_t index, count;
> -	size_t size =3D maxsize, actual;
> +	size_t size =3D maxsize;
>  	loff_t pos;
> =20
>  	if (!size)
> @@ -1631,13 +1625,7 @@ static ssize_t iter_xarray_get_pages_alloc(struct =
iov_iter *i,
>  	if (nr =3D=3D 0)
>  		return 0;
> =20
> -	actual =3D PAGE_SIZE * nr;
> -	actual -=3D offset;
> -	if (nr =3D=3D count && size > 0) {
> -		unsigned last_offset =3D (nr > 1) ? 0 : offset;
> -		actual -=3D PAGE_SIZE - (last_offset + size);
> -	}
> -	return actual;
> +	return min(nr * PAGE_SIZE - offset, maxsize);
>  }
> =20
>  ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
>=20
>=20

This seems to fix the bug I was hitting. Thanks!

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Jeff Layton <jlayton@kernel.org>
