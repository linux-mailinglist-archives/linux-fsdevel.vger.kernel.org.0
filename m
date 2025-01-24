Return-Path: <linux-fsdevel+bounces-40024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D872BA1AE09
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 02:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB144188E08C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 01:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F001D516B;
	Fri, 24 Jan 2025 00:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GI18n8fG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A16224CC;
	Fri, 24 Jan 2025 00:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737680395; cv=none; b=ggX+nOwD9fF8GDIaeY8ASxLqixY4q9NuM/ogtni0cn7+MSbOWnkggO0INzum8A8FrHMt125pc3ClAP4ZFyMI3xIssPzcLv08egwPgucfl2oUkqLifR7mjLuC6xbTkWb/HTrm7UDWuGC4PqGZ0pugEPaidJomT2nynsgiHK4SA24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737680395; c=relaxed/simple;
	bh=cODgrbY+KP8MtIsLMUOf4ZIlSGAftl2qtO4zYfhWXRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odGdk+zLOIp4bHPDoKR0sTl3NFoAbM/4MB24cpoe3HaU8owoiZGEFetfAw3lfZmtM47HqD47uSk+R77vU8NHskFhfLCRU2HAxJM8KE8/UN3QfiButFme/mdXC1TLadhmk67jXHkVuWH6faPDR429wmDQsOPnWdYOiz9k/SshzuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GI18n8fG; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f4448bf96fso2288046a91.0;
        Thu, 23 Jan 2025 16:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737680393; x=1738285193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGJ+LOFQsueZjAbC0cPrdsYkdCGRoW9eQBPBsAKNZBw=;
        b=GI18n8fG1QyTSiGGzFfzlIW9+9McIY4JXDjEkrjfe9tpvI+sC0/UizjP0iM7BgbwHX
         ynis21g60rvWglw+/yCXPxr2aQ5efgzirfh/z93tIcz2RuddaWltRGARClIRpXCob5Rj
         v6qSeGaqO/qg2bgf7gMEMvtw6O1gVgSOqLmfEY3sGEWLIxuUYEBWjZFRiQmn6Sil0cKr
         xJXx3TeZq/+XVPo4Wcsf1eCBm197rRReupk9hl+hDaIk+Hwow6/XAE1EhUz9/t58eFk2
         LJH2ZVCCpUAwpzIgXbcxMpKr+q2nIRArcb+zBR04u/nROqA1tywXrdHmUGuP4jlVjeWM
         ZTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737680393; x=1738285193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGJ+LOFQsueZjAbC0cPrdsYkdCGRoW9eQBPBsAKNZBw=;
        b=sCHBRSZxlIa6m8CQtsJlvF9JmmthCXaqHxYdb6wmtb44pwnwaLSL+ks/o4nesj9o6q
         c6G5Uq1XyT5gkVW8/ZPgR4oj2jks8FksUcFnQjiezX9nyudDIRPRYFI08P6IeoEUZxJm
         RvAeZ9Oj2hoyXaC/7BCKfqyw+INwn7it8gVRCXAMR43rDMQ6n7YKJcpMWj23do3x73tG
         ECYHqlqPX1MzbVXQ3smGDLLj38eXL9yz8IlD5vKXQUiFlRv4XliM1qqWNi7xjwOkF/1o
         MeS+Djn/yEXJ/0KeswpsahWSxLrM5R3FacZ/FsIAi+d6ITbXs24+s9FUoemn213zP0ID
         yHSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCAoXrD0As77Oyshntc4eImrpqkDaubSX3Deg1r1QVu9YMsrtnUrZav8eQ9zIVWeuQdFTmD2T/4Y8ewmv6mmwrlw==@vger.kernel.org, AJvYcCV8l0x+wcKyeZQU7DcLXWFD8ujMvLIpH4dXjK6LctRuqHmu6exS1vOJr7/aMK7UbUgD5vAnTqmSoT33MoIFgb39PS/c1qp1@vger.kernel.org, AJvYcCW/QK8qVna0g63lRgcvxo2XkVKgA4gYHz0oGDMC0EFaeIHbdvX3Qs4c7GpojyHUCvQaCSE=@vger.kernel.org, AJvYcCWW8cYlrQDRbKLnwcnE/IbXVDVQ+qZIIqCPaDI8pukcZEsX/K4y6EqlGKuF0gdBqBYvXNa+7DNQ8uzmQV0N@vger.kernel.org, AJvYcCXk//4KE+Mk/EHwLD5SDMpV/suzKVLNaH2zp1whIt0fPGhB+pINfQig7W5eLFCbVJnIGhnjeTKsiqcg77tX5Q==@vger.kernel.org, AJvYcCXuuD8nHuqwkykWzGzWxLjzbRlT+EZjNlfxLh9gLqQl+whGbI6OGRXm4w4jX5wncXfH4DKffw0uDkr6PIZzhXyRZO4z@vger.kernel.org
