Return-Path: <linux-fsdevel+bounces-46042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2CDA81CAF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 08:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B6731B66D4B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 06:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763CC1DED54;
	Wed,  9 Apr 2025 06:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaxFpIAy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EA515A85E;
	Wed,  9 Apr 2025 06:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744178958; cv=none; b=LANhviyB852+9Q2U2K9+JyN2rsMnEC3bGZyIKWoKKotj7gV02Y/77BG/JuWDlr5sKy6aDlwIjEX0V03nWo4bOszTWw+v4j/qZfocsrcprgyRWaT7E28PuuCc2qj/t3WcglM0GMHB7kA6uNdpZZLGg2zYLqklbKA9aLrJHTzv3TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744178958; c=relaxed/simple;
	bh=jM8OD4HM9d+9zUOqW5Nz/zC6iHQDo765ocSa73hEqEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GLbcxRmflk1VHfKcrnl5wrAcVT+pBWaH0GRop4dLXGEAKQhcQZHKxaC7FGWryWISpW8r+BpndKAmyL4YF0rwzJ9I+oFe1+fF7XubNWYacu2rr1trEDt3F8ziEgc+2msWGiBB/cUXR3LFVaPPqmjSSJzeAIF3SOcq0zQF00IPR/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaxFpIAy; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac289147833so1063527566b.2;
        Tue, 08 Apr 2025 23:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744178955; x=1744783755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8a2ffX23jEbnViJJp1bHsuHmbprTP/8SlZIzCp4vio=;
        b=VaxFpIAy9+vkm71mMbQbwkB8lMzPAGhfJAR1tZIx+5YfksT6J+/4sKA1QFmkm28THX
         P0Dl2hBSxf2PMsSCeeN97cI8o6AjKPeuGwJ2yb1T5ftHxvIsWgY/x5LriGR2O8kye3tF
         7cSH/JtQcXQMG7WtznPBD5h4VPKlNk1Jg9k1wPANHOIQVyORg0PywE3AAOhPk9KcAcRj
         ae1pNRvJY6NAwVobscflkhkCnwYHd13xUbSD0bWkAdTKWjXlIvXDrgmIIZ4X7fcBsTul
         O9I6tKg7yzjTJQpMqYJALqafQvVZBX9ng/Tk6dIlwS7DWP18U3PUBlPp/tYAaZBKg1+L
         uijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744178955; x=1744783755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8a2ffX23jEbnViJJp1bHsuHmbprTP/8SlZIzCp4vio=;
        b=E6/vc1UlDEAMz/kustYQMxNsI9rQ5d80431b1LLIvzRxaIVTo4chHLvOQ860lC8qQ9
         qH5xjkjVWex0bUiBreqCWpcs7C0bU1uTvRGXDdw62pUaNxpIgN0NaxvF/+GFGK/k9KNC
         70iYJ0YBLOVxfccJrU96wIi8SgMgyovSwaMZ7eZ0/3TtCb7QN5NekSqvYwzgBZ9gVQZH
         bdEo8etQ8FKBDLF9ov8liwsWiIjGGTFXCEtYVm21i7f93Q86HolSuERV7kIGLppXobGo
         NDaLXsFpekx0svqVuR8jDkhKlBWGyAbq53YW498JQBkgor+s19Ftp/9ajAAcZH2NmDLs
         dw2g==
X-Forwarded-Encrypted: i=1; AJvYcCW3/1HjF40YDtST8srLs+jR4IAtbTNTPDekVhY3Vq5nIGg91tRGDLu9CrT8rwKEyVBbg0GCr2zqbo7qfA8e@vger.kernel.org
X-Gm-Message-State: AOJu0YzKfH0oEN6xYep6EwFHOp2Gn2zHyBJkOzUr3r3CWzleBAtTJQYG
	TcYM1kfeC5E/VRhJQgnxXheUVHu5UdmOdHczMB9xQEqi4QuLfOBoiFTsLk1mg5qXpBSx05UFQ2/
	4zQTB+e+sr5ygPv6kP4Tqf6IKUJs=
X-Gm-Gg: ASbGncso6dH74tOLxSildV5sB64SJdBQoDly8JOo4Z24dSzbtQEEnkF0L2NshD/Fbx0
	fDg9FG9Txu2pQDD2qzMuydfFLZzgofqPOGKRaJ5pmmQB2hSGdjv5jPIa6a9SrBvkSLAa9mUlLuB
	hW41UEeCzcdRFeF1lnJm80xw==
