Return-Path: <linux-fsdevel+bounces-31817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDF199B8EF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2024 11:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494431F21403
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2024 09:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE4313B792;
	Sun, 13 Oct 2024 09:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRACa7Jk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAFA17557;
	Sun, 13 Oct 2024 09:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728811526; cv=none; b=jYvRq+5ZYOKjz5MlZ1Ft8yzMKP0pnBMx1y8gjm1OesKufVdC45+0jwLEQ1/ZU4X/z1Y9CmeLr5No8tt7OLRlo/yMcZ/RA7icx7P+gyCe5Yks3wGuFRj4SXhOGjTU+LQMYr6131RP1kcWRY9+eEMQr+9VNiDo/XI7tUxp1G3Sclw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728811526; c=relaxed/simple;
	bh=d/trfIAh5TFhMfXZwRTveMRwTjmpxI+lsttj8bGExGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UO7+gb19nIiBSHlHn9Dgdt6jl5l96liW7ghMKZZueARURxHXK8ECeC1v+RJP+SNZ6UQi2IbdpPObiszJgzQXiVN9XXYPLovjN/FIJ8dAWcdyqxvgIvT0EPIUg8WJSBxVBBDSXI4OmVyrDq3ceOEfrwmPPfzBw+Ug0B3M7knieXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRACa7Jk; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b111535924so286800385a.2;
        Sun, 13 Oct 2024 02:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728811523; x=1729416323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaFBGNz2XPoyEo+hECMZYXHfXzHmpgaXkJU5xSSktM4=;
        b=MRACa7JkrERc0ZBd1TSGIy2xwNEzEJHlxvyAhTgf3BBhsNXcenqnsefJIdKVfemY4F
         4I94ipBM61kbcuBy2zSZH+BqS7ub8K+QDOZZol4mdPLaw41cHsoC1+NeZKqizjBZS2gR
         LDeg28KDSQfgg8YaDHJMbIBakrZs8GB/bosVo3VY6sTUJHCCwCYiB3J7QTCQiOjbxIbV
         dK0eGiLh6rtPQFv/jdizQbq64VwREiRhx8JQ5vK+FJWfFCHF5Vwx8sDISXJ00ofUL78c
         7p/JPvVG1LWX3fq8lJiY8M/ML2xtb11RF1n5TXroQRcgoUXtR7JQoXTmEalOe2Len48w
         rpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728811523; x=1729416323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KaFBGNz2XPoyEo+hECMZYXHfXzHmpgaXkJU5xSSktM4=;
        b=JVayFnVjXs86CWZ2QR5NwkwFh6ENBsbSe1kCP9+FSTzH9qtbfPmv2nvWS9zgJaGzzi
         ipVNyRFER0iN+xqt1XR0gjVR0j7DnPkdl29cii8OrBP/k2b04sCvDEyocv1INxZnjdS9
         diVnG1sAwBtxbOvOKbS4m7IMWvcvel0qWZ0Wx25kugBRXvYfDPPRfuPvBACsvpGpkpN4
         7K/I/EB1mWLMZZvy2qQHE0CedK5melUaiGmhvY4Vs3l55TlF/l+hQnsDn6jpb1JKs7a0
         y0wCDpZeLSdtYxLgPEfErKbZHtS1Qlxo3/QioERjL/4Z5oIQJ4wq0q/fA4NIEfchocmp
         BgJA==
