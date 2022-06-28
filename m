Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399FD55DFF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345567AbiF1MSG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 08:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345486AbiF1MSF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:18:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D68CDA4
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 05:18:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 395DD60FE3
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 12:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B848CC3411D;
        Tue, 28 Jun 2022 12:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656418683;
        bh=E22kElzzTi7SU4N6Uu/FwOHA+7JgvENzgDCAC3snu4o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NZN5yd+S/RAq15xAK149Kob/DgG9QVbx1q+M3XK9RJHjmaQiZumSJZJccD5WtCrm5
         vC18YluZup9ZLbzmQYm9Ruel7eJJ/Aq4O2OgYmExgjNhdF+hhXK2C1PtdS+CEx7mxf
         b5XKbyHF6xgIwImSQGp77LgwFXEjzIUa2XKrjCx3QBZrWnuQq7JsaYwWpETZUROFAF
         kRF1jruSBY1Hb+5gGeWIjmGcYT6BpWOtx21G7KQsXa4vT/bIStZ2NeUiWREzLWUA4J
         d/Qmt022qfPfvS+z7ARmRDu73uKHkdKxKBrBGgW1XN/XDliV5S98x+3in0pRHYgNgi
         VKFvCBMnW4e5w==
Message-ID: <db21875791433ed37cedc116123b1ded636fe61f.camel@kernel.org>
Subject: Re: [PATCH 38/44] iter_to_pipe(): switch to advancing variant of
 iov_iter_get_pages()
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Date:   Tue, 28 Jun 2022 08:18:01 -0400
In-Reply-To: <20220622041552.737754-38-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
         <20220622041552.737754-1-viro@zeniv.linux.org.uk>
         <20220622041552.737754-38-viro@zeniv.linux.org.uk>
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
> ... and untangle the cleanup on failure to add into pipe.
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/splice.c | 47 ++++++++++++++++++++++++-----------------------
>  1 file changed, 24 insertions(+), 23 deletions(-)
>=20
> diff --git a/fs/splice.c b/fs/splice.c
> index 6645b30ec990..9f84bd21f64c 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -1160,39 +1160,40 @@ static int iter_to_pipe(struct iov_iter *from,
>  	};
>  	size_t total =3D 0;
>  	int ret =3D 0;
> -	bool failed =3D false;
> =20
> -	while (iov_iter_count(from) && !failed) {
> +	while (iov_iter_count(from)) {
>  		struct page *pages[16];
> -		ssize_t copied;
> +		ssize_t left;
>  		size_t start;
> -		int n;
> +		int i, n;
> =20
> -		copied =3D iov_iter_get_pages(from, pages, ~0UL, 16, &start);
> -		if (copied <=3D 0) {
> -			ret =3D copied;
> +		left =3D iov_iter_get_pages2(from, pages, ~0UL, 16, &start);
> +		if (left <=3D 0) {
> +			ret =3D left;
>  			break;
>  		}
> =20
> -		for (n =3D 0; copied; n++, start =3D 0) {
> -			int size =3D min_t(int, copied, PAGE_SIZE - start);
> -			if (!failed) {
> -				buf.page =3D pages[n];
> -				buf.offset =3D start;
> -				buf.len =3D size;
> -				ret =3D add_to_pipe(pipe, &buf);
> -				if (unlikely(ret < 0)) {
> -					failed =3D true;
> -				} else {
> -					iov_iter_advance(from, ret);
> -					total +=3D ret;
> -				}
> -			} else {
> -				put_page(pages[n]);
> +		n =3D DIV_ROUND_UP(left + start, PAGE_SIZE);
> +		for (i =3D 0; i < n; i++) {
> +			int size =3D min_t(int, left, PAGE_SIZE - start);
> +
> +			buf.page =3D pages[i];
> +			buf.offset =3D start;
> +			buf.len =3D size;
> +			ret =3D add_to_pipe(pipe, &buf);
> +			if (unlikely(ret < 0)) {
> +				iov_iter_revert(from, left);
> +				// this one got dropped by add_to_pipe()
> +				while (++i < n)
> +					put_page(pages[i]);
> +				goto out;
>  			}
> -			copied -=3D size;
> +			total +=3D ret;
> +			left -=3D size;
> +			start =3D 0;
>  		}
>  	}
> +out:
>  	return total ? total : ret;
>  }
> =20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
