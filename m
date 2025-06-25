Return-Path: <linux-fsdevel+bounces-52957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B381DAE8BD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 19:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFFC35A6CFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 17:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA291DA60F;
	Wed, 25 Jun 2025 17:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihutSd9k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BFA2D4B66;
	Wed, 25 Jun 2025 17:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750874145; cv=none; b=PuYBuI15kSSGTO92McPudE9+t717F6oNh0Hr7z6y/Zjgk67P79elXLDIO/cMq0SuToLcQRAUcRj4eZqQA7X1s4Z+/UuOB9YIFuHlPbcGmOWJ8LgiodIPc9rpoQtFP8gpN4J2KskiuzwPau5R3/7RgB8SswQSkknM9xnkMOWq1D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750874145; c=relaxed/simple;
	bh=3Ps2LWxr0Qj/WHYdtt5+dgVAKiRCKMXB0CUvldjUUeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o2OnL2LFCafVkAXTH0aYy3xSMzcyP6jhxAk+FZ7OtVCXCRoao7ffvB+Brr92hb+TV3/g3dxh7ANqblB0QwaQ8VwlPfqNSMbOG/nhOSNcvZyOogUmrCxguYsUuP3qiYl6GfGhVZ7P/hHBduymJd9ZfLuxrvdWO43vM8r1w6pRGW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihutSd9k; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-adb5cb6d8f1so26669466b.3;
        Wed, 25 Jun 2025 10:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750874142; x=1751478942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtugL7WxHa5us9MWHTT0doGfkNfwxNhIZaQAdtPaj2A=;
        b=ihutSd9kfgQSXwMaxq1BmDWQ3WkmMvgqfjv4/Z8YgFm7s8+k9x2BnxetT+kSkPvPP+
         HZ9FO0VAsq1eKwal2bWW/+xSpEZXwdIqOKO/vZgPygDpuRkyzVpLepFeg14IbgA8C1NB
         u6Z7WXju0C3IjxDbAQnd7cH31LuAVw67qVM56eYwZfi1vzVYO2D5XbaYDwWXoLmh94ws
         AiVSv/0PY/+i5Qi9HQgtv6tAS/d0YR589fpFaIIzlIOK2NMoE4ac73Go9ChiW6RwRu2F
         Qp9R6dmhthA3agyJuawig6y6gMM6gVmwq7Tb4qHStl/EEJ+dUEG/tEAAPZMBwZrQN52q
         JykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750874142; x=1751478942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AtugL7WxHa5us9MWHTT0doGfkNfwxNhIZaQAdtPaj2A=;
        b=ldOV/DI5L/8ee5aRnp8mK4EeiofjweQSEkXgKJM/NOByz2RWkVghMs0z3f+g6XAhSA
         6N8S3k98EvZ1JchzkHNBZAGdsM4yVFjMQK+tJHtrsP75huTUlEL4bh4zag+Vjoc4P/Fi
         ADQ1JciuI8a3yoaEf7GH96z/gz85ogv5rgGgSTVsc/ztYTgZXQpxlOrA55YyP9gpDjyB
         sPQ4Y0vZk7k08HgEllwaM4fEnN9hm+IauxrKvIGrOcj5+CY8f4OsRkaxtPiiP0HY1x9b
         1DkQtdyL7fUHbqco64ty/Ef04a80deFK6GIAgAHDTIdRFc6wAMXRCaasGM6Lr9MXUoTI
         iGpg==
X-Forwarded-Encrypted: i=1; AJvYcCUCwqtfVeUSoWvWP+uWTqhSXt/KYdErubkLBjNaJX6hTBPbfUWCPx41THCZqp8F9XMlJ5W2rAAoYQbsUISgIA==@vger.kernel.org, AJvYcCXdBOIjTNxHXkR6MXkuj6dPV2JNutbxR48RdhtWaN1oaYKrm/NkX8OpW/LJB+XZsfv96Ku8PkBFB6FncBLY@vger.kernel.org
X-Gm-Message-State: AOJu0YxHa9U6GLLPpVeWpPQYNTsi962+6LYE9fffoo2ym2GujK8m3suu
	O0bs34rD202OXPwSVHJClitFpOTlr2JeiY6OGy1+V1uSuCwSBOTefhm87U5GoYQWbhNvE6GM0HC
	23RQF0/SrZSKtepR0PhTkf8ippjxMmJE=
X-Gm-Gg: ASbGncve/Hp5D1X1hBFHoXiUskNUqb2jx12BJI4cnmmdDBYXVFnmkEq21i13SAT0kew
	twOoeir1ZmVdzE87Yz7Urm/vvj4mWT6WL1R7ZTUivLdor3m3gFIWOgKr4+yGYo4nLCJBVeTJvwe
	QVGNqCZX6zp42r+xXAn7XxHl7cG4LUjZPEKpzLjnEMwDc=
X-Google-Smtp-Source: AGHT+IHjRiDEwzCcf3jOrRQWLn2FoDb0IeTm68SM4EDzlbvJaXCP16Apypmy72AFeD+YpnfwOemuGw7lmmo2KO4BnGk=
X-Received: by 2002:a17:907:a645:b0:ae0:ae4c:6e90 with SMTP id
 a640c23a62f3a-ae0bea6ad45mr387568066b.29.1750874141420; Wed, 25 Jun 2025
 10:55:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624230636.3233059-1-neil@brown.name> <20250624230636.3233059-5-neil@brown.name>
In-Reply-To: <20250624230636.3233059-5-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 25 Jun 2025 19:55:30 +0200
X-Gm-Features: Ac12FXxA7L0xBfRWOkeP-ScYDjcbPAOTOaBIsXtY8-fdGDbFzGluO68_e1B0ye8
Message-ID: <CAOQ4uxg5EQ+Zt_RLXv-f5DuJONFzrL=9-z1tg4rfL12c-u7uJw@mail.gmail.com>
Subject: Re: [PATCH 04/12] ovl: narrow locking in ovl_create_upper()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 1:07=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> Drop the directory lock immediately after the ovl_create_real() call and
> take a separate lock later for cleanup in ovl_cleanup_unlocked() - if
> needed.
>
> This makes way for future changes where locks are taken on individual
> dentries rather than the whole directory.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/overlayfs/dir.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index a51a3dc02bf5..2d67704d641e 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -326,9 +326,10 @@ static int ovl_create_upper(struct dentry *dentry, s=
truct inode *inode,
>                                     ovl_lookup_upper(ofs, dentry->d_name.=
name,
>                                                      upperdir, dentry->d_=
name.len),
>                                     attr);
> +       inode_unlock(udir);
>         err =3D PTR_ERR(newdentry);
>         if (IS_ERR(newdentry))
> -               goto out_unlock;
> +               goto out;
>
>         if (ovl_type_merge(dentry->d_parent) && d_is_dir(newdentry) &&
>             !ovl_allow_offline_changes(ofs)) {
> @@ -340,14 +341,13 @@ static int ovl_create_upper(struct dentry *dentry, =
struct inode *inode,

>        ovl_dir_modified(dentry->d_parent, false);

inside ovl_dir_modified() =3D>ovl_dir_version_inc() there is:
   WARN_ON(!inode_is_locked(inode));

so why is this WARN_ON not triggered by this change?
either there are more changes that fix it later,
or your tests did not cover this (seems unlikely)
or you did not look in dmesg and overlay fstests do not check for it?
some other explanation?

Thanks,
Amir.

