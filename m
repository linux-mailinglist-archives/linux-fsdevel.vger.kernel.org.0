Return-Path: <linux-fsdevel+bounces-45814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92803A7CC8C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Apr 2025 04:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6E3F167891
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Apr 2025 02:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDD284E1C;
	Sun,  6 Apr 2025 02:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YA0z2bez"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EDD2E62BD;
	Sun,  6 Apr 2025 02:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743906555; cv=none; b=V49p0N1au/ltG5jZviEXDbUOWhXBmqiQ94lqxypuik4zWL3PQKFRcW5wZfqXczY9bJxYs0oddVUGcO2Wtb3SjYRn2L6RA+e7/fkzTAUcpslKJ9hZsnYNAUHztHjEM1tModyOKjo6sPW0pMlmznaJTj2lWzs4+2xeotSn7vKlDHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743906555; c=relaxed/simple;
	bh=+cc9Wf+8QVea7RzuFaCWm/KHgmB6BfU8yHWa+l0lN+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ixm1USB5ZKm4FteJW0YRYXWYWNLQmCDVd7RrMMISDHXzbfpXTDyOHNsdQOkNOLhr66jNL89zZV2/pw5+WotLXAwT4ntT8Iciu5kbENJn1tcf150zMwkL2P0CqxMjlm13wHzr+sluvlp5QdlydC5eCzPiTXpnQxENKr37xA8zeJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YA0z2bez; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6ecfc2cb1aaso34978646d6.3;
        Sat, 05 Apr 2025 19:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743906553; x=1744511353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIiylM2j9zQF/1YnJzm9yePwxAWbQcx1fkMSx40gJuk=;
        b=YA0z2bezrjhK6QjxrsOBP/KQIa3E4FYSmcvveJ+Y400GzMFKRwn1IYImz2alYwwh5/
         +y7ViSuEPusq8EaFupxvgDZhZxkMgEvkuZ3+W4uAyA1b/Ac0q7Cm/GCoECPN1hP7jVgu
         3BGa4Bj70ni/bfl1xejkArotiiWcbCkNjWxeF7eXc3/lXCAe+sUA1GHES96Gwka/tXCp
         F/lWzVMmjLlOi3m3P1i8YJyDRJzi+CMV8n3ms86af6lXHNT1Fy37Hc5efpRSOeaqKWMj
         UdTufXGpOPptd2+fbotysQrhn2YX+l1UU+gW54T1ZunDLANLPumCFqWPUDYhpWbxA+NI
         SWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743906553; x=1744511353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CIiylM2j9zQF/1YnJzm9yePwxAWbQcx1fkMSx40gJuk=;
        b=Sw6/9D42qjamRjddNvVHYa0N0hi0nJgGaLHAp73FzN7+dh2eALtBAR/+5CBZfL0tnP
         4eyBnsfKAMp8b0KhgrfUfHOzTnJnmWbhf3t2GoeUhVjcA/x1DVby7vx28ZdvCkYDU2Ek
         Vx65rvNTU7HE8wvOnfipazag735G8+IPqG0rn6Do265TUc+hURpGvDlzAoGVZ7CLY6xP
         VrWoeZh5EVy8/O81ITEZhvgHMqw+bOf2dLZsYNv9BQs1d7KetNn70nQi/NEk+9Oetz/i
         W9IUYQDj4gnvqDAdm/gu2ePiPfpYGOVRULhmlWVEziQRC7KWLhxpsa8velmfXzSGqfCn
         h1jQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/mlo4q4SkBi04s7E/SxGBgkXXtKSN46Wu0bT+2qTfGPrSyjlVAWX1RnQdQjGdb75LrUys6LjEKlopSnu/@vger.kernel.org, AJvYcCW/4MT/OhkHuNh9Sn20IK/3P8OulUwXGHfBBnxUJ1djSDABcS9x6TEj1iARIXlGg9Iw050=@vger.kernel.org, AJvYcCWz1xfN389EMLNvEfkgCgE1Iuf14um68aZQi4umlMrOFN0FhLysNLnHs0PWdAhY4MADO5E6gE/E6QxH3EvH2hc5pQ==@vger.kernel.org, AJvYcCXC6AHUuOK0h1FwY/GSnsUM8dXiegEIzxxtxv/wjQ3rVLbJpVng0NxjrehxelNxxU7xAjwgakRpHHKB/Q9I1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyxLwO2rQO9wS8H/k9HMHPZJat+ezVF7kO1lLSj+R95YKu1HUk
	wY43Swz3+4ZRwGzhS8F4e6KubtRdfOUhVyTqDyE+qs8hleGlkn1FocrA4gov9S0ySMhlhsKlcch
	aF/rzX3o56403P+8kMTcG7Bl5YyE=
