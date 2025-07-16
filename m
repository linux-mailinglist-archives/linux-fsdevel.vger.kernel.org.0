Return-Path: <linux-fsdevel+bounces-55106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DB9B06EB8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 09:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F44566F19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 07:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C048264F99;
	Wed, 16 Jul 2025 07:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csxfZ/Hb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5592C190;
	Wed, 16 Jul 2025 07:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752650219; cv=none; b=GVr2KEwNwcIP5g7pCNOZct9YFhhz9Ju3cWwZzxCbf08LD7Nt8lUglIiO4SukBnio0qMbJC3uPZvSpb2gLyNFdOc0nxm7xxDbNechmbH6UZhnDgRklDBIrvUsMYZHxNF8Ey35kml/jRB/QkQwTB+SP72cnzzf76cWpPxQLhGWv90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752650219; c=relaxed/simple;
	bh=+KyRnNEEev/GJ/yf3D1NTnrkjBrlUD+hRO2xY14WvQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O/G49QDhE0avPRkjbX0x09F1ta2rJKjm3oWq/507U0loLQ80d4K0h4V0z1nP+3CKlweAC9WtgS+AUGk/O5zwx3Jv30aHHV2tYI7/FqtccrEmtdrieQST6ufTHeJX49hfp5LuEpeJlA4TPX+Dhb9NjhC4WU6qDWpV6xTE0SpxizI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csxfZ/Hb; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad572ba1347so884556866b.1;
        Wed, 16 Jul 2025 00:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752650216; x=1753255016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhC8b68gbj6hEWFW/DCotLsZfSPyN2n0ZcqBJpBJ+3c=;
        b=csxfZ/HbG+w1HALZZMYgIozuLGtgfcStfVi4ADg/lCepcrjzYh0pUrL78vSY7HnneF
         pSbwrqiDdL7rSq9FXeeoDstismJsxe1ePZYQZs2IUaC8uNis14K1jIycQC65SGju5/KW
         JmqJDLgkfVQFWX6HKqXl2YyrJmEk3Cz9CYB5rfUGL0cXXF1woK3A8iOeJ2S+I/0RrqEH
         skuMCtFSIFIzK8i1Ye/SIxykDFHgoxZNBNVaPsVo1iNiure9rnBB25MzityqqbRjP7zk
         GN/6s3//oR3kPUsAvGz7O9otXen3uLSkLOrW8FwBqZooUDa+7FLtJRsp66p3O7NqVB7O
         R74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752650216; x=1753255016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhC8b68gbj6hEWFW/DCotLsZfSPyN2n0ZcqBJpBJ+3c=;
        b=bMpDUMMYAFs1QJxc1FTUpDdoufnapQF+NnKMJVXaDGfJ1uZ7YChWKqAA++wNojrSlq
         6flT/h2Pm75jjZgne2KFfLNkLk03fc352oQMHnVkuL5IvZkCOaBtmdOz7mt9HMukkH8I
         5GuReUGgH8dmO4bsbhw6srPlzLPUG1/Sv0G1MuBZQInBCsRl+BSzpkzwweeHgcwrWXJh
         Jkx///lN1tcmXKA/cj/TrwK6Mq82YHB/lwDllJsPnNNZFtpM02pO/4jwgRYkrP/Rswj+
         Feu3VeuFmMrMh2E5aLZRB3VripKb+95UdxLNrviAcy5jyzF6/e+qE0sdqBuArqunqdUm
         MSzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpUhoJQhpVIdpHMwR6JP/zBO1x+v9lu8oWReof1G63zvgvnRmA3/XYLgMENV+bYrzgQdK5/OzechuBV4VziQ==@vger.kernel.org, AJvYcCX044RFeMP40lx3W0nPSnEXNSgEmfR24SGF1V2oNOSfVHEAHybMCgjRXrhQVfAz40Z/ywML4mC9Sa7J/x/g@vger.kernel.org
X-Gm-Message-State: AOJu0YxOeOjhAJ5SrAOu06WiAeWvlXe60Tr5FiQuf1B/FnzKeEh/f2kc
	K4Wn4Lss4/tWHvkIU7qWOkhRhO1hf49c8Aj7RN1CbFtx0/x6VsHclX9Ad42bevN2HmZrhV8Sv/s
	We13z5M4IWl4W7XjhW1jJ8NmLiNzIfag=
