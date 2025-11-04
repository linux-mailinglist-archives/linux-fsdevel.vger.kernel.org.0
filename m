Return-Path: <linux-fsdevel+bounces-66896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7984DC300E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 09:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84D29188B6AA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 08:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BE829B8FE;
	Tue,  4 Nov 2025 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="UZyOwWSu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844D923EA80
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 08:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762245950; cv=none; b=KI8IunJY15mLAwqhDyxbgkLUrkX7lWFLr2hW/eG2um03nJAAXu7E4o04gzLo4s9POxcEOYxS0Fzgu082MXQoLInDt0ltnEn1Mu/IhUEMpF6b4/qFRmPMjttaXZ8RXqEJtdgFsBdoeUz83v+7yDAcWP1TT43zNsaZ0GMM8zeLq4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762245950; c=relaxed/simple;
	bh=PN0zYbucyFvRDAgetmp3jqYlZ/7ZYZYgxqA3IuHoPE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q4K3NENX/02RphLtnP0urAYKLobnEMYvK22NJOnw2kmen5AeKQJvMDKFXoa3f7Sd7sme0Odx1u+1BCUKmWKv8OLhvYIlzOKyuEe5tQjy++RNsxd5w68yKPFHYSUm0UoaKnPk4RxPLfpdz/D3H4U4Y1q5AWLDq6/KWlJqwZLgpiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=UZyOwWSu; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-592f22b1e49so4730492e87.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 00:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1762245945; x=1762850745; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2RSzAQ24HSl4CevKsG32QBTt1QzsVJYEHj3v/tZDkDc=;
        b=UZyOwWSuEsOSijGmfAI8bTSU/4cwzUWlkZ7nfSxqy/TinxP+DX1XGIDCX9rNFDe0yf
         7gTB200T6I5thjd+jwFohUMANmmeUVhE4vMEt2gCBpwau1NlP4mY8t28F2odAC67TCjD
         dJcsQYJg8tNk1Sy9307bhdAw9gIuFlqw76otg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762245945; x=1762850745;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2RSzAQ24HSl4CevKsG32QBTt1QzsVJYEHj3v/tZDkDc=;
        b=fHq3TfWnpaGluUGkB4HA85mB7FNzyNBukV1ijDuS3VlnVyFmBeVeFp+1nOWhBy5kix
         4wWgH/L8vCQa/AIVxcbYBcl4kA4A/ml/3fdyauSPj91acS3LG5toY7trXlfgJldVrsN8
         0xKWNfs+UL3cgrqppRj6nfowdo4taIOALAbv6iJFuvijmx/qOn6mOYhUBfEk6gW7hYw0
         vX3If+ndMf+omZL1LOvTWI0GJtRGXstuygQmsW/aVxt5/l+pPJzwAnmoAlsLtEBkcAhh
         MTNzurgHe0pLVPmApy8DEniXdpuVsvodSMjQCZUNQG5aoKfqK904vU4qA/W+oB/1dOhP
         UXEQ==
X-Gm-Message-State: AOJu0YzFkUjkROrMm//Gc/fZfiR1oaBxc4mgLdwt8lfTLr5anHcdJY5u
	aT6ELlisW0VJi/egGWpykne9qH1wWd7KfcuURM7T3DeUggSBC25MvEsl9QHPxFTvpYG1q1MTdRz
	z71I2o+jZz6DbhlQvBuMchBf+do0RNyisA4rSNIl25Q==
X-Gm-Gg: ASbGncvrwpIAHCFilJ8Ds4oZSG16jQhVjoNw7mRAo+0dAP8/rhyOBrXG7EN8nk72VAJ
	owjjWrtJBO5UeJy94sNULIq0EbTaqQUpP7iN9bw0G+bXTOySgwLSqd1Ra9O0YJC6j2Q4MqS/lTQ
	eZ9OQxNWGSCjKtlHHUVZji0AXt4KX2kW5s6cajBpKXi99BhijyLAKw6vFRoY0jLpuOHetTUtaAo
	IKzut5KaU2UdkButzPhjNk0ShfDBTCma4o4jJFlYhFwagdksTQ5vZvJjjik
X-Google-Smtp-Source: AGHT+IFEKvFX/PZTJ29M6W4Mp7l5Z6W+B+zFgA2nSdktSZiKnMxF+DapTY8O+S9s2Q5waGMPdQWLa7/+Hvuajw7T6/I=
X-Received: by 2002:a05:6512:3e10:b0:594:2a0f:916f with SMTP id
 2adb3069b0e04-5942a0f94e8mr1878807e87.43.1762245943565; Tue, 04 Nov 2025
 00:45:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org> <20251028-work-coredump-signal-v1-7-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-7-ca449b7b7aa0@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 4 Nov 2025 09:45:32 +0100
X-Gm-Features: AWmQ_bmGmSsMLZ3W30EoBy7JM7gw3m9QpQBa7PrIXq1Ns2b_-4I1cV8wPwwRM8s
Message-ID: <CAJqdLrpCH9wsJUo0F2a9XVTFWav-jE--m+KoV5KF0Dqp2qU9hg@mail.gmail.com>
Subject: Re: [PATCH 07/22] pidfs: drop struct pidfs_exit_info
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, 
	Amir Goldstein <amir73il@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Yu Watanabe <watanabe.yu+github@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Jann Horn <jannh@google.com>, 
	Luca Boccassi <luca.boccassi@gmail.com>, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

