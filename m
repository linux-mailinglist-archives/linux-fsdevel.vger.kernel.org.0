Return-Path: <linux-fsdevel+bounces-28703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F5796D219
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 10:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 955361F229D7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 08:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF086194ACB;
	Thu,  5 Sep 2024 08:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGALHYmp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DDF15B541;
	Thu,  5 Sep 2024 08:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725524886; cv=none; b=n9Dko9X8rwWF0bIpCL7FTZ3KxL8uRimbWxsAbzs3wnv4saVxQl5gg1oLfOQASjRIqoj0WcQCrgTID2GQ/bfju7uPrVyMM4zYzASNzTdSrXaKSHW5sCtkjaeIkKcQoHgWjdx3vw2I1ERWqbASdL3yXxdgEsLK6ZyrTzXe/xzppTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725524886; c=relaxed/simple;
	bh=19hdA0KbLgqzrvahYEcdnPKJkiK1OSKjVMvVjB4oYZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ffFRtSGBXNqfHjfjaJoTMFrKokdkAn31SPG1Ihmyxe/YoM5cdltu2d73UoWkQujciOlf+4rVfImjkbI5MciZku+KJLZhbLkc3ugNOHZ72WOVvPShe2i3EHo7SpXL0O73oLxO8CXgedBay6GDAeLohbVisEqiKfTXBmax8pRCkqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGALHYmp; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-49bc44e51bcso160738137.2;
        Thu, 05 Sep 2024 01:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725524883; x=1726129683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVZvaQEpRVT3r0fm528EiKgjdfIwrSP8yDYuzflRklo=;
        b=AGALHYmpWTX0K28TVD+DyD/HaTlKVVahYFew5VYv218Y7j18+bdIcxJu4DbfpI8HcV
         9wDZjA2RZ/mijnyvz214SgOUCgDrLx0LR7ZxmHOZJ82rzhzJt2ORGFqe/JoZIG3BwDCN
         zTUveTdTy2vcxdAI822Ym89L+K1TwlGD1uLHuPonBRtRkv8WohjiV2DmFlcgPQbcwNVT
         Myfjl35pQWXS6mdnZk5s01DU9s2v0/O+vd1nUhqzAYnvSl2lH9/KqkWMlsCDSD3IIAnQ
         MyCOOuRV65FORGVa8wF3gq2lirxHCJeOPRIv0r2kx3dqCHk87ljDOXqv1oLPr39ecpZm
         O81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725524883; x=1726129683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVZvaQEpRVT3r0fm528EiKgjdfIwrSP8yDYuzflRklo=;
        b=f9aXyBiXbRGnBPcnHqg3Zfb0R6ccgPi+Px7vgjOIa9S9HtphjEKAQIhEVaDYAgJYRc
         bJAAH3WEz5b5ny7M7Igf9Jngf74cvksXzA4/Kn/AAJbioUB+uUMer19NnVafhrA36b2I
         PGqz1Cu67/PQTyxzTzPInA0nknBDZai3uhWr8AqAkMD+WX3E95oIwUp2fE7qZwhSFP2g
         vRVb5eSXftcVu6Fnib0XgMRiWTMM4XhtiTO8i4HZ307nlxlsb8l8sb/NAz6iSJGfOiSz
         alcr70+QwJ78XAAl87k88mguyWUZ8Fjl8tHnAgEfcsxRQ3cmQcobLk+HBaVG/OKbG+FL
         VwFg==
X-Forwarded-Encrypted: i=1; AJvYcCV0TdQ44JqDjSTv4TlQHmAtfT91PbE50Wgfv3el/7IcGU8JPK2sgnGM3q5cJWInJbJu8ucEsyaZNLYC@vger.kernel.org, AJvYcCW4XGG3nyb78zisKp4vC+Up23dLkZr50t7HPEYKoIm6oZiicNywGY2qlMXc8ITI/j7/895DOCckXWziWmA=@vger.kernel.org, AJvYcCWmczi44W8WJDVSAS/clidY6vS5KnPQwUBPxihOfOiVNXPY72dHNdseA8vgLD9GdMMyCi/ZkRbd/3Qr50x9tA==@vger.kernel.org, AJvYcCXBhBXoWNPG12ArZc78QSKVYPlpnON9DYWyp1Bbrlzq5aLruSqjIWzKydd/6BhKT8P9dXE0NqxPamGrTlNdWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdDdn7ep6yfOgFPFoEXAbhjlmlWx9gI8ktwVEOaKunYYjpEKYB
	diAfJbVkccH1ALTLazF+LqUY5wmS62Ogz4jGCOFN2M/76cFN7biYMOkCods6V0SWsLRRVU7taWT
	1pKc1XHcr0pfhjSoCF8QA7ZxVQwltCutQ+/U=
