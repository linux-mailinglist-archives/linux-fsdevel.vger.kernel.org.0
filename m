Return-Path: <linux-fsdevel+bounces-52414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36111AE323D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 23:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D41F77A3493
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 21:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D021F560B;
	Sun, 22 Jun 2025 21:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="N6tflaPk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AEF1EA80
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 21:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750626622; cv=none; b=m+L0+G0bjtJLOMOgOHebCB+k/IBNJEsO3amFkDPKUARwjauho9QMHnp6CFHHlVkxT3Y6fSfX6aXEGCsHTEUaQ/Rf0p9Vuul0Vc0nwY5NvUSQNxpnaA1Q09cN5lx+IAEC1nYAKecG9PmfO/32ZrIfwM5S5n58WFFA/HRjIIYNJaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750626622; c=relaxed/simple;
	bh=fDgM2HkOBBu9uKmkbksY1LdAGsNSkwd64sIkJOKlIpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i4+7Bw4Pm0m5DO8b9bxqrfxQBztkYBp0+TwwsBvWbZJg+kLLeALsyESgnSPFWLpaXi2UwWZvptvqoYKsN4bzynPaX4mWgoZILDG0/PGglpbUS5Tam6LbJvuAfNGS1OXQvFYSWD36n2i8gMv6B675dRVqY41TgXtrQMR4PoYMWmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=N6tflaPk; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32ca160b4bcso9732701fa.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 14:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1750626617; x=1751231417; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ea+ccY+LU0eYA1R8ZSxekD77eidAj0Tn+kSDBNy8xbo=;
        b=N6tflaPk3DDSreYmlkTMlYAHfpnPECIbUcCVqiMCREge3PN7JcV5pHhcFIg0qkBl2D
         0lUohbY9Je9lzIx6mVMEYPP921t4U0YSfRiYECzsjrYeFUtt+AV6FVTEJtMwqUluUCyh
         lqkM1VHmrx87cq+OasGG9zrDn7M7G99xLQEiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750626617; x=1751231417;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ea+ccY+LU0eYA1R8ZSxekD77eidAj0Tn+kSDBNy8xbo=;
        b=gxoA01pjkk09+ZJP+vGgRazYceTj3wfnjSTbGjw7rHZ3WYD9dzybdbtziY2oobkxQ6
         UfTeKdUCMxqfy4BOdPdpFSiL+C33dr0+X4e/bk4R6BGkXrmKu52IkvcZC/8hT/PQFm0f
         1DARok7NtREPwSFbwsMdYfHDgSRfdN+eY4DvDDXN/BIXxIkL0CaPjb/wQSrXUm/BxpmW
         ilkf3GTUhB0YoMkeG0KzADC2bwh20ruqrC0uocpoFJy8wOOZOIPr00hPlGMPEmvvBHPk
         hDGKwzPkd9A3we3M9wJidRLg5BYg0MP+VAc1SL472Ce2EBuJJmuZVwo2OjHyvy4P6i8G
         fopw==
X-Gm-Message-State: AOJu0Yzdr6gwFftUb2SVaL9Lg5tcDzcdjZ29s3zmDWmKVSic8HUAACQb
	dGYfo8A25x3+YVLSfZgUDEeo7p49GtzpPM2yWwoBHSXLlu06h3j7Au/0uCPTWQSBE5C2wnurB3d
	pCdeqE/cR6MEfEzxITsNLRzR1FgPpm82VbaafyeGqTA==
X-Gm-Gg: ASbGncuZFrE/ICMvxoEcHzRZQhjAGcniv+c14jkQXHjtoMXB3GUgxTyIZNPXPws2lmR
	xHHjJxnOofXWZAa6fqUMqv2HBV284rBwIJoaCdxpQrsb1+xjyfCRxPXG8WddocP2M5qjwZxfA3K
	XdVOJo0qtxZL8L4wjLraTAW+F71DVfX3rUEzwBORTirHcP
