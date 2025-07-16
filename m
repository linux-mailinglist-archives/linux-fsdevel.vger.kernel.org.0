Return-Path: <linux-fsdevel+bounces-55098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC75B06E9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 09:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56BB050349C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 07:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B81228D845;
	Wed, 16 Jul 2025 07:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8Lwqsq2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120B5288C15;
	Wed, 16 Jul 2025 07:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752650050; cv=none; b=FNyVHvCG+xPiXqbJkSnVBz0tLmgOjCJsJ9GTCOfMiTCV2MG9zrpR1q04wo50dlPKp68m2An2PlksTcE0rdsz2ESDmFCtxXmK3ho1dWoEZlaiUubUjl2D3exXBmZ+SpqEtRDuqpwoGYSqBHXoHf1L6MiWJrPfzMOMniSnS8mqer4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752650050; c=relaxed/simple;
	bh=BBfLXZi0OaWpUDKR+l9SocwlUg1hehFsJO8N+FHXdN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHyMNrXPaazppvi19rY4WoCJBXHQEhrJ/wBGUJrZgM78Jx79CgG/j4cuiTGAfAyV/VaZtycRbFzh5qtE6s6AmmOHIOhpBAO0evjV25HzhGvBfEhw8FG28P/cfF+DPNkgzMsfoVe49u2JPI4sXrkzRg9RE/p98ZzGwQSi6jptjiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8Lwqsq2; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae3703c2a8bso1165971366b.0;
        Wed, 16 Jul 2025 00:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752650047; x=1753254847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUmsE3N7oTvUAwSw8uhNgYxu+EirDzup35vNQF8XsGc=;
        b=a8Lwqsq2y+e1Iq1/ij0VTO2CedV8Toruv2uL8UvJDTWdf0wCZ2M/9bSMn3+9y80u7p
         Bo/64op7DvrfgCOOohaf3zU64WfGS2RJc0DaIvaf+X8igwDZQQdVUI1wUP4YZ/Y1/LKZ
         60iUeKA3QHv6mK/xtC2R45FJ6doIv2HPiPRjmQK9S+ERVes6ekMLNmNB4qmh1LJg/oQQ
         vBEwg6/esrPUPcp5OdWWQ2xy2/QU2azvZ/ewSiq39MRFm5zQC7ld6oPJmvc5g5XWiHRh
         U5v/WSCWEOSQEykbGVn03dOM9z+qc9wmw5xXpppC+DYXAK+nFAdenWxq8Sb3od941B/2
         uYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752650047; x=1753254847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUmsE3N7oTvUAwSw8uhNgYxu+EirDzup35vNQF8XsGc=;
        b=sVNyvQ4szKtf9MIDmH//XYZ3HWw2j9DRX6BIzXROWgRJDgsKSylc4dA6LK3GdrVjPm
         FVtJc5quFeZZB+b2A3w2trzE8dD5hA7g/WRLg4Nub8a/vmKbv03UjiCQ6nkU6yc/iORp
         2KSmL1LrEi6azjkNdqGf5T90TAeZ7ByiyIDQN3raA70pKc5dRUHSaBuRPq42t+bpJj2J
         TDrpABK10ima2sxSDvlGfR7/qceBiGrHIuaQxzwhoxZLsxWWuoMNxOTzLYYo4KcQEhz/
         zrjh3nW0pG8iaJZtcrhBW2cDHQHqY5pwRnGewoHW6TmcVvhodzl+hM5mCRalNbRL3kto
         5seA==
X-Forwarded-Encrypted: i=1; AJvYcCUOHeW2Rsc6U6jkwbug3IFNq+D4Zo3tvhHUy+N8WNIaqUPH8lMAWUzBVgwDQrY3s5WasczTfvp0NMJlNYvZ@vger.kernel.org, AJvYcCVQfaxu6f0uChNf3toGeJXqTn5mB3G+isMjkfnHH5E1a//9bAifCEYjT4RRvb9l/HrGRW1iVFrCvHhesqCRgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxundVuKS3wL/p6fNCnSiMKB32Ot0tKKnBY7C9I227ds2Fz3XJE
	d1qFc4xXwsEzEcOaK2RSAkoCLSTJimoMVLwx7LYYb1RpFK6rq+C1VmLFnu2dRfIayGfo766ym9e
	mk2FapCuXtTSdO2IHDRJVMCRWGVwWK7iJk/+ARSw=