X-Google-Smtp-Source: AGHT+IGoNU1jZY6A/h1Uf8w7In4vXi6AGkhvNM/ehWlkjdTlkw88exnYqYilHPuSRQLA2qLVcYdAIC9XX74OtFoPjeU=
X-Received: by 2002:a05:6102:2ac2:b0:492:a883:e1d with SMTP id
 ada2fe7eead31-49a7775732amr18840231137.11.1725524883402; Thu, 05 Sep 2024
 01:28:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1725481503.git.josef@toxicpanda.com> <33151057684a62a89b45466d53671c6232c34a68.1725481503.git.josef@toxicpanda.com>
In-Reply-To: <33151057684a62a89b45466d53671c6232c34a68.1725481503.git.josef@toxicpanda.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Sep 2024 10:27:52 +0200
Message-ID: <CAOQ4uxgaLY+EQCdGqr+yPsBuRh3uMe2DGLqXrBmC=hvDYBo23A@mail.gmail.com>
Subject: Re: [PATCH v5 18/18] fs: enable pre-content events on supported file systems
To: Josef Bacik <josef@toxicpanda.com>, jack@suse.cz
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 10:29=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> Now that all the code has been added for pre-content events, and the
> various file systems that need the page fault hooks for fsnotify have
> been updated, add FS_ALLOW_HSM to the currently tested file systems.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

I would not be devastated if this patch remains as is,
but I think it would be nicer to:
1. Move it before the fs specific patches
2. Set the HSM flag only on ext*
3. Add the HSM flag in other fs specific patches

Thanks,
Amir.

> ---
>  fs/bcachefs/fs.c   | 2 +-
>  fs/btrfs/super.c   | 3 ++-
>  fs/ext4/super.c    | 6 +++---
>  fs/xfs/xfs_super.c | 2 +-
>  4 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
> index 3a5f49affa0a..f889a105643b 100644
> --- a/fs/bcachefs/fs.c
> +++ b/fs/bcachefs/fs.c
> @@ -2124,7 +2124,7 @@ static struct file_system_type bcache_fs_type =3D {
>         .name                   =3D "bcachefs",
>         .init_fs_context        =3D bch2_init_fs_context,
>         .kill_sb                =3D bch2_kill_sb,
> -       .fs_flags               =3D FS_REQUIRES_DEV,
> +       .fs_flags               =3D FS_REQUIRES_DEV | FS_ALLOW_HSM,
>  };
>
>  MODULE_ALIAS_FS("bcachefs");
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 0eda8c21d861..201ed90a6083 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2193,7 +2193,8 @@ static struct file_system_type btrfs_fs_type =3D {
>         .init_fs_context        =3D btrfs_init_fs_context,
>         .parameters             =3D btrfs_fs_parameters,
>         .kill_sb                =3D btrfs_kill_super,
> -       .fs_flags               =3D FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA=
 | FS_ALLOW_IDMAP,
> +       .fs_flags               =3D FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA=
 |
> +                                 FS_ALLOW_IDMAP | FS_ALLOW_HSM,
>   };
>
>  MODULE_ALIAS_FS("btrfs");
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index e72145c4ae5a..a042216fb370 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -137,7 +137,7 @@ static struct file_system_type ext2_fs_type =3D {
>         .init_fs_context        =3D ext4_init_fs_context,
>         .parameters             =3D ext4_param_specs,
>         .kill_sb                =3D ext4_kill_sb,
> -       .fs_flags               =3D FS_REQUIRES_DEV,
> +       .fs_flags               =3D FS_REQUIRES_DEV | FS_ALLOW_HSM,
>  };
>  MODULE_ALIAS_FS("ext2");
>  MODULE_ALIAS("ext2");
> @@ -153,7 +153,7 @@ static struct file_system_type ext3_fs_type =3D {
>         .init_fs_context        =3D ext4_init_fs_context,
>         .parameters             =3D ext4_param_specs,
>         .kill_sb                =3D ext4_kill_sb,
> -       .fs_flags               =3D FS_REQUIRES_DEV,
> +       .fs_flags               =3D FS_REQUIRES_DEV | FS_ALLOW_HSM,
>  };
>  MODULE_ALIAS_FS("ext3");
>  MODULE_ALIAS("ext3");
> @@ -7298,7 +7298,7 @@ static struct file_system_type ext4_fs_type =3D {
>         .init_fs_context        =3D ext4_init_fs_context,
>         .parameters             =3D ext4_param_specs,
>         .kill_sb                =3D ext4_kill_sb,
> -       .fs_flags               =3D FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
> +       .fs_flags               =3D FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS=
_ALLOW_HSM,
>  };
>  MODULE_ALIAS_FS("ext4");
>
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 27e9f749c4c7..04a6ec7bc2ae 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -2052,7 +2052,7 @@ static struct file_system_type xfs_fs_type =3D {
>         .init_fs_context        =3D xfs_init_fs_context,
>         .parameters             =3D xfs_fs_parameters,
>         .kill_sb                =3D xfs_kill_sb,
> -       .fs_flags               =3D FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
> +       .fs_flags               =3D FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS=
_ALLOW_HSM,
>  };
>  MODULE_ALIAS_FS("xfs");
>
> --
> 2.43.0
>

