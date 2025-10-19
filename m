Return-Path: <linux-fsdevel+bounces-64619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FD7BEE353
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 12:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63B023E13AF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 10:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850792E2EFC;
	Sun, 19 Oct 2025 10:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+wIPkzu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A76028B4FD
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Oct 2025 10:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760870832; cv=none; b=fqP2P07n8aUn6iuAJnQgbdEH89hmcuaBQtwKMJi5ZycmqnMFM81MtfDCRuNZiLZTqWeWelknHi3jSVSgTI/atNy86myxlptxXFJG7WNdP6UaNtGPIh+NGJP9ybzKCANOPOxEBq1Uc04+wRfLrnnQzt/o9JliWXddIQDmSgDcTa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760870832; c=relaxed/simple;
	bh=2JTUpllK+ijPNzY9KOj/+JwKKKrfvC+dQYw20xpZfbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gFXlN1VlVpBy6xXVAvL/U0s2R7olm9Es4qOMw9OWe2ocFzl6y1kbfHAKXzkayP6POIWZXIhKKQnqUEC3HD4gLDZ7Joz4B+uS8jltT9qEFlv3g5AdTuCtVgJUJseI9CaoNBvXSEXL5z4+TJBHE1Fd+aZB27L5WNY7HvTlUr6iLEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+wIPkzu; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b00a9989633so729273366b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Oct 2025 03:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760870829; x=1761475629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEv5vaiN24Hh4XtTngpZ8t+t0x9Dx2tfNzr02wJUn/8=;
        b=H+wIPkzuA/qNpQelCNpLCKrmgW31HxSy1DPjXye8JWj7OFcdjfS0HHUOtACJcUBtBK
         gYF4Q9c8AbizvnK0rWSpl+IW2P0iioXOv691h+2IytVCjLyqM/6HAkUr2HXyVaRuH+1q
         249+lZYYiRSIGome534Fc4V9mpmv1T5au74GauGtKyuvuFg98V7MtI4i4ECrqyOeN9hd
         vUzbaxvTznSex1YVM64sVg6D7gGSDAa9NeOKLmm9yHkxw6+XB8HIUUqGzt0hWGG8W1dd
         yDwrT9hZq72q/QPsNZAfSDoh8v/Df6x9+1iUM3tf5pvmSGAIcSJdshWFlixIQ/aX5Dia
         nqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760870829; x=1761475629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nEv5vaiN24Hh4XtTngpZ8t+t0x9Dx2tfNzr02wJUn/8=;
        b=E+A9ZacdFZLxOP1XeG0oopWQHnLrPFPcDD/6FHmFkQxOFaF9AX/w6iFEnJwj28LUU4
         lomUR+5c0oguKbby2Cp9CTZ9cLH1qtOe4o+IhFWLghY5X4pOCGHLpD55WG5qnYa4BqL7
         G3OOLmcKbqkp8d9+k3p66dcvcVWlP7E5BVkftPxpq3KPh52mQsgG1NuSra3S5bkYZOro
         Ilt2ia2qRoZsIeMsEN8ra3JdVD/BtWmifVMsHB0er7HcKQrBymlivInhzW9OQNtvYEW7
         5kXNEbDaG/OaLMXv5ytC8a5cEfvkRy4gW1zNRObGWl2rJTJh6Vh1GnL4kkYQKFb987aT
         r/SQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ/0zki8ADGTG7CKGcrNj0WpinfgaCWvzZfgClDFY+3SiR2ZYGVdcv2qB2hEwc6BKvHD/JquWg28Z0vQMf@vger.kernel.org
X-Gm-Message-State: AOJu0YzmjDT1O1c9vkmidv9yvMfmTzT7igyRIU9tB3C9zxHbpo9qB8bc
	NsqbvYRpZ6BiI4Bl+G1pJ/mWaj84ue3VHqvXpCEpOutDwRnZd1amytHIvatSqP6dbBAQffzygpk
	7C8caH6v99+y8K6rmrdw/XEXSBI3CiM0=
X-Gm-Gg: ASbGnct5qwlL4/asUBm7cS1YO25Hg5zXeStaPov3Zvk+V6o11838DsRSgvHOLndYxFW
	w+1ESm98eTnDCYxPPGnCy2T2eMKjsSbDnxChbzgScIfKDnksKm+fchdmlhwqH2B41hqFa+IuRff
	cVJ15MUwfD853hEgq+fMGHkTmRmtyDv5j+dN/q8tVGhiYX8Y3TgeQVSEK1ApnJdvjwU2mWWpdQN
	ZaVkM4/FrsZ5dkCVX6to/OqQJTEoAMegvv9ssZXPRhrEprljptMnRHg6wm8IwYv+X3R3cuG0h1f
	+9GVc/Wdk4VIVlEvOXxMuIBtfPV+Ug==
