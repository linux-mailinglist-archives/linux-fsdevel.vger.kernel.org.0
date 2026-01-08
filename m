Return-Path: <linux-fsdevel+bounces-72955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C72D066A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 23:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2AF6301D67E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 22:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578312D63F6;
	Thu,  8 Jan 2026 22:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfxHCk6E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776A5219EB
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 22:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767910763; cv=none; b=NrNZ67iiVVmsq5DOlIlRQnvwHn2lxroxJ7hcAXOy8fxrkrFnTegW1Msf0w6xRiNgTAarvBiDSmB9pRZ8Eb4JBYIoUmkdmXpniTB8XvtBP5zPa91t9kYLjXQr+Kk6qOOBRAJ3gjhDOrm8kbUxg6gfV90hRhIGdHy1nWWyTen3faw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767910763; c=relaxed/simple;
	bh=KCnLa2kuV+1R/JUzI8yPpmP8ataUaAPukImIX31c+lE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UF7g/QFoYvTkQlC01O3g484BRoWjPLN7z5q4Wg7XBBfB9YMnLAFxs+erl3UHBiFJSalMC8gCVi+mA8zkE0tCuPHv/+t2edGyUqSesvNab3x4PpBr/+fYTTSKzgsDPzXuzna2T20J/eQeFT59vFWUEUO1ekpMvmhTsv6uquc27tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfxHCk6E; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4eda26a04bfso41915631cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 14:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767910761; x=1768515561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cDcjTYFQT1KJ9Dln0qTOTRDNw12jrWSy5gdHcinrdg=;
        b=NfxHCk6EVP3g0qFLGhFwudrswYgaVi+zGNu9HB4hSzcPS5jwLuoygPBJzKBiqWZEc8
         BwsBFhM1BaKUZUY635alwo6ii/vf2JAaiKiS712wnz560l15d8JDU5pfkRqjVimUin2F
         9ZjMnAGSxqPsqrO8iwzQqVekv6hi3uev4QBaQ3q4AVGDjUOL+9tNkTLK39pnLEGHNt8K
         Ez2fSWVrgsSKCCDyRy+hZgamx2lQgwAfAIwl1WcmwPmMcx0bFzYxt8eUK7juNWct7vKd
         79hOL6qioP6d32THjirhD6Xg2DUwqxKdBedGxRQkp9Lk3IZHpFvWwepDrMuuUfX8UpMH
         K5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767910761; x=1768515561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3cDcjTYFQT1KJ9Dln0qTOTRDNw12jrWSy5gdHcinrdg=;
        b=nc9W6xDR4c6t2qMVFgE+mfguQSZJU4R9cH4HPksB5pnDP1gjzxs3wRcImNwn3H7Y8Z
         7mNXtn3pDcP5YCZIm/okjGnqSMa4iWqea8AfLft/zIPMkgMN4lfPgtwQdGcpSk+tW+m9
         PsPMzh5Hp0QhFOVGxapN/2rvKvipNUFPl7rsWrNmVrJO7jbEx4M1QL2vYX/WrDiiJ82N
         8k0KjodZCSdDe6vRfmFGKzsNIB39DcPpFjI7INSilb8fhegS/1Es/I90HKxtYsCyycOM
         DDJRlGM/QfcUhO5PF6fAk018GpUcR/K9NRPDE5Uw4Jdf/0jN8WBw6Ztfwxk3zFIHx2uT
         +kCA==
X-Forwarded-Encrypted: i=1; AJvYcCWIR159uF7D6u8W/DtZ6yrCCG02ZPyFvmIGR0wPXIuABCb0N/NRTgAIj+KKl5X3Ircu8R5I3U/4YX+Yfuy1@vger.kernel.org
X-Gm-Message-State: AOJu0YxdtTY132l7b1TiHTtkipFTavSf3iE5VYjGOa4ncUrfzoG0OhQL
	RdD1yPbgQERa6rHwIwFzcLtroH5D+9N9L2PO1YpHKwX5477okXVQfpBMAj3jZX9XnNW2ejE051j
	PyFOFrK0Qy+b1pPgixhdMa3Tpz7hWqeQ=
X-Gm-Gg: AY/fxX76w58ZCrCdevdydRVfamfBGDLG+0SsUPi5d4Ir2L5ryB4kXjR7GJYSIwqjo7U
	pd20KXiS0mKxrwmmbo5UaSiDYvltDwAFh0V8ymY+e71NhZT6YjI++QpiAxrDcZDpT3rELED5Jk8
	/r3c05+0628qSSJPDnH8uQRoRhN1woKzVJzlOvJWnnpjUngI/O3iYILk0H0Ei7KKhPQEsNk+Q/c
	fEyXCp1ILVr4JtwsmQAuwI9nErsBkhbg10eKDaa2xrZ0ETtlqjl0KBUzmjjG6g8M07jAqtDWh53
	qUrS
