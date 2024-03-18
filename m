Return-Path: <linux-fsdevel+bounces-14740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D90D687E9EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 14:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19900B21623
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 13:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4293838F9C;
	Mon, 18 Mar 2024 13:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6qEQcmW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DE7383B0;
	Mon, 18 Mar 2024 13:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710767690; cv=none; b=f7XFsNxkEvV3qa7hQPrJQ2rADmCDuglt/2qgl9ahfLE/7/dQ2DgtYtrEViLe6FsxwtU+2B0zMDKe4N/xFlzMojqKoQGpMaQY6TAmgRm2/rSf2f4OK95+ciSaUyvUlVn856yuesrakfrv1hdX40NX2BcpEo7kmyuujQ4PJWKpCz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710767690; c=relaxed/simple;
	bh=wdOLheqkYQM6bCs9rhSL/Wr+WBxhXujpoON2jZ5TA50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3bPZg5FgSjHjVe1GNtQM4an83DY4g0fGY5lTn1IJAHDHLCip6M64nQt2CAtBXqKC6ZO2FknVNE01rumZIrKbGcfBXtUP0AkZatqoPa8b3xAzrnPJNYRm3TmpQ1UfaEohyxN+kLz3N0dsAMMuze0XnHdYTQxfBmbEg/9lQDP6IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6qEQcmW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE61C433C7;
	Mon, 18 Mar 2024 13:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710767690;
	bh=wdOLheqkYQM6bCs9rhSL/Wr+WBxhXujpoON2jZ5TA50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q6qEQcmWHsqOSaYqPqtanTGcl57R3kC6r/2RIkXxMJmcLf7lBlH7lXJ3RvXi5sH/g
	 8O32LovbKuZd53tqQq7uDm8UdZczeWuDCrmuQrFYMCO7NjIUDG9zfuk85kGPQrVd+2
	 mkKsufIB+NDBYK0HX2OvPnUOjXOC5wrZkXYrevMvh9cEelCzvnPYmVRjWM52W9fNUi
	 4ngJDZ86Si64mYzFcUGRsH6YO9QZ8gHJN1HBSpbJQ6okKyvF6b3cdD56vx//kg9YTA
	 0FXAIoRAEg2Ob7+1i6wFDBysU5XDEamX3OF0gbwAdohwLcPneDSpmJwEUrAjnGMzoj
	 2j/WsYrpkXxPw==
Date: Mon, 18 Mar 2024 14:14:43 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Matt Bobrowski <mattbobrowski@google.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	KP Singh <kpsingh@google.com>, Jann Horn <jannh@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm <linux-mm@kvack.org>, LSM List <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next 0/9] add new acquire/release BPF kfuncs
Message-ID: <20240318-individual-gekennzeichnet-1658fcb8bf27@brauner>
References: <cover.1709675979.git.mattbobrowski@google.com>
 <20240306-flach-tragbar-b2b3c531bf0d@brauner>
 <20240306-sandgrube-flora-a61409c2f10c@brauner>
 <CAADnVQ+RBV_rJx5LCtCiW-TWZ5DCOPz1V3ga_fc__RmL_6xgOg@mail.gmail.com>
 <20240307-phosphor-entnahmen-8ef28b782abf@brauner>
 <CAADnVQLMHdL1GfScnG8=0wL6PEC=ACZT3xuuRFrzNJqHKrYvsw@mail.gmail.com>
 <20240308-kleben-eindecken-73c993fb3ebd@brauner>
 <CAADnVQJVNntnH=DLHwUioe9mEw0FzzdUvmtj3yx8SjL38daeXQ@mail.gmail.com>
 <20240311-geglaubt-kursverfall-500a27578cca@brauner>
 <CAADnVQLnzrxyUM-EiorEP_qvfmdiSK5Kj1WtGjFoAogygHSvmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLnzrxyUM-EiorEP_qvfmdiSK5Kj1WtGjFoAogygHSvmA@mail.gmail.com>

