Return-Path: <linux-fsdevel+bounces-14741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A03D87EA07
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 14:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8CC1B21317
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 13:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276A948CFD;
	Mon, 18 Mar 2024 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2mHGKNt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7915F4CB30;
	Mon, 18 Mar 2024 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710768265; cv=none; b=kXG3S4hPy0pF68+DiM1Aw7cstndKmN0MO+0IWfP5VOZHDlkJrDjf2UFXrOOY2Vgf+e2VqfngxmBl19aN1jgumY+26dxf4HyCdgFs1mPh9+6u0RWheVG9LgrwVXwFUxW5Oa9Gs1cTccgz5MyUi4AWgBDe9IYmmjgYDKBYBdpBdHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710768265; c=relaxed/simple;
	bh=twSoeLbz1uUYCDjFLEbD4Hw80Ek0KP0899uymbExspE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTodeN1xhgYRETk0/EP2uIMJvKmlgEaADsa7m4KzdPeIw566hvMLc/VY1RoliRC4uqIUXgtL/K+Y2KAd18VRZ6f/6p6h8Vr5FHw1FIWDW7hyq5sBEN5yKJ4HOjYYVk920DS4whvk64fnytyLNNKkCR82J+8hYt9ZyIlLNWHy0J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2mHGKNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2675DC43394;
	Mon, 18 Mar 2024 13:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710768265;
	bh=twSoeLbz1uUYCDjFLEbD4Hw80Ek0KP0899uymbExspE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q2mHGKNt/EOyoZSOaA7XN5EETdDtuRfGnr/KWyUFAcK+Ws8T1gO/u4j4euwl9D+I7
	 JUIngsuY0PD0ZD+HV0+//87a0dUxX/aeFBr5wCfP5ujk/DIjjsJoLXCpdoQuPn7fqL
	 wzLk9wV3RwDZCiLAV2JjZIBkBlsw4zVzxEBiCkBE3E71atEAQOYIyufQt6mO6ngZ65
	 Rs/CXwBClpJkDsVoAvX0HdyDkDvRpZ2uo7EJ4yyao1gvHq1bmHu4x8PukLzVDcjcsX
	 TncGN/jAIH5wxQcjGni8yEDKvgOCAS5sfzokFNDpQlN8/cEQIuC3lCrG4apAKx0UQP
	 tbk3XvjgV3C/Q==
Date: Mon, 18 Mar 2024 14:24:18 +0100
From: Christian Brauner <brauner@kernel.org>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@google.com>, Jann Horn <jannh@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, 
	LSM List <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next 0/9] add new acquire/release BPF kfuncs
Message-ID: <20240318-freifahrt-perfide-e99eb9c1f4ec@brauner>
References: <cover.1709675979.git.mattbobrowski@google.com>
 <20240306-flach-tragbar-b2b3c531bf0d@brauner>
 <20240306-sandgrube-flora-a61409c2f10c@brauner>
 <CAADnVQ+RBV_rJx5LCtCiW-TWZ5DCOPz1V3ga_fc__RmL_6xgOg@mail.gmail.com>
 <20240307-phosphor-entnahmen-8ef28b782abf@brauner>
 <CAADnVQLMHdL1GfScnG8=0wL6PEC=ACZT3xuuRFrzNJqHKrYvsw@mail.gmail.com>
 <20240308-kleben-eindecken-73c993fb3ebd@brauner>
 <CAADnVQJVNntnH=DLHwUioe9mEw0FzzdUvmtj3yx8SjL38daeXQ@mail.gmail.com>
 <20240311-geglaubt-kursverfall-500a27578cca@brauner>
 <ZfCLnOBDnBp2wcJy@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfCLnOBDnBp2wcJy@google.com>

