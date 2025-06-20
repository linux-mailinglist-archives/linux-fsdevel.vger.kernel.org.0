Return-Path: <linux-fsdevel+bounces-52338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2415FAE205E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 18:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9894C5A1D94
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 16:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FA82E8880;
	Fri, 20 Jun 2025 16:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="ejxsIqhL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1859B2E3365
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750438216; cv=none; b=Xh0LXvKzlLBe/g6ey3tkBa6hB6ik2RypZL0SVcsl2lgczvaz30mi8Kpp9lENN8NAU/pFt0nRCrgTHcPxA6vFTRn1gcu38UVxY43a00eDGzKAOETQcbGe8a/8lOrdHDKQ2CKjpP0FSJ/gmSGteATB0Ay0nt6qEwnwip7uZFBXH9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750438216; c=relaxed/simple;
	bh=dY+pm5eSSZsBPLfOchs10YQh8P4xM1jomqKvnhLb9/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMORNmPBEi7/uSVQRwzXqinCYNMcwX5TFUu5hNDRCZBV0t50bTGPRUs8ZeZkfbW6apZH9K7AWNU9BtkpXTmmZf169QFu3GNvqwPGz8VjtMpchw6fbif9rHPZDuAI2O9mQakgLJNyyJuMBJ/gHZD5Ky64osURIzxAN+cxFa+XSFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=ejxsIqhL; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-553b6a349ccso2059283e87.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 09:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1750438212; x=1751043012; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HmlY05Xhq4DWn0Q/RTnndfyWxHMFyGtp//asKCUv8FI=;
        b=ejxsIqhLkFFjila0NFNQThJKkbmmst9UcrZHu+YqY79bBrFPrwPhd3OPW04zupj1vD
         DDu9lbiugnNeGnYuDZi5DqNXyMckCQjj0z1vdnIKwqjf0eb/FZ/acx3XYK6EJrfyNBRY
         QZv1KuVWQdDojtsIffA7y3ZjvfDVFBut6lMnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750438212; x=1751043012;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HmlY05Xhq4DWn0Q/RTnndfyWxHMFyGtp//asKCUv8FI=;
        b=mLMVV8Z7KKcCermFd++GCmMhcfBbazVI9mOhMIXaH5cThqHmk5vj9h40eZEiuts6fp
         9nFs9hWxhcDbY1B3TOt+CBO4NE8ew/F2zHSi5msFy9Q2V9RToaMyqujELt9RUbWFWT/b
         WBrCW28f57dDrqeBxUSP694tC+Wt3sIrDiJGCN45duFHR/uXGuK4M8qds/x/YuRYQl/g
         iscYLiLU9UF74p9JGevt6tBdCzZZQ2A+b1+xgjbUab5mYkpxyYorFbKjXa5RwWtMIlwo
         N7v7c8WSwntdPRy43ocXcDlZMBkn/oNQK6Kh+Y+n+UfzRnFY+7TEdVWgN5Sz/4n4DLYw
         6RbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEgn70jftINkwSaZygm26RJIXAbotSChe9HbDvmwjlZHlU6DKxJl/+4/Bg10e+6QaOqRPQihep2sMkQsKv@vger.kernel.org
X-Gm-Message-State: AOJu0YzPO/toBEiPiPBrOs9ElMQnH/3ZUv2iMOFsu7/fRQhUIRK7a/PU
	TvNcLHdYi4dhttAdnRK3amID+yu8BimGF3z0sKHw+cKZAok0nYayyPnagQ7FSx2IfQmRw14kLtI
	3LL61f7yDBriXiGvbJuMGSNo2BttpDFMx1gvO8bNKTA==
X-Gm-Gg: ASbGncvDEgeh3sUk+BxTFPoXwkuwWHexEvUQ4/U9Yanj8SKv8etwfG8KXhaNwNoIci4
	dhs26ag/1pRrtEHlqqTCGcE6r0vrOPx6Ex7RZUY8N1FItA35q1zy3hOZsZEWhSt0DyhS5jLVOW7
	LaEWvOnwcyLcetVm6OwEHwtuMgcWg9G/eMk/OVhZBwWOpC
X-Google-Smtp-Source: AGHT+IHK1Ts9tNZh/IwXSfefAwMh137c1G/ca2mq258vFr2H+GU2S8HSayozQQWcG5dJzahVTDnfAbIypkbA62xUy1k=
X-Received: by 2002:a05:6512:2345:b0:553:2f19:fd1e with SMTP id
 2adb3069b0e04-553e3be8549mr1147392e87.28.1750438211628; Fri, 20 Jun 2025
 09:50:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620112105.3396149-1-arnd@kernel.org>
