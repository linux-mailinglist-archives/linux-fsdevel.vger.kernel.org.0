Return-Path: <linux-fsdevel+bounces-65930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0531EC15898
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 16:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A42461565
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 15:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537FA3043D5;
	Tue, 28 Oct 2025 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y58s+EuF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ED8343D6E;
	Tue, 28 Oct 2025 15:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665569; cv=none; b=N2njzF162ImV53B0YgtFU0yBliXaLuktlWtfUb7krzH4GmuXvytXfgO2rgxSWj3KPThleQIRcx1wOLfaKoLOacbHHKOxar+M9qb0LlLig7jXEh3DFaU0Di6QiQD3IthE3miYQk4hHMs/GUxtcqjBXgxZ6pfmpcX4vwuVIPZw964=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665569; c=relaxed/simple;
	bh=PcklBCIpdApk37VX398hbDbhHd8SZs223+sTupKizTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5YYxPCtkb5CebiPtQWx1qg/sO5tAOT8BQpCDKt2YcAwtCUCWi6ajFF76EJOa2sF/Pvn4kC4fPYJZD4tGnEffVJuKOm+CONNuk2Z0yieONNJl3WX35Ubg1lCtk7JfwGA2bDUkjKQ6SknmZkz3ElCfwZf63qcMtd4m6xjF8dTbhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y58s+EuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4F0C4CEE7;
	Tue, 28 Oct 2025 15:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761665567;
	bh=PcklBCIpdApk37VX398hbDbhHd8SZs223+sTupKizTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y58s+EuFr87aGntK4Vg3Ku0XIUj3PgVfoHAp1XEmD2yfm3jlw5qWpgQcryCkARs14
	 BQQZEUPAkbUMCLplS3v/xugvI250S4z8lAfiHqiJd38Pa1XnsJGv+zhLjJpGCao6LJ
	 Fp86pWW/Jx0wXvQkDmEP01FrOGRYdnol5jt8tP336tlirNXTPFgQbEUSoc5qg89Bu6
	 41YKQLC0zMXGQaCZa7XQRHlnQuiT0T3tpxXqBR4M/+PZDM7l5EoO44mdh9TCgGQU8A
	 O46docCd/ez55B9QZenOvRdrhopClqM64rW9at1hGJ6rF9lqe8rQhGDzLwe9DxosIm
	 uKQwmVq3atxxw==
Date: Tue, 28 Oct 2025 16:32:39 +0100
From: Christian Brauner <brauner@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	bpf@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 11/70] ns: add active reference count
Message-ID: <20251028-fernweh-prasseln-b066fb441ee6@brauner>
References: <20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
 <20251024-work-namespace-nstree-listns-v3-11-b6241981b72b@kernel.org>
 <aQCbLrYf_KTdxZjU@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aQCbLrYf_KTdxZjU@horms.kernel.org>

On Tue, Oct 28, 2025 at 10:30:06AM +0000, Simon Horman wrote:
> On Fri, Oct 24, 2025 at 12:52:40PM +0200, Christian Brauner wrote:
> 
> ...
> 
> > diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> 
> ...
> 
> > +void get_cred_namespaces(struct task_struct *tsk)
> > +{
> > +	ns_ref_active_get(tsk->real_cred->user_ns);
> 
> Hi Christian,
> 
> real_cred is protected by RCU, but this code doesn't seem to take
> that into account. Or, at least Sparse doesn't think so:
> 
> .../nsproxy.c:264:9: error: no generic selection for 'struct user_namespace *const [noderef] __rcu user_ns'
> .../nsproxy.c:264:9: warning: dereference of noderef expression
> 
> > +}
> > +
> > +void exit_cred_namespaces(struct task_struct *tsk)
> > +{
> > +	ns_ref_active_put(tsk->real_cred->user_ns);
> 
> Likewise here.

get_cred_namespaces() is called during copy_creds() which is called
during process creation aka from copy_process(). So copy_creds() always
takes the creds of current (the parent process in this case) which can't
change in any way.

Simplifying a bit:
Either we created a thread via CLONE_THREAD in which case we can't
specify CLONE_NEWUSER (little know fact, I guess) and so we just bump
the reference count on the existing user namespace from the parent's
creds, or we're creating a new set of credentials that no one has ever
seen before possibly even a new user namespace if CLONE_NEWUSER has been
specified.

In both case the credentials are completely stable. The call to
exit_cred_namespaces() has similar reasoning when called from the
cleanup/failure path of copy_process().

The other callsite is release_task() which is called - simplifying -
after the task has been reaped. That thing is deader than dead and
nothing can mess with its creds anymore.

In other words, the get/put patterns for namespace management generally
happens at edges where the relevant structures are stable and can't be
changed by anyone other than the calling thread. And at no point are we
putting references on creds themselves.

Let me know if I missed something obvious.

