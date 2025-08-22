Return-Path: <linux-fsdevel+bounces-58841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0714FB320A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 18:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603BFA061FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 16:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D4230DEB7;
	Fri, 22 Aug 2025 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emKPveLf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5025822F384;
	Fri, 22 Aug 2025 16:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755880469; cv=none; b=p7+lbJ7bboyHuQOQdm5FN5DVmXFpdTmC6Ohjt2WbkIIpbfhzb0O/eqWJ9TtYrSaxELDkIs9pF1nZxkXeXcFie85sW8/LhmIuewHU2Z80QNXLyiZZvmtVZsUSZTKABcW4LGBODWRNs5Npn9z3KgGurwp4fYlo9ZPWGipV+EgIhHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755880469; c=relaxed/simple;
	bh=8QG8d1+IwB3R/mb6KsOMEkpxPevsaHOLgmQCzq052Q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EtfntqGkgJ6CY2Jkq3JADA6buIcCGdCgScp+CpXy6oNrmGF1mKIGKTj5zcKIDDKQobusUDdfoDsGEkVxq9VsaUbjMnJzBh1RP74dQhEinS9EpzKxkvh8+Gb2/Z7LOx57BKcN4ERQiuY8wGaxrNKv9R37DRWopF1IfmuFjZt2NOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emKPveLf; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61c212c3986so1134465a12.0;
        Fri, 22 Aug 2025 09:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755880465; x=1756485265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HlMkeQu40ULVawvf6RgU1vq8bta7oLaRc7sTa0rxxo=;
        b=emKPveLffUspHfGi8d2YSIBI/2loiZjGTA79l2S6d40DhWlcJY7sYO6sVS6Wu4u5B5
         HadA8ryHWNBIiQr0XQzhW6UJisFyPhIFG/9XsddDuZLUcpMW9dOA9Vwjs6o8N8cLEGN6
         F2lLffaTtfpKV+e1ZVjebsJsZxyyXDzqlULyMYMZYrij12cLRrFiYh/3o68/sBWut6Oq
         uJV4oPs2xLgfwi+Xb0DwGTemspm1fdWIhIdY8uv/NCyRtkOW133GitKNXEMAqnOFAFYT
         TX/X0Gj4a1cojDo65cy9GZunI+qqWRF7y5/UbCfOO5zffz1XD2gxB8Z9VvlRqDxdycD0
         EMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755880465; x=1756485265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6HlMkeQu40ULVawvf6RgU1vq8bta7oLaRc7sTa0rxxo=;
        b=hkSrLaYHyL/0xH4YX9nStLfK0EWhYETpu+QVfFl+kknRCuxZkpeyIQ8/zGkNI6drbi
         d3bErEbi484iGfS9uMU4p4JmheHDH0Gd0fadgft5Cjbg67bUQ7q0sre0AeRzN+jU2/h8
         YPljdl/8kEmdv+2dZbpBWdr7n5QY+4D0cvmNSfiBe1Az3Ip1C3k+AIIVGlFzGJpvuSBt
         J/De6cN6u8jYrfHd3Mvr1iSVGx3CGDEABbH6UtlcGRNVaht3vtm2wK3JHoiY2rtmChhO
         VS5jPk9avVF+iS+8Ck5OK9QtdGuIGr6ykvNBgdwyMFzyQ/dp+Z0Y8wNF+IvSvtXRppuO
         afHw==
X-Forwarded-Encrypted: i=1; AJvYcCU3RFCjFV8YbyXS18fxTSi/ABiUE4WakmMW0CLvXzGMtpDplE34b0DUUShBqjZxp9j0sS4rO27YtF9U5h3z@vger.kernel.org, AJvYcCXTAij8qZgUlJKvWF4rJMpo9A2KRuRqjQoRv+4ANj/pCBYrAevrGSo2nYTsKpOhJl9YU8/RDZG9y4vU7A7jbQ==@vger.kernel.org, AJvYcCXlZ27meaPQh15lltPAk+EvI1GY7+ehJ7L8UCxJ77Wz7V+o93GI9ggbo3EpmixKuxOnZ2vNCx5v+0OMnZ0q@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfejv9FDmxyQWY76bSN+eMCVVuiJlpVMjJYM1PoHOKQb6LqYIL
	6zv8IHjCmkYXbwlpiZnaVfZC20duFFSRUUUPKYSg9g9y5Hy4IIXxkustCBRJBt/hCoW7x7A53ph
	3CUQYt7QuHEGJ19LGI+g5Bjtirs9bTHvFCrkOono=
X-Gm-Gg: ASbGncv5HRdrvdZ6taPaVWVsZM3gszWYUeHIlimaJits2uYX4UjOwHV5T88dhhYjfbC
	2jM10zGLhjH87Mdg2SZVOqvZCPGQsfIf+QIn8ryQYHKdVGdDmTkv2j+PQgI45iNkTwFlGvm5DHB
	BcAU0is+iO4IYhBKVDj5kWy1N80kx/xdQSrn2Q4BDwswlJBcqqDdX9fLaIO5beMLlafOCgSjnMq
	fPaKSA=