X-Gm-Gg: ASbGncttAzEiNMM9ODVZJ2u9WvbNUFnSq7mFlrLyvYgxJ3loCZP+H+snVNBbH0ilUO6
	EXJG235xnP/xvTlj1/GOw9DXVB6AXx2GYX5zn6drvHpdCZlLPCWYqgTKjymtoB6hiY67WhNCKBq
	VvvCsoUyQjsntrzr4JMwZsAlY4mWQ=
X-Google-Smtp-Source: AGHT+IGS6yvI0ZrRHzw3B/bNPjznQvxjxVF/nePT6AW/hLY+icoun8BTFzmTjAUxyoEUlJrRWte4+c8X7BaV5K1U6WI=
X-Received: by 2002:ad4:5948:0:b0:6ea:d393:962c with SMTP id
 6a1803df08f44-6f058535e23mr100523026d6.30.1743906552498; Sat, 05 Apr 2025
 19:29:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331121820.455916-1-bhupesh@igalia.com> <20250331121820.455916-2-bhupesh@igalia.com>
 <CALOAHbB51b-reG6+ypr43sBJ-QpQhF39r5WPjuEp5rgabgRmoA@mail.gmail.com> <6beead5a-8c21-af57-0304-1bf825588481@igalia.com>
In-Reply-To: <6beead5a-8c21-af57-0304-1bf825588481@igalia.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 6 Apr 2025 10:28:36 +0800
X-Gm-Features: ATxdqUEO5JDPKu66gRn-W6p4DyZydEyISAr6eMeFr_OFfhxP-niPWJgczuY4Eew
Message-ID: <CALOAHbDE3ToDc0knbUtGu0on9n9uUiWfKZEb-bgm1mW57VTZvg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] exec: Dynamically allocate memory to store task's
 full name
To: Bhupesh Sharma <bhsharma@igalia.com>
Cc: Bhupesh <bhupesh@igalia.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	akpm@linux-foundation.org, kernel-dev@igalia.com, 
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

On Fri, Apr 4, 2025 at 2:35=E2=80=AFPM Bhupesh Sharma <bhsharma@igalia.com>=
 wrote:
>
>
> On 4/1/25 7:37 AM, Yafang Shao wrote:
> > On Mon, Mar 31, 2025 at 8:18=E2=80=AFPM Bhupesh <bhupesh@igalia.com> wr=
ote:
> >> Provide a parallel implementation for get_task_comm() called
> >> get_task_full_name() which allows the dynamically allocated
> >> and filled-in task's full name to be passed to interested
> >> users such as 'gdb'.
> >>
> >> Currently while running 'gdb', the 'task->comm' value of a long
> >> task name is truncated due to the limitation of TASK_COMM_LEN.
> >>
> >> For example using gdb to debug a simple app currently which generate
> >> threads with long task names:
> >>    # gdb ./threadnames -ex "run info thread" -ex "detach" -ex "quit" >=
 log
> >>    # cat log
> >>
> >>    NameThatIsTooLo
> >>
> >> This patch does not touch 'TASK_COMM_LEN' at all, i.e.
> >> 'TASK_COMM_LEN' and the 16-byte design remains untouched. Which means
> >> that all the legacy / existing ABI, continue to work as before using
> >> '/proc/$pid/task/$tid/comm'.
> >>
> >> This patch only adds a parallel, dynamically-allocated
> >> 'task->full_name' which can be used by interested users
> >> via '/proc/$pid/task/$tid/full_name'.
> >>
> >> After this change, gdb is able to show full name of the task:
> >>    # gdb ./threadnames -ex "run info thread" -ex "detach" -ex "quit" >=
 log
