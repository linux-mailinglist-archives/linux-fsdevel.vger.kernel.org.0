Return-Path: <linux-fsdevel+bounces-35293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 575C99D373B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 10:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56C61F23BA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 09:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED4B19CC27;
	Wed, 20 Nov 2024 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="rP21ilv4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1B418A6A8
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732095771; cv=none; b=QvlOdesrAOUidC/Yo2HFrDMvYUqsXkWNMiSN5BGzaQypMyLCWttleHL8sgngoiU1PE3xUjfOb9ZmJ2IXadBKPEbKqwpdr5M2YT18J11kMGnGMfTMslA2odIpnoCy5V2PmPuOhneZsr4rVwzHS/tUaRwdZS+i+68XG/iA0haT9PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732095771; c=relaxed/simple;
	bh=DL1EMCWgQ7mUmrdRLWVn4IKAh3mS223gCHzO17WAobM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jspp0PvzuG1MvzqibsEluMC4V5P21eP136QB/mxAbjVCo9VcNDo0iiJ7s7V0KDUkYw7wdIxAKr/Vrtk7iXbhs8CZgoJR5pYjSpqr+sRTwdm/K8dg0D+9asg/lJq5bnk3idi5ijD2+63Eo39URA/6qdaOBXxjrm2fQimhGqKchFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=rP21ilv4; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Xtbxt6ws2zGHt;
	Wed, 20 Nov 2024 10:42:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1732095762;
	bh=pWZ1JIjHYEiQSNew9aQ0v0zJkyWkGzv9i3fn9uGxjo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rP21ilv4xUG/dJZiqeaWKDGYPauJ4iubA5xCCk/EaDq48mQeANnCsxu6oepPlMayG
	 yxMeFBf1ww9qpyrK2qXuX92DAVWXE7nLbp0fDE/vYUIUksDa3TNT7hJdrMJKnuDM+a
	 Xf6R1UngnVPLa9avKY7+L0Ql1zoOVvnsAwzJOiM4=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Xtbxp5fpPz9Z4;
	Wed, 20 Nov 2024 10:42:38 +0100 (CET)
Date: Wed, 20 Nov 2024 10:42:37 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
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
	Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jordan R Abrahams <ajordanr@google.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Scott Shell <scottsh@microsoft.com>, 
	Shuah Khan <shuah@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, Theodore Ts'o <tytso@mit.edu>, 
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, Vincent Strubel <vincent.strubel@ssi.gouv.fr>, 
	Xiaoming Ni <nixiaoming@huawei.com>, Yin Fengwei <fengwei.yin@intel.com>, 
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v21 1/6] exec: Add a new AT_EXECVE_CHECK flag to
 execveat(2)
Message-ID: <20241120.Uy8ahtai5oku@digikod.net>
References: <20241112191858.162021-1-mic@digikod.net>
 <20241112191858.162021-2-mic@digikod.net>
 <CABi2SkVRJC_7qoU56mDt3Ch7U9GnVeRogUt9wc9=32OtG6aatw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkVRJC_7qoU56mDt3Ch7U9GnVeRogUt9wc9=32OtG6aatw@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Tue, Nov 19, 2024 at 05:17:00PM -0800, Jeff Xu wrote:
