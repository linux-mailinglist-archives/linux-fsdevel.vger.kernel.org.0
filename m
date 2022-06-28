Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BAD55E24B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344971AbiF1Kix (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 06:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343572AbiF1Kix (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:38:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D714255A6
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 03:38:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB9FE618BB
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 10:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48047C3411D;
        Tue, 28 Jun 2022 10:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656412731;
        bh=pK++iUg+FAb+3A/62sDBGVtjuexGEGFuAqTlXyKZVEk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=D4cy22youenZ2i3OUHmHqhV3BAjeP3rVo2Bym/xPdoaNLA5jtlKnKcQTh/gZ0JGRI
         +FgNqynOIcL/zhbSbC7RP235qvzGHh2lmAQWIHvbPNIFyERm4hwrhRsXHych1xzrE7
         ZYySamd6H/PwpIxz6jdOy2XmuhSfHVRqjuEB9xL4YMJfrYFhv+4NqcbMayJYukbF/w
         ujwU2gvD2Orvc84SCAu6vvaoB+wxFMwHLJq3x5NaUIB1NUo/Eds27/AWNrc9Xs8c2L
         aMdNFy/M2k4wUZ4C4Ln/M4IBz1PCnwAviIuhwhhiJwFfPde1xh6keQ7BFohV9hccLC
         b+hvZG9jmPY7w==
Message-ID: <450d83656a54c0721c73b29d32f27005b61fc1a5.camel@kernel.org>
Subject: Re: [PATCH 14/44] ITER_PIPE: helper for getting pipe buffer by index
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Date:   Tue, 28 Jun 2022 06:38:48 -0400
In-Reply-To: <20220622041552.737754-14-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
         <20220622041552.737754-1-viro@zeniv.linux.org.uk>
         <20220622041552.737754-14-viro@zeniv.linux.org.uk>
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
> pipe_buffer instances of a pipe are organized as a ring buffer,
> with power-of-2 size.  Indices are kept *not* reduced modulo ring
> size, so the buffer refered to by index N is
> 	pipe->bufs[N & (pipe->ring_size - 1)].
>=20
> Ring size can change over the lifetime of a pipe, but not while
> the pipe is locked.  So for any iov_iter primitives it's a constant.
> Original conversion of pipes to this layout went overboard trying
> to microoptimize that - calculating pipe->ring_size - 1, storing
> it in a local variable and using through the function.  In some
> cases it might be warranted, but most of the times it only
> obfuscates what's going on in there.
>=20
> Introduce a helper (pipe_buf(pipe, N)) that would encapsulate
> that and use it in the obvious cases.  More will follow...
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  lib/iov_iter.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index d00cc8971b5b..08bb393da677 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -183,13 +183,18 @@ static int copyin(void *to, const void __user *from=
, size_t n)
>  	return n;
>  }
> =20
> +static inline struct pipe_buffer *pipe_buf(const struct pipe_inode_info =
*pipe,
> +					   unsigned int slot)
> +{
> +	return &pipe->bufs[slot & (pipe->ring_size - 1)];
> +}
> +
>  #ifdef PIPE_PARANOIA
>  static bool sanity(const struct iov_iter *i)
>  {
>  	struct pipe_inode_info *pipe =3D i->pipe;
>  	unsigned int p_head =3D pipe->head;
>  	unsigned int p_tail =3D pipe->tail;
> -	unsigned int p_mask =3D pipe->ring_size - 1;
>  	unsigned int p_occupancy =3D pipe_occupancy(p_head, p_tail);
>  	unsigned int i_head =3D i->head;
>  	unsigned int idx;
> @@ -201,7 +206,7 @@ static bool sanity(const struct iov_iter *i)
>  		if (unlikely(i_head !=3D p_head - 1))
>  			goto Bad;	// must be at the last buffer...
> =20
> -		p =3D &pipe->bufs[i_head & p_mask];
> +		p =3D pipe_buf(pipe, i_head);
>  		if (unlikely(p->offset + p->len !=3D i->iov_offset))
>  			goto Bad;	// ... at the end of segment
>  	} else {
> @@ -386,11 +391,10 @@ static inline bool allocated(struct pipe_buffer *bu=
f)
>  static inline void data_start(const struct iov_iter *i,
>  			      unsigned int *iter_headp, size_t *offp)
>  {
> -	unsigned int p_mask =3D i->pipe->ring_size - 1;
>  	unsigned int iter_head =3D i->head;
>  	size_t off =3D i->iov_offset;
> =20
> -	if (off && (!allocated(&i->pipe->bufs[iter_head & p_mask]) ||
> +	if (off && (!allocated(pipe_buf(i->pipe, iter_head)) ||
>  		    off =3D=3D PAGE_SIZE)) {
>  		iter_head++;
>  		off =3D 0;
> @@ -1180,10 +1184,9 @@ unsigned long iov_iter_alignment(const struct iov_=
iter *i)
>  		return iov_iter_alignment_bvec(i);
> =20
>  	if (iov_iter_is_pipe(i)) {
> -		unsigned int p_mask =3D i->pipe->ring_size - 1;
>  		size_t size =3D i->count;
> =20
> -		if (size && i->iov_offset && allocated(&i->pipe->bufs[i->head & p_mask=
]))
> +		if (size && i->iov_offset && allocated(pipe_buf(i->pipe, i->head)))
>  			return size | i->iov_offset;
>  		return size;
>  	}

Reviewed-by: Jeff Layton <jlayton@kernel.org>
