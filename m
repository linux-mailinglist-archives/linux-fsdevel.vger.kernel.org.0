Return-Path: <linux-fsdevel+bounces-44948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDDEA6F038
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F317C18871BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 11:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A112254B1B;
	Tue, 25 Mar 2025 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qd3DzoOF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A68537E9;
	Tue, 25 Mar 2025 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742901228; cv=none; b=Sm+3MnugGm768It4I+NFQFasX9aSMfexw5IaNIqpBra6eCikLBU0PJDwDT4he/RvWKJB3KQhAfrlWSomrI7yNsTjRElN1jVvXBcFehhN0QJZd0ZXpNEZsZsNb0kMH750ZTBEfpvb36vRs6CFwBhZ/g5TBgOpsb3tOAFyhChvHio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742901228; c=relaxed/simple;
	bh=oiLSwYFjiUis8e72W884YKrNFUMTJcV1TgbNOmTdcqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WdgXA0F5k8UEmWxiGwWfjr6vcwCzin1jdJ+LJfFvJRYdi3B1fMywtUym54ExQ5HI2svBNXyr5xOfAgb/AeubYgpuzExSQsgcc1bLcS3nCBoEMkLIzneSnX5CHjM7wZB977Y5l3DUySqoPQDLhMlQQzQSUp+JM5UUSAfvL7v7wBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qd3DzoOF; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e5c7d6b96fso9845446a12.3;
        Tue, 25 Mar 2025 04:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742901223; x=1743506023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9M/B0Pf9mqzaAVp/rsdYiboyi88E5VwqckOOkYoQ+w=;
        b=Qd3DzoOFiPYhVdEegdpiPgqpxnrlaEU3sdU9lm6iWxrIyxfXXtiRshy8p22zk2jm1D
         ijwsBl57JfyAEQ/hjA4oQaKwxdOjWz8fpJZSYVAIxoklSzUyAwh8xbhoXdYF0yp0Iai0
         OoP7DKk5ryXnM150YBj9gR8TJhoEzeBR8iLl9pMroanXqrCvjibJ6JANvrp+6Abd3rFR
         SSLI5rWXwpwdAZOPu6iqLd8X+6CaJuDtS9mehoQerEcHjLO+M0wZjMmsNdSp7DV09HNN
         Aihfa8Kljcuk1wvQBz0WMhIDBd57YiVoKSze4KcGs2U4zmZ6e/DrxXeGwsJI3e/XcI4D
         N8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742901223; x=1743506023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9M/B0Pf9mqzaAVp/rsdYiboyi88E5VwqckOOkYoQ+w=;
        b=MVcTsIYDBE+K8iKmliVON56F74HjjtyHFjQeV9wkwvgzpyTOojw1/rDrrNh5SNqSCE
         VYlmxN0LyJQGDcIqFXdt+3LojF4KWU5i0rZc3Q984RaqCbCgVsyTP214QE15jFZL1g2J
         PP5QI3ieA2M66Wz3Yqux6fqAgJt2fhOed8yCzsXUNwBjcKs8Yg5eau6qiEzP71uGte51
         KL7XkZ5s/nbn3AUtpQ+iahhW8CqCdt22eLY8HZXm07udDhCyXgavTv4vECQ3wtFFEdis
         VRzGWRXf1JXcn50uDsgKu6+jjkLX2w3IVvVTRr6o3dOrJZn4MzgoP1dM+DDPiSxjjXtW
         M5Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUiliD7wDALHrV7FUxomx/uIAIgu81ViPGstuXXCRsR+1uHizumHx/+3f9yf+nm8CqdDhSsoj60UJmEBMmr@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8cCneUKKs3YgPNWIkS2VenoenGqAq1WH2A17uNiN+1OEoqs7S
	9AnwkOYIQpn1cTZ6uq9v0oVGJR97YfMPAIZ691At+FOvS/yxprRe68SpxhMjxwFLx2kZRgzMLIN
	i3rujLcxoMg9sTuZJT77TBnHl6Rk=
X-Gm-Gg: ASbGncs7jzbYhdo79PSbZdIMucDTQtiBN0/aMsz14JtmX8DDAZzZdKiv7KaE1snlc8P
	OatKcKZi2k0jQfndY+/WQB0qRD+5Fux/YKvSZHhFrPY3wHZtQ8H/ILN6WaQPrA359o5enD9a5Qy
	p8zY0aYyJ+tqcpFolLwUoDEzRe
X-Google-Smtp-Source: AGHT+IE/FAgKsln01DXQRfRcgKN7ZoJOGFY3ECUh3lwlvYXccD7fgH+yvXLGspKZMMQblU6GPRb4C9hJUcYjKvwnRbc=
X-Received: by 2002:a05:6402:440a:b0:5e5:ca1b:c425 with SMTP id
 4fb4d7f45d1cf-5ebcd4680c0mr14283905a12.17.1742901223092; Tue, 25 Mar 2025
 04:13:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325104634.162496-1-mszeredi@redhat.com> <20250325104634.162496-4-mszeredi@redhat.com>
