Return-Path: <linux-fsdevel+bounces-55104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D49A1B06EBB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 09:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0ABA1A65BF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 07:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81505533D6;
	Wed, 16 Jul 2025 07:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDtLjnoT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A1C277C96;
	Wed, 16 Jul 2025 07:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752650177; cv=none; b=NoEi9BfJN6Da/wu/QdRZedIJHWh6XUhTLdw2SkBoKCjt4qjIZvvMx3Kjg66joTg1+iai+/IoBwiR1At0J+Fhok+xzmT8T+AwBljdFkaxyRA+mJ6jRF9ya44FjTgAPl2eW3OfUxcSlruDnAqA3bZ+4LWdX0lPYCGaDTmK5Ko8P5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752650177; c=relaxed/simple;
	bh=mRxXW8JYF6RDYHnj1S2eWgAadS01Wd42JHAkL0oIijM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gz14oKjHrWw8rwUzJKkkO27DDgXHZS3S3vVwpYL4UG8C5tZtd+qMh8lOA+Pi6Nv/wgcjH3gXlvjGMiJIj7kiHCz30vWhqW3FH8tFpxb5qhAPporhxuwHl/q7oGIoAlkq7LT0LxpO6DxLyq7k30AVfTSqoIYXL/hSKPGsfjO87W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDtLjnoT; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae223591067so1075981666b.3;
        Wed, 16 Jul 2025 00:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752650173; x=1753254973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBhOiP5IhDLShl7XOtUBGsG3REOSNP1S33njauLvr10=;
        b=hDtLjnoTjw3wmlZg0v8ys3XB4vZ7QD7mYqDzUKrXlfIQPvNkgw50G0dQR2MNmeX2pS
         a5PKRB1cW/8uB26DLc4PcDWYwop1iF8CFTEqnR8dk+SL/6l/w/ud8oR5dyvwAbqYT3Lr
         NOUclMSiI8gCdM3DqqRi9wPFqRidltSg5CoD46Ce+B3uj6qxvPI5sB42BANd97jy93HB
         RiLrOBYFgBPGfuiL1agnWob/CnJrjwqYNXI1PXdqOc1/fFAfZkhbzVFfrTkbBDvKKoLQ
         jjLCOfB3ZhlGyzUwCkUZSMPDID8sDDL0+Abs88NLBcCMHhL9obkxrGW76QPmXYI5gLpp
         4ncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752650173; x=1753254973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBhOiP5IhDLShl7XOtUBGsG3REOSNP1S33njauLvr10=;
        b=xJ19+Qi+NsQrKjEaI9lo46HqvOCbZeza+1OaANLoNGslf+A0oNVzHdS27UhmLGSHju
         xHU1r7GoLAZZOe+50VzCgFztmMbYSEJZ4DteX/4paG5Uwqb8dPDX7K5lE6Oji9yuQHSX
         dspSG7LM0AP+TNsdJen5K+nQ2LCPoG65bgEELSm5fekeqIo27Q7YoydloMhixA48VZZP
         vEG3Fzef0vgYTaUww5bTAHxzHl2bKutsXZ7SwLrg/NOfIzDbZFKzfTgbvqu8eVwZ8sAu
         h/0wXz0iXqPF5Wm/g6sENtIGq/m01oObaQiG/3itsxeoDp/QvzvHZbT2eB4g2ZJzuTc2
         nwag==
X-Forwarded-Encrypted: i=1; AJvYcCVH0W3xi2pNcgFVQsKi+g3fEUaico/Qej6XZ2sZsi5/cdBlQyCMNt7RT+Su+mVRO2vhT2lCc3jiFe0Y654c@vger.kernel.org, AJvYcCX4K4haRVH/vQPV2LyR0eQ3fY1QVc28okpB7mTV9HikV00stywZIMlIj9ieUd/Yt3slX/F8V/1S0Df1D0mm4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDuAUXhaO2B4PdbPlR1isZRVd/1wTd1S9iUI5LsMpz2Z1PPWOz
	cyqy1UviUHD6U9IsKKAIWNuroPnEFgeUSAYtsL8smprRIdG1CghmxESCgKETE/CPITqaWZ6ODkY
	l8F04Bzzz4pdOgdHR8k6YXNVOipv4c1Q=
