Return-Path: <linux-fsdevel+bounces-23800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F92D93372D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 08:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB011F22792
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 06:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119AE17545;
	Wed, 17 Jul 2024 06:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="icW7o23Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BB015E81
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 06:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721198078; cv=none; b=X7utGBqEb59PpOmw+mSx70wsjyS78nkK2c0ZBcRPMQs8mUGbMGa2UEZZIzdIWdlhJXb7+jxF9Gzk3z2ccp+zynzDHLBwJd3EtP4UZ1PvXcB9okexS84MRVZoVgPGwlEOTI2aulYnxbXA4VnpSQgf4BWa6q/DOx/Qd8D/MD7JxDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721198078; c=relaxed/simple;
	bh=ZzRqnXG/WymFGcHQ28vvNVgpLtd5zSuwSo7JLsh90Ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pyxN7KxqztwuqwCwYZ2vCQAWMFV/n1KZ7ykR5jTXZOuJrGc29sIeI54gB5Xrij1qwMZ/tNGMoFPWFB3H20mwgNBZZHi8mpdNF5kL2CvCbweYKzxAsRxnNDZ/YrruG7dxOdvCLumz23DuJ3e4ykFRB9LzPH6nC/cHeTz4mhXnXUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=icW7o23Z; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-58c0abd6b35so10831a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jul 2024 23:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721198075; x=1721802875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53iyz8JF6uRIbfZMKSJA71iqZou/dHPJqNT+l8ZIpu8=;
        b=icW7o23ZnbM6w2HLagbsR0m92WRVAq3x7NXlcm5IGTiOeo5mjd3DLpVYZfvJKvur8g
         099HoNUzR4l1FIZ7hm7VC9B2OBWSvht371lbiBjw6iklFqZbTY7YQiARQnTDshHzlmRB
         4pPr9StZd/lckZAzKDedoMKoB30khfn2S1QDq+pJCHL0cCeeOLMExSNe5Rbtq2dBe4Bs
         Y2uAn9Cy5elQWH3SrBZX11z7TI6vbJO/lWRX2UAM3Yk1tuexC1bbUrBDV/OReamei/87
         2TUoyqJdEjhL1eBBHO85nERIKTb762vCLSr13L9QuMITARW65ZX9bZeHBkItxRsgLXai
         9msg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721198075; x=1721802875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53iyz8JF6uRIbfZMKSJA71iqZou/dHPJqNT+l8ZIpu8=;
        b=xUIi1+GZZWz6zN0C8qTQkf93fnoZej9WmhF2YnVaKmd4BCWYnoaRK6Pg0vG0LFzUPP
         UkBZgylcgArTzur6NYDsS1bGx+R+b5OlnnizYVtquDHzqcVCdUGEpjU/0lkhyQ0iNJyz
         qfQeb8471hS5QOdXsI+oxbqUDm0pxX1YpIkbiQPBR2y2dk9eo62uxDYAWfCSYbErAfqH
         8de1kxrFmbpntsMsrV6MrxFVvohBylslA1JJvn8S+FBAAty3ee8gv2+aCdGuKTuzkDM5
         itnb/WcR9Uogja3aH+4xLMlcckEdiLWxW2Cj16/wMAMjGmcBizofA6CUBNZwr8Il6Kpf
         ZCFg==
X-Forwarded-Encrypted: i=1; AJvYcCViK2CgpdgUpaFdBJZz/U9Zd+oWwHKHqsXcYOiVZ75UorkbGsKuTe77BO3e6KX+FJm6UiWVfFQ1z0tt3m4yS15+h+E9whLAB4lHQ9QydA==
X-Gm-Message-State: AOJu0Yxh0+FgDhaUjki92aucseOrBR+Jcjw9WEcmZzCxDyVJ1pHjo53Q
	Y1b1FwG2fHXQ06il9Nq81jQgHLhR5E3B6M26fok7Vc4n01BVURMYgo076odCAbkUcYGSGBIwAvf
	Oiyfyo/7MZ4JVJkvB8qHlL38THsfI7CC01lcN
