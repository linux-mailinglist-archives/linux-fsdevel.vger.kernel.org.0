Return-Path: <linux-fsdevel+bounces-23986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1367937205
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 03:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D52481C20F44
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 01:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7053257D;
	Fri, 19 Jul 2024 01:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WA2lLZYw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A306D15D1
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2024 01:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721352638; cv=none; b=Gu383puewJVW223+HaIQVuDzLNmDvKx+UUng4iQ+IMLBWsqhxrwZazPr0W6cBvGUYRCrN6pgugdgVfYn8DtTbzeMVo2hyIEtStKbgfmbkOk5YqqJ1uGXlx9NioupNzE6REkxG49eaNk5jDiAXQywvkwZU+Swd9nEe3MSmbXAIFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721352638; c=relaxed/simple;
	bh=lVeo2b3ZL9yUF8vqBnW3SHS/SJn7ZNntOcEf68iSs1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oNOWqj0zdRQ7AbY3Rai6mmeMY8gmhtA+0d3jTE68dNSXW5uW9lyCvQp6pSaal8pJvpHObv5ME/hXAHS6idYYgP1U+C/Q6DfyNeZ7iW+/U+it8yCMu4GDxXE0sHLCRwmZRQd7iR5z6kj9989SnNuToPfVoJ8DFJB5zxYK3K4ok1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WA2lLZYw; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso9839a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 18:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721352634; x=1721957434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/75dPOajlVDrCBVLC7N50C4sUWkx4B0lwNFzxYSOReQ=;
        b=WA2lLZYwUP+ieQcc9NYbjz6eUErN4dapjOZocQjnKaimQjkGvu/WNfL9T1r6wi0Jgo
         1hQO3ImHucgAAEZVCpoRefXBYbF0V5303x1P6vP03zOZcTOWBT2Bx9vlhCVR0aQNm5ru
         tBYZyCgvwqWUJUtJDtwzqzLDpJWTuFlutzwtDXyNgIOicTgFJgk9exE8glRkqQ8jlyLl
         +9DH3Fs/qEcCAC2KgTyziIJVpomGnzA72jUSe6iINRVrBB66wO2cO5QnjDuBxD/UVa/d
         X7G/+HO+jn2fzSYr48C90DVzmyHLfoe+RkrY42zvrxTRwUruBrOhLDDiAvTmR6+aFFGg
         7BOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721352634; x=1721957434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/75dPOajlVDrCBVLC7N50C4sUWkx4B0lwNFzxYSOReQ=;
        b=BlYjVfdcUVV5NMwsivqSVJc4a6ySiPS7/2cog1TChWS/Q3MsGrhBhKi3s4ykyTs648
         LgRHhjskwDlmKvG7hjx8gyGx9/orOat9+CuuThCo7UL9SwmFQf2w6bv2lVAlwtvWg9MM
         5R5xQwYq1H3UpVsf22927HU4h5hX226cLOICdOnJflj3t7jWUz3Xs1Of/AriFHdEE4P0
         GYU2eChapEoi/FsMUq0MVbGPztEZ0VZVOuDP7F/2bkGqPHZq2lwfyv1yzb2mIxNfUj5u
         LcAD0J3HRPvh7ORUW5BFIlBzxaNvwUx0sLNMapKh0fQ/fzhk9iN8WqxNoI72rr054U/d
         D07Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmLqJZQCUwVjped5MARlmKZz+ExEAeeMlQWj1WeRaZ8GUW7Uyl2dtun2XyQHCKQaXE5zwZ+/+OeAtbpelOzq3SdtqKN/I8DIp/RvjTsQ==
X-Gm-Message-State: AOJu0YwZGco1912MMKeysnpKeOaitR+XadH5a0nXw8VUvhZIqpv4ly3S
	LyvmmGCNzqJIrmAfJmSvHJhX8DlEohULSj2dEpF9hSx4MfEjpEMFEIxQMt/8RRbhSramHHeuP0l
	QYPoGqdRSRlZFATE853OcrZIkUhaP6+o6J98w
