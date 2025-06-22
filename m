Return-Path: <linux-fsdevel+bounces-52416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3F0AE323F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 23:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D683ACAC2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 21:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B442B1F8690;
	Sun, 22 Jun 2025 21:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="PsjZ8hO9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CDF2EAE5
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 21:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750626731; cv=none; b=PCHx5TaXU5Tuf0abHDiuioboIQN8mzef2Dc/1hxOu4zYuszBw2mDtaBZ7wdi2eJ7Wk4ocrq1DpIz+C5A1JA4Ho/qApIM12Vq3W2PFRk0vVZnG7FVFznfO+LOO3OkZD2dpwgEqWeKbdF/eZjOIhppPCi6EoKFextRBTXbxk62vAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750626731; c=relaxed/simple;
	bh=0FnR03qDNQuPGE+Is65MEGq7f7QtyzHcaREf+tfNcXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TqsStac+1iAABbGBaRvEg7U5f8KUSfEnWLadf1rdx+yRo+AoznPGA5TcGvfUmall7inRFr73qgbAK0vjN7iv19lX78nwNlYxfJbKgrAr6ABNVN6HsH5exCOQnoXXORlqD7KcHQ0dn9kvA6FZkK0nbM3MPx/n9uHwR6LLt1oQK7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=PsjZ8hO9; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32b7123edb9so33875591fa.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 14:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1750626727; x=1751231527; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R/Y1NqWwz0tbJ3UCThJ77uB2AmtD519rE3rKA3t1PT0=;
        b=PsjZ8hO9I5VZQg3nny7LipRywcVdS9r2sHwk5pv3pGK/TCE5Y93mTYB+ptLwV3YbCY
         LcntlP3bSEFy6zCUmKvPem4pTtXSNYSWG17D7POhHVYaQRYpN1XGKnyuGLsJ9vhRMwS5
         2SHCLti9GzXDv8kz0sDgJE/r7LpVaPQ0RTZi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750626727; x=1751231527;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R/Y1NqWwz0tbJ3UCThJ77uB2AmtD519rE3rKA3t1PT0=;
        b=ih8frInpjnVIM3D9GUFakb21hl0p8jE28Icgh0FdG4Y4C8kFAwmRWaso9bGBYVCxzQ
         h0viIviMGWV3UKC19blalZ2j/sYQJ/OH9FJe6FuPPBk4G8MqgjHYG3g6rb7wABiXRdqC
         ion5ssZTmTMUzPmI7Nh8IHA0vs53xiC2WwbQJIlAvIkrth77K6OqFbMOr02TeZGLjrKJ
         LLF9u3wSAhXTsAOoFB0iNfGmc+kTFJ7qNa9yrLfGZzrvFOIH45Vr6jxJkHM8gTfNN/MP
         I87Bl1dGF7KJZSUbzA0gY+yr6nxOiwj4/qfqZF198706UPI0tGE03z682oPGwIemWXJ4
         QF8Q==
X-Gm-Message-State: AOJu0YxsgQnhStMrIZYoDIDwZIvQc5tyge8vqqrvbAgBUee6PR5rIPAA
	lQPuN48fZeDH8Ip3yRkP5HW4jGJ3PQeOvMpNJfEL+hs1f8ZZzrCROvg5M/Yr5VNmWpgrR87gJ2U
	6e2Hc4x9Es5suHV65NtY9GFepVU+1av7E76NwP7Hh9g==
X-Gm-Gg: ASbGncvCuXi5+Dgp5F3YeH9/dVb6FAsmq4LAq0fb8zTd7Klm89CHsnaDQNyfF9d5gKz
	6e2iJw9dLlofaUN3y43P8Kf7C3Y3JytBEMdiVnY50nC4uo6gSM8az9UAt7ryqxvCDw73/MunDJt
	G65qf8RNkBzq9i1zuwhKeVchh4e1fxRV9Im/2lHuQJDS7C
X-Google-Smtp-Source: AGHT+IFK9xqxnpcdjFfuTgBDhfk2jyVIlvb28Zeb03pRifjn3knEfkLTZgmxnp1AwMH3GzvbNEuYBSErTzD5sFx1QeY=
X-Received: by 2002:a2e:bc1a:0:b0:32a:66e6:9ff9 with SMTP id
 38308e7fff4ca-32b98f37b14mr33369641fa.26.1750626727376; Sun, 22 Jun 2025
 14:12:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org> <20250618-work-pidfs-persistent-v2-8-98f3456fd552@kernel.org>
In-Reply-To: <20250618-work-pidfs-persistent-v2-8-98f3456fd552@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Sun, 22 Jun 2025 23:11:56 +0200
X-Gm-Features: Ac12FXwNWqUbHPxRin55tFi-J3R7X260sXuP9873BsmFoIQ8PPovhLiJzOJ_BEE
Message-ID: <CAJqdLro3yvjQjxYs-1avTKL29Di_vxSk47XD_RiTEgi6u7PKcw@mail.gmail.com>
Subject: Re: [PATCH v2 08/16] pidfs: remove pidfs_{get,put}_pid()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mike Yuan <me@yhndnzj.com>, =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

