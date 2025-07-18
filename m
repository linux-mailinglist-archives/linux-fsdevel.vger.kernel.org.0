Return-Path: <linux-fsdevel+bounces-55448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B12B0A8E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 18:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D0B3ACC9C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 16:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4162E62AF;
	Fri, 18 Jul 2025 16:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lGCt+VKt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7002E5B29
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 16:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752857377; cv=none; b=BMlZUSWhyYlKlpYuEy7neUUzzpPRXod4nk4TMDH6BwfuXijXAzz29WzPxcUY5KE27xtc3lrYZXmg4JFHQkremJE4p/bnm8pQiyKCtOuwgGtbbqYyUXJNJ6TTF6RcFgJGfLd4vCzs+etbH8ida2sub1shD9zDnIktnoTeQuyG1rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752857377; c=relaxed/simple;
	bh=YYkFrLXQNcF/LRzXFAq83sA1w2G3tvd/U+OLCef/WXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWU8Ooh2Rn1SuLsvH/0ulBXxM3VBglOtkyqf5eUgXLQDsxV8lWFamJj24kqVN0/iYQEA99nq75OOlJ/qTVQ64yn/ni+93+JSXxQeyHhj6qKQqXbLTMeD2filxGapbF6YCWhDYk/yS113Qqv8dqlXIefB9ymaEm0eUr2I+ITO+z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lGCt+VKt; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60b86fc4b47so178a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 09:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752857374; x=1753462174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdFQmiTCtyQu/zHhNrg0B+XyPur8yXji78Rwk2BnkTc=;
        b=lGCt+VKtC9uaLgOoITxVUkGzORTgYA/s0GCk2GJ73Ttegz2xKc/kIBLwN75X8YvJyr
         0983tRmGEuEgLdEuNoXFAASzEOTAJaXxKLFLb06/+dA2h4Wt7VLI/u+nNEKcjzumPFXn
         S9G65x8RBemmlEQQFUbjppPodzzWL/TpZVr6kUYOnw4BSqK1R4ydEiskAs1hU0ujtri8
         uf0EBbdCXvTniTFd89oODWxVMTd18q4Fbx1GnChzofWuxp0lUYKWQM2jMGTqbFpa7w40
         0GSyGwbFBV0lD2U1svhyCnZUnlshk2zqDOHYx4vtje9jbhghRfD6tDIJ1KMkAzgrSoV+
         IHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752857374; x=1753462174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdFQmiTCtyQu/zHhNrg0B+XyPur8yXji78Rwk2BnkTc=;
        b=Qxgq1C3d28quBwmxBMV6HmagcJfvXOxgQjLXHW1PMfqiNyD5386cqI9cHdoNEbCd9O
         toW13OkhaiRpfWnspYvIbRhJ+5IyUNRxx7qNgIfwtkMOr7EF6rRxBXrBZ+lBLgn2THPR
         PlyHgEXnhudoHOCtojl0uTrVVgMgQEGAGSOccC7m4z55oDHQy6cDpU8i/Cjus2yP0tM1
         +VeIPkA8e51cWqkexAo5WXLAQEUdRqNbKcPhNx20tGJ8ZbjXn3qIFov/Ju38E4fduwH1
         E2SlZ9mGtN13zQFZ5dmsImdB9UTmPEDR94H48dOQIwfXcRTcSjnFlXhmgXidg8SdEfc7
         2bJg==
X-Gm-Message-State: AOJu0Yy7qS6Rui9eE2kHVT7sciagTR8YnnOdwOxWJmeToODKPhOonk0K
	Osr4839NgItjDhgS+YtKcQ9CaOetebIbA2A7piih0NXiv5EMn+TefVXvn/JvaziJWy7u6Hmt1xc
	ILLu+xuiz4QyrGpfAUtH5+sRz7pazI/1E3a/6rUM5
X-Gm-Gg: ASbGnctTk32lGeqewisj559vp5iGo9/Zk0EIRf5A8xQZdylcveoleWwDkr0YcOZi8Ya
	LfJmfXsHmini0oopmuBv76WMuINX4eqnSxU94E5vZTpimNO2uZ1NryqCPugLB0BlR62ZqABdT94
	uUDxTPJe18J6BDYb4lkz1zhdbawzfQPbyAyvnmMla/h6SerbpNgweEorwcK/KrDg3Z3ufgwUbMQ
	vNN0sh3NTVLV874co4YkB3e7Iz4AcDvQL0=
