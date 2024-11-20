Return-Path: <linux-fsdevel+bounces-35338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2189D4005
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 17:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3906B395BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 16:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9B914601C;
	Wed, 20 Nov 2024 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aef5PZ35"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A1A1411DE
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 16:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732118782; cv=none; b=A5R3oxo18aSMN6mkKqh1egwedEQ16GkthTpN46Lx1z5XYnhg7L6Jjk6OGj3+0YklcqlONDZN4eH2HEqEnFLqHf9U6E7YPgHefd1I1K7iamuvicYLtQCkIWzuSM7WOC/wZBc5B2N375/6b/NQSGHYACQfQ1JIIvTY6G/16S7eDBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732118782; c=relaxed/simple;
	bh=z8vK4Qadnc+JLHpwO05RWHC49QG9bKA+PeouZyVH3WY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjcuAf6tJ8Vt5p3a3mzYisbJecvm2pQHxfCTc4+BU5g3sB5uqyqAoV1ssqGfD/axmOLjJvFjh0T058eVXXSo6nhpB2/5Er0kdZSzWyntFApIQ3TmMy4LoDa/q9BleOzXr01iU7InCPbCXoH9nZ/cIDmSTgn1WH4XzqcfctGv+2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aef5PZ35; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7180a16c130so490083a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 08:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732118779; x=1732723579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZoQhgMTbtoxG5e5YAFh1GHk/Gz9C4nwf6K19BOyDyk=;
        b=aef5PZ35x0L1yPB5TskKZhaj3jWr/4dFVGo4Nw7avFtnljqbCavmCLjZG+3IAUkCU1
         ZTVX3BRWHn8duM3x4pBAhyJOoG2yP57e07YbYlD22stHbOQuHsaT5r+FOI7eCykXQ0y5
         Fq7BnRYA1fJQU8CtbVyvGbVwY7DS1jWsHkLpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732118779; x=1732723579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZoQhgMTbtoxG5e5YAFh1GHk/Gz9C4nwf6K19BOyDyk=;
        b=mZGIhVvLOGpR4hQz7QqQTDvKcM96hxh6024Kp8ZVivP/x0bo2Zhr7WNhdega3DQoiD
         jx6jrqkM6gNsmFNm/pQzwDDuGt+yDiKMGaJCVS9CR6phULr/g6kywQgRZPs8uRece0Jr
         NBZZzqt7q2tKLbdel9pT9esG/+0WMwsJH4wM8AY0MtQSqbMWP1LWDNfykD8caPCoyyqo
         Js4Gx7qPJ2h/PmbYBjBu9MknaGnXopp5zdxEQxkqmlNBv+bVi0Wfn01MmhnrtkmxdePG
         XnQOZesXO/Cqvgv8RGWzRDIITSotqxrkESv1lltJaMiGoH1SYJQUGoG+fqpVn5M83VKN
         m9gA==
X-Forwarded-Encrypted: i=1; AJvYcCWCMiENUlumfkKiTGcWYiNslfI5efGzd0X95PO2t+GbpemL8cU6Z4FVm6MaBArj3U7kgtvRl4U7iGKy7YR7@vger.kernel.org
X-Gm-Message-State: AOJu0YzsjaoVHXDbQtei0tzsA6pMi761bVnr2c4CmBd2siL37m68XLZG
	lN31Fbx1vnAZHhPiC0Gp3eJNfuvBywpiDuhyelg3TTg6fElJwR+SP8djdDZFl4aGivHcvDUxakA
	4aHgXlTjyTUqUMflgf+ZcnAHm6rS4GYQdtx68
X-Gm-Gg: ASbGnctkSNQtQHmI431sg7zQDcjd2nEFLHcRmHjc7cWbYXQwAQLonhLMxqgiokJRH5/
	GxxyUYc7XjbFEk59lnaF2cFHV2wCVYmfGN4LZtozd02vsxi4WMzOaJRKcUhnx
