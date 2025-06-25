Return-Path: <linux-fsdevel+bounces-52970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F0EAE8E07
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 21:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 332C97B1727
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 19:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193712E2F16;
	Wed, 25 Jun 2025 19:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cilijuW9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE66F2E3376;
	Wed, 25 Jun 2025 19:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750878328; cv=none; b=m2pKxOBw1r0muTdcR21uIpnOE1at7Ib6k7YaGshPXRD5I5ogwsdjinOccSFokjSngld+pURVOd1sMJQZJ9kvf/ZMAq/xSS7oevxx0YDuHIDHSif4Opqzeuuy3i6RUzT3WMjGZFI+aWgEuo4fUMr4we8fVYvfOeRlYqPvQhfBMkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750878328; c=relaxed/simple;
	bh=lO+AB2R1NCX8vf6NuJoMLmpYrYTOWMZZmzSFeEF9hc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sguop1liFLU5yPOnGEiTlUpjcgep7ZillM3K37qdSb0ceOOV2GJLNkAAuQrB40xaHXPFbU3aAzloFHn2paQDnm6fFbhoW/3d+6S58UWFCBlbgqUFN0gtnUbDQJ2On4CNJ1VxVHujKAzpRQP+u0nPEylarKmoHQq95C6I933KT+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cilijuW9; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ade5b8aab41so53655066b.0;
        Wed, 25 Jun 2025 12:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750878325; x=1751483125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdfHW9EcNzdpUREaVuEP4+UZtUO+XlrJH4J16ilgcVc=;
        b=cilijuW9H+WvpXIrz8L6UW7jZ7YJECCnkriPEx9Ig6l2W+hjkzRr4Wt3RqVg/Nl5Ch
         XvT+fhlICcv4zs16Q2tGCggm/rYUU+eIxtwBahm09C5k9g+OwwCeWJbj/WO1xTu2eF++
         TA7H0nUr0LEkyTFrKUqSRvNq6922CnJxrdR9KDn1QNMCSQWfyDPpaQBmMPPv9tyTWz72
         RPfkdwSm/jDuScWdQsZQBhqpNPEac6UCW5p7ZxKcvz7FKtnGGOSxu6OneY+TFyNTOdXl
         qDdcMcjBEIlSeWHtfktvlIzDzeBkLkzviEembn8DMbQHzhRIFzG6myUVNxTUeAHVBU4O
         ohkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750878325; x=1751483125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdfHW9EcNzdpUREaVuEP4+UZtUO+XlrJH4J16ilgcVc=;
        b=xOCjQOyimSr0pNDhEUpK4eVTR4ir21s7diOAEyZpouPVDkVYG5iEGXLaP7KU7v1cen
         JchnLSpjzB5dUhNKTVtZDy9yabWAkeryDTPhvX1cbQTfUehnliQcGapaHFsQo4KwVOgI
         QC/yne3lGWJzMxCf8LP67o0vDWOp9i1EvnzFlfRfTwxs4Wv+oq0UfekhMLsMpJL1M4RJ
         Ulpt0wiNg9svHDtXzrFpjkoY21/doT8R968lp3RAsmSk2DC03RAlyk2NU4j4ZUMa4/TB
         cWVhMzWf4n35+9YuO9Vt/UEnc3UuhaILwd5+QSuSEzxQA3EvKvHhvTn80KqNmsaG0NqU
         MAFw==
X-Forwarded-Encrypted: i=1; AJvYcCXRWIAD7Eo746QaLnU97VjiRCWblDCUoy9NtlUO1d8VfEQ78oAxPAxCpo7zfhTC1U4YNVo2FGe1jGCNO72lRA==@vger.kernel.org, AJvYcCXv9qXUqnQCB7HQc6rYKqkZLBeENh+KrWBJwBW5hnyZPOc/uV+jN7D/jTPJM00xj2ah6e2wEZzw96MG29oj@vger.kernel.org
X-Gm-Message-State: AOJu0YyhFwLq+o5msRuzYoE3s/zp4LfJbPSDyc65aB4LM+vZOMaq7Tz9
	9H/hj1+aFkvXaelNpSCrT8hY/WyPTe0ChGkbzD8tXaYy9OZ99kG80VkbStMNQvwmhNgFU1MoVUA
	8HzbX2afagOrqb9BBmSFm0sk5x8eHJb4=
X-Gm-Gg: ASbGncvRo9/iDLUBxaCZ3JoEjTmaxBYQy3Ufrkkz1KrMcLiYMJrGErA9DJcT+TCHDZm
	wP+6V0k9uAIrINBmXwjd6DkhE4fh+twIdksff5VzmimRh0wuz3HqNY4oqzZjqMYYOz2pDH32VaE
	XzOXTdbp3dANGf6fgjhNJq9FUxoFNnLL/gLINoPmaJYPo=
