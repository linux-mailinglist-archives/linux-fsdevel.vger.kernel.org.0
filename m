Return-Path: <linux-fsdevel+bounces-54653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6492DB01E87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 16:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15156B63136
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 13:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B9C2DC34A;
	Fri, 11 Jul 2025 13:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4b/+2ba"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CCA210F53;
	Fri, 11 Jul 2025 13:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752242067; cv=none; b=qTz4g9MBQWaPnB1cfJGcg2SshGOSlHzx1X6mZp1PVEhYPNOtgJZVxT1ZSIc0Le+3B/3ABHOFR4L/qqTdZwChvUVatpymNjvwprUrMrVw+ZfusL74qrwkHw/wewozfxQND5eYPrmPwO9JGRQ/d+FoUGaqKUkzIalB/jTwSA/CUqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752242067; c=relaxed/simple;
	bh=Aq0UWMxuzgcAo0TZpLzDQyCfr27z64BIWG+3rs/BcMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GSSfGFcxRQydUIw/5MM+OFLaS6Wi7hsOy+iuRbxGjtzY/q6fKFdJBpcdf+syyNjIWC53A0Yf+wmVFX725UzWMByC9NDdLTWe+yvr4pceE7kSvevhUys6tCYvGHga+NgqFZqxUCiUdJS2tdVXm5Ci0p58xCFfMYHblGXdpMbeejs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4b/+2ba; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso3431396a12.2;
        Fri, 11 Jul 2025 06:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752242064; x=1752846864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKNmqbM1Io9kr6tHHswOc/RmHHXRZahen59U6vlxIVE=;
        b=S4b/+2bap8r7d8aIP6CPVBC6fWUlCotsoajgNbJHWJoEntqNRs/HF0MVDz/v6FHQbt
         XIYkJYuV+RieyyV+obwZ2ySPHcAY6lJoQc3P7/rMHO7xcS1XZlStGPIWPNW2et58Abox
         6rqA6gtJd5oXADlNQTZDSFcUARQxjsmdNreAgq/rRu/Pd8vWFs1kMkA1mhRzrkuuQQFh
         1hMehmwnoC+vjRspJfkmKK846ujFUDn5+smUNUmuJskasNRs08aojwopacKRSISlhaG/
         Ub2iZCyeaLHIjtGvCfuIxr92DQdOKZERxRtB99v/d4pdMk+QEES6soI61THtB6hCJoNs
         qJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752242064; x=1752846864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKNmqbM1Io9kr6tHHswOc/RmHHXRZahen59U6vlxIVE=;
        b=sW7i9No3eVXnnIyrPndi4T3/i0EEvd7SQmVgsIdamazw1yIKAlKetrWW8Zs8RrWe5r
         4VpVBbE3CzRoeFWXV/beE1HoXWWswlG/oFRNcVAw1K4eKfBJO4How/DwJboj3ziq9YHm
         bmTBOF11MgeA9ElNC5yphTua3knRbsaLu71HrCt5MAhtljj/hs0+ojmq4GYkKbvnUxyE
         60dmU6JQ4qzqxlsWGRsgGZCgjgFNSy3pl+a0s+56xYSeDeP0prb6vum7jtP9jYU0b8MJ
         gTDVNukAIx9qrVvb1iLljAB/jeRrwp/ck8h30I7snrjmArSqurCxuoEmS8sMsx9ZlPeH
         tp4g==
X-Forwarded-Encrypted: i=1; AJvYcCU+ZVrHkd+8k9L30esfl4Rbp2lMKiXCdvnbbpl9/CD7FHPoC4Goq8GVXpfUgRucCEtLd1gUnns2ADKezXDC@vger.kernel.org, AJvYcCVChml5UrTAJuujhY6wUofKdf2RWL+m/xjwutZ/u35IFptjd0qhyKYyRSheMH5pUAsD9X/nh5Le6ZXovIh1oQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1KBZ0BJ8qpjOGAJPMfktJlNqE8rONZwpyQp3XBF27pEt2wlsR
	bxaoJAcH5vR4Wh4q3e+6i26ktnMTnFEMfyWEneDnXvHXjfz3yBAMYzLw67AcnMEOVl9z65ULfLa
	PUMXl9rP/mRhd0417lqeIYhxXGAsHhvsfj8OxD9F30w==
