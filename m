Return-Path: <linux-fsdevel+bounces-31848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFCB99C19C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 09:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C1EB1C2273A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 07:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D293214EC77;
	Mon, 14 Oct 2024 07:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="0+X0hdlg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A0D149013
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 07:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728891592; cv=none; b=hazWYrc10NizPggSp7HkFaKW1OI5hrbVA/ft8SYY36wf606u1t1/HrrsautNGYnf39HxD9r9UcWOrlxahPmXGKr4aVx4LxciwXg+de7QV0C81C+Na4F5+rbqS8iLmv4dPzMnLNmQij5q0ixLAOBop+DFS/vcFNUFRin1IiTtdsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728891592; c=relaxed/simple;
	bh=/0EWjnNyTSMVWAX7PR9l4tolkkuP28KKuXM//fxuEKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epfuv/PFa/8AmLz+tznX23jHXSwRKjNpswUmPvQJS6l+HNq+L+YZ70Sh2Nsp4OLiPGyFsIIzrw+Bu+kFHVjEctrx6vAb4UKSfHN28ZWnZyrY7ODe1Lw7JSZqJ47lrMEp7cKshBkEfAFznSaEcMU7Vn0la2XSlsUccuzcTRL375g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=0+X0hdlg; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XRpz03Ln1zg0x;
	Mon, 14 Oct 2024 09:39:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728891580;
	bh=LI5PHQ4qVwieWJi0zgaZu9T5DqqBB/W0M4DOCvj8jsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0+X0hdlgJlXgMJtiAOITPn46f5lIuSOhhnBn2S0Tb4X4zEbDzPAlXeHEaNSQcZgYM
	 iq2fFvzQgCnWSWAbYs4suC7XyBSkpgiUEihe0E2nJEs5N2t5HjkfqWoOXQv/SXpkfg
	 TywKiuM3+jDssRwG1bFqaFSvyDR12s2dLpULg0ik=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XRpyt3jmBzLB1;
	Mon, 14 Oct 2024 09:39:34 +0200 (CEST)
Date: Mon, 14 Oct 2024 09:39:30 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <serge@hallyn.com>, Theodore Ts'o <tytso@mit.edu>, 
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
Subject: Re: [PATCH v20 1/6] exec: Add a new AT_CHECK flag to execveat(2)
Message-ID: <20241014.waet2se6Jeiw@digikod.net>
References: <20241011184422.977903-1-mic@digikod.net>
 <20241011184422.977903-2-mic@digikod.net>
 <CAOQ4uxi502PNn8eyKt9BExXVhbpx04f0XTeLg771i6wPOrLadA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxi502PNn8eyKt9BExXVhbpx04f0XTeLg771i6wPOrLadA@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Sun, Oct 13, 2024 at 11:25:11AM +0200, Amir Goldstein wrote:
> On Fri, Oct 11, 2024 at 8:45 PM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > Add a new AT_CHECK flag to execveat(2) to check if a file would be
> > allowed for execution.  The main use case is for script interpreters and
> > dynamic linkers to check execution permission according to the kernel's
> > security policy. Another use case is to add context to access logs e.g.,
> > which script (instead of interpreter) accessed a file.  As any
> > executable code, scripts could also use this check [1].
> >
> > This is different from faccessat(2) + X_OK which only checks a subset of
> > access rights (i.e. inode permission and mount options for regular
> > files), but not the full context (e.g. all LSM access checks).  The main
> > use case for access(2) is for SUID processes to (partially) check access
> > on behalf of their caller.  The main use case for execveat(2) + AT_CHECK
> > is to check if a script execution would be allowed, according to all the
> > different restrictions in place.  Because the use of AT_CHECK follows
> > the exact kernel semantic as for a real execution, user space gets the
> > same error codes.
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
> > Because AT_CHECK is dedicated to user space interpreters, it doesn't
> > make sense for the kernel to parse the checked files, look for
> > interpreters known to the kernel (e.g. ELF, shebang), and return ENOEXEC
> > if the format is unknown.  Because of that, security_bprm_check() is
> > never called when AT_CHECK is used.
> >
> > It should be noted that script interpreters cannot directly use
> > execveat(2) (without this new AT_CHECK flag) because this could lead to
> > unexpected behaviors e.g., `python script.sh` could lead to Bash being
> > executed to interpret the script.  Unlike the kernel, script
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
> > Cc: Serge Hallyn <serge@hallyn.com>
> > Link: https://docs.python.org/3/library/io.html#io.open_code [1]
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > Link: https://lore.kernel.org/r/20241011184422.977903-2-mic@digikod.net
> > ---
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
> >  fs/exec.c                  | 18 ++++++++++++++++--
> >  include/linux/binfmts.h    |  7 ++++++-
> >  include/uapi/linux/fcntl.h | 31 +++++++++++++++++++++++++++++++
> >  kernel/audit.h             |  1 +
> >  kernel/auditsc.c           |  1 +
> >  security/security.c        | 10 ++++++++++
> >  6 files changed, 65 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/exec.c b/fs/exec.c
> > index 6c53920795c2..163c659d9ae6 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -891,7 +891,7 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
> >                 .lookup_flags = LOOKUP_FOLLOW,
> >         };
> >
> > -       if ((flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
> > +       if ((flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH | AT_CHECK)) != 0)
> >                 return ERR_PTR(-EINVAL);
> >         if (flags & AT_SYMLINK_NOFOLLOW)
> >                 open_exec_flags.lookup_flags &= ~LOOKUP_FOLLOW;
> > @@ -1545,6 +1545,20 @@ static struct linux_binprm *alloc_bprm(int fd, struct filename *filename, int fl
> >         }
> >         bprm->interp = bprm->filename;
> >
> > +       /*
> > +        * At this point, security_file_open() has already been called (with
> > +        * __FMODE_EXEC) and access control checks for AT_CHECK will stop just
> > +        * after the security_bprm_creds_for_exec() call in bprm_execve().
> > +        * Indeed, the kernel should not try to parse the content of the file
> > +        * with exec_binprm() nor change the calling thread, which means that
> > +        * the following security functions will be not called:
> > +        * - security_bprm_check()
> > +        * - security_bprm_creds_from_file()
> > +        * - security_bprm_committing_creds()
> > +        * - security_bprm_committed_creds()
> > +        */
> > +       bprm->is_check = !!(flags & AT_CHECK);
> > +
> >         retval = bprm_mm_init(bprm);
> >         if (!retval)
> >                 return bprm;
> > @@ -1839,7 +1853,7 @@ static int bprm_execve(struct linux_binprm *bprm)
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
> > index 87e2dec79fea..e606815b1c5a 100644
> > --- a/include/uapi/linux/fcntl.h
> > +++ b/include/uapi/linux/fcntl.h
> > @@ -154,6 +154,37 @@
> >                                            usable with open_by_handle_at(2). */
> >  #define AT_HANDLE_MNT_ID_UNIQUE        0x001   /* Return the u64 unique mount ID. */
> >
> > +/*
> > + * AT_CHECK only performs a check on a regular file and returns 0 if execution
> > + * of this file would be allowed, ignoring the file format and then the related
> > + * interpreter dependencies (e.g. ELF libraries, script's shebang).
> > + *
> > + * Programs should always perform this check to apply kernel-level checks
> > + * against files that are not directly executed by the kernel but passed to a
> > + * user space interpreter instead.  All files that contain executable code,
> > + * from the point of view of the interpreter, should be checked.  However the
> > + * result of this check should only be enforced according to
> > + * SECBIT_EXEC_RESTRICT_FILE or SECBIT_EXEC_DENY_INTERACTIVE.  See securebits.h
> > + * documentation and the samples/check-exec/inc.c example.
> > + *
> > + * The main purpose of this flag is to improve the security and consistency of
> > + * an execution environment to ensure that direct file execution (e.g.
> > + * `./script.sh`) and indirect file execution (e.g. `sh script.sh`) lead to the
> > + * same result.  For instance, this can be used to check if a file is
> > + * trustworthy according to the caller's environment.
> > + *
> > + * In a secure environment, libraries and any executable dependencies should
> > + * also be checked.  For instance, dynamic linking should make sure that all
> > + * libraries are allowed for execution to avoid trivial bypass (e.g. using
> > + * LD_PRELOAD).  For such secure execution environment to make sense, only
> > + * trusted code should be executable, which also requires integrity guarantees.
> > + *
> > + * To avoid race conditions leading to time-of-check to time-of-use issues,
> > + * AT_CHECK should be used with AT_EMPTY_PATH to check against a file
> > + * descriptor instead of a path.
> > + */
> 
> If you ask me, the very elaborate comment above belongs to execveat(2)
> man page and is way too verbose for a uapi header.

OK, but since this new flags raised a lot of questions, I guess a
dedicated Documentation/userspace-api/check-exec.rst file with thit
AT*_CHECK and the related securebits would be useful instead of the
related inlined documentation.

> 
> > +#define AT_CHECK               0x10000
> 
> Please see the comment "Per-syscall flags for the *at(2) family of syscalls."
> above. If this is a per-syscall flag please use one of the per-syscall
> flags, e.g.:
> 
> /* Flags for execveat2(2) */
> #define AT_EXECVE_CHECK     0x0001   /* Only perform a check if
> execution would be allowed */

I missed this part, this prefix makes sense, thanks.

> 
> 
> Thanks,
> Amir.