> On Tue, Nov 12, 2024 at 11:22 AM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > Add a new AT_EXECVE_CHECK flag to execveat(2) to check if a file would
> > be allowed for execution.  The main use case is for script interpreters
> > and dynamic linkers to check execution permission according to the
> > kernel's security policy. Another use case is to add context to access
> > logs e.g., which script (instead of interpreter) accessed a file.  As
> > any executable code, scripts could also use this check [1].
> >
> > This is different from faccessat(2) + X_OK which only checks a subset of
> > access rights (i.e. inode permission and mount options for regular
> > files), but not the full context (e.g. all LSM access checks).  The main
> > use case for access(2) is for SUID processes to (partially) check access
> > on behalf of their caller.  The main use case for execveat(2) +
> > AT_EXECVE_CHECK is to check if a script execution would be allowed,
> > according to all the different restrictions in place.  Because the use
> > of AT_EXECVE_CHECK follows the exact kernel semantic as for a real
> > execution, user space gets the same error codes.
> >
> > An interesting point of using execveat(2) instead of openat2(2) is that
> > it decouples the check from the enforcement.  Indeed, the security check
> > can be logged (e.g. with audit) without blocking an execution
> > environment not yet ready to enforce a strict security policy.
> >
> > LSMs can control or log execution requests with
> > security_bprm_creds_for_exec().  However, to enforce a consistent and
> > complete access control (e.g. on binary's dependencies) LSMs should
> > restrict file executability, or mesure executed files, with
> > security_file_open() by checking file->f_flags & __FMODE_EXEC.
> >
> > Because AT_EXECVE_CHECK is dedicated to user space interpreters, it
> > doesn't make sense for the kernel to parse the checked files, look for
> > interpreters known to the kernel (e.g. ELF, shebang), and return ENOEXEC
> > if the format is unknown.  Because of that, security_bprm_check() is
> > never called when AT_EXECVE_CHECK is used.
> >
> > It should be noted that script interpreters cannot directly use
> > execveat(2) (without this new AT_EXECVE_CHECK flag) because this could
> > lead to unexpected behaviors e.g., `python script.sh` could lead to Bash
> > being executed to interpret the script.  Unlike the kernel, script
> > interpreters may just interpret the shebang as a simple comment, which
> > should not change for backward compatibility reasons.
> >
> > Because scripts or libraries files might not currently have the
> > executable permission set, or because we might want specific users to be
> > allowed to run arbitrary scripts, the following patch provides a dynamic
> > configuration mechanism with the SECBIT_EXEC_RESTRICT_FILE and
> > SECBIT_EXEC_DENY_INTERACTIVE securebits.
> >
> > This is a redesign of the CLIP OS 4's O_MAYEXEC:
> > https://github.com/clipos-archive/src_platform_clip-patches/blob/f5cb330d6b684752e403b4e41b39f7004d88e561/1901_open_mayexec.patch
> > This patch has been used for more than a decade with customized script
> > interpreters.  Some examples can be found here:
> > https://github.com/clipos-archive/clipos4_portage-overlay/search?q=O_MAYEXEC
> >
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> > Link: https://docs.python.org/3/library/io.html#io.open_code [1]
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > Link: https://lore.kernel.org/r/20241112191858.162021-2-mic@digikod.net
> > ---
> >
> > Changes since v20:
> > * Rename AT_CHECK to AT_EXECVE_CHECK, requested by Amir Goldstein and
> >   Serge Hallyn.
> > * Move the UAPI documentation to a dedicated RST file.
> > * Add Reviewed-by: Serge Hallyn
> >
> > Changes since v19:
> > * Remove mention of "role transition" as suggested by Andy.
> > * Highlight the difference between security_bprm_creds_for_exec() and
> >   the __FMODE_EXEC check for LSMs (in commit message and LSM's hooks) as
> >   discussed with Jeff.
> > * Improve documentation both in UAPI comments and kernel comments
> >   (requested by Kees).
> >
> > New design since v18:
> > https://lore.kernel.org/r/20220104155024.48023-3-mic@digikod.net
> > ---
> >  Documentation/userspace-api/check_exec.rst | 34 ++++++++++++++++++++++
> >  Documentation/userspace-api/index.rst      |  1 +
> >  fs/exec.c                                  | 20 +++++++++++--
> >  include/linux/binfmts.h                    |  7 ++++-
> >  include/uapi/linux/fcntl.h                 |  4 +++
> >  kernel/audit.h                             |  1 +
> >  kernel/auditsc.c                           |  1 +
> >  security/security.c                        | 10 +++++++
> >  8 files changed, 75 insertions(+), 3 deletions(-)
> >  create mode 100644 Documentation/userspace-api/check_exec.rst
> >
> > diff --git a/Documentation/userspace-api/check_exec.rst b/Documentation/userspace-api/check_exec.rst
> > new file mode 100644
> > index 000000000000..ad1aeaa5f6c0
> > --- /dev/null
> > +++ b/Documentation/userspace-api/check_exec.rst
> > @@ -0,0 +1,34 @@
> > +===================
> > +Executability check
> > +===================
> > +
> > +AT_EXECVE_CHECK
> > +===============
> > +
> > +Passing the ``AT_EXECVE_CHECK`` flag to :manpage:`execveat(2)` only performs a
> > +check on a regular file and returns 0 if execution of this file would be
> > +allowed, ignoring the file format and then the related interpreter dependencies
> > +(e.g. ELF libraries, script's shebang).
> > +
> > +Programs should always perform this check to apply kernel-level checks against
> > +files that are not directly executed by the kernel but passed to a user space
> > +interpreter instead.  All files that contain executable code, from the point of
> > +view of the interpreter, should be checked.  However the result of this check
> > +should only be enforced according to ``SECBIT_EXEC_RESTRICT_FILE`` or
> > +``SECBIT_EXEC_DENY_INTERACTIVE.``.
> Regarding "should only"
> Userspace (e.g. libc) could decide to enforce even when
> SECBIT_EXEC_RESTRICT_FILE=0), i.e. if it determines not-enforcing
> doesn't make sense.

User space is always in control, but I don't think it would be wise to
not follow the configuration securebits (in a generic system) because
this could result to unattended behaviors (I don't have a specific one
in mind but...).  That being said, configuration and checks are
standalones and specific/tailored systems are free to do the checks they
want.

> When SECBIT_EXEC_RESTRICT_FILE=1,  userspace is bound to enforce.
> 
> > +
> > +The main purpose of this flag is to improve the security and consistency of an
> > +execution environment to ensure that direct file execution (e.g.
> > +``./script.sh``) and indirect file execution (e.g. ``sh script.sh``) lead to
> > +the same result.  For instance, this can be used to check if a file is
> > +trustworthy according to the caller's environment.
> > +
> > +In a secure environment, libraries and any executable dependencies should also
> > +be checked.  For instance, dynamic linking should make sure that all libraries
> > +are allowed for execution to avoid trivial bypass (e.g. using ``LD_PRELOAD``).
> > +For such secure execution environment to make sense, only trusted code should
> > +be executable, which also requires integrity guarantees.
> > +
> > +To avoid race conditions leading to time-of-check to time-of-use issues,
> > +``AT_EXECVE_CHECK`` should be used with ``AT_EMPTY_PATH`` to check against a
> > +file descriptor instead of a path.
> > diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
> > index 274cc7546efc..6272bcf11296 100644
> > --- a/Documentation/userspace-api/index.rst
> > +++ b/Documentation/userspace-api/index.rst
> > @@ -35,6 +35,7 @@ Security-related interfaces
> >     mfd_noexec
> >     spec_ctrl
> >     tee
> > +   check_exec
> >
> >  Devices and I/O
> >  ===============
> > diff --git a/fs/exec.c b/fs/exec.c
> > index 6c53920795c2..bb83b6a39530 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -891,7 +891,8 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
> >                 .lookup_flags = LOOKUP_FOLLOW,
> >         };
> >
> > -       if ((flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
> > +       if ((flags &
> > +            ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH | AT_EXECVE_CHECK)) != 0)
> >                 return ERR_PTR(-EINVAL);
> >         if (flags & AT_SYMLINK_NOFOLLOW)
> >                 open_exec_flags.lookup_flags &= ~LOOKUP_FOLLOW;
> > @@ -1545,6 +1546,21 @@ static struct linux_binprm *alloc_bprm(int fd, struct filename *filename, int fl
> >         }
> >         bprm->interp = bprm->filename;
> >
> > +       /*
> > +        * At this point, security_file_open() has already been called (with
> > +        * __FMODE_EXEC) and access control checks for AT_EXECVE_CHECK will
> > +        * stop just after the security_bprm_creds_for_exec() call in
> > +        * bprm_execve().  Indeed, the kernel should not try to parse the
> > +        * content of the file with exec_binprm() nor change the calling
> > +        * thread, which means that the following security functions will be
> > +        * not called:
> > +        * - security_bprm_check()
> > +        * - security_bprm_creds_from_file()
> > +        * - security_bprm_committing_creds()
> > +        * - security_bprm_committed_creds()
> > +        */
> > +       bprm->is_check = !!(flags & AT_EXECVE_CHECK);
> > +
> >         retval = bprm_mm_init(bprm);
> >         if (!retval)
> >                 return bprm;
> > @@ -1839,7 +1855,7 @@ static int bprm_execve(struct linux_binprm *bprm)
> >
> >         /* Set the unchanging part of bprm->cred */
> >         retval = security_bprm_creds_for_exec(bprm);
> > -       if (retval)
> > +       if (retval || bprm->is_check)
> >                 goto out;
> >
> >         retval = exec_binprm(bprm);
> > diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> > index e6c00e860951..8ff0eb3644a1 100644
> > --- a/include/linux/binfmts.h
> > +++ b/include/linux/binfmts.h
> > @@ -42,7 +42,12 @@ struct linux_binprm {
> >                  * Set when errors can no longer be returned to the
> >                  * original userspace.
> >                  */
> > -               point_of_no_return:1;
> > +               point_of_no_return:1,
> > +               /*
> > +                * Set by user space to check executability according to the
> > +                * caller's environment.
> > +                */
> > +               is_check:1;
> >         struct file *executable; /* Executable to pass to the interpreter */
> >         struct file *interpreter;
> >         struct file *file;
> > diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> > index 87e2dec79fea..2e87f2e3a79f 100644
> > --- a/include/uapi/linux/fcntl.h
> > +++ b/include/uapi/linux/fcntl.h
> > @@ -154,6 +154,10 @@
> >                                            usable with open_by_handle_at(2). */
> >  #define AT_HANDLE_MNT_ID_UNIQUE        0x001   /* Return the u64 unique mount ID. */
> >
> > +/* Flags for execveat2(2). */
> > +#define AT_EXECVE_CHECK                0x10000 /* Only perform a check if execution
> > +                                          would be allowed. */
> > +
> >  #if defined(__KERNEL__)
> >  #define AT_GETATTR_NOSEC       0x80000000
> >  #endif
> > diff --git a/kernel/audit.h b/kernel/audit.h
> > index a60d2840559e..8ebdabd2ab81 100644
> > --- a/kernel/audit.h
> > +++ b/kernel/audit.h
> > @@ -197,6 +197,7 @@ struct audit_context {
> >                 struct open_how openat2;
> >                 struct {
> >                         int                     argc;
> > +                       bool                    is_check;
> >                 } execve;
> >                 struct {
> >                         char                    *name;
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index cd57053b4a69..8d9ba5600cf2 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -2662,6 +2662,7 @@ void __audit_bprm(struct linux_binprm *bprm)
> >
> >         context->type = AUDIT_EXECVE;
> >         context->execve.argc = bprm->argc;
> > +       context->execve.is_check = bprm->is_check;
> Where is execve.is_check used ?

It is used in bprm_execve(), exposed to the audit framework, and
potentially used by LSMs.

> 
> 
> >  }
> >
> >
> > diff --git a/security/security.c b/security/security.c
> > index c5981e558bc2..456361ec249d 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -1249,6 +1249,12 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
> >   * to 1 if AT_SECURE should be set to request libc enable secure mode.  @bprm
> >   * contains the linux_binprm structure.
> >   *
> > + * If execveat(2) is called with the AT_EXECVE_CHECK flag, bprm->is_check is
> > + * set.  The result must be the same as without this flag even if the execution
> > + * will never really happen and @bprm will always be dropped.
> > + *
> > + * This hook must not change current->cred, only @bprm->cred.
> > + *
> >   * Return: Returns 0 if the hook is successful and permission is granted.
> >   */
> >  int security_bprm_creds_for_exec(struct linux_binprm *bprm)
> > @@ -3100,6 +3106,10 @@ int security_file_receive(struct file *file)
> >   * Save open-time permission checking state for later use upon file_permission,
> >   * and recheck access if anything has changed since inode_permission.
> >   *
> > + * We can check if a file is opened for execution (e.g. execve(2) call), either
> > + * directly or indirectly (e.g. ELF's ld.so) by checking file->f_flags &
> > + * __FMODE_EXEC .
> > + *
> >   * Return: Returns 0 if permission is granted.
> >   */
> >  int security_file_open(struct file *file)
> > --
> > 2.47.0
> >
> >

