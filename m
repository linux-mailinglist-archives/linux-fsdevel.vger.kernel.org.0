Return-Path: <linux-fsdevel+bounces-40025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B80A1AE10
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 02:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CDA47A5260
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 01:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2A61D516D;
	Fri, 24 Jan 2025 01:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kb6LZiNn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF5713AC1;
	Fri, 24 Jan 2025 01:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737680578; cv=none; b=llvwYU4ZYXVFGuY4LeJlgbDpA8nplo2nwBBwLbR179HfEPNiZF23Bsxm4QLoWigOFItjCzhL4RoiC2lKGid7GgvnSJLqVlno+wz2c5tjvCRQjJt2X37uvOKbou92h3CdbedT6JkxF+w42Wbmp5ZGacyHQa2BbuhMOPN78E+T8nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737680578; c=relaxed/simple;
	bh=Rq8kZwwXGjztMSgzkUP1H/YqKvt3qDXZ21j1s3ck1B0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cpyhzq3Vv3xGeAxqCjEvsT0CLCFOMvhYO5S2hVzLVT8hZ7LvO5dLHrIek8qHIqGR7F9NJ7Vi20Rr0Q+K447pbxIMuvMelnId/pIAk76FbcwAlLhTjEmhfLkaxU+SScNjqqvkwRqiWC7dEf1Xtdui+NkG64au3vXjnE1Rr0A5xJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kb6LZiNn; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2164b1f05caso26478215ad.3;
        Thu, 23 Jan 2025 17:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737680576; x=1738285376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0aJPrChJkjhsAZYwCY7691Ium0idIWe4UuZ5CwOmvw=;
        b=Kb6LZiNnNsy45N3x9BUZFMAT4m6MYqT+uR0+JumMm/Djz5cdVm2C4r0GvxM63OmSEH
         l1PSTbzOp8L9w/dICbUs5YMkofRCje5vJlUs4pRgbSo77q4fl5ZB1aGX0g9jIBqPJtdc
         7jKBoMSBShHtFfq47Him6yNUEA3dSs7OPpbiyEQFgZfEpjQpOZwPzGBIwvaUM2jQPkKt
         fIn+vPoFJWZfY9WjIZ9AILWZr3iV80FO773MAVCZzNKECOCd/P14hdXBOgFnUVt5APD9
         LI09+VEIUgh9GSCzxn0uPGzTaU77HJE4UChWaPrxUQVaJYGhFX1Q+GOopJbQOhEANWH+
         eVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737680576; x=1738285376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0aJPrChJkjhsAZYwCY7691Ium0idIWe4UuZ5CwOmvw=;
        b=MjOTqwhjbcK1j0kr7iqCZceraRSlra/Kj8NjJ8nsGB53JxsBv7TLB/vUl+oDtU9UFt
         8IBRUoPVAAJVuqUTk5gcWfpRsEPMxFakdkk42ZL/tg29XBrJP7TCq52BGVVfE57ArTz7
         mYDdAUHZdzirDR0k0DvxyUKWngQ90MCn9uGyvFD6b6zvfNlLlo0lU0wp8j74wjKvIx1/
         Ty2U3acu/ZPv2BYeS745nn8RCC0+D38FG/MYimohgFpC00CvcKPJusv5uKWRmNqIlzuI
         Et+6dWBnrz8IH8xWzXEk9rH7m+1w7K8wSMK8UJxjGUqbEfMWhuCoC+YQ8eKpKJaLSMUH
         lHjg==
X-Forwarded-Encrypted: i=1; AJvYcCVoL64CgoE96StzztDnzCoNcCa553cmitgbw1j0ftFvkBNw5S0uqWcm6luVK+uui7pkZUWxluW1ncd4iHVpzo03MYNT@vger.kernel.org, AJvYcCWBH6hdcZhfbKM+BzXMqbcYhB35nRFkjN1vw9BfaP4Lcdo6sR47ry3/WZEolcuX1PQU+neB5FP3l8W8t0mkWz1jigVbTQ8p@vger.kernel.org, AJvYcCWX4TCHlJ6M4uATqoGFK0zxGyGSETJUJxPRipujI6vxo47wzTusAvP5DvJm/Ja9pmANJ0XgL4hSe8Rzjmle@vger.kernel.org, AJvYcCX+PidXgu/ui01K/XinzcD5HOrODeuSeIByspoFSIeAp/R0FD3O/LsjGgyQe7b76J2HV3yWw9vtKXL+IjOm44IaFw==@vger.kernel.org, AJvYcCX+f5nJHPYRXgSiJ54IxtDTVeulIYh33Tz2Oq7DbBVM/AqGscy42fIQJa19Ir964Z8hTYx0eFyfiNcsER05Sg==@vger.kernel.org, AJvYcCXaCd4buSUOdEaoz+zE+Ofv+V5kn/GYa+gRTdO4xfyOdaFhrLPoYJ3uLKWOQwKYP3bMEAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIIAHlsE42BcU1oPbov3lmOXRm29pJ6/rsS6RG3F5LVzlEDUZU
	n44a/8was8Uj8CpOJA4a7yZubZGGPoVsLKyYNObWq4Dzjj1QWxBZgZIPZI1wzOIhvxNNhoSE9Rk
	ahQFMpsn4qsSMqUzF29nuOGagVlI=