X-Gm-Gg: ASbGnctujKzIQbrdg4/dwyamUoHcTzFRahtTXf+oSHrIDA75oSK6KBvkGDnTz6Bd+Rh
	lWSwF/BzEYJFMGqjxIXDxwylducG3VlKKfKhnsqafd8qNtMGg8GcYfnrYiHfD9grW2iNWZ+xo3K
	vUHLiM7qhKx3ZbLVFpksg0XGDlKvGmIlbECjjSm+j9RZYV6dTL2di9G+9s4PLh5e+aamo9nu99o
	OkiaXQ=
X-Google-Smtp-Source: AGHT+IGc2H700Pcc1ic9k16xZrYOap4QMpLb/7jvEfZkxIm3x01fxgcZidMjnS5VEgrIajLoDgE8W4wl2SEY1pCRFNU=
X-Received: by 2002:a17:906:4791:b0:ad8:9a86:cf52 with SMTP id
 a640c23a62f3a-ae9cdd7f078mr150346266b.11.1752650173006; Wed, 16 Jul 2025
 00:16:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716004725.1206467-1-neil@brown.name> <20250716004725.1206467-15-neil@brown.name>
In-Reply-To: <20250716004725.1206467-15-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 16 Jul 2025 09:16:01 +0200
X-Gm-Features: Ac12FXySbcq_SLu--mvQQST9McKnt2edS4b2UWA0nrUzkc9oNcbhWvzcb8F_BNs
Message-ID: <CAOQ4uxhbaibS=4-XghhGoQBOk08V-WHxgnyswREYCoq_KDFTrA@mail.gmail.com>
Subject: Re: [PATCH v3 14/21] ovl: narrow locking in ovl_workdir_cleanup_recurse()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 2:47=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> Only take the dir lock when needed, rather than for the whole loop.
>
> Signed-off-by: NeilBrown <neil@brown.name>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/readdir.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 95d5284daf8d..b0f9e5a00c1a 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -1122,7 +1122,6 @@ static int ovl_workdir_cleanup_recurse(struct ovl_f=
s *ofs, const struct path *pa
>         if (err)
>                 goto out;
>
> -       inode_lock_nested(dir, I_MUTEX_PARENT);
>         list_for_each_entry(p, &list, l_node) {
>                 struct dentry *dentry;
>
> @@ -1137,16 +1136,21 @@ static int ovl_workdir_cleanup_recurse(struct ovl=
_fs *ofs, const struct path *pa
>                         err =3D -EINVAL;
>                         break;
>                 }
> -               dentry =3D ovl_lookup_upper(ofs, p->name, path->dentry, p=
->len);
> +               dentry =3D ovl_lookup_upper_unlocked(ofs, p->name, path->=
dentry, p->len);
>                 if (IS_ERR(dentry))
>                         continue;
> -               if (dentry->d_inode)
> -                       err =3D ovl_workdir_cleanup(ofs, dir, path->mnt, =
dentry, level);
> +               if (dentry->d_inode) {
> +                       err =3D ovl_parent_lock(path->dentry, dentry);
> +                       if (!err) {
> +                               err =3D ovl_workdir_cleanup(ofs, dir, pat=
h->mnt,
> +                                                         dentry, level);
> +                               ovl_parent_unlock(path->dentry);
> +                       }
> +               }
>                 dput(dentry);
>                 if (err)
>                         break;
>         }
> -       inode_unlock(dir);
>  out:
>         ovl_cache_free(&list);
>         return err;
> --
> 2.49.0
>