X-Google-Smtp-Source: AGHT+IGHwn0+TuaT3RcDkehu2d++Wqd2sJcLskS7Ol47UNfLau3oRkNj1nFp3WqMuG0+GDSiv+ZCvmVASTso72CvPYE=
X-Received: by 2002:a05:6402:270a:b0:615:5f47:8873 with SMTP id
 4fb4d7f45d1cf-61c1b1cee08mr3281998a12.14.1755880465210; Fri, 22 Aug 2025
 09:34:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com> <20250822-tonyk-overlayfs-v6-9-8b6e9e604fa2@igalia.com>
In-Reply-To: <20250822-tonyk-overlayfs-v6-9-8b6e9e604fa2@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 22 Aug 2025 18:34:13 +0200
X-Gm-Features: Ac12FXx1A_g7Xzez-KtpzTlCyVmrWWuKs2KmuS2dQABuISj33sThEK0TOuWWIg4
Message-ID: <CAOQ4uxhWE=5_+DBx7OJ94NVCZXztxf1d4sxyMuakDGKUmbNyTg@mail.gmail.com>
Subject: Re: [PATCH v6 9/9] ovl: Support mounting case-insensitive enabled layers
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, 
	Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 4:17=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> Drop the restriction for casefold dentries lookup to enable support for
> case-insensitive layers in overlayfs.
>
> Support case-insensitive layers with the condition that they should be
> uniformly enabled across the stack and (i.e. if the root mount dir has
> casefold enabled, so should all the dirs bellow for every layer).
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
> Changes from v5:
> - Fix mounting layers without casefold flag
> ---
>  fs/overlayfs/namei.c | 17 +++++++++--------
>  fs/overlayfs/util.c  | 10 ++++++----
>  2 files changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index 76d6248b625e7c58e09685e421aef616aadea40a..e93bcc5727bcafdc18a499b47=
a7609fd41ecaec8 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -239,13 +239,14 @@ static int ovl_lookup_single(struct dentry *base, s=
truct ovl_lookup_data *d,
>         char val;
>
>         /*
> -        * We allow filesystems that are case-folding capable but deny co=
mposing
> -        * ovl stack from case-folded directories. If someone has enabled=
 case
> -        * folding on a directory on underlying layer, the warranty of th=
e ovl
> -        * stack is voided.
> +        * We allow filesystems that are case-folding capable as long as =
the
> +        * layers are consistently enabled in the stack, enabled for ever=
y dir
> +        * or disabled in all dirs. If someone has modified case folding =
on a
> +        * directory on underlying layer, the warranty of the ovl stack i=
s
> +        * voided.
>          */
> -       if (ovl_dentry_casefolded(base)) {
> -               warn =3D "case folded parent";
> +       if (ofs->casefold !=3D ovl_dentry_casefolded(base)) {
> +               warn =3D "parent wrong casefold";
>                 err =3D -ESTALE;
>                 goto out_warn;
>         }
> @@ -259,8 +260,8 @@ static int ovl_lookup_single(struct dentry *base, str=
uct ovl_lookup_data *d,
>                 goto out_err;
>         }
>
> -       if (ovl_dentry_casefolded(this)) {
> -               warn =3D "case folded child";
> +       if (ofs->casefold !=3D ovl_dentry_casefolded(this)) {
> +               warn =3D "child wrong casefold";
>                 err =3D -EREMOTE;
>                 goto out_warn;
>         }
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index a33115e7384c129c543746326642813add63f060..52582b1da52598fbb14866f8c=
33eb27e36adda36 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -203,6 +203,8 @@ void ovl_dentry_init_flags(struct dentry *dentry, str=
uct dentry *upperdentry,
>
>  bool ovl_dentry_weird(struct dentry *dentry)
>  {
> +       struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
> +
>         if (!d_can_lookup(dentry) && !d_is_file(dentry) && !d_is_symlink(=
dentry))
>                 return true;
>
> @@ -210,11 +212,11 @@ bool ovl_dentry_weird(struct dentry *dentry)
>                 return true;
>
>         /*
> -        * Allow filesystems that are case-folding capable but deny compo=
sing
> -        * ovl stack from case-folded directories.
> +        * Exceptionally for layers with casefold, we accept that they ha=
ve
> +        * their own hash and compare operations
>          */
> -       if (sb_has_encoding(dentry->d_sb))
> -               return IS_CASEFOLDED(d_inode(dentry));
> +       if (ofs->casefold)
> +               return false;

I think this is better as:
        if (sb_has_encoding(dentry->d_sb))
                return false;

I don't think there is a reason to test ofs->casefold here.
a "weird" dentry is one that overlayfs doesn't know how to
handle. Now it known how to handle dentries with hash()/compare()
on casefolding capable filesysytems.

Can you please push v6 after this fix to your gitlab branch?

Thanks,
Amir.