X-Google-Smtp-Source: AGHT+IFBadWTvWgwIQR+TysU2KHcsnhD2OsYMLEgfGriYZ5n5XNN5twGyKji/Wkg+DNoRKKB4qhk9m/xKGrRn9xjVr0=
X-Received: by 2002:a05:6402:50ca:b0:57c:c3a7:dab6 with SMTP id
 4fb4d7f45d1cf-5a2f26335acmr55450a12.3.1721352633181; Thu, 18 Jul 2024
 18:30:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704190137.696169-1-mic@digikod.net> <20240704190137.696169-2-mic@digikod.net>
 <CALmYWFss7qcpR9D_r3pbP_Orxs55t3y3yXJsac1Wz=Hk9Di0Nw@mail.gmail.com>
 <20240717.neaB5Aiy2zah@digikod.net> <CALmYWFt=yXpzhS=HS9FjwVMvx6U1MoR31vK79wxNLhmJm9bBoA@mail.gmail.com>
 <20240718.kaePhei9Ahm9@digikod.net>
In-Reply-To: <20240718.kaePhei9Ahm9@digikod.net>
From: Jeff Xu <jeffxu@google.com>
Date: Thu, 18 Jul 2024 18:29:54 -0700
Message-ID: <CALmYWFto4sw-Q2+J0Gc54POhnM9C8YpnJ44wMz=fd_K3_+dWmw@mail.gmail.com>
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

On Thu, Jul 18, 2024 at 5:24=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> On Wed, Jul 17, 2024 at 07:08:17PM -0700, Jeff Xu wrote:
> > On Wed, Jul 17, 2024 at 3:01=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > >
> > > On Tue, Jul 16, 2024 at 11:33:55PM -0700, Jeff Xu wrote:
> > > > On Thu, Jul 4, 2024 at 12:02=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <m=
ic@digikod.net> wrote:
> > > > >
> > > > > Add a new AT_CHECK flag to execveat(2) to check if a file would b=
e
> > > > > allowed for execution.  The main use case is for script interpret=
ers and
> > > > > dynamic linkers to check execution permission according to the ke=
rnel's
> > > > > security policy. Another use case is to add context to access log=
s e.g.,
> > > > > which script (instead of interpreter) accessed a file.  As any
> > > > > executable code, scripts could also use this check [1].
> > > > >
> > > > > This is different than faccessat(2) which only checks file access
> > > > > rights, but not the full context e.g. mount point's noexec, stack=
 limit,
> > > > > and all potential LSM extra checks (e.g. argv, envp, credentials)=
.
> > > > > Since the use of AT_CHECK follows the exact kernel semantic as fo=
r a
> > > > > real execution, user space gets the same error codes.
> > > > >
> > > > So we concluded that execveat(AT_CHECK) will be used to check the
> > > > exec, shared object, script and config file (such as seccomp config=
),
> > >
> > > "config file" that contains executable code.
> > >
> > Is seccomp config  considered as "contains executable code", seccomp
> > config is translated into bpf, so maybe yes ? but bpf is running in
> > the kernel.
>
> Because seccomp filters alter syscalls, they are similar to code
> injection.
>
that makes sense.

