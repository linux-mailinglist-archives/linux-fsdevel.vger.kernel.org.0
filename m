Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E99055D4E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237598AbiF0TPj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jun 2022 15:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235557AbiF0TPi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jun 2022 15:15:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EFB639F
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jun 2022 12:15:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFE1B61579
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jun 2022 19:15:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B5E4C3411D;
        Mon, 27 Jun 2022 19:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656357336;
        bh=V7RYN3S7sP+X1R43sEJEi8P5Nj7dtEHwIADybZppQok=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HOHhmv8lyBVSASrvqHAzcMaHfkCkmGdjjCOG35L1nfFqJmF/iMphbxLofBFtkJNz3
         qF4VCD2w3FdWSBJmtTnwKk6t4NaEcETiYD9bgivcv9csj3MCPrIVKuECy+n0ZQE7wz
         AQ0y/d8m5yukm6r0CnKBte97MlJHWycR9J+eTqGDXUQzjGnxyWIQmddxarvQvV2rhj
         tD93o02GDVZvXMaKFV6fF64W/aQQtJhWfSs+ieB5NH5wzuTiSjLgg8qyIAHJ2ZUCXu
         VIdiPctdtZV6QQphxkmYCVbwFJO/G1Aayw3Z/DeWN+0QZVLlfTN/op/OwjofLKiCmH
         FGG8SFZbD8PAA==
Message-ID: <b036442de875b654c20299950352f08614aed3bb.camel@kernel.org>
Subject: Re: [PATCH 12/44] fix short copy handling in copy_mc_pipe_to_iter()
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Date:   Mon, 27 Jun 2022 15:15:33 -0400
In-Reply-To: <20220622041552.737754-12-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
         <20220622041552.737754-1-viro@zeniv.linux.org.uk>
         <20220622041552.737754-12-viro@zeniv.linux.org.uk>
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
> Unlike other copying operations on ITER_PIPE, copy_mc_to_iter() can
> result in a short copy.  In that case we need to trim the unused
> buffers, as well as the length of partially filled one - it's not
> enough to set ->head, ->iov_offset and ->count to reflect how
> much had we copied.  Not hard to fix, fortunately...
>=20
> I'd put a helper (pipe_discard_from(pipe, head)) into pipe_fs_i.h,
> rather than iov_iter.c - it has nothing to do with iov_iter and
> having it will allow us to avoid an ugly kludge in fs/splice.c.
> We could put it into lib/iov_iter.c for now and move it later,
> but I don't see the point going that way...
>=20
> Fixes: ca146f6f091e "lib/iov_iter: Fix pipe handling in _copy_to_iter_mcs=
afe()"
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  include/linux/pipe_fs_i.h |  9 +++++++++
>  lib/iov_iter.c            | 15 +++++++++++----
>  2 files changed, 20 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
> index cb0fd633a610..4ea496924106 100644
> --- a/include/linux/pipe_fs_i.h
> +++ b/include/linux/pipe_fs_i.h
> @@ -229,6 +229,15 @@ static inline bool pipe_buf_try_steal(struct pipe_in=
ode_info *pipe,
>  	return buf->ops->try_steal(pipe, buf);
>  }
> =20
> +static inline void pipe_discard_from(struct pipe_inode_info *pipe,
> +		unsigned int old_head)
> +{
> +	unsigned int mask =3D pipe->ring_size - 1;
> +
> +	while (pipe->head > old_head)
> +		pipe_buf_release(pipe, &pipe->bufs[--pipe->head & mask]);
> +}
> +
>  /* Differs from PIPE_BUF in that PIPE_SIZE is the length of the actual
>     memory allocation, whereas PIPE_BUF makes atomicity guarantees.  */
>  #define PIPE_SIZE		PAGE_SIZE
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 0b64695ab632..2bf20b48a04a 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -689,6 +689,7 @@ static size_t copy_mc_pipe_to_iter(const void *addr, =
size_t bytes,
>  	struct pipe_inode_info *pipe =3D i->pipe;
>  	unsigned int p_mask =3D pipe->ring_size - 1;
>  	unsigned int i_head;
> +	unsigned int valid =3D pipe->head;
>  	size_t n, off, xfer =3D 0;
> =20
>  	if (!sanity(i))
> @@ -702,11 +703,17 @@ static size_t copy_mc_pipe_to_iter(const void *addr=
, size_t bytes,
>  		rem =3D copy_mc_to_kernel(p + off, addr + xfer, chunk);
>  		chunk -=3D rem;
>  		kunmap_local(p);
> -		i->head =3D i_head;
> -		i->iov_offset =3D off + chunk;
> -		xfer +=3D chunk;
> -		if (rem)
> +		if (chunk) {
> +			i->head =3D i_head;
> +			i->iov_offset =3D off + chunk;
> +			xfer +=3D chunk;
> +			valid =3D i_head + 1;
> +		}
> +		if (rem) {
> +			pipe->bufs[i_head & p_mask].len -=3D rem;
> +			pipe_discard_from(pipe, valid);
>  			break;
> +		}
>  		n -=3D chunk;
>  		off =3D 0;
>  		i_head++;

Reviewed-by: Jeff Layton <jlayton@kernel.org>