X-Google-Smtp-Source: AGHT+IEcQ87b2S98giZRUUEjfFRjwWGAXq1R+jlPbWJt+wEQ7hF7bnbsQBGW927UFsWh0HyFwsGHVuNdH0qfDvnYI6Y=
X-Received: by 2002:a50:9b54:0:b0:59f:9f59:9b07 with SMTP id
 4fb4d7f45d1cf-5a01aa1de7bmr158260a12.4.1721198074196; Tue, 16 Jul 2024
 23:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704190137.696169-1-mic@digikod.net> <20240704190137.696169-2-mic@digikod.net>
In-Reply-To: <20240704190137.696169-2-mic@digikod.net>
From: Jeff Xu <jeffxu@google.com>
Date: Tue, 16 Jul 2024 23:33:55 -0700
Message-ID: <CALmYWFss7qcpR9D_r3pbP_Orxs55t3y3yXJsac1Wz=Hk9Di0Nw@mail.gmail.com>
Subject: Re: [RFC PATCH v19 1/5] exec: Add a new AT_CHECK flag to execveat(2)
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Paul Moore <paul@paul-moore.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Alejandro Colomar <alx.manpages@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Casey Schaufler <casey@schaufler-ca.com>, 
	Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Eric Biggers <ebiggers@kernel.org>, Eric Chiang <ericchiang@google.com>, 
	Fan Wu <wufan@linux.microsoft.com>, Florian Weimer <fweimer@redhat.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, James Morris <jamorris@linux.microsoft.com>, 
	Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
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

On Thu, Jul 4, 2024 at 12:02=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> Add a new AT_CHECK flag to execveat(2) to check if a file would be
> allowed for execution.  The main use case is for script interpreters and
> dynamic linkers to check execution permission according to the kernel's
> security policy. Another use case is to add context to access logs e.g.,
> which script (instead of interpreter) accessed a file.  As any
> executable code, scripts could also use this check [1].
>
> This is different than faccessat(2) which only checks file access
> rights, but not the full context e.g. mount point's noexec, stack limit,
> and all potential LSM extra checks (e.g. argv, envp, credentials).
> Since the use of AT_CHECK follows the exact kernel semantic as for a
> real execution, user space gets the same error codes.
>
So we concluded that execveat(AT_CHECK) will be used to check the
exec, shared object, script and config file (such as seccomp config),
I'm still thinking  execveat(AT_CHECK) vs faccessat(AT_CHECK) in
different use cases:

execveat clearly has less code change, but that also means: we can't
add logic specific to exec (i.e. logic that can't be applied to
config) for this part (from do_execveat_common to
security_bprm_creds_for_exec) in future.  This would require some
agreement/sign-off, I'm not sure from whom.

--------------------------
now looked at user cases (focus on elf for now)

1> ld.so /tmp/a.out, /tmp/a.out is on non-exec mount
dynamic linker will first call execveat(fd, AT_CHECK) then execveat(fd)

2> execve(/usr/bin/some.out) and some.out has dependency on /tmp/a.so
/usr/bin/some.out will pass AT_CHECK

3> execve(usr/bin/some.out) and some.out uses custom /tmp/ld.so
/usr/bin/some.out will pass AT_CHECK, however, it uses a custom
/tmp/ld.so (I assume this is possible  for elf header will set the
path for ld.so because kernel has no knowledge of that, and
binfmt_elf.c allocate memory for ld.so during execveat call)

4> dlopen(/tmp/a.so)
I assume dynamic linker will call execveat(AT_CHECK), before map a.so
into memory.

For case 1>
Alternative solution: Because AT_CHECK is always called, I think we
can avoid the first AT_CHECK call, and check during execveat(fd),
this means the kernel will enforce SECBIT_EXEC_RESTRICT_FILE =3D 1, the
benefit is that there is no TOCTOU and save one round trip of syscall
for a succesful execveat() case.

For case 2>
dynamic linker will call execve(AT_CHECK), then mmap(fd) into memory.
However,  the process can all open then mmap() directly, it seems
minimal effort for an attacker to walk around such a defence from
dynamic linker.

Alternative solution:
dynamic linker call AT_CHECK for each .so, kernel will save the state
(associated with fd)
kernel will check fd state at the time of mmap(fd, executable memory)
and enforce SECBIT_EXEC_RESTRICT_FILE =3D 1

