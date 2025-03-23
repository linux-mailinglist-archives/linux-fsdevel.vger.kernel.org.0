Return-Path: <linux-fsdevel+bounces-44845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE2EA6D11A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 21:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FE8B16F0B4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 20:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E421A0BED;
	Sun, 23 Mar 2025 20:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUOA5CBy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A11136E
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Mar 2025 20:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742762543; cv=none; b=S4embeUB7r0BPrTvFAjJkYvmyGsYOpIakQnfVaNj4LWxNozRGyBE/3rcMUj3aMcTCDdbyaxxoJUvray87CFurrJfiF/fsiKX0xxFcxH4TFMY6mZlvNEnK9pvKLx3Qatn0Mwd6dvDorCpJ7TE+9dkzhol4dF1GC3x26LgIiVkaOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742762543; c=relaxed/simple;
	bh=neI/fUnpJL6FTv21Wn+1kCYKTbaUZaSNEiKksBvB7aY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bb0nPDpa1HEMaut0cl/C+DVuIK3/EvOZ3HCmzzb4PyAlQXIqMCoAjsjm8pQX10H3O5/UIyPclZiKHEoapDYEtbb79TrhQA/G2aB8q77zVPdb4YHgw8Ttu/vkYuaUQGy4ZGdacfWrQ99LK3N5vZmKPawSu3XWUKSEGhptDYn/5Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUOA5CBy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B6EC4CEE2;
	Sun, 23 Mar 2025 20:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742762542;
	bh=neI/fUnpJL6FTv21Wn+1kCYKTbaUZaSNEiKksBvB7aY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oUOA5CBy3LSiZOKGGDNe+TOEgMrAqc0oJvtcg4YCE/cHNrG8y7Ej27n5FI3n/Tt8z
	 IbV0wWeciEncywaOBmwl4Oe17W2hezxudckPJOXup+Qoh00Rqyb7Q8ZvgLhCkShzFh
	 ic2JZax3mIP7o/VrkCh8YlXacy8agNd/KOtIQhDNtH//DV/3WQLXgIuS0B4/CgCUaQ
	 qVZJ+BsolN38sasGsHFYqgHSgdSKLO+iyLZGPMhoVAuyLpINw2PwvmuRA+EGvER6jx
	 Z79nbwuX45w5R6Vd/YHQ6XXlSCyCPo+Q59AZN6+SZbW1WjwzKtb+Y9C4vDMb8wlsPW
	 1FpJUMLvF/dVQ==
Date: Sun, 23 Mar 2025 21:42:21 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Lennart Poettering <lennart@poettering.net>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH] pidfs: cleanup the usage of do_notify_pidfd()
Message-ID: <20250323-merkbar-hallen-8cfd79b6f2ed@brauner>
References: <20250320-work-pidfs-thread_group-v4-0-da678ce805bf@kernel.org>
 <20250323171955.GA834@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250323171955.GA834@redhat.com>

On Sun, Mar 23, 2025 at 06:19:55PM +0100, Oleg Nesterov wrote:
> If a single-threaded process exits do_notify_pidfd() will be called twice,
> from exit_notify() and right after that from do_notify_parent().
> 
> 1. Change exit_notify() to call do_notify_pidfd() if the exiting task is
>    not ptraced and it is not a group leader.
> 
> 2. Change do_notify_parent() to call do_notify_pidfd() unconditionally.
> 
>    If tsk is not ptraced, do_notify_parent() will only be called when it
>    is a group-leader and thread_group_empty() is true.
> 
> This means that if tsk is ptraced, do_notify_pidfd() will be called from
> do_notify_parent() even if tsk is a delay_group_leader(). But this case is
> less common, and apart from the unnecessary __wake_up() is harmless.
> 
> Granted, this unnecessary __wake_up() can be avoided, but I don't want to
> do it in this patch because it's just a consequence of another historical
> oddity: we notify the tracer even if !thread_group_empty(), but do_wait()
> from debugger can't work until all other threads exit. With or without this
> patch we should either eliminate do_notify_parent() in this case, or change
> do_wait(WEXITED) to untrace the ptraced delay_group_leader() at least when
> ptrace_reparented().
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---

Thanks for doing this! I'll send this together with the first set of
fixes after the merge window closes.

>  kernel/exit.c   | 8 ++------
>  kernel/signal.c | 8 +++-----
>  2 files changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 683766316a3d..d0ebccb9dec0 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -742,12 +742,6 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
>  		kill_orphaned_pgrp(tsk->group_leader, NULL);
>  
>  	tsk->exit_state = EXIT_ZOMBIE;
> -	/*
> -	 * Ignore thread-group leaders that exited before all
> -	 * subthreads did.
> -	 */
> -	if (!delay_group_leader(tsk))
> -		do_notify_pidfd(tsk);
>  
>  	if (unlikely(tsk->ptrace)) {
>  		int sig = thread_group_leader(tsk) &&
> @@ -760,6 +754,8 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
>  			do_notify_parent(tsk, tsk->exit_signal);
>  	} else {
>  		autoreap = true;
> +		/* untraced sub-thread */
> +		do_notify_pidfd(tsk);
>  	}
>  
>  	if (autoreap) {
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 027ad9e97417..1d8db0dabb71 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2179,11 +2179,9 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
>  
>  	WARN_ON_ONCE(!tsk->ptrace &&
>  	       (tsk->group_leader != tsk || !thread_group_empty(tsk)));
> -	/*
> -	 * Notify for thread-group leaders without subthreads.
> -	 */
> -	if (thread_group_empty(tsk))
> -		do_notify_pidfd(tsk);
> +
> +	/* ptraced, or group-leader without sub-threads */
> +	do_notify_pidfd(tsk);
>  
>  	if (sig != SIGCHLD) {
>  		/*
> -- 
> 2.25.1.362.g51ebf55
> 
> 

