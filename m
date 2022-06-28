Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5508A55D91E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345383AbiF1MQk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 08:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345407AbiF1MQj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:16:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AE925C7A
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 05:16:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61F6B6116A
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 12:16:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D64C341CD;
        Tue, 28 Jun 2022 12:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656418597;
        bh=lhgIrqK4S3VXO4TRgYn+80Xr6QMfm3SipDieKo0f3Z4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BekQ8XLulNL95BrMUTLNyDGNEih/crPM63Rr0DTeZ7nRe2dOlbhgFHUlOoolck+T+
         SBjvqc+hXD/bihFPSg1mER1MWPRYS0G/x3RHA2PgKnUnSt8Y3TfiodoZO6SYb6YzBo
         2CddEN1YVhkz3ioTsFHUNKhg0Puvo4c5QYG+lJNiIkxENICFcHRrgox1Y9FDnnqGq4
         HNvp95Zq7LbgHpHdFDoJFc3lU4+B3iQ1R4YfSjmk57aPD39kiSTvaDwObokIsEqZs9
         VMUA7cZyJ0mSQSbdm0i5WixvkxYAxPR9NA38a6EYQhoXQr5hH9cwx0ZHwJ900YcF1I
         5fNO/Bl6oMXaw==
Message-ID: <05afca3b521ee492f9f9d30751f622c1c1c15746.camel@kernel.org>
Subject: Re: [PATCH 37/44] block: convert to advancing variants of
 iov_iter_get_pages{,_alloc}()
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Date:   Tue, 28 Jun 2022 08:16:35 -0400
In-Reply-To: <20220622041552.737754-37-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
         <20220622041552.737754-1-viro@zeniv.linux.org.uk>
         <20220622041552.737754-37-viro@zeniv.linux.org.uk>
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
> ... doing revert if we end up not using some pages
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  block/bio.c     | 15 ++++++---------
>  block/blk-map.c |  7 ++++---
>  2 files changed, 10 insertions(+), 12 deletions(-)
>=20
> diff --git a/block/bio.c b/block/bio.c
> index 51c99f2c5c90..01ab683e67be 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1190,7 +1190,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio=
, struct iov_iter *iter)
>  	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
>  	pages +=3D entries_left * (PAGE_PTRS_PER_BVEC - 1);
> =20
> -	size =3D iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
> +	size =3D iov_iter_get_pages2(iter, pages, LONG_MAX, nr_pages, &offset);
>  	if (unlikely(size <=3D 0))
>  		return size ? size : -EFAULT;
> =20
> @@ -1205,6 +1205,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio=
, struct iov_iter *iter)
>  		} else {
>  			if (WARN_ON_ONCE(bio_full(bio, len))) {
>  				bio_put_pages(pages + i, left, offset);
> +				iov_iter_revert(iter, left);
>  				return -EINVAL;
>  			}
>  			__bio_add_page(bio, page, len, offset);
> @@ -1212,7 +1213,6 @@ static int __bio_iov_iter_get_pages(struct bio *bio=
, struct iov_iter *iter)
>  		offset =3D 0;
>  	}
> =20
> -	iov_iter_advance(iter, size);
>  	return 0;
>  }
> =20
> @@ -1227,7 +1227,6 @@ static int __bio_iov_append_get_pages(struct bio *b=
io, struct iov_iter *iter)
>  	ssize_t size, left;
>  	unsigned len, i;
>  	size_t offset;
> -	int ret =3D 0;
> =20
>  	if (WARN_ON_ONCE(!max_append_sectors))
>  		return 0;
> @@ -1240,7 +1239,7 @@ static int __bio_iov_append_get_pages(struct bio *b=
io, struct iov_iter *iter)
>  	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
>  	pages +=3D entries_left * (PAGE_PTRS_PER_BVEC - 1);
> =20
> -	size =3D iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
> +	size =3D iov_iter_get_pages2(iter, pages, LONG_MAX, nr_pages, &offset);
>  	if (unlikely(size <=3D 0))
>  		return size ? size : -EFAULT;
> =20
> @@ -1252,16 +1251,14 @@ static int __bio_iov_append_get_pages(struct bio =
*bio, struct iov_iter *iter)
>  		if (bio_add_hw_page(q, bio, page, len, offset,
>  				max_append_sectors, &same_page) !=3D len) {
>  			bio_put_pages(pages + i, left, offset);
> -			ret =3D -EINVAL;
> -			break;
> +			iov_iter_revert(iter, left);
> +			return -EINVAL;
>  		}
>  		if (same_page)
>  			put_page(page);
>  		offset =3D 0;
>  	}
> -
> -	iov_iter_advance(iter, size - left);
> -	return ret;
> +	return 0;
>  }
> =20
>  /**
> diff --git a/block/blk-map.c b/block/blk-map.c
> index df8b066cd548..7196a6b64c80 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -254,7 +254,7 @@ static int bio_map_user_iov(struct request *rq, struc=
t iov_iter *iter,
>  		size_t offs, added =3D 0;
>  		int npages;
> =20
> -		bytes =3D iov_iter_get_pages_alloc(iter, &pages, LONG_MAX, &offs);
> +		bytes =3D iov_iter_get_pages_alloc2(iter, &pages, LONG_MAX, &offs);
>  		if (unlikely(bytes <=3D 0)) {
>  			ret =3D bytes ? bytes : -EFAULT;
>  			goto out_unmap;
> @@ -284,7 +284,6 @@ static int bio_map_user_iov(struct request *rq, struc=
t iov_iter *iter,
>  				bytes -=3D n;
>  				offs =3D 0;
>  			}
> -			iov_iter_advance(iter, added);
>  		}
>  		/*
>  		 * release the pages we didn't map into the bio, if any
> @@ -293,8 +292,10 @@ static int bio_map_user_iov(struct request *rq, stru=
ct iov_iter *iter,
>  			put_page(pages[j++]);
>  		kvfree(pages);
>  		/* couldn't stuff something into bio? */
> -		if (bytes)
> +		if (bytes) {
> +			iov_iter_revert(iter, bytes);
>  			break;
> +		}
>  	}
> =20
>  	ret =3D blk_rq_append_bio(rq, bio);

Reviewed-by: Jeff Layton <jlayton@kernel.org>
