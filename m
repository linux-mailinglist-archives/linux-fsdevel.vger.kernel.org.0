Return-Path: <linux-fsdevel+bounces-68057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3567C52470
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 13:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 618793B60D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 12:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FA9332EAE;
	Wed, 12 Nov 2025 12:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6QGQBfF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9839331A5A;
	Wed, 12 Nov 2025 12:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762950718; cv=none; b=TXFbxlhPcYA9u/8q1NG42nA8bgO2piVLrW3GGGvEp6ZhpH6BPCs5/qnCmFj1ZFYQEGjMfbvXMSg/cS+tAo0ejLxzE9C2MFBP4aYajCjIpiTE40Z1jc7GNzESwbhulGAwexQFvMfhmUtVADVyeqYi/26dH/THGGZPtZITY8OFAgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762950718; c=relaxed/simple;
	bh=GlKYuKsEEyi4V2HY2b7ezLSnFWQ2Pyb/BCq/tb6wv9k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZaRpvht5rBEX9NKzaDdlcjvUYTyDT2q6mdxA9kdFxzQkQE4t1LQygcacE/mjfqdLFYsvfZ17PbhGCTFGgVzXXuyRyKstIefz2TKaGSFZakI1Ox3iAhuw+1shTbNwyf3jDRllBHgtIkCtUSl0J3AJKfHEmALycnh78FzfygMMnoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6QGQBfF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F2AC4CEF8;
	Wed, 12 Nov 2025 12:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762950718;
	bh=GlKYuKsEEyi4V2HY2b7ezLSnFWQ2Pyb/BCq/tb6wv9k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=p6QGQBfFo45yhdgOmFWmNdPNAXGoJujKk2obqH/VXsA7nBYPLNAevEsvYGaLM9Fpc
	 9tPag9hIk8T2GGvk5QGxRRASWyj9Pafm31liXjiUpkiWN30/r7RaWpllN2xELUzD5i
	 6BaqKmdcelwVqaw4f3DxGaRpBzSvbXmk7n6fd4JYaGZinnFPSvQwysWip+YDxL0wNR
	 cq54hv4a9v64z8WHWxcxgI71vr1XO3FVc+T0JXgX14YirfZ//mi8fAEx7Nz/4IzaLV
	 rEClr9jjSkK6xyPLRgd09wvZT2Az9UpT1QPDGoIy9/ZQAL3wkFlkN63g3bSYYAxVue
	 ejvEFAKTGPUrw==
Message-ID: <9fe596e42cbb68111901eb0354c76bdd8cd86287.camel@kernel.org>
Subject: Re: [PATCH v2 2/2] fs: track the inode having file locks with a
 flag in ->i_opflags
From: Jeff Layton <jlayton@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Date: Wed, 12 Nov 2025 07:31:56 -0500
In-Reply-To: <20251112104432.1785404-2-mjguzik@gmail.com>
References: <20251112104432.1785404-1-mjguzik@gmail.com>
	 <20251112104432.1785404-2-mjguzik@gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-12 at 11:44 +0100, Mateusz Guzik wrote:
> Opening and closing an inode dirties the ->i_readcount field.
>=20
> Depending on the alignment of the inode, it may happen to false-share
> with other fields loaded both for both operations to various extent.
>=20
> This notably concerns the ->i_flctx field.
>=20
> Since most inodes don't have the field populated, this bit can be managed
> with a flag in ->i_opflags instead which bypasses the problem.
>=20
> Here are results I obtained while opening a file read-only in a loop
> with 24 cores doing the work on Sapphire Rapids. Utilizing the flag as
> opposed to reading ->i_flctx field was toggled at runtime as the benchmar=
k
> was running, to make sure both results come from the same alignment.
>=20
> before: 3233740
> after:  3373346 (+4%)
>=20
> before: 3284313
> after:  3518711 (+7%)
>=20
> before: 3505545
> after:  4092806 (+16%)
>=20
> Or to put it differently, this varies wildly depending on how (un)lucky
> you get.
>=20
> The primary bottleneck before and after is the avoidable lockref trip in
> do_dentry_open().
>=20
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>=20
> v2:
> - fix smatch warning:
> ./include/linux/filelock.h:241:24: warning: Using plain integer as NULL p=
ointer
>=20
>  fs/locks.c               | 14 ++++++++++++--
>  include/linux/filelock.h | 15 +++++++++++----
>  include/linux/fs.h       |  1 +
>  3 files changed, 24 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/locks.c b/fs/locks.c
> index 04a3f0e20724..9cd23dd2a74e 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -178,7 +178,6 @@ locks_get_lock_context(struct inode *inode, int type)
>  {
>  	struct file_lock_context *ctx;
> =20
> -	/* paired with cmpxchg() below */
>  	ctx =3D locks_inode_context(inode);
>  	if (likely(ctx) || type =3D=3D F_UNLCK)
>  		goto out;
> @@ -196,7 +195,18 @@ locks_get_lock_context(struct inode *inode, int type=
)
>  	 * Assign the pointer if it's not already assigned. If it is, then
>  	 * free the context we just allocated.
>  	 */
> -	if (cmpxchg(&inode->i_flctx, NULL, ctx)) {
> +	spin_lock(&inode->i_lock);
> +	if (!(inode->i_opflags & IOP_FLCTX)) {
> +		VFS_BUG_ON_INODE(inode->i_flctx, inode);
> +		WRITE_ONCE(inode->i_flctx, ctx);
> +		/*
> +		 * Paired with locks_inode_context().
> +		 */
> +		smp_store_release(&inode->i_opflags, inode->i_opflags | IOP_FLCTX);
> +		spin_unlock(&inode->i_lock);

Not thrilled with having to deal with the i_lock here, but this is the
slow path and we typically only go through it once per inode. I can
believe that IOP_FLCTX helps the more common case where the i_flctx is
already present.

> +	} else {
> +		VFS_BUG_ON_INODE(!inode->i_flctx, inode);
> +		spin_unlock(&inode->i_lock);
>  		kmem_cache_free(flctx_cache, ctx);
>  		ctx =3D locks_inode_context(inode);
>  	}
> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
> index 37e1b33bd267..9dc57b3dcfae 100644
> --- a/include/linux/filelock.h
> +++ b/include/linux/filelock.h
> @@ -233,8 +233,12 @@ static inline struct file_lock_context *
>  locks_inode_context(const struct inode *inode)
>  {
>  	/*
> -	 * Paired with the fence in locks_get_lock_context().
> +	 * Paired with smp_store_release in locks_get_lock_context().
> +	 *
> +	 * Ensures ->i_flctx will be visible if we spotted the flag.
>  	 */
> +	if (likely(!(smp_load_acquire(&inode->i_opflags) & IOP_FLCTX)))
> +		return NULL;
>  	return READ_ONCE(inode->i_flctx);
>  }
> =20
> @@ -441,7 +445,7 @@ static inline int break_lease(struct inode *inode, un=
signed int mode)
>  	 * could end up racing with tasks trying to set a new lease on this
>  	 * file.
>  	 */
> -	flctx =3D READ_ONCE(inode->i_flctx);
> +	flctx =3D locks_inode_context(inode);
>  	if (!flctx)
>  		return 0;
>  	smp_mb();
> @@ -460,7 +464,7 @@ static inline int break_deleg(struct inode *inode, un=
signed int mode)
>  	 * could end up racing with tasks trying to set a new lease on this
>  	 * file.
>  	 */
> -	flctx =3D READ_ONCE(inode->i_flctx);
> +	flctx =3D locks_inode_context(inode);
>  	if (!flctx)
>  		return 0;
>  	smp_mb();
> @@ -493,8 +497,11 @@ static inline int break_deleg_wait(struct inode **de=
legated_inode)
> =20
>  static inline int break_layout(struct inode *inode, bool wait)
>  {
> +	struct file_lock_context *flctx;
> +
>  	smp_mb();
> -	if (inode->i_flctx && !list_empty_careful(&inode->i_flctx->flc_lease))
> +	flctx =3D locks_inode_context(inode);
> +	if (flctx && !list_empty_careful(&flctx->flc_lease))
>  		return __break_lease(inode,
>  				wait ? O_WRONLY : O_WRONLY | O_NONBLOCK,
>  				FL_LAYOUT);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index b803a592c07e..b3d9230c310f 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -655,6 +655,7 @@ is_uncached_acl(struct posix_acl *acl)
>  #define IOP_MGTIME		0x0020
>  #define IOP_CACHED_LINK		0x0040
>  #define IOP_FASTPERM_MAY_EXEC	0x0080
> +#define IOP_FLCTX		0x0100
> =20
>  /*
>   * Inode state bits.  Protected by inode->i_lock

This looks correct to me.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

