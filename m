Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0C255D69D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345615AbiF1MXo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 08:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345614AbiF1MXl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:23:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A115D1263C
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 05:23:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67DD6B81E05
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 12:23:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517B6C341CE;
        Tue, 28 Jun 2022 12:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656419018;
        bh=s8JbY3JiANq6WjI6O3CBK8TMALqNkZ1pF1pThuDhWx0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=gXzQSKB6p8zq6jHgyrtu0i/OdamO5/gl3m7HTqkBii3AYD5RbTKCJAXp4bSL/YQBb
         6m9nXpkMQvjmvdNoMKhNQllp2pU/aSAAmrmKBf2V6WZcWF+N722LdulebRvCvvrAFY
         7U3YZ86PZTIN/Ix70qTKosYQbzsMj3K8s3Lp6Y2HD8btSMczLY4j6snN8voT2JWe+4
         OEh2/fzJBCCfYLEED27ea+EYCJxy18TIB5XoHs1bLM35tDSzVusHulvchNI4w3AP7O
         /k7n+SH+B62mBh+lEn8QzAdBMlPYPEi0u6TsJ6INQphn5Pju9+agK5kwZMdpfrAzbX
         T0LosElaCIYoQ==
Message-ID: <4dc08a36c01d8fc09e598413877fe2fc61551cf4.camel@kernel.org>
Subject: Re: [PATCH 43/44] pipe_get_pages(): switch to append_pipe()
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Date:   Tue, 28 Jun 2022 08:23:36 -0400
In-Reply-To: <20220622041552.737754-43-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
         <20220622041552.737754-1-viro@zeniv.linux.org.uk>
         <20220622041552.737754-43-viro@zeniv.linux.org.uk>
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
> now that we are advancing the iterator, there's no need to
> treat the first page separately - just call append_pipe()
> in a loop.
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  lib/iov_iter.c | 36 ++++++++----------------------------
>  1 file changed, 8 insertions(+), 28 deletions(-)
>=20
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 70736b3e07c5..a8045c97b975 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1207,10 +1207,10 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
>  		   struct page ***pages, size_t maxsize, unsigned maxpages,
>  		   size_t *start)
>  {
> -	struct pipe_inode_info *pipe =3D i->pipe;
> -	unsigned int npages, off, count;
> +	unsigned int npages, count;
>  	struct page **p;
>  	ssize_t left;
> +	size_t off;
> =20
>  	if (!sanity(i))
>  		return -EFAULT;
> @@ -1222,38 +1222,18 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
>  	if (!count)
>  		return -ENOMEM;
>  	p =3D *pages;
> -	left =3D maxsize;
> -	npages =3D 0;
> -	if (off) {
> -		struct pipe_buffer *buf =3D pipe_buf(pipe, pipe->head - 1);
> -
> -		get_page(*p++ =3D buf->page);
> -		left -=3D PAGE_SIZE - off;
> -		if (left <=3D 0) {
> -			buf->len +=3D maxsize;
> -			iov_iter_advance(i, maxsize);
> -			return maxsize;
> -		}
> -		buf->len =3D PAGE_SIZE;
> -		npages =3D 1;
> -	}
> -	for ( ; npages < count; npages++) {
> -		struct page *page;
> -		unsigned int size =3D min_t(ssize_t, left, PAGE_SIZE);
> -
> -		if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
> -			break;
> -		page =3D push_anon(pipe, size);
> +	for (npages =3D 0, left =3D maxsize ; npages < count; npages++) {
> +		struct page *page =3D append_pipe(i, left, &off);
>  		if (!page)
>  			break;
>  		get_page(*p++ =3D page);
> -		left -=3D size;
> +		if (left <=3D PAGE_SIZE - off)
> +			return maxsize;
> +		left -=3D PAGE_SIZE - off;
>  	}
>  	if (!npages)
>  		return -EFAULT;
> -	maxsize -=3D left;
> -	iov_iter_advance(i, maxsize);
> -	return maxsize;
> +	return maxsize - left;
>  }
> =20
>  static ssize_t iter_xarray_populate_pages(struct page **pages, struct xa=
rray *xa,

Reviewed-by: Jeff Layton <jlayton@kernel.org>
