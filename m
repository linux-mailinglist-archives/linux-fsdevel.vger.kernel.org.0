Return-Path: <linux-fsdevel+bounces-24020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361D69379E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 17:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68243B21A70
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 15:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BC514534D;
	Fri, 19 Jul 2024 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aXH0hAzy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F02C143723
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2024 15:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721402881; cv=none; b=W6K4168Z8F9rXRkIReEFnCbTMZkN25cy73czy+iNlWIxVZDEZmaKhNnMqkOUCEtQarGAAKhBVqgrNHr39nUY8R+LoQxTxl+T8Fha5Um4FvzMuLV4ZKElR7/crHsLOqMpNrb3CsJ1sg/ypD9mVSP7AlSYLMK6Kngl1NOQqEZpTu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721402881; c=relaxed/simple;
	bh=sD1lGd9SneUctEquyLBmVbslUeLr+/Ruw82FHYbwjto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lzkeF3flS+NtZL0pNfPunJzZIeNFd8MFjr15ruJaTB7RnAFrK+AQ70seN2lhwYGJQ7BWb1vLewMcGpU6IxztYbIvzcHBkUiit/rh3S/wJrRT3sPZUlzpAgcl3BEYTBTvf6bZuVyqNsH8FR3HZrgwlCDRgs8Ourt3VIu6vYT8gP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aXH0hAzy; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so13928a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2024 08:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721402878; x=1722007678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/MxYH2/uzCcS4HqNETSoYIUh519YogSSIkssubeOjA=;
        b=aXH0hAzy9WFcE/WsXnwIXUinFc2tYiWtF+sspx4k49z1wTp2JcuKgxXf0GYLSPZJFx
         NF5BtUWzep56Sd02nJ5x1UbJOOvMOoA+sZNL2Yh0GqbeEsxOO4pUWUDVI0BQM/ceY1aK
         5yU2xaoF4O9l6LUXiI2aJd8i3MKDrTETHo9dhDh2jL15QiXGv/j2uJdaTUyddb3AHIJk
         QBLNLlffWSlW8EF+zbegUQLlzbeKtPTTu6MKFUyBF/Jxe0qY4RJtCQsJOSCcyCrbq4gC
         0pNpa7nHWngnjSbjbIfuzWY1blUl5kvxMytHKc8Aah6axhpKhIJcXa82+YX4O7BBPWTJ
         zOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721402878; x=1722007678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/MxYH2/uzCcS4HqNETSoYIUh519YogSSIkssubeOjA=;
        b=vyULHUAx4HilhP/mSFaLMPpbklpjC2mR+248JMu5LqWVBPTfxaRK4mXXGWmjetfxEE
         XLB7mwwbYC0KQ79XKTKdRZecz7dC2yMAMVSvD8HtNo9ykB1+OENrqX1g79efilOIa9X0
         rwilVRS1uNH48nqAdFds8qGDiXeNSniCEGkRyPWVPSX1k65+zi5mdyu9HsS0j/hLTVIv
         elFBDtRyth0fHOR2GVv0an1Hn9AlbKexCiYAiGmTHdkEfLjt8XSxwLNDpfgQTk4kXCiz
         zYZBn2jOUCNO5wI2iT2GwOroOT73CcuJgFgU0GpVSYFlAmXWdptlNH90cNedgK/YgTlX
         Eu3g==
X-Forwarded-Encrypted: i=1; AJvYcCXxk6EXPdTUW2+s6pzx5v2oGEKNyOOpkgZCUgLgCECMyK/JJAmdyXeBUN6B6Dx8FgSoiFI3PhtMELBxl5Ao2rKO04P+0diX7AEHEONrVg==
X-Gm-Message-State: AOJu0Yz1g25vmcuhTU9M/U11n0nkQqhaKoIpybPIi0LHCKbB85ee5KeW
	YYuJqQZ1VOd7tuBLEqElkEjf0hFZLdb7VLrWwtThubDjcTgixXYt1zWCXrnMLBkcYWWhcg+Bws0
	HEqtodBcgGKcHYRmqwKFFz8ChtlceclWhjTTB
X-Google-Smtp-Source: AGHT+IGSwc1Sbm2gtpC0SvLJW7tBA/sZMi1xLeY6EhseEA9RMcDEKQHymOTelOQ90KNEQFpSSZW3FvOrxTA1Y9I1PzU=
X-Received: by 2002:a05:6402:50c9:b0:57c:c5e2:2c37 with SMTP id
 4fb4d7f45d1cf-5a2f262b220mr178043a12.3.1721402878011; Fri, 19 Jul 2024
 08:27:58 -0700 (PDT)
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
 <20240719.shaeK6PaiSie@digikod.net> <CALmYWFsd-=pOPZZmiKvYJ8pOhACsTvW_d+pRjG_C4jD6+Li0AQ@mail.gmail.com>
 <20240719.sah7oeY9pha4@digikod.net>
In-Reply-To: <20240719.sah7oeY9pha4@digikod.net>
From: Jeff Xu <jeffxu@google.com>
Date: Fri, 19 Jul 2024 08:27:18 -0700
Message-ID: <CALmYWFsAZjU5sMcXTT23Mtw2Y30ewc94FAjKsnuSv1Ex=7fgLQ@mail.gmail.com>
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

