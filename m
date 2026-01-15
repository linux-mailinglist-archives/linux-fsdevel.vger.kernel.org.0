Return-Path: <linux-fsdevel+bounces-73867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BB0D22256
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 03:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57367303C80F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 02:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9674426ED25;
	Thu, 15 Jan 2026 02:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpD4vkM2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C14023ABBF
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 02:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768444682; cv=none; b=Sgg2SG5oYmDI3ts8yQlEw28+FIWzY0UBNMXmvPOeV4bSeOVZRdFHvNjMT+WlxcyW/sf3m2UmviCradDrvZ41esKUCcI0YxthAqLXVgeUNJ1bkr4d584ozED1SU7ej41bPE3dlSHSaPWh2aSYH43GCWf3OUDKOat2AMCPuX4S76c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768444682; c=relaxed/simple;
	bh=ZyTV8v3kJsnWNNopSIKvamZVH6nq3QsgjYdvF1pX7HI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SaipOQeO0OW77Z3Mtu2eMY8PBY7Bec+7cLhHdzjoffXjccv/HBGHfrQWo8BZXHU2zlw9bldNmjRd2dGxEOdWQMjtQ1MwjZ60ljWqTZaj9mE8Mfz3zeK75APcWJQTIVBu/G/RkTCeD75yrFK92qFsezWk3j8GdQmF0FAb7IS0n/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpD4vkM2; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50146fcf927so12587041cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 18:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768444679; x=1769049479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpTqbj9eVEKEyMAUgGaXErqkh+1ZH5X37iNQJIuNlIM=;
        b=FpD4vkM2VoofVkoUzJJCpmGb+q9oIeFJpV/YfogrQai/y7NNopGx0nzxUws/0oGsT4
         +Wi/7Rdu+dV7D7CnhUowRDsgVlt4D9YS8Lp2fJ3QOb+UUVC8oXutZ+USw8UGSZlonnP7
         wqkHbIVdScuKjlATzHCUmEatBaRTi33tsuXeCGyUpEmr/cPwX7eCxocx/GOgDwk6GrVQ
         TgYtwco+hOSIVJbQnvikJh0nObcJ1187Q08kyPOFtJQs6ZIbWda8weCJ9RQVe0y4ag/a
         yiPEOugH3/cdZB5tP4cmZ4qf6a7yQUU6CQnyYltgwjIKMdjmZljSf6OpagqbtRjxXc8j
         CAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768444679; x=1769049479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tpTqbj9eVEKEyMAUgGaXErqkh+1ZH5X37iNQJIuNlIM=;
        b=l/VF8Rw43DES1lG5m6iY0Rpv4OyX52Bbs54cIeSA+PKbTHpnhi5t0LC9TegLB0AnEu
         g+Lt2napJwVAiXc9aJiG0JyVK+/REIUwkdlBNGEm7vkw3i9a3nh93X/XyRZ2p/52uRvk
         i9cjH75740i7HlysymVG/Gsx0htpzYbypn8Ggn9Uv9SMS+b0mGTgcNlO8DnzAhJ3fLFR
         SAD6UGsTBptb4biFaGFG+JnJZ0XuUWaVsGeWVCB908/z56ewKRPVgZzQytS5lQ1kDDNk
         T3mEXDZmIu7Sgvw+TcjVZQHMdFv/ORfelosAhNqPDRfaPlAhlzj2g3uoIjbZaWewsIE4
         i5rg==
X-Forwarded-Encrypted: i=1; AJvYcCX8uIgByfp5u8op17cSkUWw5zcZPwEQy39Mo3xyo2XSlPZiL3GpvfxjqntoJ5GyMe2Mtn8Gpe+VxgZfGUAL@vger.kernel.org
X-Gm-Message-State: AOJu0YxutGP3O55zHdtx8oc6S5cFGjK/fpj4jDrKOipcF+WsN99oYNrF
	zTIq63U2Nx8RvM70nyhS6uKHCxBAO5I4RA1eKhi86NZpI2tnx16iklTmxdfHacDp5P1/ZIGXbYj
	fOT0PELM7RgQbIgpw2rCNEj567XUtGnAG1mmMOfU=
X-Gm-Gg: AY/fxX4dRFln2sv/rIf1PGFomae3q11M3iy5E74FA3w5s+QGP/dH4+3K4IyILHIxsuB
	3LsaFRsgtGmIj909uZHxay98zd4DRWXjwEp25o8HrbwW5op9V1A3z+MVmaEuaDoYg4fr8J1RQr2
	m85WoLLbp+i8QQkN8+ojxd9UjL0jGizDEHD1ywcdTxxn1c2036Ot5XtGYpScCXf7PQ/UAAf7ErM
	pOrzabq9Z8hpTFMoLMhcoqDzWoXiWKgV5lz4sn/1EPnegQpFAeRzCNvV+AWehbkbEKA1g==
