Return-Path: <linux-fsdevel+bounces-45408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B50A77292
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 04:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CD2716B9CB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 02:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5181A18FC9D;
	Tue,  1 Apr 2025 02:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMF71JTL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D357EACE;
	Tue,  1 Apr 2025 02:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743473293; cv=none; b=M5CVG5yz/fG6KZ3hH4Ckchqc7OEeVedjOPoE1T7IpenGyGSA9G8IQF9Cs6Q7ETjOAOYVv2nrjESqTF2hM+py+Sw3eD2TVKf+Tx/99YFglobzwTsjoIc84e55eQEsMUOlbfMLBRz7PggIv7xskhAWLxmUii4p3DI3VojPXyKQnUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743473293; c=relaxed/simple;
	bh=lCssQdZbCquHUtvBNwAYmoP4TXmIpPQYUK8Wv0tAJiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZ1I0y7mxJi19hi+66c8He1cyDIudNaWkxKL1EGopjc2NjhiXg6DrV5kyvk9XKZelktqz0GimtCEh+kbqWqdhtnGWzoHRzi0LW/kiOGF06nVxiN6B1DB6jR4Zgy/XxoA5m/WzhcT0Jip5RyY559JPLXJwasF4U+Pl7BbJko3nws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMF71JTL; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6df83fd01cbso24762056d6.2;
        Mon, 31 Mar 2025 19:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743473291; x=1744078091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ms0+har1C2wQOkI4KlWfLkswK693L/k5CGR6bBU56S4=;
        b=jMF71JTLjftCdg1qAKo173fCZUSB1GCB9KmL8YbtkYL4oQdy7sFZbCe37qWoelNw44
         AYWMsnpW4BdjcXiC70OvE/xS4ttYdaxWDt4OdRtLRNFUUDsJVCBCo0hG52N5V4413DYu
         Yh1ZjIh9uTHI9m6LGOi2fiRiWR3cfXfHHSKOwVGhJmyS+OY1X2vM8HI7O5Zp+SdxEGAu
         s4cMwX95a/FLN5FlorquBubevT4Jl8RJMMv3xcIC/75lWY+xS/l7vlLr5IQO3bIxGok3
         8Hsiuwawu9TLNUQ071UJ0KMYlrrPjHCpJYbvWWIzF6nQssaVVUVx1dIEKibG1J8ySxbq
         BtiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743473291; x=1744078091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ms0+har1C2wQOkI4KlWfLkswK693L/k5CGR6bBU56S4=;
        b=AqMAYvHJiggNzO/VFWd+H6pzRK5Z/tfWljFoIvRLyUxGm1UTDHGCYb/4b82q7H6vu9
         AJotx5/A9yVu0bDRASsRVfSZvQnBNLJoKVC5e7eecbOpuyB6l76zGhagSZZZHC1Vk2+G
         hWN5cAzzD2UiFa2NhABWxZUKb/+V2kf/FQgyv2EJXqGQQoL1pFkYMa5DJX16NZpt3v3z
         yPOi8EkqDL2T1r69QeFDDbP/LV+CtEKbGofpq7e4YpOHC4vHryqGtzDr/bjBWGkvDS4G
         iTeAQwd2zEJslAL125VEmuLSXenHuHQs/pMD5Yq58sdD80oJwwAvCnT7phFIj81aAgK4
         nbbw==
X-Forwarded-Encrypted: i=1; AJvYcCUdpLuS0k2Q73boVKJO4DwIQqCHi06Wcse3oVQMt89pFYPCytwjhjM9DEauvTTYFnAIQMk=@vger.kernel.org, AJvYcCWSVlnEt2S8nhF5q7PKPRaZ4Ucq7POdaeizLi2SUJtaKBlFwuRXoJIs7u5rLHIgoGALV4AypWTr9wYCPiIwYQ==@vger.kernel.org, AJvYcCWiEsEBy0fZd1waMQOPsd/1KmNALiOA7me8D9bcqJd3HFwBYJUBjB9OGjO+g+mbaKzCCYZRoN4PiEmvDJF5KIhsbw==@vger.kernel.org, AJvYcCXXgCQLxt2IJwUzVBp1EqgFGZgDrkVllHx3qj0+XJLc/DVCZ4Ya4ADTFl0aG7LfnA91/Jb0cryv2rgJbxT0@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/6yPRF9fJCJqMmmm86IlLXsc+CHFjXwrs4fGO6/UKaGikqKcK
	FXADhDiYY9MdMX6EyQWoK7u6h9lcrdvM9Yl97wDc/p0KjY4ySFD9EYv/uHL+hKbn8PO27LiR825
	9RdO6jRmOZzHkRuIkrfTzcRTOsHM=
X-Gm-Gg: ASbGncudYgBUrr88ebnw38owqbfYa4opTUO2KGLpt46UzQ/qlYkc25INaK4RSS+mJTK
	rxUAgSfVtiP2nATAjPGaDWYfX5aI95176unMagKSygHcwEFsdUCwjCW2cFBpz22Q4Z/9qdFcGrJ
	e6nkN4UftE7baAwmMOjvluAoLsIM0=
