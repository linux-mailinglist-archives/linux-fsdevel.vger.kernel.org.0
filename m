Return-Path: <linux-fsdevel+bounces-13851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6D6874B63
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 10:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A92122824CF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 09:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21C884FDA;
	Thu,  7 Mar 2024 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfU6llXD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CDD83A06;
	Thu,  7 Mar 2024 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805307; cv=none; b=CpLp0MYyWjZfQ0B7VmuWEO9wH0DaadSj3BHED7bva6MpToxhirkDo+XVO6MeN+vBDxc0R+wjxodQ9yeWCDgbAOARXYEDz3ybdL3HpYlcvayB0TP5y4d6K3cahid8pW99iaVeXUmWl6Fw1p1S+mO32M7PJPXJtKTWj+tbCIHSkhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805307; c=relaxed/simple;
	bh=waOE1njY/F7aQaiRNvi/NeLmKaSlbwk7wKg6U4Ol4KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5JmhYhPWJ/Dv9kKQT3NZZ1AmZVO8V5wHLajA44PDpSV8Ajp5oE/6b2t4EtWnZ45zkPz5qGLYlMHhiR86RMOWgx63lQxPbcwmvwckT+yXnLSg87CGYt/Fe15MTJ8m1yPo2ua87l3ZiRAt7k3VtB/aIq/kgRv2J7uJo9tyT43LDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfU6llXD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A350AC433C7;
	Thu,  7 Mar 2024 09:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709805306;
	bh=waOE1njY/F7aQaiRNvi/NeLmKaSlbwk7wKg6U4Ol4KY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tfU6llXDV5qArtzC5ad5GiKUCwyCceItgZ9ukA928c6W4MUUm72FNcub5NfeobyMG
	 DA8kYfhZvaKV4V+1Y8srVhwKRoVmbSemOcP3/wOGJFus2cPdc3GaS8FxBSW7qIf6IZ
	 x0mLAu8wSuOrGYBvi57IVNshKOB4CMpjHZ/A+rIM9aRdWK08qFOhNmD3XPtVt9+QG+
	 29jZ194rK4NuqnuPld4F7rTyoKbSCjjqga1JUFhUMAZ4qjTaLfJjqyc6b5m4Dje4zC
	 zCmI0ibdRKS0MVysL2TtY5c26YEZT7tdF/WgqyreiJFKYWHWtCMkKsDS7uggRJM5sB
	 7qvIXSdJHbV8Q==
Date: Thu, 7 Mar 2024 10:54:59 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Matt Bobrowski <mattbobrowski@google.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	KP Singh <kpsingh@google.com>, Jann Horn <jannh@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm <linux-mm@kvack.org>, LSM List <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next 0/9] add new acquire/release BPF kfuncs
Message-ID: <20240307-phosphor-entnahmen-8ef28b782abf@brauner>
References: <cover.1709675979.git.mattbobrowski@google.com>
 <20240306-flach-tragbar-b2b3c531bf0d@brauner>
 <20240306-sandgrube-flora-a61409c2f10c@brauner>
 <CAADnVQ+RBV_rJx5LCtCiW-TWZ5DCOPz1V3ga_fc__RmL_6xgOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+RBV_rJx5LCtCiW-TWZ5DCOPz1V3ga_fc__RmL_6xgOg@mail.gmail.com>

