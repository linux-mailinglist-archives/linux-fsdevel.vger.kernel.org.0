Return-Path: <linux-fsdevel+bounces-52411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DF9AE320B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 22:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931A616DE4A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 20:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5EC1F3FC6;
	Sun, 22 Jun 2025 20:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="F0z2wK63"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54402EAE5
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 20:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750624984; cv=none; b=K8YPVwKFlXQH0V+uxYq3Bm2n8We7uZrzYIyMO/JClKKSz5qWMGq9a+qpQjltEQvIkSsBa55ft2ittpp9fIMqeHPlo+nVT4vWtVUCgNWiE90ERpaVHDnsdtA9pn/6eVWsYICXw7nQ0SzWOfb1T69yWWqSSMpezHwaqykaTfBM1aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750624984; c=relaxed/simple;
	bh=+jG2HuLWEx62oFB03Wuq//caQwog+L2q5/3i1YR9LNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b98yFtUqwJo5Gd33cg50efUu96V7kXKaj6rsw0XOvKAiQH8lVSCIm2uXDP212PBPjEokrttT1pxldsToaN1g1HtLeu4+6LKNNs8GhJY5nHGVIIcBBLThojr59zW4OHNX8KmBChMQ/VOLiwkvBcW+shhnMb38LuEQ7U2ef4WtANA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=F0z2wK63; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3105ef2a071so38937711fa.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 13:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1750624981; x=1751229781; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qEsyfeAiaq2fJuwkyqZ0Fgps4JqruNLVtd6VMI2wYm8=;
        b=F0z2wK63m4wo4L8I1J17RAUuLawQQ1gKivkHLjvMUomhg9gGqAKbQ/0ymlF1/BCWdr
         +eJtCjpKxh3DEBTg8SVlZuFNVMhw8SZcQ9ZU8stkTy7p8Ngay8AIDje0Hznd0EMSxdK6
         /pkGzxKZlspl2IFdOOiTD4iivhT4TtSLimu44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750624981; x=1751229781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEsyfeAiaq2fJuwkyqZ0Fgps4JqruNLVtd6VMI2wYm8=;
        b=Gtc2Po0871AB82oICjK6rGAkLE9Uv5QKb5bvlP6NAQBEKzCdd7yTGzLY2Nu2aZg04V
         7ljxMhSzSsI00IlBYxcXWaC0snfXIN2d70egfGyz/vj83Y2OtILysDRctbp8unkgp+Ru
         ot4v+itv9ufCoNJKqKt8irS1m27TiwAjZYT1l7GRUO//hKvhkaSmtl7r76I+SuTTugUW
         8D/aK2hD4kInI+LTsDv0yraLkEb+LwO29qeUFH4yjXJYxLVBMPe6PQfsSlh7E+gqCeMQ
         53/LOnZQg5GdqYHsG51tqsdykJ0FA4Kgmxkjru+vwZ3aJeZpzqNDmW1jW6iaRsNnYpmh
         IINQ==
X-Gm-Message-State: AOJu0YwOUHmDFqlQwkDquXZdwCrtBSlV8Tjb5N/BuECirfgAjZPsCMy1
	PzjxhAxIBdZ7f/nfUTd0CzYsXsV/JyL0NSlJDsGDvCQgl1cbiqYb80fHbfXmO+ICsXBMtLd8HZL
	JlrHyTRnDZvbyELzDd1QP6GgOYgUvohpRw5avKGqklw==
X-Gm-Gg: ASbGncsqw/105Dexq6XXLD6XFAqj74c3DotfVdLARG1cDo1eI5qN4KpygfcQMh1XYng
	i6fFjHlFALDUlaARNf/pxeW6tZmFVIu6eZAi1foz2UpU+jIcc4DqZiOnWmuH8aGMd5aILdM1sBf
	t1k8vHJUrVLa5KzOnGbzOBgzQTmWG6EjPtiMPs/NLoM6Th
X-Google-Smtp-Source: AGHT+IHzfZ9+dxpnD1y477EYAmydKv/nL+sZ4IkTpmj1GPdnWrVq9GTfRWoYXq4HSA+0kjm+jK+slR3sMn2lBtLdAIA=
X-Received: by 2002:a05:651c:111b:b0:32a:8062:69b1 with SMTP id
 38308e7fff4ca-32b98e31c80mr21015321fa.8.1750624980755; Sun, 22 Jun 2025
 13:43:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org> <20250618-work-pidfs-persistent-v2-3-98f3456fd552@kernel.org>
In-Reply-To: <20250618-work-pidfs-persistent-v2-3-98f3456fd552@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Sun, 22 Jun 2025 22:42:49 +0200
X-Gm-Features: Ac12FXyuOD5smGfiXxvEsaxLph53CwUaViGrzJXBn661SuQ8xekBdXsVGrkDK3M
Message-ID: <CAJqdLrqX+uSKyvWCcJo+dUp-ekSNxG8JrmEWSDJfrOkCbN8L-A@mail.gmail.com>
Subject: Re: [PATCH v2 03/16] libfs: massage path_from_stashed()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mike Yuan <me@yhndnzj.com>, =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

Am Mi., 18. Juni 2025 um 22:53 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Make it a littler easier to follow.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/libfs.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 3541e22c87b5..997d3a363ce6 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -2227,9 +2227,8 @@ int path_from_stashed(struct dentry **stashed, struct vfsmount *mnt, void *data,
>         if (IS_ERR(res))
>                 return PTR_ERR(res);
>         if (res) {
> -               path->dentry = res;
>                 sops->put_data(data);
> -               goto out_path;
> +               goto make_path;
>         }
>
>         /* Allocate a new dentry. */
> @@ -2246,15 +2245,14 @@ int path_from_stashed(struct dentry **stashed, struct vfsmount *mnt, void *data,
>                 dput(dentry);
>                 return PTR_ERR(res);
>         }
> -       path->dentry = res;
> -       /* A dentry was reused. */
>         if (res != dentry)
>                 dput(dentry);
>
> -out_path:
> -       WARN_ON_ONCE(path->dentry->d_fsdata != stashed);
> -       WARN_ON_ONCE(d_inode(path->dentry)->i_private != data);
> +make_path:
> +       path->dentry = res;
>         path->mnt = mntget(mnt);
> +       VFS_WARN_ON_ONCE(path->dentry->d_fsdata != stashed);
> +       VFS_WARN_ON_ONCE(d_inode(path->dentry)->i_private != data);
>         return 0;
>  }
>
>
> --
> 2.47.2
>