X-Gm-Gg: ASbGncu6wioGzV2GUKq6Y9j/LJytAUbp+W+iPvCBDU7wDSO/ZNb6yV4GXOpdtNZcCaA
	QBnPmP2A2zscVpzCXzPiHDPsO3jwIYihJ/hHVcoDI3YhvwbJPgviOPwg1KFA8z6kCIzeVuNbQ5X
	mnBWoyFU6yteW5jXkZJCytpVFB3NvMotG0U1YEH7Om4QvRTymdiz0DYyeuclaP2Au+QNeC8bFfb
	qSJoik=
X-Google-Smtp-Source: AGHT+IG5+/GeL6JIafsEIJDRwVamx0Jqjnb55IXdQINYT0tPvQZWMJF8IWtQWhSl6y7GKaojXfU3a8lu2BP1YGfqX1U=
X-Received: by 2002:a17:907:7f09:b0:ae0:35fb:5c83 with SMTP id
 a640c23a62f3a-ae9c9af8913mr198933166b.28.1752650047008; Wed, 16 Jul 2025
 00:14:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716004725.1206467-1-neil@brown.name> <20250716004725.1206467-10-neil@brown.name>
In-Reply-To: <20250716004725.1206467-10-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 16 Jul 2025 09:13:55 +0200
X-Gm-Features: Ac12FXyJZ_6B9N1oGtcSvnL80xUnI7CL6TOWS86zYIS_yX7tURSnaX-FjQX_dF4
Message-ID: <CAOQ4uxioySALf-q8aQ46DhO6v=xhwswebt_YXsOkXDddc=SwVQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/21] ovl: narrow locking in ovl_rename()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 2:47=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> Drop the rename lock immediately after the rename, and use
> ovl_cleanup_unlocked() for cleanup.
>
> This makes way for future changes where locks are taken on individual
> dentries rather than the whole directory.
>
> Signed-off-by: NeilBrown <neil@brown.name>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/dir.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 138dd85d2242..e81be60f1125 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -1263,11 +1263,12 @@ static int ovl_rename(struct mnt_idmap *idmap, st=
ruct inode *olddir,
>
>         err =3D ovl_do_rename(ofs, old_upperdir, olddentry,
>                             new_upperdir, newdentry, flags);
> +       unlock_rename(new_upperdir, old_upperdir);
>         if (err)
> -               goto out_unlock;
> +               goto out_revert_creds;
>
>         if (cleanup_whiteout)
> -               ovl_cleanup(ofs, old_upperdir->d_inode, newdentry);
> +               ovl_cleanup_unlocked(ofs, old_upperdir, newdentry);
>
>         if (overwrite && d_inode(new)) {
>                 if (new_is_dir)
> @@ -1286,8 +1287,6 @@ static int ovl_rename(struct mnt_idmap *idmap, stru=
ct inode *olddir,
>         if (d_inode(new) && ovl_dentry_upper(new))
>                 ovl_copyattr(d_inode(new));
>
> -out_unlock:
> -       unlock_rename(new_upperdir, old_upperdir);
>  out_revert_creds:
>         ovl_revert_creds(old_cred);
>         if (update_nlink)
> @@ -1300,6 +1299,10 @@ static int ovl_rename(struct mnt_idmap *idmap, str=
uct inode *olddir,
>         dput(opaquedir);
>         ovl_cache_free(&list);
>         return err;
> +
> +out_unlock:
> +       unlock_rename(new_upperdir, old_upperdir);
> +       goto out_revert_creds;
>  }
>
>  static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
> --
> 2.49.0
>

