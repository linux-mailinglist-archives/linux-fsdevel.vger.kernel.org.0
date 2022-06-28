Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C9955C557
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 14:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344706AbiF1Ly3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 07:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343940AbiF1Ly0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:54:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A3B3120F
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 04:54:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07A7D60C52
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 11:54:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F52EC3411D;
        Tue, 28 Jun 2022 11:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656417265;
        bh=1Q4++zpLkRFe/UIhP6KJ0fKCw4wahMqTAY4KpRGuu/8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fzaCgTyIZOsWpgFfJLp7JznhfOu/ui8TGTNJmwyk39QY2M4Ll3XSpDoHlKX8Rb/zI
         sPJLmKhuJHAv4Nm670/rYv8MX8Ywq7pc0iANz7jbspia4ipVf/b1Kt5LXcyMtCIRNX
         fLPdKCAgeY04+ZLMcuZpCAnUEy9yR686eTNhzuaS5btCl24p19Sy7e2OYmpCfmCLvs
         HUbAwUGt5aFi+jps9aspYlRgHzaQiw2AbYfRZs/yUrNqcAIQ2i24om2pf3pfQ3fPAG
         eLP+n3dFhqveHSPJKLmKLqXuhpQmwd5Y3UME/n6oWXPGl/mzSr/ksWblBOQ5n8SFYP
         g3U2uZfYblJog==
Message-ID: <c1929e9b6dbdc07fc8929848c658ef3f2424e395.camel@kernel.org>
Subject: Re: [PATCH 29/44] ITER_XARRAY: don't open-code DIV_ROUND_UP()
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Date:   Tue, 28 Jun 2022 07:54:23 -0400
In-Reply-To: <20220622041552.737754-29-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
         <20220622041552.737754-1-viro@zeniv.linux.org.uk>
         <20220622041552.737754-29-viro@zeniv.linux.org.uk>
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
>  lib/iov_iter.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>=20
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 811fa09515d8..92a566f839f9 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1289,15 +1289,7 @@ static ssize_t iter_xarray_get_pages(struct iov_it=
er *i,
>  	offset =3D pos & ~PAGE_MASK;
>  	*_start_offset =3D offset;
> =20
> -	count =3D 1;
> -	if (size > PAGE_SIZE - offset) {
> -		size -=3D PAGE_SIZE - offset;
> -		count +=3D size >> PAGE_SHIFT;
> -		size &=3D ~PAGE_MASK;
> -		if (size)
> -			count++;
> -	}
> -
> +	count =3D DIV_ROUND_UP(size + offset, PAGE_SIZE);
>  	if (count > maxpages)
>  		count =3D maxpages;
> =20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