On Wed, Mar 13, 2024 at 02:05:13PM -0700, Alexei Starovoitov wrote:
> On Mon, Mar 11, 2024 at 5:01 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > > > > One can argue that get_mm_exe_file() is not exported,
> > > > > but it's nothing but rcu_lock-wrap plus get_file_rcu()
> > > > > which is EXPORT_SYMBOL.
> > > >
> > > > Oh, good spot. That's an accident. get_file_rcu() definitely shouldn't
> > > > be exported. So that'll be removed asap.
> > >
> > > So, just to make a point that
> > > "Included in that set are functions that aren't currently even
> > > exported to modules"
> > > you want to un-export get_file_rcu() ?
> >
> > No. The reason it was exported was because of the drm subsystem and we
> > already quite disliked that. But it turned out that's not needed so in
> > commit 61d4fb0b349e ("file, i915: fix file reference for
> > mmap_singleton()") they were moved away from this helper.
> 
> Arguably that commit 61d4fb0b349e should have had
> Fixes: 0ede61d8589c ("file: convert to SLAB_TYPESAFE_BY_RCU")
> i915 was buggy before you touched it
> and safe_by_rcu exposed the bug.
> I can see why you guys looked at it, saw issues,
> and decided to look away.
> Though your guess in commit 61d4fb0b349e
> "
>     Now, there might be delays until
>     file->f_op->release::singleton_release() is called and
>     i915->gem.mmap_singleton is set to NULL.
> "
> feels unlikely.
> I suspect release() delay cannot be that long to cause rcu stall.
> In the log prior to the splat there are just two mmap related calls
> from selftests in i915_gem_mman_live_selftests():
> i915: Running i915_gem_mman_live_selftests/igt_mmap_offset_exhaustion
> i915: Running i915_gem_mman_live_selftests/igt_mmap
> 1st mmap test passed, but 2nd failed.
> So it looks like it's not a race, but an issue with cleanup in that driver.
> And instead of getting to the bottom of the issue
> you've decided to paper over with get_file_active().
> I agree with that trade-off.
> But the bug in i915 is still there and it's probably an UAF.
> get_file_active() is probably operating on a broken 'struct file'
> that got to zero, but somehow it still around
> or it's just a garbage memory and file->f_count
> just happened to be zero.
> 
> My point is that it's not ok to have such double standards.
> On one side you're arguing that we shouldn't introduce kfunc:
> +__bpf_kfunc struct file *bpf_get_task_exe_file(struct task_struct *task)
> +{
> + return get_task_exe_file(task);
> +}
> that cleanly takes ref cnt on task->mm->exe_file and _not_ using lower
> level get_file/get_file_rcu/get_file_active api-s directly which
> are certainly problematic to expose anywhere, since safe_by_rcu
> protocol is delicate.
> 
> But on the other side there is buggy i915 that does
> questionable dance with get_file_active().
> It's EXPORT_SYMBOL_GPL as well and out of tree driver can
> ruin safe_by_rcu file properties with hard to debug consequences.

You're lending strong support for my earlier point. Because this is a
clear an example where a subsystem got access to a helper that it
shouldn't have had access to. So we fixed the issue.

But this whole polemic just illustrates that you simply didn't bother to
understand how the code works. The way you talk about UAF together with
SLAB_TYPESAFE_BY_RCU is telling. Please read the code instead of
guessing.

So the same way we don't have to take responsibility for bpf
misunderstanding the expectations of d_path() we don't have to take
responsibility for misusing an internal helper by another subsystem.

So your argument here is moot at best and polemical and opportunistic at
worst. It certainly doesn't illustrate what you think it does.

And the above is fundamentally a suspiciously long sideshow. So let's
get back to the core topic: Unless you document your rules when it's ok
for a bpf program to come along and request access to internal apis
patchsets such as this are not acceptable.

> 
> > There is absolutely no way that any userspace will
> > get access to such low-level helpers. They have zero business to be
> > involved in the lifetimes of objects on this level just as no module has.
> 
> correct, and kfuncs do not give bpf prog to do direct get_file*() access
> because we saw how tricky safe_by_rcu is.
> Hence kfuncs acquire file via get_task_exe_file or get_mm_exe_file
> and release via fput.
> That's the same pattern that security/tomoyo/util.c is doing:
>    exe_file = get_mm_exe_file(mm);
>    if (!exe_file)
>         return NULL;
> 
>    cp = tomoyo_realpath_from_path(&exe_file->f_path);
>    fput(exe_file);
> 
> in bpf_lsm case it will be:
> 
>    exe_file = bpf_get_mm_exe_file(mm);
>    if (!exe_file)
>    // the verifier will enforce that bpf prog has this NULL check here
>    // because we annotate kfunc as:
> BTF_ID_FLAGS(func, bpf_get_mm_exe_file, KF_ACQUIRE | KF_TRUSTED_ARGS |
> KF_RET_NULL)
> 
>  bpf_path_d_path(&exe_file->f_path, ...);
>  bpf_put_file(exe_file);
> // and the verifier will enforce that bpf_put_file() is called too.
> // and there is no path out of this bpf program that can take file refcnt
> // without releasing.
> 
> So really these kfuncs are a nop from vfs pov.
> If there is a bug in the verifier we will debug it and we will fix it.
> 
> You keep saying that bpf_d_path() is a mess.
> Right. It is a mess now and we're fixing it.
> When it was introduced 4 years ago it was safe at that time.

Uhm, no it was always sketchy.

> The unrelated verifier "smartness" made it possible to use it in UAF.
> We found the issue now and we're fixing it.
> Over these years we didn't ask vfs folks to help fix such bugs,
> and not asking for help now.
> You're being cc-ed on the patches to be aware on how we plan to fix
> this bpf_d_path() mess. If you have a viable alternative please suggest.

The fix is to export a variant with trusted args.

> As it stands the new kfuncs are clean and safe way to solve this mess.

I will remind you of what you have been told in [1]:

"No. It's not up to maintainers to suggest alternatives. Sometimes it's
simply enough to explain *why* something isn't acceptable.

A plain "no" without explanation isn't sufficient. NAKs need a good
reason. But they don't need more than that.

The onus of coming up with an acceptable solution is on the person who
needs something new."

You've been provided:

a) good reasons why the patchset in it's current form isn't acceptable
   repeated multiple times
b) support for exporting a variant of bpf_d_path() that is safe to use
c) a request that all kfunc exports for the vfs will have to be located
   under fs/, not in kernel/bpf/
d) a path on how to move forward with additional kfunc requests:
   Clear and documented rules when it's ok for someone to come along and
   request access to bpf kfuncs when it's to be rejected and when it's
   ok to be supported.

You repeatedly threatening to go over the heads of people will not make
them more amenable to happily integrate with your subsystem.

[1]: https://lore.kernel.org/all/CAHk-=whD2HMe4ja5nR6WWofUh3nLmhjoSPDvZm2-XMGjeie5Tg@mail.gmail.com

