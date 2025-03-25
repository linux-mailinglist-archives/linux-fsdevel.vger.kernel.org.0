Return-Path: <linux-fsdevel+bounces-44950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 546EEA6F1AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCBC916A3DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 11:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C413E253F13;
	Tue, 25 Mar 2025 11:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aq6ZlnNR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D5C1EBA1C;
	Tue, 25 Mar 2025 11:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742901743; cv=none; b=gsN/x3/H4MLvvw1CBJxHEM8deN2Zznjif3n7BKdFUfiPyFbXMsTHfMmQoWpwISyU/AWXCVLhKHaqNfqU8WoK0R5DE8/iX1uYzSI3VCURRD7yZUzV2OSrJqoIsnYp/sb5kxSh9F0rMvMnjdnLuyYYDt5GL2e2pPa0BSAxz4HdSLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742901743; c=relaxed/simple;
	bh=ewOdPmySkgub89Tb74+NzRZuYfY4Bd6qLHH9IcfkT3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JdsjM1aCmuZBc7OUPpbQAiCDi9/3RLQcD/IFNJevp0z31iMEDyLtYNrIzb+QHn1L/PPVoEJe1JBlcqzva40gtC0Z7zB/6X7IH/3pJlRPU5615nnQ9plLF6CA4siM4nCqj3YmOVeceM4BOGeQTKYjCDwopP7YK7PMF4oCTPakf4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aq6ZlnNR; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac3fcf5ab0dso577174866b.3;
        Tue, 25 Mar 2025 04:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742901740; x=1743506540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6XgmHpTftChV8iYuUmbQjK+YqrsUw3+0TFNqS9E7cU=;
        b=Aq6ZlnNRm4T/VS7wbLepoC/IblKam74XFqBPDEOQuOteWR/1ly0mQoLHtoEFhMvfRc
         cYJxt8ZQ8tSJ7zO9FOQemPUfys2HMuYqP9+gA0dXp2n6Xq0nq6kfvOfGxJ0m1DwcKsTU
         c4ceKDk4o5Cwzb+xEOuaOM+y4kildEI+ZmWezLnPW+kJltqf9T9EDvagIj4L5oCnhyo3
         twnCzh4h/PV7enZsYs+znnrbP5ulJGDoPOxsxB2KNpdL1P/scFBfAM1vrqnKleDjihwI
         ZjrIQYZ1et16rQHNVAVvcAek5so8OydtsqPRrbC3uq8oGL3c8b9spF1Pvp005fMMRsrK
         v0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742901740; x=1743506540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6XgmHpTftChV8iYuUmbQjK+YqrsUw3+0TFNqS9E7cU=;
        b=s9Kr5UiTGa9CY6UIiLcsyg4UpBbVQvJ0oSOLoUmSRbZdth+AyzaiVuSyrVIcTsbewG
         8fwJih/7sn/orOaL+eXidSYYW7bm6c9KU4X6Aa5ynmZYZiDrl6gdMxynf5u1tte2ktpk
         WJBfvz6E+wZOczGLam0NuOCxHymv0zECB500kqHdcwVOBZ1x1uDvljhM738E+pjyQ8Ax
         I2+vbO6QE3kHCHrobT1Z6k6vta2yp7g+e6r4wb6U+5loYh+ef6+C9PHPDPTTFCWTsGSj
         StAwo56t+KGqPcT9bRfpS4FjBw8JaFpaXBnuCw5T1yqOFpcFZIghDOTZ+gdU4qpmtPsg
         X/ag==
X-Forwarded-Encrypted: i=1; AJvYcCVCskEXssAjkgTXe01Vys/U87leQou8YuZ+bvvTxO9HHzu1e5M8+y7jPnXcUE5hhGGhlALDynq0wLuy8obv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2nGNbDmp2BFEFt+psBOkc3rlKiK0v5mKiQaOc9NROc4OiVl8d
	XP28xSuP1oQJ8iOvxLpF1ySyEtPUT0+0MgY1zTY1kFQ/GeRrUZvTygfRxwqtxEeUDHRfri1Oc4C
	jkkuI+RSa1S/8S9EHBQjK24n8/3Q=
X-Gm-Gg: ASbGncvSzOWySb0otPzdqWX2ppK3S+Uy3P+839Fuo0pIVm03bDQ4DlVPGqd+VbHBpcd
	eXMPXoK9Q/5Py1y6fAEktrlJMvTP3LVabcKtFdwsRQhWWYnWYAa+k+yxWPFwwrvVR8dU02ih+Qt
	IIqtEEMP+2sei0P6edLMkeeUZx
X-Google-Smtp-Source: AGHT+IGAR9zcgfU9TJviTE8fTjZVko1Kw7rXvbyVIAf6DQ2UQI6pdp+XjN+2VwTuIpAS4kFVsmDYowLghf/Sm3SthR0=
X-Received: by 2002:a17:907:7212:b0:ac1:deb0:5c3e with SMTP id
 a640c23a62f3a-ac3f22344edmr1927183866b.16.1742901739185; Tue, 25 Mar 2025
 04:22:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325104634.162496-1-mszeredi@redhat.com> <20250325104634.162496-5-mszeredi@redhat.com>