X-Forwarded-Encrypted: i=1; AJvYcCU6h+dTkLfsMQ/vq8/eWjuTzyAj/Ry0Xr/Vt3zeujReVuzEgD4ECE1/DW8IDFVdhbTe8nVBJB41DOTte0q/@vger.kernel.org, AJvYcCUXx/7K31DyTmM4Q1FbC1PH9+7ZPqaWOIoF3kPYFFHaXwMfy8ngfzl9OBjaRxdR09kM3VGa5bMdBc8/r26x/AlublBc8YFZ@vger.kernel.org, AJvYcCUaMHtBmnP3b44EKd2981sUilW4JEscjEZB4P73H7dm5+PpmivU+y0Rr8KbnOODtB1hztPJFX0ggLQ=@vger.kernel.org, AJvYcCVixypnOmIi0GLk/uWJe+YEEhCeOamhV4pSnCNJNBTt1CUIc+URCKKRKNm579r8twB9M246PdBCLwmBUaz4QsyV@vger.kernel.org, AJvYcCXWnCKko0h5EO6HbpIGCW393mjo6v7C8KBkZTrHnbbUbeiGgKDFjyV0iwwaQDQHwW0ZXtiTOjCCYtMFf/ErKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxoIIhSWxttlXZa6AX+X8Elb+lm4V0pniiXl6OW6XpagH+qGjX
	5ZaRhhxjagCIfqcULBE/0a6GleTmRI8AZsTcwRB6eW//5UwBjlnuFO9w26zgOEefWH3W7CbIEZ2
	wBLhrXTcR+diLeOXVehYQtuf0/Zw=
X-Google-Smtp-Source: AGHT+IFnjTA6tChcRzvuTePAlpSofBsS7Ba9WDcYdOoG1HdjOJ1j5RwXrOu+zxfF71tRaFhLCvPh4LuYTEsT3CJPL44=
X-Received: by 2002:a05:620a:1929:b0:7ac:e157:e04d with SMTP id
 af79cd13be357-7b11a3bcb9cmr1195494085a.40.1728811523345; Sun, 13 Oct 2024
 02:25:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011184422.977903-1-mic@digikod.net> <20241011184422.977903-2-mic@digikod.net>
In-Reply-To: <20241011184422.977903-2-mic@digikod.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 13 Oct 2024 11:25:11 +0200
Message-ID: <CAOQ4uxi502PNn8eyKt9BExXVhbpx04f0XTeLg771i6wPOrLadA@mail.gmail.com>
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

