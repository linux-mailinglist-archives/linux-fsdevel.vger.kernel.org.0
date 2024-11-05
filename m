Return-Path: <linux-fsdevel+bounces-33650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D07629BC80D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 09:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3BD51C21B50
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 08:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEE11CEAAA;
	Tue,  5 Nov 2024 08:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="F8ErgTCT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC122C1A2
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Nov 2024 08:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730795502; cv=none; b=IP5Fo/I8IzatB6gZoZbFQJTYk5iUEVcvfP7O0qDFuEiGGsMddxWzjf/gi7XWTqW749WsQM88P3Fxx1evxW3PyTJ2zSDzoqaqYTxWhHQGiWfIPhi3DekSanDt0fC47bLEwCZGVGDBpBHgGr9g8AG9HR707ya9xS5a6Us54cwjx/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730795502; c=relaxed/simple;
	bh=a+/Z5HCLWAqFe9kJLjCtp3TP8nih4/kqHmqtcCTiBa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7f+XG2FEEE6MVc1XhPakWwMA17/DYvDJNjtVkScf0/IRdD5khQlyIBDBXYUK0aJ7T1SA7VYFWn34uqngIZ1Gb2Vfq3hoTYI4y3KPEX4KVRfpfgWfAgaocaTTCHxk6BM3FfgOunqbsDd36AaFYkxfquu5re8KRZEXZxC/6v6r38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=F8ErgTCT; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e291cbbf05bso4922091276.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Nov 2024 00:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1730795497; x=1731400297; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ze9WHQ0beEz8+ocNfaZ5viUgzsEDrj/TAqXIVsGM76k=;
        b=F8ErgTCThQy4UrOiq4VQHc30DTBwtTe1ztuaOMQc0WBwzWSuWadHh0pPMr7UXhtGeB
         5yWVpHcKXOaEych2oYu/wcdOCDqBSPg7ik8ZRk5O6klvGwnblPUiBxp81CGzthvMyErx
         LBOgLNxpkjXwyksSqM4a18v97rjwlqG6o8GNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730795497; x=1731400297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ze9WHQ0beEz8+ocNfaZ5viUgzsEDrj/TAqXIVsGM76k=;
        b=gCEWAneVYR6C11isUNBDaakJnPcpM2rrFhz/lxurOXFir2JNHbquHrNQO8ubG4Bd3e
         zq9cbZP+/3zDgbSGn8aJ0Yrune5fIZ0tk9enYuQEHRjqPKciqBx/5++Cvx9xNtVRsnDF
         Rqn7FSicz6ceLEsAvYmbABZpLSUoDA2B0mVcS04VnbEXiFImtblW/mw0hVPq5A7OzE89
         ndpFXnEiL91Cfay9xEvOT7fP0Bj4aEpvZTNiRrUKiuNfZ1Q0bI+adg6kZR5BT6HcMQmy
         YGRgNb2pX3yDRSK0UgrITlYofDNKaxxTH16zNF+htDj3NPnKM6/PM2KpW3JZBGh2J8Bx
         gDkw==
X-Forwarded-Encrypted: i=1; AJvYcCUjwP5r5eO664WAS7MVDEKP9yfCT5WDEtReV+rwD8La8zsmvcQdgWGTY+dKT2i+NPoUqeGZveOZGT5jqgnI@vger.kernel.org
X-Gm-Message-State: AOJu0YwsZktg+Nu31vOpJL92XHyLONTmlm6r3611P+MnhuTLCZ8yziUJ
	8BaFmNrbRiI/K+VNVRQMp1hpSaJeIyUX7UMqTvJ3zBYCA9YHhX4h8jSRd/s3BYEgxVEW2RSKA85
	JzJsN6CcN24srFwPOehUxQPSuIPyE7ATpQs9qOQ==
