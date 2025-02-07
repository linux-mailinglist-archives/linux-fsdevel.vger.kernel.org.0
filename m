Return-Path: <linux-fsdevel+bounces-41243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB40A2CA65
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 18:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1FE5188D183
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 17:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2310E19992D;
	Fri,  7 Feb 2025 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cm9nHzOL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7722A1D8;
	Fri,  7 Feb 2025 17:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738949964; cv=none; b=qFUWo13T0IWW3Hq+PmKwI5vhfp/39MJAXfidZqWz6bs5uaLZFCFxFn8fdwUKkYBdSz49Z/NwxetRJs2ogP7ifYDTjdZHmknBsoaswBTMu7VJonbq9NY09khYjobirl7Mnh3F1UL8MHkXCzoSD48kkGrkdSz+48QWLWwEsgzLBOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738949964; c=relaxed/simple;
	bh=fSsrW3H7Vu3OL2dcvZSUx1bgKcsMa8O8hWiJVthrgEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IkWL5OAimm5AmAKAV1Bjg4c47w+6kR0Wj6C2/Vba3Eym9CXI2sjdooZ1MVdYig9pP6QWcfMwhJlAbA1pLCtOWkdGe64bElZAMhR5fyUOWmtylL7a0WsDpqU1vrnfSBGGkcqIeR8twUDIJ8YZ9A6FOLkcnlalgPe/IcOLU1AETfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cm9nHzOL; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5dcef33eeceso4245271a12.2;
        Fri, 07 Feb 2025 09:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738949961; x=1739554761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHG9z5ZzVOBTfLJT1jahvgsFI0hw4A7Oh2qiZG7sPow=;
        b=cm9nHzOLE0ohSCQi5QR5cdNrBr9U8xS8FxCepp0ui8YSIDkeCYyuOE8LzLB3mC3U21
         sErLe3Ycrv6K+uh0/pbwYhlGUyDUsC4IxFj4XwiFr6Fp1fEh8FJDusodgVrLUsVaGMs/
         5ilDxNmd1+8N4IlzeRA9uDI7lgxSrBVa5DePMgbVvLbbc36dATbMI+SNj/XMn4luMake
         rkJ8aJth/tFhoMAI69VFnYScP7rgHZJEUMzKOLWseBfwMzzbMUTh6mCFrXywO7yvvvKH
         DHdjbw/SGcEElwtxVO43UaEGqZr/ThF3FVD1E/deExfnMcu7qOHPgUMaVi4a1eynChKd
         ql/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738949961; x=1739554761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHG9z5ZzVOBTfLJT1jahvgsFI0hw4A7Oh2qiZG7sPow=;
        b=Il9OPQ6TiP6TeXevJEDjuEbOdsGtsafMAVMSyJRha1drqHrVFWrozDXbFpF9/TCgXV
         BH+FJXtnMzV9g8pM6NhlcuJPGuOG/ft6T4+pW0+igJr1B1f0FOBPGHw9v2bjDfBN2ZpM
         VEWM4AxEh7HuVJ0h3DVAV7vD35MbqhOTNPKDqfc6P7LOho4EqDjGeeMi8HDCFQMwSDOl
         ZoihT/1az/K8AIlw/hQGUhGN71LGqoaEwp+zSx1TFj4HiMDSw4mTKmHjyVTb3b0dqU2X
         ijdLJsyWWQRgCJdL4pdHM1DYeKrofpbycLJSTZNkwKPt+T//XAfZYhtgxw9A7mbkhG4/
         939Q==
X-Forwarded-Encrypted: i=1; AJvYcCXr/Xd7AXCc3rfrwfQVEVrqAVNRxhp/MVapRxupORaO2Pulx2wnwrBZVgK2N4ItQ3uDSa5xdlGO2pELQNNU@vger.kernel.org
X-Gm-Message-State: AOJu0YwmJk7in8s7mUM+WMZ5lH5KRvDsvY9LT5a44R55fXJ9+Zosh98k
	1vpGJEgkGrmEGCUxtsjXqmwsxE+qWuIFmewmtCOvQo7nD6Yit4SrB48JHXGp9n93DY7t4l/8ZYr
	fLe8PcVUxP/KhrFV1XNIH7rgtEfI=
X-Gm-Gg: ASbGncv0j2PK3vPLE5DEtdj1ufFtmraHNGvn/qYjGzHaAdHK3pyEF5//xW6o05cWWXq
	81bPPQH4qeFfrUr1qHshSoilkgJGNvVo6OtAMnsutld/b7G0meQ5TfkcYj16GqyvJA+x/6pN3
X-Google-Smtp-Source: AGHT+IEdVhxCv22ighc4yGvpCgkER+K18kaOwlP0B5XuFzqahU9AuWY9scYKYx+sCpIt4+kJxvN8SK/UgsMkXgKHkjQ=
X-Received: by 2002:a05:6402:40cb:b0:5dc:d43c:3a1b with SMTP id
 4fb4d7f45d1cf-5de450aa4a6mr4283442a12.20.1738949960665; Fri, 07 Feb 2025
 09:39:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207-work-overlayfs-v1-0-611976e73373@kernel.org> <20250207-work-overlayfs-v1-1-611976e73373@kernel.org>
