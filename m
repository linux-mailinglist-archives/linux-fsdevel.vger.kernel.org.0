Return-Path: <linux-fsdevel+bounces-54632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0E5B01B6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 14:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7B81CA3113
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 12:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F2728C02C;
	Fri, 11 Jul 2025 12:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsbP3kBq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5B8289806;
	Fri, 11 Jul 2025 12:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752235395; cv=none; b=n4ODhC2e7+ow1WUTrZgeeYvU8a2VlCX90GwjmkQRqKD3mV9/zfybL03khgF3Mq1wRm90u3ZyhUvEUKdW6Kid9nG1CX9N5e0imzhPLzQBZudHjw7B3QTVG+PlJGWWr9K+fx0y780pD+rE8ZGD9TrLCEsynRMtCnr8S99TBFe1rws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752235395; c=relaxed/simple;
	bh=GHmiklsSSoFaYlx6ticLhE/+mC/tx5TCAsRWidtUGeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZtOmEAGOdDOgLJfe64JVKB9PhySx4myASG6cf/ekxeEOf/+wBkY0p9akWfBt0kpCjiAJxaRZWbjvlJsAlA6TJMNefuJQGLDzH9+c3jwkMmxk4TOG+d4BUqxjJwEpWrQlGr7h5jNFAKiSAR6aY2ChVZmBzp3Zfyf8SDd5UiTjdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsbP3kBq; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad572ba1347so275802466b.1;
        Fri, 11 Jul 2025 05:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752235392; x=1752840192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kFyngUYQXH1ZiQnoavIiPZPM+7Xj3I0MfuiFkP5sps=;
        b=ZsbP3kBqZff3DqHBKTMBxvIntn/mzoubnb++ZWUPw9IfxJ1mkaCg0z2/5JgyjWlMad
         zmvhshdqalcaCncQwuRqvWMi3xD+4JDfzw5sRYXlJx7Oh1A2Gd4stP9b9DZhEAMvcZ74
         S6muqsghZaOPBb8fNqSy+ygan80pNYB1RbamoGoFbfclFNYQy8KNOT5OBnupY9bzGmXj
         BehfnDyiOz1s923q2wWUUfgV+nOc+MafMWq3m2xvJWCpM48tT/PkQgtKZvrIneIQMqgc
         mhsvs7Nxb7urYkKB4sz2ZQaXpeJ8gVqy6wVajhFOB18St8c5/j+WJqJd0/avO1GKpiPt
         etxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752235392; x=1752840192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kFyngUYQXH1ZiQnoavIiPZPM+7Xj3I0MfuiFkP5sps=;
        b=BRnhbhhxyYO9bG2RMCszzalJzrrwBmO2nEcwQns75jAJvo3vNewB+oiK9bzoKTYHP4
         D+g4IqItJvnfJ9nUkftyj7vIcfF6UAN+QEJg8vi773rinV8O/zdQ3qu+cl5Htid//dx0
         EDN8VUDX3AqqGYccza0NBWVkP1O7IxRxPJ+J861yJa9zt2uxZeSnSEeQTWvGeKO4qyMJ
         NbYRNEdzCkFgFtxZw6TMhEIwZIHUl6Ts2xQqzKH1IKiyspjo7UIXHzcHKuMqE08lhc1p
         pdjUgAtrc/tUtMFtKz9jXd+kR3MkzRpcc4nTgQ2zW5/v7lH3ks87thxFcry6ixdJbzZ0
         YfPg==
X-Forwarded-Encrypted: i=1; AJvYcCUCdMCz0sUyaONr7RB7hUDP14XldWSA0+r27h1OBrf9k8+I0QF+3lg6k5kv0q3lkwx2Cat1yDXeqJOg8kKF@vger.kernel.org, AJvYcCUQ47QSR4uPlR0spjoRkj2IONolA5aVQsd9Nm6hzB/3Ygn9URCNQ/l+QWA12snr0MRx6uecJEdKir5ML7g2UQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQcCToffuoDNMYaPwleZJP7rjaRoqEnvH0Z7GpeF7IJkT8NcMU
	t89fxdAZ8aFOjdAu9NMgsqKgi1L8s0tQQaYxNr1RSxzjy8SGYw7FTt9f3Y04qmzX6rULejDMc14
	+F/+xmnhu3/2xDHzbQXC6yzPXoTRnnGE=
X-Gm-Gg: ASbGncszbJf0a7V7Vdq6ZsBDFKNExIb/aNrqAcZzDu2jqBzB8c4q5V3UGIJBvnG2b1V
	ewd+/13rnGPvghheb+jXRM69exDbzGrgTjB0Kd7YxwDlNrpb9efrfxUESqLyMmjnsDdh8tz6vP5
	92j0f1bHtKGuVa54dN3yLYE2sayI/i5UW4K5xmYWsyCgdVIbdhHJiALCJzp8SABOzkm9v65AclN
	IZjdKE=
X-Google-Smtp-Source: AGHT+IFtO8PsgcPbcQuGhyC77cQRSK0LKwdcwKhMF7Ce59DZnfO6E/9M0MhjhFda7o3itOyVDNN40V84/hp75cEF3Ko=
X-Received: by 2002:a17:907:2d22:b0:ade:405:9e38 with SMTP id
 a640c23a62f3a-ae6fc74e7aemr292441466b.24.1752235391384; Fri, 11 Jul 2025
 05:03:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710232109.3014537-1-neil@brown.name> <20250710232109.3014537-5-neil@brown.name>
In-Reply-To: <20250710232109.3014537-5-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 11 Jul 2025 14:03:00 +0200
X-Gm-Features: Ac12FXxFGrlIxKlPuujoTZZznOz8UAyIpANSctOXWXZEFrUnD6PG9_LZXm6K7jE
Message-ID: <CAOQ4uxih6o7-3ESpktvP1YPVtaY4TKxO+WVmUEnE4ocQEPZE8Q@mail.gmail.com>
Subject: Re: [PATCH 04/20] ovl: narrow the locked region in ovl_copy_up_workdir()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 1:21=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> In ovl_copy_up_workdir() unlock immediately after the rename, and then
> use ovl_cleanup_unlocked() with separate locking rather than using the
> same lock to protect both.
>
> This makes way for future changes where locks are taken on individual
> dentries rather than the whole directory.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/overlayfs/copy_up.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index eafb46686854..7b84a39c081f 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -765,7 +765,6 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx=
 *c)
>  {
>         struct ovl_fs *ofs =3D OVL_FS(c->dentry->d_sb);
>         struct inode *inode;
> -       struct inode *wdir =3D d_inode(c->workdir);
>         struct path path =3D { .mnt =3D ovl_upper_mnt(ofs) };
>         struct dentry *temp, *upper, *trap;
>         struct ovl_cu_creds cc;
> @@ -816,9 +815,9 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx=
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

I now see that this bit was missing from my proposed patch 1
variant, but with this in patch 1, this patch becomes trivial.

Thanks,
Amir.

>         }
>
>         err =3D ovl_copy_up_metadata(c, temp);
> @@ -832,9 +831,10 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ct=
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
> @@ -848,17 +848,17 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_c=
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
> +       unlock_rename(c->workdir, c->destdir);
> +cleanup_unlocked:
> +       ovl_cleanup_unlocked(ofs, c->workdir, temp);
>         dput(temp);
> -       goto unlock;
> +       goto out;
>
>  cleanup_need_write:
>         ovl_start_write(c->dentry);
> --
> 2.49.0
>