In-Reply-To: <20250325104634.162496-5-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 25 Mar 2025 12:22:08 +0100
X-Gm-Features: AQ5f1JrQYdDRrs_qaxh82Jg68ASP3MfEAfq-lyo3iUDeyvFoWs4yhAbSFQSCKaU
Message-ID: <CAOQ4uxhWdWG5t1tpE39gi2kzsXoA3PwbvJgZ0rUeYFP=G8VoCw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] ovl: relax redirect/metacopy requirements for
 lower -> data redirect
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Giuseppe Scrivano <gscrivan@redhat.com>, Alexander Larsson <alexl@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 11:46=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.co=
m> wrote:
>
> Allow the special case of a redirect from a lower layer to a data layer
> without having to turn on metacopy.  This makes the feature work with
> userxattr, which in turn allows data layers to be usable in user
> namespaces.
>
> Minimize the risk by only enabling redirect from a single lower layer to =
a
> data layer iff a data layer is specified.  The only way to access a data
> layer is to enable this, so there's really no reason no to enable this.
>
> This can be used safely if the lower layer is read-only and the
> user.overlay.redirect xattr cannot be modified.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  Documentation/filesystems/overlayfs.rst |  7 ++++++
>  fs/overlayfs/namei.c                    | 32 ++++++++++++++-----------
>  fs/overlayfs/params.c                   |  5 ----
>  3 files changed, 25 insertions(+), 19 deletions(-)
>
> diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/file=
systems/overlayfs.rst
> index 6245b67ae9e0..5d277d79cf2f 100644
> --- a/Documentation/filesystems/overlayfs.rst
> +++ b/Documentation/filesystems/overlayfs.rst
> @@ -429,6 +429,13 @@ Only the data of the files in the "data-only" lower =
layers may be visible
>  when a "metacopy" file in one of the lower layers above it, has a "redir=
ect"
>  to the absolute path of the "lower data" file in the "data-only" lower l=
ayer.
>
> +Instead of explicitly enabling "metacopy=3Don" it is sufficient to speci=
fy at
> +least one data-only layer to enable redirection of data to a data-only l=
ayer.
> +In this case other forms of metacopy are rejected.  Note: this way data-=
only
> +layers may be used toghether with "userxattr", in which case careful att=
ention
> +must be given to privileges needed to change the "user.overlay.redirect"=
 xattr
> +to prevent misuse.
> +
>  Since kernel version v6.8, "data-only" lower layers can also be added us=
ing
>  the "datadir+" mount options and the fsconfig syscall from new mount api=
.
>  For example::
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index da322e9768d1..f9dc71b70beb 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -1042,6 +1042,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct=
 dentry *dentry,
>         char *upperredirect =3D NULL;
>         bool nextredirect =3D false;
>         bool nextmetacopy =3D false;
> +       bool check_redirect =3D (ovl_redirect_follow(ofs) || ofs->numdata=
layer);
>         struct dentry *this;
>         unsigned int i;
>         int err;
> @@ -1053,7 +1054,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct=
 dentry *dentry,
>                 .is_dir =3D false,
>                 .opaque =3D false,
>                 .stop =3D false,
> -               .last =3D ovl_redirect_follow(ofs) ? false : !ovl_numlowe=
r(poe),
> +               .last =3D check_redirect ? false : !ovl_numlower(poe),
>                 .redirect =3D NULL,
>                 .metacopy =3D 0,
>         };
> @@ -1141,7 +1142,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct=
 dentry *dentry,
>                         goto out_put;
>                 }
>
> -               if (!ovl_redirect_follow(ofs))
> +               if (!check_redirect)
>                         d.last =3D i =3D=3D ovl_numlower(poe) - 1;
>                 else if (d.is_dir || !ofs->numdatalayer)
>                         d.last =3D lower.layer->idx =3D=3D ovl_numlower(r=
oe);
> @@ -1222,21 +1223,24 @@ struct dentry *ovl_lookup(struct inode *dir, stru=
ct dentry *dentry,
>                 }
>         }
>
> -       /* Defer lookup of lowerdata in data-only layers to first access =
*/
> +       /*
> +        * Defer lookup of lowerdata in data-only layers to first access.
> +        * Don't require redirect=3Dfollow and metacopy=3Don in this case=
.
> +        */
>         if (d.metacopy && ctr && ofs->numdatalayer && d.absolute_redirect=
) {
>                 d.metacopy =3D 0;
>                 ctr++;
> -       }
> -
> -       if (nextmetacopy && !ofs->config.metacopy) {
> -               pr_warn_ratelimited("refusing to follow metacopy origin f=
or (%pd2)\n", dentry);
> -               err =3D -EPERM;
> -               goto out_put;
> -       }
> -       if (nextredirect && !ovl_redirect_follow(ofs)) {
> -               pr_warn_ratelimited("refusing to follow redirect for (%pd=
2)\n", dentry);
> -               err =3D -EPERM;
> -               goto out_put;
> +       } else {
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
>         }
>
>         /*
> diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> index 1115c22deca0..54468b2b0fba 100644
> --- a/fs/overlayfs/params.c
> +++ b/fs/overlayfs/params.c
> @@ -1000,11 +1000,6 @@ int ovl_fs_params_verify(const struct ovl_fs_conte=
xt *ctx,
>                  */
>         }
>
> -       if (ctx->nr_data > 0 && !config->metacopy) {
> -               pr_err("lower data-only dirs require metacopy support.\n"=
);
> -               return -EINVAL;
> -       }
> -
>         return 0;
>  }
>
> --
> 2.49.0
>