Am Di., 28. Okt. 2025 um 09:46 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> This is not needed anymore now that we have the new scheme to guarantee
> all-or-nothing information exposure.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/pidfs.c | 35 +++++++++++------------------------
>  1 file changed, 11 insertions(+), 24 deletions(-)
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 0fad0c969b7a..a3b80be3b98b 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -39,16 +39,6 @@ void pidfs_get_root(struct path *path)
>         path_get(path);
>  }
>
> -/*
> - * Stashes information that userspace needs to access even after the
> - * process has been reaped.
> - */
> -struct pidfs_exit_info {
> -       __u64 cgroupid;
> -       __s32 exit_code;
> -       __u32 coredump_mask;
> -};
> -
>  enum pidfs_attr_mask_bits {
>         PIDFS_ATTR_BIT_EXIT     = 0,
>  };
> @@ -56,8 +46,11 @@ enum pidfs_attr_mask_bits {
>  struct pidfs_attr {
>         unsigned long attr_mask;
>         struct simple_xattrs *xattrs;
> -       struct pidfs_exit_info __pei;
> -       struct pidfs_exit_info *exit_info;
> +       struct /* exit info */ {
> +               __u64 cgroupid;
> +               __s32 exit_code;
> +       };
> +       __u32 coredump_mask;
>  };
>
>  static struct rb_root pidfs_ino_tree = RB_ROOT;
> @@ -313,7 +306,6 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
>         struct pid *pid = pidfd_pid(file);
>         size_t usize = _IOC_SIZE(cmd);
>         struct pidfd_info kinfo = {};
> -       struct pidfs_exit_info *exit_info;
>         struct user_namespace *user_ns;
>         struct pidfs_attr *attr;
>         const struct cred *c;
> @@ -342,15 +334,15 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
>                         smp_rmb();
>                         kinfo.mask |= PIDFD_INFO_EXIT;
>  #ifdef CONFIG_CGROUPS
> -                       kinfo.cgroupid = exit_info->cgroupid;
> +                       kinfo.cgroupid = attr->cgroupid;
>                         kinfo.mask |= PIDFD_INFO_CGROUPID;
>  #endif
> -                       kinfo.exit_code = exit_info->exit_code;
> +                       kinfo.exit_code = attr->exit_code;
>                 }
>         }
>
>         if (mask & PIDFD_INFO_COREDUMP) {
> -               kinfo.coredump_mask = READ_ONCE(attr->__pei.coredump_mask);
> +               kinfo.coredump_mask = READ_ONCE(attr->coredump_mask);
>                 if (kinfo.coredump_mask)
>                         kinfo.mask |= PIDFD_INFO_COREDUMP;
>         }
> @@ -629,7 +621,6 @@ void pidfs_exit(struct task_struct *tsk)
>  {
>         struct pid *pid = task_pid(tsk);
>         struct pidfs_attr *attr;
> -       struct pidfs_exit_info *exit_info;
>  #ifdef CONFIG_CGROUPS
>         struct cgroup *cgrp;
>  #endif
> @@ -657,15 +648,13 @@ void pidfs_exit(struct task_struct *tsk)
>          * is put
>          */
>
> -       exit_info = &attr->__pei;
> -
>  #ifdef CONFIG_CGROUPS
>         rcu_read_lock();
>         cgrp = task_dfl_cgroup(tsk);
> -       exit_info->cgroupid = cgroup_id(cgrp);
> +       attr->cgroupid = cgroup_id(cgrp);
>         rcu_read_unlock();
>  #endif
> -       exit_info->exit_code = tsk->exit_code;
> +       attr->exit_code = tsk->exit_code;
>
>         /* Ensure that PIDFD_GET_INFO sees either all or nothing. */
>         smp_wmb();
> @@ -676,7 +665,6 @@ void pidfs_exit(struct task_struct *tsk)
>  void pidfs_coredump(const struct coredump_params *cprm)
>  {
>         struct pid *pid = cprm->pid;
> -       struct pidfs_exit_info *exit_info;
>         struct pidfs_attr *attr;
>         __u32 coredump_mask = 0;
>
> @@ -685,14 +673,13 @@ void pidfs_coredump(const struct coredump_params *cprm)
>         VFS_WARN_ON_ONCE(!attr);
>         VFS_WARN_ON_ONCE(attr == PIDFS_PID_DEAD);
>
> -       exit_info = &attr->__pei;
>         /* Note how we were coredumped. */
>         coredump_mask = pidfs_coredump_mask(cprm->mm_flags);
>         /* Note that we actually did coredump. */
>         coredump_mask |= PIDFD_COREDUMPED;
>         /* If coredumping is set to skip we should never end up here. */
>         VFS_WARN_ON_ONCE(coredump_mask & PIDFD_COREDUMP_SKIP);
> -       smp_store_release(&exit_info->coredump_mask, coredump_mask);
> +       smp_store_release(&attr->coredump_mask, coredump_mask);
>  }
>  #endif
>
>
> --
> 2.47.3
>

