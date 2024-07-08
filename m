Return-Path: <linux-fsdevel+bounces-23302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6EB92A724
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 18:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B781C2139A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 16:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FAD1474AB;
	Mon,  8 Jul 2024 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qy6WXTuP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14ED1459F6
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jul 2024 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720455493; cv=none; b=uuJkvrt3VVYLHswwuyrNeEx7XA963BCT8CTUkFSuM2qwUsQyiB4mHMdcwwnSzbcwmvepzDVGFC5E47TK3p1IGBGUoDiq+nMRBbLlkuLcSxIRrU4difRX/tdnNUhpMW0zvdn+AWo3Wbtf2Y1gI6KU9tqekANzw2Fg5G8Zdpj6HzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720455493; c=relaxed/simple;
	bh=MuJEbBHy6itu6fmEwM7+t6HMdCK8qgssL/78E3P5OUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dLJ7JGS37hKEiE2tKgN2FI4GYujfYnR0Njk20vN0nKda1bfDsNRTiLw6hQ0yIwLRxbPeNjzJFTtEtRyYvfSnD7FnQbI/UCBP6flTTGoMPp5mYITsHUvlqGngJQzWLmkpr6GbO6r5NDbzqLoIjuCsp0VQtyBgZjeFIlMElxFA8lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qy6WXTuP; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-58c92e77ac7so40958a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jul 2024 09:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720455490; x=1721060290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fn/a7ER44O8bOHjkNsYey6oRYCmXOGVH7UnmwHXI7t0=;
        b=Qy6WXTuPqAVgYnlv9zf+pTDiaO36kVf7MD9i1yXdw7oj7s0uJyt4pSxlw8hAuuqwES
         BN6/gGRPOH9m7uWuAHE8PQAaYuIB6S/LdxwApUIQ9e83mVto1q7gvrVPdFaS+UlmsThZ
         xpwCqeIgcMZdQPjMv2ghz1guikKyjsfCD8xow7HXEHzUbENKzsyo2UGQxjyItXooRkHO
         cFmS8IXblINGtcSsJYO2NMZTunTnt9wub68pddxB91vJONGI+MD4NjO5w1aCZ03E4B9N
         uC5xfWeMg4cFH7InnLFokK4xlm8JHBAKiK8nSRBB9SFf9jW+9/D2kYmHIXIfeGEe36dC
         EyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720455490; x=1721060290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fn/a7ER44O8bOHjkNsYey6oRYCmXOGVH7UnmwHXI7t0=;
        b=MMzwcQPL7oXfEoe4syXJY6OMF+mf0J5Yhnx/Xe/c0gJcSajNbQ+orHYxN9xV0qqR/y
         0IbPlu9ZuI/iC5WRCkRF9jolA2cpnWUPYSlFt8rViRvvsaTZCwKrw9DzaNoAIJhlnjrx
         nysXH7KBIvD2IijfjP/IA8GuMkT48KKMf4uuNR9WM+dyyvJ2AKj2eLbmgm24CRcVBzSp
         758a/H/J/YY2M7jrK+DvjWs1XA5WW4X42V2MxfTCYkLxDAzC2pJfMFpeyFmHN3nngVxx
         k5tayrqfVUWollr4EHONfSgS+6nTHBKfMzPNYHXmxYK72CRSDy8+Ko679+jlblfFRjdz
         pZyg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ2/GdMX7YVuVufYIudoEAZ5iWSmetYuDycBchyRSqgvFLlwt7n42yOpsF3t4fnGNrPcHq0zRKQrBulrbki3SxL7vz74D7cNrrOFJoJA==
X-Gm-Message-State: AOJu0YwFSFSaOcK7frlGSUFufGQPUGPuP3TuUmvGYpuyEWechJXgMXur
	PbLzr/ipZy/sAH4rjcYQ7gUCSHYpP2Exg0OGoy2/2L5ZbtHVRVmnirx/+pRGrpKvsykTLFFLFoh
	tIgTOJyfzRMLzn1Xyi3ua0F/QJ5FhsDrx334b
X-Google-Smtp-Source: AGHT+IF0JA8f5F0B9mZePvGnab2T+eDbnveXuqABggo9msC/3jQwhRII7ytvWhl3d0S2UKfySqynwO3nSEeF71AYPbY=
X-Received: by 2002:a50:bae9:0:b0:58b:dfaa:a5cd with SMTP id
 4fb4d7f45d1cf-59352e1a5b2mr165860a12.2.1720455489944; Mon, 08 Jul 2024
 09:18:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704190137.696169-1-mic@digikod.net> <20240704190137.696169-3-mic@digikod.net>
