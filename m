Return-Path: <linux-fsdevel+bounces-35977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 737859DA76C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 13:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAF181652A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 12:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678A71FAC53;
	Wed, 27 Nov 2024 12:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="g1huBdDD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E8C1FAC49
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2024 12:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732709289; cv=none; b=cNFT/NQMUniGySbg8EtEk5Y93HlCpJO27uOd7q5fNQv4EYsmQHtjpgJmJICjXHsRYD5uSDuOE3Ar44KTDcRBRNKBj50AP6ougGzC/c6PluqISx8OUH1SKLzGMxpJuZlA+Y2LbD/2FWP25I896mvTTHUM3HonIQCWj52vAJKEQDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732709289; c=relaxed/simple;
	bh=WJvqmQ+xhf09Z/4BHWJrHRCdWSsCIF0Rns9cQyeF/5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WH7twswN2gwJ5nDrm9XdkeonUaaFp3Hz8ulcJNMl4R+/IZLj7GJxnLpHN+wI8ZY5jyuvCPMI5foDmdfNcl9CDlK0XDK084NGVx+Wqh7t8H1dYaRqhDwgx4xncxKcnzyGkTeJ4nEclRritRV62q9kITSUC/WY0vdsjhOrMIjgYiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=g1huBdDD; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XyyrD0rP1z5tJ;
	Wed, 27 Nov 2024 13:07:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1732709275;
	bh=EiGftrje5ypKE9pthGsmxW8FbQHmXEJU7gSd9a+4HlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g1huBdDDKh9YdHXR1cyODB59m89R8VP4E3M6d2uBBMxZbdmukk2nJbsqg9XRqZBmv
	 GblAPD3Lp4aNwCzXn/6jEWKjx6arQH8KXY6huvaZLAdSe3dkzgnUk3M+3R5eGvVm4Y
	 A4UqPR125v5nlUN/dUsitWlLPXQxSEnwxVdEjnCA=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Xyyr86nX0z8bb;
	Wed, 27 Nov 2024 13:07:52 +0100 (CET)
Date: Wed, 27 Nov 2024 13:07:48 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jeff Xu <jeffxu@google.com>
Cc: Jeff Xu <jeffxu@chromium.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <serge@hallyn.com>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, Alejandro Colomar <alx@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Elliott Hughes <enh@google.com>, 
	Eric Biggers <ebiggers@kernel.org>, Eric Chiang <ericchiang@google.com>, 
	Fan Wu <wufan@linux.microsoft.com>, Florian Weimer <fweimer@redhat.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, James Morris <jamorris@linux.microsoft.com>, 
	Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Luca Boccassi <bluca@debian.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Matthew Garrett <mjg59@srcf.ucam.org>, 
	Matthew Wilcox <willy@infradead.org>, Miklos Szeredi <mszeredi@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, 
	Scott Shell <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Steve Dower <steve.dower@python.org>, 
	Steve Grubb <sgrubb@redhat.com>, Theodore Ts'o <tytso@mit.edu>, 
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, Vincent Strubel <vincent.strubel@ssi.gouv.fr>, 
	Xiaoming Ni <nixiaoming@huawei.com>, Yin Fengwei <fengwei.yin@intel.com>, 
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Eric Paris <eparis@redhat.com>, audit@vger.kernel.org
Subject: Re: [PATCH v21 1/6] exec: Add a new AT_EXECVE_CHECK flag to
 execveat(2)
Message-ID: <20241127.aizae7eeHohn@digikod.net>
References: <20241112191858.162021-1-mic@digikod.net>
 <20241112191858.162021-2-mic@digikod.net>
 <CABi2SkVRJC_7qoU56mDt3Ch7U9GnVeRogUt9wc9=32OtG6aatw@mail.gmail.com>
 <20241120.Uy8ahtai5oku@digikod.net>
 <CABi2SkUx=7zummB4JCqEfb37p6MORR88y7S0E_YxJND_8dGaKA@mail.gmail.com>
 <20241121.uquee7ohRohn@digikod.net>
 <CABi2SkVHW9MBm=quZPdim_pM=BPaUD-8jRjG6G8OyQ8fQVsm0A@mail.gmail.com>
 <20241122.akooL5pie0th@digikod.net>
 <CALmYWFuYVHHz7aoxk+U=auLLT4xvJdzyOyzQ2u+E0kM3uc_rTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALmYWFuYVHHz7aoxk+U=auLLT4xvJdzyOyzQ2u+E0kM3uc_rTw@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Mon, Nov 25, 2024 at 09:38:51AM -0800, Jeff Xu wrote:
