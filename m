Return-Path: <linux-fsdevel+bounces-25506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F292F94CC92
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 10:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F401B2397B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 08:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDACA18C930;
	Fri,  9 Aug 2024 08:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="h2Ipt9D2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10CA219E1
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 08:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723193147; cv=none; b=cvDpfPrJe+9Lcm58vzWt+k5cGZd6DSp3g9ROI8GBSMfrz1vIpukQzA9weOa5a7kjWpf1NkNe4jW6dAy00T+P7BofobkyoJ+LjsZ54VZ6tph0G7xT0e4dL9IP7q6gi8MhDZk9krY+HYIg8Iq+Hu85UAyfNbPiQ/Ixk+qfM4EZmzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723193147; c=relaxed/simple;
	bh=Cc3CTSJnqciZ5F97WujY8wtP6LwylWlntc2UMCDJOAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYPxGkKs124yk6CBZvXEBLHGyBeD/uzMvs8qZc/gb0GyddUE2yPvmTcLrkiDuM/1dX0zSBHrZZwoMqFhNzRf0rMrflE9nKQScmY8F6FIrn0Ac7IVduWZkQeFCL7s9S9dtmYPnP3eRe8EeGZ35mAajUbzIVtwelcx5QJOnMuQGUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=h2Ipt9D2; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WgHYY28mjzcxg;
	Fri,  9 Aug 2024 10:45:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1723193137;
	bh=A4Mye3W1GO6Qfy6D2ZWCed9/6+HjtrIW34KoXP/3AGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h2Ipt9D2gSZ/q8ygM/sKMThiKAgF5W7JXFX6TJPXNTZAYDmh1klJCHwS2nWk1/Ls6
	 rODW1Jw9gRqcGJJlyTfXdlR0gZLZ9XfO6hh5TppcVcLc35YP40xdWPET10w2N9LHIp
	 rSAeWKTu4mMzgbT0el463lS6S0/0zMcqfxAW+NGE=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WgHYN5HlJzLZR;
	Fri,  9 Aug 2024 10:45:28 +0200 (CEST)
Date: Fri, 9 Aug 2024 10:45:23 +0200
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
Message-ID: <20240809.Taiyah0ii7ph@digikod.net>
References: <20240717.neaB5Aiy2zah@digikod.net>
 <CALmYWFt=yXpzhS=HS9FjwVMvx6U1MoR31vK79wxNLhmJm9bBoA@mail.gmail.com>
 <20240718.kaePhei9Ahm9@digikod.net>
 <CALmYWFto4sw-Q2+J0Gc54POhnM9C8YpnJ44wMz=fd_K3_+dWmw@mail.gmail.com>
 <20240719.shaeK6PaiSie@digikod.net>
 <CALmYWFsd-=pOPZZmiKvYJ8pOhACsTvW_d+pRjG_C4jD6+Li0AQ@mail.gmail.com>
 <20240719.sah7oeY9pha4@digikod.net>
 <CALmYWFsAZjU5sMcXTT23Mtw2Y30ewc94FAjKsnuSv1Ex=7fgLQ@mail.gmail.com>
 <20240723.beiTu0qui2ei@digikod.net>
 <CALmYWFtHQY41PbRwGxge1Wo=8D4ocZfQgRUO47-PF1eJCEr0Sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALmYWFtHQY41PbRwGxge1Wo=8D4ocZfQgRUO47-PF1eJCEr0Sw@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Mon, Aug 05, 2024 at 11:35:09AM -0700, Jeff Xu wrote:
> On Tue, Jul 23, 2024 at 6:15 AM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > On Fri, Jul 19, 2024 at 08:27:18AM -0700, Jeff Xu wrote:
> > > On Fri, Jul 19, 2024 at 8:04 AM Mickaël Salaün <mic@digikod.net> wrote:
> > > >
> > > > On Fri, Jul 19, 2024 at 07:16:55AM -0700, Jeff Xu wrote:
> > > > > On Fri, Jul 19, 2024 at 1:45 AM Mickaël Salaün <mic@digikod.net> wrote:
> > > > > >
> > > > > > On Thu, Jul 18, 2024 at 06:29:54PM -0700, Jeff Xu wrote:
> > > > > > > On Thu, Jul 18, 2024 at 5:24 AM Mickaël Salaün <mic@digikod.net> wrote:
> > > > > > > >
> > > > > > > > On Wed, Jul 17, 2024 at 07:08:17PM -0700, Jeff Xu wrote:
> > > > > > > > > On Wed, Jul 17, 2024 at 3:01 AM Mickaël Salaün <mic@digikod.net> wrote:
> > > > > > > > > >
> > > > > > > > > > On Tue, Jul 16, 2024 at 11:33:55PM -0700, Jeff Xu wrote:
> > > > > > > > > > > On Thu, Jul 4, 2024 at 12:02 PM Mickaël Salaün <mic@digikod.net> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Add a new AT_CHECK flag to execveat(2) to check if a file would be
> > > > > > > > > > > > allowed for execution.  The main use case is for script interpreters and
> > > > > > > > > > > > dynamic linkers to check execution permission according to the kernel's
> > > > > > > > > > > > security policy. Another use case is to add context to access logs e.g.,
> > > > > > > > > > > > which script (instead of interpreter) accessed a file.  As any
> > > > > > > > > > > > executable code, scripts could also use this check [1].
> > > > > > > > > > > >
> > > > > > > > > > > > This is different than faccessat(2) which only checks file access
> > > > > > > > > > > > rights, but not the full context e.g. mount point's noexec, stack limit,
> > > > > > > > > > > > and all potential LSM extra checks (e.g. argv, envp, credentials).
> > > > > > > > > > > > Since the use of AT_CHECK follows the exact kernel semantic as for a
> > > > > > > > > > > > real execution, user space gets the same error codes.
> > > > > > > > > > > >
> > > > > > > > > > > So we concluded that execveat(AT_CHECK) will be used to check the
> > > > > > > > > > > exec, shared object, script and config file (such as seccomp config),
> > > > > >
> > > > > > > > > > > I think binfmt_elf.c in the kernel needs to check the ld.so to make
> > > > > > > > > > > sure it passes AT_CHECK, before loading it into memory.
> > > > > > > > > >
> > > > > > > > > > All ELF dependencies are opened and checked with open_exec(), which
> > > > > > > > > > perform the main executability checks (with the __FMODE_EXEC flag).
> > > > > > > > > > Did I miss something?
> > > > > > > > > >
> > > > > > > > > I mean the ld-linux-x86-64.so.2 which is loaded by binfmt in the kernel.
> > > > > > > > > The app can choose its own dynamic linker path during build, (maybe
> > > > > > > > > even statically link one ?)  This is another reason that relying on a
> > > > > > > > > userspace only is not enough.
> > > > > > > >
> > > > > > > > The kernel calls open_exec() on all dependencies, including
> > > > > > > > ld-linux-x86-64.so.2, so these files are checked for executability too.
> > > > > > > >
> > > > > > > This might not be entirely true. iiuc, kernel  calls open_exec for
> > > > > > > open_exec for interpreter, but not all its dependency (e.g. libc.so.6)
> > > > > >
> > > > > > Correct, the dynamic linker is in charge of that, which is why it must
> > > > > > be enlighten with execveat+AT_CHECK and securebits checks.
> > > > > >
> > > > > > > load_elf_binary() {
> > > > > > >    interpreter = open_exec(elf_interpreter);
> > > > > > > }
> > > > > > >
> > > > > > > libc.so.6 is opened and mapped by dynamic linker.
> > > > > > > so the call sequence is:
> > > > > > >  execve(a.out)
> > > > > > >   - open exec(a.out)
> > > > > > >   - security_bprm_creds(a.out)
> > > > > > >   - open the exec(ld.so)
> > > > > > >   - call open_exec() for interruptor (ld.so)
> > > > > > >   - call execveat(AT_CHECK, ld.so) <-- do we want ld.so going through
> > > > > > > the same check and code path as libc.so below ?
> > > > > >
> > > > > > open_exec() checks are enough.  LSMs can use this information (open +
> > > > > > __FMODE_EXEC) if needed.  execveat+AT_CHECK is only a user space
> > > > > > request.
> > > > > >
> > > > > Then the ld.so doesn't go through the same security_bprm_creds() check
> > > > > as other .so.
> > > >
> > > > Indeed, but...
> > > >
> > > My point is: we will want all the .so going through the same code
> > > path, so  security_ functions are called consistently across all the
> > > objects, And in the future, if we want to develop additional LSM
> > > functionality based on AT_CHECK, it will be applied to all objects.
> >
> > I'll extend the doc to encourage LSMs to check for __FMODE_EXEC, which
> > already is the common security check for all executable dependencies.
> > As extra information, they can get explicit requests by looking at
> > execveat+AT_CHECK call.
> >
> I agree that security_file_open + __FMODE_EXEC for checking all
> the .so (e.g for executable memfd) is a better option  than checking at
> security_bprm_creds_for_exec.
> 
> But then maybe execveat( AT_CHECK) can return after  calling alloc_bprm ?
> See below call graph:
> 
> do_execveat_common (AT_CHECK)
> -> alloc_bprm
> ->->do_open_execat
> ->->-> do_filp_open (__FMODE_EXEC)
> ->->->->->->> security_file_open
> -> bprm_execve
> ->-> prepare_exec_creds
> ->->-> prepare_creds
> ->->->-> security_prepare_creds
> ->-> security_bprm_creds_for_exec
> 
> What is the consideration to mark the end at
> security_bprm_creds_for_exec ? i.e. including brpm_execve,
> prepare_creds, security_prepare_creds, security_bprm_creds_for_exec.

