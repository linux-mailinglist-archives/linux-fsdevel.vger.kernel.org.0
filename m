Return-Path: <linux-fsdevel+bounces-71463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A305CC20B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 11:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E24E304EB78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 10:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBB833B6D1;
	Tue, 16 Dec 2025 10:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="qiJBo+wX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7533832E149
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 10:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765882720; cv=none; b=BW+8WQEPrjh4/nsRHa8IkssVIwXV7mWaaVdqriBwvrEgQ4wPNpDDAQzkl9oS8l+UYoroLwDMejgvXXVuBnnw2fXTpHelR6TltgGOjE66ga6TSeaEngHWMhA7M3k0y79OKSEPcSIYkozmaboBAqE7EFRDEfrRwHLgeeQVosGgrWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765882720; c=relaxed/simple;
	bh=Us/Yq5qEGgekZRqyvi1bFmzUrxGRFoGVGiF7Yc5b48s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vFx7JVzhP8MUTLDfjzP+Y9fCucBuk7N9ck9Km2yEvJzDw8vmjs7RHX6DaRX2Ihxk4UumsjHk7358FE2G2pBq5tGekGMtElzYllv32Q37+l9zmgZiPf8uBFTCSsMSrTpeJ0MQaqtzz1BnIJwUVf7B5QNkXadpiMmZ/QtK3S4nAjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=qiJBo+wX; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4edb6e678ddso61967131cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 02:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1765882716; x=1766487516; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ccbd41GpfjXb5qRRkuX2D2CeaOMo2FLWUWzIn4R7yF8=;
        b=qiJBo+wXaJYpMLRBfsNuEC4ksGhcf083i905zUnqZ3ZgmCmOer9pVEFRklqREB2UoF
         nxPHZpNALcQWB92LLDitIuLFfhKH5it2lboWaPDUvTAmlL3fi5UQIufNfyMMQPhvgZ/l
         7rsjj8iuozWeM04MNMuXkR9+WDn+jzHnMdmi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765882716; x=1766487516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ccbd41GpfjXb5qRRkuX2D2CeaOMo2FLWUWzIn4R7yF8=;
        b=dy6dLT0uL6U2b25MXxs46QgeZKdOzagyVRDbE2+JUaTCiYZI4vHcy33hXYJhG4RXSE
         HZ7oPIOdhlXJfULGSMwv7V2NaeWTPbRHRcC217oUCFUdul5XSo5kH/wPVVeIEYig9tJ0
         rZaSmBgV0Z/MlhAK2cuCGm64ormCM9zPCDCNL4cfr+Y3kbUtgyFwEoLjk6LrDlrN8B+o
         GPqMW9nSYkGq/UVQ4rP0ukDDM2VhNwe44DW0fEAvF1HQ9idFGjqLbk/ZyJRVWXgNO9QR
         ODl6ZcBca5mT6NZ/nhoxuhxrSO2bn0PPAe8g59aN7BE3zsW6wCc32GDHens3bMgrWlE7
         XhQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcVLWY9Fz6/d414e9F6VR+r/qhCPixy0ycQ5c/quGrwtcDsOu3OuCYpKwbQ23ZelpIjsdkMCzhJGD/3PY8@vger.kernel.org
X-Gm-Message-State: AOJu0YysXKs83Ki7PdevZobhnL3j8y0n5h195Y4et8WAUFdanIRSI0V2
	8PH6QVtHzRHSq6XVf2komFvXb4cXG1MSkX+tuBX4VaNIFZj9B1uBzYtjCrNhepINeNMN96vBLnl
	UV+Q5keql2mcTLYqjtwsa2yULmUjzjvjcv1zk6xRH3Q==
X-Gm-Gg: AY/fxX4X3IcC04T4jbOh027zLL4yxl2gDn6MU1llHkonpTfLEJDwO9Hf7zk32RY3Bj9
	MW/J9FTP9FYFfFTxGlDZNMIiMrAvskBA2iOwt9IImDLfEL6MySlnJw+R5wYxwxILCi3X2tjflDF
	Ch5knv9s98AjGqhz2zOLhgRMBFpxf8pmkTJ6iuRssIaJbK9iPz7c3rYVuAlebtU39eMWElSn4Ne
	9RkX0KV+N26aYYWabxfgKV5XgyG9NvNTd5O95HETWFZC/Dpuqs8eMRLuJyu6W+UAlXx8K8=
X-Google-Smtp-Source: AGHT+IHXX4BTvpsy0ERATuh1IeNuuW1TsqWd+IbP8+t+7oUZ2pkjgMslSao5zr/xmQT8OiK9j9OdMiKARRy3gMHnXR0=
X-Received: by 2002:a05:622a:11d0:b0:4f0:22df:9afe with SMTP id
 d75a77b69052e-4f1d05a9310mr210279801cf.51.1765882716249; Tue, 16 Dec 2025
 02:58:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212181254.59365-1-luis@igalia.com> <20251212181254.59365-7-luis@igalia.com>