On Fri, Jul 19, 2024 at 8:04=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> On Fri, Jul 19, 2024 at 07:16:55AM -0700, Jeff Xu wrote:
> > On Fri, Jul 19, 2024 at 1:45=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > >
> > > On Thu, Jul 18, 2024 at 06:29:54PM -0700, Jeff Xu wrote:
> > > > On Thu, Jul 18, 2024 at 5:24=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <m=
ic@digikod.net> wrote:
> > > > >
> > > > > On Wed, Jul 17, 2024 at 07:08:17PM -0700, Jeff Xu wrote:
> > > > > > On Wed, Jul 17, 2024 at 3:01=E2=80=AFAM Micka=C3=ABl Sala=C3=BC=
n <mic@digikod.net> wrote:
> > > > > > >
> > > > > > > On Tue, Jul 16, 2024 at 11:33:55PM -0700, Jeff Xu wrote:
> > > > > > > > On Thu, Jul 4, 2024 at 12:02=E2=80=AFPM Micka=C3=ABl Sala=
=C3=BCn <mic@digikod.net> wrote:
> > > > > > > > >
> > > > > > > > > Add a new AT_CHECK flag to execveat(2) to check if a file=
 would be
> > > > > > > > > allowed for execution.  The main use case is for script i=
nterpreters and
> > > > > > > > > dynamic linkers to check execution permission according t=
o the kernel's
> > > > > > > > > security policy. Another use case is to add context to ac=
cess logs e.g.,
> > > > > > > > > which script (instead of interpreter) accessed a file.  A=
s any
> > > > > > > > > executable code, scripts could also use this check [1].
> > > > > > > > >
> > > > > > > > > This is different than faccessat(2) which only checks fil=
e access
> > > > > > > > > rights, but not the full context e.g. mount point's noexe=
c, stack limit,
> > > > > > > > > and all potential LSM extra checks (e.g. argv, envp, cred=
entials).
> > > > > > > > > Since the use of AT_CHECK follows the exact kernel semant=
ic as for a
> > > > > > > > > real execution, user space gets the same error codes.
> > > > > > > > >
> > > > > > > > So we concluded that execveat(AT_CHECK) will be used to che=
ck the
> > > > > > > > exec, shared object, script and config file (such as seccom=
p config),
> > >
> > > > > > > > I think binfmt_elf.c in the kernel needs to check the ld.so=
 to make
> > > > > > > > sure it passes AT_CHECK, before loading it into memory.
> > > > > > >
> > > > > > > All ELF dependencies are opened and checked with open_exec(),=
 which
> > > > > > > perform the main executability checks (with the __FMODE_EXEC =
flag).
> > > > > > > Did I miss something?
> > > > > > >
> > > > > > I mean the ld-linux-x86-64.so.2 which is loaded by binfmt in th=
e kernel.
> > > > > > The app can choose its own dynamic linker path during build, (m=
aybe
> > > > > > even statically link one ?)  This is another reason that relyin=
g on a
> > > > > > userspace only is not enough.
> > > > >
> > > > > The kernel calls open_exec() on all dependencies, including
> > > > > ld-linux-x86-64.so.2, so these files are checked for executabilit=
y too.
> > > > >
> > > > This might not be entirely true. iiuc, kernel  calls open_exec for
> > > > open_exec for interpreter, but not all its dependency (e.g. libc.so=
.6)
> > >
> > > Correct, the dynamic linker is in charge of that, which is why it mus=
t
> > > be enlighten with execveat+AT_CHECK and securebits checks.
> > >
> > > > load_elf_binary() {
> > > >    interpreter =3D open_exec(elf_interpreter);
> > > > }
> > > >
> > > > libc.so.6 is opened and mapped by dynamic linker.
> > > > so the call sequence is:
> > > >  execve(a.out)
> > > >   - open exec(a.out)
> > > >   - security_bprm_creds(a.out)
> > > >   - open the exec(ld.so)
> > > >   - call open_exec() for interruptor (ld.so)
> > > >   - call execveat(AT_CHECK, ld.so) <-- do we want ld.so going throu=
gh
> > > > the same check and code path as libc.so below ?
> > >
> > > open_exec() checks are enough.  LSMs can use this information (open +
> > > __FMODE_EXEC) if needed.  execveat+AT_CHECK is only a user space
> > > request.
> > >
> > Then the ld.so doesn't go through the same security_bprm_creds() check
> > as other .so.
>
> Indeed, but...
>
My point is: we will want all the .so going through the same code
path, so  security_ functions are called consistently across all the
objects, And in the future, if we want to develop additional LSM
functionality based on AT_CHECK, it will be applied to all objects.

Another thing to consider is:  we are asking userspace to make
additional syscall before  loading the file into memory/get executed,
there is a possibility for future expansion of the mechanism, without
asking user space to add another syscall again.

I m still not convinced yet that execveat(AT_CHECK) fits more than
faccessat(AT_CHECK)


> >
> > As my previous email, the ChromeOS LSM restricts executable mfd
> > through security_bprm_creds(), the end result is that ld.so can still
> > be executable memfd, but not other .so.
>
> The chromeOS LSM can check that with the security_file_open() hook and
> the __FMODE_EXEC flag, see Landlock's implementation.  I think this
> should be the only hook implementation that chromeOS LSM needs to add.
>
> >
> > One way to address this is to refactor the necessary code from
> > execveat() code patch, and make it available to call from both kernel
> > and execveat() code paths., but if we do that, we might as well use
> > faccessat2(AT_CHECK)
>
> That's why I think it makes sense to rely on the existing __FMODE_EXEC
> information.
>
> >
> >
> > > >   - transfer the control to ld.so)
> > > >   - ld.so open (libc.so)
> > > >   - ld.so call execveat(AT_CHECK,libc.so) <-- proposed by this patc=
h,
> > > > require dynamic linker change.
> > > >   - ld.so mmap(libc.so,rx)
> > >
> > > Explaining these steps is useful. I'll include that in the next patch
> > > series.

