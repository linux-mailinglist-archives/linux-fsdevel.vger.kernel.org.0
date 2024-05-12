Return-Path: <linux-fsdevel+bounces-19339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61718C34EA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 05:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B9CB2818AA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 03:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC61BE58;
	Sun, 12 May 2024 03:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="il2ePAZD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24437B64B
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 May 2024 03:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715483208; cv=none; b=lR2x1W06NF80vnSozNZfc+ru5Eqf35gX44yH269TZYulSzgN2hQxLrLSVvZm+s2DRrVEnvifVZIrDv1+uiUQTBpZYzKrm6yOo7BfdMIHzmDZk7rQ3HbvSOKzh2RxPYG6Ob3oILVPt/gtmFxwdJIXofz09XX5PwW03cyWv6Xo7ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715483208; c=relaxed/simple;
	bh=JFljjhgk2xCROBeRLxhq2w1z0ozrj4M+3pj4smcaR48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WkgWIwDUh1xiWPLi8epBwvDhlsRKuLCPo0cSeLwxbj91l/8EcJftLzSEzpeZ5/psHQdHwjPQD8c67j0lALLquQwY8Y+dPIKFMvGBoRyNi0zKaEv3aaaplCnuAozl80tdiuvblQimXjpdc/oMestBB0fz7J5KDVL31eAEScCY2rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=il2ePAZD; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-792b94301eeso296890585a.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 20:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715483206; x=1716088006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QOXZtHCWFZAVgCUe2SUjyDjIn1m/Zw8sdvhjXaCoHI=;
        b=il2ePAZDv4J8ipBcwz784TGqHBLHKjE8rs3t5FCMgK25nlPyUN2GCB7dydnUaAJZc/
         GG5EFAEvmXUllBspVE7Joc+AyPy+o70aoaPGntiSqtIbDaPm4ZK6RWhKHwdaFc1mfegJ
         vdAaXqHvgwc+eXBxHqj66tGFf7Muca+GubtLjcHE7uUrgVmkKomQzXh9QC+Lo32YKVKh
         iagYsvJuL0Q+qpd7Icbip9T1xH5qbid7IEkSBT3kHa6ZTRIej5F0FzPmZKJB4lfnvrDc
         aXnNVCd7zmYHcU9OM7EvQMbIl+E7Qr7lwbO1xDPqUquRXhpcnMM+exoRBLgW6LwjHbcd
         x8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715483206; x=1716088006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QOXZtHCWFZAVgCUe2SUjyDjIn1m/Zw8sdvhjXaCoHI=;
        b=tbQesBLn7F77lad3i9VM5Pw90Z7V8myTb0bXeesRxx5Co/r5u/e9pSMTuVU+Au8/vq
         2Iu2OWJ4HLDqVEEBF1D3qwPxwy5SE8yYazaMcwv3BOh0HGm1Yde7a8g+h+n0juPcBv66
         Bt790fi5Jl6pyyo/1xU4e7PTUzUxEvMOmohujtfE++DxOl291Y2XWyFz2dv4nZ8LxhQp
         /EocI2lTGRb6r5SFXrs4iC9B6OVrlJY7pox5gsPwuHx4iAq97bQcTIcjKqO7EZI3TNO4
         YLhgIWtiWEerhzts/GfKtd8waIOy9A5hcy62w1RbRB3pLP8kNmVSlt5qejpIv5u4BuYn
         YYLA==
X-Forwarded-Encrypted: i=1; AJvYcCXigK6gPXLSwqvXEUenqjISCFh/wxAP53hddqhn8yETXttfx/YWE/ATaKye6Dqz+PpcPPixoBIvx0P3722nqtTqMNVRm087ANeg/m00OA==
X-Gm-Message-State: AOJu0YzBcc9id/Nfvre9GKtKrndGqEb48J68CKRILb4BiNLCknUB371c
	pU6oWAieycBH1eXCvDonPv5FnKdJF3zwdNrA3ZLkvifn8cArcHKMgml5EpvawURNL00TsPd+P5v
	8uaG48QByih1KnZG5VftMqhuG4xB+J2uu4vo=
X-Google-Smtp-Source: AGHT+IHZ4zltM5l8E7o4+/ZlH0mrvVju2X1sgCAetgLJ3eJoidCFimG4V4hAG1jeFkQt3fKWYJhX4Mz36iN9A1WP5Zs=
X-Received: by 2002:a05:6214:4407:b0:6a0:c8da:5cb2 with SMTP id
 6a1803df08f44-6a168151ebdmr66002656d6.3.1715483205978; Sat, 11 May 2024
 20:06:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wijTRY-72qm02kZAT_Ttua0Qwvfms5m5NbR4EWbS02NqA@mail.gmail.com>
 <20240511200240.6354-2-torvalds@linux-foundation.org>
In-Reply-To: <20240511200240.6354-2-torvalds@linux-foundation.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 12 May 2024 11:06:07 +0800
Message-ID: <CALOAHbBSRGViePQm45upEJnUNnOa1=ZjkvAT_tR6jXMTEKUSkw@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: move dentry shrinking outside the inode lock in 'rmdir()'
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	longman@redhat.com, viro@zeniv.linux.org.uk, walters@verbum.org, 
	wangkai86@huawei.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 12, 2024 at 4:03=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Yafang Shao reports that he has seen loads that generate billions of