In-Reply-To: <20251212181254.59365-7-luis@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 16 Dec 2025 11:58:25 +0100
X-Gm-Features: AQt7F2oh_BXCPu_Hhm6UfVD-zoozpvTTiED8Vmca8m28acbS-tReRWtJrV_8BKU
Message-ID: <CAJfpegu8-ddQeE9nnY5NH64KQHzr1Zfb=187Pb2uw14oTEPdOw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 6/6] fuse: implementation of export_operations with FUSE_LOOKUP_HANDLE
To: Luis Henriques <luis@igalia.com>
Cc: Amir Goldstein <amir73il@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Bernd Schubert <bschubert@ddn.com>, Kevin Chen <kchen@ddn.com>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matt Harvey <mharvey@jumptrading.com>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Dec 2025 at 19:13, Luis Henriques <luis@igalia.com> wrote:
>
> This patch allows the NFS handle to use the new file handle provided by the
> LOOKUP_HANDLE operation.  It still allows the usage of nodeid+generation as
> an handle if this operation is not supported by the FUSE server or if no
> handle is available for a specific inode.  I.e. it can mix both file handle
> types FILEID_INO64_GEN{_PARENT} and FILEID_FUSE_WITH{OUT}_PARENT.
>
> Signed-off-by: Luis Henriques <luis@igalia.com>
> ---
>  fs/fuse/export.c         | 162 ++++++++++++++++++++++++++++++++++++---
>  include/linux/exportfs.h |   7 ++
>  2 files changed, 160 insertions(+), 9 deletions(-)
>
> diff --git a/fs/fuse/export.c b/fs/fuse/export.c
> index 4a9c95fe578e..b40d146a32f2 100644
> --- a/fs/fuse/export.c
> +++ b/fs/fuse/export.c
> @@ -3,6 +3,7 @@
>   * FUSE NFS export support.
>   *
>   * Copyright (C) 2001-2008  Miklos Szeredi <miklos@szeredi.hu>
> + * Copyright (C) 2025 Jump Trading LLC, author: Luis Henriques <luis@igalia.com>
>   */
>
>  #include "fuse_i.h"
> @@ -10,7 +11,8 @@
>
>  struct fuse_inode_handle {
>         u64 nodeid;
> -       u32 generation;
> +       u32 generation; /* XXX change to u64, and use fid->i64.ino in encode/decode? */
> +       struct fuse_file_handle fh;
>  };
>
>  static struct dentry *fuse_get_dentry(struct super_block *sb,
> @@ -67,8 +69,8 @@ static struct dentry *fuse_get_dentry(struct super_block *sb,
>         return ERR_PTR(err);
>  }
>
> -static int fuse_encode_fh(struct inode *inode, u32 *fh, int *max_len,
> -                          struct inode *parent)
> +static int fuse_encode_gen_fh(struct inode *inode, u32 *fh, int *max_len,
> +                             struct inode *parent)
>  {
>         int len = parent ? 6 : 3;
>         u64 nodeid;
> @@ -96,38 +98,180 @@ static int fuse_encode_fh(struct inode *inode, u32 *fh, int *max_len,
>         }
>
>         *max_len = len;
> +
>         return parent ? FILEID_INO64_GEN_PARENT : FILEID_INO64_GEN;
>  }
>
> -static struct dentry *fuse_fh_to_dentry(struct super_block *sb,
> -               struct fid *fid, int fh_len, int fh_type)
> +static int fuse_encode_fuse_fh(struct inode *inode, u32 *fh, int *max_len,
> +                              struct inode *parent)
> +{
> +       struct fuse_inode *fi = get_fuse_inode(inode);
> +       struct fuse_inode *fip = NULL;
> +       struct fuse_inode_handle *handle = (void *)fh;
> +       int type = FILEID_FUSE_WITHOUT_PARENT;
> +       int len, lenp = 0;
> +       int buflen = *max_len << 2; /* max_len: number of words */
> +
> +       len = sizeof(struct fuse_inode_handle) + fi->fh->size;
> +       if (parent) {
> +               fip = get_fuse_inode(parent);
> +               if (fip->fh && fip->fh->size) {
> +                       lenp = sizeof(struct fuse_inode_handle) +
> +                               fip->fh->size;
> +                       type = FILEID_FUSE_WITH_PARENT;
> +               }
> +       }
> +
> +       if (buflen < (len + lenp)) {
> +               *max_len = (len + lenp) >> 2;
> +               return  FILEID_INVALID;
> +       }
> +
> +       handle[0].nodeid = fi->nodeid;
> +       handle[0].generation = inode->i_generation;

I think it should be either

  - encode nodeid + generation (backward compatibility),

  - or encode file handle for servers that support it

but not both.

Which means that fuse_iget() must be able to search the cache based on
the handle as well, but that should not be too difficult to implement
(need to hash the file handle).

Thanks,
Miklos