X-Google-Smtp-Source: AGHT+IFdHBBqhwKP4Tl6JZjeTXLPr9L0gRdGF6JvWih1BHcq8/LkOKiDZ73D5O3SqKuAwbvi/FGg4dOWom4H3Out854=
X-Received: by 2002:a17:907:d87:b0:ac7:391a:e159 with SMTP id
 a640c23a62f3a-aca9d73c032mr86955366b.60.1744178954385; Tue, 08 Apr 2025
 23:09:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408154011.673891-1-mszeredi@redhat.com> <20250408154011.673891-2-mszeredi@redhat.com>
In-Reply-To: <20250408154011.673891-2-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 9 Apr 2025 08:09:02 +0200
X-Gm-Features: ATxdqUHEgtJh6K0qrSJCBBQh4q29yp7zi4OG4srh4bUD0WEbNScRW7j8mb-6ARU
Message-ID: <CAOQ4uxjOT=m7ZsdLod3KEYe+69K--fGTUegSNwQg0fU7TeVbsQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] ovl: make redirect/metacopy rejection consistent
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Giuseppe Scrivano <gscrivan@redhat.com>, Alexander Larsson <alexl@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 5:40=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.com>=
 wrote:
>
> When overlayfs finds a file with metacopy and/or redirect attributes and
> the metacopy and/or redirect features are not enabled, then it refuses to
> act on those attributes while also issuing a warning.
>
> There was an inconsistency in not checking metacopy found from the index.
>
> And also only warning on an upper metacopy if it found the next file on t=
he
> lower layer, while always warning for metacopy found on a lower layer.
>
> Fix these inconsistencies and make the logic more straightforward, paving
> the way for following patches to change when dataredirects are allowed.

missing space: dataredirects

