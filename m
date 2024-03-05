Return-Path: <linux-fsdevel+bounces-13590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F59871A15
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 10:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5F61F21B7F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 09:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BADA54750;
	Tue,  5 Mar 2024 09:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ambo0nUm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B1350246;
	Tue,  5 Mar 2024 09:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709632711; cv=none; b=CZm/byPVCrE7BAz9czEqel7T0PEV9pOn72RCAwPdgNx72Lq6MuvanT6jsnCsYc/WMTAz1GgiDtNEStQc5eJESl0Phh5N48HsrbDRQJzhWaZoMvIiOTuv9uRpBsJm83yz5O3/LwQ9sl0v5vaIRXY5E4VBfCNN580FhH7D+qVouJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709632711; c=relaxed/simple;
	bh=/4mH6blz+OXbyiAZdJXapeZYAAHshdm8yjRhaiNohG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gp/aF+TASY7rqHsTMYY146WTc+ex4CyBR4AjTaBkNKT8OF/EIXK1D4NbujjPqzCGUu/muqOfw5FkDUjM3ghMx1rXx9+5qKjJWxYYphrGq+wSUozqsEbQ5DQrp2Nj9ipN/WsRc5I4WhTfqJr5T8ilmhMZES6e/9zJsosBJ2Rv+wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ambo0nUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4ECC433F1;
	Tue,  5 Mar 2024 09:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709632711;
	bh=/4mH6blz+OXbyiAZdJXapeZYAAHshdm8yjRhaiNohG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ambo0nUmKbxaZC2hyphDe3+VrmUQkQMnghESDL91tOcycm/8gzmlrBxbmyuP7owm5
	 9YdNAqmjdAcc91XJxDV4+GSTpoMBy557B6lF1np0wFkis1b2oUxWzzblBu+PeJbVih
	 D5UtafeVnQTOaeQnFhjMjm38EswV2h+tuACEpWbiVmiENBzotksuhpGJd6TZQvFwJH
	 hevskSUIRUI/fA/8aYM6Mdwjoe4fmcKCgs/Ebu9xHYfOgc4U8Rm9CJLxAPnu9jkvSb
	 Xld6fNHXfA5lIuwIetidOy9YqB3qUZiDx/ZN+bzC5WAfyXcAm7h8wruFJtRjicoy//
	 ddcLizSRVMCxw==
Date: Tue, 5 Mar 2024 10:58:25 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>, 
	linux-fsdevel@vger.kernel.org, kernel@collabora.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Guenter Roeck <groeck@chromium.org>, 
	Doug Anderson <dianders@chromium.org>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Mike Frysinger <vapier@chromium.org>
Subject: Re: [PATCH v2] proc: allow restricting /proc/pid/mem writes
Message-ID: <20240305-kontakt-ticken-77fc8f02be1d@brauner>
References: <20240301213442.198443-1-adrian.ratiu@collabora.com>
 <20240304-zugute-abtragen-d499556390b3@brauner>
 <202403040943.9545EBE5@keescook>
 <20240305-attentat-robust-b0da8137b7df@brauner>
 <202403050134.784D787337@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202403050134.784D787337@keescook>

On Tue, Mar 05, 2024 at 01:41:29AM -0800, Kees Cook wrote:
> On Tue, Mar 05, 2024 at 09:59:47AM +0100, Christian Brauner wrote:
> > > > Uhm, this will break the seccomp notifier, no? So you can't turn on
> > > > SECURITY_PROC_MEM_RESTRICT_WRITE when you want to use the seccomp
> > > > notifier to do system call interception and rewrite memory locations of
> > > > the calling task, no? Which is very much relied upon in various
> > > > container managers and possibly other security tools.
> > > > 
> > > > Which means that you can't turn this on in any of the regular distros.
> > > 
> > > FWIW, it's a run-time toggle, but yes, let's make sure this works
> > > correctly.
> > > 
> > > > So you need to either account for the calling task being a seccomp
> > > > supervisor for the task whose memory it is trying to access or you need
> > > > to provide a migration path by adding an api that let's caller's perform
> > > > these writes through the seccomp notifier.
> > > 
> > > How do seccomp supervisors that use USER_NOTIF do those kinds of
> > > memory writes currently? I thought they were actually using ptrace?
> > > Everything I'm familiar with is just using SECCOMP_IOCTL_NOTIF_ADDFD,
> > > and not doing fancy memory pokes.
> > 
> > For example, incus has a seccomp supervisor such that each container
> > gets it's own goroutine that is responsible for handling system call
> > interception.
> > 
> > If a container is started the container runtime connects to an AF_UNIX
> > socket to register with the seccomp supervisor. It stays connected until
> > it stops. Everytime a system call is performed that is registered in the
> > seccomp notifier filter the container runtime will send a AF_UNIX
> > message to the seccomp supervisor. This will include the following fds:
> > 
> > - the pidfd of the task that performed the system call (we should
> >   actually replace this with SO_PEERPIDFD now that we have that)
> > - the fd of the task's memory to /proc/<pid>/mem
> > 
> > The seccomp supervisor will then perform the system call interception
> > including the required memory reads and writes.
> 
> Okay, so the patch would very much break that. Some questions, though:
> - why not use process_vm_writev()?

Because it's inherently racy as I've explained in an earlier mail in
this thread. Opening /proc/<pid>/mem we can guard via:

// Assume we hold @pidfd for supervised process

int fd_mem = open("/proc/$pid/mem", O_RDWR);:

if (pidfd_send_signal(pidfd, 0, ...) == 0)
        write(fd_mem, ...);

But we can't exactly do:

process_vm_writev(pid, WRITE_TO_MEMORY, ...);
if (pidfd_send_signal(pidfd, 0, ...) == 0)
        write(fd_mem, ...);

That's always racy. The process might have been reaped before we even
call pidfd_send_signal() and we're writing to some random process
memory.

If we wanted to support this we'd need to implement a proposal I had a
while ago:

#define PROCESS_VM_RW_PIDFD (1 << 0)

process_vm_readv(pidfd,  ..., PROCESS_VM_RW_PIDFD);
process_vm_writev(pidfd, ..., PROCESS_VM_RW_PIDFD);

which is similar to what we did for waitid(pidfd, P_PIDFD, ...)

That would make it possible to use a pidfd instead of a pid in the two
system calls. Then we can get rid of the raciness and actually use those
system calls. As they are now, we can't.

> - does the supervisor depend on FOLL_FORCE?

Since the write handler for /proc/<pid>/mem does raise FOLL_FORCE
unconditionally it likely would implicitly. But I'm not familiar enough
with FOLL_FORCE to say for sure.

> Perhaps is is sufficient to block the use of FOLL_FORCE?
> 
> I took a look at the Chrome OS exploit, and I _think_ it is depending
> on the FOLL_FORCE behavior (it searches for a symbol to overwrite that
> if I'm following correctly is in a read-only region), but some of the
> binaries don't include source code, so I couldn't easily see what was
> being injected. Mike or Adrian can you confirm this?

