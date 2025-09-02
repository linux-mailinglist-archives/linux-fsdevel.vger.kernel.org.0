Return-Path: <linux-fsdevel+bounces-59954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA04B3F88D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 10:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9780A1A84046
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 08:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC442E92D4;
	Tue,  2 Sep 2025 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlVFgOpZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45CB2E8E0D;
	Tue,  2 Sep 2025 08:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802000; cv=none; b=tOHZCOn1oSzPHcE2uMhHrGbqULPn5Gzfs7EtmkikKKvj2uq6SP4DVEGEahM8hx/HQD2ofrggx8BC5UmLy1LAZtDr2IcfEXcLukEyborO/vBt2J2oM9ZAZw1998/fDWhfxbDTSKteIOQ3QKFY2E37p+z8tYWpt2wqABiiGjUtS4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802000; c=relaxed/simple;
	bh=IAUToj+bzLErcKE3mkfZFwKR6ru5C17HBgUlEv7h524=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwesCpyDvp+VT5huHLp1mtxpzvLhDSQmMYbyWqhbqb0aILEZJGX4LR5bH9h+2vZwKJnt0xZidAfWRsPfsf1gSuPFnlzdC4Y+J75AL8a4fl9mlWlE8NziRLWlPDqjuB5w75XobQPT7clzQ4Nu75Z+WaKouH+la/nZ1IGuAcoktdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlVFgOpZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF06C4CEED;
	Tue,  2 Sep 2025 08:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756801999;
	bh=IAUToj+bzLErcKE3mkfZFwKR6ru5C17HBgUlEv7h524=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NlVFgOpZffJVaiNWHDtCuP9h2C1LdZr68pJ+nFz1v7zWjlVSFhy9yCyvOb0DTeAob
	 97Ct9BSVDNjn5I1cVmECCE6tej1XCHhRygYQyt/M4m1iK/18LY+kgC3Fap6dtdK8nf
	 zKdlcRFhz2Diaa0QpOzjaTtCWmVkmik/MBJnJdenOIoncIIM4ntaaUD7c7QshWhyP/
	 NkswXxixqUyfY8768oSXee0V5RKxVYtbACynze6z7YSiy89+744eAxp3MUB0b8jqNr
	 jdBhx2/JQR6g7kLcyJjKLjPf9eUZJ+LkCDT8ehbCLbDC+AC230h55MhR2M3zub+qTQ
	 OQ1+PphzUBt3A==
Date: Tue, 2 Sep 2025 10:33:15 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Alexander Monakov <amonakov@ispras.ru>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: ETXTBSY window in __fput
Message-ID: <20250902-faust-kolibri-0898c1980de8@brauner>
References: <6e60aa72-94ef-9de2-a54c-ffd91fcc4711@ispras.ru>
 <u4vg6vh4myt5wuytwiif72hlgdnp2xmwu6mdmgarbx677sv6uf@dnr6x7epvddl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <u4vg6vh4myt5wuytwiif72hlgdnp2xmwu6mdmgarbx677sv6uf@dnr6x7epvddl>

