Return-Path: <linux-fsdevel+bounces-13606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3957871CD1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 12:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69100285D08
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 11:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915A25812B;
	Tue,  5 Mar 2024 11:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvBaNGpK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F9E1C6AD;
	Tue,  5 Mar 2024 11:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636608; cv=none; b=Pyrl6H2zxjTcrU+bL+W2Vy5+cq1mAIIqWYP1CPMFpTCnfhYreHr3T6Qu0bd3Mqwyth0wHR7F1xlqIX13MPuMJsym8tqGCIxA4gnJCjiQ3GkOcTjDahy5YzBUD0KMGde3/wy4N2U8VE3cDGi8/Vst7bOX5hEaMa1Hlo8PV0GVEyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636608; c=relaxed/simple;
	bh=CWsbl+d48blGuvvq/hiJnHb8eCwdGeKP67OqIvqbKVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ot0DIbjPB4Aue9PVlYegehm+sEX+PIvaSejlrfuzk4+wiJLYiW5Nwz7nkDfy2zm/NARMjf6PhG/bcnmjdi7A3K+Xq4u3zgDUFJcrdISkwK/JxBIIv5pOWLjkLnR6ffSIyhZTgaK9yrdv6dZ4y+JZ1tcN+cPJ59cWeez3J9xN3F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvBaNGpK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E302C433C7;
	Tue,  5 Mar 2024 11:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709636607;
	bh=CWsbl+d48blGuvvq/hiJnHb8eCwdGeKP67OqIvqbKVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lvBaNGpKF8VbnuFraQMyOVDjcZgCgt9N6u7Ba5VZKyfQsdEyYA0cX5A/9SD8FaRZ3
	 3XFOhrmT0dsEU6YRaOGcrBWYag06ujtBruRZtZck2CIInZN+Y6rtwkRausBuDEkkOq
	 JThj5M/gYoFEYO3N4sKpl+6FCQ3mQnIRmBgNN3CFJypU9bkf+2RJvcTX6xW2yAHaNS
	 PxiQK7rq4fA1xBsKfffbmSYlDrrR/5ze1oF6fWYhYH+Lc/CsLXr1D6cvtzcISCiol+
	 lngTlZ1QjFCTrGXTrzjh79aPrBY9P2KY2sFxtOYfLlWqBmFoqfvISthONRAyM681sC
	 kMc+Knqd67ITA==
Date: Tue, 5 Mar 2024 12:03:21 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kees Cook <keescook@chromium.org>, 
	Matthew Denton <mpdenton@chromium.org>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>, 
	linux-fsdevel@vger.kernel.org, kernel@collabora.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Guenter Roeck <groeck@chromium.org>, 
	Doug Anderson <dianders@chromium.org>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Mike Frysinger <vapier@chromium.org>
Subject: Re: [PATCH v2] proc: allow restricting /proc/pid/mem writes
Message-ID: <20240305-gremien-faucht-29973b61fb57@brauner>
References: <20240301213442.198443-1-adrian.ratiu@collabora.com>
 <20240304-zugute-abtragen-d499556390b3@brauner>
 <202403040943.9545EBE5@keescook>
 <20240305-attentat-robust-b0da8137b7df@brauner>
 <202403050134.784D787337@keescook>
 <20240305-kontakt-ticken-77fc8f02be1d@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240305-kontakt-ticken-77fc8f02be1d@brauner>

On Tue, Mar 05, 2024 at 10:58:31AM +0100, Christian Brauner wrote:
> On Tue, Mar 05, 2024 at 01:41:29AM -0800, Kees Cook wrote:
> > On Tue, Mar 05, 2024 at 09:59:47AM +0100, Christian Brauner wrote:
> > > > > Uhm, this will break the seccomp notifier, no? So you can't turn on
> > > > > SECURITY_PROC_MEM_RESTRICT_WRITE when you want to use the seccomp
> > > > > notifier to do system call interception and rewrite memory locations of
> > > > > the calling task, no? Which is very much relied upon in various
> > > > > container managers and possibly other security tools.
> > > > > 
> > > > > Which means that you can't turn this on in any of the regular distros.
> > > > 
> > > > FWIW, it's a run-time toggle, but yes, let's make sure this works
> > > > correctly.
> > > > 
> > > > > So you need to either account for the calling task being a seccomp
> > > > > supervisor for the task whose memory it is trying to access or you need
> > > > > to provide a migration path by adding an api that let's caller's perform
> > > > > these writes through the seccomp notifier.
> > > > 
> > > > How do seccomp supervisors that use USER_NOTIF do those kinds of
> > > > memory writes currently? I thought they were actually using ptrace?
> > > > Everything I'm familiar with is just using SECCOMP_IOCTL_NOTIF_ADDFD,
> > > > and not doing fancy memory pokes.
> > > 
> > > For example, incus has a seccomp supervisor such that each container
> > > gets it's own goroutine that is responsible for handling system call
> > > interception.
> > > 
> > > If a container is started the container runtime connects to an AF_UNIX
> > > socket to register with the seccomp supervisor. It stays connected until
> > > it stops. Everytime a system call is performed that is registered in the
> > > seccomp notifier filter the container runtime will send a AF_UNIX
> > > message to the seccomp supervisor. This will include the following fds:
> > > 
> > > - the pidfd of the task that performed the system call (we should
> > >   actually replace this with SO_PEERPIDFD now that we have that)
> > > - the fd of the task's memory to /proc/<pid>/mem
> > > 
> > > The seccomp supervisor will then perform the system call interception
> > > including the required memory reads and writes.
> > 
> > Okay, so the patch would very much break that. Some questions, though:
> > - why not use process_vm_writev()?
> 
> Because it's inherently racy as I've explained in an earlier mail in
> this thread. Opening /proc/<pid>/mem we can guard via:
> 
> // Assume we hold @pidfd for supervised process
> 
> int fd_mem = open("/proc/$pid/mem", O_RDWR);:
> 
> if (pidfd_send_signal(pidfd, 0, ...) == 0)
>         write(fd_mem, ...);
> 
> But we can't exactly do:
> 
> process_vm_writev(pid, WRITE_TO_MEMORY, ...);
> if (pidfd_send_signal(pidfd, 0, ...) == 0)
>         write(fd_mem, ...);
> 
> That's always racy. The process might have been reaped before we even
> call pidfd_send_signal() and we're writing to some random process
> memory.
> 
> If we wanted to support this we'd need to implement a proposal I had a
> while ago:
> 
> #define PROCESS_VM_RW_PIDFD (1 << 0)
> 
> process_vm_readv(pidfd,  ..., PROCESS_VM_RW_PIDFD);
> process_vm_writev(pidfd, ..., PROCESS_VM_RW_PIDFD);
> 
> which is similar to what we did for waitid(pidfd, P_PIDFD, ...)
> 
> That would make it possible to use a pidfd instead of a pid in the two
> system calls. Then we can get rid of the raciness and actually use those
> system calls. As they are now, we can't.

What btw, is the Linux sandbox on Chromium doing? Did they finally move
away from SECCOMP_RET_TRAP to SECCOMP_RET_USER_NOTIF? I see:

https://issues.chromium.org/issues/40145101

What ever became of this?

