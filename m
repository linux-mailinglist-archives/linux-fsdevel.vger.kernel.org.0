Return-Path: <linux-fsdevel+bounces-54645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70C7B01DAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 15:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2550E175E31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 13:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAC22DECC2;
	Fri, 11 Jul 2025 13:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDCYejiE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD262D3EDC;
	Fri, 11 Jul 2025 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240852; cv=none; b=Sc4sByGWOriEmBKJqh6IKXrU75KXcohglHm1c9KYiCninZu1N8rG03/ycLsnvU8DxPQr3BfD0PUWT9kMOC5H4OYHl7EZlB03geRYXjAGcjYDBrS/NZoRcOX9UInGAu+TETMo0n0fcDswt5Ffin6dXawQOaTisMatgU7Lp6pcfmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240852; c=relaxed/simple;
	bh=jGjedGfEZAEkRpP1YXiQZPzhPj4gOjvBUBE6mLWfnvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AvDxHosARQ82CPVGWp3ml4yo4bESujvIZh/2IbepOl/npXBh/+5aLD+TsPLcW3nPwEmMZYr0LQt4lSyDvXERTYphwPrrr0GgTiSqEqJlx9G4XEO7rdj3V1lnvyCO6cdI/q6uAJ2h9T+cMmcjLTSZrWFkOLdST55gtssNjvL9oEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDCYejiE; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ad56cbc7b07so374387766b.0;
        Fri, 11 Jul 2025 06:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752240849; x=1752845649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25Ync+dD+UKEvHtSRsjy2JBcs+ZiSxy1QrQ2c2cV8Uo=;
        b=PDCYejiE07Zs0C96L+isThd+edhMVajxmZdKAiRwMME/UWFyOhmMwQFHYdnmlgso//
         Q3A/YHkoMFXlXcMjPMBt/oncVxp6s75sgXyhtGSXZZL8BL0AYg+S33rmY8dARCCJQjV5
         Ci4gRMpCgQq8Agk4oG7hguwPb9uV1JI3PuqaSOyfpmsZPo13BhI0lW5pq4vp8+/24go7
         AKzXmRQ3lXQwpTiifmxnSLwpGLZIV6qRUndJUM2hUq3ZpTjMwAt9CtHsQFe8AZsj4U5+
         i46LwG8u9pOv/Kcwqn9//TFwwsXVSJbRw4g5YiGNUhM1CGPEAhhQONrXMcY7zBFE12Os
         /9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752240849; x=1752845649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25Ync+dD+UKEvHtSRsjy2JBcs+ZiSxy1QrQ2c2cV8Uo=;
        b=MPUU0jsGbyccRqzNGDL2Bh7NF5Uo6bStCijS4mIYynBg5Co5ceBIzxPuFxVGmjkINW
         GeBMT15XVpJ2z0rZO5+s52RyfIL1hM52pHyLINrXEZD6XOreJu3yZMmmGq8OgZsr1l1Z
         OrosayhcoJtWHbNEJ85Zbqei8cKikSsCEuxvBNvN79QAZIfrCHFOL2uvQ5GLhXf5haaJ
         OY5n6aKygftCWaKOSRdRoeSWhKfQeXJ/H/5RNAXhZy5XRfX+JgbnrA0BnIAu+cA4k7ZI
         0daYLXhtYXPIjMFEsGAveTz2cxsVJ0mcVpTOCl20lhb2FzNHrtCWQiXAynFdWsEsXc1d
         viyA==
X-Forwarded-Encrypted: i=1; AJvYcCVALUmRUdpgirA4pbY0Z/LeDHSkh/Eb4tf3YSxCDms7f0FsOdQzbTy8++G0HFuk0Fo8eoyKWzVfzpTUotFaEw==@vger.kernel.org, AJvYcCW4pGI3zwLRr16I+HJ9BEdPJ0ujmAmYsfYb+BkHxOjW/azLgYyt7w+zoXpwQ/UENwPpsV/awmb7kKmeLr+W@vger.kernel.org
X-Gm-Message-State: AOJu0YzuJKcU9dmrjwJovEtizJFWgJp1gK5xYfwGop70rSWsyRYZpkiJ
	YSftVqff/xqdc7EAePPoLvAMNlfYyyZEV7cyVfnHYaXQI8UEN8/Muhgs3j9019nYqSOJSVwO1Od
	fEGWbteGKGRYNDCqRoeAS7RwZilCt9vM=
