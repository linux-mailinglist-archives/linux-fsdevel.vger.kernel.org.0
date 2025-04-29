Return-Path: <linux-fsdevel+bounces-47620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DE5AA1306
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 19:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0BFF188DE58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 16:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C6E253322;
	Tue, 29 Apr 2025 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpAewxvW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051C92517A6;
	Tue, 29 Apr 2025 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945849; cv=none; b=muUdbAqfgAnnkpnnQFt/isp2X19gCdxZU4nMjRjEI3Kubn/rfR1KjQAhBYBAGIQFjhDFZ2tk2T6GHbQsmsYDZlkfrRAaDNHB2WtQKuAGIS2epKhB+aq/0Wy8tnvWyTdDVi3/TqaBoQigDWQv6YhAs55EUE9eIvw38FwpFgk8nfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945849; c=relaxed/simple;
	bh=ipRqIkTVDn1dLGetJ67+0tIDZlhJgt4zp5uPL1A7eL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lncGm6aWu69gT4iaYnWzlqIPrthpj6i51kzAkG0t6E57UyFcT9O9BbD6xgWkE56bpWipQZhzXaA5ssh5gavQ+WETSZNqgQ0XdFEicuYCAVBiSZUI3zpAlD1e/UEZUHxnC2pmQ3aSi9qcHuzcDAbXn5FN670iqc9UpxH6iBINcJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpAewxvW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87D8C4CEE9;
	Tue, 29 Apr 2025 16:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745945847;
	bh=ipRqIkTVDn1dLGetJ67+0tIDZlhJgt4zp5uPL1A7eL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HpAewxvWdIt4hTlSxGh2L6xk+QE7EtRvqSTv9+cvpeifDyPXpJHiJ3riJtquKe36w
	 iJclZWXV68HyQtAKqSuZSWufXcTKiQ4+ij3z61TpHnRwmJa/DAwJtS6+W12viqwPwT
	 kiar65ZM7ojINcILfivDzdtHxhhorpQKJU6RYeCgXkDcpaEpCIjWE3ajvCUFro7a36
	 LlSYSs5WNGLnzvQh843eghvaBfCExnEsGBkHMB/VlJ5t+TVE2D9aVdwtqsU3L+vIiE
	 ofYwnNpyzok+8OXJX6nLW+Zh+6hs91j8qXtMzGIxQFc3WnaDgoq+PEaVtAXflTPwur
	 0/aBaZA2pYfjw==
Date: Tue, 29 Apr 2025 09:57:24 -0700
From: Kees Cook <kees@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
	mjguzik@gmail.com, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] exec: fix the racy usage of fs_struct->in_exec
Message-ID: <202504290957.1D6835B89@keescook>
References: <67dc67f0.050a0220.25ae54.001f.GAE@google.com>
 <20250324160003.GA8878@redhat.com>
 <20250429154944.GA18907@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429154944.GA18907@redhat.com>

On Tue, Apr 29, 2025 at 05:49:44PM +0200, Oleg Nesterov wrote:
> Damn, I am stupid.
> 
> On 03/24, Oleg Nesterov wrote:
> >
> > check_unsafe_exec() sets fs->in_exec under cred_guard_mutex, then execve()
> > paths clear fs->in_exec lockless. This is fine if exec succeeds, but if it
> > fails we have the following race:
> >
> > 	T1 sets fs->in_exec = 1, fails, drops cred_guard_mutex
> >
> > 	T2 sets fs->in_exec = 1
> >
> > 	T1 clears fs->in_exec
> 
> When I look at this code again, I think this race was not possible and thus
> this patch (applied as af7bb0d2ca45) was not needed.
> 
> Yes, begin_new_exec() can drop cred_guard_mutex on failure, but only after
> de_thread() succeeds, when we can't race with another sub-thread.
> 
> I hope this patch didn't make the things worse so we don't need to revert it.
> Plus I think it makes this (confusing) logic a bit more clear. Just, unless
> I am confused again, it wasn't really needed.
> 
> -----------------------------------------------------------------------------
> But. I didn't read the original report from syzbot,
> https://lore.kernel.org/all/67dc67f0.050a0220.25ae54.001f.GAE@google.com/#t
> because I wasn't CC'ed. and then - sorry Kees!!! - I didn't bother to read
> your first reply carefully.
> 
> So yes, with or without this patch the "if (fs->in_exec)" check in copy_fs()
> can obviously hit the 1 -> 0 transition.
> 
> This is harmless, but should be probably fixed just to avoid another report
> from KCSAN.
> 
> I do not want to add another spin_lock(fs->lock). We can change copy_fs() to
> use data_race(), but I'd prefer the patch below. Yes, it needs the additional
> comment(s) to explain READ_ONCE().
> 
> What do you think? Did I miss somthing again??? Quite possibly...
> 
> Mateusz, I hope you will cleanup this horror sooner or later ;)
> 
> Oleg.
> ---
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 5d1c0d2dc403..42a7f9b43911 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1495,7 +1495,7 @@ static void free_bprm(struct linux_binprm *bprm)
>  	free_arg_pages(bprm);
>  	if (bprm->cred) {
>  		/* in case exec fails before de_thread() succeeds */
> -		current->fs->in_exec = 0;
> +		WRITE_ONCE(current->fs->in_exec, 0);
>  		mutex_unlock(&current->signal->cred_guard_mutex);
>  		abort_creds(bprm->cred);
>  	}
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 4c2df3816728..381af8c8ece8 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1802,7 +1802,7 @@ static int copy_fs(unsigned long clone_flags, struct task_struct *tsk)
>  		/* tsk->fs is already what we want */
>  		spin_lock(&fs->lock);
>  		/* "users" and "in_exec" locked for check_unsafe_exec() */
> -		if (fs->in_exec) {
> +		if (READ_ONCE(fs->in_exec)) {
>  			spin_unlock(&fs->lock);
>  			return -EAGAIN;
>  		}
> 

Yeah, this seems reasonable.

-- 
Kees Cook

