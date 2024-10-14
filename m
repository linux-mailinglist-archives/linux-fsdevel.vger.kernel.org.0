Return-Path: <linux-fsdevel+bounces-31858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC67699C31A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 10:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1DAD284622
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 08:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AB5155757;
	Mon, 14 Oct 2024 08:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBHAjEAN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B4715535A;
	Mon, 14 Oct 2024 08:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894257; cv=none; b=jke02GhL3f0J3rMRGeHfOviDpHmIk22AJ5eekxi0ti8kHfWSVLT0U7c2OHKQGzo7lIPHDPySuX8cuH4ksDCzczRbttdFjHqc+aRDI9yDAaxO5nyTOtnfZ7GbVA1d+sTClmWcOhUqv6PzFCT4DLEOLTS09Fry9HW34egSkEQpHps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894257; c=relaxed/simple;
	bh=ZpTpCMLS1t0Xe/dtWrFlh4/vrQtyUIXH8VhzqXs7QX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TlVIDMsn4SVEf75gWLE1TIGEdCAHvoHrOCYVptq6o+s4WWhT6eUzhlK0IU92evrCVe5LsThPsdsqYG6hyfXZmgzComOa2M3IBd72RSnIlVqEbGyrUjyfPkF4wGlEllBnfA+Lq68vdEsWM7erx5GE7JDwNZ9wfVh9gvm06UDZePw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBHAjEAN; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-84f1ac129c7so1052813241.1;
        Mon, 14 Oct 2024 01:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728894254; x=1729499054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3h2PE7vwOhhQtkKSXOUfxYJYudoNEBV4oSe5DndjYQ=;
        b=NBHAjEANaa6eZWTwQtYdW/AQe12cRCYfrNECKlU4Fl9QT5TvQQG2ofZtXvW4Hpt9kJ
         e7T4Tak6iJAkgvbMJGuSpm5hNtQDpl3nhPrRkKhsNh3rRqcnOkVYeq6BpDgtYaw567SJ
         fGLwkT/8+a9RwbLGWXkxA+5wYS7D0ztwBbS9FWvKx3DZO8qnr9n/YVHkia4fzqNWrgxg
         nAnr/qfLzKbjBsopKtuYDmcrfBmBmVolEEj4b6sO5C09BGb/dGUV5ugtBhtur7XE7EUv
         q4p2673eWOlaqPhkCsXEsvAqOJHU136Qbotyindmz5k8bs0KQH5LfQph9Pvn+BONZVir
         qgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728894254; x=1729499054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3h2PE7vwOhhQtkKSXOUfxYJYudoNEBV4oSe5DndjYQ=;
        b=exch0YR/SLscPyQ2Bl4tsqSBeuoCObi9GXml1ltTHGRaXu46g2H2pO9cREclFhza6B
         nJxxV7JJwaKdxrIFTRidyt2V1t8aJwi65rdLVmWKbpAW64jK4eVi8/hiLvK6rv+ISuY7
         Fq5DkCwwhZ5+pVCEZW+mVFH2/iXrTWHBIQXBFKwp5dVFCzevAX3M9AaP2UzUyHRyvCSm
         7kurwT4bf5gUWqLpSzS0/p0diTOHrW54nFikOoRj42WmQ7Cuc0WExcX/CSX8kyqw1kip
         68bsLdKNVPpX5vLcMcyR7/JYpiq2ObMvR/qwl5tNBle1M7DqVr1CE5WV3R/mWVhaUrmf
         wO+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6rdfE8IWsACml4H1VFs6HNBJi4CBuolZRgYedPC7Q9X/FznSgYN3VHQ0fVnQnytNrPllKIbUhghKbltOfAZiGsRTg2+7b@vger.kernel.org, AJvYcCVQiQamV6i7RaHrWFeXhIs4IrhA3FX2XVB7fEmA39ZRQpcJ2DTzW7GPC1bs1ePN0ndvPYBS/CUgAVA=@vger.kernel.org, AJvYcCWKxJfSHPIuyf6eQW/HKEAXXfKXdU5DgsHSruwxwoNew3EFBRF928F10evlAooiBewpABfHY9IgpalDbL0I@vger.kernel.org, AJvYcCWaIbmIA2KmFgWBA0CGTId5qP1rZV4VlYb3xk9vqcjoHKyC6uzGUVNTbDA8oaSfpb8Rnh7NsUL+hivEIP2dlw==@vger.kernel.org, AJvYcCWdN+55+EQDDsQ8E9YuoJKWge589lf0B/nwLDvjC+8W4JRWbCuItNt8Wa/ENe0pWYjgNfDJ33IysTYIFe2wXfUD@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxnwd+Pw1yDxay7ptB38LRMZpFQWjAUCAng8bdFj0BhS8PcXCU
	ZHdlD8JpU9KL1WtIEh3ZHVvULYHMG8IDCmmG075uEi9ePc0kvGRVhDy1e7JVWhFEACQK4blU2p1
	T9n+8TFHy+NW3fxOcWbcf8RpuL5A=