In-Reply-To: <20240704190137.696169-3-mic@digikod.net>
From: Jeff Xu <jeffxu@google.com>
Date: Mon, 8 Jul 2024 09:17:32 -0700
Message-ID: <CALmYWFscz5W6xSXD-+dimzbj=TykNJEDa0m5gvBx93N-J+3nKA@mail.gmail.com>
Subject: Re: [RFC PATCH v19 2/5] security: Add new SHOULD_EXEC_CHECK and
 SHOULD_EXEC_RESTRICT securebits
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

Hi

On Thu, Jul 4, 2024 at 12:02=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> These new SECBIT_SHOULD_EXEC_CHECK, SECBIT_SHOULD_EXEC_RESTRICT, and
> their *_LOCKED counterparts are designed to be set by processes setting
> up an execution environment, such as a user session, a container, or a
> security sandbox.  Like seccomp filters or Landlock domains, the
> securebits are inherited across proceses.
>
> When SECBIT_SHOULD_EXEC_CHECK is set, programs interpreting code should
> check executable resources with execveat(2) + AT_CHECK (see previous
> patch).
>
> When SECBIT_SHOULD_EXEC_RESTRICT is set, a process should only allow
> execution of approved resources, if any (see SECBIT_SHOULD_EXEC_CHECK).
>
Do we need both bits ?
When CHECK is set and RESTRICT is not, the "check fail" executable
will still get executed, so CHECK is for logging ?
Does RESTRICT imply CHECK is set, e.g. What if CHECK=3D0 and RESTRICT =3D 1=
 ?

