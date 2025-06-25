Return-Path: <linux-fsdevel+bounces-52971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A897FAE8E14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 21:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27B51C2694F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 19:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8362E2E0B72;
	Wed, 25 Jun 2025 19:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDwy+LBW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363812E0B56;
	Wed, 25 Jun 2025 19:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750878493; cv=none; b=TP6LGJIP73ScZ89x410VBgKL51Bbn6rxsWTUzyAP4In/TopbosyfJbUtHtYo92akQ3ZeAnsbeU3EtpkQkf4kDgtIycULRXdaZ/egHmD5HRNa0F2H0Sa4OS7Ekg3UHb1iF5aljwLkBA6qph1dqj/Q+l8rHsZmzGPyBykzr2bgu7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750878493; c=relaxed/simple;
	bh=jOTzYCX/q+6NwHtg2FzxD0aNrAllUWKzL4Ey6jLB2j8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWTuvkQO4t738lT+Q8g46s3cZu2fyTP5BNVMgCU5WT3qOxIYAZ77lY88HBEceRKIGz8Wy6r4fk7jg6JWjk6pDfrSKKtpQfeITEHuGxF7obJVDe3PedDvkyz0CZN1Jc4ilLJUZTtHRFQxfRJTt+yZW0dwFeDAjd1+Y6pgO6YXPoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDwy+LBW; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad88d77314bso40775866b.1;
        Wed, 25 Jun 2025 12:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750878490; x=1751483290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8ozs6t1nvLS2czmZ/QfN3NaqSFCpr9nqM4R8orTeG0=;
        b=dDwy+LBWQT3KeOITnYlEBToi1/tfDkwZhgyK2TlFQm0zDVe2KCeLcu5UyYjGptWfQe
         3aHIV6NS0JWZwnWYIQkYjKfkQVPKK2eQyAZsgcOkGku2tpvXAnUTc+g3I/+NbbAL8sGd
         cEIZC52Q4S79PSCbHOk4ZIu3mxO5CYk7ZWVzPVKzJYI0sZofHV3++MgHpoln5qOl5Eav
         rXLa734fOuKIb+lfKF2Yt07PJZPYzNpzcsztXMbWy/Qil82ffNG7uyxtslBEVeiaR0f/
         NWitnP2MO3/BoVGrJSe5XwRbwll1HWgcduWvifqGCZstXQos6UqEyXbuxZ94JEWALP9C
         oouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750878490; x=1751483290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8ozs6t1nvLS2czmZ/QfN3NaqSFCpr9nqM4R8orTeG0=;
        b=MEsKky2Zny+KsVHH5/XEBcQCioszycGcMar3xu1aK/floYetpiIFgO80nAhxgeX76L
         S03x3OOpa09BszVK/YzviaKzhICwrLHMWEXpFWoOvYQRTvIJNT+rh8kmmLW1h0+QQOjo
         Wq9nCWTWESRr41+bXnDsh+iacba9qcS/Ahq+3SERsbRRXjdtRXOqz7XH42IgZ/5Ugv6G
         eZ5qr/MbbrMDkc4doEqG/KZDIiUqGvfS0MymEWEBXw7wNyv6Zkvqb3cVrAbAywJ+Za1e
         o+js3MGOiTMLDipNn4/q7Q72UqatKu4tk3C/GWbpyP30zpgW1lY9+6fLqGBqdZA8IadA
         lxbw==
X-Forwarded-Encrypted: i=1; AJvYcCUsS29RlSACO/XXkAD2DFmke27w2Z+8rwMbgrfk0MOSNx07hkYnhaQB2FT4dvFJRnM0r0PwNcL5+1v5qNq8@vger.kernel.org, AJvYcCX5CGNV9ezAtwuNRLBhTGq/74Yww5P3N3awwkUIGq1oq+/ip5JzqWpg5FGMFEnJEaIxNEQFNXYbohKJ9jSWUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwghbUr7+sZ5DUUiRTPXoeTR0Th8JLF5Ki5IyH4CuIhE7OCfRxx
	2U/i2DE2kO9yKsIwONm4/zuah1v6ruFRT9IBdSgpLZrLzNVengxxVDsy4BJOAWaayxAQn/COQhd
	Ir3AGWdMGoLVd7kekB/O2SXDB41G/HJF3nxXU
X-Gm-Gg: ASbGnctoWEL3CyPz/0dp6G9Z8rsvs2/isjjUZSUANWBds1f7UDwcbEUmRqjp4bkQNWa
	uhLNdoXccWinGQyoLyJJuPALzKmh4jugDiG2EpyL8isdvaLvSyTrKmUG+1cvC6L4oMHd4xqCkjj
	2sdSEbGPwmw2Wv4ooA6DIRKwrIQzUb9FuI/JmC7alyHpFYKeHQB42Qmg==