X-Google-Smtp-Source: AGHT+IEWP3h6CcjymD/OesLSDdjqr9+4TfrW1mL0073/ko35J20HpemS3nMy1aJdu+0gtOhKqa8LRSu70kAueQOkZ6o=
X-Received: by 2002:a17:906:1952:b0:ad8:a41a:3cba with SMTP id
 a640c23a62f3a-ae0bee013fbmr368244766b.43.1750878324822; Wed, 25 Jun 2025
 12:05:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624230636.3233059-1-neil@brown.name> <20250624230636.3233059-12-neil@brown.name>
In-Reply-To: <20250624230636.3233059-12-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 25 Jun 2025 21:05:13 +0200
X-Gm-Features: Ac12FXzZLmKeZI_1ZsXPjkcSNdhg13TPmSI1yhAa1xpYV8O8cv2WEIsVSbcHCjk
Message-ID: <CAOQ4uxgRPp4U7nxS=DJMi7LzE0sMB9nGCyQ0wb-TNkv8k5Zs3w@mail.gmail.com>
Subject: Re: [PATCH 11/12] ovl: change ovl_create_real() to receive dentry parent
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 1:07=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> Instead of passing an inode *dir, pass a dentry *parent.  This makes the
> calling slightly cleaner.
>
> Signed-off-by: NeilBrown <neil@brown.name>

nice

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/dir.c       | 7 ++++---
>  fs/overlayfs/overlayfs.h | 2 +-
>  fs/overlayfs/super.c     | 3 +--
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 78b0d956b0ac..9a43ab23cf01 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -164,9 +164,10 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, str=
uct dentry *dir,
>         goto out;
>  }
>
> -struct dentry *ovl_create_real(struct ovl_fs *ofs, struct inode *dir,
> +struct dentry *ovl_create_real(struct ovl_fs *ofs, struct dentry *parent=
,
>                                struct dentry *newdentry, struct ovl_cattr=
 *attr)
>  {
> +       struct inode *dir =3D parent->d_inode;
>         int err;
>
>         if (IS_ERR(newdentry))
> @@ -227,7 +228,7 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, st=
ruct dentry *workdir,
>  {
>         struct dentry *ret;
>         inode_lock(workdir->d_inode);
> -       ret =3D ovl_create_real(ofs, d_inode(workdir),
> +       ret =3D ovl_create_real(ofs, workdir,
>                               ovl_lookup_temp(ofs, workdir), attr);
>         inode_unlock(workdir->d_inode);
>         return ret;
> @@ -333,7 +334,7 @@ static int ovl_create_upper(struct dentry *dentry, st=
ruct inode *inode,
>         int err;
>
>         inode_lock_nested(udir, I_MUTEX_PARENT);
> -       newdentry =3D ovl_create_real(ofs, udir,
> +       newdentry =3D ovl_create_real(ofs, upperdir,
>                                     ovl_lookup_upper(ofs, dentry->d_name.=
name,
>                                                      upperdir, dentry->d_=
name.len),
>                                     attr);
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 25378b81251e..3d89e1c8d565 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -849,7 +849,7 @@ struct ovl_cattr {
>  #define OVL_CATTR(m) (&(struct ovl_cattr) { .mode =3D (m) })
>
>  struct dentry *ovl_create_real(struct ovl_fs *ofs,
> -                              struct inode *dir, struct dentry *newdentr=
y,
> +                              struct dentry *parent, struct dentry *newd=
entry,
>                                struct ovl_cattr *attr);
>  int ovl_cleanup(struct ovl_fs *ofs, struct inode *dir, struct dentry *de=
ntry);
>  int ovl_cleanup_unlocked(struct ovl_fs *ofs, struct dentry *workdir, str=
uct dentry *dentry);
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 8331667b8101..1ba1bffc4547 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -617,8 +617,7 @@ static struct dentry *ovl_lookup_or_create(struct ovl=
_fs *ofs,
>         inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
>         child =3D ovl_lookup_upper(ofs, name, parent, len);
>         if (!IS_ERR(child) && !child->d_inode)
> -               child =3D ovl_create_real(ofs, parent->d_inode, child,
> -                                       OVL_CATTR(mode));
> +               child =3D ovl_create_real(ofs, parent, child, OVL_CATTR(m=
ode));
>         inode_unlock(parent->d_inode);
>         dput(parent);
>
> --
> 2.49.0
>

