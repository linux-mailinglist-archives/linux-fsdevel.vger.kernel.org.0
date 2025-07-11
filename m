Return-Path: <linux-fsdevel+bounces-54644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA44B01E01
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 15:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5F50B477D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 13:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23B02DAFD7;
	Fri, 11 Jul 2025 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGZoAiF6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7922D46B1;
	Fri, 11 Jul 2025 13:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240764; cv=none; b=GGu1F5IFlmDAcP4B19QQyy4jCfRCPEu+66BR39YIJB/lJl/22k0yz1JPhA63Gug+1YALix6C/gNgpXAtAKgcRZmYVFh9d5yWM76xn82kBkDEB64eqHjvgffju/wwa82zP81L6xSD/RS1bHJVovd5mlS+0/ehBhtejx2lqJYCfPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240764; c=relaxed/simple;
	bh=9/srNi5NxPYHuLuMzs350rL4Qi4M8bj4/4SNn/kQIkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pXwTu3SIEdngj8Hz5ZIeC2PCiXDMl8auf+wilVYgJsgZj5QVIYADGdnR+Uu1XEZG5VBvpBFG7vC70ssXLjsHDyEGVlG/FNNe2Jtjcvp7s4xWnaujjEUbL6xgBuEjVs7uwD66VIMqPB3Djvl46cFMTVmjt7hd/YqXOok9IKdJmHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGZoAiF6; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae0de1c378fso331319566b.3;
        Fri, 11 Jul 2025 06:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752240760; x=1752845560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUYmGjn8b+ni+3oA2uqaVvOpchRrlznYPwlaR45MpqY=;
        b=FGZoAiF6Ao+kJyfjuZlO9FuvLjoVefT4UbHJxdWZvGuVxGWsU755219bpLFk10oAc8
         YaimgpkCiNEWSzx1SpZrlZbYfd3c2yt6JmD+eYdN5WhjkSs/ifp33GwQ25y6Rk/1QYrf
         9Xcn1rNyHgR0viQ6MpCclDwdfCPRBFFjwcoV7dvtTcqvR8Oz/bfnMC/HbJ90ktJqN+NL
         3a3Egov/+MZYmhfmZUqtlcLm4/xp/7xS7mZ+ZRj/4SrzTJKyykyySE3X0CGGVMEoFTbi
         E0k65MOIkqBAPe0HB3lenbsivtcsakiDu6KbpxkGccAPO/FfE7ZSkGdViak+sa0LNg4/
         Lt5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752240760; x=1752845560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUYmGjn8b+ni+3oA2uqaVvOpchRrlznYPwlaR45MpqY=;
        b=h3LsiVVvVYVzeSKhivmFlasUROrWtMgovzji6fVnjyzei0vGGcF7QcXlSi5exEpGGJ
         7uttbKLxb96ROppwEJQHDdWJG0AaeqICiWPPI6ss7f74vjydBQ/nWUGAj+hj1Jf1nk9y
         E5qbHCeY2mnc5XadEGWyNSn1Mehe2GwantIAeko6kyHKB7XjMHOhDt+CujBZCO7GOPLO
         mEQfrhlCaDm88yu51DTgHh2g5pPnVu5jrpD6PQ2WPsKApr4Eq3Sv+LMrbz8jYWLdyHLD
         VaipS0f8Lo753bT8rt5CzVGqDSXG4i6i1HegXmv/lHN2G3G1LcXRO6JnThwGgYcSpZoO
         O/qg==
X-Forwarded-Encrypted: i=1; AJvYcCUCXh8DZUvJDqprgMPlOwGFLuFoxk/FqLQ7c3hsMKZdJMw5A3A7ET4zsFbfWLiXEVKep3ocAEQVckPKWpeGWA==@vger.kernel.org, AJvYcCXbqfP1EHPxkrUEMDSWR7hT++Vh3lM58xs64mAfuN7VEQkdNs1Q7ZkD1Cv8rR35RIwtLP/aicI0zC2J/34y@vger.kernel.org
X-Gm-Message-State: AOJu0YzymYzGwhocR5qgPoxtt8TN8eL/qh81Njk5D+tVEm8VnoEUFGJY
	tTCLxQHsPdHH5EB81GGBKNZsOOBe8jzAQY+fmufejkB10Qn31anfYGAhMA01VQdN85ACvGVH5st
	eGiAmTRcOUk+pFGmhAjil7OY01i0eqFk=
