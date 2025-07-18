Return-Path: <linux-fsdevel+bounces-55432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B95B0A52C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 15:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3C35657D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 13:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F872DC358;
	Fri, 18 Jul 2025 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLeVHKom"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3E72DC342
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752845320; cv=none; b=S9G7Amai+5F6MaabuD66L9pvnSwsKO/cLcC3A9WWz1GrOa1d3mqAWjUHLBcHi4SHM+OGeeh8k7qYH2R+C28cIx+CIK2ObN6mzT5S0wiE+J//T+uY33fqEB2N/7Bim2OzmdHNrkp95XtCqEr4fChbhyyVmv013CHxCoE4rXX4pV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752845320; c=relaxed/simple;
	bh=TSE2xJhPwVervQj+SsummOmFJfXfd/oyKItN8M0ZB3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RYP6IyKsB0NgBpBL8nVz51Lleqh66u4jggCyTRV14kKNCRdCXEidiRkVvTcrpuYueyPUDsR69oCopOUF/vs+0rgcWUUr8qKwCjzLI0AbAS3OXIV8XZRUlBt1H2nO3jj8PHmiOaDFjt76/DyaWG1MuCiXtxpqdIL5jzVyqqEGCW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLeVHKom; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae04d3d63e6so387851466b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 06:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752845317; x=1753450117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ppwzoS1jE1FgELAyRnTTs/mOp2qdKTZRscp428XPo8=;
        b=XLeVHKomJDIesGPSVW7LerRzo7CvCYo80kr7iBIQPoquzhd2QB7a8Qihf/+9tD9WQX
         LXPvL6SGXoQcPl2jMC3jX2Ke8FqYoWH851+v3N7BnKWpAYSfKkNpQKNDZQzzRktT0RL4
         zT8fu3lKR2GWIK/c6UwmYRor0TEnfkObjVp+ut7aZ3qzlo6rdCFlq0P5fLhktMvKeE/H
         aXKKBx/afWVIXWAO3uFt9E4uNEzP958KxlD58u5rd0n5iOA/ele/7owrpFutY8phb8Mf
         SaSjM+Z/MIPjW4mjjmOfVvhOJSfdEDz0GgxFkYVIpEhnalbEpq9olhQ9ItnELj/vVA7R
         0EgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752845317; x=1753450117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ppwzoS1jE1FgELAyRnTTs/mOp2qdKTZRscp428XPo8=;
        b=UuAhqV8HHqdUAEc22oIQLsfnns43ccmKD5NkAwhnr3dS1WPVykSB16k/b6P0RRjVwZ
         aGr4QDfRxlKTzpsUDHrGanIGvbukcP8jio5UCX0RFwg9siLkWF/aaiChaH/9D7IaS8H9
         dJllDT4HH/wWjRBBfewSoDAHod2J+MmeO8XqlhW5T79UMd+3ZJS3ZLvIn+b3LbkPfOYi
         kRjUk4a/+RJqWxmNkW/Ic0/pqQEEaHG1c4q0UKnk5xr2mFm5rz9+qPWdAzlrUk3smV3T
         1JXjYjrhxWoNLmCeDwdiUJQ+5NWrnZ0ECgOXo0yhHBMfR5TAudx1ndveKsxuq7BfmmfE
         sWhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWW9pJhm8tlZgL3OV33/qewhi0eFGzn3P1N68o16+zBkVNw1l4jqUn3eaqpPIc13yzFEqirIWPGLTJLORkV@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9HZubT4rdhsjagB0oMGRH15pRtduFzhkHeVU6MrIKfoUs5ZQL
	V5Re469w8xfwmnK5Zg0oD6XkAjXgWKrIK7P4tMfSO+WqCEZzsFQCdA3n0Nn79QvKg8vSKO4HE6a
	jjhFEVqHVai7Gvcl6XMOwYpcYXzCIQ2I=