X-Google-Smtp-Source: AGHT+IHemnM16Rf3hM25uBaKAMuFL0NVZTdWj5pD/ZJ/9CsWuTjJ2lAXkP9rWfJpmBYmKxlx8VPnjp7sKeqF7CLT0yQ=
X-Received: by 2002:a05:6902:1081:b0:e25:fc6f:9cbf with SMTP id
 3f1490d57ef6-e30e5b3b269mr17448141276.52.1730795497472; Tue, 05 Nov 2024
 00:31:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101193703.3282039-1-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20241101193703.3282039-1-stefanb@linux.vnet.ibm.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 5 Nov 2024 09:31:26 +0100
Message-ID: <CAJfpegvGGt+XankFJjuijr6QXVUFXRUWTotLNXLQ4n21ELf=Xg@mail.gmail.com>
Subject: Re: [PATCH] fs: Simplify getattr interface function checking
 AT_GETATTR_NOSEC flag
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	LSM <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Nov 2024 at 20:37, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
>
> From: Stefan Berger <stefanb@linux.ibm.com>
>
> Commit 8a924db2d7b5 ("fs: Pass AT_GETATTR_NOSEC flag to getattr interface
> function")' introduced the AT_GETATTR_NOSEC flag to ensure that the
> call paths only call vfs_getattr_nosec if it is set instead of vfs_getattr.
> Now, simplify the getattr interface functions of filesystems where the flag
> AT_GETATTR_NOSEC is checked.
>
> There is only a single caller of inode_operations getattr function and it
> is located in fs/stat.c in vfs_getattr_nosec. The caller there is the only
> one from which the AT_GETATTR_NOSEC flag is passed from.
>
> Two filesystems are checking this flag in .getattr and the flag is always
> passed to them unconditionally from only vfs_getattr_nosec:
>
> - ecryptfs:  Simplify by always calling vfs_getattr_nosec in
>              ecryptfs_getattr. From there the flag is passed to no other
>              function and this function is not called otherwise.
>
> - overlayfs: Simplify by always calling vfs_getattr_nosec in
>              ovl_getattr. From there the flag is passed to no other
>              function and this function is not called otherwise.
>
> The query_flags in vfs_getattr_nosec will mask-out AT_GETATTR_NOSEC from
> any caller using AT_STATX_SYNC_TYPE as mask so that the flag is not
> important inside this function. Also, since no filesystem is checking the
> flag anymore, remove the flag entirely now, including the BUG_ON check that
> never triggered.
>
> The net change of the changes here combined with the originan commit is
> that ecryptfs and overlayfs do not call vfs_getattr but only
> vfs_getattr_nosec.

[Adding LSM list.]

The original intention was I think that security_inode_getattr()
should be called on the backing inode IFF it was called on the backed
(overlay/ecryptfs) inode.

The implementation was broken, but the question remains whether this
is needed or not.

Thanks,
Miklos


>
> Fixes: 8a924db2d7b5 ("fs: Pass AT_GETATTR_NOSEC flag to getattr interface function")
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Closes: https://lore.kernel.org/linux-fsdevel/20241101011724.GN1350452@ZenIV/T/#u
> Cc: Tyler Hicks <code@tyhicks.com>
> Cc: ecryptfs@vger.kernel.org
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: linux-unionfs@vger.kernel.org
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  fs/ecryptfs/inode.c        | 12 ++----------
>  fs/overlayfs/inode.c       | 10 +++++-----
>  fs/overlayfs/overlayfs.h   |  8 --------
>  fs/stat.c                  |  5 +----
>  include/uapi/linux/fcntl.h |  4 ----
>  5 files changed, 8 insertions(+), 31 deletions(-)
>
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index cbdf82f0183f..a9819ddb1ab8 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -1008,14 +1008,6 @@ static int ecryptfs_getattr_link(struct mnt_idmap *idmap,
>         return rc;
>  }
>
> -static int ecryptfs_do_getattr(const struct path *path, struct kstat *stat,
> -                              u32 request_mask, unsigned int flags)
> -{
> -       if (flags & AT_GETATTR_NOSEC)
> -               return vfs_getattr_nosec(path, stat, request_mask, flags);
> -       return vfs_getattr(path, stat, request_mask, flags);
> -}
> -
>  static int ecryptfs_getattr(struct mnt_idmap *idmap,
>                             const struct path *path, struct kstat *stat,
>                             u32 request_mask, unsigned int flags)
> @@ -1024,8 +1016,8 @@ static int ecryptfs_getattr(struct mnt_idmap *idmap,
>         struct kstat lower_stat;
>         int rc;
>
> -       rc = ecryptfs_do_getattr(ecryptfs_dentry_to_lower_path(dentry),
> -                                &lower_stat, request_mask, flags);
> +       rc = vfs_getattr_nosec(ecryptfs_dentry_to_lower_path(dentry),
> +                              &lower_stat, request_mask, flags);
>         if (!rc) {
>                 fsstack_copy_attr_all(d_inode(dentry),
>                                       ecryptfs_inode_to_lower(d_inode(dentry)));
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index 35fd3e3e1778..8b31f44c12cd 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -170,7 +170,7 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
>
>         type = ovl_path_real(dentry, &realpath);
>         old_cred = ovl_override_creds(dentry->d_sb);
> -       err = ovl_do_getattr(&realpath, stat, request_mask, flags);
> +       err = vfs_getattr_nosec(&realpath, stat, request_mask, flags);
>         if (err)
>                 goto out;
>
> @@ -195,8 +195,8 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
>                                         (!is_dir ? STATX_NLINK : 0);
>
>                         ovl_path_lower(dentry, &realpath);
> -                       err = ovl_do_getattr(&realpath, &lowerstat, lowermask,
> -                                            flags);
> +                       err = vfs_getattr_nosec(&realpath, &lowerstat, lowermask,
> +                                               flags);
>                         if (err)
>                                 goto out;
>
> @@ -248,8 +248,8 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
>
>                         ovl_path_lowerdata(dentry, &realpath);
>                         if (realpath.dentry) {
> -                               err = ovl_do_getattr(&realpath, &lowerdatastat,
> -                                                    lowermask, flags);
> +                               err = vfs_getattr_nosec(&realpath, &lowerdatastat,
> +                                                       lowermask, flags);
>                                 if (err)
>                                         goto out;
>                         } else {
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 0bfe35da4b7b..910dbbb2bb7b 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -412,14 +412,6 @@ static inline bool ovl_open_flags_need_copy_up(int flags)
>         return ((OPEN_FMODE(flags) & FMODE_WRITE) || (flags & O_TRUNC));
>  }
>
> -static inline int ovl_do_getattr(const struct path *path, struct kstat *stat,
> -                                u32 request_mask, unsigned int flags)
> -{
> -       if (flags & AT_GETATTR_NOSEC)
> -               return vfs_getattr_nosec(path, stat, request_mask, flags);
> -       return vfs_getattr(path, stat, request_mask, flags);
> -}
> -
>  /* util.c */
>  int ovl_get_write_access(struct dentry *dentry);
>  void ovl_put_write_access(struct dentry *dentry);
> diff --git a/fs/stat.c b/fs/stat.c
> index 41e598376d7e..cbc0fcd4fba3 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -165,7 +165,7 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
>         if (inode->i_op->getattr)
>                 return inode->i_op->getattr(idmap, path, stat,
>                                             request_mask,
> -                                           query_flags | AT_GETATTR_NOSEC);
> +                                           query_flags);
>
>         generic_fillattr(idmap, request_mask, inode, stat);
>         return 0;
> @@ -198,9 +198,6 @@ int vfs_getattr(const struct path *path, struct kstat *stat,
>  {
>         int retval;
>
> -       if (WARN_ON_ONCE(query_flags & AT_GETATTR_NOSEC))
> -               return -EPERM;
> -
>         retval = security_inode_getattr(path);
>         if (retval)
>                 return retval;
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index 87e2dec79fea..a40833bf2855 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -154,8 +154,4 @@
>                                            usable with open_by_handle_at(2). */
>  #define AT_HANDLE_MNT_ID_UNIQUE        0x001   /* Return the u64 unique mount ID. */
>
> -#if defined(__KERNEL__)
> -#define AT_GETATTR_NOSEC       0x80000000
> -#endif
> -
>  #endif /* _UAPI_LINUX_FCNTL_H */
> --
> 2.47.0
>

