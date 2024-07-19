Return-Path: <linux-fsdevel+bounces-24007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 206D393790F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 16:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93C3A1F22EDC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 14:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB91142E85;
	Fri, 19 Jul 2024 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YLQ9Rrqk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08B481749
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2024 14:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721398659; cv=none; b=lgygDcPn4sDG8cSfglgngKZGUxMKGmI2Lvj2NGS5Upg5xbq22P1WqPxUfL4vI3Igp46/AZEZW9Jd/AfTcnIkg76cZbj8vxCnGqSTyZ0nWboyuYk59BREk1fdLZRK3WC3Au4rnAawC6Aoo7BFpL6svvFtQkjnhtkUXEWTsW4MYHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721398659; c=relaxed/simple;
	bh=4EWpzWGRDEjZbhG0kGkRZIyo4WrdmT6376CHlCk5/pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GZNB9TIQtx06sBWdcmWv3j1goZsiJ9raWt2BrvPEvHfUbJPFdMS+UkM0fLbnMZySAkgbsc3LA0w6nLH1eVXB6vbbCEP52n6Y0CTF96VpzAPrwKEP1s1XNitOFEE3EDtRISO0bkHSAm+UAqUhSL+HbIfshwodReNH670i5uZzZBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YLQ9Rrqk; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so12642a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2024 07:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721398656; x=1722003456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3gGwnKkOxiHuqDBoqHiGOngepHwURq3W8ZE5hfV4/I=;
        b=YLQ9RrqkSIq6CixGgC31cxVa5rmqGG0jmN2ffnr651EDlxqv0gzIFnjS2dNXV6TE+i
         QG/hORf+LgIrhuV4CsmUANPhzJRlESFaeWZLftn/0dvk82StxjD0JdSCNyHPIKCFF20h
         5u5+hI6R2833dRKca62coWdn1ewVDS0+njh4pN1jaNYVN84ZsBNqLKl1uesRCLp1ypi5
         twnGsDctNHHDCeVhaYrjvY3g9LLQUqrYNqHi9BPpPbrEw3siNoRzvBHE/KcDaS7VI5XB
         Jn0iZogWOaOGStLLmww9Pi/0XIxxquJRGssySirP61BI1qSD5GqcwuZYVfuk2gO4de6V
         GvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721398656; x=1722003456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3gGwnKkOxiHuqDBoqHiGOngepHwURq3W8ZE5hfV4/I=;
        b=umBiG3M4eBxleInm5N5v3y0FTQUUGYbUa7I6CxwL0RI5dhQHwmvISXmUKzZdOQJsAQ
         UwlpNTVA3OZzc9VmpnbppTE4bBzq5imJILbgKU4KOB3QVnSqVsyjMZL/Zs+muj2c+T3o
         XGQQnKhd/7RbMi8AVkvSmuBsbZDhNmofTkofQjjDVqPkCx3Nu/NMiQuTa/CoOp5xSHl3
         aKDqGCJNEL1ccQAm6LT3/EMfdm7UuJf6zug+llFpsq+KT7YGYRZUkL3XS2i2qj0P7ZcT
         6Deu4EIHstH4J01KRE+RKzi4JNlO9rGENpLp7QIBe8M6WTQ3QmTau1ezUwu7M9g2z160
         a+MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNunO8q+XZHB+rw+ZdAKf2pTEHlSU7xcFJH0RymHfxLEx+PwZs01Bhk32E04cjrJCIPI72MO6xzvq80JcdQUG6I5gauQilxMD7hyLFeg==
X-Gm-Message-State: AOJu0YyooRe01SKoCWCpU4hSWYIzWVuz3hGneHad6PnCS8kQQD5cyGsp
	llcI1/fgSoWL9Qcn55Q1czYivCv66IrGfiL21RBz9uPLUsuH8uinMMwnM+Ssc776J/cfAIyLXjc
	ROg0Lke37MhedLUhDuYMDkiiLJUtzfnLygT1W
