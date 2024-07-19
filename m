Return-Path: <linux-fsdevel+bounces-24015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 498A7937983
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 17:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B53EB22D8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 15:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2E91459F8;
	Fri, 19 Jul 2024 15:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="b4kakrJ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0701917BA1
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2024 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721401459; cv=none; b=nEsrzmc5FNjM8DrrDifoLVYkA8bvk106rwPou7ggijIn/tbGCVk/a8w7cKSlSe0ZEOCcVL5f57mp1IR/QhxoFR4hLxJtoAdUv5lg9XMlwJNMwlSccUteQEXkj2lfrrYCJytjAqd2PW6twsKOhx2Hbq09qleIl+T2pxPKmA2A0Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721401459; c=relaxed/simple;
	bh=IkerZt4Fxk/+kj7zT55z8pEEfoDcPPMEQB+n7a6GaUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMWa3t8+aEhGrDBrY9/0/2cQj463t3GPl39n0aJcxWSptsmMnCpsN7Fars+DanKbRlGCSL6+H0ihbe2QOGQKOHKD/F/KWVkbebti+2n2mc+LXeOlJtyRSDq7CLim/phiaoANapMJ/5XuUvWhKheeDd5S5Wp2m+YqYDqxxociSd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=b4kakrJ2; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WQXy011c8zhL1;
	Fri, 19 Jul 2024 17:04:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721401447;
	bh=iO8TtxQIbOnz80RswndwIyTDS+UMf9IftsRCjoUU3os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b4kakrJ2gEcsh07UAD7jdRnmSpBpScTkTk8IOgBrpODTDzJ2Nw1DRAUDcDp+p0np0
	 zppIOPLEwPo8uiPxahx62iDnkq36SBKgaaRTzxyDUjLiIbUlQYNZc3TBUf8/fVTn+m
	 /3a86+glhXe287wY9p8tD+Gq9LxALtGy6QgHjDbI=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WQXxw06kVzs0G;
	Fri, 19 Jul 2024 17:04:03 +0200 (CEST)
Date: Fri, 19 Jul 2024 17:04:01 +0200
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
	linux-security-module@vger.kernel.org, Elliott Hughes <enh@google.com>
Subject: Re: [RFC PATCH v19 1/5] exec: Add a new AT_CHECK flag to execveat(2)
Message-ID: <20240719.sah7oeY9pha4@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
 <20240704190137.696169-2-mic@digikod.net>
 <CALmYWFss7qcpR9D_r3pbP_Orxs55t3y3yXJsac1Wz=Hk9Di0Nw@mail.gmail.com>
 <20240717.neaB5Aiy2zah@digikod.net>
 <CALmYWFt=yXpzhS=HS9FjwVMvx6U1MoR31vK79wxNLhmJm9bBoA@mail.gmail.com>
 <20240718.kaePhei9Ahm9@digikod.net>
 <CALmYWFto4sw-Q2+J0Gc54POhnM9C8YpnJ44wMz=fd_K3_+dWmw@mail.gmail.com>
 <20240719.shaeK6PaiSie@digikod.net>
 <CALmYWFsd-=pOPZZmiKvYJ8pOhACsTvW_d+pRjG_C4jD6+Li0AQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALmYWFsd-=pOPZZmiKvYJ8pOhACsTvW_d+pRjG_C4jD6+Li0AQ@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Fri, Jul 19, 2024 at 07:16:55AM -0700, Jeff Xu wrote:
> On Fri, Jul 19, 2024 at 1:45 AM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > On Thu, Jul 18, 2024 at 06:29:54PM -0700, Jeff Xu wrote:
> > > On Thu, Jul 18, 2024 at 5:24 AM Mickaël Salaün <mic@digikod.net> wrote:
> > > >
> > > > On Wed, Jul 17, 2024 at 07:08:17PM -0700, Jeff Xu wrote:
> > > > > On Wed, Jul 17, 2024 at 3:01 AM Mickaël Salaün <mic@digikod.net> wrote:
> > > > > >
> > > > > > On Tue, Jul 16, 2024 at 11:33:55PM -0700, Jeff Xu wrote:
> > > > > > > On Thu, Jul 4, 2024 at 12:02 PM Mickaël Salaün <mic@digikod.net> wrote:
> > > > > > > >
> > > > > > > > Add a new AT_CHECK flag to execveat(2) to check if a file would be
> > > > > > > > allowed for execution.  The main use case is for script interpreters and
> > > > > > > > dynamic linkers to check execution permission according to the kernel's
> > > > > > > > security policy. Another use case is to add context to access logs e.g.,
> > > > > > > > which script (instead of interpreter) accessed a file.  As any
> > > > > > > > executable code, scripts could also use this check [1].
> > > > > > > >
> > > > > > > > This is different than faccessat(2) which only checks file access
> > > > > > > > rights, but not the full context e.g. mount point's noexec, stack limit,
> > > > > > > > and all potential LSM extra checks (e.g. argv, envp, credentials).
> > > > > > > > Since the use of AT_CHECK follows the exact kernel semantic as for a
> > > > > > > > real execution, user space gets the same error codes.
> > > > > > > >
> > > > > > > So we concluded that execveat(AT_CHECK) will be used to check the
> > > > > > > exec, shared object, script and config file (such as seccomp config),
> >
> > > > > > > I think binfmt_elf.c in the kernel needs to check the ld.so to make
> > > > > > > sure it passes AT_CHECK, before loading it into memory.
> > > > > >
> > > > > > All ELF dependencies are opened and checked with open_exec(), which
> > > > > > perform the main executability checks (with the __FMODE_EXEC flag).
> > > > > > Did I miss something?
> > > > > >
> > > > > I mean the ld-linux-x86-64.so.2 which is loaded by binfmt in the kernel.
> > > > > The app can choose its own dynamic linker path during build, (maybe
> > > > > even statically link one ?)  This is another reason that relying on a
> > > > > userspace only is not enough.
> > > >
> > > > The kernel calls open_exec() on all dependencies, including
> > > > ld-linux-x86-64.so.2, so these files are checked for executability too.
> > > >
> > > This might not be entirely true. iiuc, kernel  calls open_exec for
> > > open_exec for interpreter, but not all its dependency (e.g. libc.so.6)
> >
> > Correct, the dynamic linker is in charge of that, which is why it must
> > be enlighten with execveat+AT_CHECK and securebits checks.
> >
> > > load_elf_binary() {
> > >    interpreter = open_exec(elf_interpreter);
> > > }
> > >
> > > libc.so.6 is opened and mapped by dynamic linker.
> > > so the call sequence is:
> > >  execve(a.out)
> > >   - open exec(a.out)
> > >   - security_bprm_creds(a.out)
> > >   - open the exec(ld.so)
> > >   - call open_exec() for interruptor (ld.so)
> > >   - call execveat(AT_CHECK, ld.so) <-- do we want ld.so going through
> > > the same check and code path as libc.so below ?
> >
> > open_exec() checks are enough.  LSMs can use this information (open +
> > __FMODE_EXEC) if needed.  execveat+AT_CHECK is only a user space
> > request.
> >
> Then the ld.so doesn't go through the same security_bprm_creds() check
> as other .so.

Indeed, but...

> 
> As my previous email, the ChromeOS LSM restricts executable mfd
> through security_bprm_creds(), the end result is that ld.so can still
> be executable memfd, but not other .so.

The chromeOS LSM can check that with the security_file_open() hook and
the __FMODE_EXEC flag, see Landlock's implementation.  I think this
should be the only hook implementation that chromeOS LSM needs to add.

> 
> One way to address this is to refactor the necessary code from
> execveat() code patch, and make it available to call from both kernel
> and execveat() code paths., but if we do that, we might as well use
> faccessat2(AT_CHECK)

That's why I think it makes sense to rely on the existing __FMODE_EXEC
information.

> 
> 
> > >   - transfer the control to ld.so)
> > >   - ld.so open (libc.so)
> > >   - ld.so call execveat(AT_CHECK,libc.so) <-- proposed by this patch,
> > > require dynamic linker change.
> > >   - ld.so mmap(libc.so,rx)
> >
> > Explaining these steps is useful. I'll include that in the next patch
> > series.

