Return-Path: <linux-fsdevel+bounces-25151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 276B8949760
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 20:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59B51F22257
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 18:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420DF770F3;
	Tue,  6 Aug 2024 18:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mooBXGFe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8F824211;
	Tue,  6 Aug 2024 18:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722967927; cv=none; b=p45nK+6iRAZEm9/cN1hxc/ivPJoApEFDQmql+/DZB9TVuh3lPaDj4lquZPQR+eD1HspfV3uOguFxkSY+8ntS3E+MGtZJsDs1bBxpanB/aASwjmAww/VAUyePfUEP4Fad2UDjYCFRkxp2EzPaz+Z25a96Ef48LmwPLphV6XCDcNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722967927; c=relaxed/simple;
	bh=Xt+QcqAW74Niy6lI+W4HfqfYEpVdrM2k/3lt77RgsR4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T565+wboCyMvGlt/ifQwdjErIqampFtqliPo3M+taea4FvAmgbFmhlekk1Ud0jVKtTleXRgv/mqu5n2UTAhAlyvGCiEYSCZ8OaDkqEQTLJ4NDoMzIs5Xs+Ybb83THOxMxwg5vFszcgI0Fgg2is/EmpkMUQhYg6St7r3p6mAY7CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mooBXGFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2D4C32786;
	Tue,  6 Aug 2024 18:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722967927;
	bh=Xt+QcqAW74Niy6lI+W4HfqfYEpVdrM2k/3lt77RgsR4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=mooBXGFeyFOHFQT19FjyIWz+jUuarvcgZey2Z9Q/0+zpHhGDtw2S83aY1n0PyhCQh
	 QRKE2rULM4HmtzhTjAOmE5rQa0fmmUFdk7atIOWMnvNxm4t1IkjxEb0obtXfZhgTZD
	 haDQU6MOhBi8b8qy7tz5lOjGzIYuNHA2HyuweU1vEYO+pJsGSdnZDiKyNVT2B00ceL
	 6IaeywpXEUQk57IWHZroBC9RzsiLTXAZ1vcsr3A2+g9rDfFf+zXncNeLfXigrq1VVY
	 VU7meYVTvQx7D7KKS0lIt3ec/7/u1ZoYXIzu2O+5r5u/bsKfoFUayErRF86yOtCJ6b
	 vrBjsemi+2Nlg==
Message-ID: <b2f081444c0c70603af40942e0776fe1fb298577.camel@kernel.org>
Subject: Re: [PATCH] vfs: dodge smp_mb in break_lease and break_deleg in the
 common case
From: Jeff Layton <jlayton@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org, 
	viro@zeniv.linux.org.uk
Cc: jack@suse.cz, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date: Tue, 06 Aug 2024 14:12:05 -0400
In-Reply-To: <20240806172846.886570-1-mjguzik@gmail.com>
References: <20240806172846.886570-1-mjguzik@gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=mQINBE6V0TwBEADXhJg7s8wFDwBMEvn0qyhAnzFLTOCHooMZyx7XO7dAiIhDSi7G1NPxw
 n8jdFUQMCR/GlpozMFlSFiZXiObE7sef9rTtM68ukUyZM4pJ9l0KjQNgDJ6Fr342Htkjxu/kFV1Wv
 egyjnSsFt7EGoDjdKqr1TS9syJYFjagYtvWk/UfHlW09X+jOh4vYtfX7iYSx/NfqV3W1D7EDi0PqV
 T2h6v8i8YqsATFPwO4nuiTmL6I40ZofxVd+9wdRI4Db8yUNA4ZSP2nqLcLtFjClYRBoJvRWvsv4lm
 0OX6MYPtv76hka8lW4mnRmZqqx3UtfHX/hF/zH24Gj7A6sYKYLCU3YrI2Ogiu7/ksKcl7goQjpvtV
 YrOOI5VGLHge0awt7bhMCTM9KAfPc+xL/ZxAMVWd3NCk5SamL2cE99UWgtvNOIYU8m6EjTLhsj8sn
 VluJH0/RcxEeFbnSaswVChNSGa7mXJrTR22lRL6ZPjdMgS2Km90haWPRc8Wolcz07Y2se0xpGVLEQ
 cDEsvv5IMmeMe1/qLZ6NaVkNuL3WOXvxaVT9USW1+/SGipO2IpKJjeDZfehlB/kpfF24+RrK+seQf
 CBYyUE8QJpvTZyfUHNYldXlrjO6n5MdOempLqWpfOmcGkwnyNRBR46g/jf8KnPRwXs509yAqDB6sE
 LZH+yWr9LQZEwARAQABtCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPokCOAQTAQIAIg
 UCWe8u6AIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQAA5oQRlWghUuCg/+Lb/xGxZD2Q1
 oJVAE37uW308UpVSD2tAMJUvFTdDbfe3zKlPDTuVsyNsALBGclPLagJ5ZTP+Vp2irAN9uwBuacBOT
 tmOdz4ZN2tdvNgozzuxp4CHBDVzAslUi2idy+xpsp47DWPxYFIRP3M8QG/aNW052LaPc0cedYxp8+
 9eiVUNpxF4SiU4i9JDfX/sn9XcfoVZIxMpCRE750zvJvcCUz9HojsrMQ1NFc7MFT1z3MOW2/RlzPc
 og7xvR5ENPH19ojRDCHqumUHRry+RF0lH00clzX/W8OrQJZtoBPXv9ahka/Vp7kEulcBJr1cH5Wz/
 WprhsIM7U9pse1f1gYy9YbXtWctUz8uvDR7shsQxAhX3qO7DilMtuGo1v97I/Kx4gXQ52syh/w6EB
 ny71CZrOgD6kJwPVVAaM1LRC28muq91WCFhs/nzHozpbzcheyGtMUI2Ao4K6mnY+3zIuXPygZMFr9
 KXE6fF7HzKxKuZMJOaEZCiDOq0anx6FmOzs5E6Jqdpo/mtI8beK+BE7Va6ni7YrQlnT0i3vaTVMTi
 CThbqsB20VrbMjlhpf8lfK1XVNbRq/R7GZ9zHESlsa35ha60yd/j3pu5hT2xyy8krV8vGhHvnJ1XR
 MJBAB/UYb6FyC7S+mQZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-06 at 19:28 +0200, Mateusz Guzik wrote:
> These inlines show up in the fast path (e.g., in do_dentry_open()) and
> induce said full barrier regarding i_flctx access when in most cases the
> pointer is NULL.
>=20
> The pointer can be safely checked before issuing the barrier, dodging it
> in most cases as a result.
>=20
> It is plausible the consume fence would be sufficient, but I don't want
> to go audit all callers regarding what they before calling here.
>=20
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>=20
> the header file has locks_inode_context and i even found users like
> this (lease_get_mtime):
>=20
> ctx =3D locks_inode_context(inode);
> if (ctx && !list_empty_careful(&ctx->flc_lease)) {
>=20
> however, without looking further at the code I'm not confident this
> would be sufficient here -- for all I know one consumer needs all stores
> to be visible before looking further after derefing the pointer
>=20
> keeping the full fence in place makes this reasonably easy to reason
> about the change i think, but someone(tm) willing to sort this out is
> most welcome to do so
>=20

Nod. It would be nice to get rid of that barrier. I'm not sure how to
do that in a provably correct way. I'll need to think about that.

> =C2=A0include/linux/filelock.h | 14 ++++++++++++--
> =C2=A01 file changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
> index daee999d05f3..bb44224c6676 100644
> --- a/include/linux/filelock.h
> +++ b/include/linux/filelock.h
> @@ -420,28 +420,38 @@ static inline int locks_lock_file_wait(struct file =
*filp, struct file_lock *fl)
> =C2=A0#ifdef CONFIG_FILE_LOCKING
> =C2=A0static inline int break_lease(struct inode *inode, unsigned int mod=
e)
> =C2=A0{
> +	struct file_lock_context *flctx;
> +
> =C2=A0	/*
> =C2=A0	 * Since this check is lockless, we must ensure that any refcounts
> =C2=A0	 * taken are done before checking i_flctx->flc_lease. Otherwise, w=
e
> =C2=A0	 * could end up racing with tasks trying to set a new lease on thi=
s
> =C2=A0	 * file.
> =C2=A0	 */
> +	flctx =3D READ_ONCE(inode->i_flctx);
> +	if (!flctx)
> +		return 0;
> =C2=A0	smp_mb();
> -	if (inode->i_flctx && !list_empty_careful(&inode->i_flctx->flc_lease))
> +	if (!list_empty_careful(&flctx->flc_lease))
> =C2=A0		return __break_lease(inode, mode, FL_LEASE);
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> =C2=A0static inline int break_deleg(struct inode *inode, unsigned int mod=
e)
> =C2=A0{
> +	struct file_lock_context *flctx;
> +
> =C2=A0	/*
> =C2=A0	 * Since this check is lockless, we must ensure that any refcounts
> =C2=A0	 * taken are done before checking i_flctx->flc_lease. Otherwise, w=
e
> =C2=A0	 * could end up racing with tasks trying to set a new lease on thi=
s
> =C2=A0	 * file.
> =C2=A0	 */
> +	flctx =3D READ_ONCE(inode->i_flctx);
> +	if (!flctx)
> +		return 0;
> =C2=A0	smp_mb();
> -	if (inode->i_flctx && !list_empty_careful(&inode->i_flctx->flc_lease))
> +	if (!list_empty_careful(&flctx->flc_lease))
> =C2=A0		return __break_lease(inode, mode, FL_DELEG);
> =C2=A0	return 0;
> =C2=A0}

This change looks good to me:

Reviewed-by: Jeff Layton <jlayton@kernel.org>

