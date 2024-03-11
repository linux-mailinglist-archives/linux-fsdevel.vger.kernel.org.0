Return-Path: <linux-fsdevel+bounces-14121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4E0877F6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 13:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65D541F22666
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 12:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6D53BBFF;
	Mon, 11 Mar 2024 12:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erF5UkB7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ED03CF79;
	Mon, 11 Mar 2024 12:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710158463; cv=none; b=pd6O0ORoY8ti1Ea80OM82+m027NGtm7x8pmul7vRWJE/tUC9ooJZ7flBxQcXGc6mfH6gbcoArlRSccIBgOhvDBW3EM9/bQZ0/RQD6GMfBq/9R/lUC/CrwYqkQn9jrmhZKQRK3J6rMpTRm43jWmwYIwrsvWnW6c0Tnt/74mK5fzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710158463; c=relaxed/simple;
	bh=fT5zINPY9j/8xLkIBxSYOgCQjvdqeRAhMKCybJ05TQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iARCfzMdl84Ed6bmmhdngXaXK8XN7C+vtuFqzqai7BhX/aIRcRkAVz1AnkMyQ6wLr342+JQfz5AVqsJaK68dLluXS1NGmXmmrNyrDcLzpFCYKSefs3M/XDriWhNZiZq/sZporTZVlexzow31L5xBVjoeugINQZgVeKFRlYV7IbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erF5UkB7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF54C43390;
	Mon, 11 Mar 2024 12:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710158463;
	bh=fT5zINPY9j/8xLkIBxSYOgCQjvdqeRAhMKCybJ05TQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=erF5UkB7mbXC3562nUyPVTqJMF6nrNRiMFVstjWEDCm8BoLWdWRnY15085Kr4AWXs
	 RMRE2RcTXhaF4b3PKCFbThEJuUphxCndNv4Jt7r1SXhXgNXafDw5EUeOb5dDCoBxFS
	 2BoWl2yKaeWu3ITC/CROdG20SP339bnnMIg/rNR6neR2l5Bj5ZX+70hc4VfHAGGHi3
	 4C+rHM7m6du+r5xCVRn2v7d+XYtqs9WQi4QsgBb3xhkxxSOkIFD/prTzbybt1uwW+R
	 AOapPaKus5E12gzrRl7LuL8ZAtHLtzlZlJ43/U1AF2K8aS/Nn+eM6sKizMGaAUz9Cm
	 v9CfC2TdBzOQg==
Date: Mon, 11 Mar 2024 13:00:56 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Matt Bobrowski <mattbobrowski@google.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	KP Singh <kpsingh@google.com>, Jann Horn <jannh@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm <linux-mm@kvack.org>, LSM List <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next 0/9] add new acquire/release BPF kfuncs
Message-ID: <20240311-geglaubt-kursverfall-500a27578cca@brauner>
References: <cover.1709675979.git.mattbobrowski@google.com>
 <20240306-flach-tragbar-b2b3c531bf0d@brauner>
 <20240306-sandgrube-flora-a61409c2f10c@brauner>
 <CAADnVQ+RBV_rJx5LCtCiW-TWZ5DCOPz1V3ga_fc__RmL_6xgOg@mail.gmail.com>
 <20240307-phosphor-entnahmen-8ef28b782abf@brauner>
 <CAADnVQLMHdL1GfScnG8=0wL6PEC=ACZT3xuuRFrzNJqHKrYvsw@mail.gmail.com>
 <20240308-kleben-eindecken-73c993fb3ebd@brauner>
 <CAADnVQJVNntnH=DLHwUioe9mEw0FzzdUvmtj3yx8SjL38daeXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJVNntnH=DLHwUioe9mEw0FzzdUvmtj3yx8SjL38daeXQ@mail.gmail.com>