X-Google-Smtp-Source: AGHT+IGHvpZL5iYfpbRQL+m/YuEDKMOY47TD2XxHf/+0HabF52EojQkyirI5XhKaF57wYBEHAhIqyHH9IywrRywk+aE=
X-Received: by 2002:a17:907:c086:b0:b5f:c3df:dedc with SMTP id
 a640c23a62f3a-b6051dc3619mr1539572966b.2.1760870829375; Sun, 19 Oct 2025
 03:47:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015014756.2073439-1-neilb@ownmail.net> <20251015014756.2073439-14-neilb@ownmail.net>
In-Reply-To: <20251015014756.2073439-14-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 19 Oct 2025 12:46:58 +0200
X-Gm-Features: AS18NWCXbh9pUHtiWGKCkbPj6b9BtIBcTSPsrU8tbstG7aid-Gvz5OnY9PeTAp8
Message-ID: <CAOQ4uxg6dcKRKhCiTsDEqFvKVAm4d88rWGayZNRKaYq7i7_ZkA@mail.gmail.com>
Subject: Re: [PATCH v2 13/14] VFS: change vfs_mkdir() to unlock on failure.
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 3:49=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> vfs_mkdir() already drops the reference to the dentry on failure but it
> leaves the parent locked.
> This complicates end_creating() which needs to unlock the parent even
> though the dentry is no longer available.
>
> If we change vfs_mkdir() to unlock on failure as well as releasing the
> dentry, we can remove the "parent" arg from end_creating() and simplify
> the rules for calling it.

Does this deserve a mention in filesystems/porting.rst?
I think the change of semantics in
c54b386969a58 VFS: Change vfs_mkdir() to return the dentry.
was also not recorded in porting.rst.

>
> Note that cachefiles_get_directory() can choose to substitute an error
> instead of actually calling vfs_mkdir(), for fault injection.  In that
> case it needs to call end_creating(), just as vfs_mkdir() now does on
> error.
>
> Signed-off-by: NeilBrown <neil@brown.name>

This looks much better IMO.

With one nit below fixed, feel free to add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/btrfs/ioctl.c         |  2 +-
>  fs/cachefiles/namei.c    | 14 ++++++++------
>  fs/ecryptfs/inode.c      |  8 ++++----
>  fs/namei.c               |  4 ++--
>  fs/nfsd/nfs3proc.c       |  2 +-
>  fs/nfsd/nfs4proc.c       |  2 +-
>  fs/nfsd/nfs4recover.c    |  2 +-
>  fs/nfsd/nfsproc.c        |  2 +-
>  fs/nfsd/vfs.c            |  8 ++++----
>  fs/overlayfs/copy_up.c   |  4 ++--
>  fs/overlayfs/dir.c       | 13 ++++++-------
>  fs/overlayfs/super.c     |  6 +++---
>  fs/xfs/scrub/orphanage.c |  2 +-
>  include/linux/namei.h    | 28 +++++++++-------------------
>  ipc/mqueue.c             |  2 +-
>  15 files changed, 45 insertions(+), 54 deletions(-)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 4fbfdd8faf6a..90ef777eae25 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -935,7 +935,7 @@ static noinline int btrfs_mksubvol(struct dentry *par=
ent,
>  out_up_read:
>         up_read(&fs_info->subvol_sem);
>  out_dput:
> -       end_creating(dentry, parent);
> +       end_creating(dentry);
>         return ret;
>  }
>
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index b97a40917a32..10f010dc9946 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -130,8 +130,10 @@ struct dentry *cachefiles_get_directory(struct cache=
files_cache *cache,
>                 ret =3D cachefiles_inject_write_error();
>                 if (ret =3D=3D 0)
>                         subdir =3D vfs_mkdir(&nop_mnt_idmap, d_inode(dir)=
, subdir, 0700);
> -               else
> +               else {
> +                       end_creating(subdir);
>                         subdir =3D ERR_PTR(ret);
> +               }

Please match if {} else {} parenthesis

Thanks,
Amir.

