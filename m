Return-Path: <linux-fsdevel+bounces-59193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9709CB35F49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 14:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DBD4364F24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 12:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6CD342CAE;
	Tue, 26 Aug 2025 12:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="cbQYMRuL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE9733CEB3
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756211999; cv=none; b=lVJ6aEC9HDamt0gXHQfUJlLyJgZhhZRYAcJaleyNvrksVIPlIXcFeKaBhtEcfyUWx/egu1fQjuwY33YDSXqCVAogsDX7cikPeEC7alOy+VFvBMaN8UWuhkSstCWBYa9yb+UZ4SK2jDug9KEaZDagiijs3NYM7aFIxKiw1FioR3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756211999; c=relaxed/simple;
	bh=owvMDeO/rtDHrufbsOnTU4uMOllTaekHA/NSLoICYxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeVfxmOM4Zpf2Q/0bfbYpr2CW+dBh5A7MtBxpYqIX982ACMQ4n6sUqzh/RbjM1osttZ4KN/zdvU0aVDpyhpsny3/cPCAMgy3IJl2LJ5ANVWKkdUCVlX4MhWxh6XSGthuyv/m2lP0Oz6L5KGSu3GP9T2YHv39soV/jVvqwjVo3EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=cbQYMRuL; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cB6gS6rgVz9FT;
	Tue, 26 Aug 2025 14:39:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1756211988;
	bh=r4zF4RcKacPFfRNA+PbpvCuNO0g7TdTS1E1lESdaE7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cbQYMRuLroBswXOyC1WyYIqvpUevslZjEnsUVdI9SIVI06yhHgz+LzXTD0QhiO2dQ
	 pfj1DCfCLWP6L7FZ7u1ZA1BNdjenl/N6ulUl9YxWBzupi5bIJR8dFM/BM4fQr69av0
	 5/8JrhUh0G8E+omTpuztKSqfC4VizJMewcTb5+x0=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4cB6gR6sZbzMtQ;
	Tue, 26 Aug 2025 14:39:47 +0200 (CEST)
Date: Tue, 26 Aug 2025 14:39:47 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jeff Xu <jeffxu@google.com>
Cc: Andy Lutomirski <luto@amacapital.net>, Jann Horn <jannh@google.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <serge@hallyn.com>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Elliott Hughes <enh@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Robert Waite <rowait@microsoft.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Scott Shell <scottsh@microsoft.com>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
Subject: Re: [RFC PATCH v1 1/2] fs: Add O_DENY_WRITE
Message-ID: <20250826.eWi6chuayae4@digikod.net>
References: <20250822170800.2116980-1-mic@digikod.net>
 <20250822170800.2116980-2-mic@digikod.net>
 <CAG48ez1XjUdcFztc_pF2qcoLi7xvfpJ224Ypc=FoGi-Px-qyZw@mail.gmail.com>
 <20250824.Ujoh8unahy5a@digikod.net>
 <CALCETrWwd90qQ3U2nZg9Fhye6CMQ6ZF20oQ4ME6BoyrFd0t88Q@mail.gmail.com>
 <20250825.mahNeel0dohz@digikod.net>
 <CALmYWFv90uzq0J76+xtUFjZxDzR2rYvrFbrr5Jva5zdy_dvoHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALmYWFv90uzq0J76+xtUFjZxDzR2rYvrFbrr5Jva5zdy_dvoHA@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Mon, Aug 25, 2025 at 10:57:57AM -0700, Jeff Xu wrote:
> Hi Mickaël
> 
> On Mon, Aug 25, 2025 at 2:31 AM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > On Sun, Aug 24, 2025 at 11:04:03AM -0700, Andy Lutomirski wrote:
> > > On Sun, Aug 24, 2025 at 4:03 AM Mickaël Salaün <mic@digikod.net> wrote:
> > > >
> > > > On Fri, Aug 22, 2025 at 09:45:32PM +0200, Jann Horn wrote:
> > > > > On Fri, Aug 22, 2025 at 7:08 PM Mickaël Salaün <mic@digikod.net> wrote:
> > > > > > Add a new O_DENY_WRITE flag usable at open time and on opened file (e.g.
> > > > > > passed file descriptors).  This changes the state of the opened file by
> > > > > > making it read-only until it is closed.  The main use case is for script
> > > > > > interpreters to get the guarantee that script' content cannot be altered
> > > > > > while being read and interpreted.  This is useful for generic distros
> > > > > > that may not have a write-xor-execute policy.  See commit a5874fde3c08
> > > > > > ("exec: Add a new AT_EXECVE_CHECK flag to execveat(2)")
> > > > > >
> > > > > > Both execve(2) and the IOCTL to enable fsverity can already set this
> > > > > > property on files with deny_write_access().  This new O_DENY_WRITE make
> > > > >
> > > > > The kernel actually tried to get rid of this behavior on execve() in
> > > > > commit 2a010c41285345da60cece35575b4e0af7e7bf44.; but sadly that had
> > > > > to be reverted in commit 3b832035387ff508fdcf0fba66701afc78f79e3d
> > > > > because it broke userspace assumptions.
> > > >
> > > > Oh, good to know.
> > > >
> > > > >
> > > > > > it widely available.  This is similar to what other OSs may provide
> > > > > > e.g., opening a file with only FILE_SHARE_READ on Windows.
> > > > >
> > > > > We used to have the analogous mmap() flag MAP_DENYWRITE, and that was
> > > > > removed for security reasons; as
> > > > > https://man7.org/linux/man-pages/man2/mmap.2.html says:
> > > > >
> > > > > |        MAP_DENYWRITE
> > > > > |               This flag is ignored.  (Long ago—Linux 2.0 and earlier—it
> > > > > |               signaled that attempts to write to the underlying file
> > > > > |               should fail with ETXTBSY.  But this was a source of denial-
> > > > > |               of-service attacks.)"
> > > > >
> > > > > It seems to me that the same issue applies to your patch - it would
> > > > > allow unprivileged processes to essentially lock files such that other
> > > > > processes can't write to them anymore. This might allow unprivileged
> > > > > users to prevent root from updating config files or stuff like that if
> > > > > they're updated in-place.
> > > >
> > > > Yes, I agree, but since it is the case for executed files I though it
> > > > was worth starting a discussion on this topic.  This new flag could be
> > > > restricted to executable files, but we should avoid system-wide locks
> > > > like this.  I'm not sure how Windows handle these issues though.
> > > >
> > > > Anyway, we should rely on the access control policy to control write and
> > > > execute access in a consistent way (e.g. write-xor-execute).  Thanks for
> > > > the references and the background!
> > >
> > > I'm confused.  I understand that there are many contexts in which one
> > > would want to prevent execution of unapproved content, which might
> > > include preventing a given process from modifying some code and then
> > > executing it.
> > >
> > > I don't understand what these deny-write features have to do with it.
> > > These features merely prevent someone from modifying code *that is
> > > currently in use*, which is not at all the same thing as preventing
> > > modifying code that might get executed -- one can often modify
> > > contents *before* executing those contents.
> >
> > The order of checks would be:
> > 1. open script with O_DENY_WRITE
> > 2. check executability with AT_EXECVE_CHECK
> > 3. read the content and interpret it
> >
> I'm not sure about the O_DENY_WRITE approach, but the problem is worth solving.
> 
> AT_EXECVE_CHECK is not just for scripting languages. It could also
> work with bytecodes like Java, for example. If we let the Java runtime
> call AT_EXECVE_CHECK before loading the bytecode, the LSM could
> develop a policy based on that.

Sure, I'm using "script" to make it simple, but this applies to other
use cases.

> 
> > The deny-write feature was to guarantee that there is no race condition
> > between step 2 and 3.  All these checks are supposed to be done by a
> > trusted interpreter (which is allowed to be executed).  The
> > AT_EXECVE_CHECK call enables the caller to know if the kernel (and
> > associated security policies) allowed the *current* content of the file
> > to be executed.  Whatever happen before or after that (wrt.
> > O_DENY_WRITE) should be covered by the security policy.
> >
> Agree, the race problem needs to be solved in order for AT_EXECVE_CHECK.
> 
> Enforcing non-write for the path that stores scripts or bytecodes can
> be challenging due to historical or backward compatibility reasons.
> Since AT_EXECVE_CHECK provides a mechanism to check the file right
> before it is used, we can assume it will detect any "problem" that
> happened before that, (e.g. the file was overwritten). However, that
> also imposes two additional requirements:
> 1> the file doesn't change while AT_EXECVE_CHECK does the check.

This is already the case, so any kind of LSM checks are good.

> 2>The file content kept by the process remains unchanged after passing
> the AT_EXECVE_CHECK.

The goal of this patch was to avoid such race condition in the case
where executable files can be updated.  But in most cases it should not
be a security issue (because processes allowed to write to executable
files should be trusted), but this could still lead to bugs (because of
inconsistent file content, half-updated).

> 
> I imagine, the complete solution for AT_EXECVE_CHECK would include
> those two grantees.

There is no issue directly with AT_EXECVE_CHECK, but according to the
system configuration, interpreters could read a file that was updated
after the AT_EXECVE_CHECK.  This should not be an issue for secure
systems where executable files are only updated with trusted code,
except if the update mechanism is not atomic.  The main use case for
this patch series was for generic distros that may not have the
write-xor-execute guarantees e.g., for developers.

The only viable solution I see would be to have some kind of snapshot of
files, requested by interpreters, but I'm not sure if it is worth it.

