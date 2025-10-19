Return-Path: <linux-fsdevel+bounces-64611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEEFBEE286
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 12:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9824B4E4378
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 10:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5762E2DDD;
	Sun, 19 Oct 2025 10:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhV+HjOi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DB52C21F2
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Oct 2025 10:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760868152; cv=none; b=GoyXXQ6Zh0t+QcEpxdTEd6mq+FtK67ryiKsD1Am/HybvETCUhzGqjgynTl+OldrfOtgPQ3EMhr7W6S8xELtemAE1EIZj5W6zsYV0fyXjfmRX9H6X7C+uSJ3DMROggTb3k1kQ8XOibOTykczUP0xmw6n4qpAjcNbqx+abqhQPw6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760868152; c=relaxed/simple;
	bh=XN0BVMpkeCa0uY4qVb7IwZCVXIyXXASMjbC/cKKar8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P2EhTc/6LnByWKKqC5p58FHjgtgDbLvH2IEH+M0xwuMVIfIFaTwb7Z5JcQSgxdR6uiyk9BQDJD2rFOAkLjKDSKdyb4DvIYVEH29m1GyJ3VJWgdAX6AiEyYsMq26oScoP0cEtWh+u1HxZCxdxxecxm9gnRzHIfHnTZ7tumS0rbG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhV+HjOi; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63c1a0d6315so5798796a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Oct 2025 03:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760868149; x=1761472949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AXCGodpOr7Ttc1rXSfWrLUMPs2mPK13FYqCSlUnGoc=;
        b=MhV+HjOij7xPo/xXJvaN9z5JJWHXve0FRuCOxRd2nxIX6VyKZ3klVi1SGbT7NJP1DQ
         thjEpPJy5ARrtdEzQZ5Uo42m+B4cI0pvSPx02o3hkVZ72cGH2y6yW3XJyupQ2lI0ZXCO
         aO7cZ8nLC2j+LXksx5wD5lsqYBtWV8obvEe1nGb4YztQ5iNmMqsVFUJkfTEZxn87mjq/
         BYFkdUgQ7YueiY4x2530PrPCmkr57eTmSas1ul6yDTn1cNKvNvUWXjAqi2Su798O58Ns
         oLAaPAauqwnYITNW23J4XR0rV5eM4e2yCMI85XA8hDEtgesDHndSUUxdAeG19ugJY/hQ
         VMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760868149; x=1761472949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6AXCGodpOr7Ttc1rXSfWrLUMPs2mPK13FYqCSlUnGoc=;
        b=rBK+pBIzijKjxYHlIeGExo0CPOORyGDv47tlfYFBmUMTAvmQ0Q2+XV4X5il8ajay0d
         W4tUMvB+lKeVh1ax9wHMDt+CnO/35oG0qqwWibo46aM98pSMCSlhjHdK/il++C4mIPLO
         12qf0KXd++S52MJl2QOMlYoPLDr32OdOvmO3JXeWCRWq8oQhDRU7+N6fj6IurdiE71+A
         pCZWCiQq+AVwmgTJkhrkGLYnXkUaynkGKbV2BNISGN1DjvTXlZZdSbaaW1J7FZu0cTwx
         onzCP8bUDqa6DRXnl56g+bIiAc8IOmMQYnCV4pvmKgrEtAxNsNfKMV+yBv/O0r/835XK
         gDcg==
X-Forwarded-Encrypted: i=1; AJvYcCU9J33FORj5jUqBRI3sV5DXlTCGr66O+HXwW3mT9QTZADwSdu5k7HoaAab+CdVBUyY8Veqk0YIh1/qIqQ1A@vger.kernel.org
X-Gm-Message-State: AOJu0Yz19ceNN3c/Bz7DN1o4CMXrViQgdTA8Z9VlInfctJ3gov4nCyZN
	TlihXdVN7FG/OOZCJjh7JN0SKveuHV5fz8vcMfb2ufgXQdYUJSht2lyEpBm0TbqtZuB3FLZIZNI
	Vi5jxtlR/cm3eibzb6H4OW6qyeWcOr/Qp8yGoDaw=
X-Gm-Gg: ASbGnct5U7GE20k/AM9pkML0vueTHPFSsACfQPzrYgTVl9HgpB0LCcdAGmE72S1PcZt
	Qlj9y6c6h7JungKKnjKfsEu3tupjuQbfUYbHFmsy0ngjbV0K9fXxHDjxj8WqdcwDWxgxG2RzNiY
	C3JGi+VVqRrej2MaSuI+Ht02nPRWO46ltXpLUweZ5bkwKwQoTcdyk7lcPRDfFNJQqA/+3iqgKUv
	TrzNQXYHKw+KG0E6jd+a14N7/zFk4ACHKRkADx0PekAtPSE5IfYrKQiwPcm9gStWgkuuJrEWGfp
	1NZn6mIwLYBP9ashGkM=