> >
> > > > I'm still thinking  execveat(AT_CHECK) vs faccessat(AT_CHECK) in
> > > > different use cases:
> > > >
> > > > execveat clearly has less code change, but that also means: we can'=
t
> > > > add logic specific to exec (i.e. logic that can't be applied to
> > > > config) for this part (from do_execveat_common to
> > > > security_bprm_creds_for_exec) in future.  This would require some
> > > > agreement/sign-off, I'm not sure from whom.
> > >
> > > I'm not sure to follow. We could still add new flags, but for now I
> > > don't see use cases.  This patch series is not meant to handle all
> > > possible "trust checks", only executable code, which makes sense for =
the
> > > kernel.
> > >
> > I guess the "configfile" discussion is where I get confused, at one
> > point, I think this would become a generic "trust checks" api for
> > everything related to "generating executable code", e.g. javascript,
> > java code, and more.
> > We will want to clearly define the scope of execveat(AT_CHECK)
>
> The line between data and code is blurry.  For instance, a configuration
> file can impact the execution flow of a program.  So, where to draw the
> line?
>
> It might makes sense to follow the kernel and interpreter semantic: if a
> file can be executed by the kernel (e.g. ELF binary, file containing a
> shebang, or just configured with binfmt_misc), then this should be
> considered as executable code.  This applies to Bash, Python,
> Javascript, NodeJS, PE, PHP...  However, we can also make a picture
> executable with binfmt_misc.  So, again, where to draw the line?
>
> I'd recommend to think about interaction with the outside, through
> function calls, IPCs, syscalls...  For instance, "running" an image
> should not lead to reading or writing to arbitrary files, or accessing
> the network, but in practice it is legitimate for some file formats...
> PostScript is a programming language, but mostly used to draw pictures.
> So, again, where to draw the line?
>
> We should follow the principle of least astonishment.  What most users
> would expect?  This should follow the *common usage* of executable
> files.  At the end, the script interpreters will be patched by security
> folks for security reasons.  I think the right question to ask should
> be: could this file format be (ab)used to leak or modify arbitrary
> files, or to perform arbitrary syscalls?  If the answer is yes, then it
> should be checked for executability.  Of course, this excludes bugs
> exploited in the file format parser.
>
> I'll extend the next patch series with this rationale.
>
> >
> > > If we want other checks, we'll need to clearly define their semantic =
and
> > > align with the kernel.  faccessat2(2) might be used to check other fi=
le
> > > properties, but the executable property is not only defined by the fi=
le
> > > attributes.
> > >
> > Agreed.
> >
> > > >
> > > > --------------------------
> > > > now looked at user cases (focus on elf for now)
> > > >
> > > > 1> ld.so /tmp/a.out, /tmp/a.out is on non-exec mount
> > > > dynamic linker will first call execveat(fd, AT_CHECK) then execveat=
(fd)
> > > >
> > > > 2> execve(/usr/bin/some.out) and some.out has dependency on /tmp/a.=
so
> > > > /usr/bin/some.out will pass AT_CHECK
> > > >
> > > > 3> execve(usr/bin/some.out) and some.out uses custom /tmp/ld.so
> > > > /usr/bin/some.out will pass AT_CHECK, however, it uses a custom
> > > > /tmp/ld.so (I assume this is possible  for elf header will set the
> > > > path for ld.so because kernel has no knowledge of that, and
> > > > binfmt_elf.c allocate memory for ld.so during execveat call)
> > > >
> > > > 4> dlopen(/tmp/a.so)
> > > > I assume dynamic linker will call execveat(AT_CHECK), before map a.=
so
> > > > into memory.
> > > >
> > > > For case 1>
> > > > Alternative solution: Because AT_CHECK is always called, I think we
> > > > can avoid the first AT_CHECK call, and check during execveat(fd),
> > >
> > > There is no need to use AT_CHECK if we're going to call execveat(2) o=
n
> > > the same file descriptor.  By design, AT_CHECK is implicit for any
> > > execve(2).
> > >
> > Yes. I realized I was wrong to say that ld.so will call execve() for
> > /tmp/a.out, there is no execve() call, otherwise it would have been
> > blocked already today.
> > The ld.so will  mmap the /tmp/a.out directly.  So case 1 is no
> > different than case 2 and 4.  ( the elf objects are mapped to memory
> > by dynamic linker.)
> > I'm not familiar with dynamic linker, Florian is on this thread, and
> > can help to correct me if my guess is wrong.
> >
> > > > this means the kernel will enforce SECBIT_EXEC_RESTRICT_FILE =3D 1,=
 the
> > > > benefit is that there is no TOCTOU and save one round trip of sysca=
ll
> > > > for a succesful execveat() case.
> > >
> > > As long as user space uses the same file descriptor, there is no TOCT=
OU.
> > >
> > > SECBIT_EXEC_RESTRICT_FILE only makes sense for user space: it defines
> > > the user space security policy.  The kernel already enforces the same
> > > security policy for any execve(2), whatever are the calling process's
> > > securebits.
> > >
> > > >
> > > > For case 2>
> > > > dynamic linker will call execve(AT_CHECK), then mmap(fd) into memor=
y.
> > > > However,  the process can all open then mmap() directly, it seems
> > > > minimal effort for an attacker to walk around such a defence from
> > > > dynamic linker.
> > >
> > > Which process?  What do you mean by "can all open then mmap() directl=
y"?
> > >
> > > In this context the dynamic linker (like its parent processes) is
> > > trusted (guaranteed by the system).
> > >
> > > For case 2, the dynamic linker must check with AT_CHECK all files tha=
t
> > > will be mapped, which include /usr/bin/some.out and /tmp/a.so
> > >
> > My point is that the process can work around this by mmap() the file di=
rectly.
>
> Yes, see my answer in the other email. The process is trusted.
>
OK. Let's agree that this is out of scope for this patch series.