X-Google-Smtp-Source: AGHT+IFENCyRieMBccdaVEVaZX7EEFceoq8zbv+3ZefOKTVeVjrNi6O/1gqc4m/ojVzNp7gq0BDNcUAqEDjbuprQhQY=
X-Received: by 2002:a05:6102:a4a:b0:4a4:8f4f:136e with SMTP id
 ada2fe7eead31-4a48f4f16a1mr675367137.15.1728894253974; Mon, 14 Oct 2024
 01:24:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011184422.977903-1-mic@digikod.net> <20241011184422.977903-2-mic@digikod.net>
 <CAOQ4uxi502PNn8eyKt9BExXVhbpx04f0XTeLg771i6wPOrLadA@mail.gmail.com> <20241014.waet2se6Jeiw@digikod.net>
In-Reply-To: <20241014.waet2se6Jeiw@digikod.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 14 Oct 2024 10:24:02 +0200
Message-ID: <CAOQ4uxjGEo9qwAjdYKeojuKiraUh8=qW6-qZCiv08+8OiDRj7g@mail.gmail.com>
Subject: Re: [PATCH v20 1/6] exec: Add a new AT_CHECK flag to execveat(2)
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <serge@hallyn.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, Alejandro Colomar <alx@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Elliott Hughes <enh@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Eric Chiang <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	James Morris <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>, 
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Scott Shell <scottsh@microsoft.com>, 
	Shuah Khan <shuah@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, 
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>, Xiaoming Ni <nixiaoming@huawei.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, kernel-hardening@lists.openwall.com, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 9:39=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> On Sun, Oct 13, 2024 at 11:25:11AM +0200, Amir Goldstein wrote:
> > On Fri, Oct 11, 2024 at 8:45=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > >
> > > Add a new AT_CHECK flag to execveat(2) to check if a file would be
> > > allowed for execution.  The main use case is for script interpreters =
and
> > > dynamic linkers to check execution permission according to the kernel=
's
> > > security policy. Another use case is to add context to access logs e.=
g.,
> > > which script (instead of interpreter) accessed a file.  As any
> > > executable code, scripts could also use this check [1].
> > >
> > > This is different from faccessat(2) + X_OK which only checks a subset=
 of
> > > access rights (i.e. inode permission and mount options for regular
> > > files), but not the full context (e.g. all LSM access checks).  The m=
ain
> > > use case for access(2) is for SUID processes to (partially) check acc=
ess
> > > on behalf of their caller.  The main use case for execveat(2) + AT_CH=
ECK
> > > is to check if a script execution would be allowed, according to all =
the
> > > different restrictions in place.  Because the use of AT_CHECK follows
> > > the exact kernel semantic as for a real execution, user space gets th=
e
> > > same error codes.
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
> > > Because AT_CHECK is dedicated to user space interpreters, it doesn't
> > > make sense for the kernel to parse the checked files, look for
> > > interpreters known to the kernel (e.g. ELF, shebang), and return ENOE=
XEC
> > > if the format is unknown.  Because of that, security_bprm_check() is
> > > never called when AT_CHECK is used.
> > >
> > > It should be noted that script interpreters cannot directly use
> > > execveat(2) (without this new AT_CHECK flag) because this could lead =
to
> > > unexpected behaviors e.g., `python script.sh` could lead to Bash bein=
g
> > > executed to interpret the script.  Unlike the kernel, script
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
> > > Cc: Serge Hallyn <serge@hallyn.com>
> > > Link: https://docs.python.org/3/library/io.html#io.open_code [1]
> > > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > > Link: https://lore.kernel.org/r/20241011184422.977903-2-mic@digikod.n=
et
> > > ---
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
> > >  fs/exec.c                  | 18 ++++++++++++++++--
> > >  include/linux/binfmts.h    |  7 ++++++-
> > >  include/uapi/linux/fcntl.h | 31 +++++++++++++++++++++++++++++++
> > >  kernel/audit.h             |  1 +
> > >  kernel/auditsc.c           |  1 +
> > >  security/security.c        | 10 ++++++++++
> > >  6 files changed, 65 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/fs/exec.c b/fs/exec.c
> > > index 6c53920795c2..163c659d9ae6 100644
> > > --- a/fs/exec.c
> > > +++ b/fs/exec.c
> > > @@ -891,7 +891,7 @@ static struct file *do_open_execat(int fd, struct=
 filename *name, int flags)