> >>    # cat log
> >>
> >>    NameThatIsTooLongForComm[4662]
> >>
> >> Signed-off-by: Bhupesh <bhupesh@igalia.com>
> >> ---
> >>   fs/exec.c             | 21 ++++++++++++++++++---
> >>   include/linux/sched.h |  9 +++++++++
> >>   2 files changed, 27 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/fs/exec.c b/fs/exec.c
> >> index f45859ad13ac..4219d77a519c 100644
> >> --- a/fs/exec.c
> >> +++ b/fs/exec.c
> >> @@ -1208,6 +1208,9 @@ int begin_new_exec(struct linux_binprm * bprm)
> >>   {
> >>          struct task_struct *me =3D current;
> >>          int retval;
> >> +       va_list args;
> >> +       char *name;
> >> +       const char *fmt;
> >>
> >>          /* Once we are committed compute the creds */
> >>          retval =3D bprm_creds_from_file(bprm);
> >> @@ -1348,11 +1351,22 @@ int begin_new_exec(struct linux_binprm * bprm)
> >>                   * detecting a concurrent rename and just want a term=
inated name.
> >>                   */
> >>                  rcu_read_lock();
> >> -               __set_task_comm(me, smp_load_acquire(&bprm->file->f_pa=
th.dentry->d_name.name),
> >> -                               true);
> >> +               fmt =3D smp_load_acquire(&bprm->file->f_path.dentry->d=
_name.name);
> >> +               name =3D kvasprintf(GFP_KERNEL, fmt, args);
> >> +               if (!name)
> >> +                       return -ENOMEM;
> >> +
> >> +               me->full_name =3D name;
> >> +               __set_task_comm(me, fmt, true);
> >>                  rcu_read_unlock();
> >>          } else {
> >> -               __set_task_comm(me, kbasename(bprm->filename), true);
> >> +               fmt =3D kbasename(bprm->filename);
> >> +               name =3D kvasprintf(GFP_KERNEL, fmt, args);
> >> +               if (!name)
> >> +                       return -ENOMEM;
> >> +
> >> +               me->full_name =3D name;
> >> +               __set_task_comm(me, fmt, true);
> >>          }
> >>
> >>          /* An exec changes our domain. We are no longer part of the t=
hread
> >> @@ -1399,6 +1413,7 @@ int begin_new_exec(struct linux_binprm * bprm)
> >>          return 0;
> >>
> >>   out_unlock:
> >> +       kfree(me->full_name);
> >>          up_write(&me->signal->exec_update_lock);
> >>          if (!bprm->cred)
> >>                  mutex_unlock(&me->signal->cred_guard_mutex);
> >> diff --git a/include/linux/sched.h b/include/linux/sched.h
> >> index 56ddeb37b5cd..053b52606652 100644
> >> --- a/include/linux/sched.h
> >> +++ b/include/linux/sched.h
> >> @@ -1166,6 +1166,9 @@ struct task_struct {
> >>           */
> >>          char                            comm[TASK_COMM_LEN];
> >>
> >> +       /* To store the full name if task comm is truncated. */
> >> +       char                            *full_name;
> >> +
> > Adding another field to store the task name isn=E2=80=99t ideal. What a=
bout
> > combining them into a single field, as Linus suggested [0]?
> >
> > [0]. https://lore.kernel.org/all/CAHk-=3DwjAmmHUg6vho1KjzQi2=3DpsR30+Co=
gFd4aXrThr2gsiS4g@mail.gmail.com/
> >
>
> Thanks for sharing Linus's suggestion. I went through the suggested
> changes in the related threads and came up with the following set of poin=
ts:
>
> 1. struct task_struct would contain both 'comm' and 'full_name',

Correct.

> 2. Remove the task_lock() inside __get_task_comm(),

This has been implemented in the patch series titled "Improve the copy
of task comm". For details, please refer to:
https://lore.kernel.org/linux-mm/20240828030321.20688-1-laoar.shao@gmail.co=
m/.

> 3. Users of task->comm will be affected in the following ways:

Correct.

>      (a). Printing with '%s' and tsk->comm would just continue to
> work,but will get a longer max string.
>      (b). For users of memcpy.*->comm\>', we should change 'memcpy()' to
> 'copy_comm()' which would look like:
>
>          memcpy(dst, src, TASK_COMM_LEN);
>          dst[TASK_COMM_LEN-1] =3D 0;
>
>     (c). Users which use "sizeof(->comm)" will continue to get the old va=
lue because of the hacky union.

Using a separate pointer rather than a union could simplify the
implementation. I=E2=80=99m open to introducing a new pointer if you believ=
e
it=E2=80=99s the better approach.

>
> Am I missing something here. Please let me know your views.


--=20
Regards
Yafang

