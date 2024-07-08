Return-Path: <linux-fsdevel+bounces-23321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933B792A942
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 20:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B67E01C21552
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 18:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F249D14D2A7;
	Mon,  8 Jul 2024 18:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="jO1hYhMl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01261482E6
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jul 2024 18:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720464545; cv=none; b=MUjLRs5Ax2f8KOrQr31z+JAKyoRiNqJojWChvqUtgiZTim9mHSMjlLPG7ziriVzbyF1AKRI7o68EDAUsG1NtF2MxAicvtUFV7zKfZiKAxbm/bEb4ee8o4+MSjfuKefAkIDJL/DVOfySI2Y2tA3G0ILtgeQHJ2aHE31An1/3yEdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720464545; c=relaxed/simple;
	bh=Hl4YvBV8go4slZ9IoVL2J+Wu0va4qX9+10GlwhRiRZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tz1MdtWoewPSPg5V9r29724/TDY3ckuTFWJ+yhgQMYY84GP4chu+Vdub9HiOI3XiopPS6BPJhENCEgUKcpBKkUCeuspzfXQQKvNu3249zK7hAy5SQNXYP/5OXlCPtl9xDKk9ZQrTyAB0qeBvICuhwYBbLBJkCEw0BKrlPtFZ1UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=jO1hYhMl; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WHtSQ1wggzLb3;
	Mon,  8 Jul 2024 20:48:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1720464534;
	bh=iGXt0xsa3rS+/5ZnuSgBxf26AIJNKWTQ+ZK/8T1K4CM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jO1hYhMlGqC2ihtxiG/svAn1L92DGAbJ6eAS3yD5ZKxhQ3AdxbeN5fJriToJdDSgg
	 ryDPCfrGOoXTm2F/V6eUSsZFDxd6tFLvQnTTac3vdlzGuPXg/qcukz0bhempjggIVm
	 AdQj8yI4MkSKKodTr+Dx8IwSZGUsdXAtS/AOWeLo=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WHtSL2dRBzWFC;
	Mon,  8 Jul 2024 20:48:50 +0200 (CEST)
Date: Mon, 8 Jul 2024 20:48:47 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jeff Xu <jeffxu@google.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Paul Moore <paul@paul-moore.com>, Theodore Ts'o <tytso@mit.edu>, 
	Alejandro Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Eric Chiang <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	James Morris <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jordan R Abrahams <ajordanr@google.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Luca Boccassi <bluca@debian.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Matthew Garrett <mjg59@srcf.ucam.org>, 
	Matthew Wilcox <willy@infradead.org>, Miklos Szeredi <mszeredi@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, 
	Scott Shell <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Steve Dower <steve.dower@python.org>, 
	Steve Grubb <sgrubb@redhat.com>, Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, 
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>, Xiaoming Ni <nixiaoming@huawei.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v19 2/5] security: Add new SHOULD_EXEC_CHECK and
 SHOULD_EXEC_RESTRICT securebits
Message-ID: <20240708.quoe8aeSaeRi@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
 <20240704190137.696169-3-mic@digikod.net>
 <CALmYWFscz5W6xSXD-+dimzbj=TykNJEDa0m5gvBx93N-J+3nKA@mail.gmail.com>
 <CALmYWFsLUhkU5u1NKH8XWvSxbFKFOEq+A_eqLeDsN29xOEAYgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALmYWFsLUhkU5u1NKH8XWvSxbFKFOEq+A_eqLeDsN29xOEAYgg@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Mon, Jul 08, 2024 at 10:53:11AM -0700, Jeff Xu wrote:
> On Mon, Jul 8, 2024 at 9:17 AM Jeff Xu <jeffxu@google.com> wrote:
> >
> > Hi
> >
> > On Thu, Jul 4, 2024 at 12:02 PM Mickaël Salaün <mic@digikod.net> wrote:
> > >
> > > These new SECBIT_SHOULD_EXEC_CHECK, SECBIT_SHOULD_EXEC_RESTRICT, and
> > > their *_LOCKED counterparts are designed to be set by processes setting
> > > up an execution environment, such as a user session, a container, or a
> > > security sandbox.  Like seccomp filters or Landlock domains, the
> > > securebits are inherited across proceses.
> > >
> > > When SECBIT_SHOULD_EXEC_CHECK is set, programs interpreting code should
> > > check executable resources with execveat(2) + AT_CHECK (see previous
> > > patch).
> > >
> > > When SECBIT_SHOULD_EXEC_RESTRICT is set, a process should only allow
> > > execution of approved resources, if any (see SECBIT_SHOULD_EXEC_CHECK).
> > >
> > Do we need both bits ?
> > When CHECK is set and RESTRICT is not, the "check fail" executable
> > will still get executed, so CHECK is for logging ?
> > Does RESTRICT imply CHECK is set, e.g. What if CHECK=0 and RESTRICT = 1 ?
> >
> The intention might be "permissive mode"?  if so, consider reuse
> existing selinux's concept, and still with 2 bits:
> SECBIT_SHOULD_EXEC_RESTRICT
> SECBIT_SHOULD_EXEC_RESTRICT_PERMISSIVE

SECBIT_SHOULD_EXEC_CHECK is for user space to check with execveat+AT_CHECK.

SECBIT_SHOULD_EXEC_RESTRICT is for user space to restrict execution by
default, and potentially allow some exceptions from the list of
checked-and-allowed files, if SECBIT_SHOULD_EXEC_CHECK is set.

Without SECBIT_SHOULD_EXEC_CHECK, SECBIT_SHOULD_EXEC_RESTRICT is to deny
any kind of execution/interpretation.

With only SECBIT_SHOULD_EXEC_CHECK, user space should just check and log
any denied access, but ignore them.  So yes, it is similar to the
SELinux's permissive mode.

This is explained in the next patch as comments.

The *_LOCKED variants are useful and part of the securebits concept.

> 
> 
> -Jeff
> 
> 
> 
> 
> > > For a secure environment, we might also want
> > > SECBIT_SHOULD_EXEC_CHECK_LOCKED and SECBIT_SHOULD_EXEC_RESTRICT_LOCKED
> > > to be set.  For a test environment (e.g. testing on a fleet to identify
> > > potential issues), only the SECBIT_SHOULD_EXEC_CHECK* bits can be set to
> > > still be able to identify potential issues (e.g. with interpreters logs
> > > or LSMs audit entries).
> > >
> > > It should be noted that unlike other security bits, the
> > > SECBIT_SHOULD_EXEC_CHECK and SECBIT_SHOULD_EXEC_RESTRICT bits are
> > > dedicated to user space willing to restrict itself.  Because of that,
> > > they only make sense in the context of a trusted environment (e.g.
> > > sandbox, container, user session, full system) where the process
> > > changing its behavior (according to these bits) and all its parent
> > > processes are trusted.  Otherwise, any parent process could just execute
> > > its own malicious code (interpreting a script or not), or even enforce a
> > > seccomp filter to mask these bits.
> > >
> > > Such a secure environment can be achieved with an appropriate access
> > > control policy (e.g. mount's noexec option, file access rights, LSM
> > > configuration) and an enlighten ld.so checking that libraries are
> > > allowed for execution e.g., to protect against illegitimate use of
> > > LD_PRELOAD.
> > >
> > > Scripts may need some changes to deal with untrusted data (e.g. stdin,
> > > environment variables), but that is outside the scope of the kernel.
> > >
> > > The only restriction enforced by the kernel is the right to ptrace
> > > another process.  Processes are denied to ptrace less restricted ones,
> > > unless the tracer has CAP_SYS_PTRACE.  This is mainly a safeguard to
> > > avoid trivial privilege escalations e.g., by a debugging process being
> > > abused with a confused deputy attack.
> > >
> > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Paul Moore <paul@paul-moore.com>
> > > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > > Link: https://lore.kernel.org/r/20240704190137.696169-3-mic@digikod.net
> > > ---