> > >                 .lookup_flags =3D LOOKUP_FOLLOW,
> > >         };
> > >
> > > -       if ((flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) !=3D 0)
> > > +       if ((flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH | AT_CHECK=
)) !=3D 0)
> > >                 return ERR_PTR(-EINVAL);
> > >         if (flags & AT_SYMLINK_NOFOLLOW)
> > >                 open_exec_flags.lookup_flags &=3D ~LOOKUP_FOLLOW;
> > > @@ -1545,6 +1545,20 @@ static struct linux_binprm *alloc_bprm(int fd,=
 struct filename *filename, int fl
> > >         }
> > >         bprm->interp =3D bprm->filename;
> > >
> > > +       /*
> > > +        * At this point, security_file_open() has already been calle=
d (with
> > > +        * __FMODE_EXEC) and access control checks for AT_CHECK will =
stop just
> > > +        * after the security_bprm_creds_for_exec() call in bprm_exec=
ve().
> > > +        * Indeed, the kernel should not try to parse the content of =
the file
> > > +        * with exec_binprm() nor change the calling thread, which me=
ans that
> > > +        * the following security functions will be not called:
> > > +        * - security_bprm_check()
> > > +        * - security_bprm_creds_from_file()
> > > +        * - security_bprm_committing_creds()
> > > +        * - security_bprm_committed_creds()
> > > +        */
> > > +       bprm->is_check =3D !!(flags & AT_CHECK);
> > > +
> > >         retval =3D bprm_mm_init(bprm);
> > >         if (!retval)
> > >                 return bprm;
> > > @@ -1839,7 +1853,7 @@ static int bprm_execve(struct linux_binprm *bpr=
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
> > > index 87e2dec79fea..e606815b1c5a 100644
> > > --- a/include/uapi/linux/fcntl.h
> > > +++ b/include/uapi/linux/fcntl.h
> > > @@ -154,6 +154,37 @@
> > >                                            usable with open_by_handle=
_at(2). */
> > >  #define AT_HANDLE_MNT_ID_UNIQUE        0x001   /* Return the u64 uni=
que mount ID. */
> > >
> > > +/*
> > > + * AT_CHECK only performs a check on a regular file and returns 0 if=
 execution
> > > + * of this file would be allowed, ignoring the file format and then =
the related
> > > + * interpreter dependencies (e.g. ELF libraries, script's shebang).
> > > + *
> > > + * Programs should always perform this check to apply kernel-level c=
hecks
> > > + * against files that are not directly executed by the kernel but pa=
ssed to a
> > > + * user space interpreter instead.  All files that contain executabl=
e code,
> > > + * from the point of view of the interpreter, should be checked.  Ho=
wever the
> > > + * result of this check should only be enforced according to
> > > + * SECBIT_EXEC_RESTRICT_FILE or SECBIT_EXEC_DENY_INTERACTIVE.  See s=
ecurebits.h
> > > + * documentation and the samples/check-exec/inc.c example.
> > > + *
> > > + * The main purpose of this flag is to improve the security and cons=
istency of
> > > + * an execution environment to ensure that direct file execution (e.=
g.
> > > + * `./script.sh`) and indirect file execution (e.g. `sh script.sh`) =
lead to the
> > > + * same result.  For instance, this can be used to check if a file i=
s
> > > + * trustworthy according to the caller's environment.
> > > + *
> > > + * In a secure environment, libraries and any executable dependencie=
s should
> > > + * also be checked.  For instance, dynamic linking should make sure =
that all
> > > + * libraries are allowed for execution to avoid trivial bypass (e.g.=
 using
> > > + * LD_PRELOAD).  For such secure execution environment to make sense=
, only
> > > + * trusted code should be executable, which also requires integrity =
guarantees.
> > > + *
> > > + * To avoid race conditions leading to time-of-check to time-of-use =
issues,
> > > + * AT_CHECK should be used with AT_EMPTY_PATH to check against a fil=
e
> > > + * descriptor instead of a path.
> > > + */
> >
> > If you ask me, the very elaborate comment above belongs to execveat(2)
> > man page and is way too verbose for a uapi header.
>
> OK, but since this new flags raised a lot of questions, I guess a
> dedicated Documentation/userspace-api/check-exec.rst file with thit
> AT*_CHECK and the related securebits would be useful instead of the
> related inlined documentation.
>
> >
> > > +#define AT_CHECK               0x10000
> >
> > Please see the comment "Per-syscall flags for the *at(2) family of sysc=
alls."
> > above. If this is a per-syscall flag please use one of the per-syscall
> > flags, e.g.:
> >
> > /* Flags for execveat2(2) */
> > #define AT_EXECVE_CHECK     0x0001   /* Only perform a check if
> > execution would be allowed */
>
> I missed this part, this prefix makes sense, thanks.
>

Not only the prefix, also the overloaded value.

Thanks,
Amir.

