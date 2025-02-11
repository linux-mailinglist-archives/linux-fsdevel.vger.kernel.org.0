Return-Path: <linux-fsdevel+bounces-41509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5870BA30999
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 12:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A7E61889EDF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 11:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67E670807;
	Tue, 11 Feb 2025 11:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaEpfYre"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707EA1F4E4F;
	Tue, 11 Feb 2025 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739272406; cv=none; b=gljam7SlT6DZ8jUcr6IJuOJGRYtVcBnWBzfiXSKQoCaZGeXi/rT3HgbO3fMEkMEjk4lBxo7/QVYPkZo0OZBZbMCfLqGiK3Xz98SeYpbY6a8aYfDz3OBXYfAWA+zflwjZP5XACr6q4B5UVBE6Zq1B5jDNB1LrEyuLbzh0YUPWE1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739272406; c=relaxed/simple;
	bh=foqrSrZ1s2dHL7Z7ZcrxqCXlVj8OK1XKF/S8gb4/vkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iSxvafEWCD6dUSRPEZ36w6Qs1vmYc/uDfTPjtsmeMSVDWqXK45ZbRZBIEXKMY9gT3GelIVEudf+LY4VAgB4Npr/zWF20+JC74tDsx3ctyWmfa6p9Se4nIQN5mGrlUWiulQQ8rYnLUGc6gkDlJ+Dxxst4gQjUFx+ILQvbHmx3Cwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaEpfYre; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5de6c708315so4240652a12.0;
        Tue, 11 Feb 2025 03:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739272403; x=1739877203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEU8/gjk2N8YCn1RPxrta02uUUIr1qS3ltsjPz1h4Y0=;
        b=QaEpfYreV0UEUvJYBGcN+pHzsNjdleF/kO0pOFarLxjL4npf7EAhbAjMtAo/lzbwfh
         uQI2LFaw2NhsK1iJgqmkeFjWyajCH9e+Pt9rve2xAb6h+ZDtHf8j3344chhAhQFjnZmo
         UNvkwmL53j2P19gCZOCSu0pHZL2FPD2aaLB6CREeQuAyjuzG+KyI/LGv+3QHAuAYJ0Xp
         f7JP+hTCnqNImLRFnT/x5Ko7e8KunYEFHZoCUuF1MUq+/cfNaGa873G1F5vu5mw8EufW
         lIZQWCwtJUB5vVQjkFKty9RP0rdlt40gUR9a4WDkBzQhESmQfrjCSCUL4iryYTQjj4X5
         ADHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739272403; x=1739877203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEU8/gjk2N8YCn1RPxrta02uUUIr1qS3ltsjPz1h4Y0=;
        b=duhxviKt3a6NeKMXw7LrmrN54uYj7ImUmqpFB5nWKv7n0atBa63lFF3rl047uvtqPt
         OQsyp4Yh3e8JfvMg/GwnR6r3ZJBBDgjQbAurJ4hK/QkOrSGnfPm+vzX+7PIUmuQNBJWn
         h/XUAfDS+NnXmFm6d8pKFDMz0VEPIER7RWVHvidVuDBZoTkEdXfurx0VqZNpN8019lAh
         ODyWmZ1M3Ilj9S+CHFv9Iz3u02zwG8PGXfMDTD6jPus5/U4hYwNl6mARohOkHTg8JVcz
         wrgpYOlPyAaEFZDkgN4f4xrGIa4LfcixhHAOGhZ8iaj6gFdBOAa5stlcUBSPoQCY8ZmH
         PuBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHtdtoKoIfbLLo+PpqBXJunj19lUXUZGhDnW8+nOnL2sUvLuOsAbS4+5IjiCdufUL3YMTkA8KZOAcvCi8O@vger.kernel.org
X-Gm-Message-State: AOJu0YwQa/6PJO9eIjlqEx16zO5aa0RY5+603YGGCcQjej4L6VZOSeYG
	XDqlqr7Jmmv9nbd9+h+BNmMdKMtphjdxnFWTorg4ag69mVmot4oBknmSXlJhOvged6CbbjfY2+C
	kJ9GYkvMAzeX9ijcF6fsvu4RuRtm99EUyUWU=
X-Gm-Gg: ASbGncsOltgUb/Rdwvbz+z/HP8JBBMhBFPlABvisGq914zX9VK9ukKX5wrSJrO0Iz0W
	GUQdWufCIHGuXwjNU5/vTHiGDIwE4LKGFaWYLN2zcA0OYOUq70bmgEsS+MDyJiDNQvg75wr9b
X-Google-Smtp-Source: AGHT+IEN/qdHoeQnbJhcB8+5amSySKbOBXp11EnPJBDW0OrXspRzeKtEEcqcuJ7DYiSk7BSiFEyu/HXuII4npO72fz4=
X-Received: by 2002:a05:6402:400e:b0:5dc:5e37:b3ab with SMTP id
 4fb4d7f45d1cf-5de45005043mr19485845a12.12.1739272402177; Tue, 11 Feb 2025
 03:13:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210194512.417339-1-mszeredi@redhat.com> <20250210194512.417339-3-mszeredi@redhat.com>
In-Reply-To: <20250210194512.417339-3-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 11 Feb 2025 12:13:10 +0100
X-Gm-Features: AWEUYZmeu8pw4X-Ow59fbO5-HYFxGhhYYl3w7yxk6EuKp7GgqjtYZM9QcqrnX58
Message-ID: <CAOQ4uxiqis6kawuv4pa6jxHYgpQPc18izFP8e0TORfA_mVu_-w@mail.gmail.com>
Subject: Re: [PATCH 3/5] ovl: make redirect/metacopy rejection consistent
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 8:45=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
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
> Fix this inconsistency and make the logic more straightforward, pavig the
> way for following patches to change when dataredirects are allowed.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
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

What do you say about moving this comment outside the loop and leaving here
only:

    /* Should redirects/metacopy to lower layers be followed? */
    if ((nextmetacopy && !ofs->config.metacopy) ||
        (nextredirect && !ovl_redirect_follow(ofs)))
          break;

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
> 2.48.1
>

