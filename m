Return-Path: <linux-fsdevel+bounces-52105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFDCADF6FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 21:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AEA81BC0D7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 19:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5819218585;
	Wed, 18 Jun 2025 19:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="hSBliWOK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3693419DF7A
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750275667; cv=none; b=UeKNqL0ef6GogpR6hfPUfVtXHt55psx3kJQpNhsrwp2BLby0j1I98it19y6hrV/XNPlcvLjf+nIRZFnZBJMDflsaDbLPlfVjxaqc5T4r51k9vRMUWJSRKSjNpIsw91Ua3zw/QKU5m59LSa1LtK4K8NBTW/9gRCGNoNxmCXGG/pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750275667; c=relaxed/simple;
	bh=MomHFYVbHU+sLf7vljZc97arA6KKG7vTO5wa1HrKZqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MuTKOgv8qT/m9J2VEkCgBrit95r+L22Z/AGlq7MGRsmxbVG2aEQLTHTnfnSOEk5S+wPH5+NXNSfV49sQSTHFGOcN4BymmUcAqifdeJlCZvuka4aQluWHxNEpLqoUFPb+m74hEToxTFOSGEAKsSr7ZYTVCUopl8vzaHEJbYSDQFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=hSBliWOK; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-553ba7f11cbso4986713e87.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 12:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1750275663; x=1750880463; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ePE3eTY38YnPr3dbNd5SPOdaEusG94ompeCZ0rmRKMs=;
        b=hSBliWOK4SwjuTTQq+mPBhVb3qO2I+zZy5ZpUMRfRDNDrC6Ojq5IOxy1jxbV6ld6HW
         JHSFgZGJIryJDRasLi1aF0rijiYfdVNkze6I3fPof1+DQhQr8ZO+V02H1v03PstJdDwj
         Ydzge6HS5576WowXo4zveuSb1HWJ7koa0Zpak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750275663; x=1750880463;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ePE3eTY38YnPr3dbNd5SPOdaEusG94ompeCZ0rmRKMs=;
        b=jPYVlnO+m6+zsrbLNohymwQc+yfom10qXrRenIKCUzrrCvB7dWl5SeBY9HbmcF26pX
         3UVPTQ4nZZtvEsSzdgZKYJx6C0E7RoKBh5zdnTRarZQKmt6mPdn1owIy1UZHgB6FDzJa
         Dm21pLB9bYaGnG9PAU+LHjtafz2q9WEB/oLJ6X84C64mEYFZ9YOdIi6AHBuUrnKguj9s
         u2jE4ZgV7dKeVEFzaiAsgR2zAp0KqOrhwTY3VGYTPd1m2fGtF4DAjEQkPl6U7ao8OO9R
         C9HmYeIqMDB9zXpMWFA96RUXFULEmIXM4dwd1sr8j4v5YVQwFvflK68bPAJI7T/10UBl
         d1qA==
X-Gm-Message-State: AOJu0YwVk9B120dPhIGzAaeg5ZvweXOPkKqbOUgNrHskh6TgSrnMKoUP
	hTOmU/PIwqpEPKR8xOPJujGwnkAAYvRR9Rbw3C1AVArfb6IjMX6bBxg0n6k0YWdoxCaaXKjQghI
	4p8sT9QXI7I9LC5O6TY6KiJb7V47BALGsofA6i5w3Uw==
X-Gm-Gg: ASbGncskYhrNna9qeRC/uNhIjWsHTOBB1c2lU50NJRNMA5cNg7gQdOlLjs5TKwj9X20
	DKf9Dhi5DG5znIyCrT83uvs4ex+PmP892R6fUi3U8SNSu4jma0fitJ2XwC6Kf714HbefS0JeFF2
	g3Xnr73yufFs05vmXHyXp24L3U92W2TKw60iHY0BaAvk1k
X-Google-Smtp-Source: AGHT+IG3CaljGdxEAoWHnqY4TN3kKfo9+s8ktiE2hc8l3uEsnCKUf7oBEQ6Lw7wKTfNUyMeo6aEKC0NMzD7wdo0KBAs=
X-Received: by 2002:a05:6512:10d4:b0:553:5d4a:1cdb with SMTP id
 2adb3069b0e04-553b6e7d1f9mr5261159e87.5.1750275662879; Wed, 18 Jun 2025
 12:41:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617-work-pidfs-xattr-v1-0-2d0df10405bb@kernel.org> <20250617-work-pidfs-xattr-v1-2-2d0df10405bb@kernel.org>
In-Reply-To: <20250617-work-pidfs-xattr-v1-2-2d0df10405bb@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 18 Jun 2025 21:40:51 +0200
X-Gm-Features: Ac12FXxkxigo5FzGFk1OEBWQXHL8hAzMbNRPO-0ymvFJjcuWNzFNJBBAXbti-sE
Message-ID: <CAJqdLrpKXicxs4yp_GV-Am6szeRAueDJ6W6AF5+9XbwfhiWtNg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/9] pidfs: remove pidfs_pid_valid()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mike Yuan <me@yhndnzj.com>, =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

Am Di., 17. Juni 2025 um 17:42 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> The validation is now completely handled in path_from_stashed().
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/pidfs.c | 48 ------------------------------------------------
>  1 file changed, 48 deletions(-)
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index ee5e9a18c2d3..9373d03fd263 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -869,53 +869,8 @@ static int pidfs_export_permission(struct handle_to_path_ctx *ctx,
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
> -               struct inode *inode = d_inode(path->dentry);
> -               return !!READ_ONCE(pidfs_i(inode)->exit_info);
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
> @@ -1032,9 +987,6 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
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

