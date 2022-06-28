Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0151055D9BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245734AbiF1Lrs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 07:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345359AbiF1Lr0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:47:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82A5240
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 04:47:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 747E5B818E0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 11:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E40FC341CA;
        Tue, 28 Jun 2022 11:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656416835;
        bh=dKzZ/vy7HHvgx95lHEzqYt47FaFP0k+n4+nWn7QZZlU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=adOwIr7067hKNeKFJcoiTocRHJNGaEOqofpqK5jToyY6VCO+PkuBp1vUomCAYqW5s
         Dj20lxK75cnFhOfiBVaEEJd9FnRiaNiT1RsKcz2ASwttMgV238cvMcv2GDNNxDWrR8
         Q/YJrKT7dCrOL0oiZLZN2mqS/n4aNTMAT9r5oqB/cFxLJbH2xUVUg4qejZ83m/jv1V
         SJMIOpbBoLl26Ux29TePzxHxEJkMv6ygHQxb1esoRbGSef/7b9TVh6lt++EAnsevM5
         mYkGulRhSVtgHnBewYX2k0z/JfVEacdGug/WnfTQ7HoHaJCDVmZyZXAJFTSy6z8jaO
         IaX+tfsLjsShA==
Message-ID: <9b5c07c490f67b1fc35d6ec0900dfb161120ccd8.camel@kernel.org>
Subject: Re: [PATCH 25/44] iov_iter_get_pages(): sanity-check arguments
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Date:   Tue, 28 Jun 2022 07:47:12 -0400
In-Reply-To: <20220622041552.737754-25-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
         <20220622041552.737754-1-viro@zeniv.linux.org.uk>
         <20220622041552.737754-25-viro@zeniv.linux.org.uk>
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
> zero maxpages is bogus, but best treated as "just return 0";
> NULL pages, OTOH, should be treated as a hard bug.
>=20
> get rid of now completely useless checks in xarray_get_pages{,_alloc}().
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  lib/iov_iter.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>=20
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 9c25661684c6..5c985cf2858e 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1271,9 +1271,6 @@ static ssize_t iter_xarray_get_pages(struct iov_ite=
r *i,
>  	size_t size =3D maxsize;
>  	loff_t pos;
> =20
> -	if (!size || !maxpages)
> -		return 0;
> -
>  	pos =3D i->xarray_start + i->iov_offset;
>  	index =3D pos >> PAGE_SHIFT;
>  	offset =3D pos & ~PAGE_MASK;
> @@ -1365,10 +1362,11 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
> =20
>  	if (maxsize > i->count)
>  		maxsize =3D i->count;
> -	if (!maxsize)
> +	if (!maxsize || !maxpages)
>  		return 0;
>  	if (maxsize > MAX_RW_COUNT)
>  		maxsize =3D MAX_RW_COUNT;
> +	BUG_ON(!pages);
> =20
>  	if (likely(user_backed_iter(i))) {
>  		unsigned int gup_flags =3D 0;
> @@ -1441,9 +1439,6 @@ static ssize_t iter_xarray_get_pages_alloc(struct i=
ov_iter *i,
>  	size_t size =3D maxsize;
>  	loff_t pos;
> =20
> -	if (!size)
> -		return 0;
> -
>  	pos =3D i->xarray_start + i->iov_offset;
>  	index =3D pos >> PAGE_SHIFT;
>  	offset =3D pos & ~PAGE_MASK;

Reviewed-by: Jeff Layton <jlayton@kernel.org>