On Fri, Oct 11, 2024 at 8:45=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> Add a new AT_CHECK flag to execveat(2) to check if a file would be
> allowed for execution.  The main use case is for script interpreters and
> dynamic linkers to check execution permission according to the kernel's
> security policy. Another use case is to add context to access logs e.g.,
> which script (instead of interpreter) accessed a file.  As any
> executable code, scripts could also use this check [1].
>
> This is different from faccessat(2) + X_OK which only checks a subset of
> access rights (i.e. inode permission and mount options for regular
> files), but not the full context (e.g. all LSM access checks).  The main
> use case for access(2) is for SUID processes to (partially) check access
> on behalf of their caller.  The main use case for execveat(2) + AT_CHECK
> is to check if a script execution would be allowed, according to all the
> different restrictions in place.  Because the use of AT_CHECK follows
> the exact kernel semantic as for a real execution, user space gets the
> same error codes.
>
> An interesting point of using execveat(2) instead of openat2(2) is that
> it decouples the check from the enforcement.  Indeed, the security check
> can be logged (e.g. with audit) without blocking an execution
> environment not yet ready to enforce a strict security policy.
>
> LSMs can control or log execution requests with
> security_bprm_creds_for_exec().  However, to enforce a consistent and
> complete access control (e.g. on binary's dependencies) LSMs should
> restrict file executability, or mesure executed files, with
> security_file_open() by checking file->f_flags & __FMODE_EXEC.
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
> configuration mechanism with the SECBIT_EXEC_RESTRICT_FILE and
> SECBIT_EXEC_DENY_INTERACTIVE securebits.
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
> Cc: Serge Hallyn <serge@hallyn.com>
> Link: https://docs.python.org/3/library/io.html#io.open_code [1]
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20241011184422.977903-2-mic@digikod.net
> ---
>
> Changes since v19:
> * Remove mention of "role transition" as suggested by Andy.
> * Highlight the difference between security_bprm_creds_for_exec() and
>   the __FMODE_EXEC check for LSMs (in commit message and LSM's hooks) as
>   discussed with Jeff.
> * Improve documentation both in UAPI comments and kernel comments
>   (requested by Kees).
>
> New design since v18:
> https://lore.kernel.org/r/20220104155024.48023-3-mic@digikod.net
> ---
>  fs/exec.c                  | 18 ++++++++++++++++--
>  include/linux/binfmts.h    |  7 ++++++-
>  include/uapi/linux/fcntl.h | 31 +++++++++++++++++++++++++++++++
>  kernel/audit.h             |  1 +
>  kernel/auditsc.c           |  1 +
>  security/security.c        | 10 ++++++++++
>  6 files changed, 65 insertions(+), 3 deletions(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index 6c53920795c2..163c659d9ae6 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -891,7 +891,7 @@ static struct file *do_open_execat(int fd, struct fil=
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
> @@ -1545,6 +1545,20 @@ static struct linux_binprm *alloc_bprm(int fd, str=
uct filename *filename, int fl
>         }
>         bprm->interp =3D bprm->filename;
>
> +       /*
> +        * At this point, security_file_open() has already been called (w=
ith
> +        * __FMODE_EXEC) and access control checks for AT_CHECK will stop=
 just
> +        * after the security_bprm_creds_for_exec() call in bprm_execve()=
.
> +        * Indeed, the kernel should not try to parse the content of the =
file
> +        * with exec_binprm() nor change the calling thread, which means =
that
> +        * the following security functions will be not called:
> +        * - security_bprm_check()
> +        * - security_bprm_creds_from_file()
> +        * - security_bprm_committing_creds()
> +        * - security_bprm_committed_creds()
> +        */
> +       bprm->is_check =3D !!(flags & AT_CHECK);
> +
>         retval =3D bprm_mm_init(bprm);
>         if (!retval)
>                 return bprm;
> @@ -1839,7 +1853,7 @@ static int bprm_execve(struct linux_binprm *bprm)
>
>         /* Set the unchanging part of bprm->cred */
>         retval =3D security_bprm_creds_for_exec(bprm);
> -       if (retval)
> +       if (retval || bprm->is_check)
>                 goto out;
>
>         retval =3D exec_binprm(bprm);
> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> index e6c00e860951..8ff0eb3644a1 100644
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
> index 87e2dec79fea..e606815b1c5a 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -154,6 +154,37 @@
>                                            usable with open_by_handle_at(=
2). */
>  #define AT_HANDLE_MNT_ID_UNIQUE        0x001   /* Return the u64 unique =
mount ID. */
>
> +/*
> + * AT_CHECK only performs a check on a regular file and returns 0 if exe=
cution
> + * of this file would be allowed, ignoring the file format and then the =
related
> + * interpreter dependencies (e.g. ELF libraries, script's shebang).
> + *
> + * Programs should always perform this check to apply kernel-level check=
s
> + * against files that are not directly executed by the kernel but passed=
 to a
> + * user space interpreter instead.  All files that contain executable co=
de,
> + * from the point of view of the interpreter, should be checked.  Howeve=
r the
> + * result of this check should only be enforced according to
> + * SECBIT_EXEC_RESTRICT_FILE or SECBIT_EXEC_DENY_INTERACTIVE.  See secur=
ebits.h
> + * documentation and the samples/check-exec/inc.c example.
> + *
> + * The main purpose of this flag is to improve the security and consiste=
ncy of
> + * an execution environment to ensure that direct file execution (e.g.
> + * `./script.sh`) and indirect file execution (e.g. `sh script.sh`) lead=
 to the
> + * same result.  For instance, this can be used to check if a file is
> + * trustworthy according to the caller's environment.
> + *
> + * In a secure environment, libraries and any executable dependencies sh=
ould
> + * also be checked.  For instance, dynamic linking should make sure that=
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

If you ask me, the very elaborate comment above belongs to execveat(2)
man page and is way too verbose for a uapi header.

> +#define AT_CHECK               0x10000

Please see the comment "Per-syscall flags for the *at(2) family of syscalls=
."
above. If this is a per-syscall flag please use one of the per-syscall
flags, e.g.:

/* Flags for execveat2(2) */
#define AT_EXECVE_CHECK     0x0001   /* Only perform a check if
execution would be allowed */


Thanks,
Amir.