X-Gm-Gg: ASbGncsju7voM3DPR8EqA+NRvqcIy6NQm6waA81x7LD2ZmREfyUngGssVg3nHMjsvzJ
	cAW0+ufk5AJIXG5VG0Fz4Nqa/s9QNiVyPvuTfNyptXoHDy1gIe7GUssC4W8eu7mqCVuNAMKHteW
	30QFGZMarOlO3JQjp+FlIaogX41KUvBZokFZnQPacCL2lWFvybgiMzfoT9Bts1Wp3mfq7y0xZQZ
	MPWlPo=
X-Google-Smtp-Source: AGHT+IEITQZpAwBXCqCpzPLNMUXtEshpGOKDBXPWzQ1ENQv+EYErOus6R+wmicE70FWiXjo9Jctq+JIqvIiCbIs3uDo=
X-Received: by 2002:a17:906:d261:b0:ad8:87a0:62aa with SMTP id
 a640c23a62f3a-ae9cde5aa53mr1025927366b.27.1752845316800; Fri, 18 Jul 2025
 06:28:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175279460363.714831.9608375779453686904.stgit@frogsfrogsfrogs> <175279460430.714831.6251867847811735740.stgit@frogsfrogsfrogs>
In-Reply-To: <175279460430.714831.6251867847811735740.stgit@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 18 Jul 2025 15:28:25 +0200
X-Gm-Features: Ac12FXy46PuUyk-g9g1WC9QPPciMpV9HosGLdSq-z2fX5Tvf0VuY9NZoyNNMhY8
Message-ID: <CAOQ4uxjzU7o9j9LE1cQjGsKMpfrH0S2DGsrd=xGAqHyWbGFwng@mail.gmail.com>
Subject: Re: [PATCH 3/4] libfuse: add statx support to the lower level library
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: bschubert@ddn.com, John@groves.net, joannelkoong@gmail.com, 
	linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, neal@gompa.dev, 
	miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 1:39=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Add statx support to the lower level fuse library.

This looked familiar.
Merged 3 days ago:
https://github.com/libfuse/libfuse/pull/1026