X-Gm-Gg: ASbGncusJROuREp1t/KH62N3b9BIHMlsZAnPyS+RN1kY/D6DZO07zesaXgoDK1GDaCY
	Q8d4uHCMu/wOY2Shg9SCrmB3UPVfKE2Pl6d87HbFAYqZvsiug6Wrz5lUFaoXIe0UYxsaa+106Qv
	PXQo3JQUUO7OAtPuP96Br6xqqt2BQdLPU9nsbgYL3k+edjHMxnIpAaSBZ1CsyjhM1y4BNEZ0MH3
	o2SbOY=
X-Google-Smtp-Source: AGHT+IEWgBskudsUnvZmIiNZ4IBD/XZ1QH62ddQ8qRtx3ZiLm2ObFj1uT4RyVbeCj6blbX6dj1/kZUCRn68WFKcpiOc=
X-Received: by 2002:a17:907:84a:b0:ae3:a240:7ad2 with SMTP id
 a640c23a62f3a-ae6fc6aa6dcmr351490366b.2.1752240848330; Fri, 11 Jul 2025
 06:34:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710232109.3014537-1-neil@brown.name> <20250710232109.3014537-13-neil@brown.name>
In-Reply-To: <20250710232109.3014537-13-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 11 Jul 2025 15:33:56 +0200
X-Gm-Features: Ac12FXxh4Dj1EKwoUyDCe-QVmBhzR23TDkH56EVk3Xf-0b7xVIAlRHXkdvsap4I
Message-ID: <CAOQ4uxiuEKO4yK_=S8BmVEYFkcDvf6X0+YZx9+56K7F+korOGg@mail.gmail.com>
Subject: Re: [PATCH 12/20] ovl: narrow locking in ovl_indexdir_cleanup()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 1:21=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> Instead of taking the directory lock for the whole cleanup, only take it
> when needed.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/overlayfs/readdir.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 2a222b8185a3..3a4bbc178203 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -1194,7 +1194,6 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
>         if (err)
>                 goto out;
>
> -       inode_lock_nested(dir, I_MUTEX_PARENT);
>         list_for_each_entry(p, &list, l_node) {
>                 if (p->name[0] =3D=3D '.') {
>                         if (p->len =3D=3D 1)
> @@ -1202,7 +1201,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
>                         if (p->len =3D=3D 2 && p->name[1] =3D=3D '.')
>                                 continue;
>                 }
> -               index =3D ovl_lookup_upper(ofs, p->name, indexdir, p->len=
);
> +               index =3D ovl_lookup_upper_unlocked(ofs, p->name, indexdi=
r, p->len);
>                 if (IS_ERR(index)) {
>                         err =3D PTR_ERR(index);
>                         index =3D NULL;
> @@ -1210,7 +1209,9 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
>                 }
>                 /* Cleanup leftover from index create/cleanup attempt */
>                 if (index->d_name.name[0] =3D=3D '#') {
> +                       inode_lock_nested(dir, I_MUTEX_PARENT);

parent_lock()

>                         err =3D ovl_workdir_cleanup(ofs, dir, path.mnt, i=
ndex, 1);
> +                       inode_unlock(dir);
>                         if (err)
>                                 break;
>                         goto next;
> @@ -1220,7 +1221,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
>                         goto next;
>                 } else if (err =3D=3D -ESTALE) {
>                         /* Cleanup stale index entries */
> -                       err =3D ovl_cleanup(ofs, dir, index);
> +                       err =3D ovl_cleanup_unlocked(ofs, indexdir, index=
);
>                 } else if (err !=3D -ENOENT) {
>                         /*
>                          * Abort mount to avoid corrupting the index if
> @@ -1233,10 +1234,12 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
>                          * Whiteout orphan index to block future open by
>                          * handle after overlay nlink dropped to zero.
>                          */
> +                       inode_lock_nested(dir, I_MUTEX_PARENT);

parent_lock()

Thanks,
Amir.

>                         err =3D ovl_cleanup_and_whiteout(ofs, indexdir, i=
ndex);
> +                       inode_unlock(dir);
>                 } else {
>                         /* Cleanup orphan index entries */
> -                       err =3D ovl_cleanup(ofs, dir, index);
> +                       err =3D ovl_cleanup_unlocked(ofs, indexdir, index=
);
>                 }
>
>                 if (err)
> @@ -1247,7 +1250,6 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
>                 index =3D NULL;
>         }
>         dput(index);
> -       inode_unlock(dir);
>  out:
>         ovl_cache_free(&list);
>         if (err)
> --
> 2.49.0
>