X-Received: by 2002:a05:622a:2443:b0:4ff:82aa:d845 with SMTP id
 d75a77b69052e-5019f901a4fmr25448841cf.41.1768444679300; Wed, 14 Jan 2026
 18:37:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109-fuse-compounds-upstream-v4-0-0d3b82a4666f@ddn.com> <20260109-fuse-compounds-upstream-v4-2-0d3b82a4666f@ddn.com>
In-Reply-To: <20260109-fuse-compounds-upstream-v4-2-0d3b82a4666f@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 14 Jan 2026 18:37:48 -0800
X-Gm-Features: AZwV_QhdtDkaBozF4fWC8yra3ouwZeWjSJVoTrW0FeTagjijSR6Ytel8fT2wA9E
Message-ID: <CAJnrk1aS=zJvBNwUFmM+vos36i3nY2UaZzZv96vDikuHr8SLqA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] fuse: create helper functions for filling in fuse
 args for open and getattr
To: Horst Birthelmer <horst@birthelmer.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 10:27=E2=80=AFAM Horst Birthelmer <horst@birthelmer.=
com> wrote:
>
> From: Horst Birthelmer <hbirthelmer@ddn.com>
>
> create fuse_getattr_args_fill() and fuse_open_args_fill() to fill in
> the parameters for the open and getattr calls.
>
> This is in preparation for implementing open+getattr and does not
> represent any functional change.
>
> Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
> ---
>  fs/fuse/dir.c    |  9 +--------
>  fs/fuse/file.c   | 42 ++++++++++++++++++++++++++++++++++--------
>  fs/fuse/fuse_i.h |  8 ++++++++
>  3 files changed, 43 insertions(+), 16 deletions(-)
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
> index 01bc894e9c2b..53744559455d 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -23,6 +23,39 @@
>  #include <linux/task_io_accounting_ops.h>
>  #include <linux/iomap.h>
>
> +/*
> + * Helper function to initialize fuse_args for OPEN/OPENDIR operations
> + */
> +void fuse_open_args_fill(struct fuse_args *args, u64 nodeid, int opcode,
> +                        struct fuse_open_in *inarg, struct fuse_open_out=
 *outarg)
> +{
> +       args->opcode =3D opcode;
> +       args->nodeid =3D nodeid;
> +       args->in_numargs =3D 1;
> +       args->in_args[0].size =3D sizeof(*inarg);
> +       args->in_args[0].value =3D inarg;
> +       args->out_numargs =3D 1;
> +       args->out_args[0].size =3D sizeof(*outarg);
> +       args->out_args[0].value =3D outarg;
> +}
> +
> +/*
> + * Helper function to initialize fuse_args for GETATTR operations
> + */
> +void fuse_getattr_args_fill(struct fuse_args *args, u64 nodeid,
> +                            struct fuse_getattr_in *inarg,
> +                            struct fuse_attr_out *outarg)
> +{
> +       args->opcode =3D FUSE_GETATTR;
> +       args->nodeid =3D nodeid;
> +       args->in_numargs =3D 1;
> +       args->in_args[0].size =3D sizeof(*inarg);
> +       args->in_args[0].value =3D inarg;
> +       args->out_numargs =3D 1;
> +       args->out_args[0].size =3D sizeof(*outarg);
> +       args->out_args[0].value =3D outarg;
> +}

sorry to be so nitpicky but I think we should move this to the
fuse/dir.c file since that's where the main fuse_do_getattr() function
lives

> +
>  static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
>                           unsigned int open_flags, int opcode,
>                           struct fuse_open_out *outargp)
> @@ -40,14 +73,7 @@ static int fuse_send_open(struct fuse_mount *fm, u64 n=
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
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 6dddbe2b027b..98ea41f76623 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1179,6 +1179,14 @@ struct fuse_io_args {
>  void fuse_read_args_fill(struct fuse_io_args *ia, struct file *file, lof=
f_t pos,
>                          size_t count, int opcode);
>
> +/*
> + * Helper functions to initialize fuse_args for common operations
> + */
> +void fuse_open_args_fill(struct fuse_args *args, u64 nodeid, int opcode,
> +                        struct fuse_open_in *inarg, struct fuse_open_out=
 *outarg);

I don't think we need this for fuse_open_args_fill() here since it'll
be used only in the scope of fuse/file.c

Thanks,
Joanne

> +void fuse_getattr_args_fill(struct fuse_args *args, u64 nodeid,
> +                           struct fuse_getattr_in *inarg,
> +                           struct fuse_attr_out *outarg);
>
>  struct fuse_file *fuse_file_alloc(struct fuse_mount *fm, bool release);
>  void fuse_file_free(struct fuse_file *ff);
>
> --
> 2.51.0
>

