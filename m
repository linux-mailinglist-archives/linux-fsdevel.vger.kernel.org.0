Return-Path: <linux-fsdevel+bounces-31363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49F69956C0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 20:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5C21C224AB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 18:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8213212D3C;
	Tue,  8 Oct 2024 18:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="to4X9MHn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE991E0DDD;
	Tue,  8 Oct 2024 18:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412640; cv=none; b=k55kBfeop54p9jfoWuRut6ULF/EHvg9JGdcr0em5zj6mb6b0NkSkSD68tWAKx6Rgf2I6QcvYr9SpHxjbcWm2znXRgvXinPtwr59MIplWOksYqmKksJEIQWzgG6qxxX8khqPsyryR0yJfF+/d/wpotBlKliuXP/D0uGuwpY4A0mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412640; c=relaxed/simple;
	bh=JN7FYQviyirjPFA+WtNSib5/mPHM9CPS3S7oRFW8B10=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pgczN4EcjPiUg0aslvTJgiSQMWuqntlBG0dcPR2872qFymWSaqoYOCogF7sej6zE2tF3FkYaUR9iWxgh0smge8VGARDOuvUcj8SLWdc0tBmHFM2J+RXu4yeIrxB4yV5R9Gd7/sZU0jhPk9VdBXDTxi5+DmE1OmRyTio/eaYNkZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=to4X9MHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2177BC4CEC7;
	Tue,  8 Oct 2024 18:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728412639;
	bh=JN7FYQviyirjPFA+WtNSib5/mPHM9CPS3S7oRFW8B10=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=to4X9MHnDhmYHUrND/322o0HLt5sUPaNxXQlhpZoa7Bi45DgRKSp1UCHs0cpAYpHU
	 2ObwSPpKCELYDS9GozjHcFQUxNkeoCO+p8l0XBDfQN5L5eHDbx9si6Qplc5h4IOmBS
	 ah6sDTgwOf6TOgrbZ7Z/9Ws6SR+sz94CZgWksoxbaez4jCsZwHvrOKunaxuHg/6/oN
	 ff1CPGVnQxt0UjyMwsedV2IqMTOLeXDMYzazQO3pw5yXU2JIic4DfTcXEFx6RaqLdW
	 WYod7rOcZfCVmhHW3gK3p/Ag5+QaeGRLz1jpOpgMuoAjjI7zMQFByy5IPUBrMq8W2w
	 XNvG7TG6Uxwhg==
Message-ID: <dda3f1f28bce2d155bcffce953dc331956df38f2.camel@kernel.org>
Subject: Re: [PATCH v3 3/3] fs: open_by_handle_at() support for decoding
 "explicit connectable" file handles
From: Jeff Layton <jlayton@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Aleksa
 Sarai <cyphar@cyphar.com>, Chuck Lever <chuck.lever@oracle.com>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Date: Tue, 08 Oct 2024 14:37:18 -0400
In-Reply-To: <20241008152118.453724-4-amir73il@gmail.com>
References: <20241008152118.453724-1-amir73il@gmail.com>
	 <20241008152118.453724-4-amir73il@gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-08 at 17:21 +0200, Amir Goldstein wrote:
> Teach open_by_handle_at(2) about the type format of "explicit connectable=
"
> file handles that were created using the AT_HANDLE_CONNECTABLE flag to
> name_to_handle_at(2).
>=20
> When decoding an "explicit connectable" file handles, name_to_handle_at(2=
)
> should fail if it cannot open a "connected" fd with known path, which is
> accessible (to capable user) from mount fd path.
>=20
> Note that this does not check if the path is accessible to the calling
> user, just that it is accessible wrt the mount namesapce, so if there
> is no "connected" alias, or if parts of the path are hidden in the
> mount namespace, open_by_handle_at(2) will return -ESTALE.
>=20
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/fhandle.c             | 20 +++++++++++++++++++-
>  include/linux/exportfs.h |  2 +-
>  2 files changed, 20 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index 7b4c8945efcb..6a5458c3c6c9 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -246,7 +246,13 @@ static int vfs_dentry_acceptable(void *context, stru=
ct dentry *dentry)
> =20
>  	if (!(ctx->flags & HANDLE_CHECK_SUBTREE) || d =3D=3D root)
>  		retval =3D 1;
> -	WARN_ON_ONCE(d !=3D root && d !=3D root->d_sb->s_root);
> +	/*
> +	 * exportfs_decode_fh_raw() does not call acceptable() callback with
> +	 * a disconnected directory dentry, so we should have reached either
> +	 * mount fd directory or sb root.
> +	 */
> +	if (ctx->fh_flags & EXPORT_FH_DIR_ONLY)
> +		WARN_ON_ONCE(d !=3D root && d !=3D root->d_sb->s_root);

I don't quite get the test for EXPORT_FH_DIR_ONLY here. Why does this
change require that instead of just continuing to WARN unconditionally?

>  	dput(d);
>  	return retval;
>  }
> @@ -349,6 +355,7 @@ static int handle_to_path(int mountdirfd, struct file=
_handle __user *ufh,
>  		retval =3D -EINVAL;
>  		goto out_path;
>  	}
> +
>  	handle =3D kmalloc(struct_size(handle, f_handle, f_handle.handle_bytes)=
,
>  			 GFP_KERNEL);
>  	if (!handle) {
> @@ -364,6 +371,17 @@ static int handle_to_path(int mountdirfd, struct fil=
e_handle __user *ufh,
>  		goto out_handle;
>  	}
> =20
> +	/*
> +	 * If handle was encoded with AT_HANDLE_CONNECTABLE, verify that we
> +	 * are decoding an fd with connected path, which is accessible from
> +	 * the mount fd path.
> +	 */
> +	if (f_handle.handle_type & FILEID_IS_CONNECTABLE) {
> +		ctx.fh_flags |=3D EXPORT_FH_CONNECTABLE;
> +		ctx.flags |=3D HANDLE_CHECK_SUBTREE;
> +	}
> +	if (f_handle.handle_type & FILEID_IS_DIR)
> +		ctx.fh_flags |=3D EXPORT_FH_DIR_ONLY;
>  	/* Filesystem code should not be exposed to user flags */
>  	handle->handle_type &=3D ~FILEID_USER_FLAGS_MASK;
>  	retval =3D do_handle_to_path(handle, path, &ctx);
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 230b0e1d669d..a48d4c94ff74 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -171,7 +171,7 @@ struct fid {
>  /* Flags supported in encoded handle_type that is exported to user */
>  #define FILEID_IS_CONNECTABLE	0x10000
>  #define FILEID_IS_DIR		0x40000
> -#define FILEID_VALID_USER_FLAGS	(0)
> +#define FILEID_VALID_USER_FLAGS	(FILEID_IS_CONNECTABLE | FILEID_IS_DIR)
> =20
>  #define FILEID_USER_TYPE_IS_VALID(type) \
>  	(!(FILEID_USER_FLAGS(type) & ~FILEID_VALID_USER_FLAGS))

--=20
Jeff Layton <jlayton@kernel.org>