> On Fri, Nov 22, 2024 at 6:50 AM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > On Thu, Nov 21, 2024 at 10:27:40AM -0800, Jeff Xu wrote:
> > > On Thu, Nov 21, 2024 at 5:40 AM Mickaël Salaün <mic@digikod.net> wrote:
> > > >
> > > > On Wed, Nov 20, 2024 at 08:06:07AM -0800, Jeff Xu wrote:
> > > > > On Wed, Nov 20, 2024 at 1:42 AM Mickaël Salaün <mic@digikod.net> wrote:
> > > > > >
> > > > > > On Tue, Nov 19, 2024 at 05:17:00PM -0800, Jeff Xu wrote:
> > > > > > > On Tue, Nov 12, 2024 at 11:22 AM Mickaël Salaün <mic@digikod.net> wrote:
> > > > > > > >
> > > > > > > > Add a new AT_EXECVE_CHECK flag to execveat(2) to check if a file would
> > > > > > > > be allowed for execution.  The main use case is for script interpreters
> > > > > > > > and dynamic linkers to check execution permission according to the
> > > > > > > > kernel's security policy. Another use case is to add context to access
> > > > > > > > logs e.g., which script (instead of interpreter) accessed a file.  As
> > > > > > > > any executable code, scripts could also use this check [1].
> > > > > > > >
> > > > > > > > This is different from faccessat(2) + X_OK which only checks a subset of
> > > > > > > > access rights (i.e. inode permission and mount options for regular
> > > > > > > > files), but not the full context (e.g. all LSM access checks).  The main
> > > > > > > > use case for access(2) is for SUID processes to (partially) check access
> > > > > > > > on behalf of their caller.  The main use case for execveat(2) +
> > > > > > > > AT_EXECVE_CHECK is to check if a script execution would be allowed,
> > > > > > > > according to all the different restrictions in place.  Because the use
> > > > > > > > of AT_EXECVE_CHECK follows the exact kernel semantic as for a real
> > > > > > > > execution, user space gets the same error codes.
> > > > > > > >
> > > > > > > > An interesting point of using execveat(2) instead of openat2(2) is that
> > > > > > > > it decouples the check from the enforcement.  Indeed, the security check
> > > > > > > > can be logged (e.g. with audit) without blocking an execution
> > > > > > > > environment not yet ready to enforce a strict security policy.
> > > > > > > >
> > > > > > > > LSMs can control or log execution requests with
> > > > > > > > security_bprm_creds_for_exec().  However, to enforce a consistent and
> > > > > > > > complete access control (e.g. on binary's dependencies) LSMs should
> > > > > > > > restrict file executability, or mesure executed files, with
> > > > > > > > security_file_open() by checking file->f_flags & __FMODE_EXEC.
> > > > > > > >
> > > > > > > > Because AT_EXECVE_CHECK is dedicated to user space interpreters, it
> > > > > > > > doesn't make sense for the kernel to parse the checked files, look for
> > > > > > > > interpreters known to the kernel (e.g. ELF, shebang), and return ENOEXEC
> > > > > > > > if the format is unknown.  Because of that, security_bprm_check() is
> > > > > > > > never called when AT_EXECVE_CHECK is used.
> > > > > > > >
> > > > > > > > It should be noted that script interpreters cannot directly use
> > > > > > > > execveat(2) (without this new AT_EXECVE_CHECK flag) because this could
> > > > > > > > lead to unexpected behaviors e.g., `python script.sh` could lead to Bash
> > > > > > > > being executed to interpret the script.  Unlike the kernel, script
> > > > > > > > interpreters may just interpret the shebang as a simple comment, which
> > > > > > > > should not change for backward compatibility reasons.
> > > > > > > >
> > > > > > > > Because scripts or libraries files might not currently have the
> > > > > > > > executable permission set, or because we might want specific users to be
> > > > > > > > allowed to run arbitrary scripts, the following patch provides a dynamic
> > > > > > > > configuration mechanism with the SECBIT_EXEC_RESTRICT_FILE and
> > > > > > > > SECBIT_EXEC_DENY_INTERACTIVE securebits.
> > > > > > > >
> > > > > > > > This is a redesign of the CLIP OS 4's O_MAYEXEC:
> > > > > > > > https://github.com/clipos-archive/src_platform_clip-patches/blob/f5cb330d6b684752e403b4e41b39f7004d88e561/1901_open_mayexec.patch
> > > > > > > > This patch has been used for more than a decade with customized script
> > > > > > > > interpreters.  Some examples can be found here:
> > > > > > > > https://github.com/clipos-archive/clipos4_portage-overlay/search?q=O_MAYEXEC
> > > > > > > >
> > > > > > > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > > > > > > Cc: Christian Brauner <brauner@kernel.org>
> > > > > > > > Cc: Kees Cook <keescook@chromium.org>
> > > > > > > > Cc: Paul Moore <paul@paul-moore.com>
> > > > > > > > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> > > > > > > > Link: https://docs.python.org/3/library/io.html#io.open_code [1]
> > > > > > > > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > > > > > > > Link: https://lore.kernel.org/r/20241112191858.162021-2-mic@digikod.net
> > > > > > > > ---
> > > > > > > >
> > > > > > > > Changes since v20:
> > > > > > > > * Rename AT_CHECK to AT_EXECVE_CHECK, requested by Amir Goldstein and
> > > > > > > >   Serge Hallyn.
> > > > > > > > * Move the UAPI documentation to a dedicated RST file.
> > > > > > > > * Add Reviewed-by: Serge Hallyn
> > > > > > > >
> > > > > > > > Changes since v19:
> > > > > > > > * Remove mention of "role transition" as suggested by Andy.
> > > > > > > > * Highlight the difference between security_bprm_creds_for_exec() and
> > > > > > > >   the __FMODE_EXEC check for LSMs (in commit message and LSM's hooks) as
> > > > > > > >   discussed with Jeff.
> > > > > > > > * Improve documentation both in UAPI comments and kernel comments
> > > > > > > >   (requested by Kees).
> > > > > > > >
> > > > > > > > New design since v18:
> > > > > > > > https://lore.kernel.org/r/20220104155024.48023-3-mic@digikod.net
> > > > > > > > ---
> > > > > > > >  Documentation/userspace-api/check_exec.rst | 34 ++++++++++++++++++++++
> > > > > > > >  Documentation/userspace-api/index.rst      |  1 +
> > > > > > > >  fs/exec.c                                  | 20 +++++++++++--
> > > > > > > >  include/linux/binfmts.h                    |  7 ++++-
> > > > > > > >  include/uapi/linux/fcntl.h                 |  4 +++
> > > > > > > >  kernel/audit.h                             |  1 +
> > > > > > > >  kernel/auditsc.c                           |  1 +
> > > > > > > >  security/security.c                        | 10 +++++++
> > > > > > > >  8 files changed, 75 insertions(+), 3 deletions(-)
> > > > > > > >  create mode 100644 Documentation/userspace-api/check_exec.rst
> > > > > > > >
> > > > > > > > diff --git a/Documentation/userspace-api/check_exec.rst b/Documentation/userspace-api/check_exec.rst
> > > > > > > > new file mode 100644
> > > > > > > > index 000000000000..ad1aeaa5f6c0
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/Documentation/userspace-api/check_exec.rst
> > > > > > > > @@ -0,0 +1,34 @@
> > > > > > > > +===================
> > > > > > > > +Executability check
> > > > > > > > +===================
> > > > > > > > +
> > > > > > > > +AT_EXECVE_CHECK
> > > > > > > > +===============
> > > > > > > > +
> > > > > > > > +Passing the ``AT_EXECVE_CHECK`` flag to :manpage:`execveat(2)` only performs a
> > > > > > > > +check on a regular file and returns 0 if execution of this file would be
> > > > > > > > +allowed, ignoring the file format and then the related interpreter dependencies
> > > > > > > > +(e.g. ELF libraries, script's shebang).
> > > > > > > > +
> > > > > > > > +Programs should always perform this check to apply kernel-level checks against
> > > > > > > > +files that are not directly executed by the kernel but passed to a user space
> > > > > > > > +interpreter instead.  All files that contain executable code, from the point of
> > > > > > > > +view of the interpreter, should be checked.  However the result of this check
> > > > > > > > +should only be enforced according to ``SECBIT_EXEC_RESTRICT_FILE`` or
> > > > > > > > +``SECBIT_EXEC_DENY_INTERACTIVE.``.
> > > > > > > Regarding "should only"
> > > > > > > Userspace (e.g. libc) could decide to enforce even when
> > > > > > > SECBIT_EXEC_RESTRICT_FILE=0), i.e. if it determines not-enforcing
> > > > > > > doesn't make sense.
> > > > > >
> > > > > > User space is always in control, but I don't think it would be wise to
> > > > > > not follow the configuration securebits (in a generic system) because
> > > > > > this could result to unattended behaviors (I don't have a specific one
> > > > > > in mind but...).  That being said, configuration and checks are
> > > > > > standalones and specific/tailored systems are free to do the checks they
> > > > > > want.
> > > > > >
> > > > > In the case of dynamic linker, we can always enforce honoring the
> > > > > execveat(AT_EXECVE_CHECK) result, right ? I can't think of a case not
> > > > > to,  the dynamic linker doesn't need to check the
> > > > > SECBIT_EXEC_RESTRICT_FILE bit.
> > > >
> > > > If the library file is not allowed to be executed by *all* access
> > > > control systems (not just mount and file permission, but all LSMs), then
> > > > the AT_EXECVE_CHECK will fail, which is OK as long as it is not a hard
> > > > requirement.
> > > Yes. specifically for the library loading case, I can't think of a
> > > case where we need to by-pass LSMs.  (letting user space to by-pass
> > > LSM check seems questionable in concept, and should only be used when
> > > there aren't other solutions). In the context of SELINUX enforcing
> > > mode,  we will want to enforce it. In the context of process level LSM
> > > such as landlock,  the process can already decide for itself by
> > > selecting the policy for its own domain, it is unnecessary to use
> > > another opt-out solution.
> >
> > My answer wasn't clear.  The execveat(AT_EXECVE_CHECK) can and should
> > always be done, but user space should only enforce restrictions
> > according to the securebits.
> >
> I knew this part (AT_EXESCVE_CHECK is called always)
> Since the securebits are enforced by userspace, setting it to 0 is
> equivalent to opt-out enforcement, that is what I meant by opt-out.

OK, that was confusing because these bits are set to 0 by default (for
compatibility reasons).

> 
> > It doesn't make sense to talk about user space "bypassing" kernel
> > checks.  This patch series provides a feature to enable user space to
> > enforce (at its level) the same checks as the kernel.
> >
> > There is no opt-out solution, but compatibility configuration bits
> > through securebits (which can also be set by LSMs).
> >
> > To answer your question about the dynamic linker, there should be no
> > difference of behavior with a script interpreter.  Both should check
> > executability but only enforce restriction according to the securebits
> > (as explained in the documentation).  Doing otherwise on a generic
> > distro could lead to unexpected behaviors (e.g. if a user enforced a
> > specific SELinux policy that doesn't allow execution of library files).
> >
> > >
> > > There is one case where I see a difference:
> > > ld.so a.out (when a.out is on non-exec mount)
> > >
> > > If the dynamic linker doesn't read SECBIT_EXEC_RESTRICT_FILE setting,
> > > above will always fail. But that is more of a bugfix.
> >
> > No, the dynamic linker should only enforce restrictions according to the
> > securebits, otherwise a user space update (e.g. with a new dynamic
> > linker ignoring the securebits) could break an existing system.
> >
> OK. upgrade is a valid concern. Previously, I was just thinking about
> a new LSM based on this check, not existing LSM policies.
> Do you happen to know which SELinux policy/LSM could break ? i.e. it
> will be applied to libraries once we add AT_EXESCVE_CHECK in the
> dynamic linker.

We cannot assume anything about LSM policies because of custom and
private ones.

> We could give heads up and prepare for that.
> 
> > >
> > > >Relying on the securebits to know if this is a hard
> > > > requirement or not enables system administrator and distros to control
> > > > this potential behavior change.
> > > >
> > > I think, for the dynamic linker, it can be a hard requirement.
> >
> > Not on a generic distro.
> >
> Ok. Maybe this can be done through a configuration option for the
> dynamic linker.

Yes, we could have a built-time option (disabled by default) for the
dynamic linker to enforce that.

> 
> The consideration I have is: securebits is currently designed to
> control both dynamic linker and shell scripts.
> The case for dynamic linker is simpler than scripts cases, (non-exec
> mount, and perhaps some LSM policies for libraries) and distributions
> such as ChromeOS can enforce the dynamic linker case ahead of scripts
> interrupter cases, i.e. without waiting for python/shell being
> upgraded, that can take sometimes.

For secure systems, the end goal is to always enforce such restrictions,
so once interpretation/execution of a set of file types (e.g. ELF
libraries) are tested enough in such a system, we can remove the
securebits checks for the related library/executable (e.g. ld.so) and
consider that they are always set, independently of the current
user/credentials.