> >
> > > >
> > > > Alternative solution:
> > > > dynamic linker call AT_CHECK for each .so, kernel will save the sta=
te
> > > > (associated with fd)
> > > > kernel will check fd state at the time of mmap(fd, executable memor=
y)
> > > > and enforce SECBIT_EXEC_RESTRICT_FILE =3D 1
> > >
> > > The idea with AT_CHECK is that there is no kernel side effect, no ext=
ra
> > > kernel state, and the semantic is the same as with execve(2).
> > >
> > > This also enables us to check file's executable permission and ignore
> > > it, which is useful in a "permissive mode" when preparing for a
> > > migration without breaking a system, or to do extra integrity checks.
> > For preparing a migration (detect all violations), this is useful.
> > But as a defense mechanism (SECBIT_EXEC_RESTRICT_FILE =3D 1) , this
> > seems to be weak, at least for elf loading case.
>
> We could add more restrictions, but that is outside the scope of this
> patch series.
>
Agreed.

> >
> > > BTW, this use case would also be more complex with a new openat2(2) f=
lag
> > > like the original O_MAYEXEC.
> > >
> > > >
> > > > Alternative solution 2:
> > > > a new syscall to load the .so and enforce the AT_CHECK in kernel
> > >
> > > A new syscall would be overkill for this feature.  Please see Linus's
> > > comment.
> > >
> > maybe, I was thinking on how to prevent "/tmp/a.o" from getting mmap()
> > to executable memory.
>
> OK, this is another story.
>
> >
> > > >
> > > > This also means, for the solution to be complete, we might want to
> > > > block creation of executable anonymous memory (e.g. by seccomp, ),
> > >
> > > How seccomp could create anonymous memory in user space?
> > > seccomp filters should be treated (and checked with AT_CHECK) as
> > > executable code anyway.
> > >
> > > > unless the user space can harden the creation of  executable anonym=
ous
> > > > memory in some way.
> > >
> > > User space is already in charge of mmapping its own memory.  I don't =
see
> > > what is missing.
> > >
> > > >
> > > > For case 3>
> > > > I think binfmt_elf.c in the kernel needs to check the ld.so to make
> > > > sure it passes AT_CHECK, before loading it into memory.
> > >
> > > All ELF dependencies are opened and checked with open_exec(), which
> > > perform the main executability checks (with the __FMODE_EXEC flag).
> > > Did I miss something?
> > >
> > I mean the ld-linux-x86-64.so.2 which is loaded by binfmt in the kernel=
.
> > The app can choose its own dynamic linker path during build, (maybe
> > even statically link one ?)  This is another reason that relying on a
> > userspace only is not enough.
>
> The kernel calls open_exec() on all dependencies, including
> ld-linux-x86-64.so.2, so these files are checked for executability too.
>
This might not be entirely true. iiuc, kernel  calls open_exec for
open_exec for interpreter, but not all its dependency (e.g. libc.so.6)
load_elf_binary() {
   interpreter =3D open_exec(elf_interpreter);
}

libc.so.6 is opened and mapped by dynamic linker.
so the call sequence is:
 execve(a.out)
  - open exec(a.out)
  - security_bprm_creds(a.out)
  - open the exec(ld.so)
  - call open_exec() for interruptor (ld.so)
  - call execveat(AT_CHECK, ld.so) <-- do we want ld.so going through
the same check and code path as libc.so below ?
  - transfer the control to ld.so)
  - ld.so open (libc.so)
  - ld.so call execveat(AT_CHECK,libc.so) <-- proposed by this patch,
require dynamic linker change.
  - ld.so mmap(libc.so,rx)


