Return-Path: <linux-fsdevel+bounces-44784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5447EA6C942
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 11:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB4A67A9865
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 10:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510C21F9AB6;
	Sat, 22 Mar 2025 10:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vH87r9u6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDE11DE8B4;
	Sat, 22 Mar 2025 10:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742639322; cv=none; b=jNnseosURQN8WmIU1rGElOkH2r7HNqL7QNdFzW4pPuPmEy1Xb5MIegPQMLnTaJH5CQgsaE7QGbPqS3+bYFuWQpGfq3KgHSfvnFja5CGqiGcWr0hrpD2FMKvkZP2bCrfQRs3oWUIU4gaJ+W+jyChNsUuzaH8tmZq1px2GAdG22H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742639322; c=relaxed/simple;
	bh=/Kqgjm/YTOF5HTAfqwvoVIWHqlsHCxVeqZvK1/hHahw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRg7FZzZklszIj+RFH6dHjUKS8wdzdeZf2EeozXme/iOzmS3SFZe4rFb8ikkBPyycRsQ/eQb5iPeNl0cuwLapT+9Lh6s9f64f+KOIZrNouLHUTt1IdaVjDgeScGBL7stJyXLQ0oaRvidMEA1vlAOSKI6Tun6hPO2jTwuaWXdMuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vH87r9u6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C785EC4CEDD;
	Sat, 22 Mar 2025 10:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742639322;
	bh=/Kqgjm/YTOF5HTAfqwvoVIWHqlsHCxVeqZvK1/hHahw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vH87r9u6TDBaV0s5CeeV5jLdWlxe57mSoJCzif8WS6Dnt+5Z6qyQGrm3GAnCObMlQ
	 26ST0eVp5hihWU605LdcPbeGOVGRPiWfsbZSkd1Q+4RVuIG+9F0iUbvERes9S7mu1H
	 mJE78JFUagXnYVBs1J7JqD4fniXmJwmmv4k1YvNb6wu4OPYwBokbLgEVv+zFCosjnX
	 ABV4AeY1uAf5odch+JTiGZSTrzvioebwRZJSYU3f6m/fa8Bo7VvtH8qBBQmflpUigW
	 R6w8Kas6wjF4zBbe/nXM/kLqoa3ndrZ/DwPa05uvietpOv9Dzm13Ek6UQyQgDyLMgE
	 OOiU4S771rATQ==
Date: Sat, 22 Mar 2025 11:28:37 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Oleg Nesterov <oleg@redhat.com>, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+1c486d0b62032c82a968@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [fs?] [mm?] KCSAN: data-race in bprm_execve / copy_fs
 (4)
Message-ID: <20250322-erahnen-popkultur-c871983bd560@brauner>
References: <67dc67f0.050a0220.25ae54.001f.GAE@google.com>
 <202503201225.92C5F5FB1@keescook>
 <20250321-abdecken-infomaterial-2f373f8e3b3c@brauner>
 <20250322010008.GG2023217@ZenIV>
 <202503212313.1E55652@keescook>
 <lhxexfurwfcr4fgwxmnhcqeii2qrzpoy7dflpwqio463x6jhrm@rttainje5vzq>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <lhxexfurwfcr4fgwxmnhcqeii2qrzpoy7dflpwqio463x6jhrm@rttainje5vzq>

