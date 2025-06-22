Return-Path: <linux-fsdevel+bounces-52417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 416E9AE3243
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 23:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF9316F033
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 21:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BB52153E1;
	Sun, 22 Jun 2025 21:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="WkHGb8sy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B402EAE5
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 21:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750626846; cv=none; b=R+yZvDeb6uN2Zhn6lMbzT3cJeMMoDYayaCIo8qa7aWrHQFLbbX+MA9DqeZ7eDYlDMa/BRIs4ydKTbsw5+89a7yDmQW7cL2tyXoCPGYMi+j1ByLtkwgpIc94ToBBnBaADzifkj0U4bn6wbavCZVar2x+CrwCNxKe8cSVETWRbIDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750626846; c=relaxed/simple;
	bh=N3ZxUirxCunxJvATZXfMRKmKv+ffseg2f0MhKD6sghA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BymUYXKcIFAZXgD+P6UbT3cQBhZM77e6lmIDW74Q3ShXnhKEfZY/QZkvpx4Z+8i3zvMNHliuoX2lLxvwmft64TebL/DPV0jMcayvZTERKABpH3VZAxiBh4dvQBrpMY6KDroOpOGTNqMt+XO/210ZCzA1peNMqUbx9Z7JXyXeHLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=WkHGb8sy; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-553dceb342fso2889249e87.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 14:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1750626843; x=1751231643; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U25dcbyhJ6glgn5Z3EICqSULiBhHeqQPDqS1H63S1VU=;
        b=WkHGb8syPlQDSPNYzKDumwBq7+PDrpe3Qck1KqiQ7pMzCCgyvoJZ8MnIQC02aF3VD/
         zPOxm8b4gSXQwCrgcLR40xjeNTVER2/33OsD2MvZczr7wcF+JibbYyGIn8GKY1aLPUqI
         1LYcwBpT0QKwyJjULLhMIRUFex9pWhdAXuZQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750626843; x=1751231643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U25dcbyhJ6glgn5Z3EICqSULiBhHeqQPDqS1H63S1VU=;
        b=ZqAyj7Y0O5S0a3X8N33UkxXRoLOAHy/Y6AFq//nFojhpXcDOgPSdMcNT+p09dWuC6t
         LPDSSEPMntRNaXgozt3huOTKATnIxX5T4Yej5kRLJmJSjFY2pySVjhzqZpu6abCSSnv2
         AK0ryRDM//CY5COJPQRKYAQy8F1ngYPI6EK7XJyx6jGuy94PROOpfJe0nb0ycuQXNpLJ
         qyu9lQaH2kXTDe/03yffTjbDDgJMNWaDKC+tqywXJPhtWrY66sMm/IUPXEMfB1ie3nHU
         jYUZOge1AkUFVRK+j0h6v0CWiyd/n9lzHqbte0P1BZNMzbzdeKvf2wSfulWRefqwKQZR
         GVEA==
X-Gm-Message-State: AOJu0Yzcz63ERT9Hk+gpk9s2X8g2CV5lwSLimtajzvWK/y2JPt6o0cw2
	sDBySvcc2EkfL5obKJpowoqNXvil527S741d4VNeYfOfzXIFlAEzCG6waDQvUilo/5ezQ/MVDVl
	7YzjWdpCEdGp2+F4KUsJjk/Tky6h7uIAQcCsSVb1hgA==
X-Gm-Gg: ASbGnct+RC1X/TTXyVNSLVwYuM9HPk+LQ9lzcJnW+QmRojCsqT4YT8Az76SbUoq7HWK
	qmfTLi+62zCd7zWoUC2HftPnAaWM3nlJ2VAG36GWKzcc6WJDe+3Z22g2zRZtEnDjlFrKP6SxLpK
	z5TyhoiZGLmxWoDvEyO3PulDw3ADsoFMZWZLGttuVRIcJJ