> >
> > > However, we must be careful with programs using the (deprecated)
> > > uselib(2). They should also check with AT_CHECK because this syscall
> > > opens the shared library without __FMODE_EXEC (similar to a simple fi=
le
> > > open). See
> > > https://lore.kernel.org/all/CAHk-=3DwiUwRG7LuR=3Dz5sbkFVGQh+7qVB6_1NM=
0Ny9SVNL1Un4Sw@mail.gmail.com/
> > >
> > > >
> > > > For case 4>
> > > > same as case 2.
> > > >
> > > > Consider those cases: I think:
> > > > a> relying purely on userspace for enforcement does't seem to be
> > > > effective,  e.g. it is trivial  to call open(), then mmap() it into
> > > > executable memory.
> > >
> > > As Steve explained (and is also explained in the patches), it is triv=
ial
> > > if the attacker can already execute its own code, which is too late t=
o
> > > enforce any script execution control.
> > >
> > > > b> if both user space and kernel need to call AT_CHECK, the faccess=
at
> > > > seems to be a better place for AT_CHECK, e.g. kernel can call
> > > > do_faccessat(AT_CHECK) and userspace can call faccessat(). This wil=
l
> > > > avoid complicating the execveat() code path.
> > >
> > > A previous version of this patches series already patched faccessat(2=
),
> > > but this is not the right place.  faccessat2(2) is dedicated to check
> > > file permissions, not executability (e.g. with mount's noexec).
> > >
> > > >
> > > > What do you think ?
> > >
> > > I think there are some misunderstandings.  Please let me know if it's
> > > clearer now.
> > >
> > I'm still not sure about the user case for dynamic linker (elf
> > loading) case. Maybe this patch is more suitable for scripts?
>
> It's suitable for both, but we could add more restriction on mmap
> with an (existing) LSM.  The kernel already checks for mount's noexec
> when mapping a file, but not for the file permission, which is OK
> because it could be bypassed by coping the content of the file and
> mprotecting it anyway.  For a consistent memory execution control, all
> memory mapping need to be restricted, which is out of scope for this
> patch series.
>
Ok.

> > A detailed user case will help demonstrate the use case for dynamic
> > linker, e.g. what kind of app will benefit from
> > SECBIT_EXEC_RESTRICT_FILE =3D 1, what kind of threat model are we
> > dealing with , what kind of attack chain we blocked as a result.
>
> I explained that in the patches and in the description of these new
> securebits.  Please point which part is not clear.  The full threat
> model is simple: the TCB includes the kernel and system's files, which
> are integrity-protected, but we don't trust arbitrary data/scripts that
> can be written to user-owned files or directly provided to script
> interpreters.  As for the ptrace restrictions, the dynamic linker
> restrictions helps to avoid trivial bypasses (e.g. with LD_PRELOAD)
> with consistent executability checks.
>
On elf loading case, I'm clear after your last email. However, I'm not
sure if everyone else follows,  I will try to summarize here:
- Problem:  ld.so /tmp/a.out will happily pass, even /tmp/a.out is
mounted as non-exec.
  Solution: ld.so call execveat(AT_CHECK) for a.out before mmap a.out
into memory.

- Problem: a poorly built application (a.out) can have a dependency on
/tmp/a.o, when /tmp/a.o is on non-exec mount,
  Solution: ld.so call execveat(AT_CHECK) for a.o, before mmap a.o into mem=
ory.

- Problem: application can call mmap (/tmp/a.out, rx), where /tmp is
on non-exec mount
  This is out of scope, i.e. will require enforcement on mmap(), maybe
through LSM

Thanks
Best regards
-Jeff

-Jeff


> >
> > > >
> > > > Thanks
> > > > -Jeff
> > > >
> > > > > With the information that a script interpreter is about to interp=
ret a
> > > > > script, an LSM security policy can adjust caller's access rights =
or log
> > > > > execution request as for native script execution (e.g. role trans=
ition).
> > > > > This is possible thanks to the call to security_bprm_creds_for_ex=
ec().
> > > > >
> > > > > Because LSMs may only change bprm's credentials, use of AT_CHECK =
with
> > > > > current kernel code should not be a security issue (e.g. unexpect=
ed role
> > > > > transition).  LSMs willing to update the caller's credential coul=
d now
> > > > > do so when bprm->is_check is set.  Of course, such policy change =
should
> > > > > be in line with the new user space code.
> > > > >
> > > > > Because AT_CHECK is dedicated to user space interpreters, it does=
n't
> > > > > make sense for the kernel to parse the checked files, look for
> > > > > interpreters known to the kernel (e.g. ELF, shebang), and return =
ENOEXEC
> > > > > if the format is unknown.  Because of that, security_bprm_check()=
 is