X-Gm-Message-State: AOJu0YxkEwEjCCmjomAYPazE58wsG/tZzxik91T1CkMNpCgGgmpn4gUT
	GnJRW9cnFa/17TPqB6nnh2130kLqCUzq+yhCET24H100wv9/AMaXLKuYg7zgQgnI5+qFIV+z6aG
	hFq1pVbv87S8XF6KR6lmKYRSpcYQ=
X-Gm-Gg: ASbGncvxMpQYaApIToSVQ0acWtNRBabltaAwz73DLiNgrAoxEOt2ZLxVNqRpjd3ifmS
	ICiNQxWpm+6Jw6NZ8XO8SNte8jiaeTslWgG+kAK38FkOJ7yQviBQNEDRK6izfHTcWfB3qTscVWX
	3ieGs86GeVw76v
X-Google-Smtp-Source: AGHT+IEUIz9scdrVFJ+gtZjs9wyWB7JNdYwpMDbqC2wtWVPcS47Yd13fC8PGpZo55BBHcmqGMYisS1UI28edrLiekgc=
X-Received: by 2002:a05:6a00:3cd3:b0:727:d55e:4be3 with SMTP id
 d2e1a72fcca58-72daf9e0919mr39848627b3a.7.1737680393052; Thu, 23 Jan 2025
 16:59:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123214342.4145818-1-andrii@kernel.org> <CAJuCfpE9QOo-xmDpk_FF=gs3p=9Zzb-Q5yDaKAEChBCnpogmQg@mail.gmail.com>
 <202501231526.A3C13EC5@keescook>
In-Reply-To: <202501231526.A3C13EC5@keescook>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 23 Jan 2025 16:59:38 -0800
X-Gm-Features: AbW1kva6NRq7GYf8siQt0N3qPLCqEdfanjjoZdLOdZlkCjA2qfdcH_vSoTjXlf4
Message-ID: <CAEf4BzbYBw3kzWyyG42VZSKh8MX+Xfqa1B_TRRN4p35_C9xZmw@mail.gmail.com>
Subject: Re: [PATCH] mm,procfs: allow read-only remote mm access under CAP_PERFMON
To: Kees Cook <kees@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Andrii Nakryiko <andrii@kernel.org>, linux-mm@kvack.org, 
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@meta.com, rostedt@goodmis.org, peterz@infradead.org, 
	mingo@kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, shakeel.butt@linux.dev, rppt@kernel.org, 
	liam.howlett@oracle.com, Jann Horn <jannh@google.com>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 3:47=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Thu, Jan 23, 2025 at 01:52:52PM -0800, Suren Baghdasaryan wrote:
> > On Thu, Jan 23, 2025 at 1:44=E2=80=AFPM Andrii Nakryiko <andrii@kernel.=
org> wrote:
> > >
> > > It's very common for various tracing and profiling toolis to need to
> > > access /proc/PID/maps contents for stack symbolization needs to learn
> > > which shared libraries are mapped in memory, at which file offset, et=
c.
> > > Currently, access to /proc/PID/maps requires CAP_SYS_PTRACE (unless w=
e
> > > are looking at data for our own process, which is a trivial case not =
too
> > > relevant for profilers use cases).
> > >
> > > Unfortunately, CAP_SYS_PTRACE implies way more than just ability to
> > > discover memory layout of another process: it allows to fully control
> > > arbitrary other processes. This is problematic from security POV for
> > > applications that only need read-only /proc/PID/maps (and other simil=
ar
> > > read-only data) access, and in large production settings CAP_SYS_PTRA=
CE
> > > is frowned upon even for the system-wide profilers.
> > >
> > > On the other hand, it's already possible to access similar kind of
> > > information (and more) with just CAP_PERFMON capability. E.g., settin=
g
> > > up PERF_RECORD_MMAP collection through perf_event_open() would give o=
ne
> > > similar information to what /proc/PID/maps provides.
> > >
> > > CAP_PERFMON, together with CAP_BPF, is already a very common combinat=
ion
> > > for system-wide profiling and observability application. As such, it'=
s
> > > reasonable and convenient to be able to access /proc/PID/maps with
> > > CAP_PERFMON capabilities instead of CAP_SYS_PTRACE.
> > >
> > > For procfs, these permissions are checked through common mm_access()
> > > helper, and so we augment that with cap_perfmon() check *only* if
> > > requested mode is PTRACE_MODE_READ. I.e., PTRACE_MODE_ATTACH wouldn't=
 be