>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  include/fuse_lowlevel.h |   37 ++++++++++++++++++
>  lib/fuse_lowlevel.c     |   97 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  lib/fuse_versionscript  |    2 +
>  3 files changed, 136 insertions(+)
>
>
> diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
> index 77685e433e4f7d..f4d62cee22870a 100644
> --- a/include/fuse_lowlevel.h
> +++ b/include/fuse_lowlevel.h
> @@ -1416,6 +1416,26 @@ struct fuse_lowlevel_ops {
>          * @param ino the inode number
>          */
>         void (*syncfs) (fuse_req_t req, fuse_ino_t ino);
> +
> +       /**
> +        * Fetch extended stat information about a file
> +        *
> +        * If this request is answered with an error code of ENOSYS, this=
 is
> +        * treated as a permanent failure, i.e. all future statx() reques=
ts
> +        * will fail with the same error code without being sent to the
> +        * filesystem process.
> +        *
> +        * Valid replies:
> +        *   fuse_reply_statx
> +        *   fuse_reply_err
> +        *
> +        * @param req request handle
> +        * @param statx_flags AT_STATX_* flags
> +        * @param statx_mask desired STATX_* attribute mask
> +        * @param fi file information
> +        */
> +       void (*statx) (fuse_req_t req, fuse_ino_t ino, uint32_t statx_fla=
gs,
> +                      uint32_t statx_mask, struct fuse_file_info *fi);
>  #endif /* FUSE_USE_VERSION >=3D 318 */
>  };
>
> @@ -1897,6 +1917,23 @@ int fuse_reply_iomap_begin(fuse_req_t req, const s=
truct fuse_iomap *read_iomap,
>   * @return zero for success, -errno for failure to send reply
>   */
>  int fuse_reply_iomap_config(fuse_req_t req, const struct fuse_iomap_conf=
ig *cfg);
> +
> +struct statx;
> +
> +/**
> + * Reply with statx attributes
> + *
> + * Possible requests:
> + *   statx
> + *
> + * @param req request handle
> + * @param statx the attributes
> + * @param size the size of the statx structure
> + * @param attr_timeout validity timeout (in seconds) for the attributes
> + * @return zero for success, -errno for failure to send reply
> + */
> +int fuse_reply_statx(fuse_req_t req, const struct statx *statx, size_t s=
ize,
> +                    double attr_timeout);
>  #endif /* FUSE_USE_VERSION >=3D 318 */
>
>  /* ----------------------------------------------------------- *
> diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
> index ec30ebc4cdd074..8eeb6a8547da91 100644
> --- a/lib/fuse_lowlevel.c
> +++ b/lib/fuse_lowlevel.c
> @@ -144,6 +144,43 @@ static void convert_attr(const struct fuse_setattr_i=
n *attr, struct stat *stbuf)
>         ST_CTIM_NSEC_SET(stbuf, attr->ctimensec);
>  }
>
> +#ifdef STATX_BASIC_STATS
> +static int convert_statx(struct fuse_statx *stbuf, const struct statx *s=
tx,
> +                        size_t size)
> +{
> +       if (sizeof(struct statx) !=3D size)
> +               return EOPNOTSUPP;
> +
> +       stbuf->mask =3D stx->stx_mask & (STATX_BASIC_STATS | STATX_BTIME)=
;
> +       stbuf->blksize          =3D stx->stx_blksize;
> +       stbuf->attributes       =3D stx->stx_attributes;
> +       stbuf->nlink            =3D stx->stx_nlink;
> +       stbuf->uid              =3D stx->stx_uid;
> +       stbuf->gid              =3D stx->stx_gid;
> +       stbuf->mode             =3D stx->stx_mode;
> +       stbuf->ino              =3D stx->stx_ino;
> +       stbuf->size             =3D stx->stx_size;
> +       stbuf->blocks           =3D stx->stx_blocks;
> +       stbuf->attributes_mask  =3D stx->stx_attributes_mask;
> +       stbuf->rdev_major       =3D stx->stx_rdev_major;
> +       stbuf->rdev_minor       =3D stx->stx_rdev_minor;
> +       stbuf->dev_major        =3D stx->stx_dev_major;
> +       stbuf->dev_minor        =3D stx->stx_dev_minor;
> +
> +       stbuf->atime.tv_sec     =3D stx->stx_atime.tv_sec;
> +       stbuf->btime.tv_sec     =3D stx->stx_btime.tv_sec;
> +       stbuf->ctime.tv_sec     =3D stx->stx_ctime.tv_sec;
> +       stbuf->mtime.tv_sec     =3D stx->stx_mtime.tv_sec;
> +
> +       stbuf->atime.tv_nsec    =3D stx->stx_atime.tv_nsec;
> +       stbuf->btime.tv_nsec    =3D stx->stx_btime.tv_nsec;
> +       stbuf->ctime.tv_nsec    =3D stx->stx_ctime.tv_nsec;
> +       stbuf->mtime.tv_nsec    =3D stx->stx_mtime.tv_nsec;
> +
> +       return 0;
> +}
> +#endif
> +

Why is this conversion not needed in the merged version?
What am I missing?

Thanks,
Amir.

>  static size_t iov_length(const struct iovec *iov, size_t count)
>  {
>         size_t seg;
> @@ -2653,6 +2690,64 @@ static void do_syncfs(fuse_req_t req, const fuse_i=
no_t nodeid, const void *inarg
>         _do_syncfs(req, nodeid, inarg, NULL);
>  }
>
> +#ifdef STATX_BASIC_STATS
> +int fuse_reply_statx(fuse_req_t req, const struct statx *statx, size_t s=
ize,
> +                    double attr_timeout)
> +{
> +       struct fuse_statx_out arg =3D {
> +               .attr_valid =3D calc_timeout_sec(attr_timeout),
> +               .attr_valid_nsec =3D calc_timeout_nsec(attr_timeout),
> +       };
> +
> +       int err =3D convert_statx(&arg.stat, statx, size);
> +       if (err) {
> +               fuse_reply_err(req, err);
> +               return err;
> +       }
> +
> +       return send_reply_ok(req, &arg, sizeof(arg));
> +}
> +
> +static void _do_statx(fuse_req_t req, const fuse_ino_t nodeid,
> +                     const void *op_in, const void *in_payload)
> +{
> +       (void)in_payload;
> +       const struct fuse_statx_in *arg =3D op_in;
> +       struct fuse_file_info *fip =3D NULL;
> +       struct fuse_file_info fi;
> +
> +       if (arg->getattr_flags & FUSE_GETATTR_FH) {
> +               memset(&fi, 0, sizeof(fi));
> +               fi.fh =3D arg->fh;
> +               fip =3D &fi;
> +       }
> +
> +       if (req->se->op.statx)
> +               req->se->op.statx(req, nodeid, arg->sx_flags, arg->sx_mas=
k,
> +                                 fip);
> +       else
> +               fuse_reply_err(req, ENOSYS);
> +}
> +#else
> +int fuse_reply_statx(fuse_req_t req, const struct statx *statx,
> +                    double attr_timeout)
> +{
> +       fuse_reply_err(req, ENOSYS);
> +       return -ENOSYS;
> +}
> +
> +static void _do_statx(fuse_req_t req, const fuse_ino_t nodeid,
> +                     const void *op_in, const void *in_payload)
> +{
> +       fuse_reply_err(req, ENOSYS);
> +}
> +#endif /* STATX_BASIC_STATS */
> +
> +static void do_statx(fuse_req_t req, const fuse_ino_t nodeid, const void=
 *inarg)
> +{
> +       _do_statx(req, nodeid, inarg, NULL);
> +}
> +
>  static bool want_flags_valid(uint64_t capable, uint64_t want)
>  {
>         uint64_t unknown_flags =3D want & (~capable);
> @@ -3627,6 +3722,7 @@ static struct {
>         [FUSE_COPY_FILE_RANGE] =3D { do_copy_file_range, "COPY_FILE_RANGE=
" },
>         [FUSE_LSEEK]       =3D { do_lseek,       "LSEEK"       },
>         [FUSE_SYNCFS]      =3D { do_syncfs,       "SYNCFS"     },
> +       [FUSE_STATX]       =3D { do_statx,       "STATX"       },
>         [FUSE_IOMAP_CONFIG]=3D { do_iomap_config, "IOMAP_CONFIG" },
>         [FUSE_IOMAP_BEGIN] =3D { do_iomap_begin,  "IOMAP_BEGIN" },
>         [FUSE_IOMAP_END]   =3D { do_iomap_end,    "IOMAP_END" },
> @@ -3686,6 +3782,7 @@ static struct {
>         [FUSE_COPY_FILE_RANGE]  =3D { _do_copy_file_range, "COPY_FILE_RAN=
GE" },
>         [FUSE_LSEEK]            =3D { _do_lseek,          "LSEEK" },
>         [FUSE_SYNCFS]           =3D { _do_syncfs,         "SYNCFS" },
> +       [FUSE_STATX]            =3D { _do_statx,          "STATX" },
>         [FUSE_IOMAP_CONFIG]     =3D { _do_iomap_config,   "IOMAP_CONFIG" =
},
>         [FUSE_IOMAP_BEGIN]      =3D { _do_iomap_begin,    "IOMAP_BEGIN" }=
,
>         [FUSE_IOMAP_END]        =3D { _do_iomap_end,      "IOMAP_END" },
> diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
> index dc9fa2428b5325..a67b1802770335 100644
> --- a/lib/fuse_versionscript
> +++ b/lib/fuse_versionscript
> @@ -223,6 +223,8 @@ FUSE_3.18 {
>                 fuse_reply_iomap_config;
>                 fuse_lowlevel_notify_iomap_upsert;
>                 fuse_lowlevel_notify_iomap_inval;
> +
> +               fuse_reply_statx;
>  } FUSE_3.17;
>
>  # Local Variables:
>
>