> > > > > never called when AT_CHECK is used.
> > > > >
> > > > > It should be noted that script interpreters cannot directly use
> > > > > execveat(2) (without this new AT_CHECK flag) because this could l=
ead to
> > > > > unexpected behaviors e.g., `python script.sh` could lead to Bash =
being
> > > > > executed to interpret the script.  Unlike the kernel, script
> > > > > interpreters may just interpret the shebang as a simple comment, =
which
> > > > > should not change for backward compatibility reasons.
> > > > >
> > > > > Because scripts or libraries files might not currently have the
> > > > > executable permission set, or because we might want specific user=
s to be
> > > > > allowed to run arbitrary scripts, the following patch provides a =
dynamic
> > > > > configuration mechanism with the SECBIT_SHOULD_EXEC_CHECK and
> > > > > SECBIT_SHOULD_EXEC_RESTRICT securebits.
> > > > >
> > > > > This is a redesign of the CLIP OS 4's O_MAYEXEC:
> > > > > https://github.com/clipos-archive/src_platform_clip-patches/blob/=
f5cb330d6b684752e403b4e41b39f7004d88e561/1901_open_mayexec.patch
> > > > > This patch has been used for more than a decade with customized s=
cript
> > > > > interpreters.  Some examples can be found here:
> > > > > https://github.com/clipos-archive/clipos4_portage-overlay/search?=
q=3DO_MAYEXEC
> > > > >
> > > > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > > > Cc: Christian Brauner <brauner@kernel.org>
> > > > > Cc: Kees Cook <keescook@chromium.org>
> > > > > Cc: Paul Moore <paul@paul-moore.com>
> > > > > Link: https://docs.python.org/3/library/io.html#io.open_code [1]
> > > > > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > > > > Link: https://lore.kernel.org/r/20240704190137.696169-2-mic@digik=
od.net
> > > > > ---
> > > > >
> > > > > New design since v18:
> > > > > https://lore.kernel.org/r/20220104155024.48023-3-mic@digikod.net
> > > > > ---
> > > > >  fs/exec.c                  |  5 +++--
> > > > >  include/linux/binfmts.h    |  7 ++++++-
> > > > >  include/uapi/linux/fcntl.h | 30 ++++++++++++++++++++++++++++++
> > > > >  kernel/audit.h             |  1 +
> > > > >  kernel/auditsc.c           |  1 +
> > > > >  5 files changed, 41 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/fs/exec.c b/fs/exec.c
> > > > > index 40073142288f..ea2a1867afdc 100644
> > > > > --- a/fs/exec.c
> > > > > +++ b/fs/exec.c
> > > > > @@ -931,7 +931,7 @@ static struct file *do_open_execat(int fd, st=
ruct filename *name, int flags)
> > > > >                 .lookup_flags =3D LOOKUP_FOLLOW,
> > > > >         };
> > > > >
> > > > > -       if ((flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) !=3D=
 0)
