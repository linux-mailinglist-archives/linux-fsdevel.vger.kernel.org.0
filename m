Return-Path: <linux-fsdevel+bounces-13995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBB8876239
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 11:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7485D283EAA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 10:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9425155C2D;
	Fri,  8 Mar 2024 10:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWV6sPna"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E133A53391;
	Fri,  8 Mar 2024 10:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709894166; cv=none; b=i73Y2jeko0AJYgjzLTdtGR+5tXHKdVGdjEPOm2mhoTS/s3R9F+e6hh0SsloY1hV1IqaNEPLKrexN0Dw1CA16cBCXuNpHOwhaBMZWEjPU8217r7O/Ka/U6SnFBWGlnYDgihEEgWFEKY0Sf50rp7HKa0vEJ6skYAxgqNBWOi+dhTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709894166; c=relaxed/simple;
	bh=QkVpUYeV3CtNb7O8+udH/aZB4OwfinzkvvEEuTNnMFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+rM313RBX7my92R0pBLnMS/h3tgA77tAJpkjtg5WAMX9vHi95G9HyrQ8I9bcDGzK8Ek5haxVGE+lW0cRTmgYNDHg8H14hPOvc8IDB1hHRTs4LygPhlS0dkfqh8qoJlKdbDnOBZ5WMrMNKPHRGunAupBq8gQ7Sr/rmgIrH6EqZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWV6sPna; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E63C433F1;
	Fri,  8 Mar 2024 10:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709894165;
	bh=QkVpUYeV3CtNb7O8+udH/aZB4OwfinzkvvEEuTNnMFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LWV6sPnaWP9YplC1t/94tZ0sy+b7KIBGbPH7SZg7w22R3lrl43cvJu+W0zOigCh/P
	 I92ydODnQMf1mYrgkxTwXgQenW748JseAHzrawivMp4Vjm51Da8xToKCz3CWZA3lcc
	 7C6FhA6xiosVjYQIjGghK3t8ZafGyl4Zo+0wPyzavJr/bZQAW16L62A2I2YFGLyB10
	 k6XsMFxdvsG2NGZSMHqG38TjUxDw1NKxHpsBaJJViirMn6+z+CKhzDhUY7B03lfl+9
	 1bFiRYxoOOI3fLPcIrNHQuGmV6J6n52Yu7ECxmB8CNj7AyKhc7LnIoA2wDvxUk0KtU
	 0fyy0HRt/jeGw==
Date: Fri, 8 Mar 2024 11:35:59 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Matt Bobrowski <mattbobrowski@google.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	KP Singh <kpsingh@google.com>, Jann Horn <jannh@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm <linux-mm@kvack.org>, LSM List <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next 0/9] add new acquire/release BPF kfuncs
Message-ID: <20240308-kleben-eindecken-73c993fb3ebd@brauner>
References: <cover.1709675979.git.mattbobrowski@google.com>
 <20240306-flach-tragbar-b2b3c531bf0d@brauner>
 <20240306-sandgrube-flora-a61409c2f10c@brauner>
 <CAADnVQ+RBV_rJx5LCtCiW-TWZ5DCOPz1V3ga_fc__RmL_6xgOg@mail.gmail.com>
 <20240307-phosphor-entnahmen-8ef28b782abf@brauner>
 <CAADnVQLMHdL1GfScnG8=0wL6PEC=ACZT3xuuRFrzNJqHKrYvsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLMHdL1GfScnG8=0wL6PEC=ACZT3xuuRFrzNJqHKrYvsw@mail.gmail.com>