Am Mi., 18. Juni 2025 um 22:54 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Now that we stash persistent information in struct pid there's no need
> to play volatile games with pinning struct pid via dentries in pidfs.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/coredump.c         |  6 ------
>  fs/pidfs.c            | 35 +----------------------------------
>  include/linux/pidfs.h |  2 --
>  net/unix/af_unix.c    |  5 -----
>  4 files changed, 1 insertion(+), 47 deletions(-)
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index f217ebf2b3b6..55d6a713a0fb 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -898,12 +898,6 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>                 retval = kernel_connect(socket, (struct sockaddr *)(&addr),
>                                         addr_len, O_NONBLOCK | SOCK_COREDUMP);
>
> -               /*
> -                * ... Make sure to only put our reference after connect() took
> -                * its own reference keeping the pidfs entry alive ...
> -                */
> -               pidfs_put_pid(cprm.pid);
> -
>                 if (retval) {
>                         if (retval == -EAGAIN)
>                                 coredump_report_failure("Coredump socket %s receive queue full", addr.sun_path);
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index c49c53d6ae51..bc2342cf4492 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -895,8 +895,7 @@ static void pidfs_put_data(void *data)
>   * pidfs_register_pid - register a struct pid in pidfs
>   * @pid: pid to pin
>   *
> - * Register a struct pid in pidfs. Needs to be paired with
> - * pidfs_put_pid() to not risk leaking the pidfs dentry and inode.
> + * Register a struct pid in pidfs.
>   *
>   * Return: On success zero, on error a negative error code is returned.
>   */
> @@ -1007,38 +1006,6 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
>         return pidfd_file;
>  }
>
> -/**
> - * pidfs_get_pid - pin a struct pid through pidfs
> - * @pid: pid to pin
> - *
> - * Similar to pidfs_register_pid() but only valid if the caller knows
> - * there's a reference to the @pid through a dentry already that can't
> - * go away.
> - */
> -void pidfs_get_pid(struct pid *pid)
> -{
> -       if (!pid)
> -               return;
> -       WARN_ON_ONCE(!stashed_dentry_get(&pid->stashed));
> -}
> -
> -/**
> - * pidfs_put_pid - drop a pidfs reference
> - * @pid: pid to drop
> - *
> - * Drop a reference to @pid via pidfs. This is only safe if the
> - * reference has been taken via pidfs_get_pid().
> - */
> -void pidfs_put_pid(struct pid *pid)
> -{
> -       might_sleep();
> -
> -       if (!pid)
> -               return;
> -       VFS_WARN_ON_ONCE(!pid->stashed);
> -       dput(pid->stashed);
> -}
> -
>  void __init pidfs_init(void)
>  {
>         pidfs_attr_cachep = kmem_cache_create("pidfs_attr_cache", sizeof(struct pidfs_attr), 0,
> diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
> index 8f6ed59bb3fb..3e08c33da2df 100644
> --- a/include/linux/pidfs.h
> +++ b/include/linux/pidfs.h
> @@ -14,8 +14,6 @@ void pidfs_coredump(const struct coredump_params *cprm);
>  #endif
>  extern const struct dentry_operations pidfs_dentry_operations;
>  int pidfs_register_pid(struct pid *pid);
> -void pidfs_get_pid(struct pid *pid);
> -void pidfs_put_pid(struct pid *pid);
>  void pidfs_free_pid(struct pid *pid);
>
>  #endif /* _LINUX_PID_FS_H */
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 2e2e9997a68e..129388c309b0 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -646,9 +646,6 @@ static void unix_sock_destructor(struct sock *sk)
>                 return;
>         }
>
> -       if (sk->sk_peer_pid)
> -               pidfs_put_pid(sk->sk_peer_pid);
> -
>         if (u->addr)
>                 unix_release_addr(u->addr);
>
> @@ -769,7 +766,6 @@ static void drop_peercred(struct unix_peercred *peercred)
>         swap(peercred->peer_pid, pid);
>         swap(peercred->peer_cred, cred);
>
> -       pidfs_put_pid(pid);
>         put_pid(pid);
>         put_cred(cred);
>  }
> @@ -802,7 +798,6 @@ static void copy_peercred(struct sock *sk, struct sock *peersk)
>
>         spin_lock(&sk->sk_peer_lock);
>         sk->sk_peer_pid = get_pid(peersk->sk_peer_pid);
> -       pidfs_get_pid(sk->sk_peer_pid);
>         sk->sk_peer_cred = get_cred(peersk->sk_peer_cred);
>         spin_unlock(&sk->sk_peer_lock);
>  }
>
> --
> 2.47.2
>