X-Google-Smtp-Source: AGHT+IG4xfIGM/6JJ0Tbenn67Py6zDqX/itNpw6dl589O6W0UivBBONNTgMUNUdAQVgraPUwhEwjpILNSjMAkGhDNX4=
X-Received: by 2002:a05:6402:34cf:b0:63b:edb2:16ee with SMTP id
 4fb4d7f45d1cf-63c1f626eb6mr8788516a12.7.1760868148516; Sun, 19 Oct 2025
 03:02:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015014756.2073439-1-neilb@ownmail.net> <20251015014756.2073439-4-neilb@ownmail.net>
In-Reply-To: <20251015014756.2073439-4-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 19 Oct 2025 12:02:17 +0200
X-Gm-Features: AS18NWA80pBcVz9upXsHEU12qUB6oS_Xh8TuQ0G3xQEAedDm3EtpNOm6wLmK2OA
Message-ID: <CAOQ4uxh_2hhjLNH0=pYrvX3YNU7W-6pf2GYvD08XvyLpbH6GLQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/14] VFS: tidy up do_unlinkat()
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 3:48=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> The simplification of locking in the previous patch opens up some room
> for tidying up do_unlinkat()
>
> - change all "exit" labels to describe what will happen at the label.
> - always goto an exit label on an error - unwrap the "if (!IS_ERR())" bra=
nch.
> - Move the "slashes" handing inline, but mark it as unlikely()
> - simplify use of the "inode" variable - we no longer need to test for NU=
LL.
>
> Signed-off-by: NeilBrown <neil@brown.name>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/namei.c | 55 ++++++++++++++++++++++++++----------------------------
>  1 file changed, 26 insertions(+), 29 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 3618efd4bcaa..9effaad115d9 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4755,65 +4755,62 @@ int do_unlinkat(int dfd, struct filename *name)
>         struct path path;
>         struct qstr last;
>         int type;
> -       struct inode *inode =3D NULL;
> +       struct inode *inode;
>         struct inode *delegated_inode =3D NULL;
>         unsigned int lookup_flags =3D 0;
>  retry:
>         error =3D filename_parentat(dfd, name, lookup_flags, &path, &last=
, &type);
>         if (error)
> -               goto exit1;
> +               goto exit_putname;
>
>         error =3D -EISDIR;
>         if (type !=3D LAST_NORM)
> -               goto exit2;
> +               goto exit_path_put;
>
>         error =3D mnt_want_write(path.mnt);
>         if (error)
> -               goto exit2;
> +               goto exit_path_put;
>  retry_deleg:
>         dentry =3D start_dirop(path.dentry, &last, lookup_flags);
>         error =3D PTR_ERR(dentry);
> -       if (!IS_ERR(dentry)) {
> +       if (IS_ERR(dentry))
> +               goto exit_drop_write;
>
> -               /* Why not before? Because we want correct error value */
> -               if (last.name[last.len])
> -                       goto slashes;
> -               inode =3D dentry->d_inode;
> -               ihold(inode);
> -               error =3D security_path_unlink(&path, dentry);
> -               if (error)
> -                       goto exit3;
> -               error =3D vfs_unlink(mnt_idmap(path.mnt), path.dentry->d_=
inode,
> -                                  dentry, &delegated_inode);
> -exit3:
> +       /* Why not before? Because we want correct error value */
> +       if (unlikely(last.name[last.len])) {
> +               if (d_is_dir(dentry))
> +                       error =3D -EISDIR;
> +               else
> +                       error =3D -ENOTDIR;
>                 end_dirop(dentry);
> +               goto exit_drop_write;
>         }
> -       if (inode)
> -               iput(inode);    /* truncate the inode here */
> -       inode =3D NULL;
> +       inode =3D dentry->d_inode;
> +       ihold(inode);
> +       error =3D security_path_unlink(&path, dentry);
> +       if (error)
> +               goto exit_end_dirop;
> +       error =3D vfs_unlink(mnt_idmap(path.mnt), path.dentry->d_inode,
> +                          dentry, &delegated_inode);
> +exit_end_dirop:
> +       end_dirop(dentry);
> +       iput(inode);    /* truncate the inode here */
>         if (delegated_inode) {
>                 error =3D break_deleg_wait(&delegated_inode);
>                 if (!error)
>                         goto retry_deleg;
>         }
> +exit_drop_write:
>         mnt_drop_write(path.mnt);
> -exit2:
> +exit_path_put:
>         path_put(&path);
>         if (retry_estale(error, lookup_flags)) {
>                 lookup_flags |=3D LOOKUP_REVAL;
> -               inode =3D NULL;
>                 goto retry;
>         }
> -exit1:
> +exit_putname:
>         putname(name);
>         return error;
> -
> -slashes:
> -       if (d_is_dir(dentry))
> -               error =3D -EISDIR;
> -       else
> -               error =3D -ENOTDIR;
> -       goto exit3;
>  }
>
>  SYSCALL_DEFINE3(unlinkat, int, dfd, const char __user *, pathname, int, =
flag)
> --
> 2.50.0.107.gf914562f5916.dirty
>

