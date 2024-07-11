Return-Path: <linux-fsdevel+bounces-23557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A78EE92E2D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 10:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBED51C2223A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 08:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9CE1552E7;
	Thu, 11 Jul 2024 08:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="HZzzUjw8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F6878283;
	Thu, 11 Jul 2024 08:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720688279; cv=none; b=J8GgSPSJxInvmmx+op6va6n51R6k32hikaYa8QcRqx3M4hBZ/2Ia5v49fv7a6ar0+kL9m+l/R9f4Zy6Y5brVaymbcSm/1L0rsED66glR3ZctVkcdhFc1xw3YHyJrdi2JkdCOb88UkHpGsKp1V4gT1s3yD2QE/ucVICZN8eB9lBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720688279; c=relaxed/simple;
	bh=5qdlkIUXePdQbQ6tcGsIR0SkqQQqqPEPCuRj3ix32Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4Wnmg667GD7d5+X65T5S/I8zr56YBSuPoWFeqERwZ5j5WJw7WQfDhf3DkMuw8B6T65k+aH2KSIUc/iVTMHtm5YpdGcvTr8NYp9u1dP3DVCy0NinK66jAZTFWkl6wuF1VHt0UOA4RI1MJhGD83ykIxngZFhyZmaHGp+A7ag/6No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=HZzzUjw8; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WKTC13dJNz4lx;
	Thu, 11 Jul 2024 10:57:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1720688269;
	bh=GfpDJTHUlFGNz4hRlFHHf6Z/4olbS9aXzyMulHHeow8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HZzzUjw849M7NY6xsNUpYqhsGbFchucvpMppMz14wLhpotEOHN5Qqv4iy+qxGAg3g
	 O23dQCHUItTr3LNn+Yj323dDXmEdwne3XNbPckHNQKSLuhw9ARFg5zTLN81sZB5ef1
	 NLyZffTATZvsTENeZcx45tOhK/1XbJIMmD/k1x70=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WKTBx4H8FzV1N;
	Thu, 11 Jul 2024 10:57:45 +0200 (CEST)
Date: Thu, 11 Jul 2024 10:57:42 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Kees Cook <kees@kernel.org>
Cc: Jeff Xu <jeffxu@google.com>, Steve Dower <steve.dower@python.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
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
	Stephen Rothwell <sfr@canb.auug.org.au>, Steve Grubb <sgrubb@redhat.com>, 
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, Vincent Strubel <vincent.strubel@ssi.gouv.fr>, 
	Xiaoming Ni <nixiaoming@huawei.com>, Yin Fengwei <fengwei.yin@intel.com>, 
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v19 2/5] security: Add new SHOULD_EXEC_CHECK and
 SHOULD_EXEC_RESTRICT securebits
Message-ID: <20240711.sequuGhee0th@digikod.net>
References: <CALmYWFscz5W6xSXD-+dimzbj=TykNJEDa0m5gvBx93N-J+3nKA@mail.gmail.com>
 <CALmYWFsLUhkU5u1NKH8XWvSxbFKFOEq+A_eqLeDsN29xOEAYgg@mail.gmail.com>
 <20240708.quoe8aeSaeRi@digikod.net>
 <CALmYWFuVJiRZgB0ye9eR95dvBOigoOVShgS9i_ESjEre-H5pLA@mail.gmail.com>
 <ef3281ad-48a5-4316-b433-af285806540d@python.org>
 <CALmYWFuFE=V7sGp0_K+2Vuk6F0chzhJY88CP1CAE9jtd=rqcoQ@mail.gmail.com>
 <20240709.aech3geeMoh0@digikod.net>
 <CALmYWFuOXAiT05Pi2rZ1nUAKDGe9JyTH7fro2EYS1fh3zeGV5Q@mail.gmail.com>
 <20240710.eiKohpa4Phai@digikod.net>
 <202407100921.687BE1A6@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202407100921.687BE1A6@keescook>
X-Infomaniak-Routing: alpha

On Wed, Jul 10, 2024 at 09:26:14AM -0700, Kees Cook wrote:
> On Wed, Jul 10, 2024 at 11:58:25AM +0200, Mickaël Salaün wrote:
> > Here is another proposal:
> > 
> > We can change a bit the semantic by making it the norm to always check
> > file executability with AT_CHECK, and using the securebits to restrict
> > file interpretation and/or command injection (e.g. user supplied shell
> > commands).  Non-executable checked files can be reported/logged at the
> > kernel level, with audit, configured by sysadmins.
> > 
> > New securebits (feel free to propose better names):
> > 
> > - SECBIT_EXEC_RESTRICT_FILE: requires AT_CHECK to pass.
> 
> Would you want the enforcement of this bit done by userspace or the
> kernel?
> 
> IIUC, userspace would always perform AT_CHECK regardless of
> SECBIT_EXEC_RESTRICT_FILE, and then which would happen?
> 
> 1) userspace would ignore errors from AT_CHECK when
>    SECBIT_EXEC_RESTRICT_FILE is unset

Yes, that's the idea.

> 
> or
> 
> 2) kernel would allow all AT_CHECK when SECBIT_EXEC_RESTRICT_FILE is
>    unset
> 
> I suspect 1 is best and what you intend, given that
> SECBIT_EXEC_DENY_INTERACTIVE can only be enforced by userspace.

Indeed. We don't want AT_CHECK's behavior to change according to
securebits.

> 
> > - SECBIT_EXEC_DENY_INTERACTIVE: deny any command injection via
> >   command line arguments, environment variables, or configuration files.
> >   This should be ignored by dynamic linkers.  We could also have an
> >   allow-list of shells for which this bit is not set, managed by an
> >   LSM's policy, if the native securebits scoping approach is not enough.
> > 
> > Different modes for script interpreters:
> > 
> > 1. RESTRICT_FILE=0 DENY_INTERACTIVE=0 (default)
> >    Always interpret scripts, and allow arbitrary user commands.
> >    => No threat, everyone and everything is trusted, but we can get
> >    ahead of potential issues with logs to prepare for a migration to a
> >    restrictive mode.
> > 
> > 2. RESTRICT_FILE=1 DENY_INTERACTIVE=0
> >    Deny script interpretation if they are not executable, and allow
> >    arbitrary user commands.
> >    => Threat: (potential) malicious scripts run by trusted (and not
> >       fooled) users.  That could protect against unintended script
> >       executions (e.g. sh /tmp/*.sh).
> >    ==> Makes sense for (semi-restricted) user sessions.
> > 
> > 3. RESTRICT_FILE=1 DENY_INTERACTIVE=1
> >    Deny script interpretation if they are not executable, and also deny
> >    any arbitrary user commands.
> >    => Threat: malicious scripts run by untrusted users.
> >    ==> Makes sense for system services executing scripts.
> > 
> > 4. RESTRICT_FILE=0 DENY_INTERACTIVE=1
> >    Always interpret scripts, but deny arbitrary user commands.
> >    => Goal: monitor/measure/assess script content (e.g. with IMA/EVM) in
> >       a system where the access rights are not (yet) ready.  Arbitrary
> >       user commands would be much more difficult to monitor.
> >    ==> First step of restricting system services that should not
> >        directly pass arbitrary commands to shells.
> 
> I like these bits!

Good! Jeff, Steve, Florian, Matt, others, what do you think?

