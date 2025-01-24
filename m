Return-Path: <linux-fsdevel+bounces-40032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205FDA1B2C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 10:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B40F167DC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 09:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FF521A45E;
	Fri, 24 Jan 2025 09:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayliuE46"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A20B23A0;
	Fri, 24 Jan 2025 09:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737711537; cv=none; b=Tc9XlAE05WVM8dCsWzlDV+laCUN6wxrOj3zyCokVyYsNuPJHJRZjDYvo+ty5Ix6VSoj6KwLbJDrsEyYvFK0c+GoX/A4TiwuAe47y7qcUI/pkb0nAH+Gv9IxbP8MqIL6Qfp7GCD9V4JSm2a7cePJBVWdPHJH8cfC4Mz/d2qDnQKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737711537; c=relaxed/simple;
	bh=w44kYJhywS4/lsXTR5UrbeYOFe3r10lL99Jo0jLdLfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIYjvBHGyMSCSG4RZChMQGuOBVEs15pZ6vwMv9DHYZytk38o2rWPOA3EWhN3hfoK85YTCMdlbJNf2gK0GYJp062vNZwPtpHn84xn9PoO8F9qNqTzfAR/WmeP8VWWIG4hyJPH0pPJCGI9yPYIGME6UOBDQHbDwxOEZJDZcoCI9zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayliuE46; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457A3C4CED2;
	Fri, 24 Jan 2025 09:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737711537;
	bh=w44kYJhywS4/lsXTR5UrbeYOFe3r10lL99Jo0jLdLfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ayliuE46c+pkA4cw/TgHsouqsiEEftspfVob2Dh8Wegh2NNJYvDxDdtPFFGPCk1SL
	 wVz11BKwjOmQosW5Wiuu9R1o3TjWJr0wJzKw3yXcKAfDIn7AXvUqd0xA7hBA3xkmB1
	 elwLMw5LFGUT1J3V+wEP9YSG6JC026hgc+mxvGqMhh7VAKlx+G9zArV2z/9aGMNgC5
	 /LpuJgfjXXybVjwXzMcNn3T2HEK8YLRRQdYFVfkQAbg0F6EK0cin0cRyIMO84/MweJ
	 uFmXVnjrznA+vcqwwKQ9HkhflSfy9CewFL1iCe7pN8V2soL1uANnpB1ewIglfqLK4I
	 gUbupDqLGAarQ==
Date: Fri, 24 Jan 2025 10:38:49 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-mm@kvack.org, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org, peterz@infradead.org, 
	mingo@kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, shakeel.butt@linux.dev, rppt@kernel.org, liam.howlett@oracle.com, 
	Jann Horn <jannh@google.com>, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] mm,procfs: allow read-only remote mm access under
 CAP_PERFMON
Message-ID: <20250124-hermachen-truthahn-f0ba886b6ae7@brauner>
References: <20250123214342.4145818-1-andrii@kernel.org>
 <CAJuCfpE9QOo-xmDpk_FF=gs3p=9Zzb-Q5yDaKAEChBCnpogmQg@mail.gmail.com>
 <202501231526.A3C13EC5@keescook>
 <CAEf4BzbYBw3kzWyyG42VZSKh8MX+Xfqa1B_TRRN4p35_C9xZmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbYBw3kzWyyG42VZSKh8MX+Xfqa1B_TRRN4p35_C9xZmw@mail.gmail.com>