This enables LSMs to know/log an explicit execution request, including
context with argv and envp.

> 
> Since dynamic linker doesn't load ld.so (it is by kernel),  ld.so
> won't go through those  security_prepare_creds and
> security_bprm_creds_for_exec checks like other .so do.

Yes, but this is not an issue nor an explicit request. ld.so is only one
case of this patch series.

> 
> > >
> > > Another thing to consider is:  we are asking userspace to make
> > > additional syscall before  loading the file into memory/get executed,
> > > there is a possibility for future expansion of the mechanism, without
> > > asking user space to add another syscall again.
> >
> > AT_CHECK is defined with a specific semantic.  Other mechanisms (e.g.
> > LSM policies) could enforce other restrictions following the same
> > semantic.  We need to keep in mind backward compatibility.
> >
> > >
> > > I m still not convinced yet that execveat(AT_CHECK) fits more than
> > > faccessat(AT_CHECK)
> >
> > faccessat2(2) is dedicated to file permission/attribute check.
> > execveat(2) is dedicated to execution, which is a superset of file
> > permission for executability, plus other checks (e.g. noexec).
> >
> That sounds reasonable, but if execveat(AT_CHECK) changes behavior of
> execveat(),  someone might argue that faccessat2(EXEC_CHECK) can be
> made for the executability.

AT_CHECK, as any other syscall flags, changes the behavior of execveat,
but the overall semantic is clearly defined.

Again, faccessat2 is only dedicated to file attributes/permissions, not
file executability.

> 
> I think the decision might depend on what this PATCH intended to
> check, i.e. where we draw the line.

The goal is clearly defined in the cover letter and patches: makes it
possible to control (or log) script execution.

> 
> do_open_execat() seems to cover lots of checks for executability, if
> we are ok with the thing that do_open_execat() checks, then
> faccessat(AT_CHECK) calling do_open_execat() is an option, it  won't
> have those "unrelated" calls  in execve path, e.g.  bprm_stack_limits,
> copy argc/env .

I don't thing there is any unrelated calls in execve path, quite the
contrary, it follows the same semantic as for a full execution, and
that's another argument to use the execveat interface.  Otherwise, we
couldn't argue that `./script.sh` can be the same as `sh script.sh`

The only difference is that user space is in charge of parsing and
interpreting the file's content.

> 
> However, you mentioned superset of file permission for executability,
> can you elaborate on that ? Is there something not included in
> do_open_execat() but still necessary for execveat(AT_CHECK)? maybe
> security_bprm_creds_for_exec? (this goes back to my  question above)

As explained above, the goal is to have the same semantic as a full
execveat call, taking into account all the checks (e.g. stack limit,
argv/envp...).

> 
> Thanks
> Best regards,
> -Jeff
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> > >
> > >
> > > > >
> > > > > As my previous email, the ChromeOS LSM restricts executable mfd
> > > > > through security_bprm_creds(), the end result is that ld.so can still
> > > > > be executable memfd, but not other .so.
> > > >
> > > > The chromeOS LSM can check that with the security_file_open() hook and
> > > > the __FMODE_EXEC flag, see Landlock's implementation.  I think this
> > > > should be the only hook implementation that chromeOS LSM needs to add.
> > > >
> > > > >
> > > > > One way to address this is to refactor the necessary code from
> > > > > execveat() code patch, and make it available to call from both kernel
> > > > > and execveat() code paths., but if we do that, we might as well use
> > > > > faccessat2(AT_CHECK)
> > > >
> > > > That's why I think it makes sense to rely on the existing __FMODE_EXEC
> > > > information.
> > > >
> > > > >
> > > > >
> > > > > > >   - transfer the control to ld.so)
> > > > > > >   - ld.so open (libc.so)
> > > > > > >   - ld.so call execveat(AT_CHECK,libc.so) <-- proposed by this patch,
> > > > > > > require dynamic linker change.
> > > > > > >   - ld.so mmap(libc.so,rx)
> > > > > >
> > > > > > Explaining these steps is useful. I'll include that in the next patch
> > > > > > series.
> > >
> 