> For a secure environment, we might also want
> SECBIT_SHOULD_EXEC_CHECK_LOCKED and SECBIT_SHOULD_EXEC_RESTRICT_LOCKED
> to be set.  For a test environment (e.g. testing on a fleet to identify
> potential issues), only the SECBIT_SHOULD_EXEC_CHECK* bits can be set to
> still be able to identify potential issues (e.g. with interpreters logs
> or LSMs audit entries).
>
> It should be noted that unlike other security bits, the
> SECBIT_SHOULD_EXEC_CHECK and SECBIT_SHOULD_EXEC_RESTRICT bits are
> dedicated to user space willing to restrict itself.  Because of that,
> they only make sense in the context of a trusted environment (e.g.
> sandbox, container, user session, full system) where the process
> changing its behavior (according to these bits) and all its parent
> processes are trusted.  Otherwise, any parent process could just execute
> its own malicious code (interpreting a script or not), or even enforce a
> seccomp filter to mask these bits.
>
> Such a secure environment can be achieved with an appropriate access
> control policy (e.g. mount's noexec option, file access rights, LSM
> configuration) and an enlighten ld.so checking that libraries are
> allowed for execution e.g., to protect against illegitimate use of
> LD_PRELOAD.
>
> Scripts may need some changes to deal with untrusted data (e.g. stdin,
> environment variables), but that is outside the scope of the kernel.
>
> The only restriction enforced by the kernel is the right to ptrace
> another process.  Processes are denied to ptrace less restricted ones,
> unless the tracer has CAP_SYS_PTRACE.  This is mainly a safeguard to
> avoid trivial privilege escalations e.g., by a debugging process being
> abused with a confused deputy attack.
>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20240704190137.696169-3-mic@digikod.net
> ---
>
> New design since v18:
> https://lore.kernel.org/r/20220104155024.48023-3-mic@digikod.net
> ---
>  include/uapi/linux/securebits.h | 56 ++++++++++++++++++++++++++++-
>  security/commoncap.c            | 63 ++++++++++++++++++++++++++++-----
>  2 files changed, 110 insertions(+), 9 deletions(-)
>
> diff --git a/include/uapi/linux/securebits.h b/include/uapi/linux/secureb=
its.h
> index d6d98877ff1a..3fdb0382718b 100644
> --- a/include/uapi/linux/securebits.h
> +++ b/include/uapi/linux/securebits.h
> @@ -52,10 +52,64 @@
>  #define SECBIT_NO_CAP_AMBIENT_RAISE_LOCKED \
>                         (issecure_mask(SECURE_NO_CAP_AMBIENT_RAISE_LOCKED=
))
>
> +/*
> + * When SECBIT_SHOULD_EXEC_CHECK is set, a process should check all exec=
utable
> + * files with execveat(2) + AT_CHECK.  However, such check should only b=
e
> + * performed if all to-be-executed code only comes from regular files.  =
For
> + * instance, if a script interpreter is called with both a script snippe=
d as
> + * argument and a regular file, the interpreter should not check any fil=
e.
> + * Doing otherwise would mislead the kernel to think that only the scrip=
t file
> + * is being executed, which could for instance lead to unexpected permis=
sion
> + * change and break current use cases.
> + *
> + * This secure bit may be set by user session managers, service managers=
,
> + * container runtimes, sandboxer tools...  Except for test environments,=
 the
> + * related SECBIT_SHOULD_EXEC_CHECK_LOCKED bit should also be set.
> + *
> + * Ptracing another process is deny if the tracer has SECBIT_SHOULD_EXEC=
_CHECK
> + * but not the tracee.  SECBIT_SHOULD_EXEC_CHECK_LOCKED also checked.
> + */
> +#define SECURE_SHOULD_EXEC_CHECK               8
> +#define SECURE_SHOULD_EXEC_CHECK_LOCKED                9  /* make bit-8 =
immutable */
> +
> +#define SECBIT_SHOULD_EXEC_CHECK (issecure_mask(SECURE_SHOULD_EXEC_CHECK=
))
> +#define SECBIT_SHOULD_EXEC_CHECK_LOCKED \
> +                       (issecure_mask(SECURE_SHOULD_EXEC_CHECK_LOCKED))
> +
> +/*
> + * When SECBIT_SHOULD_EXEC_RESTRICT is set, a process should only allow
> + * execution of approved files, if any (see SECBIT_SHOULD_EXEC_CHECK).  =
For
> + * instance, script interpreters called with a script snippet as argumen=
t
> + * should always deny such execution if SECBIT_SHOULD_EXEC_RESTRICT is s=
et.
> + * However, if a script interpreter is called with both
> + * SECBIT_SHOULD_EXEC_CHECK and SECBIT_SHOULD_EXEC_RESTRICT, they should
> + * interpret the provided script files if no unchecked code is also prov=
ided
> + * (e.g. directly as argument).
> + *
> + * This secure bit may be set by user session managers, service managers=
,
> + * container runtimes, sandboxer tools...  Except for test environments,=
 the
> + * related SECBIT_SHOULD_EXEC_RESTRICT_LOCKED bit should also be set.
> + *
> + * Ptracing another process is deny if the tracer has
> + * SECBIT_SHOULD_EXEC_RESTRICT but not the tracee.
> + * SECBIT_SHOULD_EXEC_RESTRICT_LOCKED is also checked.
> + */
> +#define SECURE_SHOULD_EXEC_RESTRICT            10
> +#define SECURE_SHOULD_EXEC_RESTRICT_LOCKED     11  /* make bit-8 immutab=
le */
> +
> +#define SECBIT_SHOULD_EXEC_RESTRICT (issecure_mask(SECURE_SHOULD_EXEC_RE=
STRICT))
> +#define SECBIT_SHOULD_EXEC_RESTRICT_LOCKED \
> +                       (issecure_mask(SECURE_SHOULD_EXEC_RESTRICT_LOCKED=
))
> +
>  #define SECURE_ALL_BITS                (issecure_mask(SECURE_NOROOT) | \
>                                  issecure_mask(SECURE_NO_SETUID_FIXUP) | =
\
>                                  issecure_mask(SECURE_KEEP_CAPS) | \
> -                                issecure_mask(SECURE_NO_CAP_AMBIENT_RAIS=
E))
> +                                issecure_mask(SECURE_NO_CAP_AMBIENT_RAIS=
E) | \
> +                                issecure_mask(SECURE_SHOULD_EXEC_CHECK) =
| \
> +                                issecure_mask(SECURE_SHOULD_EXEC_RESTRIC=
T))
>  #define SECURE_ALL_LOCKS       (SECURE_ALL_BITS << 1)
>
> +#define SECURE_ALL_UNPRIVILEGED (issecure_mask(SECURE_SHOULD_EXEC_CHECK)=
 | \