On Tue, Mar 12, 2024 at 05:06:36PM +0000, Matt Bobrowski wrote:
> Hey Christian,
> 
> On Mon, Mar 11, 2024 at 01:00:56PM +0100, Christian Brauner wrote:
> > On Fri, Mar 08, 2024 at 05:23:30PM -0800, Alexei Starovoitov wrote:
> > > On Fri, Mar 8, 2024 at 2:36 AM Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > >
> > > > These exports are specifically for an out-of-tree BPF LSM program that
> > > > is not accessible to the public. The question in the other mail stands.
> > > 
> > > The question was already answered. You just don't like the answer.
> > > bpf progs are not equivalent to kernel modules.
> > > They have completely different safety and visibility properties.
> > > The safety part I already talked about.
> > > Sounds like the visibility has to be explained.
> > > Kernel modules are opaque binary blobs.
> > > bpf programs are fully transparent. The intent is known
> > > to the verifier and to anyone with understanding
> > > of bpf assembly.
> > > Those that cannot read bpf asm can read C source code that is
> > > embedded in the bpf program in kernel memory.
> > > It's not the same as "llvm-dwarfdump module.ko" on disk.
> > > The bpf prog source code is loaded into the kernel
> > > at program verification time for debugging and visibility reasons.
> > > If there is a verifier bug and bpf manages to crash the kernel
> > > vmcore will have relevant lines of program C source code right there.
> > > 
> > > Hence out-of-tree or in-tree bpf makes no practical difference.
> > > The program cannot hide its meaning and doesn't hamper debugging.
> > > 
> > > Hence adding EXPORT_SYMBOL == Brace for impact!
> > > Expect crashes, api misuse and what not.
> > > 
> > > While adding bpf_kfunc is a nop for kernel development.
> > > If kfunc is in the way of code refactoring it can be removed
> > > (as we demonstrated several times).
> > > A kfunc won't cause headaches for the kernel code it is
> > > calling (assuming no verifier bugs).
> > > If there is a bug it's on us to fix it as we demonstrated in the past.
> > > For example: bpf_probe_read_kernel().
> > > It's a wrapper of copy_from_kernel_nofault() and over the years
> > > bpf users hit various bugs in copy_from_kernel_nofault(),
> > > reported them, and _bpf developers_ fixed them.
> > > Though copy_from_kernel_nofault() is as generic as it can get
> > > and the same bugs could have been reproduced without bpf
> > > we took care of fixing these parts of the kernel.
> > > 
> > > Look at path_put().
> > > It's EXPORT_SYMBOL and any kernel module can easily screw up
> > > reference counting, so that sooner or later distro folks
> > > will experience debug pains due to out-of-tree drivers.
> > > 
> > > kfunc that calls path_put() won't have such consequences.
> > > The verifier will prevent path_put() on a pointer that wasn't
> > > acquired by the same bpf program. No support pains.
> > > It's a nop for vfs folks.
> > > 
> > > > > First of all, there is no such thing as get_task_fs_pwd/root
> > > > > in the kernel.
> > > >
> > > > Yeah, we'd need specific helpers for a never seen before out-of-tree BPF
> > > > LSM. I don't see how that's different from an out-of-tree kernel module.
> > > 
> > > Sorry, but you don't seem to understand what bpf can and cannot do,
> > > hence they look similar.
> > 
> > Maybe. On the other hand you seem to ignore what I'm saying. You
> > currently don't have a clear set of rules for when it's ok for someone
> > to send patches and request access to bpf kfuncs to implement a new BPF
> > program. This patchset very much illustrates this point. The safety
> > properties of bpf don't matter for this. And again, your safety
> > properties very much didn't protect you from your bpf_d_path() mess.
> > 
> > We're not even clearly told where and how these helper are supposed to be
> > used. That's not ok and will never be ok. As long as there are no clear
> > criteria to operate under this is highly problematic. This may be fine
> > from a bpf perspective and one can even understand why because that's
> > apparently your model or promise to your users. But there's no reason to
> > expect the same level of laxness from any of the subsystems you're
> > requesting kfuncs from.
> 
> You raise a completely fair point, and I truly do apologies for the
> lack of context and in depth explanations around the specific
> situations that the proposed BPF kfuncs are intended to be used
> from. Admittedly, that's a failure on my part, and I can completely
> understand why from a maintainers point of view there would be
> reservations around acknowledging requests for adding such invisible
> dependencies.

Thanks for providing more background.

> Now, I'm in a little bit of a tough situation as I'm unable to point
> you to an open-source BPF LSM implementation that intends to make use
> of such newly proposed BPF kfuncs. That's just an unfortunate
> constraint and circumstance that I'm having to deal with, so I'm just
> going to have to provide heavily redacted and incomplete example to
> illustrate how these BPF kfuncs intend to be used from BPF LSM
> programs that I personally work on here at Google. Notably though, the
> contexts that I do share here may obviously be a nonholistic view on
> how these newly introduced BPF kfuncs end up getting used in practice
> by some other completely arbitrary open-source BPF LSM programs.

I have to say that this to me is wild. Essentially we're supposed to
allow access to our internal APIs based on internal use-cases that
aren't public and likely never will be.

If that's acceptable then I want bpf to document this in their kernel
Documentation and submit this for review to the wider community.

