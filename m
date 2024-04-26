Return-Path: <linux-fsdevel+bounces-17888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7511F8B36A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 13:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 321E4284A75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 11:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154AE145B37;
	Fri, 26 Apr 2024 11:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxW0Hd2d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B039145B21;
	Fri, 26 Apr 2024 11:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714131801; cv=none; b=VyQbCT3hZ8wrmMqJiAUGBhQdxTjPQAYH/2G61GopPG/I3Soz4eYBmqPS20acA4i3YJMbi2sek2f1+28H9bUXK70kYKULjZCopIzq9VUvB5Tyhj4nAGW7LSSjOFo7irSExhAwEoB2VikdeWhvgZMkdBwbaxctUgitEm1HzoErG7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714131801; c=relaxed/simple;
	bh=W2Yi4b8UUflYNjFBhKm+kSTDx5VFRPzQrHLBTed65Eo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a5jt+07T5f6bC45RpQVxJR46PaXsZcSjeKdVTA2G3vT8bdLZo9L9/izadbj7c7AkQikWzOZWeo+uBVvHiiGjq3gMS1hP7VjeJbYArf0+lCUhgw3tUyOHZmhH0WJn5ShQHJfWczbVJy9gkifAcewK/dLnvysZbwSoeUiHltGH8dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxW0Hd2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BCFC113CD;
	Fri, 26 Apr 2024 11:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714131801;
	bh=W2Yi4b8UUflYNjFBhKm+kSTDx5VFRPzQrHLBTed65Eo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=BxW0Hd2dK2F/YPPiVT1xiQG5GFCiDj/hJDpVwiGyocQgdwzxvWmYRYTgWcRy9IkbN
	 5aRPbbergf3asX5vbt3nG/jmaKq5DM6kYtiEEKlQKHHgO/OBH2gUyAh9CG/R09PVdU
	 WPv/8XRaP0occLuKeiMMsLQ4TheW8WKQQkGABFz7zOpkra4Y1lm0T4iCntWi/6gCj5
	 /wzXg1efvKb0JjUg8c2/2T3TJKX+ldf8I6IJ2xD1JW97G8HJWIsOugwKTiApeUgkXl
	 mJHH9LPsbfTmuY4ZCA4l9qz5Gg8b8BHu/gvoKR+DEHRNZv4K3EoHs9FDzjHKS4PMPT
	 eqHQZMURSPdBQ==
Message-ID: <873caf750d495a1850839f30fb120be7c6b5fd36.camel@kernel.org>
Subject: Re: [PATCH] netfs: Fix the pre-flush when appending to a file in
 writethrough mode
From: Jeffrey Layton <jlayton@kernel.org>
To: David Howells <dhowells@redhat.com>, Christian Brauner
 <brauner@kernel.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>,  Dominique Martinet <asmadeus@codewreck.org>, Christian
 Schoenebeck <linux_oss@crudebyte.com>, Marc Dionne
 <marc.dionne@auristor.com>, netfs@lists.linux.dev, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, v9fs@lists.linux.dev, 
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Fri, 26 Apr 2024 07:43:18 -0400
In-Reply-To: <2150448.1714130115@warthog.procyon.org.uk>
References: <2150448.1714130115@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 (3.52.0-1.fc40app1) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-26 at 12:15 +0100, David Howells wrote:
> In netfs_perform_write(), when the file is marked NETFS_ICTX_WRITETHROUGH
> or O_*SYNC or RWF_*SYNC was specified, write-through caching is performed
> on a buffered file.  When setting up for write-through, we flush any
> conflicting writes in the region and wait for the write to complete,
> failing if there's a write error to return.
>=20
> The issue arises if we're writing at or above the EOF position because we
> skip the flush and - more importantly - the wait.  This becomes a problem
> if there's a partial folio at the end of the file that is being written o=
ut
> and we want to make a write to it too.  Both the already-running write an=
d
> the write we start both want to clear the writeback mark, but whoever is
> second causes a warning looking something like:
>=20
>     ------------[ cut here ]------------
>     R=3D00000012: folio 11 is not under writeback
>     WARNING: CPU: 34 PID: 654 at fs/netfs/write_collect.c:105
>     ...
>     CPU: 34 PID: 654 Comm: kworker/u386:27 Tainted: G S ...
>     ...
>     Workqueue: events_unbound netfs_write_collection_worker
>     ...
>     RIP: 0010:netfs_writeback_lookup_folio
>=20
> Fix this by making the flush-and-wait unconditional.  It will do nothing =
if
> there are no folios in the pagecache and will return quickly if there are
> no folios in the region specified.
>=20
> Further, move the WBC attachment above the flush call as the flush is goi=
ng
> to attach a WBC and detach it again if it is not present - and since we
> need one anyway we might as well share it.
>=20
> Fixes: 41d8e7673a77 ("netfs: Implement a write-through caching option")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202404161031.468b84f-oliver.sang@i=
ntel.com
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Eric Van Hensbergen <ericvh@kernel.org>
> cc: Latchesar Ionkov <lucho@ionkov.net>
> cc: Dominique Martinet <asmadeus@codewreck.org>
> cc: Christian Schoenebeck <linux_oss@crudebyte.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> cc: v9fs@lists.linux.dev
> cc: linux-afs@lists.infradead.org
> cc: linux-cifs@vger.kernel.org
> ---
>  fs/netfs/buffered_write.c |   13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
> index 9a0d32e4b422..07aff231926c 100644
> --- a/fs/netfs/buffered_write.c
> +++ b/fs/netfs/buffered_write.c
> @@ -172,15 +172,14 @@ ssize_t netfs_perform_write(struct kiocb *iocb, str=
uct iov_iter *iter,
>  	if (unlikely(test_bit(NETFS_ICTX_WRITETHROUGH, &ctx->flags) ||
>  		     iocb->ki_flags & (IOCB_DSYNC | IOCB_SYNC))
>  	    ) {
> -		if (pos < i_size_read(inode)) {
> -			ret =3D filemap_write_and_wait_range(mapping, pos, pos + iter->count)=
;
> -			if (ret < 0) {
> -				goto out;
> -			}
> -		}
> -
>  		wbc_attach_fdatawrite_inode(&wbc, mapping->host);
> =20
> +		ret =3D filemap_write_and_wait_range(mapping, pos, pos + iter->count);
> +		if (ret < 0) {
> +			wbc_detach_inode(&wbc);
> +			goto out;
> +		}
> +
>  		wreq =3D netfs_begin_writethrough(iocb, iter->count);
>  		if (IS_ERR(wreq)) {
>  			wbc_detach_inode(&wbc);
>=20

Reviewed-by: Jeffrey Layton <jlayton@kernel.org>

