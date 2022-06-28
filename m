Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E99B55E16A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345561AbiF1MSn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 08:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345002AbiF1MSi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:18:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CE72DAA5
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 05:18:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 372FE6116D
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 12:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C926CC3411D;
        Tue, 28 Jun 2022 12:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656418716;
        bh=cjxF86BPYBP3XaC2pbjoFtESrIaSGG7wPRHBJ5aEx2U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VkcscxJJCXkXhRVVkzQL840WSB2sbaCLpAJJWSvnplDY5sgMwsC4pbZ08J/6ipaRl
         ayUtTljv1uqCTTlH+AeexSsvZk/y7FGG9MnBFDu9L0ZW/BWW3cKad893U1ebk0YMqv
         AJQwIKJgEgu1IZTN/+iMlpuvoi51vT/6aOMQhuh1i9q4df4pScu22W5Vy62IICyfUb
         VA9Elwaq4sQqNJj/KXB5JRRpsfS0IDd3hHu9T0GTm73kguunoD39+bIrCGir8KBzxQ
         vhZVoiM0w5yiTtui49UDxDetLVaqrSK3F5H7Ny2/fAc3dSRVY9xyOKRb17++ex1xun
         vqTOQdW9hOfyg==
Message-ID: <3e56d8db8cb9881ee0e545af1ef12d694904ba0f.camel@kernel.org>
Subject: Re: [PATCH 39/44] af_alg_make_sg(): switch to advancing variant of
 iov_iter_get_pages()
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Date:   Tue, 28 Jun 2022 08:18:34 -0400
In-Reply-To: <20220622041552.737754-39-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
         <20220622041552.737754-1-viro@zeniv.linux.org.uk>
         <20220622041552.737754-39-viro@zeniv.linux.org.uk>
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
> ... and adjust the callers
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  crypto/af_alg.c     | 3 +--
>  crypto/algif_hash.c | 5 +++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/crypto/af_alg.c b/crypto/af_alg.c
> index c8289b7a85ba..e893c0f6c879 100644
> --- a/crypto/af_alg.c
> +++ b/crypto/af_alg.c
> @@ -404,7 +404,7 @@ int af_alg_make_sg(struct af_alg_sgl *sgl, struct iov=
_iter *iter, int len)
>  	ssize_t n;
>  	int npages, i;
> =20
> -	n =3D iov_iter_get_pages(iter, sgl->pages, len, ALG_MAX_PAGES, &off);
> +	n =3D iov_iter_get_pages2(iter, sgl->pages, len, ALG_MAX_PAGES, &off);
>  	if (n < 0)
>  		return n;
> =20
> @@ -1191,7 +1191,6 @@ int af_alg_get_rsgl(struct sock *sk, struct msghdr =
*msg, int flags,
>  		len +=3D err;
>  		atomic_add(err, &ctx->rcvused);
>  		rsgl->sg_num_bytes =3D err;
> -		iov_iter_advance(&msg->msg_iter, err);
>  	}
> =20
>  	*outlen =3D len;
> diff --git a/crypto/algif_hash.c b/crypto/algif_hash.c
> index 50f7b22f1b48..1d017ec5c63c 100644
> --- a/crypto/algif_hash.c
> +++ b/crypto/algif_hash.c
> @@ -102,11 +102,12 @@ static int hash_sendmsg(struct socket *sock, struct=
 msghdr *msg,
>  		err =3D crypto_wait_req(crypto_ahash_update(&ctx->req),
>  				      &ctx->wait);
>  		af_alg_free_sg(&ctx->sgl);
> -		if (err)
> +		if (err) {
> +			iov_iter_revert(&msg->msg_iter, len);
>  			goto unlock;
> +		}
> =20
>  		copied +=3D len;
> -		iov_iter_advance(&msg->msg_iter, len);
>  	}
> =20
>  	err =3D 0;

Reviewed-by: Jeff Layton <jlayton@kernel.org>