On Fri, Mar 08, 2024 at 05:23:30PM -0800, Alexei Starovoitov wrote:
> On Fri, Mar 8, 2024 at 2:36 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> >
> > These exports are specifically for an out-of-tree BPF LSM program that
> > is not accessible to the public. The question in the other mail stands.
> 
> The question was already answered. You just don't like the answer.
> bpf progs are not equivalent to kernel modules.
> They have completely different safety and visibility properties.
> The safety part I already talked about.
> Sounds like the visibility has to be explained.
> Kernel modules are opaque binary blobs.
> bpf programs are fully transparent. The intent is known
> to the verifier and to anyone with understanding
> of bpf assembly.
> Those that cannot read bpf asm can read C source code that is
> embedded in the bpf program in kernel memory.
> It's not the same as "llvm-dwarfdump module.ko" on disk.
> The bpf prog source code is loaded into the kernel
> at program verification time for debugging and visibility reasons.
> If there is a verifier bug and bpf manages to crash the kernel
> vmcore will have relevant lines of program C source code right there.
> 
> Hence out-of-tree or in-tree bpf makes no practical difference.
> The program cannot hide its meaning and doesn't hamper debugging.
> 
> Hence adding EXPORT_SYMBOL == Brace for impact!
> Expect crashes, api misuse and what not.
> 
> While adding bpf_kfunc is a nop for kernel development.
> If kfunc is in the way of code refactoring it can be removed
> (as we demonstrated several times).
> A kfunc won't cause headaches for the kernel code it is
> calling (assuming no verifier bugs).
> If there is a bug it's on us to fix it as we demonstrated in the past.
> For example: bpf_probe_read_kernel().
> It's a wrapper of copy_from_kernel_nofault() and over the years
> bpf users hit various bugs in copy_from_kernel_nofault(),
> reported them, and _bpf developers_ fixed them.
> Though copy_from_kernel_nofault() is as generic as it can get
> and the same bugs could have been reproduced without bpf
> we took care of fixing these parts of the kernel.
> 
> Look at path_put().
> It's EXPORT_SYMBOL and any kernel module can easily screw up
> reference counting, so that sooner or later distro folks
> will experience debug pains due to out-of-tree drivers.
> 
> kfunc that calls path_put() won't have such consequences.
> The verifier will prevent path_put() on a pointer that wasn't
> acquired by the same bpf program. No support pains.
> It's a nop for vfs folks.
> 
> > > First of all, there is no such thing as get_task_fs_pwd/root
> > > in the kernel.
> >
> > Yeah, we'd need specific helpers for a never seen before out-of-tree BPF
> > LSM. I don't see how that's different from an out-of-tree kernel module.
> 
> Sorry, but you don't seem to understand what bpf can and cannot do,
> hence they look similar.

Maybe. On the other hand you seem to ignore what I'm saying. You
currently don't have a clear set of rules for when it's ok for someone
to send patches and request access to bpf kfuncs to implement a new BPF
program. This patchset very much illustrates this point. The safety
properties of bpf don't matter for this. And again, your safety
properties very much didn't protect you from your bpf_d_path() mess.

We're not even clearly told where and how these helper are supposed to be
used. That's not ok and will never be ok. As long as there are no clear
criteria to operate under this is highly problematic. This may be fine
from a bpf perspective and one can even understand why because that's
apparently your model or promise to your users. But there's no reason to
expect the same level of laxness from any of the subsystems you're
requesting kfuncs from.

> > > One can argue that get_mm_exe_file() is not exported,
> > > but it's nothing but rcu_lock-wrap plus get_file_rcu()
> > > which is EXPORT_SYMBOL.
> >
> > Oh, good spot. That's an accident. get_file_rcu() definitely shouldn't
> > be exported. So that'll be removed asap.
> 
> So, just to make a point that
> "Included in that set are functions that aren't currently even
> exported to modules"
> you want to un-export get_file_rcu() ?

No. The reason it was exported was because of the drm subsystem and we
already quite disliked that. But it turned out that's not needed so in
commit 61d4fb0b349e ("file, i915: fix file reference for
mmap_singleton()") they were moved away from this helper.

And then we simply forgot to unexport it.

A helper such as get_file_rcu() is called on a file object that is
subject to SLAB_TYPESAFE_BY_RCU semantics where the caller doesn't hold
a reference. The semantics of that are maybe understood by a couple of
people in the kernel. There is absolutely no way that any userspace will
get access to such low-level helpers. They have zero business to be
involved in the lifetimes of objects on this level just as no module has.

So really, this is an orthogonal cleanup.

