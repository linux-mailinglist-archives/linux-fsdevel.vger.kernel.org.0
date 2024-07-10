Return-Path: <linux-fsdevel+bounces-23468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9508B92CEB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 11:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4854E289649
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 09:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89C718FA36;
	Wed, 10 Jul 2024 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="DaR54BNM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2A518FA2C
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2024 09:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720605523; cv=none; b=OQmeroa/9sLvFY/fuv6azur+pHyjVAlecCix4jaY7N1SA8o+SvvWyZTgmFUXCRog6fmChywyzI2hZC30Cg6DDcSwDwRonv4xjaNK1wPtMFn4OQ2cuEM230hFLwjT/EiFzohvQMCqSPTpkbO7TLlnv20Soi0lUyUdbte1s4e2tzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720605523; c=relaxed/simple;
	bh=ggCqrQBvrrG8yiVpZ2nE9VBvLg4UjjrGTkmALuvItEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnGKiRqhoH0c4kJxDEgdS+/kIn0qYkqK2Dzzr/DTnaGyjLUMp6dDaa9zaN0IQ6jzsWL+FI9DyoFofy6HQA0dV3TDeGBAGTl2FwnIqF0ZxH/elMhi3HiCi8ctoPZY+RYkJKICf8VwXgE5pTCg8qZzFq4/i5kPkjBqF42fvDkvK4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=DaR54BNM; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WJtbW6W7GzwkR;
	Wed, 10 Jul 2024 11:58:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1720605511;
	bh=GHxfhG9pyjM4wm0dM1heyMCWxzYAh2GXre8FZxnfg4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DaR54BNM5FcOyFu3r2Y5PjFq7SQW2EzQwlQsAFtZjZwHS6QM+njE0Li3ZTrdgBcK+
	 59QHiOa06zW0Cu2srNkVLIjfPCL75HDRLAOyqUgEp+NSyVTqA6Eug6UMynpMHjZiq2
	 Kn3NrWYZrdvGLmO6vnATSK+6LIS7Jw544KpmzJhY=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WJtbS484Bz8rt;
	Wed, 10 Jul 2024 11:58:28 +0200 (CEST)
Date: Wed, 10 Jul 2024 11:58:25 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jeff Xu <jeffxu@google.com>
Cc: Steve Dower <steve.dower@python.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Paul Moore <paul@paul-moore.com>, Theodore Ts'o <tytso@mit.edu>, 
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
	Stephen Rothwell <sfr@canb.auug.org.au>, Steve Grubb <sgrubb@redhat.com>, 
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, Vincent Strubel <vincent.strubel@ssi.gouv.fr>, 
	Xiaoming Ni <nixiaoming@huawei.com>, Yin Fengwei <fengwei.yin@intel.com>, 
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v19 2/5] security: Add new SHOULD_EXEC_CHECK and
 SHOULD_EXEC_RESTRICT securebits
Message-ID: <20240710.eiKohpa4Phai@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
 <20240704190137.696169-3-mic@digikod.net>
 <CALmYWFscz5W6xSXD-+dimzbj=TykNJEDa0m5gvBx93N-J+3nKA@mail.gmail.com>
 <CALmYWFsLUhkU5u1NKH8XWvSxbFKFOEq+A_eqLeDsN29xOEAYgg@mail.gmail.com>
 <20240708.quoe8aeSaeRi@digikod.net>
 <CALmYWFuVJiRZgB0ye9eR95dvBOigoOVShgS9i_ESjEre-H5pLA@mail.gmail.com>
 <ef3281ad-48a5-4316-b433-af285806540d@python.org>
 <CALmYWFuFE=V7sGp0_K+2Vuk6F0chzhJY88CP1CAE9jtd=rqcoQ@mail.gmail.com>
 <20240709.aech3geeMoh0@digikod.net>
 <CALmYWFuOXAiT05Pi2rZ1nUAKDGe9JyTH7fro2EYS1fh3zeGV5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALmYWFuOXAiT05Pi2rZ1nUAKDGe9JyTH7fro2EYS1fh3zeGV5Q@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Tue, Jul 09, 2024 at 02:57:43PM -0700, Jeff Xu wrote:
> On Tue, Jul 9, 2024 at 1:42 PM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > On Mon, Jul 08, 2024 at 03:07:24PM -0700, Jeff Xu wrote:
> > > On Mon, Jul 8, 2024 at 2:25 PM Steve Dower <steve.dower@python.org> wrote:
> > > >
> > > > On 08/07/2024 22:15, Jeff Xu wrote:
> > > > > IIUC:
> > > > > CHECK=0, RESTRICT=0: do nothing, current behavior
> > > > > CHECK=1, RESTRICT=0: permissive mode - ignore AT_CHECK results.
> > > > > CHECK=0, RESTRICT=1: call AT_CHECK, deny if AT_CHECK failed, no exception.
> > > > > CHECK=1, RESTRICT=1: call AT_CHECK, deny if AT_CHECK failed, except
> > > > > those in the "checked-and-allowed" list.
> > > >
> > > > I had much the same question for Mickaël while working on this.
> > > >
> > > > Essentially, "CHECK=0, RESTRICT=1" means to restrict without checking.
> > > > In the context of a script or macro interpreter, this just means it will
> > > > never interpret any scripts. Non-binary code execution is fully disabled
> > > > in any part of the process that respects these bits.
> > > >
> > > I see, so Mickaël does mean this will block all scripts.
> >
> > That is the initial idea.
> >
> > > I guess, in the context of dynamic linker, this means: no more .so
> > > loading, even "dlopen" is called by an app ?  But this will make the
> > > execve()  fail.
> >
> > Hmm, I'm not sure this "CHECK=0, RESTRICT=1" configuration would make
> > sense for a dynamic linker except maybe if we want to only allow static
> > binaries?
> >
> > The CHECK and RESTRICT securebits are designed to make it possible a
> > "permissive mode" and an enforcement mode with the related locked
> > securebits.  This is why this "CHECK=0, RESTRICT=1" combination looks a
> > bit weird.  We can replace these securebits with others but I didn't
> > find a better (and simple) option.  I don't think this is an issue
> > because with any security policy we can create unusable combinations.
> > The three other combinations makes a lot of sense though.
> >
> If we need only handle 3  combinations,  I would think something like
> below is easier to understand, and don't have wield state like
> CHECK=0, RESTRICT=1

