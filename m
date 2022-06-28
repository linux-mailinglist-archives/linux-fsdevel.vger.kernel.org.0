Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7F955CDCC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344276AbiF1Ll5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 07:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344267AbiF1Ll4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:41:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15FB2E0BE
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 04:41:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C27861AD2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 11:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7D6C3411D;
        Tue, 28 Jun 2022 11:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656416514;
        bh=1mnkMgp/rc5QET6ccBgQU57EF5F42ZWZpDSf4eofuWY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=F2F8329VSF5YilfdUuT4/jS5H59OB6HZgasSX0A1tJrPPNAFUnQncxu8SBEQ1DcbP
         TsfkF8rOxko9TfVfvSMoAO9hnDqJ+iI3d7/LYN3hE2TWEgcsMMsU8T9XOS/wo0n91i
         SXC3ey239Zx1mVkrERYDTaFEEMw/BuNk5IOvynfwRa7lNfOLo/AJnIQHH9tDaYOENl
         D8CHzmaULXhN8sQlIX+Y8hnz1eNytLt4lnUT3/dWYJw/o/pHGyOEcNhBBpkl/6sl1N
         2EzwgCMIP/33cJw6+KtZM2rSzhO/dgbGeH2bx79/vNmI4JkNZjxtw5eOI84GgfTXGI
         8vKC44fIftPEQ==
Message-ID: <e35986c71e058e2840247f8d49aff8f2ed952f32.camel@kernel.org>
Subject: Re: [PATCH 23/44] iov_iter_get_pages{,_alloc}(): cap the maxsize
 with MAX_RW_COUNT
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Date:   Tue, 28 Jun 2022 07:41:52 -0400
In-Reply-To: <20220622041552.737754-23-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
         <20220622041552.737754-1-viro@zeniv.linux.org.uk>
         <20220622041552.737754-23-viro@zeniv.linux.org.uk>
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
> All callers can and should handle iov_iter_get_pages() returning
> fewer pages than requested.  All in-kernel ones do.  And it makes
> the arithmetical overflow analysis much simpler...
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  lib/iov_iter.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 30f4158382d6..c3fb7853dbe8 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1367,6 +1367,8 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
>  		maxsize =3D i->count;
>  	if (!maxsize)
>  		return 0;
> +	if (maxsize > MAX_RW_COUNT)
> +		maxsize =3D MAX_RW_COUNT;
> =20
>  	if (likely(user_backed_iter(i))) {
>  		unsigned int gup_flags =3D 0;
> @@ -1485,6 +1487,8 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i=
,
>  		maxsize =3D i->count;
>  	if (!maxsize)
>  		return 0;
> +	if (maxsize > MAX_RW_COUNT)
> +		maxsize =3D MAX_RW_COUNT;
> =20
>  	if (likely(user_backed_iter(i))) {
>  		unsigned int gup_flags =3D 0;


Reviewed-by: Jeff Layton <jlayton@kernel.org>
