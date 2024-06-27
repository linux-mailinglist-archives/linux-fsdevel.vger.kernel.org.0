Return-Path: <linux-fsdevel+bounces-22671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E12C291AFBA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 21:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F8E61C22399
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 19:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA6D4500D;
	Thu, 27 Jun 2024 19:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="d1+0Qs1u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7399B4D8AC
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 19:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719516690; cv=none; b=tm6ylpaYoq1wTAXeqia6BiYXbHj2cH7sCauX3QQvScpATxGW9w47iz9LRZ8UpW+spwQTaXOosn9c3oewuZAyS+z2uTaXGTmyK/YEDoyxP7ISSn2G6nx2QFvhAbgftFcfimmm+6Rsp4siFC/7BSmSiOd/z8Fjp6M5LA50jMsdKyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719516690; c=relaxed/simple;
	bh=1WDS2AQgpymRP2QXgn1kI0il61QYOAw1AXEQeE298Ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9DMeuESWYXLgjS4cU1px3dZQ3c/EOZkW+cwlsDX7/yrlAR9y8LDT2B9aCePhQXLiMZcH+YZqjY22zw7ZZRT50IEcJrn8xst3N+yRqkudCk9z7nlrIZXb+//YtuvC5+zxIjU8WZz9ENWLrXs5nXzgBYUzSsLsdeDWUDTE7Snw3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=d1+0Qs1u; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ec5f1b4ee7so5783951fa.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 12:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1719516685; x=1720121485; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0uZEamPUO6yUzxqg3ZAiorpvMsEHy+mCNtlItIcU6TI=;
        b=d1+0Qs1uUdSBkYYEw4rYga5gUZA3ohrC8iwLkoZiOEwhAIoKEGnc4+hj1blwK2Yw8s
         Woqfevd74CcYeqIWOTFRxNiT5Tj98Zmu3c/4wDTRRIsV4NTZwGD+BT4eOwzcDqnHefsJ
         Jd5kqZ2V0ay8+OLyW6mZ7a2Uzw19ShxVQ06tI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719516685; x=1720121485;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0uZEamPUO6yUzxqg3ZAiorpvMsEHy+mCNtlItIcU6TI=;
        b=S18KQ2Y4kIoUbm/ycO4/DLFQKwcJFhHb86EuoEhd/gj7fS8GNrwDjs2FI2uJbNHkmt
         OYUV7C6i1+y395da8ipmwN6nzUIO8wEWqjn9brNJf8ZLqwDbozI/ozz7tpk9gpUgICf7
         Vi6EJ7DBSg2tRDCpM8y9ydDO28vSi2NYye4jSnZAQv3LAXihwS3XxgL5VA1YRXluUPKr
         Pn2Sk8S4ldiQYGhjrztIok6eYnSN9aG3HjDKOGHo+UgtrwM7uIxInEdeBGp0ReFpbq9F
         PM3TjHaD6c3Cpb0YCJGXtvWqMI9yjcoJa2+wnMN6KjnOErFZUhItqphm6zdxBXn6+jhf
         xLXw==
X-Gm-Message-State: AOJu0YxIkyX97v/YzanXcvo+ftQsTCLKX8f4M48SF9Gpir8shbLP6WV6
	OyNyYrm6mHJ1OQBhk6dvVa9KmTkZ1aZdpNxJiU1Dh4XXz+guZddjOHUc1RCXab6d+dIPsniGIYA
	FBSkuq0PFCi1riVE9n8hdTyWhZoL9YnLc3IrxVA==
X-Google-Smtp-Source: AGHT+IGYbeIpF88uwHjYHb/uvL6enbFx4XM+L7o1MmMiQyL/VEz0XdZfbRyhX0Cbr+/k052guCZCS0lJRMJyVPoaiAM=
X-Received: by 2002:a2e:80da:0:b0:2ec:42a2:7e25 with SMTP id
 38308e7fff4ca-2ec5619c255mr94496161fa.3.1719516684890; Thu, 27 Jun 2024
 12:31:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619-work-ns_ioctl-v1-1-7c0097e6bb6b@kernel.org>
In-Reply-To: <20240619-work-ns_ioctl-v1-1-7c0097e6bb6b@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Thu, 27 Jun 2024 21:31:13 +0200
Message-ID: <CAJqdLrp1nzoJTsDm0NLUnP6NWuh=s2qLjhuj1EW1k1g4G+5HKA@mail.gmail.com>
Subject: Re: [PATCH] nsfs: add pid translation ioctls
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Stephane Graber <stgraber@stgraber.org>, 
	Tycho Andersen <tandersen@netflix.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"

Am Mi., 19. Juni 2024 um 15:50 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Add ioctl()s to translate pids between pid namespaces.
>
> LXCFS is a tiny fuse filesystem used to virtualize various aspects of
> procfs. LXCFS is run on the host. The files and directories it creates
> can be bind-mounted by e.g. a container at startup and mounted over the
> various procfs files the container wishes to have virtualized. When e.g.
> a read request for uptime is received, LXCFS will receive the pid of the
> reader. In order to virtualize the corresponding read, LXCFS needs to
> know the pid of the init process of the reader's pid namespace. In order
> to do this, LXCFS first needs to fork() two helper processes. The first
> helper process setns() to the readers pid namespace. The second helper
> process is needed to create a process that is a proper member of the pid
> namespace. The second helper process then creates a ucred message with
> ucred.pid set to 1 and sends it back to LXCFS. The kernel will translate
> the ucred.pid field to the corresponding pid number in LXCFS's pid
> namespace. This way LXCFS can learn the init pid number of the reader's
> pid namespace and can go on to virtualize. Since these two forks() are
> costly LXCFS maintains an init pid cache that caches a given pid for a
> fixed amount of time. The cache is pruned during new read requests.
> However, even with the cache the hit of the two forks() is singificant
> when a very large number of containers are running. With this simple
> patch we add an ns ioctl that let's a caller retrieve the init pid nr of
> a pid namespace through its pid namespace fd. This significantly
> improves performance with a very simple change.
>
> Support translation of pids and tgids. Other concepts can be added but
> there are no obvious users for this right now.
>
> To protect against races pidfds can be used to check whether the process
> is still valid. If needed, this can also be extended to work on pidfds
> directly.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Dear Christian,