On Wed, Mar 06, 2024 at 08:05:05PM -0800, Alexei Starovoitov wrote:
> On Wed, Mar 6, 2024 at 4:13 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Wed, Mar 06, 2024 at 12:21:28PM +0100, Christian Brauner wrote:
> > > On Wed, Mar 06, 2024 at 07:39:14AM +0000, Matt Bobrowski wrote:
> > > > G'day All,
> > > >
> > > > The original cover letter providing background context and motivating
> > > > factors around the needs for the BPF kfuncs introduced within this
> > > > patch series can be found here [0], so please do reference that if
> > > > need be.
> > > >
> > > > Notably, one of the main contention points within v1 of this patch
> > > > series was that we were effectively leaning on some preexisting
> > > > in-kernel APIs such as get_task_exe_file() and get_mm_exe_file()
> > > > within some of the newly introduced BPF kfuncs. As noted in my
> > > > response here [1] though, I struggle to understand the technical
> > > > reasoning behind why exposing such in-kernel helpers, specifically
> > > > only to BPF LSM program types in the form of BPF kfuncs, is inherently
> > > > a terrible idea. So, until someone provides me with a sound technical
> > > > explanation as to why this cannot or should not be done, I'll continue
> > > > to lean on them. The alternative is to reimplement the necessary
> > > > in-kernel APIs within the BPF kfuncs, but that's just nonsensical IMO.
> > >
> > > You may lean as much as you like. What I've reacted to is that you've
> > > (not you specifically, I'm sure) messed up. You've exposed d_path() to
> > > users  without understanding that it wasn't safe apparently.
> > >
> > > And now we get patches that use the self-inflicted brokeness as an
> > > argument to expose a bunch of other low-level helpers to fix that.
> > >
> > > The fact that it's "just bpf LSM" programs doesn't alleviate any
> > > concerns whatsoever. Not just because that is just an entry vector but
> > > also because we have LSMs induced API abuse that we only ever get to see
> > > the fallout from when we refactor apis and then it causes pain for the vfs.
> > >
> > > I'll take another look at the proposed helpers you need as bpf kfuncs
> > > and I'll give my best not to be overly annoyed by all of this. I have no
> > > intention of not helping you quite the opposite but I'm annoyed that
> > > we're here in the first place.
> > >
> > > What I want is to stop this madness of exposing stuff to users without
> > > fully understanding it's semantics and required guarantees.
> >
> > So, looking at this series you're now asking us to expose:
> >
> > (1) mmgrab()
> > (2) mmput()
> > (3) fput()
> > (5) get_mm_exe_file()
> > (4) get_task_exe_file()
> > (7) get_task_fs_pwd()
> > (6) get_task_fs_root()
> > (8) path_get()
> > (9) path_put()
> >
> > in one go and the justification in all patches amounts to "This is
> > common in some BPF LSM programs".
> >
> > So, broken stuff got exposed to users or at least a broken BPF LSM
> > program was written somewhere out there that is susceptible to UAFs
> > becauase you didn't restrict bpf_d_path() to trusted pointer arguments.
> > So you're now scrambling to fix this by asking for a bunch of low-level
> > exports.
> >
> > What is the guarantee that you don't end up writing another BPF LSM that
> > abuses these exports in a way that causes even more issues and then
> > someone else comes back asking for the next round of bpf funcs to be
> > exposed to fix it.
> 
> There is no guarantee.
> We made a safety mistake with bpf_d_path() though
> we restricted it very tight. And that UAF is tricky.
> I'm still amazed how Jann managed to find it.
> We all make mistakes.
> It's not the first one and not going to be the last.
> 
> What Matt is doing is an honest effort to fix it
> in the upstream kernel for all bpf users to benefit.
> He could have done it with a kernel module.
> The above "low level" helpers are all either static inline
> in .h or they call EXPORT_SYMBOL[_GPL] or simply inc/dec refcnt.
> 
> One can implement such kfuncs in an out of tree kernel module
> and be done with it, but in the bpf community we encourage
> everyone to upstream their work.
> 
> So kudos to Matt for working on these patches.
> 
> His bpf-lsm use case is not special.
> It just needs a safe way to call d_path.
> 
> +SEC("lsm.s/file_open")
> +__failure __msg("R1 must be referenced or trusted")
> +int BPF_PROG(path_d_path_kfunc_untrusted_from_current)
> +{
> +       struct path *pwd;
> +       struct task_struct *current;
> +
> +       current = bpf_get_current_task_btf();
> +       /* Walking a trusted pointer returned from bpf_get_current_task_btf()
> +        * yields and untrusted pointer. */
> +       pwd = &current->fs->pwd;
> +       bpf_path_d_path(pwd, buf, sizeof(buf));
> +       return 0;
> +}
> 
> This test checks that such an access pattern is unsafe and
> the verifier will catch it.
> 
> To make it safe one needs to do:
> 
>   current = bpf_get_current_task_btf();
>   pwd = bpf_get_task_fs_pwd(current);
>   if (!pwd) // error path
>   bpf_path_d_path(pwd, ...);
>   bpf_put_path(pwd);
> 
> these are the kfuncs from patch 6.
> 
> And notice that they have KF_ACQUIRE and KF_RELEASE flags.
> 
> They tell the verifier to recognize that bpf_get_task_fs_pwd()
> kfunc acquires 'struct path *'.
> Meaning that bpf prog cannot just return without releasing it.
> 
> The bpf prog cannot use-after-free that 'pwd' either
> after it was released by bpf_put_path(pwd).
> 
> The verifier static analysis catches such UAF-s.
> It didn't catch Jann's UAF earlier, because we didn't have
> these kfuncs! Hence the fix is to add such kfuncs with
> acquire/release semantics.
> 
> > The difference between a regular LSM asking about this and a BPF LSM
> > program is that we can see in the hook implementation what the LSM
> > intends to do with this and we can judge whether that's safe or not.
> 
> See above example.
> The verifier is doing a much better job than humans when it comes
> to safety.
> 
> > Here you're asking us to do this blindfolded.
> 
> If you don't trust the verifier to enforce safety,
> you shouldn't trust Rust compiler to generate safe code either.
> 
> In another reply you've compared kfuncs to EXPORT_SYMBOL_GPL.
> Such analogy is correct to some extent,
> but unlike exported symbols kfuncs are restricted to particular
> program types. They don't accept arbitrary pointers,
> and reference count is enforced as well.
> That's a pretty big difference vs EXPORT_SYMBOL.

There's one fundamental question here that we'll need an official answer to:

Is it ok for an out-of-tree BPF LSM program, that nobody has ever seen
to request access to various helpers in the kernel?

Because fundamentally this is what this patchset is asking to be done.

If the ZFS out-of-tree kernel module were to send us a similar patch
series asking us for a list of 9 functions that they'd like us to export
what would the answer to that be? It would be "no" - on principle alone.

So what is different between an out-of-tree BPF LSM program that no one
even has ever seen and an out-of-tree kernel module that one can at
least look at in Github? Why should we reject requests from the latter
but are supposed to accept requests from the former?

If we say yes to the BPF LSM program requests we would have to say yes
to ZFS as well.

