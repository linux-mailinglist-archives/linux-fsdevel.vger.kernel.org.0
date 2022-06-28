Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7D055C3D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 14:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345202AbiF1Lcv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 07:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344368AbiF1Lct (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:32:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E52C32040
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 04:32:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE7CB6175F
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 11:32:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7822DC3411D;
        Tue, 28 Jun 2022 11:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656415967;
        bh=ZrQZnOTlnUqxEDHgoJOXB5o9pnd4FJ++YW4Bq5p/aAc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rAWe25iTR7wcVoNt32fMes+z5xBMABRtGkybXAfO5CVEFNq8hznzJ2laBZVRseZCu
         SI6zQZXD95Cg9Tc1BQMbDNZRsO/kwX39U+usd5LXVqdTBbkOjIrD97eajPxwV7gjfb
         487permxp/gHLEuDuaxzWmWwRSpDOudJsWXi9UnIt5h6qNtb37cPeMyzSlPuBmn90d
         Nl+k0An6zlzxuhGOMC8LOQevSYnnpHxyvLWNLiF3z+7uTIKObTA42F5+S2IaVcW0rH
         stZkbNldqbSM+M5NVBlrsg6zlNYiKHHge+A0LewHzamKWFMl4xj+HNd2Yr3wCaPNFN
         hDEO7nMhmV+5w==
Message-ID: <df1fdcbf5ef46928a5900569214847a6c66c0147.camel@kernel.org>
Subject: Re: [PATCH 15/44] ITER_PIPE: helpers for adding pipe buffers
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Date:   Tue, 28 Jun 2022 07:32:44 -0400
In-Reply-To: <20220622041552.737754-15-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
         <20220622041552.737754-1-viro@zeniv.linux.org.uk>
         <20220622041552.737754-15-viro@zeniv.linux.org.uk>
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
> There are only two kinds of pipe_buffer in the area used by ITER_PIPE.
>=20
> 1) anonymous - copy_to_iter() et.al. end up creating those and copying
> data there.  They have zero ->offset, and their ->ops points to
> default_pipe_page_ops.
>=20
> 2) zero-copy ones - those come from copy_page_to_iter(), and page
> comes from caller.  ->offset is also caller-supplied - it might be
> non-zero.  ->ops points to page_cache_pipe_buf_ops.
>=20
> Move creation and insertion of those into helpers - push_anon(pipe, size)
> and push_page(pipe, page, offset, size) resp., separating them from
> the "could we avoid creating a new buffer by merging with the current
> head?" logics.
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  lib/iov_iter.c | 88 ++++++++++++++++++++++++++------------------------
>  1 file changed, 46 insertions(+), 42 deletions(-)
>=20
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 08bb393da677..924854c2a7ce 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -231,15 +231,39 @@ static bool sanity(const struct iov_iter *i)
>  #define sanity(i) true
>  #endif
> =20
> +static struct page *push_anon(struct pipe_inode_info *pipe, unsigned siz=
e)
> +{
> +	struct page *page =3D alloc_page(GFP_USER);
> +	if (page) {
> +		struct pipe_buffer *buf =3D pipe_buf(pipe, pipe->head++);
> +		*buf =3D (struct pipe_buffer) {
> +			.ops =3D &default_pipe_buf_ops,
> +			.page =3D page,
> +			.offset =3D 0,
> +			.len =3D size
> +		};
> +	}
> +	return page;
> +}
> +
> +static void push_page(struct pipe_inode_info *pipe, struct page *page,
> +			unsigned int offset, unsigned int size)
> +{
> +	struct pipe_buffer *buf =3D pipe_buf(pipe, pipe->head++);
> +	*buf =3D (struct pipe_buffer) {
> +		.ops =3D &page_cache_pipe_buf_ops,
> +		.page =3D page,
> +		.offset =3D offset,
> +		.len =3D size
> +	};
> +	get_page(page);
> +}
> +
>  static size_t copy_page_to_iter_pipe(struct page *page, size_t offset, s=
ize_t bytes,
>  			 struct iov_iter *i)
>  {
>  	struct pipe_inode_info *pipe =3D i->pipe;
> -	struct pipe_buffer *buf;
> -	unsigned int p_tail =3D pipe->tail;
> -	unsigned int p_mask =3D pipe->ring_size - 1;
> -	unsigned int i_head =3D i->head;
> -	size_t off;
> +	unsigned int head =3D pipe->head;
> =20
>  	if (unlikely(bytes > i->count))
>  		bytes =3D i->count;
> @@ -250,32 +274,21 @@ static size_t copy_page_to_iter_pipe(struct page *p=
age, size_t offset, size_t by
>  	if (!sanity(i))
>  		return 0;
> =20
> -	off =3D i->iov_offset;
> -	buf =3D &pipe->bufs[i_head & p_mask];
> -	if (off) {
> -		if (offset =3D=3D off && buf->page =3D=3D page) {
> -			/* merge with the last one */
> +	if (offset && i->iov_offset =3D=3D offset) { // could we merge it?
> +		struct pipe_buffer *buf =3D pipe_buf(pipe, head - 1);
> +		if (buf->page =3D=3D page) {
>  			buf->len +=3D bytes;
>  			i->iov_offset +=3D bytes;
> -			goto out;
> +			i->count -=3D bytes;
> +			return bytes;
>  		}
> -		i_head++;
> -		buf =3D &pipe->bufs[i_head & p_mask];
>  	}
> -	if (pipe_full(i_head, p_tail, pipe->max_usage))
> +	if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
>  		return 0;
> =20
> -	buf->ops =3D &page_cache_pipe_buf_ops;
> -	buf->flags =3D 0;
> -	get_page(page);
> -	buf->page =3D page;
> -	buf->offset =3D offset;
> -	buf->len =3D bytes;
> -
> -	pipe->head =3D i_head + 1;
> +	push_page(pipe, page, offset, bytes);
>  	i->iov_offset =3D offset + bytes;
> -	i->head =3D i_head;
> -out:
> +	i->head =3D head;
>  	i->count -=3D bytes;
>  	return bytes;
>  }
> @@ -407,8 +420,6 @@ static size_t push_pipe(struct iov_iter *i, size_t si=
ze,
>  			int *iter_headp, size_t *offp)
>  {
>  	struct pipe_inode_info *pipe =3D i->pipe;
> -	unsigned int p_tail =3D pipe->tail;
> -	unsigned int p_mask =3D pipe->ring_size - 1;
>  	unsigned int iter_head;
>  	size_t off;
>  	ssize_t left;
> @@ -423,30 +434,23 @@ static size_t push_pipe(struct iov_iter *i, size_t =
size,
>  	*iter_headp =3D iter_head;
>  	*offp =3D off;
>  	if (off) {
> +		struct pipe_buffer *buf =3D pipe_buf(pipe, iter_head);
> +
>  		left -=3D PAGE_SIZE - off;
>  		if (left <=3D 0) {
> -			pipe->bufs[iter_head & p_mask].len +=3D size;
> +			buf->len +=3D size;
>  			return size;
>  		}
> -		pipe->bufs[iter_head & p_mask].len =3D PAGE_SIZE;
> -		iter_head++;
> +		buf->len =3D PAGE_SIZE;
>  	}
> -	while (!pipe_full(iter_head, p_tail, pipe->max_usage)) {
> -		struct pipe_buffer *buf =3D &pipe->bufs[iter_head & p_mask];
> -		struct page *page =3D alloc_page(GFP_USER);
> +	while (!pipe_full(pipe->head, pipe->tail, pipe->max_usage)) {
> +		struct page *page =3D push_anon(pipe,
> +					      min_t(ssize_t, left, PAGE_SIZE));
>  		if (!page)
>  			break;
> =20
> -		buf->ops =3D &default_pipe_buf_ops;
> -		buf->flags =3D 0;
> -		buf->page =3D page;
> -		buf->offset =3D 0;
> -		buf->len =3D min_t(ssize_t, left, PAGE_SIZE);
> -		left -=3D buf->len;
> -		iter_head++;
> -		pipe->head =3D iter_head;
> -
> -		if (left =3D=3D 0)
> +		left -=3D PAGE_SIZE;
> +		if (left <=3D 0)
>  			return size;
>  	}
>  	return size - left;

Not sure I follow all of the buffer handling shenanigans in here, but I
think it looks sane.

Acked-by: Jeff Layton <jlayton@kernel.org>