The "CHECK=0, RESTRICT=1" is useful for script interpreter instances
that should not interpret any command from users e.g., but only execute
script files.

> 
> XX_RESTRICT: when true: Perform the AT_CHECK, and deny the executable
> after AT_CHECK fails.

> XX_RESTRICT_PERMISSIVE:  take effect when XX_RESTRICT is true. True
> means Ignoring the AT_CHECK result.

We get a similar weird state with XX_RESTRICT_PERMISSIVE=1 and
XX_RESTRICT=0

As a side note, for compatibility reasons, by default all securebits
must be 0, and this must translate to no restriction.

> 
> Or
> 
> XX_CHECK: when true: Perform the AT_CHECK.
> XX_CHECK_ENFORCE takes effect only when XX_CHECK is true.   True means
> restrict the executable when AT_CHECK failed; false means ignore the
> AT_CHECK failure.

We get a similar weird state with XX_CHECK_ENFORCE=1 and XX_CHECK=0

> 
> Of course, we can replace XX_CHECK_ENFORCE with XX_RESTRICT.
> Personally I think having _CHECK_ in the name implies the XX_CHECK
> needs to be true as a prerequisite for this flag , but that is my
> opinion only. As long as the semantics are clear as part of the
> comments of definition in code,  it is fine.

Here is another proposal:

We can change a bit the semantic by making it the norm to always check
file executability with AT_CHECK, and using the securebits to restrict
file interpretation and/or command injection (e.g. user supplied shell
commands).  Non-executable checked files can be reported/logged at the
kernel level, with audit, configured by sysadmins.

New securebits (feel free to propose better names):

- SECBIT_EXEC_RESTRICT_FILE: requires AT_CHECK to pass.

- SECBIT_EXEC_DENY_INTERACTIVE: deny any command injection via
  command line arguments, environment variables, or configuration files.
  This should be ignored by dynamic linkers.  We could also have an
  allow-list of shells for which this bit is not set, managed by an
  LSM's policy, if the native securebits scoping approach is not enough.

Different modes for script interpreters:

1. RESTRICT_FILE=0 DENY_INTERACTIVE=0 (default)
   Always interpret scripts, and allow arbitrary user commands.
   => No threat, everyone and everything is trusted, but we can get
   ahead of potential issues with logs to prepare for a migration to a
   restrictive mode.

2. RESTRICT_FILE=1 DENY_INTERACTIVE=0
   Deny script interpretation if they are not executable, and allow
   arbitrary user commands.
   => Threat: (potential) malicious scripts run by trusted (and not
      fooled) users.  That could protect against unintended script
      executions (e.g. sh /tmp/*.sh).
   ==> Makes sense for (semi-restricted) user sessions.

3. RESTRICT_FILE=1 DENY_INTERACTIVE=1
   Deny script interpretation if they are not executable, and also deny
   any arbitrary user commands.
   => Threat: malicious scripts run by untrusted users.
   ==> Makes sense for system services executing scripts.

4. RESTRICT_FILE=0 DENY_INTERACTIVE=1
   Always interpret scripts, but deny arbitrary user commands.
   => Goal: monitor/measure/assess script content (e.g. with IMA/EVM) in
      a system where the access rights are not (yet) ready.  Arbitrary
      user commands would be much more difficult to monitor.
   ==> First step of restricting system services that should not
       directly pass arbitrary commands to shells.

> 
> Thanks
> -Jeff
> 
> 
> > >
> > > > "CHECK=1, RESTRICT=1" means to restrict unless AT_CHECK passes. This
> > > > case is the allow list (or whatever mechanism is being used to determine
> > > > the result of an AT_CHECK check). The actual mechanism isn't the
> > > > business of the script interpreter at all, it just has to refuse to
> > > > execute anything that doesn't pass the check. So a generic interpreter
> > > > can implement a generic mechanism and leave the specifics to whoever
> > > > configures the machine.
> > > >
> > > In the context of dynamic linker. this means:
> > > if .so passed the AT_CHECK, ldopen() can still load it.
> > > If .so fails the AT_CHECK, ldopen() will fail too.
> >
> > Correct
> >
> > >
> > > Thanks
> > > -Jeff
> > >
> > > > The other two case are more obvious. "CHECK=0, RESTRICT=0" is the
> > > > zero-overhead case, while "CHECK=1, RESTRICT=0" might log, warn, or
> > > > otherwise audit the result of the check, but it won't restrict execution.
> > > >
> > > > Cheers,
> > > > Steve

