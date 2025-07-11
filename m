Return-Path: <linux-fsdevel+bounces-54616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22865B019E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 12:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96D5E7A4D2E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 10:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48E128643F;
	Fri, 11 Jul 2025 10:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMkwBiOH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806DB27A927;
	Fri, 11 Jul 2025 10:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752230475; cv=none; b=oWGVYK0NnmbNt0sysuWBg797k0GiDnT1vsDVwwOpOAJI4kckMSw6TrLtJwcO6BMRPx1jtn8lv0ewjrSUG1wCY54i0QUqrdy0uJXhmCstGYpaLQPLV11yi9dddD9U2n5ikF17590czP6zuvSHJNysi0vGUMld5mxgET9cyFlNRRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752230475; c=relaxed/simple;
	bh=nqdN+S+q/NcNzjU8CUkzqppLsb6dRf97fkyfo2ItziQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T2lgtX2CInNFWGiK6cu10NVOxTh2b5MNqNHdTK8PoP6lh46lxIVdL3KHTOEUiZIbO6ORyajKNtSl7WxnYtBG2TFjig4rIoQapivqKC9VHz/ReCTMroNrwOiYQ99Y1WNqGI3RkTOulDnKvPBHK5IGT9LRomWofsB6gFFUFb7QEeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMkwBiOH; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso3708443a12.2;
        Fri, 11 Jul 2025 03:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752230472; x=1752835272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqE4b0t6rfqUFbp0NCoSazjYl9TiKvogLEiWybDxynM=;
        b=PMkwBiOHXjY93UiaF0Bc5vG5+Ag84DWzWq0JxtaYY6Nh9xzFrWLMHvotew3ItMozlL
         F6BW3BQHSf3bViZE3vESMV/pOtMLOctuXSOv/PIEdI2AAfg/Ts8ljbSEvCnmuim5HMFx
         cYeOgxLVRAiRuL6EfRpRUd7p/8N6gyjTzHZ92ghUzc9wdl5m2miIX5Yjx2wzKtdI1jeX
         587flbzDZy4hOmyGmzmTyZd5LZZGmGwM4/+4oCkPXR4QnPAxJLeVWwNxSgG+DXUNgNbW
         +Ix2O36CcbscSutkPm55L5RT2uSdQV9AR03pPXn+EQePTMRV71rJvro3ycrIjxmNxtWl
         SreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752230472; x=1752835272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eqE4b0t6rfqUFbp0NCoSazjYl9TiKvogLEiWybDxynM=;
        b=OUFR7GCd+OX14viR3GfG1QO1gBHakHEt08jqaviyjhAw1sKyjJpcasm1yx5BHL93H0
         INRSSGloHZklmYVZBDyNNmL8fnS5awz1n9w2eWWn+cTJ/qtTTtDhL2u46Ay6YxdXrT45
         59g77ut7NpxN7Y+hKwQF3t85av3HrejVEpJoRNNCjrmVCeWQlvKimK3fmMR7Z4stWWM6
         BwqU5kriKtlnzGVrBVpXsuYEdMNbFXeZveYjoZ84LBZIPW4WgfqbyW34QYtoOmWEuLNG
         exFfWnMFFOBrMsSydgzPXK+FgU45SakUbxSvLiYmCeQkUGiKHo4uaFUNBIz2XxV8V8Sd
         H/TA==
X-Forwarded-Encrypted: i=1; AJvYcCVWudl/gmCgBkhzqTOcMTR3j1HkXn3QrcHTU3++UQ6uGp8ZtlJ+kcXFiKSPC4AONTH0EzfUoXu3WTDwIUaarg==@vger.kernel.org, AJvYcCXDLGuq59UhDGn/cL993py+8jjr+JoVAWCxOD3ZBNem61dir0/TeaNjJLFDj4In1sMP+nQqKtVPyUMkrAbq@vger.kernel.org
X-Gm-Message-State: AOJu0YwXxC8bDbh83jc+jXpKHVkB6IxgT49chI/FtVHO8Kp0dn7/njw2
	Gg/KR+6xQ98eaX82lSPrXq4q7nceZwjzr78kZtI/Xyd1s1OPOr93Hf7gZl7kde7k1bgNcYTkYtE
	X+YegdceNdjqHEs9QAfMCYq/e5vckAT8=
X-Gm-Gg: ASbGnct5rivuiyLd3ZkcG+/w6vX57A2p8VOe8RMeBbo2czQsaRUHa6VNS3KkHaQHIfy
	XkXOt1MsuYyjQfywgSgJjDiDXuLisuAuWEgVOiyq2FQmSoeUAMNIttr+hPAA/PmXgeuZbkHTaEK
	LM0TIARqiXbxg6pMQk94xQzt4OEJ42wtbtg/qvgCEB3FRTOOqSb8i7Cj3fSLU4x1zSTPjkmMC+Z
	qtcCww=