X-Google-Smtp-Source: AGHT+IFyqLszhvQ+h29a1Auhie80JzMNSwcl4Xe8P/6XDOeRRL7FyHVGdd2HZB9sAOvkseaJWNwau7B8A2quiTR4jf4=
X-Received: by 2002:a05:6830:6813:b0:704:45ed:fa3 with SMTP id
 46e09a7af769-71ab30bd650mr834958a34.1.1732118779291; Wed, 20 Nov 2024
 08:06:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112191858.162021-1-mic@digikod.net> <20241112191858.162021-2-mic@digikod.net>
 <CABi2SkVRJC_7qoU56mDt3Ch7U9GnVeRogUt9wc9=32OtG6aatw@mail.gmail.com> <20241120.Uy8ahtai5oku@digikod.net>
In-Reply-To: <20241120.Uy8ahtai5oku@digikod.net>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 20 Nov 2024 08:06:07 -0800
Message-ID: <CABi2SkUx=7zummB4JCqEfb37p6MORR88y7S0E_YxJND_8dGaKA@mail.gmail.com>
Subject: Re: [PATCH v21 1/6] exec: Add a new AT_EXECVE_CHECK flag to execveat(2)
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <serge@hallyn.com>, Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, 
	Alejandro Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Casey Schaufler <casey@schaufler-ca.com>, 
	Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Elliott Hughes <enh@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Eric Chiang <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	James Morris <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>, 
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Luca Boccassi <bluca@debian.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Scott Shell <scottsh@microsoft.com>, 
	Shuah Khan <shuah@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, 
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>, Xiaoming Ni <nixiaoming@huawei.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, kernel-hardening@lists.openwall.com, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 1:42=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> On Tue, Nov 19, 2024 at 05:17:00PM -0800, Jeff Xu wrote:
> > On Tue, Nov 12, 2024 at 11:22=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@=
digikod.net> wrote:
> > >
> > > Add a new AT_EXECVE_CHECK flag to execveat(2) to check if a file woul=
d
> > > be allowed for execution.  The main use case is for script interprete=
rs
> > > and dynamic linkers to check execution permission according to the
> > > kernel's security policy. Another use case is to add context to acces=
s
> > > logs e.g., which script (instead of interpreter) accessed a file.  As
> > > any executable code, scripts could also use this check [1].
> > >
> > > This is different from faccessat(2) + X_OK which only checks a subset=
 of