X-Google-Smtp-Source: AGHT+IEA3evSnmU+YhfAa3ZMXWHPub9Cil1bDNAXAJL99SwrhPSpKu7SfpIrUDN/qeooYScbkq8WoaBXhV5rdU49qmU=
X-Received: by 2002:a05:622a:13d4:b0:4ed:b94c:774a with SMTP id
 d75a77b69052e-4ffb48bb27fmr131737481cf.5.1767910761330; Thu, 08 Jan 2026
 14:19:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108-fuse-compounds-upstream-v3-0-8dc91ebf3740@ddn.com> <20260108-fuse-compounds-upstream-v3-3-8dc91ebf3740@ddn.com>
In-Reply-To: <20260108-fuse-compounds-upstream-v3-3-8dc91ebf3740@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 8 Jan 2026 14:19:10 -0800
X-Gm-Features: AQt7F2rApVWku-JNbhV5gYCE5Voy3itB_hThKYaGVZ6-9ChyxAFSMu9JbFdGXt8
Message-ID: <CAJnrk1Ynob-fqDUf_xrGkGwgj+=6kyhAB=qPVkKHW5ri5frsRQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 3/3] fuse: use the newly created helper functions
To: horst@birthelmer.com
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 6:23=E2=80=AFAM <horst@birthelmer.com> wrote:
>
> From: Horst Birthelmer <hbirthelmer@ddn.com>
>
> new helper functions are:
> - fuse_getattr_args_fill()
> - fuse_open_args_fill()
>
> Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
> ---
>  fs/fuse/dir.c  | 9 +--------
>  fs/fuse/file.c | 9 +--------
>  2 files changed, 2 insertions(+), 16 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 4b6b3d2758ff..ca8b69282c60 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1493,14 +1493,7 @@ static int fuse_do_getattr(struct mnt_idmap *idmap=
, struct inode *inode,
>                 inarg.getattr_flags |=3D FUSE_GETATTR_FH;
>                 inarg.fh =3D ff->fh;
>         }
> -       args.opcode =3D FUSE_GETATTR;
> -       args.nodeid =3D get_node_id(inode);
> -       args.in_numargs =3D 1;
> -       args.in_args[0].size =3D sizeof(inarg);
> -       args.in_args[0].value =3D &inarg;
> -       args.out_numargs =3D 1;
> -       args.out_args[0].size =3D sizeof(outarg);
> -       args.out_args[0].value =3D &outarg;
> +       fuse_getattr_args_fill(&args, get_node_id(inode), &inarg, &outarg=
);
>         err =3D fuse_simple_request(fm, &args);
>         if (!err) {
>                 if (fuse_invalid_attr(&outarg.attr) ||
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 676f6bfde9f8..c0375b32967d 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -73,14 +73,7 @@ static int fuse_send_open(struct fuse_mount *fm, u64 n=
odeid,
>                 inarg.open_flags |=3D FUSE_OPEN_KILL_SUIDGID;
>         }
>
> -       args.opcode =3D opcode;
> -       args.nodeid =3D nodeid;
> -       args.in_numargs =3D 1;
> -       args.in_args[0].size =3D sizeof(inarg);
> -       args.in_args[0].value =3D &inarg;
> -       args.out_numargs =3D 1;
> -       args.out_args[0].size =3D sizeof(*outargp);
> -       args.out_args[0].value =3D outargp;
> +       fuse_open_args_fill(&args, nodeid, opcode, &inarg, outargp);
>
>         return fuse_simple_request(fm, &args);
>  }
>

This is a very minor nit but imo the split is a bit nicer if patch 2/3
is this patch with your helper changes:

+/*
+ * Helper function to initialize fuse_args for OPEN/OPENDIR operations
+ */
+void fuse_open_args_fill(struct fuse_args *args, u64 nodeid, int opcode,
+ struct fuse_open_in *inarg, struct fuse_open_out *outarg)
+{
+ args->opcode =3D opcode;
...
+}
+
+/*
+ * Helper function to initialize fuse_args for GETATTR operations
+ */
+void fuse_getattr_args_fill(struct fuse_args *args, u64 nodeid,
+     struct fuse_getattr_in *inarg,
+     struct fuse_attr_out *outarg)
+{
+ args->opcode =3D FUSE_GETATTR;
...
+}
+

and then patch 3 is your open+getattr changes. That way, it's easier
to see that the changes in this patch to fuse_do_getattr() and
fuse_send_open() have no functional changes in logic.


Thanks,
Joanne
> --
> 2.51.0
>

