Return-Path: <linux-fsdevel+bounces-23935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D90AE934FFE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 17:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 572981F22ABB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 15:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6556A1448DF;
	Thu, 18 Jul 2024 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="xtzXf0ai"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAB1143C55
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 15:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721316963; cv=none; b=Vgp/dxBEThvGts5ukE+44GVUq3jfnqec360/9pRovOLXOJXkh46TG9rckgMuCYW43waXNKRoPcd8f9Le7fdX6ORpbV/788n9ugvobpzw8Jir+DYMYVr+cFqbuczY6M+ChUbWhH9/iT9hHnA/bS+Dwe0AUpJ7sYSZFQzkfVSqjIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721316963; c=relaxed/simple;
	bh=47DXvCq/KA2yDmeWz6pfc5h/STaHEi06Coo1syEqRz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpUKqjxJ7B80Izne60ZndDNjY5raHyCTFIoTP0Zm6wAftY1wl0D8ohZ7X/BQhAHMXfWzOy1e6/gvh0Doz8WALb25WSbVHuvCO0w/hi0OhInniQ2vCgoakAT1InGzzVwO6iCVjP+ZlVFON/sH4xGB1K/uQ7G7rCigCMLlYjPQD8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=xtzXf0ai; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WPxj96MnPzCbN;
	Thu, 18 Jul 2024 17:35:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721316957;
	bh=E31Jo0xm32H4Cu7Kb+myrg9suLr0Xvm7uNKD25UoAvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xtzXf0ai3h4ZnbWd88g9rC9kS/rEccxZtHrHjqWXEKfi4LcIgMBSFwoFGpH8FwcSC
	 zdtv7IIXLn5jCMeAvfyKvr1A9NJcbda0ZJrRiDzbsyN5qL9qzwNONHyepE2hrooTaW
	 vaP8eQbv6Bdgv7Lu9ZdVSTmFYytWJt8JJ1FBNiAE=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WPxj85Cyczd6w;
	Thu, 18 Jul 2024 17:35:56 +0200 (CEST)
Date: Thu, 18 Jul 2024 17:35:54 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: enh <enh@google.com>
Cc: Jeff Xu <jeffxu@google.com>, Al Viro <viro@zeniv.linux.org.uk>, 
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
Subject: Re: [RFC PATCH v19 1/5] exec: Add a new AT_CHECK flag to execveat(2)
Message-ID: <20240718.uPh9bei7fee6@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
 <20240704190137.696169-2-mic@digikod.net>
 <CALmYWFss7qcpR9D_r3pbP_Orxs55t3y3yXJsac1Wz=Hk9Di0Nw@mail.gmail.com>
 <20240717.neaB5Aiy2zah@digikod.net>
 <CALmYWFt=yXpzhS=HS9FjwVMvx6U1MoR31vK79wxNLhmJm9bBoA@mail.gmail.com>
 <CAJgzZor6frRHx1oZt3wnrNc6-13og=BL3GSKDhDmGE5JRq_LmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJgzZor6frRHx1oZt3wnrNc6-13og=BL3GSKDhDmGE5JRq_LmQ@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Thu, Jul 18, 2024 at 10:46:54AM -0400, enh wrote:
> On Wed, Jul 17, 2024 at 10:08 PM Jeff Xu <jeffxu@google.com> wrote:
> >
> > On Wed, Jul 17, 2024 at 3:01 AM Mickaël Salaün <mic@digikod.net> wrote:
> > >
> > > On Tue, Jul 16, 2024 at 11:33:55PM -0700, Jeff Xu wrote:
> > > > On Thu, Jul 4, 2024 at 12:02 PM Mickaël Salaün <mic@digikod.net> wrote:
> > > > >
> > > > > Add a new AT_CHECK flag to execveat(2) to check if a file would be
> > > > > allowed for execution.  The main use case is for script interpreters and
> > > > > dynamic linkers to check execution permission according to the kernel's
> > > > > security policy. Another use case is to add context to access logs e.g.,
> > > > > which script (instead of interpreter) accessed a file.  As any
> > > > > executable code, scripts could also use this check [1].
> > > > >
> > > > > This is different than faccessat(2) which only checks file access
> > > > > rights, but not the full context e.g. mount point's noexec, stack limit,
> > > > > and all potential LSM extra checks (e.g. argv, envp, credentials).
> > > > > Since the use of AT_CHECK follows the exact kernel semantic as for a
> > > > > real execution, user space gets the same error codes.
> > > > >
> > > > So we concluded that execveat(AT_CHECK) will be used to check the
> > > > exec, shared object, script and config file (such as seccomp config),
> > >
> > > "config file" that contains executable code.
> > >
> > Is seccomp config  considered as "contains executable code", seccomp
> > config is translated into bpf, so maybe yes ? but bpf is running in
> > the kernel.
> >
> > > > I'm still thinking  execveat(AT_CHECK) vs faccessat(AT_CHECK) in
> > > > different use cases:
> > > >
> > > > execveat clearly has less code change, but that also means: we can't
> > > > add logic specific to exec (i.e. logic that can't be applied to
> > > > config) for this part (from do_execveat_common to
> > > > security_bprm_creds_for_exec) in future.  This would require some
> > > > agreement/sign-off, I'm not sure from whom.
> > >
> > > I'm not sure to follow. We could still add new flags, but for now I
> > > don't see use cases.  This patch series is not meant to handle all
> > > possible "trust checks", only executable code, which makes sense for the
> > > kernel.
> > >
> > I guess the "configfile" discussion is where I get confused, at one
> > point, I think this would become a generic "trust checks" api for
> > everything related to "generating executable code", e.g. javascript,
> > java code, and more.
> > We will want to clearly define the scope of execveat(AT_CHECK)
> >
> > > If we want other checks, we'll need to clearly define their semantic and
> > > align with the kernel.  faccessat2(2) might be used to check other file
> > > properties, but the executable property is not only defined by the file
> > > attributes.
> > >
> > Agreed.
> >
> > > >
> > > > --------------------------
> > > > now looked at user cases (focus on elf for now)
> > > >
> > > > 1> ld.so /tmp/a.out, /tmp/a.out is on non-exec mount
> > > > dynamic linker will first call execveat(fd, AT_CHECK) then execveat(fd)
> > > >
> > > > 2> execve(/usr/bin/some.out) and some.out has dependency on /tmp/a.so
> > > > /usr/bin/some.out will pass AT_CHECK
> > > >
> > > > 3> execve(usr/bin/some.out) and some.out uses custom /tmp/ld.so
> > > > /usr/bin/some.out will pass AT_CHECK, however, it uses a custom
> > > > /tmp/ld.so (I assume this is possible  for elf header will set the
> > > > path for ld.so because kernel has no knowledge of that, and
> > > > binfmt_elf.c allocate memory for ld.so during execveat call)
> > > >
> > > > 4> dlopen(/tmp/a.so)
> > > > I assume dynamic linker will call execveat(AT_CHECK), before map a.so
> > > > into memory.
> > > >
> > > > For case 1>
> > > > Alternative solution: Because AT_CHECK is always called, I think we
> > > > can avoid the first AT_CHECK call, and check during execveat(fd),
> > >
> > > There is no need to use AT_CHECK if we're going to call execveat(2) on
> > > the same file descriptor.  By design, AT_CHECK is implicit for any
> > > execve(2).
> > >
> > Yes. I realized I was wrong to say that ld.so will call execve() for
> > /tmp/a.out, there is no execve() call, otherwise it would have been
> > blocked already today.
> > The ld.so will  mmap the /tmp/a.out directly.  So case 1 is no
> > different than case 2 and 4.  ( the elf objects are mapped to memory
> > by dynamic linker.)
> > I'm not familiar with dynamic linker, Florian is on this thread, and
> > can help to correct me if my guess is wrong.
> 
> for Android, this has been the nail in the coffin of previous attempts
> to disallow running code from non-trusted filesystems --- instead of
> execing /tmp/a.out, the attacker just execs the linker with /tmp/a.out
> as an argument. people are doing this already in some cases, because
> we already have ineffectual "barriers" in place. [the usual argument
> for doing such things anyway is "it makes it harder to be doing this
> by _accident_".]

This AT_CHECK and related securebits should cover this case.

> 
> the other workaround for the attacker is to copy and paste the entire
> dynamic linker source and change the bits they don't like :-) (if
> you're thinking "is that a thing?", yes, so much so that the idea has
> been independently reinvented multiple times by several major legit
> apps and by basically every piece of DRM middleware. which is why --
> although i'm excited by mseal(2) -- i expect to face significant
> challenges rolling it out in Android _especially_ in places like
> "dynamic linker internal data structures" where i've wanted it for
> years!)
> 
> this proposal feels like it _ought_ to let a defender tighten their
> seccomp filter to require a "safe" fd if i'm using mmap() with an fd,
> but in practice as long as JITs exist i can always just copy code into
> a non-fd-backed mmap() region. and -- from the perspective of Android,
> where all "apps" are code loaded into a Java runtime -- there's not
> much getting away from JITs. (and last i looked, ART -- Android's Java
> runtime -- uses memfd() for the JIT cache.)