On Thu, Jan 23, 2025 at 04:59:38PM -0800, Andrii Nakryiko wrote:
> On Thu, Jan 23, 2025 at 3:47 PM Kees Cook <kees@kernel.org> wrote:
> >
> > On Thu, Jan 23, 2025 at 01:52:52PM -0800, Suren Baghdasaryan wrote:
> > > On Thu, Jan 23, 2025 at 1:44 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> > > >
> > > > It's very common for various tracing and profiling toolis to need to
> > > > access /proc/PID/maps contents for stack symbolization needs to learn
> > > > which shared libraries are mapped in memory, at which file offset, etc.
> > > > Currently, access to /proc/PID/maps requires CAP_SYS_PTRACE (unless we
> > > > are looking at data for our own process, which is a trivial case not too
> > > > relevant for profilers use cases).
> > > >
> > > > Unfortunately, CAP_SYS_PTRACE implies way more than just ability to
> > > > discover memory layout of another process: it allows to fully control
> > > > arbitrary other processes. This is problematic from security POV for
> > > > applications that only need read-only /proc/PID/maps (and other similar
> > > > read-only data) access, and in large production settings CAP_SYS_PTRACE
> > > > is frowned upon even for the system-wide profilers.
> > > >
> > > > On the other hand, it's already possible to access similar kind of
> > > > information (and more) with just CAP_PERFMON capability. E.g., setting
> > > > up PERF_RECORD_MMAP collection through perf_event_open() would give one
> > > > similar information to what /proc/PID/maps provides.
> > > >
> > > > CAP_PERFMON, together with CAP_BPF, is already a very common combination
> > > > for system-wide profiling and observability application. As such, it's
> > > > reasonable and convenient to be able to access /proc/PID/maps with
> > > > CAP_PERFMON capabilities instead of CAP_SYS_PTRACE.
> > > >
> > > > For procfs, these permissions are checked through common mm_access()
> > > > helper, and so we augment that with cap_perfmon() check *only* if
> > > > requested mode is PTRACE_MODE_READ. I.e., PTRACE_MODE_ATTACH wouldn't be
> > > > permitted by CAP_PERFMON.
> > > >
> > > > Besides procfs itself, mm_access() is used by process_madvise() and
> > > > process_vm_{readv,writev}() syscalls. The former one uses
> > > > PTRACE_MODE_READ to avoid leaking ASLR metadata, and as such CAP_PERFMON
> > > > seems like a meaningful allowable capability as well.
> > > >
> > > > process_vm_{readv,writev} currently assume PTRACE_MODE_ATTACH level of
> > > > permissions (though for readv PTRACE_MODE_READ seems more reasonable,
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
> > > > @@ -1547,6 +1547,15 @@ struct mm_struct *get_task_mm(struct task_struct *task)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(get_task_mm);
> > > >
> > > > +static bool can_access_mm(struct mm_struct *mm, struct task_struct *task, unsigned int mode)
> > > > +{
> > > > +       if (mm == current->mm)
> > > > +               return true;
> > > > +       if ((mode & PTRACE_MODE_READ) && perfmon_capable())
> > > > +               return true;
> > > > +       return ptrace_may_access(task, mode);
> > > > +}
> >
> > nit: "may" tends to be used more than "can" for access check function naming.
> 
> good point, will change to "may"
> 
> >
> > So, this will bypass security_ptrace_access_check() within
> > ptrace_may_access(). CAP_PERFMON may be something LSMs want visibility
> > into.
> 
> yeah, similar to perf's perf_check_permission() (though, admittedly,
> perf has its own security_perf_event_open(&attr, PERF_SECURITY_OPEN)
> check much earlier in perf_event_open() logic)
> 
> >
> > It also bypasses the dumpability check in __ptrace_may_access(). (Should
> > non-dumpability block visibility into "maps" under CAP_PERFMON?)
> 
> With perf_event_open() and PERF_RECORD_MMAP none of this dumpability
> is honored today as well, so I think CAP_PERFMON should override all
> these ptrace things here, no?
> 
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
> > and auxv maybe too much also. The "attr" files seem iffy. pagemap may be
> > reasonable.
> 
> As Shakeel pointed out, /proc/PID/mem is PTRACE_MODE_ATTACH, so won't
> be permitted under CAP_PERFMON either.
> 
> Don't really know what auxv is, but I could read all that with BPF if
> I had CAP_PERFMON, for any task, so not like we are opening up new
> possibilities here.
> 
> >
> > Gaining CAP_PERFMON access to *only* the "maps" file doesn't seem too
> > bad to me, but I think the proposed patch ends up providing way too wide
> > access to other things.
> 
> I do care about maps mostly, yes, but I also wanted to avoid
> duplicating all that mm_access() logic just for maps (and probably
> smaps, they are the same data). But again, CAP_PERFMON basically means
> read-only tracing access to anything within kernel and any user
> process, so it felt appropriate to allow CAP_PERFMON here.
> 
> >
> > Also, this is doing an init-namespace capability check for
> > CAP_PERFMON (via perfmon_capable()). Shouldn't this be per-namespace?
> 
> CAP_PERFMON isn't namespaced as far as perf_event_open() is concerned,
> so at least for that reason I don't want to relax the requirement
> here. Namespacing CAP_PERFMON in general is interesting and I bet
> there are users that would appreciate that, but that's an entire epic
> journey we probably don't want to start here.

Agreed.

