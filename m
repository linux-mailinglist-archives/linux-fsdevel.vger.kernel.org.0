Return-Path: <linux-fsdevel+bounces-40018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6C7A1AD89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 00:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07AF7165192
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 23:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA461D63F2;
	Thu, 23 Jan 2025 23:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoM1KAGZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF7F1BDAB5;
	Thu, 23 Jan 2025 23:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737676067; cv=none; b=oS9295GuKgG0m8dYqHhTyTfn1oeBqsz3bOAiC+UaFKXENTAVVQeQaLPK6zWt1ItCvvEhm21CgbhYaiP2ipstd55B7AXUPfMpLo6WdOUsyk6U5VHfA2J/pr7alg+vinv+2r3eXhzY2mrYqDHOiW8n9vrAQxOpc0+0z1y2CQVeT9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737676067; c=relaxed/simple;
	bh=wraYd2NGwuEyzk8Cgc5yaLobelCCviWThCaaKkdHMu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SH4/Jxmvow2rSM4DXVkMPChIlVUEbuAfJ+fXhvJLsLi7Yv+LZgdfFb9XQbmTwG+mtAgVv7krducSGbRx1BISaXSZHHQodn4j8B/wvPFNkvOPnhkpV+j1ZqCEaX1Zy4puOCciFEbQQbum/hmas2toSc3UMoyDMuKdmWSvY7sYSKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uoM1KAGZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BCFC4CED3;
	Thu, 23 Jan 2025 23:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737676067;
	bh=wraYd2NGwuEyzk8Cgc5yaLobelCCviWThCaaKkdHMu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uoM1KAGZIiefDfHgZDxyELPBM22hTQH1XyHU+IpjJAIv2QNNwCPYMVqdM+htvYa6w
	 d/Un2AKdgpKpInZhod29JdKJpafmOZ8d2d57cmMi1Akm2/cDrq5gmDCA3LgeTI3DUU
	 dDY7Lz42F4b4Md8af6BpBtGZQ+loK2dOPaBW/haDChHwnz2lrvR6Fels6V9xvTvTsw
	 CtGcpS4SVKObhi7BWGvmLIhQAXGXwAykmaj7bc4onqYX6qyotevurEzmT0FDC80Fgg
	 xlGnalQak8rVIzU7ViSZumFDib6h7XwqcElLIpitqYAGiiIRWbQzzhPA03Vg5ERZhC
	 dxgg1WiZJ0z0A==
Date: Thu, 23 Jan 2025 15:47:44 -0800
From: Kees Cook <kees@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-mm@kvack.org,
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
	brauner@kernel.org, viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com, rostedt@goodmis.org, peterz@infradead.org,
	mingo@kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, shakeel.butt@linux.dev,
	rppt@kernel.org, liam.howlett@oracle.com,
	Jann Horn <jannh@google.com>, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] mm,procfs: allow read-only remote mm access under
 CAP_PERFMON
Message-ID: <202501231526.A3C13EC5@keescook>
References: <20250123214342.4145818-1-andrii@kernel.org>
 <CAJuCfpE9QOo-xmDpk_FF=gs3p=9Zzb-Q5yDaKAEChBCnpogmQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpE9QOo-xmDpk_FF=gs3p=9Zzb-Q5yDaKAEChBCnpogmQg@mail.gmail.com>