On Mon, Sep 01, 2025 at 08:39:27PM +0200, Mateusz Guzik wrote:
> On Wed, Aug 27, 2025 at 12:05:38AM +0300, Alexander Monakov wrote:
> > Dear fs hackers,
> > 
> > I suspect there's an unfortunate race window in __fput where file locks are
> > dropped (locks_remove_file) prior to decreasing writer refcount
> > (put_file_access). If I'm not mistaken, this window is observable and it
> > breaks a solution to ETXTBSY problem on exec'ing a just-written file, explained
> > in more detail below.
> > 
> > The program demonstrating the problem is attached (a slightly modified version
> > of the demo given by Russ Cox on the Go issue tracker, see URL in first line).
> > It makes 20 threads, each executing an infinite loop doing the following:
> > 
> > 1) open an fd for writing with O_CLOEXEC
> > 2) write executable code into it
> > 3) close it
> > 4) fork
> > 5) in the child, attempt to execve the just-written file
> > 
> > If you compile it with -DNOWAIT, you'll see that execve often fails with
> > ETXTBSY.
> 
> This problem was reported a few times and is quite ancient by now.
> 
> While acknowleding the resulting behavior needs to be fixed, I find the
> proposed solutions are merely trying to put more lipstick or a wig on a
> pig.
> 
> The age of the problem suggests it is not *urgent* to fix it.
> 
> The O_CLOFORM idea was accepted into POSIX and recent-ish implemented in
> all the BSDs (no, really) and illumos, but got NAKed in Linux. It's also
> a part of pig's attire so I think that's the right call.
> 
> Not denying execs of files open for writing had to get reverted as
> apparently some software depends on it, so that's a no-go either.
> 
> The flag proposed by Christian elsewhere in the thread would sort this
> out, but it's just another hack which would serve no purpose if the
> issue stopped showing up.
> 
> The real problem is fork()+execve() combo being crap syscalls with crap
> semantics, perpetuating the unix tradition of screwing you over unless
> you explicitly ask it not to (e.g., with O_CLOEXEC so that the new proc
> does not hang out with surprise fds).
> 
> While I don't have anything fleshed out nor have any interest in putting
> any work in the area, I would suggest anyone looking to solve the ETXTBSY
> went after the real culprit instead of damage-controlling the current
> API.
> 
> To that end, my sketch of a suggestion boils down to a new API which
> allows you to construct a new process one step at a time explicitly
> spelling out resources which are going to get passed on, finally doing
> an actual exec. You would start with getting a file descriptor to a new
> task_struct which you gradually populate and eventually exec something
> on. There would be no forking.
> 
> It could look like this (ignore specific naming):
> 
> /* get a file descriptor for the new process. there is no *fork* here,
>  * but task_struct & related get allocated
>  * clean slate, no sigmask bullshit and similar
>  */
> pfd = proc_new();
> 
> nullfd = open("/dev/null", O_RDONLY);
> 
> /* map /dev/null as 0/1/2 in the new proc */
> proc_install_fd(pfd, nullfd, 0); 
> proc_install_fd(pfd, nullfd, 2); 
> proc_install_fd(pfd, nullfd, 2); 
> 
> /* if we can run the proc as someone else, set it up here */
> proc_install_cred(pfd, uid, gid, groups, ...);
> 
> proc_set_umask(pfd, ...);
> 
> /* finally exec */
> proc_exec_by_path("/bin/sh", argp, envp);

You can trivially build this API on top of pidfs. Like:

pidfd_empty = pidfd_open(FD_PIDFS_ROOT/FD_INVALID, PIDFD_EMPTY)

where FD_PIDFS_ROOT and FD_INVALID are things we already have in the
uapi headers.

Then either just add a new system call like pidfd_config() or just use
ioctls() on that empty pidfd.

With pidfs you have the complete freedom to implement that api however
you want.

I had a prototype for that as well but I can't find it anymore. Other
VFS work took priority and so I never finished it but I remember it
wasn't very difficult.

I would definitely merge a patch series like that.

> 
> Notice how not once at any point random-ass file descriptors popped into
> the new task, which has a side effect of completely avoiding the
> problem.
> 
> you may also notice this should be faster to execute as it does not have
> to pay the mm overhead.
> 
> While proc_install_fd is spelled out as singular syscalls, this can be
> batched to accept an array of <from, to> pairs etc.
> 
> Also notice the thread executing it is not shackled by any of vfork
> limitations.
> 
> So... if someone is serious about the transient ETXTBSY, I would really
> hope you will consider solving the source of the problem, even if you
> come up with someting other than I did (hopefully better). It would be a
> damn shame to add even more hacks to pacify this problem (like the O_
> stuff).
> 
> What to do in the meantime? There is a lol hack you can do in userspace
> which so ugly I'm not even going to spell it out, but given the
> temporary nature of ETXTBSY I'm sure you can guess what it is.
> 
> Something to ponder, cheers.