X-Google-Smtp-Source: AGHT+IEwVwo9jlkAbUXTU14Qfh3LA01iPKDDWMjUrm4tnGQHU4i3QsPK8QEDaJfFZ5Z8PEovYhXsWbFiclds5IHQi9M=
X-Received: by 2002:ad4:4ea8:0:b0:6e8:9a55:824f with SMTP id
 6a1803df08f44-6eed5f60fddmr145906786d6.6.1743473290823; Mon, 31 Mar 2025
 19:08:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331121820.455916-1-bhupesh@igalia.com> <20250331121820.455916-2-bhupesh@igalia.com>
In-Reply-To: <20250331121820.455916-2-bhupesh@igalia.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 1 Apr 2025 10:07:34 +0800
X-Gm-Features: AQ5f1Jogo27TUblm0QChMfxpov615glFLI-myzoObvnllqhLHnsXspUqCVEi74w
Message-ID: <CALOAHbB51b-reG6+ypr43sBJ-QpQhF39r5WPjuEp5rgabgRmoA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] exec: Dynamically allocate memory to store task's
 full name
To: Bhupesh <bhupesh@igalia.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: akpm@linux-foundation.org, kernel-dev@igalia.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com, pmladek@suse.com, 
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com, 
	alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com, 
	mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org, 
	david@redhat.com, viro@zeniv.linux.org.uk, keescook@chromium.org, 
	ebiederm@xmission.com, brauner@kernel.org, jack@suse.cz, mingo@redhat.com, 
	juri.lelli@redhat.com, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 8:18=E2=80=AFPM Bhupesh <bhupesh@igalia.com> wrote:
>
> Provide a parallel implementation for get_task_comm() called
> get_task_full_name() which allows the dynamically allocated
> and filled-in task's full name to be passed to interested
> users such as 'gdb'.
>
> Currently while running 'gdb', the 'task->comm' value of a long
> task name is truncated due to the limitation of TASK_COMM_LEN.
>
> For example using gdb to debug a simple app currently which generate
> threads with long task names:
>   # gdb ./threadnames -ex "run info thread" -ex "detach" -ex "quit" > log
>   # cat log
>
>   NameThatIsTooLo
>
> This patch does not touch 'TASK_COMM_LEN' at all, i.e.
> 'TASK_COMM_LEN' and the 16-byte design remains untouched. Which means
> that all the legacy / existing ABI, continue to work as before using
> '/proc/$pid/task/$tid/comm'.
>
> This patch only adds a parallel, dynamically-allocated
> 'task->full_name' which can be used by interested users
> via '/proc/$pid/task/$tid/full_name'.
>
> After this change, gdb is able to show full name of the task:
>   # gdb ./threadnames -ex "run info thread" -ex "detach" -ex "quit" > log
>   # cat log
>
>   NameThatIsTooLongForComm[4662]
>
> Signed-off-by: Bhupesh <bhupesh@igalia.com>
> ---
>  fs/exec.c             | 21 ++++++++++++++++++---
>  include/linux/sched.h |  9 +++++++++
>  2 files changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index f45859ad13ac..4219d77a519c 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1208,6 +1208,9 @@ int begin_new_exec(struct linux_binprm * bprm)
>  {
>         struct task_struct *me =3D current;
>         int retval;
> +       va_list args;
> +       char *name;
> +       const char *fmt;
>
>         /* Once we are committed compute the creds */
>         retval =3D bprm_creds_from_file(bprm);
> @@ -1348,11 +1351,22 @@ int begin_new_exec(struct linux_binprm * bprm)
>                  * detecting a concurrent rename and just want a terminat=
ed name.
>                  */
>                 rcu_read_lock();
> -               __set_task_comm(me, smp_load_acquire(&bprm->file->f_path.=
dentry->d_name.name),
> -                               true);
> +               fmt =3D smp_load_acquire(&bprm->file->f_path.dentry->d_na=
me.name);
> +               name =3D kvasprintf(GFP_KERNEL, fmt, args);
> +               if (!name)
> +                       return -ENOMEM;
> +
> +               me->full_name =3D name;
> +               __set_task_comm(me, fmt, true);
>                 rcu_read_unlock();
>         } else {
> -               __set_task_comm(me, kbasename(bprm->filename), true);
> +               fmt =3D kbasename(bprm->filename);
> +               name =3D kvasprintf(GFP_KERNEL, fmt, args);
> +               if (!name)
> +                       return -ENOMEM;
> +
> +               me->full_name =3D name;
> +               __set_task_comm(me, fmt, true);
>         }
>
>         /* An exec changes our domain. We are no longer part of the threa=
d
> @@ -1399,6 +1413,7 @@ int begin_new_exec(struct linux_binprm * bprm)
>         return 0;
>
>  out_unlock:
> +       kfree(me->full_name);
>         up_write(&me->signal->exec_update_lock);
>         if (!bprm->cred)
>                 mutex_unlock(&me->signal->cred_guard_mutex);
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 56ddeb37b5cd..053b52606652 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1166,6 +1166,9 @@ struct task_struct {
>          */
>         char                            comm[TASK_COMM_LEN];
>
> +       /* To store the full name if task comm is truncated. */
> +       char                            *full_name;
> +

Adding another field to store the task name isn=E2=80=99t ideal. What about
combining them into a single field, as Linus suggested [0]?

[0]. https://lore.kernel.org/all/CAHk-=3DwjAmmHUg6vho1KjzQi2=3DpsR30+CogFd4=
aXrThr2gsiS4g@mail.gmail.com/

--=20
Regards
Yafang