X-Gm-Gg: ASbGncvxxKVuFToK6jNUADiaOvo7zJcrVEc9Mq2Gq9qc3Wa4CdubRaKmXZe/IpusTJq
	Ic8AWtlNMIh4g5AxTLe8usshh98emVUlvS19ptjzsqT7zGYTWjAiXg+Eh98SFMulceBRh5ykcug
	SJzQ==
X-Google-Smtp-Source: AGHT+IEuyDzr4dFkkBvqvAW5OHSqHScPRQtMfqosR3W768baJCU6A9tUKJV1y5CH1vjwgjK9jbohovckbO/Io8mhO64=
X-Received: by 2002:a05:6a00:4214:b0:727:3c8f:3707 with SMTP id
 d2e1a72fcca58-72dafbf3b34mr41968026b3a.23.1737680575847; Thu, 23 Jan 2025
 17:02:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123214342.4145818-1-andrii@kernel.org> <CAJuCfpE9QOo-xmDpk_FF=gs3p=9Zzb-Q5yDaKAEChBCnpogmQg@mail.gmail.com>
 <202501231526.A3C13EC5@keescook> <CAG48ez1TXEJH3mFmm-QZbbmr_YupnoLA0WQx6WgxKQSHP3jPSA@mail.gmail.com>
In-Reply-To: <CAG48ez1TXEJH3mFmm-QZbbmr_YupnoLA0WQx6WgxKQSHP3jPSA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 23 Jan 2025 17:02:40 -0800
X-Gm-Features: AbW1kvaNIXPwtdjTpZnh9pk24SpZKxJaM3CayvMBHXdj24HdZVOFF_DSCaFQHy4
Message-ID: <CAEf4BzaToT9YcwPm7N63wK0dLTVLEVwABCBXmRVP5+_A7bCKpg@mail.gmail.com>
Subject: Re: [PATCH] mm,procfs: allow read-only remote mm access under CAP_PERFMON
To: Jann Horn <jannh@google.com>
Cc: Kees Cook <kees@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-mm@kvack.org, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com, 
	rostedt@goodmis.org, peterz@infradead.org, mingo@kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	shakeel.butt@linux.dev, rppt@kernel.org, liam.howlett@oracle.com, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 3:55=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Jan 24, 2025 at 12:47=E2=80=AFAM Kees Cook <kees@kernel.org> wrot=
e:
> > On Thu, Jan 23, 2025 at 01:52:52PM -0800, Suren Baghdasaryan wrote:
> > > On Thu, Jan 23, 2025 at 1:44=E2=80=AFPM Andrii Nakryiko <andrii@kerne=
l.org> wrote:
> > > >
> > > > It's very common for various tracing and profiling toolis to need t=
o
> > > > access /proc/PID/maps contents for stack symbolization needs to lea=
rn
> > > > which shared libraries are mapped in memory, at which file offset, =
etc.
> > > > Currently, access to /proc/PID/maps requires CAP_SYS_PTRACE (unless=
 we
> > > > are looking at data for our own process, which is a trivial case no=
t too
> > > > relevant for profilers use cases).
> > > >
> > > > Unfortunately, CAP_SYS_PTRACE implies way more than just ability to
> > > > discover memory layout of another process: it allows to fully contr=
ol
> > > > arbitrary other processes. This is problematic from security POV fo=
r
> > > > applications that only need read-only /proc/PID/maps (and other sim=
ilar
> > > > read-only data) access, and in large production settings CAP_SYS_PT=
RACE
> > > > is frowned upon even for the system-wide profilers.
> > > >
> > > > On the other hand, it's already possible to access similar kind of
> > > > information (and more) with just CAP_PERFMON capability. E.g., sett=
ing
> > > > up PERF_RECORD_MMAP collection through perf_event_open() would give=
 one
