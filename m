Return-Path: <linux-fsdevel+bounces-55103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F74B06EBA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 09:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8D33A06AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 07:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FF728C01C;
	Wed, 16 Jul 2025 07:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxptNWCC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBED28A72F;
	Wed, 16 Jul 2025 07:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752650161; cv=none; b=HUxqoiI4zhlNejWGxQ5UkY0z0d7CJCEfDNL8I0Q2nwR7ro0RovWQejWxUSZLU94rt8uUDf429a1jqyGGGCmSCJ2Be12xDNhcvd6XDfbKWpIYI2RHZBmkfEBZlHIkgaDo+udmbFXhUQIdI+fuix2JHKTTwVyJfcCW4ygVLpfZmIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752650161; c=relaxed/simple;
	bh=MoRA9BTeXLJ2CzZxO/LNuGPz1I0L849wQTguVwTUlQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GfbenPvvH/NbpFdrIiAHcr+NZIovuRULH8nyn5ZaRz/h3L6nJf3TFpd92aFTB14CC4iyK4xY0nnveBePAAOCx/zfNUcnAb6eX08/guu63lyCLxJgPhPFX+tO6D/b0/azQTmLXOfGzerTaG2JEoGLcW0bPh0o0lnUW53VNaLDSPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxptNWCC; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae0dd7ac1f5so1221887766b.2;
        Wed, 16 Jul 2025 00:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752650158; x=1753254958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKcy98wUUMClpfNvZf3o4jagI+61nLZEpZITJm/LVcs=;
        b=OxptNWCCo/fNOFC7SV6ByqiNDqh3c6zNAm3FE6QaWKPVvcYfha43uCJM5VyLu6cSjO
         eQDtF06edDEUNOqyDW7aIh/RODgnECCTCuHpQ+U1hhySVYIKJUZDz+ha4vu6ON8z+DdD
         CvvkQqnOsQR72H4s+UlA9Nw40V7JtvPVSabQpku70KQZpXjI8VLd0IgR8boFTkPLFpmK
         V80JrrQJW7ognXFOgbCZIYVzBQH3oe0EUSH/5gewhHrwtFFlRMLCoTG6MamX4D8LAjoc
         9TTHEesrG6rwtCs2PvL8xGQmTcWp6UD0xdzRCOW/X9Sa4nnCT5eYkYi8Lvna87ADQnLR
         0fNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752650158; x=1753254958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKcy98wUUMClpfNvZf3o4jagI+61nLZEpZITJm/LVcs=;
        b=QCa+i/rz9wt3M0Cqc2Ug+StYbgT67CtFWq20ZPk/BQfbNzc8I2UxZ337U97OAxdVSO
         SbkKbv0wI8uC18+SQjOoIdt8V3fGnQ48PznwrRk+SWNLoTkRvgA7EuFH1bueZEtAjUEH
         G8x8n2ESU8ngGAEn/1bvb7jKoyVX//KJiH1HoynLzS4PNEVRgh0ED2Wa+nv3oVEMBOiC
         nCUkGYGlvixnZkMrPhKKG3/bE4r7COcZ18O5GgpJR8+kI52szmGcgdmHvg6EPFIpOsEi
         k1z3WkZfezFJE1qcKC7z3OP7lYHi+v8Si9jLfGHvKQrKuYp/e8K67WnwaFrD+i+8Hfg6
         8zmw==
X-Forwarded-Encrypted: i=1; AJvYcCXG7z8hFtZ023LG6aJhoDwO9BWJm3eGe/vv8fqJFaR56xK7A+JB7+aYaOqyAM9oPBSI5qKqxI4mxs+7yFffFw==@vger.kernel.org, AJvYcCXtRYWZlEkEQffDY+4fCfs0XHjirc3RT/3NLz1yNi72XDqmZ6EXYF4BlBOulRXbb7rYVxdebMmtPJMI78YP@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu4EzK+isSoz1+perCiNre2IiZSmbrcMpK/5BHYr92wTzGBoFY
	3xBrBavl/oH2Hm6jHIw7MSTU4XxwIwMVIGGsT6imru7Zm3loiEAeX8rwnok9DWPwOujDhVxIECY
	yAu8lw8ws68waitOzo4jD5RuQ836cCaZzn0HK+HM=
