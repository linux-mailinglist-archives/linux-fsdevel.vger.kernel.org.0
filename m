Return-Path: <linux-fsdevel+bounces-52410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 309DDAE3204
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 22:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBAA0188CE23
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 20:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBA71F152D;
	Sun, 22 Jun 2025 20:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="QCmQmoU7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3404D2F2E
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 20:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750624822; cv=none; b=pzRzGKGnTMeDIOY+YLdhLS8uu2A962LlG9y6UqSAoj8JTxVKtpqUubQa90fQwg3z2ytbBcMflN3iyKgO3v7Fp1MvJ3pY6V0kQ3lLw4pOJAJ5DETOkJA5Knf6YZJzWrq5Lxyt5AT8Zvqu9fdABR8/08l4yTyexcheK8BmusyRmO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750624822; c=relaxed/simple;
	bh=pXxwLXGXGg2gKWJ3SY9z8E8wNiCCClTBVyvP7VtTjb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HBAkSQ83AtpEhaS0PD4Y3Eg9N6NvOQ7OobUDpHKigW3wYfbF9YGQOmSzSM55hTCHc1PYA3WB6XmjtLS8oTJVV5wOdpUhQqFTL6uwjrepXlP0Samum5GDzSdgQ4E/t95QxpwJPQA5KbFrK5pXLFoI+D9/LkPcsoh2cPNO4HgBSz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=QCmQmoU7; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-553e5df44f8so2121034e87.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 13:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1750624817; x=1751229617; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=64bfE8SJaN1ZDgdvI3BREjsHjqwPHVAh2za8SWRc+Vk=;
        b=QCmQmoU79hEVW9oEdd2zfnUyW22NRbTjYN47QHeylOy8sHUqyuD+lG4Wh6lDq00IOe
         LOxZsfv47jvQrkCbSfus9bljTTagN91Q7jr+27lQj/fE8hqCRIkgX0I8/owKpJpsAMdS
         vBy3oxGMGlHIJarCiTHvJtv99klEeqzkcPFzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750624817; x=1751229617;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=64bfE8SJaN1ZDgdvI3BREjsHjqwPHVAh2za8SWRc+Vk=;
        b=Bo6AW/bejgWHDyBikG1QoMUTLqFzGM0LPUV2iZNka8KJAhkWbCrCKaTXf2PNKHeqW0
         HUVLscBUcg7YmgZVPhTH5PgxTRiYcfDwT0BfXf9ceCn6omHlj5SQcLIxYW7w3BNjaMuT
         7ttYHohl4lBeQXxNzE6vBSodwqDORwVXwPNA974SlEJpgm23S/kPiJwdnkOnjfENVQaj
         7nk8NZWaMy0OWVVxR61HMEOpaI8YtV+3lKHo+5it2bz9It3IqQtTiHBcaM4mN82P3j5B
         gKNHzt9SwbvSsog09WcqellkER34Irmiom9fz/ay1DwIwxhcjMVb/WQYCvvwPvGKZi42
         8lAA==
X-Gm-Message-State: AOJu0YxMEcrYsokH2NwP8NKy+MInMsedbO9uJhBJVe66zk1SQILNVDpK
	Tq7jB59q0+IL3BlS2vakj2I7Usf5kJV/Uq729xofKxJNp6ZXyWjJwSIFy277V/ptjBQpRdA8LZI
	nP2+1rBpbyycvLCmb8z1PgbFw4cBexekiGD81HP5ySw==
X-Gm-Gg: ASbGnctNwT4lekikWPoXwAEwPAYkS+hfq01N98Tv+98BbVK0HLX634z4bcRXsIE9BUm
	C1kuXeNLLriRd0/jNEKLns4/Cojsj9+vTsAOaQBcTAHoo/S1YmHvOdlVb+KOoOlhNF5J5Rq1Hot
	/LBjWxKFNk6IiBwPyIyfiUMIaFQgVPK30F79FL49lUQB6F
X-Google-Smtp-Source: AGHT+IFzBFnh+wY22A5kbkbvFI+2HoPzkuznky2dsI8O1l/CEgrhlAjtCbQUhkaviWnxoQob3syXe6RyY2PrbZEV+fo=
X-Received: by 2002:a05:6512:b1f:b0:54a:cc04:ea24 with SMTP id
 2adb3069b0e04-553e3c07959mr2938938e87.46.1750624817130; Sun, 22 Jun 2025
 13:40:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org> <20250618-work-pidfs-persistent-v2-2-98f3456fd552@kernel.org>