On Thu, Jan 23, 2025 at 01:52:52PM -0800, Suren Baghdasaryan wrote:
> On Thu, Jan 23, 2025 at 1:44 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > It's very common for various tracing and profiling toolis to need to
> > access /proc/PID/maps contents for stack symbolization needs to learn
> > which shared libraries are mapped in memory, at which file offset, etc.
> > Currently, access to /proc/PID/maps requires CAP_SYS_PTRACE (unless we
> > are looking at data for our own process, which is a trivial case not too
> > relevant for profilers use cases).
> >
> > Unfortunately, CAP_SYS_PTRACE implies way more than just ability to
> > discover memory layout of another process: it allows to fully control
> > arbitrary other processes. This is problematic from security POV for
> > applications that only need read-only /proc/PID/maps (and other similar
> > read-only data) access, and in large production settings CAP_SYS_PTRACE
> > is frowned upon even for the system-wide profilers.
> >
> > On the other hand, it's already possible to access similar kind of
> > information (and more) with just CAP_PERFMON capability. E.g., setting
> > up PERF_RECORD_MMAP collection through perf_event_open() would give one
> > similar information to what /proc/PID/maps provides.
> >
> > CAP_PERFMON, together with CAP_BPF, is already a very common combination
> > for system-wide profiling and observability application. As such, it's
> > reasonable and convenient to be able to access /proc/PID/maps with
> > CAP_PERFMON capabilities instead of CAP_SYS_PTRACE.
> >
> > For procfs, these permissions are checked through common mm_access()
> > helper, and so we augment that with cap_perfmon() check *only* if
> > requested mode is PTRACE_MODE_READ. I.e., PTRACE_MODE_ATTACH wouldn't be
> > permitted by CAP_PERFMON.
> >
> > Besides procfs itself, mm_access() is used by process_madvise() and
> > process_vm_{readv,writev}() syscalls. The former one uses
> > PTRACE_MODE_READ to avoid leaking ASLR metadata, and as such CAP_PERFMON
> > seems like a meaningful allowable capability as well.
> >
> > process_vm_{readv,writev} currently assume PTRACE_MODE_ATTACH level of
> > permissions (though for readv PTRACE_MODE_READ seems more reasonable,
> > but that's outside the scope of this change), and as such won't be
> > affected by this patch.
> 
> CC'ing Jann and Kees.
> 
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/fork.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index ded49f18cd95..c57cb3ad9931 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -1547,6 +1547,15 @@ struct mm_struct *get_task_mm(struct task_struct *task)
> >  }
> >  EXPORT_SYMBOL_GPL(get_task_mm);
> >
> > +static bool can_access_mm(struct mm_struct *mm, struct task_struct *task, unsigned int mode)
> > +{
> > +       if (mm == current->mm)
> > +               return true;
> > +       if ((mode & PTRACE_MODE_READ) && perfmon_capable())
> > +               return true;
> > +       return ptrace_may_access(task, mode);
> > +}

nit: "may" tends to be used more than "can" for access check function naming.

So, this will bypass security_ptrace_access_check() within
ptrace_may_access(). CAP_PERFMON may be something LSMs want visibility
into.

It also bypasses the dumpability check in __ptrace_may_access(). (Should
non-dumpability block visibility into "maps" under CAP_PERFMON?)

This change provides read access for CAP_PERFMON to:

/proc/$pid/maps
/proc/$pid/smaps
/proc/$pid/mem
/proc/$pid/environ
/proc/$pid/auxv
/proc/$pid/attr/*
/proc/$pid/smaps_rollup
/proc/$pid/pagemap

/proc/$pid/mem access seems way out of bounds for CAP_PERFMON. environ
and auxv maybe too much also. The "attr" files seem iffy. pagemap may be
reasonable.

Gaining CAP_PERFMON access to *only* the "maps" file doesn't seem too
bad to me, but I think the proposed patch ends up providing way too wide
access to other things.

Also, this is doing an init-namespace capability check for
CAP_PERFMON (via perfmon_capable()). Shouldn't this be per-namespace?

-Kees

> > +
> >  struct mm_struct *mm_access(struct task_struct *task, unsigned int mode)
> >  {
> >         struct mm_struct *mm;
> > @@ -1559,7 +1568,7 @@ struct mm_struct *mm_access(struct task_struct *task, unsigned int mode)
> >         mm = get_task_mm(task);
> >         if (!mm) {
> >                 mm = ERR_PTR(-ESRCH);
> > -       } else if (mm != current->mm && !ptrace_may_access(task, mode)) {
> > +       } else if (!can_access_mm(mm, task, mode)) {
> >                 mmput(mm);
> >                 mm = ERR_PTR(-EACCES);
> >         }
> > --
> > 2.43.5
> >

-- 
Kees Cook