X-Google-Smtp-Source: AGHT+IF76WQ3Sl0kv11m20n2/Esl/cSZDr2M3d5alLDqRF7hKGGW3bWZH0gtFIknuNBESclOnt0Py52fuwxCjdRo6fQ=
X-Received: by 2002:a05:6402:50c9:b0:57c:c5e2:2c37 with SMTP id
 4fb4d7f45d1cf-5a2f262b220mr158387a12.3.1721398655421; Fri, 19 Jul 2024
 07:17:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704190137.696169-1-mic@digikod.net> <20240704190137.696169-2-mic@digikod.net>
 <CALmYWFss7qcpR9D_r3pbP_Orxs55t3y3yXJsac1Wz=Hk9Di0Nw@mail.gmail.com>
 <20240717.neaB5Aiy2zah@digikod.net> <CALmYWFt=yXpzhS=HS9FjwVMvx6U1MoR31vK79wxNLhmJm9bBoA@mail.gmail.com>
 <20240718.kaePhei9Ahm9@digikod.net> <CALmYWFto4sw-Q2+J0Gc54POhnM9C8YpnJ44wMz=fd_K3_+dWmw@mail.gmail.com>
 <20240719.shaeK6PaiSie@digikod.net>
In-Reply-To: <20240719.shaeK6PaiSie@digikod.net>
From: Jeff Xu <jeffxu@google.com>
Date: Fri, 19 Jul 2024 07:16:55 -0700
Message-ID: <CALmYWFsd-=pOPZZmiKvYJ8pOhACsTvW_d+pRjG_C4jD6+Li0AQ@mail.gmail.com>
Subject: Re: [RFC PATCH v19 1/5] exec: Add a new AT_CHECK flag to execveat(2)
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Paul Moore <paul@paul-moore.com>, "Theodore Ts'o" <tytso@mit.edu>, Alejandro Colomar <alx@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Eric Chiang <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	James Morris <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>, 
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
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
	linux-security-module@vger.kernel.org, Elliott Hughes <enh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 1:45=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> On Thu, Jul 18, 2024 at 06:29:54PM -0700, Jeff Xu wrote:
> > On Thu, Jul 18, 2024 at 5:24=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > >
> > > On Wed, Jul 17, 2024 at 07:08:17PM -0700, Jeff Xu wrote:
> > > > On Wed, Jul 17, 2024 at 3:01=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <m=
ic@digikod.net> wrote:
> > > > >
> > > > > On Tue, Jul 16, 2024 at 11:33:55PM -0700, Jeff Xu wrote:
> > > > > > On Thu, Jul 4, 2024 at 12:02=E2=80=AFPM Micka=C3=ABl Sala=C3=BC=
n <mic@digikod.net> wrote:
> > > > > > >
> > > > > > > Add a new AT_CHECK flag to execveat(2) to check if a file wou=
ld be
> > > > > > > allowed for execution.  The main use case is for script inter=
preters and
> > > > > > > dynamic linkers to check execution permission according to th=
e kernel's
> > > > > > > security policy. Another use case is to add context to access=
 logs e.g.,
> > > > > > > which script (instead of interpreter) accessed a file.  As an=
y
> > > > > > > executable code, scripts could also use this check [1].
> > > > > > >
> > > > > > > This is different than faccessat(2) which only checks file ac=
cess
> > > > > > > rights, but not the full context e.g. mount point's noexec, s=
tack limit,
> > > > > > > and all potential LSM extra checks (e.g. argv, envp, credenti=
als).
> > > > > > > Since the use of AT_CHECK follows the exact kernel semantic a=
s for a
> > > > > > > real execution, user space gets the same error codes.
> > > > > > >
> > > > > > So we concluded that execveat(AT_CHECK) will be used to check t=
he
> > > > > > exec, shared object, script and config file (such as seccomp co=
nfig),
>
> > > > > > I think binfmt_elf.c in the kernel needs to check the ld.so to =
make
> > > > > > sure it passes AT_CHECK, before loading it into memory.
> > > > >
> > > > > All ELF dependencies are opened and checked with open_exec(), whi=
ch
> > > > > perform the main executability checks (with the __FMODE_EXEC flag=
).
> > > > > Did I miss something?
> > > > >
> > > > I mean the ld-linux-x86-64.so.2 which is loaded by binfmt in the ke=
rnel.
> > > > The app can choose its own dynamic linker path during build, (maybe
> > > > even statically link one ?)  This is another reason that relying on=
 a
