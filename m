Return-Path: <linux-fsdevel+bounces-41245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B40A2CAE4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 19:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7796C16849F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 18:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E7819DF5B;
	Fri,  7 Feb 2025 18:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ignDLFdW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9191E175D5D;
	Fri,  7 Feb 2025 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738951801; cv=none; b=eDH2MNwhAmPOsd6Cs4anzGxXUS+Fevy5AtE84qa294kxEbmEfRO63/PTSEJ0tqqHTwjMr/PAutvVq0WXXiK1FXz1uTUPGgFPdJxsakWUWF9mkiOrvcstguf5AYv3kmmpzrVfLfs/2S6XltI/4AQEsGQINu6itEzJn2M+SEGcVwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738951801; c=relaxed/simple;
	bh=3p84+TNpTs9hVvq+uezcZNsAVMm6AOjf7N9evm/Hv4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g3j36tBdRHLSBW3b9MBBSaxMVQXSByvSusP4xt02AymUi9ovJ9ZH7xcgE9ZjL1p9k8+5gGxjXcv8KbwB3sK96kHHFudPrEI8fUeUWAWMGZKBdqIwNF6n15LN7N/Keko2sfLRGEIhSk5Rw9BgFdZuGbNOjuZbydeQD+acm+PWb5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ignDLFdW; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5de47cf93dfso1315867a12.2;
        Fri, 07 Feb 2025 10:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738951798; x=1739556598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQ+Q15GCXmblWLsKQgF2rbxE7ePZkLM7I/Hu6HkTf60=;
        b=ignDLFdWkW/WEaTUkK4rk4SqL5Q2kKZsaY/wGkOz/FOyVaJNXNcJxBX1UqC2/11wbQ
         yqFOEiGYRU05jrC6XvzPsjet2zHAl6K6ReqSzgwfqySGm1NH38aqKCZA2dOD5Q4BDuTK
         sHdrAdie0V4nVFKfK1QIq6jpPFUFsbPionfv1uK/VsV6qd2dC809npoQQwd53ifsitWH
         aZTSfULDu3S4L3Qh3Lmcb0eqkAe2uUI0Nat3c0o56kYBhgKIRrlxDmE0OV/2Enj+ds/k
         yP2ibPyDSUeHzVzWFzLtocoLy32A/HNMDMkpc79g5uTBC2jsgayZBoJG58aI0K6vrg3s
         xlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738951798; x=1739556598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQ+Q15GCXmblWLsKQgF2rbxE7ePZkLM7I/Hu6HkTf60=;
        b=i12CsQdq63FpuIr+haoOgDjSIhBfNhBRW1ysIfTbh6smwURbqsbAzlJb+SPWDeQeOJ
         urOn2RfBXTvq5+AlbunrN+tOZGS8JGh5CeRYrysnv5bgc4qrStTynN1cUGnveK1aYDWo
         uZCNF5hcIqX3glcbNVsQNPMPTwKjmkjXxp+vRHWC/YNfRf4zVWO/YSWgRJzUZU+FOFnx
         2PWWv8NwDcwxqDY0jSwa2Pi2uy3A+fwqThQbGhap8QDpdo3LnTYGy1daXQPqNi+JWNaV
         krclRB2WkKkpHMlbPHMzmBfl25tYnTc14o8QuuqprYgjuIW67IiyRAKnWSSDCbweoMz+
         O8sA==
X-Forwarded-Encrypted: i=1; AJvYcCWO+SvBwbsYMRN2ArrQljRmDbKyQOLmKOF2P5PmpvtO94IggnOmxbNRYDgBUxRb44vQO5uSKf6MKOv8mPxr@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/82yKQn4sJtOPANdGPwmImA5ugFBIqQM9VS8cC1hSigXMnHZ9
	mhpdVPFGTUzFLEs9pRUHZixK1DD9foZcT56tFExaMEG0/tMsDjoF+ZLeKJ7uMQcOJywIGpaclqa
	bakPG26TDdM8DjheaIh4cQGKM+go=
X-Gm-Gg: ASbGncsI+jENUoYlxAxlAn9jcHw1BRE2TUp/FJQNRggg0GFSH57OlXaGC5Vw2M11BDk
	h/GnrbI+lKqHcfEivw4nhwQ/LWZ/z6qZXccCHNp5pgBu4Y5cb2P9hrfdo2sZYuoaplXk3JJuO
X-Google-Smtp-Source: AGHT+IHce2RpV3DQ2Uq47tvg04sRoLbOIDQKdgIKggM9XFuItNnEKOSZF+EUBeY/qzD54nnfIS2exfU1+PhdfGpqGPE=
X-Received: by 2002:a05:6402:e83:b0:5dc:d8d2:e38f with SMTP id
 4fb4d7f45d1cf-5de450839f3mr11654587a12.31.1738951797404; Fri, 07 Feb 2025
 10:09:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207-work-overlayfs-v1-0-611976e73373@kernel.org>
 <20250207-work-overlayfs-v1-1-611976e73373@kernel.org> <CAOQ4uxg4pCP9EL20vO=X1rwkJ8gVXXzeSDvsxkretH_3hm_nJg@mail.gmail.com>