> +                                issecure_mask(SECURE_SHOULD_EXEC_RESTRIC=
T))
> +
>  #endif /* _UAPI_LINUX_SECUREBITS_H */
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 162d96b3a676..34b4493e2a69 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -117,6 +117,33 @@ int cap_settime(const struct timespec64 *ts, const s=
truct timezone *tz)
>         return 0;
>  }
>
> +static bool ptrace_secbits_allowed(const struct cred *tracer,
> +                                  const struct cred *tracee)
> +{
> +       const unsigned long tracer_secbits =3D SECURE_ALL_UNPRIVILEGED &
> +                                            tracer->securebits;
> +       const unsigned long tracee_secbits =3D SECURE_ALL_UNPRIVILEGED &
> +                                            tracee->securebits;
> +       /* Ignores locking of unset secure bits (cf. SECURE_ALL_LOCKS). *=
/
> +       const unsigned long tracer_locked =3D (tracer_secbits << 1) &
> +                                           tracer->securebits;
> +       const unsigned long tracee_locked =3D (tracee_secbits << 1) &
> +                                           tracee->securebits;
> +
> +       /* The tracee must not have less constraints than the tracer. */
> +       if ((tracer_secbits | tracee_secbits) !=3D tracee_secbits)
> +               return false;
> +
> +       /*
> +        * Makes sure that the tracer's locks for restrictions are the sa=
me for
> +        * the tracee.
> +        */
> +       if ((tracer_locked | tracee_locked) !=3D tracee_locked)
> +               return false;
> +
> +       return true;
> +}
> +
>  /**
>   * cap_ptrace_access_check - Determine whether the current process may a=
ccess
>   *                        another
> @@ -146,7 +173,8 @@ int cap_ptrace_access_check(struct task_struct *child=
, unsigned int mode)
>         else
>                 caller_caps =3D &cred->cap_permitted;
>         if (cred->user_ns =3D=3D child_cred->user_ns &&
> -           cap_issubset(child_cred->cap_permitted, *caller_caps))
> +           cap_issubset(child_cred->cap_permitted, *caller_caps) &&
> +           ptrace_secbits_allowed(cred, child_cred))
>                 goto out;
>         if (ns_capable(child_cred->user_ns, CAP_SYS_PTRACE))
>                 goto out;
> @@ -178,7 +206,8 @@ int cap_ptrace_traceme(struct task_struct *parent)
>         cred =3D __task_cred(parent);
>         child_cred =3D current_cred();
>         if (cred->user_ns =3D=3D child_cred->user_ns &&
> -           cap_issubset(child_cred->cap_permitted, cred->cap_permitted))
> +           cap_issubset(child_cred->cap_permitted, cred->cap_permitted) =
&&
> +           ptrace_secbits_allowed(cred, child_cred))
>                 goto out;
>         if (has_ns_capability(parent, child_cred->user_ns, CAP_SYS_PTRACE=
))
>                 goto out;
> @@ -1302,21 +1331,39 @@ int cap_task_prctl(int option, unsigned long arg2=
, unsigned long arg3,
>                      & (old->securebits ^ arg2))                        /=
*[1]*/
>                     || ((old->securebits & SECURE_ALL_LOCKS & ~arg2))   /=
*[2]*/
>                     || (arg2 & ~(SECURE_ALL_LOCKS | SECURE_ALL_BITS))   /=
*[3]*/
> -                   || (cap_capable(current_cred(),
> -                                   current_cred()->user_ns,
> -                                   CAP_SETPCAP,
> -                                   CAP_OPT_NONE) !=3D 0)                =
 /*[4]*/
>                         /*
>                          * [1] no changing of bits that are locked
>                          * [2] no unlocking of locks
>                          * [3] no setting of unsupported bits
> -                        * [4] doing anything requires privilege (go read=
 about
> -                        *     the "sendmail capabilities bug")
>                          */
>                     )
>                         /* cannot change a locked bit */
>                         return -EPERM;
>
> +               /*
> +                * Doing anything requires privilege (go read about the
> +                * "sendmail capabilities bug"), except for unprivileged =
bits.
> +                * Indeed, the SECURE_ALL_UNPRIVILEGED bits are not
> +                * restrictions enforced by the kernel but by user space =
on
> +                * itself.  The kernel is only in charge of protecting ag=
ainst
> +                * privilege escalation with ptrace protections.
> +                */
> +               if (cap_capable(current_cred(), current_cred()->user_ns,
> +                               CAP_SETPCAP, CAP_OPT_NONE) !=3D 0) {
> +                       const unsigned long unpriv_and_locks =3D
> +                               SECURE_ALL_UNPRIVILEGED |
> +                               SECURE_ALL_UNPRIVILEGED << 1;
> +                       const unsigned long changed =3D old->securebits ^=
 arg2;
> +
> +                       /* For legacy reason, denies non-change. */
> +                       if (!changed)
> +                               return -EPERM;
> +
> +                       /* Denies privileged changes. */
> +                       if (changed & ~unpriv_and_locks)
> +                               return -EPERM;
> +               }
> +
>                 new =3D prepare_creds();
>                 if (!new)
>                         return -ENOMEM;
> --
> 2.45.2
>