X-Google-Smtp-Source: AGHT+IEKipZ75dFcHQSQPERCSjZrzcx9z2eXpEQd6YxCy6qM2F3cG0oanco6kN4MAL7MZ/V/SEtL/XNR5ChXhILWj8A=
X-Received: by 2002:a50:d6c6:0:b0:612:bec2:cf22 with SMTP id
 4fb4d7f45d1cf-612c2317b32mr104875a12.4.1752857372727; Fri, 18 Jul 2025
 09:49:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718-hidepid_fix-v1-1-3fd5566980bc@ssi.gouv.fr>
 <CAG48ez3u09TK=Ju3xdEKzKuM_-sO_y9150NBx3Drs8T1G-V9AQ@mail.gmail.com> <s7no7daeq6nmkwrf5w63srpmxzzqk5uor2kxdvrvrskoahh7un@h6kubn7qxli2>
In-Reply-To: <s7no7daeq6nmkwrf5w63srpmxzzqk5uor2kxdvrvrskoahh7un@h6kubn7qxli2>
From: Jann Horn <jannh@google.com>
Date: Fri, 18 Jul 2025 18:48:54 +0200
X-Gm-Features: Ac12FXwHhnJM27H3F2j0R9jH8PM46wRLA_SIP9MxHGaFT7dpoUWY-oXaYWfBUR4
Message-ID: <CAG48ez1ERkkwd+cJPmLmVj4JKpj5Uq=LaUEpb6_TgC4PRXosUw@mail.gmail.com>
Subject: Re: [PATCH] fs: hidepid: Fixes hidepid non dumpable behavior
To: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Olivier Bal-Petre <olivier.bal-petre@oss.cyber.gouv.fr>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 5:47=E2=80=AFPM Nicolas Bouchinet
<nicolas.bouchinet@oss.cyber.gouv.fr> wrote:
> Hi Jann, thanks for your review !
>
> On Fri, Jul 18, 2025 at 04:45:15PM +0200, Jann Horn wrote:
> > On Fri, Jul 18, 2025 at 10:47=E2=80=AFAM <nicolas.bouchinet@oss.cyber.g=
ouv.fr> wrote:
> > > The hidepid mount option documentation defines the following modes:
> > >
> > > - "noaccess": user may not access any `/proc/<pid>/ directories but
> > >   their own.
> > > - "invisible": all `/proc/<pid>/` will be fully invisible to other us=
ers.
> > > - "ptraceable": means that procfs should only contain `/proc/<pid>/`
> > >   directories that the caller can ptrace.
> > >
> > > We thus expect that with "noaccess" and "invisible" users would be ab=
le to
> > > see their own processes in `/proc/<pid>/`.
> >
> > "their own" is very fuzzy and could be interpreted many ways.
> >
> > > The implementation of hidepid however control accesses using the
> > > `ptrace_may_access()` function in any cases. Thus, if a process set
> > > itself as non-dumpable using the `prctl(PR_SET_DUMPABLE,
> > > SUID_DUMP_DISABLE)` it becomes invisible to the user.
> >
> > As Aleksa said, a non-dumpable processes is essentially like a setuid
> > process (even if its UIDs match yours, it may have some remaining
> > special privileges you don't have), so it's not really "your own".
> >
>
> Also replying to  :
>
> > What's the background here - do you have a specific usecase that
> > motivated this patch?
>
> The case I encountered is using the zathura-sandbox pdf viewer which
> sandboxes itself with Landlock and set itself as non-dumpable.

It kind of sounds like an issue with your PDF viewer if that just sets
the non-dumpable flag for no reason...

> If my PDF viewer freezes and I want to kill it as an unprivileged user,
> I'm not able to get its PID from `/proc` since its fully invisible to my
> user.
>
> > > This patch fixes the `has_pid_permissions()` function in order to mak=
e
> > > its behavior to match the documentation.
> >
> > I don't think "it doesn't match the documentation" is good enough
> > reason to change how the kernel works.
> >
> > > Note that since `ptrace_may_access()` is not called anymore with
> > > "noaccess" and "invisible", the `security_ptrace_access_check()` will=
 no
> > > longer be called either.
> > >
> > > Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > > ---
> > >  fs/proc/base.c | 27 ++++++++++++++++++++++++---
> > >  1 file changed, 24 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > > index c667702dc69b8ca2531e88e12ed7a18533f294dd..fb128cb5f95fe65016fce=
96c75aee18c762a30f2 100644
> > > --- a/fs/proc/base.c
> > > +++ b/fs/proc/base.c
> > > @@ -746,9 +746,12 @@ static bool has_pid_permissions(struct proc_fs_i=
nfo *fs_info,
> > >                                  struct task_struct *task,
> > >                                  enum proc_hidepid hide_pid_min)
> > >  {
> > > +       const struct cred *cred =3D current_cred(), *tcred;
> > > +       kuid_t caller_uid;
> > > +       kgid_t caller_gid;
> > >         /*
> > > -        * If 'hidpid' mount option is set force a ptrace check,
> > > -        * we indicate that we are using a filesystem syscall
> > > +        * If 'hidepid=3Dptraceable' mount option is set, force a ptr=
ace check.
> > > +        * We indicate that we are using a filesystem syscall
> > >          * by passing PTRACE_MODE_READ_FSCREDS
> > >          */
> > >         if (fs_info->hide_pid =3D=3D HIDEPID_NOT_PTRACEABLE)
> > > @@ -758,7 +761,25 @@ static bool has_pid_permissions(struct proc_fs_i=
nfo *fs_info,
> > >                 return true;
> > >         if (in_group_p(fs_info->pid_gid))
> > >                 return true;
> > > -       return ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS);
> > > +
> > > +       task_lock(task);
> > > +       rcu_read_lock();
> > > +       caller_uid =3D cred->fsuid;
> > > +       caller_gid =3D cred->fsgid;
> > > +       tcred =3D __task_cred(task);
> > > +       if (uid_eq(caller_uid, tcred->euid) &&
> > > +           uid_eq(caller_uid, tcred->suid) &&
> > > +           uid_eq(caller_uid, tcred->uid)  &&
> > > +           gid_eq(caller_gid, tcred->egid) &&
> > > +           gid_eq(caller_gid, tcred->sgid) &&
> > > +           gid_eq(caller_gid, tcred->gid)) {
> > > +               rcu_read_unlock();
> > > +               task_unlock(task);
> > > +               return true;
> > > +       }
> > > +       rcu_read_unlock();
> > > +       task_unlock(task);
> > > +       return false;
> > >  }
> >
> > I think this is a bad idea for several reasons:
> >
> > 1. It duplicates existing logic.
> I open to work on that.
>
> > 2. I think it prevents a process with euid!=3Druid from introspecting
> > itself through procfs.
> Great question, I'll test that and write some hidepid tests to check that=
.
>
> > 3. I think it prevents root from viewing all processes through procfs.
> Yes only if combined with yama=3D"no attach", and IMHO, that would make s=
ense.

Why only if combined with yama? Doesn't your code always "return
false" on a UID/GID mismatch?

> > 4. It allows processes to view metadata about each other when that was
> > previously blocked by the combination of hidepid and an LSM such as
> > Landlock or SELinux.
> Arf, you're absolutely right about this, my bad.
>
> > 5. It ignores capabilities held by the introspected process but not
> > the process doing the introspection (which is currently checked by
> > cap_ptrace_access_check()).
> As suggested by Aleksa, I can add some capabilities checks here.
>
> >
> > What's the background here - do you have a specific usecase that
> > motivated this patch?
>
> The second motivation is that the "ptraceable" mode didn't worked with
> the yama LSM, which doesn't care about `PTRACE_MODE_READ_FSCREDS` trace
> mode. Thus, using hidepid "ptraceable" mode with yama "restricted",
> "admin-only" or "no attach" modes doesn't do much.
>
> As you have seen, I also have submited a fix to yama in order to make it
> take into account `PTRACE_MODE_READ_FSCREDS` traces.

I don't think that's really a fix - that's more of a new feature
you're proposing. Yama currently explicitly only restricts ATTACH-mode
ptrace access (which can read all process memory or modify the state
of a process), and it doesn't restrict less invasive introspection
that uses READ-mode ptrace checks.

> I have to admit I'm not really found of the fact that those two patch
> are so tightly linked.
>
> Thanks again for your review,
>
> Nicolas