X-Google-Smtp-Source: AGHT+IHytILpKbMHe+CqvTh/plpRa/xNQEx7xmjk7A2zEgr5r4mUeD0Ow/BikI4Hem+OdUs8gxXkwjvWkPfbl+J4Upk=
X-Received: by 2002:a17:907:9b84:b0:ad5:1c28:3c4b with SMTP id
 a640c23a62f3a-ae6fc21cc5bmr270281966b.52.1752230471489; Fri, 11 Jul 2025
 03:41:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710232109.3014537-1-neil@brown.name> <20250710232109.3014537-3-neil@brown.name>
In-Reply-To: <20250710232109.3014537-3-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 11 Jul 2025 12:41:00 +0200
X-Gm-Features: Ac12FXxJwM5VKxnzLS4qXnLsa-HxM7tBRbImNYeLEw_1SKocSlAYXyYZAWI-MQQ
Message-ID: <CAOQ4uxjHzRpGKe+YR4=79OOT0gwAKJox_2BPjeuhkbr9jk8rWg@mail.gmail.com>
Subject: Re: [PATCH 02/20] ovl: change ovl_create_index() to take write and
 dir locks
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 1:21=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> ovl_copy_up_workdir() currently take a rename lock on two directories,
> then use the lock to both create a file in one directory, perform a
> rename, and possibly unlink the file for cleanup.  This is incompatible
> with proposed changes which will lock just the dentry of objects being
> acted on.
>
> This patch moves the call to ovl_create_index() earlier in
> ovl_copy_up_workdir() to before the lock is taken, and also before write
> access to the filesystem is gained (this last is not strictly necessary
> but seems cleaner).

With my proposed change to patch 1, ovl_create_index() will be
called with ovl_start_write() held so you wont need to add it.

>
> ovl_create_index() then take the requires locks and drops them before
> returning.
>
> Signed-off-by: NeilBrown <neil@brown.name>

With that fixed, feel free to add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

> ---
>  fs/overlayfs/copy_up.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index 5d21b8d94a0a..25be0b80a40b 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -517,8 +517,6 @@ static int ovl_set_upper_fh(struct ovl_fs *ofs, struc=
t dentry *upper,
>
>  /*
>   * Create and install index entry.
> - *
> - * Caller must hold i_mutex on indexdir.
>   */
>  static int ovl_create_index(struct dentry *dentry, const struct ovl_fh *=
fh,
>                             struct dentry *upper)
> @@ -550,7 +548,10 @@ static int ovl_create_index(struct dentry *dentry, c=
onst struct ovl_fh *fh,
>         if (err)
>                 return err;
>
> +       ovl_start_write(dentry);
> +       inode_lock(dir);
>         temp =3D ovl_create_temp(ofs, indexdir, OVL_CATTR(S_IFDIR | 0));
> +       inode_unlock(dir);
>         err =3D PTR_ERR(temp);
>         if (IS_ERR(temp))
>                 goto free_name;
> @@ -559,6 +560,9 @@ static int ovl_create_index(struct dentry *dentry, co=
nst struct ovl_fh *fh,
>         if (err)
>                 goto out;
>
> +       err =3D parent_lock(indexdir, temp);
> +       if (err)
> +               goto out;
>         index =3D ovl_lookup_upper(ofs, name.name, indexdir, name.len);
>         if (IS_ERR(index)) {
>                 err =3D PTR_ERR(index);
> @@ -566,9 +570,11 @@ static int ovl_create_index(struct dentry *dentry, c=
onst struct ovl_fh *fh,
>                 err =3D ovl_do_rename(ofs, indexdir, temp, indexdir, inde=
x, 0);
>                 dput(index);
>         }
> +       parent_unlock(indexdir);
>  out:
>         if (err)
> -               ovl_cleanup(ofs, dir, temp);
> +               ovl_cleanup_unlocked(ofs, indexdir, temp);
> +       ovl_end_write(dentry);
>         dput(temp);
>  free_name:
>         kfree(name.name);
> @@ -797,6 +803,12 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ct=
x *c)
>         if (err)
>                 goto cleanup_need_write;
>
> +       if (S_ISDIR(c->stat.mode) && c->indexed) {
> +               err =3D ovl_create_index(c->dentry, c->origin_fh, temp);
> +               if (err)
> +                       goto cleanup_need_write;
> +       }
> +
>         /*
>          * We cannot hold lock_rename() throughout this helper, because o=
f
>          * lock ordering with sb_writers, which shouldn't be held when ca=
lling
> @@ -818,12 +830,6 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ct=
x *c)
>         if (err)
>                 goto cleanup;
>
> -       if (S_ISDIR(c->stat.mode) && c->indexed) {
> -               err =3D ovl_create_index(c->dentry, c->origin_fh, temp);
> -               if (err)
> -                       goto cleanup;
> -       }
> -
>         upper =3D ovl_lookup_upper(ofs, c->destname.name, c->destdir,
>                                  c->destname.len);
>         err =3D PTR_ERR(upper);
> --
> 2.49.0
>

