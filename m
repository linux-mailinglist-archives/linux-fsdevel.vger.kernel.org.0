Return-Path: <linux-fsdevel+bounces-55099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2174B06EA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 09:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 869661A64125
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 07:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C00328AAFB;
	Wed, 16 Jul 2025 07:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gttz5pIm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206EF27146F;
	Wed, 16 Jul 2025 07:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752650070; cv=none; b=lvmYUV1IpHfJJWZ6SAQCc88xroNi6pW8AIzy7Qp89vfGNhymb4R3cLAKjZXjRR6NO6HPXTkHR0gxvIqxivpTQC46pu2B1KcgELXDxmWc7O3gv6vSum1tM6yDs+TTiJ9J12UBhzK+QWROjwKMAHIJiNeWjQXZnFkadatEogB3gMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752650070; c=relaxed/simple;
	bh=vEQK5dBPwCPJPSrQjYZZyk9fOXKkGlhS0iGpvIcS5gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBbnsrYhxPr/ZLJPI+Tjyyb0tzwWHQMQwYG7m8CqKITh833Uyl7IhFk1WKdcIAo8fHP9GTwNgMJJKv5kxPzE+0zLASRjyfe37keXQDlBUjSsd+9+n5/REX0JqnDg0crPOI/vU9QLPFgrdvZPVCTCd0ld6p2ZJB5lWX3ch7WA+QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gttz5pIm; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad56cbc7b07so1057981966b.0;
        Wed, 16 Jul 2025 00:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752650067; x=1753254867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EFdek0k97XzOwAR8hP82H53oDqjBcj2Gcq529c7LX0=;
        b=gttz5pImwuHKT80EcfzcuIlnwsioZa+8miEAXFH7XDfi+LlggZtt3MxNBZmRWP59j3
         4y45/WdzREQAaGhDGkGW8UKrsm2uWgZykqb2vP+77WBAKNcjZ3Mrl8WZoR+NUevJ9WIn
         pNP4m2tEt4aSEsoWueqCE9myOwmKlZ8LPy8SngzQacAcBz1L0jMzs9Kw9bTsSe0P1f5J
         fGbPTLRr+wfb40XAMhLpu0BQbNF+Mned0PLcLA8GQGLUPSwBxrsF2Lr8xyku6/vjLK8D
         /2xpXL8zycMR2Du9yisiSbhIKZ0v9gWkIkaKLD8at0zS6Iqas2Z8N1LCEXlcKVFiIiG/
         7aGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752650067; x=1753254867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/EFdek0k97XzOwAR8hP82H53oDqjBcj2Gcq529c7LX0=;
        b=r+EYYvfSeIyesJgMaDdRlohk6/rk5/R6YKv7W2pEM0bW53WkQ9ImNMTqelW5EBSNAb
         /DHgv2ancWx+VOIbYwlIPwOo93PrsWIZAJXAlbGxf3ERkdaQZ+wY9GL0rPpbkRR9BPfk
         AgX3nPBlw6yVvza4UmYapeSzofSXF1l+DT0xIus3MBxmynlcxtB/N4j38I9rVVp1LIYQ
         NuwYub0RCWK0uSW/uh/n0nNz19WaC50cBKp+M8qs3/0K+Yby+vASOiNOJokm7AavS4e0
         bkTkeFNczia56enlr9GZlTjgev6RjI/U9g/eVnp0d3nkUg0exRUvT4RTKlI0yl401zA5
         1vtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5zEjEgx7j6W18QyXo5nDynS1kue88sHpPV3rzh77oJzEOyLdNzO3J/xOsRvITEsYQmtNkHaUbAuAzhWj01w==@vger.kernel.org, AJvYcCVX7wOWozQrUTH6r3X8VjaHhTs51AYX+ZRBoWusKhEcj+oLRkzSdEU1/qTG9TSBBbIJwlgyzHC1r9L0ljP8@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdrj2SA8KyErGkh0qsvGlrw2bMGeOcAx3GUsPprOBIuKDgJKa1
	c8r6OEYGIf8xO0WXPSwbCqr5nzKQaoVbHzj6vr0oOHm6j1wV9mMf3yQvo7PSzYyISVea/osL1pu
	q8jH5znkc0ArV3s+GFXJne4rF/BHjk4w=