In-Reply-To: <20250207-work-overlayfs-v1-1-611976e73373@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 7 Feb 2025 18:39:09 +0100
X-Gm-Features: AWEUYZmj3im7s71GjsSKCJChT8TKy21vngM7RaP9uzyrb0aFc9kialfuHdUdIGk
Message-ID: <CAOQ4uxg4pCP9EL20vO=X1rwkJ8gVXXzeSDvsxkretH_3hm_nJg@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs: support O_PATH fds with FSCONFIG_SET_FD
To: Christian Brauner <brauner@kernel.org>
Cc: linux-unionfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, 
	Mike Baynton <mike@mbaynton.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 4:46=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> Let FSCONFIG_SET_FD handle O_PATH file descriptors. This is particularly
> useful in the context of overlayfs where layers can be specified via
> file descriptors instead of paths. But userspace must currently use
> non-O_PATH file desriptors which is often pointless especially if
> the file descriptors have been created via open_tree(OPEN_TREE_CLONE).
>

Shall we?
Fixes: a08557d19ef41 ("ovl: specify layers via file descriptors")

I think that was the intention of the API and we are not far enough to fix
it in 6.12.y.


> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/fs_parser.c             | 12 +++++++-----
>  fs/fsopen.c                |  7 +++++--
>  fs/overlayfs/params.c      | 10 ++++++----
>  include/linux/fs_context.h |  1 +
>  include/linux/fs_parser.h  |  6 +++---
>  5 files changed, 22 insertions(+), 14 deletions(-)
>
> diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> index e635a81e17d9..35aaea224007 100644
> --- a/fs/fs_parser.c
> +++ b/fs/fs_parser.c
> @@ -310,15 +310,17 @@ int fs_param_is_fd(struct p_log *log, const struct =
fs_parameter_spec *p,
>  }
>  EXPORT_SYMBOL(fs_param_is_fd);
>
> -int fs_param_is_file_or_string(struct p_log *log,
> -                              const struct fs_parameter_spec *p,
> -                              struct fs_parameter *param,
> -                              struct fs_parse_result *result)
> +int fs_param_is_raw_file_or_string(struct p_log *log,

Besides being too long of a helper name I do not think
that it correctly reflects the spirit of the question.

The arguments for overlayfs upperdir/workdir/lowerdir+/datadir+
need to be *a path*, either a path string, or an O_PATH fd and
maybe later on also dirfd+name.

I imagine that if other filesystems would want to use this parser
helper they would need it for the same purpose.

Can we maybe come up with a name that better reflects that
intention?

> +                                  const struct fs_parameter_spec *p,
> +                                  struct fs_parameter *param,
> +                                  struct fs_parse_result *result)
>  {
>         switch (param->type) {
>         case fs_value_is_string:
>                 return fs_param_is_string(log, p, param, result);
>         case fs_value_is_file:
> +               fallthrough;
> +       case fs_value_is_raw_file:
>                 result->uint_32 =3D param->dirfd;
>                 if (result->uint_32 <=3D INT_MAX)
>                         return 0;
> @@ -328,7 +330,7 @@ int fs_param_is_file_or_string(struct p_log *log,
>         }
>         return fs_param_bad_value(log, param);
>  }
> -EXPORT_SYMBOL(fs_param_is_file_or_string);
> +EXPORT_SYMBOL(fs_param_is_raw_file_or_string);
>
>  int fs_param_is_uid(struct p_log *log, const struct fs_parameter_spec *p=
,
>                     struct fs_parameter *param, struct fs_parse_result *r=
esult)
> diff --git a/fs/fsopen.c b/fs/fsopen.c
> index 094a7f510edf..3b5fc9f1f774 100644
> --- a/fs/fsopen.c
> +++ b/fs/fsopen.c
> @@ -451,11 +451,14 @@ SYSCALL_DEFINE5(fsconfig,
>                 param.size =3D strlen(param.name->name);
>                 break;
>         case FSCONFIG_SET_FD:
> -               param.type =3D fs_value_is_file;
>                 ret =3D -EBADF;
> -               param.file =3D fget(aux);
> +               param.file =3D fget_raw(aux);
>                 if (!param.file)
>                         goto out_key;
> +               if (param.file->f_mode & FMODE_PATH)
> +                       param.type =3D fs_value_is_raw_file;
> +               else
> +                       param.type =3D fs_value_is_file;
>                 param.dirfd =3D aux;

Here it even shouts more to me that the distinction is not needed.

If the parameter would be defined as
fsparam_path_description("workdir",   Opt_workdir),
and we set param.type =3D fs_value_is_path_fd;
unconditional to f_mode & FMODE_PATH, because we
do not care if fd is O_PATH or not for the purpose of this parameter
we only care that the parameter *can* be resolved to a path
and *how* to resolve it to a path, and the answer to those questions
does not change depending on _mode & FMODE_PATH.

I admit that that's a very long rant about a mostly meaningless nuance,
and I was also not very involved in the development of the new mount API
so there may be things about it that I don't understand, so feel free to
dismiss this rant and add my Ack if you do not share my concerns.

Thanks,
Amir.

