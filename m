Return-Path: <linux-fsdevel+bounces-64617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F73BEE32C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 12:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A6624E7AC9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 10:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248E22DFA3E;
	Sun, 19 Oct 2025 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrB8a0SW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F617354AC1
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Oct 2025 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760870307; cv=none; b=JS6q8XIEOzOmlDvL+Ro7I44sD7TUKf9vfSRIQxn+rr8fn+cGZvZLi8S6dAMdjp5f9FaqQ2SoFlZgp5mTrg6ciqbabF40QkxpHGM1V0IFgFAH+yZCrEfcMvygXmC+Jz2ArC+lycK27uBrtSoTmpgMYCnpYfh5gWYXM/PXTZkZAVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760870307; c=relaxed/simple;
	bh=1ILi+E2ngMHvyNupnID3FvNstzp+g6C/yxvpeo7V2GQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rEDaypPOASMP2VhZrImJFf8G/uUy5v1jg1MXeCp/TlkA1SLLuJdp+ehRuhaui8xMujHTCKG2qG0m0kzKnnoG21zgoF1yzKnK+OvXEIRu1wKVheXbNSj03M48Cp+3/WFowKfD/BNF7oTIszM9ASS87n1hJxTejqzTA9qbcluRFbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrB8a0SW; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63bf76fc9faso6168190a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Oct 2025 03:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760870304; x=1761475104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKJ07Bve0iPE6IwmRg3Z9yLEKFrm12XxnkJdR17sDEA=;
        b=XrB8a0SWn383gDRzpi25WBO8HNEdqb9BM4ymcx9ZJCTo0VxgBf8VlsjC9glxs+Ec/g
         OtlXXMx03k4wo4C35IjawCrRHdj9hWdqXl2VqsF094kd8oeIVRL+4vyEdbKIM8FOvN/W
         ePEmmWOy8sNtzvbUxF8zIU2UihKpafpEGouJWLrGx/UHKLDwbYmPb/p2yzSgQPYcrIDC
         jpJMhE+vc/VxX4Lltb7I/Et5psHuKVbmMlnJ/LOufVAxrlv2bijWgjT7BX0BsAxwcTFM
         di8TrqSgldjItaBdIBD9zDwJ+GVaIf3pakZYg0zwrATYuNVrxynVglSFmyd08L7Hd/Te
         cFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760870304; x=1761475104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKJ07Bve0iPE6IwmRg3Z9yLEKFrm12XxnkJdR17sDEA=;
        b=oRWBSGcmEZclf9wj86zucbvK/JRtsTuR9HAxV72X9vPAAgeaUslknHogykt6nxqMQX
         GjJrR85eTesT45u1anmlU0mCNRI1rEBsjaoahxSSloZN2oq42r6kPsnNQPdrl8niClzJ
         WTMNW5vPoS1+92JxUBOJXUenZQ4VgMzknSPnDpuxXbLQkDhAtEbf8WOl4uu7nHoMVeeO
         vix0lv1vfxRF/oeBXL3mapTvwwWF3RlIA+9tZQ2cGi4iTLof8ziTqOmzLF2COCCKD0qc
         +8/s+BAarEO5dng7DW23I8syxwuafwo8LA5oo0PB2T581zlxCMDymiikJI78fH3Y9nP/
         IcFg==
X-Forwarded-Encrypted: i=1; AJvYcCXmBYKSzYMCcj6BjQMbCIUTS3zA8pJZ1u4/qHAm5WDbMBlYgZuyNF28u+OpCruQpTGZi3Imdlm8AnmQT2jS@vger.kernel.org
X-Gm-Message-State: AOJu0YxTwTTpfrwAAQTjnYTS4u7D/k6Hgm8f1lNwbd5P6ZdKqM+L8TYv
	FLkoDDqViN23gMPKrYHBLBl8lZ0d8QGReNC2LEsJi/vs70vC0CnEliKouy7BWxxxvhUJUHbgek9
	sreWJOYGL8qO4kKANop+q95irLmujMOo=