Using the feature brought by this patch series makes sense for trusted
executables willing to enforce a security policy.  Untrusted ones should
be sandboxed, which is the case for Android apps.

> 
> > > > this means the kernel will enforce SECBIT_EXEC_RESTRICT_FILE = 1, the
> > > > benefit is that there is no TOCTOU and save one round trip of syscall
> > > > for a succesful execveat() case.
> > >
> > > As long as user space uses the same file descriptor, there is no TOCTOU.
> > >
> > > SECBIT_EXEC_RESTRICT_FILE only makes sense for user space: it defines
> > > the user space security policy.  The kernel already enforces the same
> > > security policy for any execve(2), whatever are the calling process's
> > > securebits.
> > >
> > > >
> > > > For case 2>
> > > > dynamic linker will call execve(AT_CHECK), then mmap(fd) into memory.
> > > > However,  the process can all open then mmap() directly, it seems
> > > > minimal effort for an attacker to walk around such a defence from
> > > > dynamic linker.
> > >
> > > Which process?  What do you mean by "can all open then mmap() directly"?
> > >
> > > In this context the dynamic linker (like its parent processes) is
> > > trusted (guaranteed by the system).
> > >
> > > For case 2, the dynamic linker must check with AT_CHECK all files that
> > > will be mapped, which include /usr/bin/some.out and /tmp/a.so
> > >
> > My point is that the process can work around this by mmap() the file directly.
> >
> > > >
> > > > Alternative solution:
> > > > dynamic linker call AT_CHECK for each .so, kernel will save the state
> > > > (associated with fd)
> > > > kernel will check fd state at the time of mmap(fd, executable memory)
> > > > and enforce SECBIT_EXEC_RESTRICT_FILE = 1
> > >
> > > The idea with AT_CHECK is that there is no kernel side effect, no extra
> > > kernel state, and the semantic is the same as with execve(2).
> > >
> > > This also enables us to check file's executable permission and ignore
> > > it, which is useful in a "permissive mode" when preparing for a
> > > migration without breaking a system, or to do extra integrity checks.
> > For preparing a migration (detect all violations), this is useful.
> > But as a defense mechanism (SECBIT_EXEC_RESTRICT_FILE = 1) , this
> > seems to be weak, at least for elf loading case.
> >
> > > BTW, this use case would also be more complex with a new openat2(2) flag
> > > like the original O_MAYEXEC.
> > >
> > > >
> > > > Alternative solution 2:
> > > > a new syscall to load the .so and enforce the AT_CHECK in kernel
> > >
> > > A new syscall would be overkill for this feature.  Please see Linus's
> > > comment.
> > >
> > maybe, I was thinking on how to prevent "/tmp/a.o" from getting mmap()
> > to executable memory.
> >
> > > >
> > > > This also means, for the solution to be complete, we might want to
> > > > block creation of executable anonymous memory (e.g. by seccomp, ),
> > >
> > > How seccomp could create anonymous memory in user space?
> > > seccomp filters should be treated (and checked with AT_CHECK) as
> > > executable code anyway.
> > >
> > > > unless the user space can harden the creation of  executable anonymous
> > > > memory in some way.
> > >
> > > User space is already in charge of mmapping its own memory.  I don't see
> > > what is missing.
> > >
> > > >
> > > > For case 3>
> > > > I think binfmt_elf.c in the kernel needs to check the ld.so to make
> > > > sure it passes AT_CHECK, before loading it into memory.
> > >
> > > All ELF dependencies are opened and checked with open_exec(), which
> > > perform the main executability checks (with the __FMODE_EXEC flag).
> > > Did I miss something?
> > >
> > I mean the ld-linux-x86-64.so.2 which is loaded by binfmt in the kernel.
> > The app can choose its own dynamic linker path during build, (maybe
> > even statically link one ?)  This is another reason that relying on a
> > userspace only is not enough.
> >
> > > However, we must be careful with programs using the (deprecated)
> > > uselib(2). They should also check with AT_CHECK because this syscall
> > > opens the shared library without __FMODE_EXEC (similar to a simple file
> > > open). See
> > > https://lore.kernel.org/all/CAHk-=wiUwRG7LuR=z5sbkFVGQh+7qVB6_1NM0Ny9SVNL1Un4Sw@mail.gmail.com/
> > >
> > > >
> > > > For case 4>
> > > > same as case 2.
> > > >
> > > > Consider those cases: I think:
> > > > a> relying purely on userspace for enforcement does't seem to be
> > > > effective,  e.g. it is trivial  to call open(), then mmap() it into
> > > > executable memory.
> > >
> > > As Steve explained (and is also explained in the patches), it is trivial
> > > if the attacker can already execute its own code, which is too late to
> > > enforce any script execution control.
> > >
> > > > b> if both user space and kernel need to call AT_CHECK, the faccessat
> > > > seems to be a better place for AT_CHECK, e.g. kernel can call
> > > > do_faccessat(AT_CHECK) and userspace can call faccessat(). This will
> > > > avoid complicating the execveat() code path.
> > >
> > > A previous version of this patches series already patched faccessat(2),
> > > but this is not the right place.  faccessat2(2) is dedicated to check
> > > file permissions, not executability (e.g. with mount's noexec).
> > >
> > > >
> > > > What do you think ?
> > >
> > > I think there are some misunderstandings.  Please let me know if it's
> > > clearer now.
> > >
> > I'm still not sure about the user case for dynamic linker (elf
> > loading) case. Maybe this patch is more suitable for scripts?
> > A detailed user case will help demonstrate the use case for dynamic
> > linker, e.g. what kind of app will benefit from
> > SECBIT_EXEC_RESTRICT_FILE = 1, what kind of threat model are we
> > dealing with , what kind of attack chain we blocked as a result.
> >
> > > >
> > > > Thanks
> > > > -Jeff
> > > >
> > > > > With the information that a script interpreter is about to interpret a
> > > > > script, an LSM security policy can adjust caller's access rights or log
> > > > > execution request as for native script execution (e.g. role transition).
> > > > > This is possible thanks to the call to security_bprm_creds_for_exec().
> > > > >
> > > > > Because LSMs may only change bprm's credentials, use of AT_CHECK with
> > > > > current kernel code should not be a security issue (e.g. unexpected role
> > > > > transition).  LSMs willing to update the caller's credential could now
> > > > > do so when bprm->is_check is set.  Of course, such policy change should
> > > > > be in line with the new user space code.
> > > > >
> > > > > Because AT_CHECK is dedicated to user space interpreters, it doesn't
> > > > > make sense for the kernel to parse the checked files, look for
> > > > > interpreters known to the kernel (e.g. ELF, shebang), and return ENOEXEC
> > > > > if the format is unknown.  Because of that, security_bprm_check() is
> > > > > never called when AT_CHECK is used.
> > > > >
> > > > > It should be noted that script interpreters cannot directly use
> > > > > execveat(2) (without this new AT_CHECK flag) because this could lead to
> > > > > unexpected behaviors e.g., `python script.sh` could lead to Bash being
> > > > > executed to interpret the script.  Unlike the kernel, script
> > > > > interpreters may just interpret the shebang as a simple comment, which
> > > > > should not change for backward compatibility reasons.
> > > > >
> > > > > Because scripts or libraries files might not currently have the
> > > > > executable permission set, or because we might want specific users to be
> > > > > allowed to run arbitrary scripts, the following patch provides a dynamic
> > > > > configuration mechanism with the SECBIT_SHOULD_EXEC_CHECK and
> > > > > SECBIT_SHOULD_EXEC_RESTRICT securebits.
> > > > >
> > > > > This is a redesign of the CLIP OS 4's O_MAYEXEC:
> > > > > https://github.com/clipos-archive/src_platform_clip-patches/blob/f5cb330d6b684752e403b4e41b39f7004d88e561/1901_open_mayexec.patch
> > > > > This patch has been used for more than a decade with customized script
> > > > > interpreters.  Some examples can be found here:
> > > > > https://github.com/clipos-archive/clipos4_portage-overlay/search?q=O_MAYEXEC
> > > > >
> > > > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > > > Cc: Christian Brauner <brauner@kernel.org>
> > > > > Cc: Kees Cook <keescook@chromium.org>
> > > > > Cc: Paul Moore <paul@paul-moore.com>
> > > > > Link: https://docs.python.org/3/library/io.html#io.open_code [1]
> > > > > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > > > > Link: https://lore.kernel.org/r/20240704190137.696169-2-mic@digikod.net
> > > > > ---
> > > > >
> > > > > New design since v18:
> > > > > https://lore.kernel.org/r/20220104155024.48023-3-mic@digikod.net
> > > > > ---
> > > > >  fs/exec.c                  |  5 +++--
> > > > >  include/linux/binfmts.h    |  7 ++++++-
> > > > >  include/uapi/linux/fcntl.h | 30 ++++++++++++++++++++++++++++++
> > > > >  kernel/audit.h             |  1 +
> > > > >  kernel/auditsc.c           |  1 +
> > > > >  5 files changed, 41 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/fs/exec.c b/fs/exec.c
> > > > > index 40073142288f..ea2a1867afdc 100644
> > > > > --- a/fs/exec.c
> > > > > +++ b/fs/exec.c
> > > > > @@ -931,7 +931,7 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
> > > > >                 .lookup_flags = LOOKUP_FOLLOW,
> > > > >         };
> > > > >
> > > > > -       if ((flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
> > > > > +       if ((flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH | AT_CHECK)) != 0)
> > > > >                 return ERR_PTR(-EINVAL);
> > > > >         if (flags & AT_SYMLINK_NOFOLLOW)
> > > > >                 open_exec_flags.lookup_flags &= ~LOOKUP_FOLLOW;
> > > > > @@ -1595,6 +1595,7 @@ static struct linux_binprm *alloc_bprm(int fd, struct filename *filename, int fl
> > > > >                 bprm->filename = bprm->fdpath;
> > > > >         }
> > > > >         bprm->interp = bprm->filename;
> > > > > +       bprm->is_check = !!(flags & AT_CHECK);
> > > > >
> > > > >         retval = bprm_mm_init(bprm);
> > > > >         if (!retval)
> > > > > @@ -1885,7 +1886,7 @@ static int bprm_execve(struct linux_binprm *bprm)
> > > > >
> > > > >         /* Set the unchanging part of bprm->cred */
> > > > >         retval = security_bprm_creds_for_exec(bprm);
> > > > > -       if (retval)
> > > > > +       if (retval || bprm->is_check)
> > > > >                 goto out;
> > > > >
> > > > >         retval = exec_binprm(bprm);
> > > > > diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> > > > > index 70f97f685bff..8ff9c9e33aed 100644
> > > > > --- a/include/linux/binfmts.h
> > > > > +++ b/include/linux/binfmts.h
> > > > > @@ -42,7 +42,12 @@ struct linux_binprm {
> > > > >                  * Set when errors can no longer be returned to the
> > > > >                  * original userspace.
> > > > >                  */
> > > > > -               point_of_no_return:1;
> > > > > +               point_of_no_return:1,
> > > > > +               /*
> > > > > +                * Set by user space to check executability according to the
> > > > > +                * caller's environment.
> > > > > +                */
> > > > > +               is_check:1;
> > > > >         struct file *executable; /* Executable to pass to the interpreter */
> > > > >         struct file *interpreter;
> > > > >         struct file *file;
> > > > > diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> > > > > index c0bcc185fa48..bcd05c59b7df 100644
> > > > > --- a/include/uapi/linux/fcntl.h
> > > > > +++ b/include/uapi/linux/fcntl.h
> > > > > @@ -118,6 +118,36 @@
> > > > >  #define AT_HANDLE_FID          AT_REMOVEDIR    /* file handle is needed to
> > > > >                                         compare object identity and may not
> > > > >                                         be usable to open_by_handle_at(2) */
> > > > > +
> > > > > +/*
> > > > > + * AT_CHECK only performs a check on a regular file and returns 0 if execution
> > > > > + * of this file would be allowed, ignoring the file format and then the related
> > > > > + * interpreter dependencies (e.g. ELF libraries, script's shebang).  AT_CHECK
> > > > > + * should only be used if SECBIT_SHOULD_EXEC_CHECK is set for the calling
> > > > > + * thread.  See securebits.h documentation.
> > > > > + *
> > > > > + * Programs should use this check to apply kernel-level checks against files
> > > > > + * that are not directly executed by the kernel but directly passed to a user
> > > > > + * space interpreter instead.  All files that contain executable code, from the
> > > > > + * point of view of the interpreter, should be checked.  The main purpose of
> > > > > + * this flag is to improve the security and consistency of an execution
> > > > > + * environment to ensure that direct file execution (e.g. ./script.sh) and
> > > > > + * indirect file execution (e.g. sh script.sh) lead to the same result.  For
> > > > > + * instance, this can be used to check if a file is trustworthy according to
> > > > > + * the caller's environment.
> > > > > + *
> > > > > + * In a secure environment, libraries and any executable dependencies should
> > > > > + * also be checked.  For instance dynamic linking should make sure that all
> > > > > + * libraries are allowed for execution to avoid trivial bypass (e.g. using
> > > > > + * LD_PRELOAD).  For such secure execution environment to make sense, only
> > > > > + * trusted code should be executable, which also requires integrity guarantees.
> > > > > + *
> > > > > + * To avoid race conditions leading to time-of-check to time-of-use issues,
> > > > > + * AT_CHECK should be used with AT_EMPTY_PATH to check against a file
> > > > > + * descriptor instead of a path.
> > > > > + */
> > > > > +#define AT_CHECK               0x10000
> > > > > +
> > > > >  #if defined(__KERNEL__)
> > > > >  #define AT_GETATTR_NOSEC       0x80000000
> > > > >  #endif
> > > > > diff --git a/kernel/audit.h b/kernel/audit.h
> > > > > index a60d2840559e..8ebdabd2ab81 100644
> > > > > --- a/kernel/audit.h
> > > > > +++ b/kernel/audit.h
> > > > > @@ -197,6 +197,7 @@ struct audit_context {
> > > > >                 struct open_how openat2;
> > > > >                 struct {
> > > > >                         int                     argc;
> > > > > +                       bool                    is_check;
> > > > >                 } execve;
> > > > >                 struct {
> > > > >                         char                    *name;
> > > > > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > > > > index 6f0d6fb6523f..b6316e284342 100644
> > > > > --- a/kernel/auditsc.c
> > > > > +++ b/kernel/auditsc.c
> > > > > @@ -2662,6 +2662,7 @@ void __audit_bprm(struct linux_binprm *bprm)
> > > > >
> > > > >         context->type = AUDIT_EXECVE;
> > > > >         context->execve.argc = bprm->argc;
> > > > > +       context->execve.is_check = bprm->is_check;
> > > > >  }
> > > > >
> > > > >
> > > > > --
> > > > > 2.45.2
> > > > >
> > > >
> 