X-Google-Smtp-Source: AGHT+IHBmcoTf1pKSVJ4Qs1EmlgTq6dRRrryRZzjNb64O8qXgaha5Fl7UTrBfHNERGvntYBc/pCWUQjN/W/z78mfTl0=
X-Received: by 2002:a17:906:6c8b:b0:ade:1863:6ff2 with SMTP id
 a640c23a62f3a-ae0bea31123mr364379366b.52.1750878490228; Wed, 25 Jun 2025
 12:08:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624230636.3233059-1-neil@brown.name> <20250624230636.3233059-4-neil@brown.name>
In-Reply-To: <20250624230636.3233059-4-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 25 Jun 2025 21:07:58 +0200
X-Gm-Features: Ac12FXwaS9AEfDue42o9-JY8CFIiCOaVfFmcQjiD4zbf4fcJcsht7sd3CzoqJAE
Message-ID: <CAOQ4uxi8O0kOEDjtB30Ax5oVe72wS_3eFtFR7OJAWPx4xLviSQ@mail.gmail.com>
Subject: Re: [PATCH 03/12] ovl: narrow the locked region in ovl_copy_up_workdir()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 1:07=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> In ovl_copy_up_workdir() unlock immediately after the rename, and then
> use ovl_cleanup_unlocked() with separate locking rather than using the
> same lock to protect both.
>
> This makes way for future changes where locks are taken on individual
> dentries rather than the whole directory.
>
> Signed-off-by: NeilBrown <neil@brown.name>

FYI I am not reviewing this one because the code was made too much
spaghetti to my taste by patch 2, so I will wait for a better version

> ---
>  fs/overlayfs/copy_up.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index 7a21ad1f2b6e..884c738b67ff 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -763,7 +763,6 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx=
 *c)
>  {
>         struct ovl_fs *ofs =3D OVL_FS(c->dentry->d_sb);
>         struct inode *inode;
> -       struct inode *wdir =3D d_inode(c->workdir);
>         struct path path =3D { .mnt =3D ovl_upper_mnt(ofs) };
>         struct dentry *temp, *upper, *trap;
>         struct ovl_cu_creds cc;
> @@ -793,8 +792,10 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ct=
x *c)
>          */
>         path.dentry =3D temp;
>         err =3D ovl_copy_up_data(c, &path);
> -       if (err)
> -               goto cleanup_write_unlocked;
> +       if (err) {
> +               ovl_start_write(c->dentry);
> +               goto cleanup_unlocked;
> +       }
>         /*
>          * We cannot hold lock_rename() throughout this helper, because o=
f
>          * lock ordering with sb_writers, which shouldn't be held when ca=
lling
> @@ -814,9 +815,9 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx=
 *c)
>                 /* temp or workdir moved underneath us? abort without cle=
anup */
>                 dput(temp);
>                 err =3D -EIO;
> -               if (IS_ERR(trap))
> -                       goto out;
> -               goto unlock;
> +               if (!IS_ERR(trap))
> +                       unlock_rename(c->workdir, c->destdir);
> +               goto out;
>         }
>
>         err =3D ovl_copy_up_metadata(c, temp);
> @@ -830,9 +831,10 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ct=
x *c)
>                 goto cleanup;
>
>         err =3D ovl_do_rename(ofs, c->workdir, temp, c->destdir, upper, 0=
);
> +       unlock_rename(c->workdir, c->destdir);
>         dput(upper);
>         if (err)
> -               goto cleanup;
> +               goto cleanup_unlocked;
>
>         inode =3D d_inode(c->dentry);
>         if (c->metacopy_digest)
> @@ -846,20 +848,13 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_c=
tx *c)
>         ovl_inode_update(inode, temp);
>         if (S_ISDIR(inode->i_mode))
>                 ovl_set_flag(OVL_WHITEOUTS, inode);
> -unlock:
> -       unlock_rename(c->workdir, c->destdir);
>  out:
>         ovl_end_write(c->dentry);
>
>         return err;
>
>  cleanup:
> -       ovl_cleanup(ofs, wdir, temp);
> -       dput(temp);
> -       goto unlock;
> -
> -cleanup_write_unlocked:
> -       ovl_start_write(c->dentry);
> +       unlock_rename(c->workdir, c->destdir);
>  cleanup_unlocked:
>         ovl_cleanup_unlocked(ofs, c->workdir, temp);
>         dput(temp);
> --
> 2.49.0
>