Alternative solution 2:
a new syscall to load the .so and enforce the AT_CHECK in kernel

This also means, for the solution to be complete, we might want to
block creation of executable anonymous memory (e.g. by seccomp, ),
unless the user space can harden the creation of  executable anonymous
memory in some way.

For case 3>
I think binfmt_elf.c in the kernel needs to check the ld.so to make
sure it passes AT_CHECK, before loading it into memory.

For case 4>
same as case 2.

Consider those cases: I think:
a> relying purely on userspace for enforcement does't seem to be
effective,  e.g. it is trivial  to call open(), then mmap() it into
executable memory.
b> if both user space and kernel need to call AT_CHECK, the faccessat
seems to be a better place for AT_CHECK, e.g. kernel can call
do_faccessat(AT_CHECK) and userspace can call faccessat(). This will
avoid complicating the execveat() code path.

What do you think ?

Thanks
-Jeff

> With the information that a script interpreter is about to interpret a
> script, an LSM security policy can adjust caller's access rights or log
> execution request as for native script execution (e.g. role transition).
> This is possible thanks to the call to security_bprm_creds_for_exec().
>
> Because LSMs may only change bprm's credentials, use of AT_CHECK with
> current kernel code should not be a security issue (e.g. unexpected role
> transition).  LSMs willing to update the caller's credential could now
> do so when bprm->is_check is set.  Of course, such policy change should
> be in line with the new user space code.
>
> Because AT_CHECK is dedicated to user space interpreters, it doesn't
> make sense for the kernel to parse the checked files, look for
> interpreters known to the kernel (e.g. ELF, shebang), and return ENOEXEC
> if the format is unknown.  Because of that, security_bprm_check() is
> never called when AT_CHECK is used.
>
> It should be noted that script interpreters cannot directly use
> execveat(2) (without this new AT_CHECK flag) because this could lead to
> unexpected behaviors e.g., `python script.sh` could lead to Bash being
> executed to interpret the script.  Unlike the kernel, script
> interpreters may just interpret the shebang as a simple comment, which
> should not change for backward compatibility reasons.
>
> Because scripts or libraries files might not currently have the
> executable permission set, or because we might want specific users to be
> allowed to run arbitrary scripts, the following patch provides a dynamic
> configuration mechanism with the SECBIT_SHOULD_EXEC_CHECK and
> SECBIT_SHOULD_EXEC_RESTRICT securebits.
>
> This is a redesign of the CLIP OS 4's O_MAYEXEC:
> https://github.com/clipos-archive/src_platform_clip-patches/blob/f5cb330d=
6b684752e403b4e41b39f7004d88e561/1901_open_mayexec.patch
> This patch has been used for more than a decade with customized script
> interpreters.  Some examples can be found here:
> https://github.com/clipos-archive/clipos4_portage-overlay/search?q=3DO_MA=
YEXEC
>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Paul Moore <paul@paul-moore.com>
> Link: https://docs.python.org/3/library/io.html#io.open_code [1]
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20240704190137.696169-2-mic@digikod.net
> ---
>
> New design since v18:
> https://lore.kernel.org/r/20220104155024.48023-3-mic@digikod.net
> ---
>  fs/exec.c                  |  5 +++--
>  include/linux/binfmts.h    |  7 ++++++-
>  include/uapi/linux/fcntl.h | 30 ++++++++++++++++++++++++++++++
>  kernel/audit.h             |  1 +
>  kernel/auditsc.c           |  1 +
>  5 files changed, 41 insertions(+), 3 deletions(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index 40073142288f..ea2a1867afdc 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -931,7 +931,7 @@ static struct file *do_open_execat(int fd, struct fil=
ename *name, int flags)
>                 .lookup_flags =3D LOOKUP_FOLLOW,
>         };
>
> -       if ((flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) !=3D 0)
> +       if ((flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH | AT_CHECK)) !=
=3D 0)
>                 return ERR_PTR(-EINVAL);
>         if (flags & AT_SYMLINK_NOFOLLOW)
>                 open_exec_flags.lookup_flags &=3D ~LOOKUP_FOLLOW;
> @@ -1595,6 +1595,7 @@ static struct linux_binprm *alloc_bprm(int fd, stru=
ct filename *filename, int fl
>                 bprm->filename =3D bprm->fdpath;
>         }
>         bprm->interp =3D bprm->filename;
> +       bprm->is_check =3D !!(flags & AT_CHECK);
>
>         retval =3D bprm_mm_init(bprm);
>         if (!retval)
> @@ -1885,7 +1886,7 @@ static int bprm_execve(struct linux_binprm *bprm)
>
>         /* Set the unchanging part of bprm->cred */
>         retval =3D security_bprm_creds_for_exec(bprm);
> -       if (retval)
> +       if (retval || bprm->is_check)
>                 goto out;
>
>         retval =3D exec_binprm(bprm);
> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> index 70f97f685bff..8ff9c9e33aed 100644
> --- a/include/linux/binfmts.h
> +++ b/include/linux/binfmts.h
> @@ -42,7 +42,12 @@ struct linux_binprm {
>                  * Set when errors can no longer be returned to the
>                  * original userspace.
>                  */
> -               point_of_no_return:1;
> +               point_of_no_return:1,
> +               /*
> +                * Set by user space to check executability according to =
the
> +                * caller's environment.
> +                */
> +               is_check:1;
>         struct file *executable; /* Executable to pass to the interpreter=
 */
>         struct file *interpreter;
>         struct file *file;
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index c0bcc185fa48..bcd05c59b7df 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -118,6 +118,36 @@
>  #define AT_HANDLE_FID          AT_REMOVEDIR    /* file handle is needed =
to
>                                         compare object identity and may n=
ot
>                                         be usable to open_by_handle_at(2)=
 */
> +
> +/*
> + * AT_CHECK only performs a check on a regular file and returns 0 if exe=
cution
> + * of this file would be allowed, ignoring the file format and then the =
related
> + * interpreter dependencies (e.g. ELF libraries, script's shebang).  AT_=
CHECK
> + * should only be used if SECBIT_SHOULD_EXEC_CHECK is set for the callin=
g
> + * thread.  See securebits.h documentation.
> + *
> + * Programs should use this check to apply kernel-level checks against f=
iles
> + * that are not directly executed by the kernel but directly passed to a=
 user
> + * space interpreter instead.  All files that contain executable code, f=
rom the
> + * point of view of the interpreter, should be checked.  The main purpos=
e of
> + * this flag is to improve the security and consistency of an execution
> + * environment to ensure that direct file execution (e.g. ./script.sh) a=
nd
> + * indirect file execution (e.g. sh script.sh) lead to the same result. =
 For
> + * instance, this can be used to check if a file is trustworthy accordin=
g to
> + * the caller's environment.
> + *
> + * In a secure environment, libraries and any executable dependencies sh=
ould
> + * also be checked.  For instance dynamic linking should make sure that =
all
> + * libraries are allowed for execution to avoid trivial bypass (e.g. usi=
ng
> + * LD_PRELOAD).  For such secure execution environment to make sense, on=
ly
> + * trusted code should be executable, which also requires integrity guar=
antees.
> + *
> + * To avoid race conditions leading to time-of-check to time-of-use issu=
es,
> + * AT_CHECK should be used with AT_EMPTY_PATH to check against a file
> + * descriptor instead of a path.
> + */
> +#define AT_CHECK               0x10000
> +
>  #if defined(__KERNEL__)
>  #define AT_GETATTR_NOSEC       0x80000000
>  #endif
> diff --git a/kernel/audit.h b/kernel/audit.h
> index a60d2840559e..8ebdabd2ab81 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -197,6 +197,7 @@ struct audit_context {
>                 struct open_how openat2;
>                 struct {
>                         int                     argc;
> +                       bool                    is_check;
>                 } execve;
>                 struct {
>                         char                    *name;
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 6f0d6fb6523f..b6316e284342 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2662,6 +2662,7 @@ void __audit_bprm(struct linux_binprm *bprm)
>
>         context->type =3D AUDIT_EXECVE;
>         context->execve.argc =3D bprm->argc;
> +       context->execve.is_check =3D bprm->is_check;
>  }
>
>
> --
> 2.45.2
>