> > > > similar information to what /proc/PID/maps provides.
> > > >
> > > > CAP_PERFMON, together with CAP_BPF, is already a very common combin=
ation
> > > > for system-wide profiling and observability application. As such, i=
t's
> > > > reasonable and convenient to be able to access /proc/PID/maps with
> > > > CAP_PERFMON capabilities instead of CAP_SYS_PTRACE.
> > > >
> > > > For procfs, these permissions are checked through common mm_access(=
)
> > > > helper, and so we augment that with cap_perfmon() check *only* if
> > > > requested mode is PTRACE_MODE_READ. I.e., PTRACE_MODE_ATTACH wouldn=
't be
> > > > permitted by CAP_PERFMON.
> > > >
> > > > Besides procfs itself, mm_access() is used by process_madvise() and
> > > > process_vm_{readv,writev}() syscalls. The former one uses
> > > > PTRACE_MODE_READ to avoid leaking ASLR metadata, and as such CAP_PE=
RFMON
> > > > seems like a meaningful allowable capability as well.
> > > >
> > > > process_vm_{readv,writev} currently assume PTRACE_MODE_ATTACH level=
 of
> > > > permissions (though for readv PTRACE_MODE_READ seems more reasonabl=
e,
> > > > but that's outside the scope of this change), and as such won't be
> > > > affected by this patch.
> > >
> > > CC'ing Jann and Kees.
> > >
> > > >
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > > >  kernel/fork.c | 11 ++++++++++-
> > > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > > index ded49f18cd95..c57cb3ad9931 100644
> > > > --- a/kernel/fork.c
> > > > +++ b/kernel/fork.c
> > > > @@ -1547,6 +1547,15 @@ struct mm_struct *get_task_mm(struct task_st=
ruct *task)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(get_task_mm);
> > > >
> > > > +static bool can_access_mm(struct mm_struct *mm, struct task_struct=
 *task, unsigned int mode)
> > > > +{
> > > > +       if (mm =3D=3D current->mm)
> > > > +               return true;
> > > > +       if ((mode & PTRACE_MODE_READ) && perfmon_capable())
> > > > +               return true;
> > > > +       return ptrace_may_access(task, mode);
> > > > +}
> >
> > nit: "may" tends to be used more than "can" for access check function n=
aming.
> >
> > So, this will bypass security_ptrace_access_check() within
> > ptrace_may_access(). CAP_PERFMON may be something LSMs want visibility
> > into.
> >
> > It also bypasses the dumpability check in __ptrace_may_access(). (Shoul=
d
> > non-dumpability block visibility into "maps" under CAP_PERFMON?)
> >
> > This change provides read access for CAP_PERFMON to:
> >
> > /proc/$pid/maps
> > /proc/$pid/smaps
> > /proc/$pid/mem
> > /proc/$pid/environ
> > /proc/$pid/auxv
> > /proc/$pid/attr/*
> > /proc/$pid/smaps_rollup
> > /proc/$pid/pagemap
> >
> > /proc/$pid/mem access seems way out of bounds for CAP_PERFMON. environ
> > and auxv maybe too much also. The "attr" files seem iffy. pagemap may b=
e
> > reasonable.
>
> FWIW, my understanding is that if you can use perf_event_open() on a
> process, you can also grab large amounts of stack memory contents from
> that process via PERF_SAMPLE_STACK_USER/sample_stack_user. (The idea
> there is that stack unwinding for userspace stacks is complicated, so
> it's the profiler's job to turn a pile of raw stack contents and a
> register snapshot into a stack trace.) So _to some extent_ I think it
> is already possible to read memory of another process via CAP_PERFMON.
> Whether that is desirable or not I don't know, though I guess it's
> hard to argue that there's a qualitative security difference between
> reading register contents and reading stack memory...

If I'm allowed to bring in BPF capabilities coupled with CAP_PERFMON,
then you can read not just stack, but pretty much anything both inside
the kernel memory (e.g., through bpf_probe_read_kernel()) and
user-space (bpf_probe_read_user() for current user task, and more
generally bpf_copy_from_user_task() for an arbitrary task for which we
have struct task_struct).

But we don't really allow access to /proc/PID/mem here, because it's
PTRACE_MODE_ATTACH (which is sort of like read/write vs read-only).

Similarly, it would be relevant for process_vm_readv(), but that one
(currently) is also PTRACE_MODE_ATTACH.