> > > > > +       if ((flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH | AT_C=
HECK)) !=3D 0)
> > > > >                 return ERR_PTR(-EINVAL);
> > > > >         if (flags & AT_SYMLINK_NOFOLLOW)
> > > > >                 open_exec_flags.lookup_flags &=3D ~LOOKUP_FOLLOW;
> > > > > @@ -1595,6 +1595,7 @@ static struct linux_binprm *alloc_bprm(int =
fd, struct filename *filename, int fl
> > > > >                 bprm->filename =3D bprm->fdpath;
> > > > >         }
> > > > >         bprm->interp =3D bprm->filename;
> > > > > +       bprm->is_check =3D !!(flags & AT_CHECK);
> > > > >
> > > > >         retval =3D bprm_mm_init(bprm);
> > > > >         if (!retval)
> > > > > @@ -1885,7 +1886,7 @@ static int bprm_execve(struct linux_binprm =
*bprm)
> > > > >
> > > > >         /* Set the unchanging part of bprm->cred */
> > > > >         retval =3D security_bprm_creds_for_exec(bprm);
> > > > > -       if (retval)
> > > > > +       if (retval || bprm->is_check)
> > > > >                 goto out;
> > > > >
> > > > >         retval =3D exec_binprm(bprm);
> > > > > diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> > > > > index 70f97f685bff..8ff9c9e33aed 100644
> > > > > --- a/include/linux/binfmts.h
> > > > > +++ b/include/linux/binfmts.h
> > > > > @@ -42,7 +42,12 @@ struct linux_binprm {
> > > > >                  * Set when errors can no longer be returned to t=
he
> > > > >                  * original userspace.
> > > > >                  */
> > > > > -               point_of_no_return:1;
> > > > > +               point_of_no_return:1,
> > > > > +               /*
> > > > > +                * Set by user space to check executability accor=
ding to the
> > > > > +                * caller's environment.
> > > > > +                */
> > > > > +               is_check:1;
> > > > >         struct file *executable; /* Executable to pass to the int=
erpreter */
> > > > >         struct file *interpreter;
> > > > >         struct file *file;
> > > > > diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcnt=
l.h
> > > > > index c0bcc185fa48..bcd05c59b7df 100644
> > > > > --- a/include/uapi/linux/fcntl.h
> > > > > +++ b/include/uapi/linux/fcntl.h
> > > > > @@ -118,6 +118,36 @@
> > > > >  #define AT_HANDLE_FID          AT_REMOVEDIR    /* file handle is=
 needed to
> > > > >                                         compare object identity a=
nd may not
> > > > >                                         be usable to open_by_hand=
le_at(2) */
> > > > > +
> > > > > +/*
> > > > > + * AT_CHECK only performs a check on a regular file and returns =
0 if execution
> > > > > + * of this file would be allowed, ignoring the file format and t=
hen the related
> > > > > + * interpreter dependencies (e.g. ELF libraries, script's sheban=
g).  AT_CHECK
> > > > > + * should only be used if SECBIT_SHOULD_EXEC_CHECK is set for th=
e calling
> > > > > + * thread.  See securebits.h documentation.
> > > > > + *
> > > > > + * Programs should use this check to apply kernel-level checks a=
gainst files
> > > > > + * that are not directly executed by the kernel but directly pas=
sed to a user
> > > > > + * space interpreter instead.  All files that contain executable=
 code, from the
> > > > > + * point of view of the interpreter, should be checked.  The mai=
n purpose of
> > > > > + * this flag is to improve the security and consistency of an ex=
ecution
> > > > > + * environment to ensure that direct file execution (e.g. ./scri=
pt.sh) and
> > > > > + * indirect file execution (e.g. sh script.sh) lead to the same =
result.  For
> > > > > + * instance, this can be used to check if a file is trustworthy =
according to
> > > > > + * the caller's environment.
> > > > > + *
> > > > > + * In a secure environment, libraries and any executable depende=
ncies should
> > > > > + * also be checked.  For instance dynamic linking should make su=
re that all
> > > > > + * libraries are allowed for execution to avoid trivial bypass (=
e.g. using
> > > > > + * LD_PRELOAD).  For such secure execution environment to make s=
ense, only
> > > > > + * trusted code should be executable, which also requires integr=
ity guarantees.
> > > > > + *
> > > > > + * To avoid race conditions leading to time-of-check to time-of-=
use issues,
> > > > > + * AT_CHECK should be used with AT_EMPTY_PATH to check against a=
 file
> > > > > + * descriptor instead of a path.
> > > > > + */
> > > > > +#define AT_CHECK               0x10000
> > > > > +
> > > > >  #if defined(__KERNEL__)
> > > > >  #define AT_GETATTR_NOSEC       0x80000000
> > > > >  #endif
> > > > > diff --git a/kernel/audit.h b/kernel/audit.h
> > > > > index a60d2840559e..8ebdabd2ab81 100644
> > > > > --- a/kernel/audit.h
> > > > > +++ b/kernel/audit.h
> > > > > @@ -197,6 +197,7 @@ struct audit_context {
> > > > >                 struct open_how openat2;
> > > > >                 struct {
> > > > >                         int                     argc;
> > > > > +                       bool                    is_check;
> > > > >                 } execve;
> > > > >                 struct {
> > > > >                         char                    *name;
> > > > > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > > > > index 6f0d6fb6523f..b6316e284342 100644
> > > > > --- a/kernel/auditsc.c
> > > > > +++ b/kernel/auditsc.c
> > > > > @@ -2662,6 +2662,7 @@ void __audit_bprm(struct linux_binprm *bprm=
)
> > > > >
> > > > >         context->type =3D AUDIT_EXECVE;
> > > > >         context->execve.argc =3D bprm->argc;
> > > > > +       context->execve.is_check =3D bprm->is_check;
> > > > >  }
> > > > >
> > > > >
> > > > > --
> > > > > 2.45.2
> > > > >
> > > >
> >