X-Gm-Gg: ASbGncvrkddPK+MHI2mUzHWhrHrRsUZ3B53q62LkiqWNETTtdtNEmMIVGPgERbdMb/d
	RFwiTcQbw7Mf2fqbqU/OaKiKtZQ6b4CIEm0VeY9h7H4nU4amDAZKXlUu5zMopnEb56SLm6AM5sU
	merwUvQc44Oc4d6k5FZlhB3rPULUJS2fMg2rZR+AbHmq0IuNUcHshMD6hBSoeAeMWZADD141YTG
	GZt9opo/5C3vWzX3A==
X-Google-Smtp-Source: AGHT+IEht3pM/cDuVBXEAi5+RahJn+F9lXXbenF3mlsQRxL3LNxZZWqbQ/uRbYUODQLh0gSuh9bXJDl/hNUn7YzbXzQ=
X-Received: by 2002:a17:907:3c93:b0:ada:4b3c:ea81 with SMTP id
 a640c23a62f3a-ae9ce0b7e59mr134574566b.39.1752650215221; Wed, 16 Jul 2025
 00:16:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716004725.1206467-1-neil@brown.name> <20250716004725.1206467-17-neil@brown.name>
In-Reply-To: <20250716004725.1206467-17-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 16 Jul 2025 09:16:44 +0200
X-Gm-Features: Ac12FXzE4OX-YWUhFthsTZNu4CR4qYmbBeAo08V0gotN6XYxk2tNofvptPo9nnw
Message-ID: <CAOQ4uxg-YQSyk9Sc5AP7-EinRdQ_Q7=A6zWOMbzxT1M1_HjDfw@mail.gmail.com>
Subject: Re: [PATCH v3 16/21] ovl: narrow locking on ovl_remove_and_whiteout()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 2:47=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> This code:
>   performs a lookup_upper
>   creates a whiteout object
>   renames the whiteout over the result of the lookup
>
> The create and the rename must be locked separately for proposed
> directory locking changes.  This patch takes a first step of moving the
> lookup out of the locked region.  A subsequent patch will separate the
> create from the rename.
>
> Signed-off-by: NeilBrown <neil@brown.name>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/dir.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index e81be60f1125..340f8679b6e7 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -770,15 +770,11 @@ static int ovl_remove_and_whiteout(struct dentry *d=
entry,
>                         goto out;
>         }
>
> -       err =3D ovl_lock_rename_workdir(workdir, NULL, upperdir, NULL);
> -       if (err)
> -               goto out_dput;
> -
> -       upper =3D ovl_lookup_upper(ofs, dentry->d_name.name, upperdir,
> -                                dentry->d_name.len);
> +       upper =3D ovl_lookup_upper_unlocked(ofs, dentry->d_name.name, upp=
erdir,
> +                                         dentry->d_name.len);
>         err =3D PTR_ERR(upper);
>         if (IS_ERR(upper))
> -               goto out_unlock;
> +               goto out_dput;
>
>         err =3D -ESTALE;
>         if ((opaquedir && upper !=3D opaquedir) ||
> @@ -787,17 +783,18 @@ static int ovl_remove_and_whiteout(struct dentry *d=
entry,
>                 goto out_dput_upper;
>         }
>
> -       err =3D ovl_cleanup_and_whiteout(ofs, upperdir, upper);
> +       err =3D ovl_lock_rename_workdir(workdir, NULL, upperdir, upper);
>         if (err)
> -               goto out_d_drop;
> +               goto out_dput_upper;
> +
> +       err =3D ovl_cleanup_and_whiteout(ofs, upperdir, upper);
> +       if (!err)
> +               ovl_dir_modified(dentry->d_parent, true);
>
> -       ovl_dir_modified(dentry->d_parent, true);
> -out_d_drop:
>         d_drop(dentry);
> +       unlock_rename(workdir, upperdir);
>  out_dput_upper:
>         dput(upper);
> -out_unlock:
> -       unlock_rename(workdir, upperdir);
>  out_dput:
>         dput(opaquedir);
>  out:
> --
> 2.49.0
>