X-Gm-Gg: ASbGncsahxr6QEDdxqg0WOd0z6q/B2RWoU3/IQDJViuRBpLayo2kGJE5uk7TBKXj5z8
	I98j/cIvAvLb7JPgcUzfw421ucOnmZIa6SmUgI9puBFwVMW7RFZEkhugQjPIQWT4R92w+YdL4Ql
	AMXx21Dv/bP4joc86k329eM5IWuu5HzmRwEfSnacrp9wfhzxuYYgSCh4P/g3QqGnvjRlUuUcDBN
	4lMbzE=
X-Google-Smtp-Source: AGHT+IGZ9lqYieeK4f2zXrfzaGMN3XEY55Y1I4zbfLEI30167nfg4dali0aA6EvSnehV2+kGkpI9h/9Q2X63L8heoHY=
X-Received: by 2002:a17:906:730b:b0:ae3:6a82:e6a2 with SMTP id
 a640c23a62f3a-ae9c9af35d4mr222551866b.29.1752650157601; Wed, 16 Jul 2025
 00:15:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716004725.1206467-1-neil@brown.name> <20250716004725.1206467-14-neil@brown.name>
In-Reply-To: <20250716004725.1206467-14-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 16 Jul 2025 09:15:46 +0200
X-Gm-Features: Ac12FXyoJ3Eeqfr6WsC6tw2ZRfpUAOX9br4sWqCmDLh4oniJvHWZ1ivQKovL_10
Message-ID: <CAOQ4uxiyk5yXwZCzEzzao5f9h2CYcAYZ-uZJnppsf3spMR0Uug@mail.gmail.com>
Subject: Re: [PATCH v3 13/21] ovl: narrow locking in ovl_indexdir_cleanup()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 2:47=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> Instead of taking the directory lock for the whole cleanup, only take it
> when needed.
>
> Signed-off-by: NeilBrown <neil@brown.name>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/readdir.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 2a222b8185a3..95d5284daf8d 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -1194,7 +1194,6 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
>         if (err)
>                 goto out;
>
> -       inode_lock_nested(dir, I_MUTEX_PARENT);
>         list_for_each_entry(p, &list, l_node) {
>                 if (p->name[0] =3D=3D '.') {
>                         if (p->len =3D=3D 1)
> @@ -1202,7 +1201,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
>                         if (p->len =3D=3D 2 && p->name[1] =3D=3D '.')
>                                 continue;
>                 }
> -               index =3D ovl_lookup_upper(ofs, p->name, indexdir, p->len=
);
> +               index =3D ovl_lookup_upper_unlocked(ofs, p->name, indexdi=
r, p->len);
>                 if (IS_ERR(index)) {
>                         err =3D PTR_ERR(index);
>                         index =3D NULL;
> @@ -1210,7 +1209,11 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
>                 }
>                 /* Cleanup leftover from index create/cleanup attempt */
>                 if (index->d_name.name[0] =3D=3D '#') {
> -                       err =3D ovl_workdir_cleanup(ofs, dir, path.mnt, i=
ndex, 1);
> +                       err =3D ovl_parent_lock(indexdir, index);
> +                       if (!err) {
> +                               err =3D ovl_workdir_cleanup(ofs, dir, pat=
h.mnt, index, 1);
> +                               ovl_parent_unlock(indexdir);
> +                       }
>                         if (err)
>                                 break;
>                         goto next;
> @@ -1220,7 +1223,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
>                         goto next;
>                 } else if (err =3D=3D -ESTALE) {
>                         /* Cleanup stale index entries */
> -                       err =3D ovl_cleanup(ofs, dir, index);
> +                       err =3D ovl_cleanup_unlocked(ofs, indexdir, index=
);
>                 } else if (err !=3D -ENOENT) {
>                         /*
>                          * Abort mount to avoid corrupting the index if
> @@ -1233,10 +1236,14 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
>                          * Whiteout orphan index to block future open by
>                          * handle after overlay nlink dropped to zero.
>                          */
> -                       err =3D ovl_cleanup_and_whiteout(ofs, indexdir, i=
ndex);
> +                       err =3D ovl_parent_lock(indexdir, index);
> +                       if (!err) {
> +                               err =3D ovl_cleanup_and_whiteout(ofs, ind=
exdir, index);
> +                               ovl_parent_unlock(indexdir);
> +                       }
>                 } else {
>                         /* Cleanup orphan index entries */
> -                       err =3D ovl_cleanup(ofs, dir, index);
> +                       err =3D ovl_cleanup_unlocked(ofs, indexdir, index=
);
>                 }
>
>                 if (err)
> @@ -1247,7 +1254,6 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
>                 index =3D NULL;
>         }
>         dput(index);
> -       inode_unlock(dir);
>  out:
>         ovl_cache_free(&list);
>         if (err)
> --
> 2.49.0
>