This is an amazing idea! Thanks for implementing and posting this!

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
> ---
>  fs/nsfs.c                 | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/nsfs.h |  8 ++++++++
>  2 files changed, 55 insertions(+)
>
> diff --git a/fs/nsfs.c b/fs/nsfs.c
> index 07e22a15ef02..4a4d7b1eb38c 100644
> --- a/fs/nsfs.c
> +++ b/fs/nsfs.c
> @@ -8,9 +8,11 @@
>  #include <linux/magic.h>
>  #include <linux/ktime.h>
>  #include <linux/seq_file.h>
> +#include <linux/pid_namespace.h>
>  #include <linux/user_namespace.h>
>  #include <linux/nsfs.h>
>  #include <linux/uaccess.h>
> +#include <linux/cleanup.h>
>
>  #include "internal.h"
>
> @@ -123,9 +125,12 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
>                         unsigned long arg)
>  {
>         struct user_namespace *user_ns;
> +       struct pid_namespace *pid_ns;
> +       struct task_struct *tsk;
>         struct ns_common *ns = get_proc_ns(file_inode(filp));
>         uid_t __user *argp;
>         uid_t uid;
> +       pid_t pid_nr;
>
>         switch (ioctl) {
>         case NS_GET_USERNS:
> @@ -143,6 +148,48 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
>                 argp = (uid_t __user *) arg;
>                 uid = from_kuid_munged(current_user_ns(), user_ns->owner);
>                 return put_user(uid, argp);
> +       case NS_GET_PID_FROM_PIDNS:
> +               fallthrough;
> +       case NS_GET_TGID_FROM_PIDNS:
> +               fallthrough;
> +       case NS_GET_PID_IN_PIDNS:
> +               fallthrough;
> +       case NS_GET_TGID_IN_PIDNS:
> +               if (ns->ops->type != CLONE_NEWPID)
> +                       return -EINVAL;
> +
> +               pid_ns = container_of(ns, struct pid_namespace, ns);
> +
> +               guard(rcu)();
> +               if (ioctl == NS_GET_PID_IN_PIDNS ||
> +                   ioctl == NS_GET_TGID_IN_PIDNS)
> +                       tsk = find_task_by_vpid(arg);
> +               else
> +                       tsk = find_task_by_pid_ns(arg, pid_ns);
> +               if (!tsk)
> +                       return -ESRCH;
> +
> +               switch (ioctl) {
> +               case NS_GET_PID_FROM_PIDNS:
> +                       pid_nr = task_pid_vnr(tsk);
> +                       break;
> +               case NS_GET_TGID_FROM_PIDNS:
> +                       pid_nr = task_tgid_vnr(tsk);
> +                       break;
> +               case NS_GET_PID_IN_PIDNS:
> +                       pid_nr = task_pid_nr_ns(tsk, pid_ns);
> +                       break;
> +               case NS_GET_TGID_IN_PIDNS:
> +                       pid_nr = task_tgid_nr_ns(tsk, pid_ns);
> +                       break;
> +               default:
> +                       pid_nr = 0;
> +                       break;
> +               }
> +               if (!pid_nr)
> +                       return -ESRCH;
> +
> +               return pid_nr;
>         default:
>                 return -ENOTTY;
>         }
> diff --git a/include/uapi/linux/nsfs.h b/include/uapi/linux/nsfs.h
> index a0c8552b64ee..faeb9195da08 100644
> --- a/include/uapi/linux/nsfs.h
> +++ b/include/uapi/linux/nsfs.h
> @@ -15,5 +15,13 @@
>  #define NS_GET_NSTYPE          _IO(NSIO, 0x3)
>  /* Get owner UID (in the caller's user namespace) for a user namespace */
>  #define NS_GET_OWNER_UID       _IO(NSIO, 0x4)
> +/* Translate pid from target pid namespace into the caller's pid namespace. */
> +#define NS_GET_PID_FROM_PIDNS  _IOR(NSIO, 0x5, int)
> +/* Return thread-group leader id of pid in the callers pid namespace. */
> +#define NS_GET_TGID_FROM_PIDNS _IOR(NSIO, 0x7, int)
> +/* Translate pid from caller's pid namespace into a target pid namespace. */
> +#define NS_GET_PID_IN_PIDNS    _IOR(NSIO, 0x6, int)
> +/* Return thread-group leader id of pid in the target pid namespace. */
> +#define NS_GET_TGID_IN_PIDNS   _IOR(NSIO, 0x8, int)
>
>  #endif /* __LINUX_NSFS_H */
>
> ---
> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
> change-id: 20240619-work-ns_ioctl-447979cf0820
>