X-Google-Smtp-Source: AGHT+IGg7j4MTzmpK9AnSXeeMQu93FYzJlR/33LFrchIpf6Cbc5ARKXNuSaopqvgkT0G2oaiEVfdpvmqRjkYEJF5WXk=
X-Received: by 2002:a05:6512:3083:b0:553:2f33:ac04 with SMTP id
 2adb3069b0e04-553e3be8255mr2893912e87.26.1750626842649; Sun, 22 Jun 2025
 14:14:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org> <20250618-work-pidfs-persistent-v2-9-98f3456fd552@kernel.org>
In-Reply-To: <20250618-work-pidfs-persistent-v2-9-98f3456fd552@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Sun, 22 Jun 2025 23:13:50 +0200
X-Gm-Features: Ac12FXz79xQRKzlsSOZjsSOx0NY4i_rmWfu6gkMfVctMVkPWZ_sHfDvtOyRyV8M
Message-ID: <CAJqdLrqnBiB3Hp_PFPqwVWChOKGc_XWPTQC7j=2Y0h3cx5eEiQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/16] pidfs: remove pidfs_pid_valid()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mike Yuan <me@yhndnzj.com>, =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

Am Mi., 18. Juni 2025 um 22:54 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> The validation is now completely handled in path_from_stashed().
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/pidfs.c | 53 -----------------------------------------------------
>  1 file changed, 53 deletions(-)
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index bc2342cf4492..ec375692a710 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -804,58 +804,8 @@ static int pidfs_export_permission(struct handle_to_path_ctx *ctx,
>         return 0;
>  }
>
> -static inline bool pidfs_pid_valid(struct pid *pid, const struct path *path,
> -                                  unsigned int flags)
> -{
> -       enum pid_type type;
> -
> -       if (flags & PIDFD_STALE)
> -               return true;
> -
> -       /*
> -        * Make sure that if a pidfd is created PIDFD_INFO_EXIT
> -        * information will be available. So after an inode for the
> -        * pidfd has been allocated perform another check that the pid
> -        * is still alive. If it is exit information is available even
> -        * if the task gets reaped before the pidfd is returned to
> -        * userspace. The only exception are indicated by PIDFD_STALE:
> -        *
> -        * (1) The kernel is in the middle of task creation and thus no
> -        *     task linkage has been established yet.
> -        * (2) The caller knows @pid has been registered in pidfs at a
> -        *     time when the task was still alive.
> -        *
> -        * In both cases exit information will have been reported.
> -        */
> -       if (flags & PIDFD_THREAD)
> -               type = PIDTYPE_PID;
> -       else
> -               type = PIDTYPE_TGID;
> -
> -       /*
> -        * Since pidfs_exit() is called before struct pid's task linkage
> -        * is removed the case where the task got reaped but a dentry
> -        * was already attached to struct pid and exit information was
> -        * recorded and published can be handled correctly.
> -        */
> -       if (unlikely(!pid_has_task(pid, type))) {
> -               struct pidfs_attr *attr;
> -
> -               attr = READ_ONCE(pid->attr);
> -               if (!attr)
> -                       return false;
> -               if (!READ_ONCE(attr->exit_info))
> -                       return false;
> -       }
> -
> -       return true;
> -}
> -
>  static struct file *pidfs_export_open(struct path *path, unsigned int oflags)
>  {
> -       if (!pidfs_pid_valid(d_inode(path->dentry)->i_private, path, oflags))
> -               return ERR_PTR(-ESRCH);
> -
>         /*
>          * Clear O_LARGEFILE as open_by_handle_at() forces it and raise
>          * O_RDWR as pidfds always are.
> @@ -993,9 +943,6 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
>         if (ret < 0)
>                 return ERR_PTR(ret);
>
> -       if (!pidfs_pid_valid(pid, &path, flags))
> -               return ERR_PTR(-ESRCH);
> -
>         flags &= ~PIDFD_STALE;
>         flags |= O_RDWR;
>         pidfd_file = dentry_open(&path, flags, current_cred());
>
> --
> 2.47.2
>