In-Reply-To: <20250620112105.3396149-1-arnd@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Fri, 20 Jun 2025 18:49:59 +0200
X-Gm-Features: Ac12FXwsQw1wrf4tvPmP69JHE9mjWKDj4FcCzqgDj3K1MOGULQa_-3nVtY4ihvA
Message-ID: <CAJqdLrq4bwF=sjZ2umwQBCMWSXEDi8N+DiSVW5poT9KfWykqmA@mail.gmail.com>
Subject: Re: [PATCH] coredump: reduce stack usage in vfs_coredump()
To: Arnd Bergmann <arnd@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
	Luca Boccassi <luca.boccassi@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
	Roman Kisel <romank@linux.microsoft.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Am Fr., 20. Juni 2025 um 13:21 Uhr schrieb Arnd Bergmann <arnd@kernel.org>:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The newly added socket coredump code runs into some corner cases
> with KASAN that end up needing a lot of stack space:
>
> fs/coredump.c:1206:1: error: the frame size of 1680 bytes is larger than 1280 bytes [-Werror=frame-larger-than=]
>
> Mark the socket helper function as noinline_for_stack so its stack
> usage does not leak out to the other code paths. This also seems to
> help with register pressure, and the resulting combined stack usage of
> vfs_coredump() and coredump_socket() is actually lower than the inlined
> version.
>
> Moving the core_state variable into coredump_wait() helps reduce the
> stack usage further and simplifies the code, though it is not sufficient
> to avoid the warning by itself.
>
> Fixes: 6a7a50e5f1ac ("coredump: use a single helper for the socket")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/coredump.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index e2611fb1f254..c46e3996ff91 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -518,27 +518,28 @@ static int zap_threads(struct task_struct *tsk,
>         return nr;
>  }
>
> -static int coredump_wait(int exit_code, struct core_state *core_state)
> +static int coredump_wait(int exit_code)
>  {
>         struct task_struct *tsk = current;
> +       struct core_state core_state;
>         int core_waiters = -EBUSY;
>
> -       init_completion(&core_state->startup);
> -       core_state->dumper.task = tsk;
> -       core_state->dumper.next = NULL;
> +       init_completion(&core_state.startup);
> +       core_state.dumper.task = tsk;
> +       core_state.dumper.next = NULL;
>
> -       core_waiters = zap_threads(tsk, core_state, exit_code);
> +       core_waiters = zap_threads(tsk, &core_state, exit_code);
>         if (core_waiters > 0) {
>                 struct core_thread *ptr;
>
> -               wait_for_completion_state(&core_state->startup,
> +               wait_for_completion_state(&core_state.startup,
>                                           TASK_UNINTERRUPTIBLE|TASK_FREEZABLE);
>                 /*
>                  * Wait for all the threads to become inactive, so that
>                  * all the thread context (extended register state, like
>                  * fpu etc) gets copied to the memory.
>                  */
> -               ptr = core_state->dumper.next;
> +               ptr = core_state.dumper.next;
>                 while (ptr != NULL) {
>                         wait_task_inactive(ptr->task, TASK_ANY);
>                         ptr = ptr->next;
> @@ -858,7 +859,7 @@ static bool coredump_sock_request(struct core_name *cn, struct coredump_params *
>         return coredump_sock_mark(cprm->file, COREDUMP_MARK_REQACK);
>  }
>
> -static bool coredump_socket(struct core_name *cn, struct coredump_params *cprm)
> +static noinline_for_stack bool coredump_socket(struct core_name *cn, struct coredump_params *cprm)
>  {
>         if (!coredump_sock_connect(cn, cprm))
>                 return false;
> @@ -1095,7 +1096,6 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
>  {
>         struct cred *cred __free(put_cred) = NULL;
>         size_t *argv __free(kfree) = NULL;
> -       struct core_state core_state;
>         struct core_name cn;
>         struct mm_struct *mm = current->mm;
>         struct linux_binfmt *binfmt = mm->binfmt;
> @@ -1131,7 +1131,7 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
>         if (coredump_force_suid_safe(&cprm))
>                 cred->fsuid = GLOBAL_ROOT_UID;
>
> -       if (coredump_wait(siginfo->si_signo, &core_state) < 0)
> +       if (coredump_wait(siginfo->si_signo) < 0)
>                 return;
>
>         old_cred = override_creds(cred);
> --
> 2.39.5
>

