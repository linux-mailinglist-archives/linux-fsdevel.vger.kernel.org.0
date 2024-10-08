Return-Path: <linux-fsdevel+bounces-31346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC86F99507D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 15:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8B531C24CE8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 13:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57B71DF275;
	Tue,  8 Oct 2024 13:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1cz98D6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106911D362B;
	Tue,  8 Oct 2024 13:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728395004; cv=none; b=KacFFulO57OJgkUvr+Ok6ZOLbrRixTacDOaOcXC0CuanzO6SalNF0DNDG+KLYJ/v2DkSmGkNs9ftMmmlBmMChwidz7KTiAzdWZUs/CozUjx/XiatUSTqFlffjc7VK1fQRwyJqFjwbKdNoasQkgJ/OKe9I8Nyd4uadlSU4vDLVQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728395004; c=relaxed/simple;
	bh=XUjI4CjoFITjJz+g7iM1GJdro7jDpudJjbRpSdBbaBE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pk2ugCFc5sWOzfmJaaV+57Lcippg8uiY2O8yILdc3Oa7QJxVHzU1vVBqT9mdt0qIfgFLsDBMWEOiCaYNyzhgEoPglTG+SO7o80zlY+9AoQJYaMy6LIoHGrHuK6flX3GGJMV5LKOodFWFj1V7SmD6JoUWjPV2rad9SXUEI0WBYig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1cz98D6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7973C4CEC7;
	Tue,  8 Oct 2024 13:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728395003;
	bh=XUjI4CjoFITjJz+g7iM1GJdro7jDpudJjbRpSdBbaBE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=t1cz98D6UjH0+mX9D/n1jGfaqDmzc88iGGyKEB9xuBWE6FtUBO2ofss2H4X7x8d7A
	 AG6Nsvr7VvnY9txRW0Qyh3QmLsPfUox4LaxSEUD4BXW8hzsqVakswpv1MA1fCFRW3G
	 rMlYXA1JAV55815vO1sqO4/H2qtn/l4wcP5gEqg3Es2uUCLHkgBK31E8w6WhKOz4Cp
	 eeOzkHwOjC2UPDdGb//QyZQyCNd+oQqLf0gxWRgILjvVvv+eydrXGiZ2rdyosGoPRz
	 GHGdKckCatHJHc6LOGsOcuc64I8ENM8uINx8ZXOUqP52mw2MymAGwN3G0XX8jgxdbF
	 HMmdGSCoN8gWA==
Message-ID: <842daeacf39f9ef533bc398eb19526e0e1f2d532.camel@kernel.org>
Subject: Re: [PATCH v2 0/2] API for exporting connectable file handles to
 userspace
From: Jeff Layton <jlayton@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Cc: Chuck Lever <chuck.lever@oracle.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, Christian Brauner
	 <brauner@kernel.org>
Date: Tue, 08 Oct 2024 09:43:21 -0400
In-Reply-To: <CAOQ4uxht3A7Rx5eu=DX=Zn2PNyQnj5BkCLMi36Gftt0ej8KhdA@mail.gmail.com>
References: <20240923082829.1910210-1-amir73il@gmail.com>
	 <20240925-seeufer-atheismus-6f7e6ab4965f@brauner>
	 <CAOQ4uxiBwtEs_weg67MHP4TOsXN7hVi0bDCUe_C7b2tHqohtAQ@mail.gmail.com>
	 <021d3f9acf33ff74bfde7aadd6a9a01a8ee64248.camel@kernel.org>
	 <CAOQ4uxht3A7Rx5eu=DX=Zn2PNyQnj5BkCLMi36Gftt0ej8KhdA@mail.gmail.com>
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

On Tue, 2024-10-08 at 15:11 +0200, Amir Goldstein wrote:
> On Tue, Oct 8, 2024 at 1:07=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
> >=20
> > On Mon, 2024-10-07 at 17:26 +0200, Amir Goldstein wrote:
> > > On Wed, Sep 25, 2024 at 11:14=E2=80=AFAM Christian Brauner <brauner@k=
ernel.org> wrote:
> > > >=20
> > > > > open_by_handle_at(2) does not have AT_ flags argument, but also, =
I find
> > > > > it more useful API that encoding a connectable file handle can ma=
ndate
> > > > > the resolving of a connected fd, without having to opt-in for a
> > > > > connected fd independently.
> > > >=20
> > > > This seems the best option to me too if this api is to be added.
> > >=20
> > > Thanks.
> > >=20
> > > Jeff, Chuck,
> > >=20
> > > Any thoughts on this?
> > >=20
> >=20
> > Sorry for the delay. I think encoding the new flag into the fh itself
> > is a reasonable approach.
> >=20
>=20
> Adding Jan.
> Sorry I forgot to CC you on the patches, but struct file_handle is offici=
ally
> a part of fanotify ABI, so your ACK is also needed on this change.
>=20
> > I'm less thrilled with using bitfields for this, just because I have a
> > general dislike of them, and they aren't implemented the same way on
> > all arches. Would it break ABI if we just turned the handle_type int
> > into two uint16_t's instead?
>=20
> I think it will because this will not be backward compat on LE arch:
>=20
>  struct file_handle {
>         __u32 handle_bytes;
> -       int handle_type;
> +      __u16 handle_type;
> +      __u16 handle_flags;
>         /* file identifier */
>         unsigned char f_handle[] __counted_by(handle_bytes);
>  };
>=20