X-Gm-Gg: ASbGncsHCIEx6jpiWbhQuarMHfgUd8IMeSJvdvRAIse2dJ1r6+SNC80oAJyW2T11sO1
	fXnEWf08qRGxF64lvxqNmRGdqCGlEp94hAukCFdxF4QAnA3v2k6Fkd1TwomRgufotUVXSKYs2SE
	/bJFG4IxFJGBjNz6MMtGgRrXF9R1Wy1rDaAqM76KiyUuyUVlnmKSgPqs2aTPH3FNjIJFMnN3jay
	aQ88jCGM95AlkJv12SUZcDdRup8/42ip60hqEL6pXn/sYILziJLxWWvO3Xe9FrhPxR3zyQfzXIf
	auWsCa8SEnzVeA3ESSSuL9H/Ujr+Fg==
X-Google-Smtp-Source: AGHT+IHL9+7vwZl8UjeM9ey+K8gWxtS0a47Frp1ysLM6X6VC+vht8sNNM+3e+XxKqyhMtHBcq2mFESjhn6ZKOK6matU=
X-Received: by 2002:a05:6402:3552:b0:63c:683c:f9d2 with SMTP id
 4fb4d7f45d1cf-63c683d021cmr2027274a12.12.1760870303625; Sun, 19 Oct 2025
 03:38:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015014756.2073439-1-neilb@ownmail.net> <20251015014756.2073439-13-neilb@ownmail.net>
