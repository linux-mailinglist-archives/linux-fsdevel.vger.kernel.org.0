Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734B755D3A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiF1MXT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 08:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345667AbiF1MXP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:23:15 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414F31261B
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 05:23:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AF476CE1FFF
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 12:23:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101D1C341CA;
        Tue, 28 Jun 2022 12:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656418991;
        bh=vV3rOs0nJ1Hncp0+OvrmY7Qaih2OrEBI6Tiohz8l4Tc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=W9otc76k9rtFNWqS5DWTsXKhOvRNPYtB59XZV6nhgqnPYyNjko9XOElsuLo9A1zEw
         x3Y4x5YmfupO/fZE1DEOOG+iiixf7jZj2CjmdEUtWsbKI8XoCxub5yKgXjkynivoYJ
         VKXaHVoMNq95s9AbuL+XFS4qyb6Ij1dm6iZQaRf0bsDaDmEJqdQwO9/Ck1Dnkxyr7x
         TLYXdtM2S83looCotwde/sL5Gdg2uksyf7VIZVbuZHMxlSQmtspeOmM+YbCqtdNxBI
         RAs9yCsmqKnVTwR6FAr+5rTmDBguzraAK/6UiBSLk9XOCqBpxeO7yiFCfr9l74EBAb
         BllCgxoNL5RLQ==
Message-ID: <f67b363f76230f15c4f6b7e66dcce6dfa3b5b184.camel@kernel.org>
Subject: Re: [PATCH 44/44] expand those iov_iter_advance()...
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Date:   Tue, 28 Jun 2022 08:23:08 -0400
In-Reply-To: <20220622041552.737754-44-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
         <20220622041552.737754-1-viro@zeniv.linux.org.uk>
         <20220622041552.737754-44-viro@zeniv.linux.org.uk>
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
>  lib/iov_iter.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index a8045c97b975..79c86add8dea 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1284,7 +1284,8 @@ static ssize_t iter_xarray_get_pages(struct iov_ite=
r *i,
>  		return 0;
> =20
>  	maxsize =3D min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
> -	iov_iter_advance(i, maxsize);
> +	i->iov_offset +=3D maxsize;
> +	i->count -=3D maxsize;
>  	return maxsize;
>  }
> =20
> @@ -1373,7 +1374,13 @@ static ssize_t __iov_iter_get_pages_alloc(struct i=
ov_iter *i,
>  		for (int k =3D 0; k < n; k++)
>  			get_page(p[k] =3D page + k);
>  		maxsize =3D min_t(size_t, maxsize, n * PAGE_SIZE - *start);
> -		iov_iter_advance(i, maxsize);
> +		i->count -=3D maxsize;
> +		i->iov_offset +=3D maxsize;
> +		if (i->iov_offset =3D=3D i->bvec->bv_len) {
> +			i->iov_offset =3D 0;
> +			i->bvec++;
> +			i->nr_segs--;
> +		}
>  		return maxsize;
>  	}
>  	if (iov_iter_is_pipe(i))

Why do this? iov_iter_advance makes it clearer as to what's going on
here.
--=20
Jeff Layton <jlayton@kernel.org>