> > > permitted by CAP_PERFMON.
> > >
> > > Besides procfs itself, mm_access() is used by process_madvise() and
> > > process_vm_{readv,writev}() syscalls. The former one uses
> > > PTRACE_MODE_READ to avoid leaking ASLR metadata, and as such CAP_PERF=
MON
> > > seems like a meaningful allowable capability as well.
> > >
> > > process_vm_{readv,writev} currently assume PTRACE_MODE_ATTACH level o=
f
> > > permissions (though for readv PTRACE_MODE_READ seems more reasonable,
> > > but that's outside the scope of this change), and as such won't be
> > > affected by this patch.
> >
> > CC'ing Jann and Kees.
> >
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  kernel/fork.c | 11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > index ded49f18cd95..c57cb3ad9931 100644
> > > --- a/kernel/fork.c
> > > +++ b/kernel/fork.c
> > > @@ -1547,6 +1547,15 @@ struct mm_struct *get_task_mm(struct task_stru=
ct *task)
> > >  }
> > >  EXPORT_SYMBOL_GPL(get_task_mm);
> > >
> > > +static bool can_access_mm(struct mm_struct *mm, struct task_struct *=
task, unsigned int mode)
> > > +{
> > > +       if (mm =3D=3D current->mm)
> > > +               return true;
> > > +       if ((mode & PTRACE_MODE_READ) && perfmon_capable())
> > > +               return true;
> > > +       return ptrace_may_access(task, mode);
> > > +}
>
> nit: "may" tends to be used more than "can" for access check function nam=
ing.

good point, will change to "may"

>
> So, this will bypass security_ptrace_access_check() within
> ptrace_may_access(). CAP_PERFMON may be something LSMs want visibility
> into.

yeah, similar to perf's perf_check_permission() (though, admittedly,
perf has its own security_perf_event_open(&attr, PERF_SECURITY_OPEN)
check much earlier in perf_event_open() logic)

>
> It also bypasses the dumpability check in __ptrace_may_access(). (Should
> non-dumpability block visibility into "maps" under CAP_PERFMON?)

With perf_event_open() and PERF_RECORD_MMAP none of this dumpability
is honored today as well, so I think CAP_PERFMON should override all
these ptrace things here, no?

>
> This change provides read access for CAP_PERFMON to:
>
> /proc/$pid/maps
> /proc/$pid/smaps
> /proc/$pid/mem
> /proc/$pid/environ
> /proc/$pid/auxv
> /proc/$pid/attr/*
> /proc/$pid/smaps_rollup
> /proc/$pid/pagemap
>
> /proc/$pid/mem access seems way out of bounds for CAP_PERFMON. environ
> and auxv maybe too much also. The "attr" files seem iffy. pagemap may be
> reasonable.

As Shakeel pointed out, /proc/PID/mem is PTRACE_MODE_ATTACH, so won't
be permitted under CAP_PERFMON either.

Don't really know what auxv is, but I could read all that with BPF if
I had CAP_PERFMON, for any task, so not like we are opening up new
possibilities here.

>
> Gaining CAP_PERFMON access to *only* the "maps" file doesn't seem too
> bad to me, but I think the proposed patch ends up providing way too wide
> access to other things.

I do care about maps mostly, yes, but I also wanted to avoid
duplicating all that mm_access() logic just for maps (and probably
smaps, they are the same data). But again, CAP_PERFMON basically means
read-only tracing access to anything within kernel and any user
process, so it felt appropriate to allow CAP_PERFMON here.

>
> Also, this is doing an init-namespace capability check for
> CAP_PERFMON (via perfmon_capable()). Shouldn't this be per-namespace?

CAP_PERFMON isn't namespaced as far as perf_event_open() is concerned,
so at least for that reason I don't want to relax the requirement
here. Namespacing CAP_PERFMON in general is interesting and I bet
there are users that would appreciate that, but that's an entire epic
journey we probably don't want to start here.

>
> -Kees
>
> > > +
> > >  struct mm_struct *mm_access(struct task_struct *task, unsigned int m=
ode)
> > >  {
> > >         struct mm_struct *mm;
> > > @@ -1559,7 +1568,7 @@ struct mm_struct *mm_access(struct task_struct =
*task, unsigned int mode)
> > >         mm =3D get_task_mm(task);
> > >         if (!mm) {
> > >                 mm =3D ERR_PTR(-ESRCH);
> > > -       } else if (mm !=3D current->mm && !ptrace_may_access(task, mo=
de)) {
> > > +       } else if (!can_access_mm(mm, task, mode)) {
> > >                 mmput(mm);
> > >                 mm =3D ERR_PTR(-EACCES);
> > >         }
> > > --
> > > 2.43.5
> > >
>
> --
> Kees Cook