> > > access rights (i.e. inode permission and mount options for regular
> > > files), but not the full context (e.g. all LSM access checks).  The m=
ain
> > > use case for access(2) is for SUID processes to (partially) check acc=
ess
> > > on behalf of their caller.  The main use case for execveat(2) +
> > > AT_EXECVE_CHECK is to check if a script execution would be allowed,
> > > according to all the different restrictions in place.  Because the us=
e
> > > of AT_EXECVE_CHECK follows the exact kernel semantic as for a real
> > > execution, user space gets the same error codes.
> > >
> > > An interesting point of using execveat(2) instead of openat2(2) is th=
at
> > > it decouples the check from the enforcement.  Indeed, the security ch=
eck
> > > can be logged (e.g. with audit) without blocking an execution
> > > environment not yet ready to enforce a strict security policy.
> > >
> > > LSMs can control or log execution requests with
> > > security_bprm_creds_for_exec().  However, to enforce a consistent and
> > > complete access control (e.g. on binary's dependencies) LSMs should
> > > restrict file executability, or mesure executed files, with
> > > security_file_open() by checking file->f_flags & __FMODE_EXEC.
> > >
> > > Because AT_EXECVE_CHECK is dedicated to user space interpreters, it
> > > doesn't make sense for the kernel to parse the checked files, look fo=
r
> > > interpreters known to the kernel (e.g. ELF, shebang), and return ENOE=
XEC
> > > if the format is unknown.  Because of that, security_bprm_check() is
> > > never called when AT_EXECVE_CHECK is used.
> > >
> > > It should be noted that script interpreters cannot directly use
> > > execveat(2) (without this new AT_EXECVE_CHECK flag) because this coul=
d
> > > lead to unexpected behaviors e.g., `python script.sh` could lead to B=
ash
> > > being executed to interpret the script.  Unlike the kernel, script
> > > interpreters may just interpret the shebang as a simple comment, whic=
h
> > > should not change for backward compatibility reasons.
> > >
> > > Because scripts or libraries files might not currently have the
> > > executable permission set, or because we might want specific users to=
 be
> > > allowed to run arbitrary scripts, the following patch provides a dyna=
mic
> > > configuration mechanism with the SECBIT_EXEC_RESTRICT_FILE and
> > > SECBIT_EXEC_DENY_INTERACTIVE securebits.
> > >
> > > This is a redesign of the CLIP OS 4's O_MAYEXEC:
> > > https://github.com/clipos-archive/src_platform_clip-patches/blob/f5cb=
330d6b684752e403b4e41b39f7004d88e561/1901_open_mayexec.patch
> > > This patch has been used for more than a decade with customized scrip=
t
> > > interpreters.  Some examples can be found here:
> > > https://github.com/clipos-archive/clipos4_portage-overlay/search?q=3D=
O_MAYEXEC
> > >
> > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Paul Moore <paul@paul-moore.com>
> > > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> > > Link: https://docs.python.org/3/library/io.html#io.open_code [1]
> > > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > > Link: https://lore.kernel.org/r/20241112191858.162021-2-mic@digikod.n=
et
> > > ---
> > >
> > > Changes since v20:
> > > * Rename AT_CHECK to AT_EXECVE_CHECK, requested by Amir Goldstein and
> > >   Serge Hallyn.
> > > * Move the UAPI documentation to a dedicated RST file.
> > > * Add Reviewed-by: Serge Hallyn
> > >
> > > Changes since v19:
> > > * Remove mention of "role transition" as suggested by Andy.
> > > * Highlight the difference between security_bprm_creds_for_exec() and
> > >   the __FMODE_EXEC check for LSMs (in commit message and LSM's hooks)=
 as
> > >   discussed with Jeff.
> > > * Improve documentation both in UAPI comments and kernel comments
> > >   (requested by Kees).
> > >
> > > New design since v18:
> > > https://lore.kernel.org/r/20220104155024.48023-3-mic@digikod.net
> > > ---
> > >  Documentation/userspace-api/check_exec.rst | 34 ++++++++++++++++++++=
++
> > >  Documentation/userspace-api/index.rst      |  1 +
> > >  fs/exec.c                                  | 20 +++++++++++--
> > >  include/linux/binfmts.h                    |  7 ++++-
> > >  include/uapi/linux/fcntl.h                 |  4 +++
> > >  kernel/audit.h                             |  1 +
> > >  kernel/auditsc.c                           |  1 +
> > >  security/security.c                        | 10 +++++++
> > >  8 files changed, 75 insertions(+), 3 deletions(-)
> > >  create mode 100644 Documentation/userspace-api/check_exec.rst
> > >
> > > diff --git a/Documentation/userspace-api/check_exec.rst b/Documentati=
on/userspace-api/check_exec.rst
> > > new file mode 100644
> > > index 000000000000..ad1aeaa5f6c0
> > > --- /dev/null
> > > +++ b/Documentation/userspace-api/check_exec.rst
> > > @@ -0,0 +1,34 @@
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +Executability check
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +AT_EXECVE_CHECK
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +Passing the ``AT_EXECVE_CHECK`` flag to :manpage:`execveat(2)` only =
performs a
> > > +check on a regular file and returns 0 if execution of this file woul=
d be
> > > +allowed, ignoring the file format and then the related interpreter d=
ependencies
> > > +(e.g. ELF libraries, script's shebang).
> > > +
> > > +Programs should always perform this check to apply kernel-level chec=
ks against
> > > +files that are not directly executed by the kernel but passed to a u=
ser space
> > > +interpreter instead.  All files that contain executable code, from t=
he point of
> > > +view of the interpreter, should be checked.  However the result of t=
his check
> > > +should only be enforced according to ``SECBIT_EXEC_RESTRICT_FILE`` o=
r
> > > +``SECBIT_EXEC_DENY_INTERACTIVE.``.
> > Regarding "should only"
> > Userspace (e.g. libc) could decide to enforce even when
> > SECBIT_EXEC_RESTRICT_FILE=3D0), i.e. if it determines not-enforcing
> > doesn't make sense.
>
> User space is always in control, but I don't think it would be wise to
> not follow the configuration securebits (in a generic system) because
> this could result to unattended behaviors (I don't have a specific one
> in mind but...).  That being said, configuration and checks are
> standalones and specific/tailored systems are free to do the checks they
> want.
>
In the case of dynamic linker, we can always enforce honoring the
execveat(AT_EXECVE_CHECK) result, right ? I can't think of a case not
to,  the dynamic linker doesn't need to check the
SECBIT_EXEC_RESTRICT_FILE bit.

script interpreters need to check this though,  because the apps might
need to adjust/test the scripts they are calling, so
SECBIT_EXEC_RESTRICT_FILE can be used to opt-out the enforcement.

> > When SECBIT_EXEC_RESTRICT_FILE=3D1,  userspace is bound to enforce.
> >
> > > +
> > > +The main purpose of this flag is to improve the security and consist=
ency of an
> > > +execution environment to ensure that direct file execution (e.g.
> > > +``./script.sh``) and indirect file execution (e.g. ``sh script.sh``)=
 lead to
> > > +the same result.  For instance, this can be used to check if a file =
is
> > > +trustworthy according to the caller's environment.
> > > +
> > > +In a secure environment, libraries and any executable dependencies s=
hould also
> > > +be checked.  For instance, dynamic linking should make sure that all=
 libraries
> > > +are allowed for execution to avoid trivial bypass (e.g. using ``LD_P=
RELOAD``).
> > > +For such secure execution environment to make sense, only trusted co=
de should
> > > +be executable, which also requires integrity guarantees.
> > > +
> > > +To avoid race conditions leading to time-of-check to time-of-use iss=
ues,
> > > +``AT_EXECVE_CHECK`` should be used with ``AT_EMPTY_PATH`` to check a=
gainst a
> > > +file descriptor instead of a path.
> > > diff --git a/Documentation/userspace-api/index.rst b/Documentation/us=
erspace-api/index.rst
> > > index 274cc7546efc..6272bcf11296 100644
> > > --- a/Documentation/userspace-api/index.rst
> > > +++ b/Documentation/userspace-api/index.rst
> > > @@ -35,6 +35,7 @@ Security-related interfaces
> > >     mfd_noexec
> > >     spec_ctrl
> > >     tee
> > > +   check_exec
> > >
> > >  Devices and I/O
> > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > diff --git a/fs/exec.c b/fs/exec.c
> > > index 6c53920795c2..bb83b6a39530 100644
> > > --- a/fs/exec.c
> > > +++ b/fs/exec.c
> > > @@ -891,7 +891,8 @@ static struct file *do_open_execat(int fd, struct=
 filename *name, int flags)
> > >                 .lookup_flags =3D LOOKUP_FOLLOW,
> > >         };
> > >
> > > -       if ((flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) !=3D 0)
> > > +       if ((flags &
> > > +            ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH | AT_EXECVE_CHECK)=
) !=3D 0)
> > >                 return ERR_PTR(-EINVAL);
> > >         if (flags & AT_SYMLINK_NOFOLLOW)
> > >                 open_exec_flags.lookup_flags &=3D ~LOOKUP_FOLLOW;
> > > @@ -1545,6 +1546,21 @@ static struct linux_binprm *alloc_bprm(int fd,=
 struct filename *filename, int fl
> > >         }
> > >         bprm->interp =3D bprm->filename;
> > >
> > > +       /*
> > > +        * At this point, security_file_open() has already been calle=
d (with
> > > +        * __FMODE_EXEC) and access control checks for AT_EXECVE_CHEC=
K will
> > > +        * stop just after the security_bprm_creds_for_exec() call in
> > > +        * bprm_execve().  Indeed, the kernel should not try to parse=
 the
> > > +        * content of the file with exec_binprm() nor change the call=
ing
> > > +        * thread, which means that the following security functions =
will be
> > > +        * not called:
> > > +        * - security_bprm_check()
> > > +        * - security_bprm_creds_from_file()
> > > +        * - security_bprm_committing_creds()
> > > +        * - security_bprm_committed_creds()
> > > +        */
> > > +       bprm->is_check =3D !!(flags & AT_EXECVE_CHECK);
> > > +
> > >         retval =3D bprm_mm_init(bprm);
> > >         if (!retval)
> > >                 return bprm;
> > > @@ -1839,7 +1855,7 @@ static int bprm_execve(struct linux_binprm *bpr=
m)
> > >
> > >         /* Set the unchanging part of bprm->cred */
> > >         retval =3D security_bprm_creds_for_exec(bprm);
> > > -       if (retval)
> > > +       if (retval || bprm->is_check)
> > >                 goto out;
> > >
> > >         retval =3D exec_binprm(bprm);
> > > diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> > > index e6c00e860951..8ff0eb3644a1 100644
> > > --- a/include/linux/binfmts.h
> > > +++ b/include/linux/binfmts.h
> > > @@ -42,7 +42,12 @@ struct linux_binprm {
> > >                  * Set when errors can no longer be returned to the
> > >                  * original userspace.
> > >                  */
> > > -               point_of_no_return:1;
> > > +               point_of_no_return:1,
> > > +               /*
> > > +                * Set by user space to check executability according=
 to the
> > > +                * caller's environment.
> > > +                */
> > > +               is_check:1;
> > >         struct file *executable; /* Executable to pass to the interpr=
eter */
> > >         struct file *interpreter;
> > >         struct file *file;
> > > diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> > > index 87e2dec79fea..2e87f2e3a79f 100644
> > > --- a/include/uapi/linux/fcntl.h
> > > +++ b/include/uapi/linux/fcntl.h
> > > @@ -154,6 +154,10 @@
> > >                                            usable with open_by_handle=
_at(2). */
> > >  #define AT_HANDLE_MNT_ID_UNIQUE        0x001   /* Return the u64 uni=
que mount ID. */
> > >
> > > +/* Flags for execveat2(2). */
> > > +#define AT_EXECVE_CHECK                0x10000 /* Only perform a che=
ck if execution
> > > +                                          would be allowed. */
> > > +
> > >  #if defined(__KERNEL__)
> > >  #define AT_GETATTR_NOSEC       0x80000000
> > >  #endif
> > > diff --git a/kernel/audit.h b/kernel/audit.h
> > > index a60d2840559e..8ebdabd2ab81 100644
> > > --- a/kernel/audit.h
> > > +++ b/kernel/audit.h
> > > @@ -197,6 +197,7 @@ struct audit_context {
> > >                 struct open_how openat2;
> > >                 struct {
> > >                         int                     argc;
> > > +                       bool                    is_check;
> > >                 } execve;
> > >                 struct {
> > >                         char                    *name;
> > > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > > index cd57053b4a69..8d9ba5600cf2 100644
> > > --- a/kernel/auditsc.c
> > > +++ b/kernel/auditsc.c
> > > @@ -2662,6 +2662,7 @@ void __audit_bprm(struct linux_binprm *bprm)
> > >
> > >         context->type =3D AUDIT_EXECVE;
> > >         context->execve.argc =3D bprm->argc;
> > > +       context->execve.is_check =3D bprm->is_check;
> > Where is execve.is_check used ?
>
> It is used in bprm_execve(), exposed to the audit framework, and
> potentially used by LSMs.
>
bprm_execve() uses bprm->is_check, not  the context->execve.is_check.


> >
> >
> > >  }
> > >
> > >
> > > diff --git a/security/security.c b/security/security.c
> > > index c5981e558bc2..456361ec249d 100644
> > > --- a/security/security.c
> > > +++ b/security/security.c
> > > @@ -1249,6 +1249,12 @@ int security_vm_enough_memory_mm(struct mm_str=
uct *mm, long pages)
> > >   * to 1 if AT_SECURE should be set to request libc enable secure mod=
e.  @bprm
> > >   * contains the linux_binprm structure.
> > >   *
> > > + * If execveat(2) is called with the AT_EXECVE_CHECK flag, bprm->is_=
check is
> > > + * set.  The result must be the same as without this flag even if th=
e execution
> > > + * will never really happen and @bprm will always be dropped.
> > > + *
> > > + * This hook must not change current->cred, only @bprm->cred.
> > > + *
> > >   * Return: Returns 0 if the hook is successful and permission is gra=
nted.
> > >   */
> > >  int security_bprm_creds_for_exec(struct linux_binprm *bprm)
> > > @@ -3100,6 +3106,10 @@ int security_file_receive(struct file *file)
> > >   * Save open-time permission checking state for later use upon file_=
permission,
> > >   * and recheck access if anything has changed since inode_permission=
.
> > >   *
> > > + * We can check if a file is opened for execution (e.g. execve(2) ca=
ll), either
> > > + * directly or indirectly (e.g. ELF's ld.so) by checking file->f_fla=
gs &
> > > + * __FMODE_EXEC .
> > > + *
> > >   * Return: Returns 0 if permission is granted.
> > >   */
> > >  int security_file_open(struct file *file)
> > > --
> > > 2.47.0
> > >
> > >

