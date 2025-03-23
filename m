Return-Path: <linux-fsdevel+bounces-44847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1D7A6D11F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 21:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1FD5189569C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 20:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675621A3173;
	Sun, 23 Mar 2025 20:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlV7EjwB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D0E14386D;
	Sun, 23 Mar 2025 20:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742763445; cv=none; b=MhgXyc+7rGXHNl9ad+CIMdlTEiSZkF9Z3lgkdGKDgIHcrPgYqBpt1VFwtTv5yc8bQ6FkTHJSgWgjIGQTV1HNyBPQa9s+tO4ytUOy2FadD2HpBtQgs0vAZx3xREVRPyAIiGGChVhtSuPfDqelHXp0qmvGaJ0TyvPboQZWxUzMqPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742763445; c=relaxed/simple;
	bh=Ev4tSesxO91BpPfkFPCZ9nFl2zIVQfSRk1iXPRbGrk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzLWzOdMpb0SLjqBZywO8iE7+rMQm/hwy0TJstX69xe+2ds7+UQ+lyQ9boUI1chfa7tc8suvNZHelKPulz/NEWRQGEOuQ74Gu4/y3BlI5+G79QY6Ry0yOwgTbovz1JmMjUyDlmqA44BEejMHJR5VP+OFBL5RktzU2F4v4PQHWpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlV7EjwB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD5EC4CEE2;
	Sun, 23 Mar 2025 20:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742763445;
	bh=Ev4tSesxO91BpPfkFPCZ9nFl2zIVQfSRk1iXPRbGrk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rlV7EjwBKKUpVqqY81Jdzx/BLuN+HSH3HFPkoJbJ/b3TEGabUg49QUOXOdp9wVz9h
	 hdHAJGl1026w3fAjAKFnohMe7K6tbdWrIjtMNOQCP4btG79dkcZODFqwri6HDrtLSR
	 +mSe6Z8ApNBw8stpzev3TuuCbj0+mOTnNWnHgNaeoyfpoLDExbYct7Y/dp2Bi21a4I
	 /nyodGh8MR/x52VPoAACsUFO7XAbXMQ7YY6P/tI9TutSXSi3kn5NM111k2RBDS4zR4
	 PsBbMNsEJeKD56EXCncyYguBhi13hvDBzfKdNc456lAWSgfD1Ht4uXH1ZiUEVtWbjD
	 KmuXIvCkkVlAQ==
Date: Sun, 23 Mar 2025 21:57:23 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+1c486d0b62032c82a968@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [fs?] [mm?] KCSAN: data-race in bprm_execve / copy_fs
 (4)
Message-ID: <20250323-haftverschonung-rochen-22c230317a23@brauner>
References: <67dc67f0.050a0220.25ae54.001f.GAE@google.com>
 <202503201225.92C5F5FB1@keescook>
 <20250321-abdecken-infomaterial-2f373f8e3b3c@brauner>
 <20250322010008.GG2023217@ZenIV>
 <20250322155538.GA16736@redhat.com>
 <20250322185007.GI2023217@ZenIV>
 <20250323181419.GA14883@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250323181419.GA14883@redhat.com>

On Sun, Mar 23, 2025 at 07:14:21PM +0100, Oleg Nesterov wrote:
> On 03/22, Al Viro wrote:
> >
> > On Sat, Mar 22, 2025 at 04:55:39PM +0100, Oleg Nesterov wrote:
> >
> > > And this means that we just need to ensure that ->in_exec is cleared
> > > before this mutex is dropped, no? Something like below?
> >
> > Probably should work, but I wonder if it would be cleaner to have
> > ->in_exec replaced with pointer to task_struct responsible.  Not
> > "somebody with that fs_struct for ->fs is trying to do execve(),
> > has verified that nothing outside of their threads is using this
> > and had been holding ->signal->cred_guard_mutex ever since then",
> > but "this is the thread that..."
> 
> perhaps... or something else to make this "not immediately obvious"
> fs->in_exec more clear.

Well, it would certainly help to document that cred_guard_mutex
serializes concurrent exec.

This is kind of important information given that begin_new_exec() and
finalize_exec() are only called from ->load_binary() and are thus always
located in the individual binfmt_*.c files. That makes this pretty
implicit information.

Let alone that the unlocking is all based on bprm->cred being set or
unset.

Otherwise the patch looks good to me.

> 
> But I guess we need something simple for -stable, so will you agree
> with this fix for now? Apart from changelog/comments.
> 
> 	retval = de_thread(me);
> +	current->fs->in_exec = 0;
> 	if (retval)
> 		current->fs->in_exec = 0;
> 
> is correct but looks confusing. See "V2" below, it clears fs->in_exec
> after the "if (retval)" check.
> 
> syzbot says:
> 
> 	Unfortunately, I don't have any reproducer for this issue yet.
> 
> so I guess "#syz test: " is pointless right now...
> 
> Oleg.
> ---
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 506cd411f4ac..02e8824fc9cd 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1236,6 +1236,7 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	if (retval)
>  		goto out;
>  
> +	current->fs->in_exec = 0;
>  	/*
>  	 * Cancel any io_uring activity across execve
>  	 */
> @@ -1497,6 +1498,8 @@ static void free_bprm(struct linux_binprm *bprm)
>  	}
>  	free_arg_pages(bprm);
>  	if (bprm->cred) {
> +		// for the case exec fails before de_thread()
> +		current->fs->in_exec = 0;
>  		mutex_unlock(&current->signal->cred_guard_mutex);
>  		abort_creds(bprm->cred);
>  	}
> @@ -1862,7 +1865,6 @@ static int bprm_execve(struct linux_binprm *bprm)
>  
>  	sched_mm_cid_after_execve(current);
>  	/* execve succeeded */
> -	current->fs->in_exec = 0;
>  	current->in_execve = 0;
>  	rseq_execve(current);
>  	user_events_execve(current);
> @@ -1881,7 +1883,6 @@ static int bprm_execve(struct linux_binprm *bprm)
>  		force_fatal_sig(SIGSEGV);
>  
>  	sched_mm_cid_after_execve(current);
> -	current->fs->in_exec = 0;
>  	current->in_execve = 0;
>  
>  	return retval;
> 