In-Reply-To: <20251015014756.2073439-13-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 19 Oct 2025 12:38:12 +0200
X-Gm-Features: AS18NWAxBvspnz8caYFu1nDzhakI9yAjB-y9zxHiwJ3kVH1tyPnqDi0RQwFtX68
Message-ID: <CAOQ4uxjQsAT6HRdt0dP-xws2_pVcB8Ou_iTACOj6OqRG5fCSZg@mail.gmail.com>
Subject: Re: [PATCH v2 12/14] ecryptfs: use new start_creating/start_removing APIs
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
> This requires the addition of start_creating_dentry() which is given the
> dentry which has already been found, and asks for it to be locked and
> its parent validated.
>
> Signed-off-by: NeilBrown <neil@brown.name>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/ecryptfs/inode.c   | 153 ++++++++++++++++++++----------------------
>  fs/namei.c            |  33 +++++++++
>  include/linux/namei.h |   2 +
>  3 files changed, 107 insertions(+), 81 deletions(-)
>
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index ed1394da8d6b..b3702105d236 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -24,18 +24,26 @@
>  #include <linux/unaligned.h>
>  #include "ecryptfs_kernel.h"
>
> -static int lock_parent(struct dentry *dentry,
> -                      struct dentry **lower_dentry,
> -                      struct inode **lower_dir)
> +static struct dentry *ecryptfs_start_creating_dentry(struct dentry *dent=
ry)
>  {
> -       struct dentry *lower_dir_dentry;
> +       struct dentry *parent =3D dget_parent(dentry->d_parent);
> +       struct dentry *ret;
>
> -       lower_dir_dentry =3D ecryptfs_dentry_to_lower(dentry->d_parent);
> -       *lower_dir =3D d_inode(lower_dir_dentry);
> -       *lower_dentry =3D ecryptfs_dentry_to_lower(dentry);
> +       ret =3D start_creating_dentry(ecryptfs_dentry_to_lower(parent),
> +                                   ecryptfs_dentry_to_lower(dentry));
> +       dput(parent);
> +       return ret;
> +}
>
> -       inode_lock_nested(*lower_dir, I_MUTEX_PARENT);
> -       return (*lower_dentry)->d_parent =3D=3D lower_dir_dentry ? 0 : -E=
INVAL;
> +static struct dentry *ecryptfs_start_removing_dentry(struct dentry *dent=
ry)
> +{
> +       struct dentry *parent =3D dget_parent(dentry->d_parent);
> +       struct dentry *ret;
> +
> +       ret =3D start_removing_dentry(ecryptfs_dentry_to_lower(parent),
> +                                   ecryptfs_dentry_to_lower(dentry));
> +       dput(parent);
> +       return ret;
>  }
>
>  static int ecryptfs_inode_test(struct inode *inode, void *lower_inode)
> @@ -141,15 +149,12 @@ static int ecryptfs_do_unlink(struct inode *dir, st=
ruct dentry *dentry,
>         struct inode *lower_dir;
>         int rc;
>
> -       rc =3D lock_parent(dentry, &lower_dentry, &lower_dir);
> -       dget(lower_dentry);     // don't even try to make the lower negat=
ive
> -       if (!rc) {
> -               if (d_unhashed(lower_dentry))
> -                       rc =3D -EINVAL;
> -               else
> -                       rc =3D vfs_unlink(&nop_mnt_idmap, lower_dir, lowe=
r_dentry,
> -                                       NULL);
> -       }
> +       lower_dentry =3D ecryptfs_start_removing_dentry(dentry);
> +       if (IS_ERR(lower_dentry))
> +               return PTR_ERR(lower_dentry);
> +
> +       lower_dir =3D lower_dentry->d_parent->d_inode;
> +       rc =3D vfs_unlink(&nop_mnt_idmap, lower_dir, lower_dentry, NULL);
>         if (rc) {
>                 printk(KERN_ERR "Error in vfs_unlink; rc =3D [%d]\n", rc)=
;
>                 goto out_unlock;
> @@ -158,8 +163,7 @@ static int ecryptfs_do_unlink(struct inode *dir, stru=
ct dentry *dentry,
>         set_nlink(inode, ecryptfs_inode_to_lower(inode)->i_nlink);
>         inode_set_ctime_to_ts(inode, inode_get_ctime(dir));
>  out_unlock:
> -       dput(lower_dentry);
> -       inode_unlock(lower_dir);
> +       end_removing(lower_dentry);
>         if (!rc)
>                 d_drop(dentry);
>         return rc;
> @@ -186,10 +190,12 @@ ecryptfs_do_create(struct inode *directory_inode,
>         struct inode *lower_dir;
>         struct inode *inode;
>
> -       rc =3D lock_parent(ecryptfs_dentry, &lower_dentry, &lower_dir);
> -       if (!rc)
> -               rc =3D vfs_create(&nop_mnt_idmap, lower_dir,
> -                               lower_dentry, mode, true);
> +       lower_dentry =3D ecryptfs_start_creating_dentry(ecryptfs_dentry);
> +       if (IS_ERR(lower_dentry))
> +               return ERR_CAST(lower_dentry);
> +       lower_dir =3D lower_dentry->d_parent->d_inode;
> +       rc =3D vfs_create(&nop_mnt_idmap, lower_dir,
> +                       lower_dentry, mode, true);
>         if (rc) {
>                 printk(KERN_ERR "%s: Failure to create dentry in lower fs=
; "
>                        "rc =3D [%d]\n", __func__, rc);
> @@ -205,7 +211,7 @@ ecryptfs_do_create(struct inode *directory_inode,
>         fsstack_copy_attr_times(directory_inode, lower_dir);
>         fsstack_copy_inode_size(directory_inode, lower_dir);
>  out_lock:
> -       inode_unlock(lower_dir);
> +       end_creating(lower_dentry, NULL);
>         return inode;
>  }
>
> @@ -433,10 +439,12 @@ static int ecryptfs_link(struct dentry *old_dentry,=
 struct inode *dir,
>
>         file_size_save =3D i_size_read(d_inode(old_dentry));
>         lower_old_dentry =3D ecryptfs_dentry_to_lower(old_dentry);
> -       rc =3D lock_parent(new_dentry, &lower_new_dentry, &lower_dir);
> -       if (!rc)
> -               rc =3D vfs_link(lower_old_dentry, &nop_mnt_idmap, lower_d=
ir,
> -                             lower_new_dentry, NULL);
> +       lower_new_dentry =3D ecryptfs_start_creating_dentry(new_dentry);
> +       if (IS_ERR(lower_new_dentry))
> +               return PTR_ERR(lower_new_dentry);
> +       lower_dir =3D lower_new_dentry->d_parent->d_inode;
> +       rc =3D vfs_link(lower_old_dentry, &nop_mnt_idmap, lower_dir,
> +                     lower_new_dentry, NULL);
>         if (rc || d_really_is_negative(lower_new_dentry))
>                 goto out_lock;
>         rc =3D ecryptfs_interpose(lower_new_dentry, new_dentry, dir->i_sb=
);
> @@ -448,7 +456,7 @@ static int ecryptfs_link(struct dentry *old_dentry, s=
truct inode *dir,
>                   ecryptfs_inode_to_lower(d_inode(old_dentry))->i_nlink);
>         i_size_write(d_inode(new_dentry), file_size_save);
>  out_lock:
> -       inode_unlock(lower_dir);
> +       end_creating(lower_new_dentry, NULL);
>         return rc;
>  }
>
> @@ -468,9 +476,11 @@ static int ecryptfs_symlink(struct mnt_idmap *idmap,
>         size_t encoded_symlen;
>         struct ecryptfs_mount_crypt_stat *mount_crypt_stat =3D NULL;
>
> -       rc =3D lock_parent(dentry, &lower_dentry, &lower_dir);
> -       if (rc)
> -               goto out_lock;
> +       lower_dentry =3D ecryptfs_start_creating_dentry(dentry);
> +       if (IS_ERR(lower_dentry))
> +               return PTR_ERR(lower_dentry);
> +       lower_dir =3D lower_dentry->d_parent->d_inode;
> +
>         mount_crypt_stat =3D &ecryptfs_superblock_to_private(
>                 dir->i_sb)->mount_crypt_stat;
>         rc =3D ecryptfs_encrypt_and_encode_filename(&encoded_symname,
> @@ -490,7 +500,7 @@ static int ecryptfs_symlink(struct mnt_idmap *idmap,
>         fsstack_copy_attr_times(dir, lower_dir);
>         fsstack_copy_inode_size(dir, lower_dir);
>  out_lock:
> -       inode_unlock(lower_dir);
> +       end_creating(lower_dentry, NULL);
>         if (d_really_is_negative(dentry))
>                 d_drop(dentry);
>         return rc;
> @@ -501,12 +511,14 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idm=
ap *idmap, struct inode *dir,
>  {
>         int rc;
>         struct dentry *lower_dentry;
> +       struct dentry *lower_dir_dentry;
>         struct inode *lower_dir;
>
> -       rc =3D lock_parent(dentry, &lower_dentry, &lower_dir);
> -       if (rc)
> -               goto out;
> -
> +       lower_dentry =3D ecryptfs_start_creating_dentry(dentry);
> +       if (IS_ERR(lower_dentry))
> +               return lower_dentry;
> +       lower_dir_dentry =3D dget(lower_dentry->d_parent);
> +       lower_dir =3D lower_dir_dentry->d_inode;
>         lower_dentry =3D vfs_mkdir(&nop_mnt_idmap, lower_dir,
>                                  lower_dentry, mode);
>         rc =3D PTR_ERR(lower_dentry);
> @@ -522,7 +534,7 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idmap=
 *idmap, struct inode *dir,
>         fsstack_copy_inode_size(dir, lower_dir);
>         set_nlink(dir, lower_dir->i_nlink);
>  out:
> -       inode_unlock(lower_dir);
> +       end_creating(lower_dentry, lower_dir_dentry);
>         if (d_really_is_negative(dentry))
>                 d_drop(dentry);
>         return ERR_PTR(rc);
> @@ -534,21 +546,18 @@ static int ecryptfs_rmdir(struct inode *dir, struct=
 dentry *dentry)
>         struct inode *lower_dir;
>         int rc;
>
> -       rc =3D lock_parent(dentry, &lower_dentry, &lower_dir);
> -       dget(lower_dentry);     // don't even try to make the lower negat=
ive
> -       if (!rc) {
> -               if (d_unhashed(lower_dentry))
> -                       rc =3D -EINVAL;
> -               else
> -                       rc =3D vfs_rmdir(&nop_mnt_idmap, lower_dir, lower=
_dentry);
> -       }
> +       lower_dentry =3D ecryptfs_start_removing_dentry(dentry);
> +       if (IS_ERR(lower_dentry))
> +               return PTR_ERR(lower_dentry);
> +       lower_dir =3D lower_dentry->d_parent->d_inode;
> +
> +       rc =3D vfs_rmdir(&nop_mnt_idmap, lower_dir, lower_dentry);
>         if (!rc) {
>                 clear_nlink(d_inode(dentry));
>                 fsstack_copy_attr_times(dir, lower_dir);
>                 set_nlink(dir, lower_dir->i_nlink);
>         }
> -       dput(lower_dentry);
> -       inode_unlock(lower_dir);
> +       end_removing(lower_dentry);
>         if (!rc)
>                 d_drop(dentry);
>         return rc;
> @@ -562,10 +571,12 @@ ecryptfs_mknod(struct mnt_idmap *idmap, struct inod=
e *dir,
>         struct dentry *lower_dentry;
>         struct inode *lower_dir;
>
> -       rc =3D lock_parent(dentry, &lower_dentry, &lower_dir);
> -       if (!rc)
> -               rc =3D vfs_mknod(&nop_mnt_idmap, lower_dir,
> -                              lower_dentry, mode, dev);
> +       lower_dentry =3D ecryptfs_start_creating_dentry(dentry);
> +       if (IS_ERR(lower_dentry))
> +               return PTR_ERR(lower_dentry);
> +       lower_dir =3D lower_dentry->d_parent->d_inode;
> +
> +       rc =3D vfs_mknod(&nop_mnt_idmap, lower_dir, lower_dentry, mode, d=
ev);
>         if (rc || d_really_is_negative(lower_dentry))
>                 goto out;
>         rc =3D ecryptfs_interpose(lower_dentry, dentry, dir->i_sb);
> @@ -574,7 +585,7 @@ ecryptfs_mknod(struct mnt_idmap *idmap, struct inode =
*dir,
>         fsstack_copy_attr_times(dir, lower_dir);
>         fsstack_copy_inode_size(dir, lower_dir);
>  out:
> -       inode_unlock(lower_dir);
> +       end_removing(lower_dentry);
>         if (d_really_is_negative(dentry))
>                 d_drop(dentry);
>         return rc;
> @@ -590,7 +601,6 @@ ecryptfs_rename(struct mnt_idmap *idmap, struct inode=
 *old_dir,
>         struct dentry *lower_new_dentry;
>         struct dentry *lower_old_dir_dentry;
>         struct dentry *lower_new_dir_dentry;
> -       struct dentry *trap;
>         struct inode *target_inode;
>         struct renamedata rd =3D {};
>
> @@ -605,31 +615,13 @@ ecryptfs_rename(struct mnt_idmap *idmap, struct ino=
de *old_dir,
>
>         target_inode =3D d_inode(new_dentry);
>
> -       trap =3D lock_rename(lower_old_dir_dentry, lower_new_dir_dentry);
> -       if (IS_ERR(trap))
> -               return PTR_ERR(trap);
> -       dget(lower_new_dentry);
> -       rc =3D -EINVAL;
> -       if (lower_old_dentry->d_parent !=3D lower_old_dir_dentry)
> -               goto out_lock;
> -       if (lower_new_dentry->d_parent !=3D lower_new_dir_dentry)
> -               goto out_lock;
> -       if (d_unhashed(lower_old_dentry) || d_unhashed(lower_new_dentry))
> -               goto out_lock;
> -       /* source should not be ancestor of target */
> -       if (trap =3D=3D lower_old_dentry)
> -               goto out_lock;
> -       /* target should not be ancestor of source */
> -       if (trap =3D=3D lower_new_dentry) {
> -               rc =3D -ENOTEMPTY;
> -               goto out_lock;
> -       }
> +       rd.mnt_idmap  =3D &nop_mnt_idmap;
> +       rd.old_parent =3D lower_old_dir_dentry;
> +       rd.new_parent =3D lower_new_dir_dentry;
> +       rc =3D start_renaming_two_dentries(&rd, lower_old_dentry, lower_n=
ew_dentry);
> +       if (rc)
> +               return rc;
>
> -       rd.mnt_idmap            =3D &nop_mnt_idmap;
> -       rd.old_parent           =3D lower_old_dir_dentry;
> -       rd.old_dentry           =3D lower_old_dentry;
> -       rd.new_parent           =3D lower_new_dir_dentry;
> -       rd.new_dentry           =3D lower_new_dentry;
>         rc =3D vfs_rename(&rd);
>         if (rc)
>                 goto out_lock;
> @@ -640,8 +632,7 @@ ecryptfs_rename(struct mnt_idmap *idmap, struct inode=
 *old_dir,
>         if (new_dir !=3D old_dir)
>                 fsstack_copy_attr_all(old_dir, d_inode(lower_old_dir_dent=
ry));
>  out_lock:
> -       dput(lower_new_dentry);
> -       unlock_rename(lower_old_dir_dentry, lower_new_dir_dentry);
> +       end_renaming(&rd);
>         return rc;
>  }
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 0a5261640ae5..91e484dbc239 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3397,6 +3397,39 @@ struct dentry *start_removing_noperm(struct dentry=
 *parent,
>  }
>  EXPORT_SYMBOL(start_removing_noperm);
>
> +/**
> + * start_creating_dentry - prepare to create a given dentry
> + * @parent: directory from which dentry should be removed
> + * @child:  the dentry to be removed
> + *
> + * A lock is taken to protect the dentry again other dirops and
> + * the validity of the dentry is checked: correct parent and still hashe=
d.
> + *
> + * If the dentry is valid and negative a reference is taken and
> + * returned.  If not an error is returned.
> + *
> + * end_creating() should be called when creation is complete, or aborted=
.
> + *
> + * Returns: the valid dentry, or an error.
> + */
> +struct dentry *start_creating_dentry(struct dentry *parent,
> +                                    struct dentry *child)
> +{
> +       inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
> +       if (unlikely(IS_DEADDIR(parent->d_inode) ||
> +                    child->d_parent !=3D parent ||
> +                    d_unhashed(child))) {
> +               inode_unlock(parent->d_inode);
> +               return ERR_PTR(-EINVAL);
> +       }
> +       if (d_is_positive(child)) {
> +               inode_unlock(parent->d_inode);
> +               return ERR_PTR(-EEXIST);
> +       }
> +       return dget(child);
> +}
> +EXPORT_SYMBOL(start_creating_dentry);
> +
>  /**
>   * start_removing_dentry - prepare to remove a given dentry
>   * @parent: directory from which dentry should be removed
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index a99ac8b7e24a..208aed1d6728 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -100,6 +100,8 @@ struct dentry *start_removing_killable(struct mnt_idm=
ap *idmap,
>                                        struct qstr *name);
>  struct dentry *start_creating_noperm(struct dentry *parent, struct qstr =
*name);
>  struct dentry *start_removing_noperm(struct dentry *parent, struct qstr =
*name);
> +struct dentry *start_creating_dentry(struct dentry *parent,
> +                                    struct dentry *child);
>  struct dentry *start_removing_dentry(struct dentry *parent,
>                                      struct dentry *child);
>
> --
> 2.50.0.107.gf914562f5916.dirty
>