In-Reply-To: <20250325104634.162496-4-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 25 Mar 2025 12:13:32 +0100
X-Gm-Features: AQ5f1JphwS9a5s-TjYtd1k4D46RJYROeRnxmQlsj9IwChK6nuc42S9A8ASouaqY
Message-ID: <CAOQ4uxiyJTCjq5Okz=XgK9=xYZoR+r7iLiFGBBWhOrZkZ51KiA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] ovl: make redirect/metacopy rejection consistent
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Giuseppe Scrivano <gscrivan@redhat.com>, Alexander Larsson <alexl@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 11:46=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.co=
m> wrote:
>
> When overlayfs finds a file with metacopy and/or redirect attributes and
> the metacopy and/or redirect features are not enabled, then it refuses to
> act on those attributes while also issuing a warning.
>
> There was a slight inconsistency of only warning on an upper metacopy if =
it
> found the next file on the lower layer, while always warning for metacopy
> found on a lower layer.
>
> Fix this inconsistency and make the logic more straightforward, paving th=
e
> way for following patches to change when dataredirects are allowed.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/namei.c | 67 +++++++++++++++++++++++++++++---------------
>  1 file changed, 44 insertions(+), 23 deletions(-)
>
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index be5c65d6f848..da322e9768d1 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -1040,6 +1040,8 @@ struct dentry *ovl_lookup(struct inode *dir, struct=
 dentry *dentry,
>         struct inode *inode =3D NULL;
>         bool upperopaque =3D false;
>         char *upperredirect =3D NULL;
> +       bool nextredirect =3D false;
> +       bool nextmetacopy =3D false;
>         struct dentry *this;
>         unsigned int i;
>         int err;
> @@ -1087,8 +1089,10 @@ struct dentry *ovl_lookup(struct inode *dir, struc=
t dentry *dentry,
>                         if (err)
>                                 goto out_put_upper;
>
> -                       if (d.metacopy)
> +                       if (d.metacopy) {
>                                 uppermetacopy =3D true;
> +                               nextmetacopy =3D true;
> +                       }
>                         metacopy_size =3D d.metacopy;
>                 }
>
> @@ -1099,6 +1103,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct=
 dentry *dentry,
>                                 goto out_put_upper;
>                         if (d.redirect[0] =3D=3D '/')
>                                 poe =3D roe;
> +                       nextredirect =3D true;
>                 }
>                 upperopaque =3D d.opaque;
>         }
> @@ -1113,6 +1118,29 @@ struct dentry *ovl_lookup(struct inode *dir, struc=
t dentry *dentry,
>         for (i =3D 0; !d.stop && i < ovl_numlower(poe); i++) {
>                 struct ovl_path lower =3D ovl_lowerstack(poe)[i];
>
> +               /*
> +                * Following redirects/metacopy can have security consequ=
ences:
> +                * it's like a symlink into the lower layer without the
> +                * permission checks.
> +                *
> +                * This is only a problem if the upper layer is untrusted=
 (e.g
> +                * comes from an USB drive).  This can allow a non-readab=
le file
> +                * or directory to become readable.
> +                *
> +                * Only following redirects when redirects are enabled di=
sables
> +                * this attack vector when not necessary.
> +                */
> +               if (nextmetacopy && !ofs->config.metacopy) {
> +                       pr_warn_ratelimited("refusing to follow metacopy =
origin for (%pd2)\n", dentry);
> +                       err =3D -EPERM;
> +                       goto out_put;
> +               }
> +               if (nextredirect && !ovl_redirect_follow(ofs)) {
> +                       pr_warn_ratelimited("refusing to follow redirect =
for (%pd2)\n", dentry);
> +                       err =3D -EPERM;
> +                       goto out_put;
> +               }
> +
>                 if (!ovl_redirect_follow(ofs))
>                         d.last =3D i =3D=3D ovl_numlower(poe) - 1;
>                 else if (d.is_dir || !ofs->numdatalayer)
> @@ -1126,12 +1154,8 @@ struct dentry *ovl_lookup(struct inode *dir, struc=
t dentry *dentry,
>                 if (!this)
>                         continue;
>
> -               if ((uppermetacopy || d.metacopy) && !ofs->config.metacop=
y) {
> -                       dput(this);
> -                       err =3D -EPERM;
> -                       pr_warn_ratelimited("refusing to follow metacopy =
origin for (%pd2)\n", dentry);
> -                       goto out_put;
> -               }
> +               if (d.metacopy)
> +                       nextmetacopy =3D true;
>
>                 /*
>                  * If no origin fh is stored in upper of a merge dir, sto=
re fh
> @@ -1185,22 +1209,8 @@ struct dentry *ovl_lookup(struct inode *dir, struc=
t dentry *dentry,
>                         ctr++;
>                 }
>
> -               /*
> -                * Following redirects can have security consequences: it=
's like
> -                * a symlink into the lower layer without the permission =
checks.
> -                * This is only a problem if the upper layer is untrusted=
 (e.g
> -                * comes from an USB drive).  This can allow a non-readab=
le file
> -                * or directory to become readable.
> -                *
> -                * Only following redirects when redirects are enabled di=
sables
> -                * this attack vector when not necessary.
> -                */
> -               err =3D -EPERM;
> -               if (d.redirect && !ovl_redirect_follow(ofs)) {
> -                       pr_warn_ratelimited("refusing to follow redirect =
for (%pd2)\n",
> -                                           dentry);
> -                       goto out_put;
> -               }
> +               if (d.redirect)
> +                       nextredirect =3D true;
>
>                 if (d.stop)
>                         break;
> @@ -1218,6 +1228,17 @@ struct dentry *ovl_lookup(struct inode *dir, struc=
t dentry *dentry,
>                 ctr++;
>         }
>
> +       if (nextmetacopy && !ofs->config.metacopy) {
> +               pr_warn_ratelimited("refusing to follow metacopy origin f=
or (%pd2)\n", dentry);
> +               err =3D -EPERM;
> +               goto out_put;
> +       }
> +       if (nextredirect && !ovl_redirect_follow(ofs)) {
> +               pr_warn_ratelimited("refusing to follow redirect for (%pd=
2)\n", dentry);
> +               err =3D -EPERM;
> +               goto out_put;
> +       }
> +
>         /*
>          * For regular non-metacopy upper dentries, there is no lower
>          * path based lookup, hence ctr will be zero. If a dentry is foun=
d
> --
> 2.49.0
>