X-Gm-Gg: ASbGnctZcIAt+LimsF6icXeJZ4h0uU+ETx19dsK6R0g2Y+79ZE6qVkSR/EnweV0Xbwt
	DidWcoLkH/3r9uVf1euJXs64+glNlrbC2BrhhuJuxCUXMvBkqS2BgdWYg/OgDzc5AHq91wq3pVr
	MuVMi+V3wo0IOof9YtuiGhR+BfCO71Y9qDLf8+DymrpjN5amoDsB5fJxdl9K7AVVC9HC89gFRBU
	zme/pU=
X-Google-Smtp-Source: AGHT+IEk5eV6fnet+a1DYM0YhcUlcgcN+fsRplUJLhnbfko1adujwVUuXkN8X4aMMQgwjqHWp/5wE7FR+tsgzv17vdQ=
X-Received: by 2002:a17:907:f1e4:b0:ae3:a717:e90c with SMTP id
 a640c23a62f3a-ae9cde002f2mr128182766b.23.1752650066906; Wed, 16 Jul 2025
 00:14:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716004725.1206467-1-neil@brown.name> <20250716004725.1206467-12-neil@brown.name>
In-Reply-To: <20250716004725.1206467-12-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 16 Jul 2025 09:14:14 +0200
X-Gm-Features: Ac12FXx-LjOl2j03Oe_dbARUVT9fmQ-wOwixMpI_B7lUsWAoB1ZiCNyhAqHdH0s
Message-ID: <CAOQ4uxjufH4iPcX+ryHPt4OXq98BMsrWS-U2eLHTmaFtqCnjTw@mail.gmail.com>
Subject: Re: [PATCH v3 11/21] ovl: narrow locking in ovl_cleanup_index()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 2:47=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> ovl_cleanup_index() takes a lock on the directory and then does a lookup
> and possibly one of two different cleanups.
> This patch narrows the locking to use the _unlocked() versions of the
> lookup and one cleanup, and just takes the lock for the other cleanup.
>
> A subsequent patch will take the lock into the cleanup.
>
> Signed-off-by: NeilBrown <neil@brown.name>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/util.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index fc229f5fb4e9..b06136bbe170 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -1071,7 +1071,6 @@ static void ovl_cleanup_index(struct dentry *dentry=
)
>  {
>         struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
>         struct dentry *indexdir =3D ovl_indexdir(dentry->d_sb);
> -       struct inode *dir =3D indexdir->d_inode;
>         struct dentry *lowerdentry =3D ovl_dentry_lower(dentry);
>         struct dentry *upperdentry =3D ovl_dentry_upper(dentry);
>         struct dentry *index =3D NULL;
> @@ -1107,21 +1106,22 @@ static void ovl_cleanup_index(struct dentry *dent=
ry)
>                 goto out;
>         }
>
> -       inode_lock_nested(dir, I_MUTEX_PARENT);
> -       index =3D ovl_lookup_upper(ofs, name.name, indexdir, name.len);
> +       index =3D ovl_lookup_upper_unlocked(ofs, name.name, indexdir, nam=
e.len);
>         err =3D PTR_ERR(index);
>         if (IS_ERR(index)) {
>                 index =3D NULL;
>         } else if (ovl_index_all(dentry->d_sb)) {
>                 /* Whiteout orphan index to block future open by handle *=
/
> -               err =3D ovl_cleanup_and_whiteout(OVL_FS(dentry->d_sb),
> -                                              indexdir, index);
> +               err =3D ovl_parent_lock(indexdir, index);
> +               if (!err) {
> +                       err =3D ovl_cleanup_and_whiteout(OVL_FS(dentry->d=
_sb),
> +                                                      indexdir, index);
> +                       ovl_parent_unlock(indexdir);
> +               }
>         } else {
>                 /* Cleanup orphan index entries */
> -               err =3D ovl_cleanup(ofs, dir, index);
> +               err =3D ovl_cleanup_unlocked(ofs, indexdir, index);
>         }
> -
> -       inode_unlock(dir);
>         if (err)
>                 goto fail;
>
> --
> 2.49.0
>