>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/overlayfs/namei.c | 81 +++++++++++++++++++++++++++++++-------------
>  1 file changed, 57 insertions(+), 24 deletions(-)
>
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index be5c65d6f848..5cebdd05ab3a 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -16,6 +16,7 @@
>
>  struct ovl_lookup_data {
>         struct super_block *sb;
> +       struct dentry *dentry;
>         const struct ovl_layer *layer;
>         struct qstr name;
>         bool is_dir;
> @@ -23,6 +24,8 @@ struct ovl_lookup_data {
>         bool xwhiteouts;
>         bool stop;
>         bool last;
> +       bool nextredirect;
> +       bool nextmetacopy;

I think these are not needed

>         char *redirect;
>         int metacopy;
>         /* Referring to last redirect xattr */
> @@ -1024,6 +1027,31 @@ int ovl_verify_lowerdata(struct dentry *dentry)
>         return ovl_maybe_validate_verity(dentry);
>  }
>
> +/*
> + * Following redirects/metacopy can have security consequences: it's lik=
e a
> + * symlink into the lower layer without the permission checks.
> + *
> + * This is only a problem if the upper layer is untrusted (e.g comes fro=
m an USB
> + * drive).  This can allow a non-readable file or directory to become re=
adable.
> + *
> + * Only following redirects when redirects are enabled disables this att=
ack
> + * vector when not necessary.
> + */
> +static bool ovl_check_nextredirect(struct ovl_lookup_data *d)

Looks much better with the helper.
May I suggest ovl_check_follow_redirect()

> +{
> +       struct ovl_fs *ofs =3D OVL_FS(d->sb);
> +
> +       if (d->nextmetacopy && !ofs->config.metacopy) {

Should be equivalent to
       if (d->metacopy && !ofs->config.metacopy) {

In current code

> +               pr_warn_ratelimited("refusing to follow metacopy origin f=
or (%pd2)\n", d->dentry);
> +               return false;
> +       }
> +       if (d->nextredirect && !ovl_redirect_follow(ofs)) {

Should be equivalent to
       if (d->redirect && !ovl_redirect_follow(ofs)) {

With minor changes to index lookup code


> +               pr_warn_ratelimited("refusing to follow redirect for (%pd=
2)\n", d->dentry);
> +               return false;
> +       }
> +       return true;
> +}
> +
>  struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
>                           unsigned int flags)
>  {
> @@ -1047,6 +1075,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct=
 dentry *dentry,
>         int metacopy_size =3D 0;
>         struct ovl_lookup_data d =3D {
>                 .sb =3D dentry->d_sb,
> +               .dentry =3D dentry,
>                 .name =3D dentry->d_name,
>                 .is_dir =3D false,
>                 .opaque =3D false,
> @@ -1054,6 +1083,8 @@ struct dentry *ovl_lookup(struct inode *dir, struct=
 dentry *dentry,
>                 .last =3D ovl_redirect_follow(ofs) ? false : !ovl_numlowe=
r(poe),
>                 .redirect =3D NULL,
>                 .metacopy =3D 0,
> +               .nextredirect =3D false,
> +               .nextmetacopy =3D false,
>         };
>
>         if (dentry->d_name.len > ofs->namelen)
> @@ -1087,8 +1118,10 @@ struct dentry *ovl_lookup(struct inode *dir, struc=
t dentry *dentry,
>                         if (err)
>                                 goto out_put_upper;
>
> -                       if (d.metacopy)
> +                       if (d.metacopy) {
>                                 uppermetacopy =3D true;
> +                               d.nextmetacopy =3D true;

always set IFF (d.metacopy)

> +                       }
>                         metacopy_size =3D d.metacopy;
>                 }
>
> @@ -1099,6 +1132,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct=
 dentry *dentry,
>                                 goto out_put_upper;
>                         if (d.redirect[0] =3D=3D '/')
>                                 poe =3D roe;
> +                       d.nextredirect =3D true;

mostly set IFF (d.redirect)

>                 }
>                 upperopaque =3D d.opaque;
>         }
> @@ -1113,6 +1147,11 @@ struct dentry *ovl_lookup(struct inode *dir, struc=
t dentry *dentry,
>         for (i =3D 0; !d.stop && i < ovl_numlower(poe); i++) {
>                 struct ovl_path lower =3D ovl_lowerstack(poe)[i];
>
> +               if (!ovl_check_nextredirect(&d)) {
> +                       err =3D -EPERM;
> +                       goto out_put;
> +               }
> +
>                 if (!ovl_redirect_follow(ofs))
>                         d.last =3D i =3D=3D ovl_numlower(poe) - 1;
>                 else if (d.is_dir || !ofs->numdatalayer)
> @@ -1126,12 +1165,8 @@ struct dentry *ovl_lookup(struct inode *dir, struc=
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
> +                       d.nextmetacopy =3D true;
>
>                 /*
>                  * If no origin fh is stored in upper of a merge dir, sto=
re fh
> @@ -1185,22 +1220,8 @@ struct dentry *ovl_lookup(struct inode *dir, struc=
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
> +                       d.nextredirect =3D true;
>
>                 if (d.stop)
>                         break;
> @@ -1218,6 +1239,11 @@ struct dentry *ovl_lookup(struct inode *dir, struc=
t dentry *dentry,
>                 ctr++;
>         }
>
> +       if (!ovl_check_nextredirect(&d)) {
> +               err =3D -EPERM;
> +               goto out_put;
> +       }
> +
>         /*
>          * For regular non-metacopy upper dentries, there is no lower
>          * path based lookup, hence ctr will be zero. If a dentry is foun=
d
> @@ -1307,11 +1333,18 @@ struct dentry *ovl_lookup(struct inode *dir, stru=
ct dentry *dentry,
>                         upperredirect =3D NULL;
>                         goto out_free_oe;
>                 }
> +               d.nextredirect =3D upperredirect;
> +
>                 err =3D ovl_check_metacopy_xattr(ofs, &upperpath, NULL);
>                 if (err < 0)
>                         goto out_free_oe;
> -               uppermetacopy =3D err;
> +               d.nextmetacopy =3D uppermetacopy =3D err;

Could be changed to:
+               d.metacopy =3D uppermetacopy =3D err;


>                 metacopy_size =3D err;
> +
> +               if (!ovl_check_nextredirect(&d)) {
> +                       err =3D -EPERM;
> +                       goto out_free_oe;
> +               }
>         }
>


We never really follow redirect from index
All upperredirect is ever used for is to suppress ovl_set_redirect()
after copy up of another lower hardlink and rename,
but also in that case, upperredirect is not going to be followed
(or trusted for that matter) until a new lookup of the copied up
alias and at that point  ovl_check_follow_redirect() will be
called when upperdentry is found.

I think we do not need to check follow of redirect from index
I think it is enough to check follow of metacopy from index.

Therefore, I think there d.nextmetacopy and d.nextredirect are
completely implied from d.metacopy and d.redirect.

Thanks,
Amir.

