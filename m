Return-Path: <linux-fsdevel+bounces-59431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DBCB38A0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 21:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A60E97B78DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 19:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5532E1F04;
	Wed, 27 Aug 2025 19:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="pONYcV+y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F331FCFEF
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 19:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756321671; cv=none; b=ISJydmpnSdSG7R78JI3BO0n/0pPtHcOPcKSXF8Y+jcFVXHiLNpA2Gw6pyDKxra0pjJ9BnaXivfC+4us93Z8BDxJN70xF/cLsIqk+KS6Tw1RlCYtGeaaZUbB5i2AcStY/H51L+fgweF2SvIoKg25lqE+mTpGt0x6ZtR01ZfB9/N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756321671; c=relaxed/simple;
	bh=yX4JaxYCqw7dNQZwvPW9Tw6mUMQKXHiEjTBjE5noi8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EE7jB9mhPjxndqlDS8FtEg+eSAK1x2TXkGzQ4yAGuvtPgxzjVSdgPPXJC8++kll4Uip3sSGkrxamuYnfHYcW5wamMWeJsvV9/RFgYOJHecS6vP0oaBTwmgLrp8gz53Ag+4YyiYIKhveWGD3jEUIw/p9YtBdrXBqBn8AeSWp55C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=pONYcV+y; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cBvDX2wjWzd0K;
	Wed, 27 Aug 2025 21:07:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1756321660;
	bh=25MkTZUYf918F1U+hOS4n8oVEnZ1pOr2pnn7VTbbS7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pONYcV+yus1UGCmv8aS92t7WD2FIBajAKgTy8ZCr+p5H6crAPU4gpTYYYwcYmn+FV
	 HteEXLrnzALkVP+3LLs6eec4R8QTSZxF9pOxXpxUIcjJh6TlRD38kIjMqBOyQx+G87
	 nKanc1siKvNLTQFi15PK9i3tBDcP0Bmczs216KSk=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4cBvDV2XqRz7Kg;
	Wed, 27 Aug 2025 21:07:38 +0200 (CEST)
Date: Wed, 27 Aug 2025 21:07:35 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Andy Lutomirski <luto@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <keescook@chromium.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <serge@hallyn.com>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Elliott Hughes <enh@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jordan R Abrahams <ajordanr@google.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Luca Boccassi <bluca@debian.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Robert Waite <rowait@microsoft.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Scott Shell <scottsh@microsoft.com>, Steve Dower <steve.dower@python.org>, 
	Steve Grubb <sgrubb@redhat.com>, kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/2] Add O_DENY_WRITE (complement AT_EXECVE_CHECK)
Message-ID: <20250827.Fuo1Iel1pa7i@digikod.net>
References: <20250822170800.2116980-1-mic@digikod.net>
 <20250826-skorpion-magma-141496988fdc@brauner>
 <20250826.aig5aiShunga@digikod.net>
 <20250826123041.GB1603531@mit.edu>
 <20250826.iewie7Et5aiw@digikod.net>
 <CALCETrW=V9vst_ho2Q4sQUJ5uZECY5h7TnF==sG4JWq8PsWb8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrW=V9vst_ho2Q4sQUJ5uZECY5h7TnF==sG4JWq8PsWb8Q@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Aug 27, 2025 at 10:35:28AM -0700, Andy Lutomirski wrote:
> On Tue, Aug 26, 2025 at 10:47 AM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > On Tue, Aug 26, 2025 at 08:30:41AM -0400, Theodore Ts'o wrote:
> > > Is there a single, unified design and requirements document that
> > > describes the threat model, and what you are trying to achieve with
> > > AT_EXECVE_CHECK and O_DENY_WRITE?  I've been looking at the cover
> > > letters for AT_EXECVE_CHECK and O_DENY_WRITE, and the documentation
> > > that has landed for AT_EXECVE_CHECK and it really doesn't describe
> > > what *are* the checks that AT_EXECVE_CHECK is trying to achieve:
> > >
> > >    "The AT_EXECVE_CHECK execveat(2) flag, and the
> > >    SECBIT_EXEC_RESTRICT_FILE and SECBIT_EXEC_DENY_INTERACTIVE
> > >    securebits are intended for script interpreters and dynamic linkers
> > >    to enforce a consistent execution security policy handled by the
> > >    kernel."
> >
> > From the documentation:
> >
> >   Passing the AT_EXECVE_CHECK flag to execveat(2) only performs a check
> >   on a regular file and returns 0 if execution of this file would be
> >   allowed, ignoring the file format and then the related interpreter
> >   dependencies (e.g. ELF libraries, script’s shebang).
> >
> > >
> > > Um, what security policy?
> >
> > Whether the file is allowed to be executed.  This includes file
> > permission, mount point option, ACL, LSM policies...
> 
> This needs *waaaaay* more detail for any sort of useful evaluation.
> Is an actual credible security policy rolling dice?  Asking ChatGPT?
> Looking at security labels?  Does it care who can write to the file,
> or who owns the file, or what the file's hash is, or what filesystem
> it's on, or where it came from?  Does it dynamically inspect the
> contents?  Is it controlled by an unprivileged process?

AT_EXECVE_CHECK only does the same checks as done by other execveat(2)
calls, but without actually executing the file/fd.

> 
> I can easily come up with security policies for which DENYWRITE is
> completely useless.  I can come up with convoluted and
> not-really-credible policies where DENYWRITE is important, but I'm
> honestly not sure that those policies are actually useful.  I'm
> honestly a bit concerned that AT_EXECVE_CHECK is fundamentally busted
> because it should have been parametrized by *what format is expected*
> -- it might be possible to bypass a policy by executing a perfectly
> fine Python script using bash, for example.

There have been a lot of bikesheding for the AT_EXECVE_CHECK patch
series, and a lot of discussions too (you where part of them).  We ended
up with this design, which is simple and follows the kernel semantic
(requested by Linus).

> 
> I genuinely have not come up with a security policy that I believe
> makes sense that needs AT_EXECVE_CHECK and DENYWRITE.  I'm not saying
> that such a policy does not exist -- I'm saying that I have not
> thought of such a thing after a few minutes of thought and reading
> these threads.

A simple use case is for systems that wants to enforce a
write-xor-execute policy e.g., thanks to mount point options.

> 
> 
> > > And then on top of it, why can't you do these checks by modifying the
> > > script interpreters?
> >
> > The script interpreter requires modification to use AT_EXECVE_CHECK.
> >
> > There is no other way for user space to reliably check executability of
> > files (taking into account all enforced security
> > policies/configurations).
> >
> 
> As mentioned above, even AT_EXECVE_CHECK does not obviously accomplish
> this goal.  If it were genuinely useful, I would much, much prefer a
> totally different API: a *syscall* that takes, as input, a file
> descriptor of something that an interpreter wants to execute and a
> whole lot of context as to what that interpreter wants to do with it.
> And I admit I'm *still* not convinced.

As mentioned above, AT_EXECVE_CHECK follows the kernel semantic. Nothing
fancy.

> 
> Seriously, consider all the unending recent attacks on LLMs an
> inspiration.  The implications of viewing an image, downscaling the
> image, possibly interpreting the image as something containing text,
> possibly following instructions in a given language contained in the
> image, etc are all wildly different.  A mechanism for asking for
> general permission to "consume this image" is COMPLETELY MISSING THE
> POINT.  (Never mind that the current crop of LLMs seem entirely
> incapable of constraining their own use of some piece of input, but
> that's a different issue and is besides the point here.)

You're asking about what should we consider executable.  This is a good
question, but AT_EXECVE_CHECK is there to answer another question: would
the kernel execute it or not?