> > > > userspace only is not enough.
> > >
> > > The kernel calls open_exec() on all dependencies, including
> > > ld-linux-x86-64.so.2, so these files are checked for executability to=
o.
> > >
> > This might not be entirely true. iiuc, kernel  calls open_exec for
> > open_exec for interpreter, but not all its dependency (e.g. libc.so.6)
>
> Correct, the dynamic linker is in charge of that, which is why it must
> be enlighten with execveat+AT_CHECK and securebits checks.
>
> > load_elf_binary() {
> >    interpreter =3D open_exec(elf_interpreter);
> > }
> >
> > libc.so.6 is opened and mapped by dynamic linker.
> > so the call sequence is:
> >  execve(a.out)
> >   - open exec(a.out)
> >   - security_bprm_creds(a.out)
> >   - open the exec(ld.so)
> >   - call open_exec() for interruptor (ld.so)
> >   - call execveat(AT_CHECK, ld.so) <-- do we want ld.so going through
> > the same check and code path as libc.so below ?
>
> open_exec() checks are enough.  LSMs can use this information (open +
> __FMODE_EXEC) if needed.  execveat+AT_CHECK is only a user space
> request.
>
Then the ld.so doesn't go through the same security_bprm_creds() check
as other .so.

As my previous email, the ChromeOS LSM restricts executable mfd
through security_bprm_creds(), the end result is that ld.so can still
be executable memfd, but not other .so.

One way to address this is to refactor the necessary code from
execveat() code patch, and make it available to call from both kernel
and execveat() code paths., but if we do that, we might as well use
faccessat2(AT_CHECK)


> >   - transfer the control to ld.so)
> >   - ld.so open (libc.so)
> >   - ld.so call execveat(AT_CHECK,libc.so) <-- proposed by this patch,
> > require dynamic linker change.
> >   - ld.so mmap(libc.so,rx)
>
> Explaining these steps is useful. I'll include that in the next patch
> series.
>
> > > > A detailed user case will help demonstrate the use case for dynamic
> > > > linker, e.g. what kind of app will benefit from
> > > > SECBIT_EXEC_RESTRICT_FILE =3D 1, what kind of threat model are we
> > > > dealing with , what kind of attack chain we blocked as a result.
> > >
> > > I explained that in the patches and in the description of these new
> > > securebits.  Please point which part is not clear.  The full threat
> > > model is simple: the TCB includes the kernel and system's files, whic=
h
> > > are integrity-protected, but we don't trust arbitrary data/scripts th=
at
> > > can be written to user-owned files or directly provided to script
> > > interpreters.  As for the ptrace restrictions, the dynamic linker
> > > restrictions helps to avoid trivial bypasses (e.g. with LD_PRELOAD)
> > > with consistent executability checks.
> > >
> > On elf loading case, I'm clear after your last email. However, I'm not
> > sure if everyone else follows,  I will try to summarize here:
> > - Problem:  ld.so /tmp/a.out will happily pass, even /tmp/a.out is
> > mounted as non-exec.
> >   Solution: ld.so call execveat(AT_CHECK) for a.out before mmap a.out
> > into memory.
> >
> > - Problem: a poorly built application (a.out) can have a dependency on
> > /tmp/a.o, when /tmp/a.o is on non-exec mount,
> >   Solution: ld.so call execveat(AT_CHECK) for a.o, before mmap a.o into=
 memory.
> >
> > - Problem: application can call mmap (/tmp/a.out, rx), where /tmp is
> > on non-exec mount
>
> I'd say "malicious or non-enlightened processes" can call mmap without
> execveat+AT_CHECK...
>
> >   This is out of scope, i.e. will require enforcement on mmap(), maybe
> > through LSM
>
> Cool, I'll include that as well. Thanks.

