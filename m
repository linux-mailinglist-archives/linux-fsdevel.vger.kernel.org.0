Return-Path: <linux-fsdevel+bounces-40020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBCEA1ADB1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 00:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F7D3A827E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 23:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286941D5AD4;
	Thu, 23 Jan 2025 23:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yhu3qTUe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62591D5AAE
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 23:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737676545; cv=none; b=GAJ0lD8Q1QnMcesldOWIpsT9CS3L+Jdo3z5Oxbj3pLYwxojaslZCKycFU+5UDoGxrCDJ+IVaZHT7MmJx7A37X6aFmdqhq1kq0mOc3akB1nnd5s3yr/7MO6nK49Gm3smlkkxl42Oiga53tTuvqe3xgBTSrjWxAaFhDggest9qjx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737676545; c=relaxed/simple;
	bh=v0FggTfs25V/GAY+T15aZ5RkSzmN+aC2OxF418iX4Oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5oLzck5hOBBxB/SH5BLnEYEHJD9KXOy9cZJZLGhkuVFlJKYb/b7LF6LK0apv2RNrh+00ieXOsjkuVfiq7kiaRss9qG/FdHXFT2QsjFCVDeCw3L40tSh/OUdgKTWzBlSc3tBFLP0n84frQN+8CoeEK7OPoHvQZi3akfSIGv1X6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yhu3qTUe; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3e638e1b4so1406a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 15:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737676542; x=1738281342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9Ragv1x82SwxtUpkVXr3TYFZXEnZuc/EWqFgnlmJDc=;
        b=Yhu3qTUePzeBcY3fMbOsBt4j2R2Pgeyz6sDyaDJ4iUaRQeGEw/bZ88CsmiwTt3gVoS
         hzKMtwFLQwb/uhzAECFSlwiTZKSt8Hxa1934cIM2Hzz0uUGP4viOd0K1E/tyVKHEtj77
         E/2zrU5x8wAFWlNYT46Tl45LvE/HQy9PARLITQtdfTqLP9Cg2o0uXQyO1bo0AAqxjnZ0
         dOFbbE860vLCm98vb6lig2rlernr9cLFlim2OgOYJbfZr4nyDug08KN2BVm4zjJW2wmW
         j/JkBuxgbbKTHMugT2aes9+LR84NXNPellHds80Rw1Hm9Z35XFmjeCKAL+psNgjBJfR8
         wxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737676542; x=1738281342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9Ragv1x82SwxtUpkVXr3TYFZXEnZuc/EWqFgnlmJDc=;
        b=OWv8gBWep1ueUNySWzpLWmme7m6juZUQoXsPqVPkDkNJmTg217fIED1OiNDhVmvJTo
         CdkTkB0XqBSmek8f6IdcUyacy9v3vRKv0M8bRWvDNJwY2qT3x58B87pP4d3Iyvr1cKvr
         XJ4LRgyw3+2robsndiSMeEle51j+BHcL57LeIAzBxoyCdl0mr1KqrukLAi5XU+lEdB0E
         MLGBEQohk6FgVZnM00CtCHbV7rYOZd9OHpbsjquJ+jx7NV/zFI3nSXbjlaKhX+wGm6WS
         spWGMibvAzDbZvEfCW+oIjh2Zxd1JRoBz/KCoTmdEgByhVevzevXQElT7a4IenhyBv+/
         4I9g==
X-Forwarded-Encrypted: i=1; AJvYcCVlWRYp39O42rKAUvYhOkPbKJo4zka9jjh0WR8oA2p5Rv7V5CVeASKa2P+KwyS7lJH11J5nkc519d1FykJt@vger.kernel.org
X-Gm-Message-State: AOJu0YwusaZqx3NEGdNVBjagCl/gOh49NOBkkNN6c46/4rovVlwVcvbk
	MojHE9MGayPeEBuMxz+Hpcv9OJnvcQ0a98YqdRv8fsXwbEz4kL0sKKKIBse+LvpAmuaFAoEInYa
	4xfcLItipJTJ8bWqvyaybLLcTtk1zyIpuYH4W
X-Gm-Gg: ASbGncuuJsb0wcDUZAHGvIwQhoETdWcX3wYHdtGweq2anA/RUga0LzECjKPQXNKQTZ2
	QVPN8QcN2cHFkQ8vuUXMlLlvCf9DfVg2f6vJeehjE6bOL5zu/+8qMrtBUwj5EftfGRhxDqxsQzD
	n/QVHrz6/ijHB2
X-Google-Smtp-Source: AGHT+IFGTCYC1Urp8sKTGkSi5p5S/Fc8SFTFb532XbOtDnLlTcDCvS5l/1/sYkHDNjZYgiEvQM+eMoDylP2iU6QViPQ=
X-Received: by 2002:a50:9b0e:0:b0:5db:e8ed:5741 with SMTP id
 4fb4d7f45d1cf-5dc0c9ed5fcmr146053a12.7.1737676541342; Thu, 23 Jan 2025
 15:55:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123214342.4145818-1-andrii@kernel.org> <CAJuCfpE9QOo-xmDpk_FF=gs3p=9Zzb-Q5yDaKAEChBCnpogmQg@mail.gmail.com>
 <202501231526.A3C13EC5@keescook>
In-Reply-To: <202501231526.A3C13EC5@keescook>
From: Jann Horn <jannh@google.com>
Date: Fri, 24 Jan 2025 00:55:05 +0100
X-Gm-Features: AWEUYZkNff3Q26T9o9EX_TQ_KWMgeFo0Eqakd0uRwk5keM2gA1CnvXc-g9_3J_s
Message-ID: <CAG48ez1TXEJH3mFmm-QZbbmr_YupnoLA0WQx6WgxKQSHP3jPSA@mail.gmail.com>
Subject: Re: [PATCH] mm,procfs: allow read-only remote mm access under CAP_PERFMON
To: Kees Cook <kees@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Andrii Nakryiko <andrii@kernel.org>, linux-mm@kvack.org, 
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@meta.com, rostedt@goodmis.org, peterz@infradead.org, 
	mingo@kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, shakeel.butt@linux.dev, rppt@kernel.org, 
	liam.howlett@oracle.com, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 12:47=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
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
>
> So, this will bypass security_ptrace_access_check() within
> ptrace_may_access(). CAP_PERFMON may be something LSMs want visibility
> into.
>
> It also bypasses the dumpability check in __ptrace_may_access(). (Should
> non-dumpability block visibility into "maps" under CAP_PERFMON?)
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

FWIW, my understanding is that if you can use perf_event_open() on a
process, you can also grab large amounts of stack memory contents from
that process via PERF_SAMPLE_STACK_USER/sample_stack_user. (The idea
there is that stack unwinding for userspace stacks is complicated, so
it's the profiler's job to turn a pile of raw stack contents and a
register snapshot into a stack trace.) So _to some extent_ I think it
is already possible to read memory of another process via CAP_PERFMON.
Whether that is desirable or not I don't know, though I guess it's
hard to argue that there's a qualitative security difference between
reading register contents and reading stack memory...