Ok, good point.

> But I can also do without the bitfileds, maybe it's better this way.
> See diff from v2:
>=20
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index 4ce4ffddec62..64d44fc61d43 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -87,9 +87,9 @@ static long do_sys_name_to_handle(const struct path *pa=
th,
>                  * decoding connectable non-directory file handles.
>                  */
>                 if (fh_flags & EXPORT_FH_CONNECTABLE) {
> +                       handle->handle_type |=3D FILEID_IS_CONNECTABLE;
>                         if (d_is_dir(path->dentry))
> -                               fh_flags |=3D EXPORT_FH_DIR_ONLY;
> -                       handle->handle_flags =3D fh_flags;
> +                               fh_flags |=3D FILEID_IS_DIR;
>                 }
>                 retval =3D 0;
>         }
> @@ -352,7 +352,7 @@ static int handle_to_path(int mountdirfd, struct
> file_handle __user *ufh,
>                 retval =3D -EINVAL;
>                 goto out_path;
>         }
> -       if (f_handle.handle_flags & ~EXPORT_FH_USER_FLAGS) {
> +       if (!FILEID_USER_TYPE_IS_VALID(f_handle.handle_type)) {
>                 retval =3D -EINVAL;
>                 goto out_path;
>         }
> @@ -377,10 +377,14 @@ static int handle_to_path(int mountdirfd, struct
> file_handle __user *ufh,
>          * are decoding an fd with connected path, which is accessible fr=
om
>          * the mount fd path.
>          */
> -       ctx.fh_flags |=3D f_handle.handle_flags;
> -       if (ctx.fh_flags & EXPORT_FH_CONNECTABLE)
> +       if (f_handle.handle_type & FILEID_IS_CONNECTABLE) {
> +               ctx.fh_flags |=3D EXPORT_FH_CONNECTABLE;
>                 ctx.flags |=3D HANDLE_CHECK_SUBTREE;
> -
> +               if (f_handle.handle_type & FILEID_IS_DIR)
> +                       ctx.fh_flags |=3D EXPORT_FH_DIR_ONLY;
> +       }
> +       /* Filesystem code should not be exposed to user flags */
> +       handle->handle_type &=3D ~FILEID_USER_FLAGS_MASK;
>         retval =3D do_handle_to_path(handle, path, &ctx);
>=20
>  out_handle:
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 96b62e502f71..3e60bac74fa3 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -159,8 +159,17 @@ struct fid {
>  #define EXPORT_FH_CONNECTABLE  0x1 /* Encode file handle with parent */
>  #define EXPORT_FH_FID          0x2 /* File handle may be non-decodeable =
*/
>  #define EXPORT_FH_DIR_ONLY     0x4 /* Only decode file handle for a
> directory */
> -/* Flags allowed in encoded handle_flags that is exported to user */
> -#define EXPORT_FH_USER_FLAGS   (EXPORT_FH_CONNECTABLE | EXPORT_FH_DIR_ON=
LY)

Maybe add a nice comment here about how the handle_type word is
partitioned?

> +
> +/* Flags supported in encoded handle_type that is exported to user */
> +#define FILEID_USER_FLAGS_MASK 0xffff0000
> +#define FILEID_USER_FLAGS(type) ((type) & FILEID_USER_FLAGS_MASK)
> +
> +#define FILEID_IS_CONNECTABLE  0x10000
> +#define FILEID_IS_DIR          0x40000
> +#define FILEID_VALID_USER_FLAGS        (FILEID_IS_CONNECTABLE | FILEID_I=
S_DIR)
> +
> +#define FILEID_USER_TYPE_IS_VALID(type) \
> +       (FILEID_USER_FLAGS(type) & ~FILEID_VALID_USER_FLAGS)
>=20
>  /**
>   * struct export_operations - for nfsd to communicate with file systems
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index cca7e575d1f8..6329fec40872 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1071,8 +1071,7 @@ struct file {
>=20
>  struct file_handle {
>         __u32 handle_bytes;
> -       int handle_type:16;
> -       int handle_flags:16;
> +       int handle_type;
>         /* file identifier */
>         unsigned char f_handle[] __counted_by(handle_bytes);
>  };


I like that better than bitfields, fwiw.
--=20
Jeff Layton <jlayton@kernel.org>