On Sat, Mar 22, 2025 at 11:15:44AM +0100, Mateusz Guzik wrote:
> On Fri, Mar 21, 2025 at 11:26:03PM -0700, Kees Cook wrote:
> > On Sat, Mar 22, 2025 at 01:00:08AM +0000, Al Viro wrote:
> > > On Fri, Mar 21, 2025 at 09:45:39AM +0100, Christian Brauner wrote:
> > > 
> > > > Afaict, the only way this data race can happen is if we jump to the
> > > > cleanup label and then reset current->fs->in_exec. If the execve was
> > > > successful there's no one to race us with CLONE_FS obviously because we
> > > > took down all other threads.
> > > 
> > > Not really.
> > 
> > Yeah, you found it. Thank you!
> > 
> > > 1) A enters check_unsafe_execve(), sets ->in_exec to 1
> > > 2) B enters check_unsafe_execve(), sets ->in_exec to 1
> > 
> > With 3 threads A, B, and C already running, fs->users == 3, so steps (1)
> > and (2) happily pass.
> > 
> > > 3) A calls exec_binprm(), fails (bad binary)
> > > 4) A clears ->in_exec
> > > 5) C calls clone(2) with CLONE_FS and spawns D - ->in_exec is 0
> > 
> > D's creation bumps fs->users == 4.
> > 
> > > 6) B gets through exec_binprm(), kills A and C, but not D.
> > > 7) B clears ->in_exec, returns
> > > 
> > > Result: B and D share ->fs, B runs suid binary.
> > > 
> > > Had (5) happened prior to (2), (2) wouldn't have set ->in_exec;
> > > had (5) happened prior to (4), clone() would've failed; had
> > > (5) been delayed past (6), there wouldn't have been a thread
> > > to call clone().
> > > 
> > > But in the window between (4) and (6), clone() doesn't see
> > > execve() in progress and check_unsafe_execve() has already
> > > been done, so it hadn't seen the extra thread.
> > > 
> > > IOW, it really is racy.  It's a counter, not a flag.
> > 
> > Yeah, I would agree. Totally untested patch:
> > 
> > diff --git a/fs/exec.c b/fs/exec.c
> > index 506cd411f4ac..988b8621c079 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -1632,7 +1632,7 @@ static void check_unsafe_exec(struct linux_binprm *bprm)
> >  	if (p->fs->users > n_fs)
> >  		bprm->unsafe |= LSM_UNSAFE_SHARE;
> >  	else
> > -		p->fs->in_exec = 1;
> > +		refcount_inc(&p->fs->in_exec);
> >  	spin_unlock(&p->fs->lock);
> >  }
> >  
> > @@ -1862,7 +1862,7 @@ static int bprm_execve(struct linux_binprm *bprm)
> >  
> >  	sched_mm_cid_after_execve(current);
> >  	/* execve succeeded */
> > -	current->fs->in_exec = 0;
> > +	refcount_dec(&current->fs->in_exec);
> >  	current->in_execve = 0;
> >  	rseq_execve(current);
> >  	user_events_execve(current);
> > @@ -1881,7 +1881,7 @@ static int bprm_execve(struct linux_binprm *bprm)
> >  		force_fatal_sig(SIGSEGV);
> >  
> >  	sched_mm_cid_after_execve(current);
> > -	current->fs->in_exec = 0;
> > +	refcount_dec(&current->fs->in_exec);
> >  	current->in_execve = 0;
> >  
> >  	return retval;
> 
> The bump is conditional and with this patch you may be issuing
> refcount_dec when you declined to refcount_inc.
> 
> A special case where there are others to worry about and which proceeds
> with an exec without leaving in any indicators is imo sketchy.
> 
> I would argue it would make the most sense to serialize these execs.

Yeah, I tend to agree.

And fwiw, I had proposed somewhere else already that we should start
restricting thread-group exec to the thread-group leader because
subthread exec is about as ugly as it can get.

I'd like to add a sysctl for this with the goal of removing this
completely in the future. I think there are very few if any legitimate
cases for subthread aka non-thread-group leader exec. It not just
complicates things it also means two task switch TIDs which is super
confusing from userspace (It also complicates pidfd polling but that's
an aside.). I'll wip up a patch for this once I get back from travel.

> 
> Vast majority of programs are single-threaded when they exec with an
> unshared ->fs, so they don't need to bear any overhead nor complexity
> modulo a branch.
> 
> For any fucky case you can park yourself waiting for any pending exec to
> finish.

