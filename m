Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B62655C6AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 14:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240392AbiF0SsR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jun 2022 14:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240316AbiF0SsQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jun 2022 14:48:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76043EB2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jun 2022 11:48:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 386F3B81A5B
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jun 2022 18:48:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F9EC3411D;
        Mon, 27 Jun 2022 18:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656355692;
        bh=E0EKTTs4HBCI9RL22c7UyvIoxu6h5cB99hZiuojcxSE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=eXz9C9dil/zPDqEoovzTu7tzvG4Kv8jygRUvEjqd/NTv/9BgET4wBx+Es7avoBAKD
         ZsfYiBcPddUZLc4tKnpgBG7mDBxjcN7nCOhDr9E5MByiU3aatKFpOKQ6taW37DzeXZ
         ZHqRMx8CMkomYVCXkCzd1FFGjF2Ah3H64IMf9hrjnTQn0t6P8rpQ3PfcFWbGce4SE0
         jBoZJOhAasI6P0S6zYTHRV+xQvz49fqbLbsUCwaVPN63aEUaGio2VfJVlmWzcaGJJy
         AgRi+i2FahiFgZeq6GGPd2fOVlyfWdX2OcfYYKJq4Q8EUrom66kdsArgr5GU5LqvHe
         Ac+lzC4af9GHQ==
Message-ID: <3e6bf5d5dc7c4c7587787e5b13086e2cb38abbaa.camel@kernel.org>
Subject: Re: [PATCH 11/44] iov_iter_bvec_advance(): don't bother with
 bvec_iter
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Date:   Mon, 27 Jun 2022 14:48:10 -0400
In-Reply-To: <20220622041552.737754-11-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
         <20220622041552.737754-1-viro@zeniv.linux.org.uk>
         <20220622041552.737754-11-viro@zeniv.linux.org.uk>
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
> do what we do for iovec/kvec; that ends up generating better code,
> AFAICS.
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  lib/iov_iter.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>=20
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 8275b28e886b..93ceb13ec7b5 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -870,17 +870,22 @@ static void pipe_advance(struct iov_iter *i, size_t=
 size)
> =20
>  static void iov_iter_bvec_advance(struct iov_iter *i, size_t size)
>  {
> -	struct bvec_iter bi;
> +	const struct bio_vec *bvec, *end;
> =20
> -	bi.bi_size =3D i->count;
> -	bi.bi_bvec_done =3D i->iov_offset;
> -	bi.bi_idx =3D 0;
> -	bvec_iter_advance(i->bvec, &bi, size);
> +	if (!i->count)
> +		return;
> +	i->count -=3D size;
> +
> +	size +=3D i->iov_offset;
> =20
> -	i->bvec +=3D bi.bi_idx;
> -	i->nr_segs -=3D bi.bi_idx;
> -	i->count =3D bi.bi_size;
> -	i->iov_offset =3D bi.bi_bvec_done;
> +	for (bvec =3D i->bvec, end =3D bvec + i->nr_segs; bvec < end; bvec++) {
> +		if (likely(size < bvec->bv_len))
> +			break;
> +		size -=3D bvec->bv_len;
> +	}
> +	i->iov_offset =3D size;
> +	i->nr_segs -=3D bvec - i->bvec;
> +	i->bvec =3D bvec;
>  }
> =20
>  static void iov_iter_iovec_advance(struct iov_iter *i, size_t size)

Much simpler to follow, IMO...

Reviewed-by: Jeff Layton <jlayton@kernel.org>