X-Google-Smtp-Source: AGHT+IFH6eGGqT/owI+XlC5o0QaQGYZ9jHHuAgWITAmSbtylouFNfJ8jFsvHdi1FZMV8Rj5fspXa7MgcxCincPUszdo=
X-Received: by 2002:a05:651c:111b:b0:32b:2fe7:afd0 with SMTP id
 38308e7fff4ca-32b98e735f0mr22961281fa.17.1750626617137; Sun, 22 Jun 2025
 14:10:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org> <20250618-work-pidfs-persistent-v2-7-98f3456fd552@kernel.org>
In-Reply-To: <20250618-work-pidfs-persistent-v2-7-98f3456fd552@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Sun, 22 Jun 2025 23:10:05 +0200
X-Gm-Features: Ac12FXw529snkR_iYDm3EtbEYmiAApPrsdNMk7GMulck323Y51UXIT4rFPogaYc
Message-ID: <CAJqdLrputHy24f9==fsgpATETZCx-ZV=E8UADipwj+0GbmbvbQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/16] pidfs: remove custom inode allocation
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mike Yuan <me@yhndnzj.com>, =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

Am Mi., 18. Juni 2025 um 22:54 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> We don't need it anymore as persistent information is allocated lazily
> and stashed in struct pid.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/pidfs.c | 39 ---------------------------------------
>  1 file changed, 39 deletions(-)
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 72aac4f7b7d5..c49c53d6ae51 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -27,7 +27,6 @@
>
>  #define PIDFS_PID_DEAD ERR_PTR(-ESRCH)
>
> -static struct kmem_cache *pidfs_cachep __ro_after_init;
>  static struct kmem_cache *pidfs_attr_cachep __ro_after_init;
>
>  /*
> @@ -45,15 +44,6 @@ struct pidfs_attr {
>         struct pidfs_exit_info *exit_info;
>  };
>
> -struct pidfs_inode {
> -       struct inode vfs_inode;
> -};
> -
> -static inline struct pidfs_inode *pidfs_i(struct inode *inode)
> -{
> -       return container_of(inode, struct pidfs_inode, vfs_inode);
> -}
> -
>  static struct rb_root pidfs_ino_tree = RB_ROOT;
>
>  #if BITS_PER_LONG == 32
> @@ -686,27 +676,9 @@ static void pidfs_evict_inode(struct inode *inode)
>         put_pid(pid);
>  }
>
> -static struct inode *pidfs_alloc_inode(struct super_block *sb)
> -{
> -       struct pidfs_inode *pi;
> -
> -       pi = alloc_inode_sb(sb, pidfs_cachep, GFP_KERNEL);
> -       if (!pi)
> -               return NULL;
> -
> -       return &pi->vfs_inode;
> -}
> -
> -static void pidfs_free_inode(struct inode *inode)
> -{
> -       kfree(pidfs_i(inode));
> -}
> -
>  static const struct super_operations pidfs_sops = {
> -       .alloc_inode    = pidfs_alloc_inode,
>         .drop_inode     = generic_delete_inode,
>         .evict_inode    = pidfs_evict_inode,
> -       .free_inode     = pidfs_free_inode,
>         .statfs         = simple_statfs,
>  };
>
> @@ -1067,19 +1039,8 @@ void pidfs_put_pid(struct pid *pid)
>         dput(pid->stashed);
>  }
>
> -static void pidfs_inode_init_once(void *data)
> -{
> -       struct pidfs_inode *pi = data;
> -
> -       inode_init_once(&pi->vfs_inode);
> -}
> -
>  void __init pidfs_init(void)
>  {
> -       pidfs_cachep = kmem_cache_create("pidfs_cache", sizeof(struct pidfs_inode), 0,
> -                                        (SLAB_HWCACHE_ALIGN | SLAB_RECLAIM_ACCOUNT |
> -                                         SLAB_ACCOUNT | SLAB_PANIC),
> -                                        pidfs_inode_init_once);
>         pidfs_attr_cachep = kmem_cache_create("pidfs_attr_cache", sizeof(struct pidfs_attr), 0,
>                                          (SLAB_HWCACHE_ALIGN | SLAB_RECLAIM_ACCOUNT |
>                                           SLAB_ACCOUNT | SLAB_PANIC), NULL);
>
> --
> 2.47.2
>