X-Gm-Gg: ASbGncta2IUuZoE/8zrPV2wOxyKhHpVDRjI0AkiDTq6P50/nYIhwTn0UAFS+bfcmz3J
	XzzExjIH1S8Fy5RsqBQHRYQ/u2EJR9EuQ15qYbrgxtgA49xbNAx5pSeS+WfZ/T2OKeCWIjJ7qe/
	OEDdk9NzEhy2VrLebIpVkJaCiHWKHCzJyVSRjx+PCVR55r+FtIvuZZrvoQWjYES0jQI1sovizq7
	1rtDH0=
X-Google-Smtp-Source: AGHT+IH5COpSP/1rq3izI15zC6kQuwgQpZVSYuqKrU3pO/F3QBwQHJFmK8hAOh2gXvUCq0odx6xDw8XNvfLaYeR/a/4=
X-Received: by 2002:a17:907:3d02:b0:ae0:b604:894c with SMTP id
 a640c23a62f3a-ae6fcad2f4emr331824466b.48.1752242063432; Fri, 11 Jul 2025
 06:54:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710232109.3014537-1-neil@brown.name> <20250710232109.3014537-19-neil@brown.name>
In-Reply-To: <20250710232109.3014537-19-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 11 Jul 2025 15:54:12 +0200
X-Gm-Features: Ac12FXy4O2938nlEwEcZZV16F6s3PB5hr-0N5rK_-62XnL80rjr25-CRoGYHDvg
Message-ID: <CAOQ4uxiopGbM9FECQLbvB1+x4Mz9KufEgSWoMKs4UC+tFVB2_Q@mail.gmail.com>
Subject: Re: [PATCH 18/20] ovl: narrow locking in ovl_check_rename_whiteout()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 1:21=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> ovl_check_rename_whiteout() now only holds the directory lock when
> needed, and takes it again if necessary.
>
> This makes way for future changes where locks are taken on individual
> dentries rather than the whole directory.
>
> Signed-off-by: NeilBrown <neil@brown.name>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

> ---
>  fs/overlayfs/super.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 23f43f8131dd..78f4fcfb9ff6 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -559,7 +559,6 @@ static int ovl_get_upper(struct super_block *sb, stru=
ct ovl_fs *ofs,
>  static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
>  {
>         struct dentry *workdir =3D ofs->workdir;
> -       struct inode *dir =3D d_inode(workdir);
>         struct dentry *temp;
>         struct dentry *dest;
>         struct dentry *whiteout;
> @@ -580,19 +579,22 @@ static int ovl_check_rename_whiteout(struct ovl_fs =
*ofs)
>         err =3D PTR_ERR(dest);
>         if (IS_ERR(dest)) {
>                 dput(temp);
> -               goto out_unlock;
> +               parent_unlock(workdir);
> +               return err;
>         }
>
>         /* Name is inline and stable - using snapshot as a copy helper */
>         take_dentry_name_snapshot(&name, temp);
>         err =3D ovl_do_rename(ofs, workdir, temp, workdir, dest, RENAME_W=
HITEOUT);
> +       parent_unlock(workdir);
>         if (err) {
>                 if (err =3D=3D -EINVAL)
>                         err =3D 0;
>                 goto cleanup_temp;
>         }
>
> -       whiteout =3D ovl_lookup_upper(ofs, name.name.name, workdir, name.=
name.len);
> +       whiteout =3D ovl_lookup_upper_unlocked(ofs, name.name.name,
> +                                            workdir, name.name.len);
>         err =3D PTR_ERR(whiteout);
>         if (IS_ERR(whiteout))
>                 goto cleanup_temp;
> @@ -601,18 +603,15 @@ static int ovl_check_rename_whiteout(struct ovl_fs =
*ofs)
>
>         /* Best effort cleanup of whiteout and temp file */
>         if (err)
> -               ovl_cleanup(ofs, dir, whiteout);
> +               ovl_cleanup_unlocked(ofs, workdir, whiteout);
>         dput(whiteout);
>
>  cleanup_temp:
> -       ovl_cleanup(ofs, dir, temp);
> +       ovl_cleanup_unlocked(ofs, workdir, temp);
>         release_dentry_name_snapshot(&name);
>         dput(temp);
>         dput(dest);
>
> -out_unlock:
> -       parent_unlock(workdir);
> -
>         return err;
>  }
>
> --
> 2.49.0
>

