Return-Path: <linux-fsdevel+bounces-54647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 331CBB01E03
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 15:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EB5FB44FEF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 13:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45912DC33F;
	Fri, 11 Jul 2025 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDEOnxBb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904A9299AA4;
	Fri, 11 Jul 2025 13:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240918; cv=none; b=IXfxbuzP1usDgmyXMiUNoblCDz6txFIgkmYKInc1n8wQnaCb9SCP7PKVSMKDQ3uKrcrcNFQY4buyg+QXGh+8uZmKQ9rx4RCtwohnolbT6VyzJ2nJEqElDLCChCxdofTeUktDbqoAssNXYL778qpFT0BkcRLOgQ+mR8ER1WkfwQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240918; c=relaxed/simple;
	bh=ogxE0SuztJysg1c3rn4HNdeRC9BLOaub31Keriaplgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r1v0Jttj7U6Vhtln6RAqIH4CqzsV6Du6GfUG/mRgAl/6jgtqt+M8Yds4HUIx5aK3GXw+l6TmfOGSPikfaOyNMUwWgCRKhyzHcDwBhFcVNLYFHJVN1xtSIX8HFRtn2emBHXCzanzCXVVzGe6UFgkdNrK3adIJOaxkxvphwdTFpKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDEOnxBb; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae0d758c3a2so327039366b.2;
        Fri, 11 Jul 2025 06:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752240915; x=1752845715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvIlP8+APvJgjEhMKmZmige83bRQmLZ5cW3IdsYsIQ8=;
        b=CDEOnxBbUhZrEUl48XBbcHYnCaZAtgN4CpbACeXJxZ4EA/19btf2SL2ezJAqbhK61o
         l8vYZUPtB0rXHEwte9JYVE1fe3btFCu5esGEvFCh/DGZ5Vw3dPIzumtbVXbd4J0nFrN8
         JEO8k/q22NSo3xF8mmVHQVTYJLZyrLH1i6Ls/dwuOVGaV9jJmO/5lIwLSxB7l7RY56d6
         DZqRdVybjDdAaOu86mpby6WU+g31zZa/Gavc4CWjEOEfxKJ2/LOn1wn8NtvajAGIyKTT
         mY/fuZ3RtB4XaXN8QYK/KdJHbStjHVfogQFgwmmvC1V9vj8Q40W+EOh6r5MqRmGl9xbF
         w4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752240915; x=1752845715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wvIlP8+APvJgjEhMKmZmige83bRQmLZ5cW3IdsYsIQ8=;
        b=ZWS6QeoEwZlCTyk6n8MfkcusruGEQGC0EB+wR18XhJms2IReDUEEedzNpCG1KvfyGC
         QwHaZcGQyMQMOhlTqRpq/HDv4fwvDRFlejYjm56l3LeTbm44vjx2izrYGG/dt5SJW4Cs
         tbXW637cWmCGDlOtMS7cFJ5CKYEdg4/LWOpD1Cng/1M9NkTXhfCkYdIn8bySfrc06iVq
         INk+Jbxf/MPT4KMFg+QfWYLvX1h9utnr7tqWf3M1JbcaxXKj/ayJ3LkfPhPSHssE9P30
         JDl1xF9CRns9LsD5hax4YJvTS+F2o4e/84ba7yRbepDwyr7xToX66nEeTKMRd0hGdvlg
         VcHg==
X-Forwarded-Encrypted: i=1; AJvYcCWMA9dbgE7i0fJsX7rs02e8t0GCNcGTdXJUNWiVz8JG0SPcfQcjbBnntIKswCBCbfN2SOHlcf4iLVYoDyHDYQ==@vger.kernel.org, AJvYcCWVpSOTPXPy7BiRvypr9Dd8mwAagpqmPCcV7JIdnze2JGjhUbUS58m29k3HNAKm2YDZ8RxbmVO9lK53fdWT@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4f7KWPUj+tjpjd375SSAlAMbrZTX4zwLA4UNeZSz5ddT8wZLR
	t5WuYxTA+cPV7xUvlfo1vpLNMJIVHGDshVicTK53TbexOd0uHxgpgGTQegJAH9iIt42B8QiWQ5x
	fNlgCUOenricIksYiadb0hXx7/MTj0Ty/ru9xjPtkcg==
X-Gm-Gg: ASbGnctN34Pb+I46ddIqNeVsgqsIFKy7GZKa9V2vU/xg7T9FWsD957hYR8IAON6sdM7
	S/xlGaTUOobjp6dBIBAMl23T56EjVkYRAGnoDdX9hamzPogVNQ6Ke5G4NJgroxU9RzBL0G0q2n2
	//OnzlvGu/c4sqzWQAqPDIZh4w4KA5+0lakCkVKALI1WPBJTemqg/0Zq3EGSdpJPROvmRVH16tD
	rMVkbI=
X-Google-Smtp-Source: AGHT+IHv1KujamF9ABr9I9lg4vD1t95jdQl2WdGS6/ETlOXTSLxNgBGoFENnLP99R2uenq29A21sqOpJsSFr2l5Qsz0=
X-Received: by 2002:a17:907:1c93:b0:ad8:9b5d:2c1e with SMTP id
 a640c23a62f3a-ae70125f3d1mr270113966b.29.1752240914529; Fri, 11 Jul 2025
 06:35:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710232109.3014537-1-neil@brown.name> <20250710232109.3014537-14-neil@brown.name>
In-Reply-To: <20250710232109.3014537-14-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 11 Jul 2025 15:35:03 +0200
X-Gm-Features: Ac12FXx9eX_JaNZYcAzWoSM6u0rf5KrXevXbrQB3OGWWvol4qC_A2xjiRzkQ3xE
Message-ID: <CAOQ4uxgfqV-AFQsSaORVamkdxe-O4++yr5cJZEu9QStDPkpT2A@mail.gmail.com>
Subject: Re: [PATCH 13/20] ovl: narrow locking in ovl_workdir_cleanup_recurse()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 1:21=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> Only take the dir lock when needed, rather than for the whole loop.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/overlayfs/readdir.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 3a4bbc178203..b3d44bf56c78 100644
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
> @@ -1137,16 +1136,18 @@ static int ovl_workdir_cleanup_recurse(struct ovl=
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
> +               if (dentry->d_inode) {
> +                       inode_lock_nested(dir, I_MUTEX_PARENT);
>                         err =3D ovl_workdir_cleanup(ofs, dir, path->mnt, =
dentry, level);
> +                       inode_unlock(dir);


parent_lock()

Thanks,
Amir.