X-Gm-Gg: ASbGncsm2dUHi3o5wB98VAFyZjHj4N00bXHV9bIUan+TQI58hlA3C1JgytxwWBJvjoV
	b0sX159l7xvdxef+PLioUMbO4VRmhi76q3IQcJmkmQ9dgRte8SbwAdr12RH/P+2BnuimZNrGF8u
	dCYZlw2yd0+I7isNvocM47ScIlq6VvyAS1ZC/b7JQboUc8nHp8/IsZ/sR8apSLCHdYONfZz/1Ld
	MF5NB8=
X-Google-Smtp-Source: AGHT+IF41jQGXyNgBt2vwTomqSVB1R19b6Vi1exWf22EWsG/zfk7jsounVM8c/84zTB1qM//19ILh6zfkC7rZgrBm7I=
X-Received: by 2002:a17:907:709:b0:ae3:c521:db6 with SMTP id
 a640c23a62f3a-ae6fc1158c9mr313938066b.58.1752240759676; Fri, 11 Jul 2025
 06:32:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710232109.3014537-1-neil@brown.name> <20250710232109.3014537-12-neil@brown.name>
In-Reply-To: <20250710232109.3014537-12-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 11 Jul 2025 15:32:28 +0200
X-Gm-Features: Ac12FXzenOCIVsjYTWoK-zSP6WNJmNtPIi_iv0sD8TBvW7NKCPOQvVgfmCwcseA
Message-ID: <CAOQ4uxjwgoPAmu7M+6+-McrvnrUjYQ4eK6ZWZcLnn5RS+seArQ@mail.gmail.com>
Subject: Re: [PATCH 11/20] ovl: narrow locking in ovl_workdir_create()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 1:21=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> In ovl_workdir_create() don't hold the dir lock for the whole time, but
> only take it when needed.
>
> It now gets taken separately for ovl_workdir_cleanup().  A subsequent
> patch will move the locking into that function.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/overlayfs/super.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 9cce3251dd83..239ae1946edf 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -299,8 +299,8 @@ static struct dentry *ovl_workdir_create(struct ovl_f=
s *ofs,
>         int err;
>         bool retried =3D false;
>
> -       inode_lock_nested(dir, I_MUTEX_PARENT);
>  retry:
> +       inode_lock_nested(dir, I_MUTEX_PARENT);
>         work =3D ovl_lookup_upper(ofs, name, ofs->workbasedir, strlen(nam=
e));
>
>         if (!IS_ERR(work)) {
> @@ -311,23 +311,27 @@ static struct dentry *ovl_workdir_create(struct ovl=
_fs *ofs,
>
>                 if (work->d_inode) {
>                         err =3D -EEXIST;
> +                       inode_unlock(dir);
>                         if (retried)
>                                 goto out_dput;
>
>                         if (persist)
> -                               goto out_unlock;
> +                               goto out;
>
>                         retried =3D true;
> +                       inode_lock_nested(dir, I_MUTEX_PARENT);

Feels like this should be parent_lock(ofs->workbasedir, work)
and parent_lock(ofs->workbasedir, NULL) in retry:

>                         err =3D ovl_workdir_cleanup(ofs, dir, mnt, work, =
0);
> +                       inode_unlock(dir);
>                         dput(work);
>                         if (err =3D=3D -EINVAL) {
>                                 work =3D ERR_PTR(err);
> -                               goto out_unlock;
> +                               goto out;
>                         }
>                         goto retry;
>                 }
>
>                 work =3D ovl_do_mkdir(ofs, dir, work, attr.ia_mode);
> +               inode_unlock(dir);
>                 err =3D PTR_ERR(work);
>                 if (IS_ERR(work))
>                         goto out_err;
> @@ -365,11 +369,11 @@ static struct dentry *ovl_workdir_create(struct ovl=
_fs *ofs,
>                 if (err)
>                         goto out_dput;
>         } else {
> +               inode_unlock(dir);
>                 err =3D PTR_ERR(work);
>                 goto out_err;
>         }
> -out_unlock:
> -       inode_unlock(dir);
> +out:
>         return work;
>
>  out_dput:
> @@ -378,7 +382,7 @@ static struct dentry *ovl_workdir_create(struct ovl_f=
s *ofs,
>         pr_warn("failed to create directory %s/%s (errno: %i); mounting r=
ead-only\n",
>                 ofs->config.workdir, name, -err);
>         work =3D NULL;
> -       goto out_unlock;
> +       goto out;

might as well be return NULL now.

Thanks,
Amir.