In-Reply-To: <20250618-work-pidfs-persistent-v2-2-98f3456fd552@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Sun, 22 Jun 2025 22:40:05 +0200
X-Gm-Features: Ac12FXwXA4rsmuKPHrwb1z9zW-Zj3D_N0ZDg99oapODJPQQ0dTgxfDZyKrVPw3g
Message-ID: <CAJqdLrqXTSPJv4QPcnO4wmvdAUXviyqWPxD7bRP6ULB_shpr4w@mail.gmail.com>
Subject: Re: [PATCH v2 02/16] libfs: massage path_from_stashed() to allow
 custom stashing behavior
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mike Yuan <me@yhndnzj.com>, =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

Am Mi., 18. Juni 2025 um 22:53 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> * Add a callback to struct stashed_operations so it's possible to
>   implement custom behavior for pidfs and allow for it to return errors.
>
> * Teach stashed_dentry_get() to handle error pointers.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/internal.h |  3 +++
>  fs/libfs.c    | 27 ++++++++++++++++++++-------
>  2 files changed, 23 insertions(+), 7 deletions(-)
>
> diff --git a/fs/internal.h b/fs/internal.h
> index 393f6c5c24f6..22ba066d1dba 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -322,12 +322,15 @@ struct mnt_idmap *alloc_mnt_idmap(struct user_namespace *mnt_userns);
>  struct mnt_idmap *mnt_idmap_get(struct mnt_idmap *idmap);
>  void mnt_idmap_put(struct mnt_idmap *idmap);
>  struct stashed_operations {
> +       struct dentry *(*stash_dentry)(struct dentry **stashed,
> +                                      struct dentry *dentry);
>         void (*put_data)(void *data);
>         int (*init_inode)(struct inode *inode, void *data);
>  };
>  int path_from_stashed(struct dentry **stashed, struct vfsmount *mnt, void *data,
>                       struct path *path);
>  void stashed_dentry_prune(struct dentry *dentry);
> +struct dentry *stash_dentry(struct dentry **stashed, struct dentry *dentry);
>  struct dentry *stashed_dentry_get(struct dentry **stashed);
>  /**
>   * path_mounted - check whether path is mounted
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 9ea0ecc325a8..3541e22c87b5 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -2128,6 +2128,8 @@ struct dentry *stashed_dentry_get(struct dentry **stashed)
>         dentry = rcu_dereference(*stashed);
>         if (!dentry)
>                 return NULL;
> +       if (IS_ERR(dentry))
> +               return dentry;
>         if (!lockref_get_not_dead(&dentry->d_lockref))
>                 return NULL;
>         return dentry;
> @@ -2176,8 +2178,7 @@ static struct dentry *prepare_anon_dentry(struct dentry **stashed,
>         return dentry;
>  }
>
> -static struct dentry *stash_dentry(struct dentry **stashed,
> -                                  struct dentry *dentry)
> +struct dentry *stash_dentry(struct dentry **stashed, struct dentry *dentry)
>  {
>         guard(rcu)();
>         for (;;) {
> @@ -2218,12 +2219,15 @@ static struct dentry *stash_dentry(struct dentry **stashed,
>  int path_from_stashed(struct dentry **stashed, struct vfsmount *mnt, void *data,
>                       struct path *path)
>  {
> -       struct dentry *dentry;
> +       struct dentry *dentry, *res;
>         const struct stashed_operations *sops = mnt->mnt_sb->s_fs_info;
>
>         /* See if dentry can be reused. */
> -       path->dentry = stashed_dentry_get(stashed);
> -       if (path->dentry) {
> +       res = stashed_dentry_get(stashed);
> +       if (IS_ERR(res))
> +               return PTR_ERR(res);
> +       if (res) {
> +               path->dentry = res;
>                 sops->put_data(data);
>                 goto out_path;
>         }
> @@ -2234,8 +2238,17 @@ int path_from_stashed(struct dentry **stashed, struct vfsmount *mnt, void *data,
>                 return PTR_ERR(dentry);
>
>         /* Added a new dentry. @data is now owned by the filesystem. */
> -       path->dentry = stash_dentry(stashed, dentry);
> -       if (path->dentry != dentry)
> +       if (sops->stash_dentry)
> +               res = sops->stash_dentry(stashed, dentry);
> +       else
> +               res = stash_dentry(stashed, dentry);
> +       if (IS_ERR(res)) {
> +               dput(dentry);
> +               return PTR_ERR(res);
> +       }
> +       path->dentry = res;
> +       /* A dentry was reused. */
> +       if (res != dentry)
>                 dput(dentry);
>
>  out_path:
>
> --
> 2.47.2
>