In-Reply-To: <CAOQ4uxg4pCP9EL20vO=X1rwkJ8gVXXzeSDvsxkretH_3hm_nJg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 7 Feb 2025 19:09:44 +0100
X-Gm-Features: AWEUYZkKJgv3G72V3-mv3Z8LuBz0FCb0pcCEgUWWWVwq7LScqtfRYok1tw86bg4
Message-ID: <CAOQ4uxhM5j-99ckPzyubdzg66_WBo_39b4_RJKGfVneqnNbxtA@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs: support O_PATH fds with FSCONFIG_SET_FD
To: Christian Brauner <brauner@kernel.org>
Cc: linux-unionfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, 
	Mike Baynton <mike@mbaynton.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 6:39=E2=80=AFPM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> On Fri, Feb 7, 2025 at 4:46=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
> >
> > Let FSCONFIG_SET_FD handle O_PATH file descriptors. This is particularl=
y
> > useful in the context of overlayfs where layers can be specified via
> > file descriptors instead of paths. But userspace must currently use
> > non-O_PATH file desriptors which is often pointless especially if
> > the file descriptors have been created via open_tree(OPEN_TREE_CLONE).
> >
>
> Shall we?
> Fixes: a08557d19ef41 ("ovl: specify layers via file descriptors")
>
> I think that was the intention of the API and we are not far enough to fi=
x
> it in 6.12.y.
>

Oh it's not in 6.12. it's in 6.13, so less important to backport I guess.

Thanks,
Amir.

>
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/fs_parser.c             | 12 +++++++-----
> >  fs/fsopen.c                |  7 +++++--
> >  fs/overlayfs/params.c      | 10 ++++++----
> >  include/linux/fs_context.h |  1 +
> >  include/linux/fs_parser.h  |  6 +++---
> >  5 files changed, 22 insertions(+), 14 deletions(-)
> >
> > diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> > index e635a81e17d9..35aaea224007 100644
> > --- a/fs/fs_parser.c
> > +++ b/fs/fs_parser.c
> > @@ -310,15 +310,17 @@ int fs_param_is_fd(struct p_log *log, const struc=
t fs_parameter_spec *p,
> >  }
> >  EXPORT_SYMBOL(fs_param_is_fd);
> >
> > -int fs_param_is_file_or_string(struct p_log *log,
> > -                              const struct fs_parameter_spec *p,
> > -                              struct fs_parameter *param,
> > -                              struct fs_parse_result *result)
> > +int fs_param_is_raw_file_or_string(struct p_log *log,
>
> Besides being too long of a helper name I do not think
> that it correctly reflects the spirit of the question.
>
> The arguments for overlayfs upperdir/workdir/lowerdir+/datadir+
> need to be *a path*, either a path string, or an O_PATH fd and
> maybe later on also dirfd+name.
>
> I imagine that if other filesystems would want to use this parser
> helper they would need it for the same purpose.
>
> Can we maybe come up with a name that better reflects that
> intention?
>
> > +                                  const struct fs_parameter_spec *p,
> > +                                  struct fs_parameter *param,
> > +                                  struct fs_parse_result *result)
> >  {
> >         switch (param->type) {
> >         case fs_value_is_string:
> >                 return fs_param_is_string(log, p, param, result);
> >         case fs_value_is_file:
> > +               fallthrough;
> > +       case fs_value_is_raw_file:
> >                 result->uint_32 =3D param->dirfd;
> >                 if (result->uint_32 <=3D INT_MAX)
> >                         return 0;
> > @@ -328,7 +330,7 @@ int fs_param_is_file_or_string(struct p_log *log,
> >         }
> >         return fs_param_bad_value(log, param);
> >  }
> > -EXPORT_SYMBOL(fs_param_is_file_or_string);
> > +EXPORT_SYMBOL(fs_param_is_raw_file_or_string);
> >
> >  int fs_param_is_uid(struct p_log *log, const struct fs_parameter_spec =
*p,
> >                     struct fs_parameter *param, struct fs_parse_result =
*result)
> > diff --git a/fs/fsopen.c b/fs/fsopen.c
> > index 094a7f510edf..3b5fc9f1f774 100644
> > --- a/fs/fsopen.c
> > +++ b/fs/fsopen.c
> > @@ -451,11 +451,14 @@ SYSCALL_DEFINE5(fsconfig,
> >                 param.size =3D strlen(param.name->name);
> >                 break;
> >         case FSCONFIG_SET_FD:
> > -               param.type =3D fs_value_is_file;
> >                 ret =3D -EBADF;
> > -               param.file =3D fget(aux);
> > +               param.file =3D fget_raw(aux);
> >                 if (!param.file)
> >                         goto out_key;
> > +               if (param.file->f_mode & FMODE_PATH)
> > +                       param.type =3D fs_value_is_raw_file;
> > +               else
> > +                       param.type =3D fs_value_is_file;
> >                 param.dirfd =3D aux;
>
> Here it even shouts more to me that the distinction is not needed.
>
> If the parameter would be defined as
> fsparam_path_description("workdir",   Opt_workdir),
> and we set param.type =3D fs_value_is_path_fd;
> unconditional to f_mode & FMODE_PATH, because we
> do not care if fd is O_PATH or not for the purpose of this parameter
> we only care that the parameter *can* be resolved to a path
> and *how* to resolve it to a path, and the answer to those questions
> does not change depending on _mode & FMODE_PATH.
>
> I admit that that's a very long rant about a mostly meaningless nuance,
> and I was also not very involved in the development of the new mount API
> so there may be things about it that I don't understand, so feel free to
> dismiss this rant and add my Ack if you do not share my concerns.
>
> Thanks,
> Amir.