On Thu, Mar 07, 2024 at 07:11:22PM -0800, Alexei Starovoitov wrote:
> On Thu, Mar 7, 2024 at 1:55 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > > >
> > > > So, looking at this series you're now asking us to expose:
> > > >
> > > > (1) mmgrab()
> > > > (2) mmput()
> > > > (3) fput()
> > > > (5) get_mm_exe_file()
> > > > (4) get_task_exe_file()
> > > > (7) get_task_fs_pwd()
> > > > (6) get_task_fs_root()
> > > > (8) path_get()
> > > > (9) path_put()
> > > >
> > > > in one go and the justification in all patches amounts to "This is
> > > > common in some BPF LSM programs".
> > > >
> > > > So, broken stuff got exposed to users or at least a broken BPF LSM
> > > > program was written somewhere out there that is susceptible to UAFs
> > > > becauase you didn't restrict bpf_d_path() to trusted pointer arguments.
> > > > So you're now scrambling to fix this by asking for a bunch of low-level
> > > > exports.
> > > >
> > > > What is the guarantee that you don't end up writing another BPF LSM that
> > > > abuses these exports in a way that causes even more issues and then
> > > > someone else comes back asking for the next round of bpf funcs to be
> > > > exposed to fix it.
> > >
> > > There is no guarantee.
> > > We made a safety mistake with bpf_d_path() though
> > > we restricted it very tight. And that UAF is tricky.
> > > I'm still amazed how Jann managed to find it.
> > > We all make mistakes.
> > > It's not the first one and not going to be the last.
> > >
> > > What Matt is doing is an honest effort to fix it
> > > in the upstream kernel for all bpf users to benefit.
> > > He could have done it with a kernel module.
> > > The above "low level" helpers are all either static inline
> > > in .h or they call EXPORT_SYMBOL[_GPL] or simply inc/dec refcnt.
> > >
> > > One can implement such kfuncs in an out of tree kernel module
> > > and be done with it, but in the bpf community we encourage
> > > everyone to upstream their work.
> > >
> > > So kudos to Matt for working on these patches.
> > >
> > > His bpf-lsm use case is not special.
> > > It just needs a safe way to call d_path.
> > >
> > > +SEC("lsm.s/file_open")
> > > +__failure __msg("R1 must be referenced or trusted")
> > > +int BPF_PROG(path_d_path_kfunc_untrusted_from_current)
> > > +{
> > > +       struct path *pwd;
> > > +       struct task_struct *current;
> > > +
> > > +       current = bpf_get_current_task_btf();
> > > +       /* Walking a trusted pointer returned from bpf_get_current_task_btf()
> > > +        * yields and untrusted pointer. */
> > > +       pwd = &current->fs->pwd;
> > > +       bpf_path_d_path(pwd, buf, sizeof(buf));
> > > +       return 0;
> > > +}
> > >
> > > This test checks that such an access pattern is unsafe and
> > > the verifier will catch it.
> > >
> > > To make it safe one needs to do:
> > >
> > >   current = bpf_get_current_task_btf();
> > >   pwd = bpf_get_task_fs_pwd(current);
> > >   if (!pwd) // error path
> > >   bpf_path_d_path(pwd, ...);
> > >   bpf_put_path(pwd);
> > >
> > > these are the kfuncs from patch 6.
> > >
> > > And notice that they have KF_ACQUIRE and KF_RELEASE flags.
> > >
> > > They tell the verifier to recognize that bpf_get_task_fs_pwd()
> > > kfunc acquires 'struct path *'.
> > > Meaning that bpf prog cannot just return without releasing it.
> > >
> > > The bpf prog cannot use-after-free that 'pwd' either
> > > after it was released by bpf_put_path(pwd).
> > >
> > > The verifier static analysis catches such UAF-s.
> > > It didn't catch Jann's UAF earlier, because we didn't have
> > > these kfuncs! Hence the fix is to add such kfuncs with
> > > acquire/release semantics.
> > >
> > > > The difference between a regular LSM asking about this and a BPF LSM
> > > > program is that we can see in the hook implementation what the LSM
> > > > intends to do with this and we can judge whether that's safe or not.
> > >
> > > See above example.
> > > The verifier is doing a much better job than humans when it comes
> > > to safety.
> > >
> > > > Here you're asking us to do this blindfolded.
> > >
> > > If you don't trust the verifier to enforce safety,
> > > you shouldn't trust Rust compiler to generate safe code either.
> > >
> > > In another reply you've compared kfuncs to EXPORT_SYMBOL_GPL.
> > > Such analogy is correct to some extent,
> > > but unlike exported symbols kfuncs are restricted to particular
> > > program types. They don't accept arbitrary pointers,
> > > and reference count is enforced as well.
> > > That's a pretty big difference vs EXPORT_SYMBOL.
> >
> > There's one fundamental question here that we'll need an official answer to:
> >
> > Is it ok for an out-of-tree BPF LSM program, that nobody has ever seen
> > to request access to various helpers in the kernel?
> 
> obviously not.
> 
> > Because fundamentally this is what this patchset is asking to be done.
> 
> Pardon ?
> 
> > If the ZFS out-of-tree kernel module were to send us a similar patch
> > series asking us for a list of 9 functions that they'd like us to export
> > what would the answer to that be?
> 
> This patch set doesn't request any new EXPORT_SYMBOL.

In order for that out-of-tree BPF LSM program to get similar guarantees
than an equivalent kernel module we need to export all nine functions
for BPF. Included in that set are functions that aren't currently even
exported to modules.

These exports are specifically for an out-of-tree BPF LSM program that
is not accessible to the public. The question in the other mail stands.

> First of all, there is no such thing as get_task_fs_pwd/root
> in the kernel.

Yeah, we'd need specific helpers for a never seen before out-of-tree BPF
LSM. I don't see how that's different from an out-of-tree kernel module.

> One can argue that get_mm_exe_file() is not exported,
> but it's nothing but rcu_lock-wrap plus get_file_rcu()
> which is EXPORT_SYMBOL.

Oh, good spot. That's an accident. get_file_rcu() definitely shouldn't
be exported. So that'll be removed asap.

> Christian,
> 
> I understand your irritation with anything bpf related
> due to our mistake with fd=0, but as I said earlier it was
> an honest mistake. There was no malicious intent.
> Time to move on.

I understand your concern but I'm neither irritated by bpf nor do I hold
grudges. As I'm writing this bpf's bpffs and token changes are on their
way into mainline for v6.9 which I reviewed and acked immediately after
that discussion.

Rest assures that you can move on from that concern. There's no need to
keep bringing it up in unrelated discussions.