> negative dentries in a directory, which then when the directory is
> removed causes excessive latencies for other users because the dentry
> shrinking is done under the directory inode lock.
>
> There seems to be no actual reason for holding the inode lock any more
> by the time we get rid of the now uninteresting negative dentries, and
> it's an effect of the calling convention.
>
> Split the 'vfs_rmdir()' function into two separate phases:
>
>  - 'vfs_rmdir_raw()' does the actual main rmdir heavy lifting
>
>  - 'vfs_rmdir_cleanup()' needs to be run by the caller after a
>    successful raw call, after the caller has dropped the inode locks.
>
> We leave the 'vfs_rmdir()' function around, since it has multiple
> callers, and only convert the main system call path to the new two-phase
> model.  The other uses will be left as an exercise for the reader for
> when people find they care.
>
> [ Side note: I think the 'dget()/dput()' pair in vfs_rmdir_raw() is
>   superfluous, since callers always have to have a dentry reference over
>   the call anyway. That's a separate issue.    - Linus ]
>
> Reported-by: Yafang Shao <laoar.shao@gmail.com>
> Link: https://lore.kernel.org/all/20240511022729.35144-1-laoar.shao@gmail=
.com/
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

This could resolve the secondary concern.
Tested-by: Yafang Shao <laoar.shao@gmail.com>

Might it be feasible to execute the vfs_rmdir_cleanup() within a
kwoker? Such an approach could potentially mitigate the initial
concern as well.

> ---
>
> Second version - this time doing the dentry pruning even later, after
> releasing the parent inode lock too.
>
> I did the same amount of "extensive testing" on this one as the previous
> one.  IOW, little-to-none.
>
>  fs/namei.c | 61 ++++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 41 insertions(+), 20 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 28e62238346e..15b4ff6ed1e5 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4176,21 +4176,7 @@ SYSCALL_DEFINE2(mkdir, const char __user *, pathna=
me, umode_t, mode)
>         return do_mkdirat(AT_FDCWD, getname(pathname), mode);
>  }
>
> -/**
> - * vfs_rmdir - remove directory
> - * @idmap:     idmap of the mount the inode was found from
> - * @dir:       inode of @dentry
> - * @dentry:    pointer to dentry of the base directory
> - *
> - * Remove a directory.
> - *
> - * If the inode has been found through an idmapped mount the idmap of
> - * the vfsmount must be passed through @idmap. This function will then t=
ake
> - * care to map the inode according to @idmap before checking permissions=
.
> - * On non-idmapped mounts or if permission checking is to be performed o=
n the
> - * raw inode simply pass @nop_mnt_idmap.
> - */
> -int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
> +static int vfs_rmdir_raw(struct mnt_idmap *idmap, struct inode *dir,
>                      struct dentry *dentry)
>  {
>         int error =3D may_delete(idmap, dir, dentry, 1);
> @@ -4217,18 +4203,43 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct ino=
de *dir,
>         if (error)
>                 goto out;
>
> -       shrink_dcache_parent(dentry);
>         dentry->d_inode->i_flags |=3D S_DEAD;
>         dont_mount(dentry);
>         detach_mounts(dentry);
> -
>  out:
>         inode_unlock(dentry->d_inode);
>         dput(dentry);
> -       if (!error)
> -               d_delete_notify(dir, dentry);
>         return error;
>  }
> +
> +static inline void vfs_rmdir_cleanup(struct inode *dir, struct dentry *d=
entry)
> +{
> +       shrink_dcache_parent(dentry);
> +       d_delete_notify(dir, dentry);
> +}
> +
> +/**
> + * vfs_rmdir - remove directory
> + * @idmap:     idmap of the mount the inode was found from
> + * @dir:       inode of @dentry
> + * @dentry:    pointer to dentry of the base directory
> + *
> + * Remove a directory.
> + *
> + * If the inode has been found through an idmapped mount the idmap of
> + * the vfsmount must be passed through @idmap. This function will then t=
ake
> + * care to map the inode according to @idmap before checking permissions=
.
> + * On non-idmapped mounts or if permission checking is to be performed o=
n the
> + * raw inode simply pass @nop_mnt_idmap.
> + */
> +int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
> +                    struct dentry *dentry)
> +{
> +       int retval =3D vfs_rmdir_raw(idmap, dir, dentry);
> +       if (!retval)
> +               vfs_rmdir_cleanup(dir, dentry);
> +       return retval;
> +}
>  EXPORT_SYMBOL(vfs_rmdir);
>
>  int do_rmdir(int dfd, struct filename *name)
> @@ -4272,7 +4283,17 @@ int do_rmdir(int dfd, struct filename *name)
>         error =3D security_path_rmdir(&path, dentry);
>         if (error)
>                 goto exit4;
> -       error =3D vfs_rmdir(mnt_idmap(path.mnt), path.dentry->d_inode, de=
ntry);
> +       error =3D vfs_rmdir_raw(mnt_idmap(path.mnt), path.dentry->d_inode=
, dentry);
> +       if (error)
> +               goto exit4;
> +       inode_unlock(path.dentry->d_inode);
> +       mnt_drop_write(path.mnt);
> +       vfs_rmdir_cleanup(path.dentry->d_inode, dentry);
> +       dput(dentry);
> +       path_put(&path);
> +       putname(name);
> +       return 0;
> +
>  exit4:
>         dput(dentry);
>  exit3:
> --
> 2.44.0.330.g4d18c88175
>


--=20
Regards
Yafang

