Return-Path: <linux-fsdevel+bounces-24022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB119379EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 17:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28874B2182B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 15:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF52C145346;
	Fri, 19 Jul 2024 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="lB77K14i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0654145B01
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2024 15:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721403083; cv=none; b=TNxwipI1Z3RD85AL+rabrScfCtOn5IaYGjTaNqTZixwzmcShIAHz9lysavdyFkDbBfGcZHBaJZuBS5goPfvkxpG8B5H3a5z/XAZfY4K7wFDSHdoy1Jz6WZ/25inG5QRNJuFn3NGHaJ0tJzzqTXekiYMoNcG5TEFB302fDueeq7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721403083; c=relaxed/simple;
	bh=wd5RLE2IVNe8j0OkYgGaQ/CCPH8OsAp0/QhvVtCAKD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e65WjeFQcp50U5STpeQLDT/uQa/EDPRscBvMvNtMdPKmkyeAcI8tiAnMgf48hyvIlHBd8x3sbuDR5abGCKdwWEYv1Q1fhAxOFIHLeqCYpokebdSlo1sI+8C4qeAw99tbxX6YewA5uZ+h+nkOHTSGgZ2mSmjmjMAQ17FaXhwTuqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=lB77K14i; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WQYYD6S51zbQg;
	Fri, 19 Jul 2024 17:31:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721403072;
	bh=Un40jjD+8GvfPwjqSPOKrq30Me1og5PadVGfj4QH6kY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lB77K14iswxUkMLiWMQR/OqP1CUhz8X8GwZqB9CtcDBo75tvJfB77127QpOpNwBaP
	 7EoqwUR1lneJ3TlU7kjlL8eN4IRNJJmky2RERsSojlBt2Rhz1QmHm2yKFb3pIU++Wf
	 ukEouG+wAac+WvB8gW+E6zX5Jmw8sqmzYta1rvX4=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WQYY72PSTz667;
	Fri, 19 Jul 2024 17:31:07 +0200 (CEST)
Date: Fri, 19 Jul 2024 17:31:04 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jeff Xu <jeffxu@google.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Paul Moore <paul@paul-moore.com>, Theodore Ts'o <tytso@mit.edu>, 
	Alejandro Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Eric Chiang <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	James Morris <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
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
	linux-security-module@vger.kernel.org, Elliott Hughes <enh@google.com>
Subject: Re: [RFC PATCH v19 1/5] exec: Add a new AT_CHECK flag to execveat(2)
Message-ID: <20240719.Ooxeithah8Sh@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
 <20240704190137.696169-2-mic@digikod.net>
 <CALmYWFss7qcpR9D_r3pbP_Orxs55t3y3yXJsac1Wz=Hk9Di0Nw@mail.gmail.com>
 <20240717.neaB5Aiy2zah@digikod.net>
 <CALmYWFt=yXpzhS=HS9FjwVMvx6U1MoR31vK79wxNLhmJm9bBoA@mail.gmail.com>
 <20240718.kaePhei9Ahm9@digikod.net>
 <CALmYWFupWw2_BKu1FF=ooXFpA=GtJr1ehZSK3p+1+1WH34eX=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALmYWFupWw2_BKu1FF=ooXFpA=GtJr1ehZSK3p+1+1WH34eX=w@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Fri, Jul 19, 2024 at 08:12:37AM -0700, Jeff Xu wrote:
> On Thu, Jul 18, 2024 at 5:24 AM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > On Wed, Jul 17, 2024 at 07:08:17PM -0700, Jeff Xu wrote:
> > > On Wed, Jul 17, 2024 at 3:01 AM Mickaël Salaün <mic@digikod.net> wrote:
> > > >
> > > > On Tue, Jul 16, 2024 at 11:33:55PM -0700, Jeff Xu wrote:
> > > > > On Thu, Jul 4, 2024 at 12:02 PM Mickaël Salaün <mic@digikod.net> wrote:
> > > > > >
> > > > > > Add a new AT_CHECK flag to execveat(2) to check if a file would be
> > > > > > allowed for execution.  The main use case is for script interpreters and
> > > > > > dynamic linkers to check execution permission according to the kernel's
> > > > > > security policy. Another use case is to add context to access logs e.g.,
> > > > > > which script (instead of interpreter) accessed a file.  As any
> > > > > > executable code, scripts could also use this check [1].
> > > > > >
> > > > > > This is different than faccessat(2) which only checks file access
> > > > > > rights, but not the full context e.g. mount point's noexec, stack limit,
> > > > > > and all potential LSM extra checks (e.g. argv, envp, credentials).
> > > > > > Since the use of AT_CHECK follows the exact kernel semantic as for a
> > > > > > real execution, user space gets the same error codes.
> > > > > >
> > > > > So we concluded that execveat(AT_CHECK) will be used to check the
> > > > > exec, shared object, script and config file (such as seccomp config),
> > > >
> > > > "config file" that contains executable code.
> > > >
> > > Is seccomp config  considered as "contains executable code", seccomp
> > > config is translated into bpf, so maybe yes ? but bpf is running in
> > > the kernel.
> >
> > Because seccomp filters alter syscalls, they are similar to code
> > injection.
> >
> > >
> > > > > I'm still thinking  execveat(AT_CHECK) vs faccessat(AT_CHECK) in
> > > > > different use cases:
> > > > >
> > > > > execveat clearly has less code change, but that also means: we can't
> > > > > add logic specific to exec (i.e. logic that can't be applied to
> > > > > config) for this part (from do_execveat_common to
> > > > > security_bprm_creds_for_exec) in future.  This would require some
> > > > > agreement/sign-off, I'm not sure from whom.
> > > >
> > > > I'm not sure to follow. We could still add new flags, but for now I
> > > > don't see use cases.  This patch series is not meant to handle all
> > > > possible "trust checks", only executable code, which makes sense for the
> > > > kernel.
> > > >
> > > I guess the "configfile" discussion is where I get confused, at one
> > > point, I think this would become a generic "trust checks" api for
> > > everything related to "generating executable code", e.g. javascript,
> > > java code, and more.
> > > We will want to clearly define the scope of execveat(AT_CHECK)
> >
> > The line between data and code is blurry.  For instance, a configuration
> > file can impact the execution flow of a program.  So, where to draw the
> > line?
> >
> > It might makes sense to follow the kernel and interpreter semantic: if a
> > file can be executed by the kernel (e.g. ELF binary, file containing a
> > shebang, or just configured with binfmt_misc), then this should be
> > considered as executable code.  This applies to Bash, Python,
> > Javascript, NodeJS, PE, PHP...  However, we can also make a picture
> > executable with binfmt_misc.  So, again, where to draw the line?
> >
> > I'd recommend to think about interaction with the outside, through
> > function calls, IPCs, syscalls...  For instance, "running" an image
> > should not lead to reading or writing to arbitrary files, or accessing
> > the network, but in practice it is legitimate for some file formats...
> > PostScript is a programming language, but mostly used to draw pictures.
> > So, again, where to draw the line?
> >
> The javascript is run by browser and java code by java runtime, do
> they meet the criteria? they do not interact with the kernel directly,
> however they might have the same "executable" characteristics and the
> app might not want them to be put into non-exec mount.
> 
> If the answer is yes, they can also use execveat(AT_CHECK),  the next
> question is: does it make sense for javacript/java code to go through
> execveat() code path, allocate bprm, etc ? (I don't have answer, maybe
> it is)

Java and NodeJS can do arbitrary syscalls (through their runtime) and
they can access arbitrary files, so according to my below comment, yes
they should be managed as potentially dangerous executable code.

The question should be: is this code trusted? Most of the time it is
not, hence the security model of web browser and their heavy use of
sandboxing.  So no, I don't think it would make sense to check this kind
of code more than what the browser already do.

I'll talk about this use case in the next patch series.

> 
> > We should follow the principle of least astonishment.  What most users
> > would expect?  This should follow the *common usage* of executable
> > files.  At the end, the script interpreters will be patched by security
> > folks for security reasons.  I think the right question to ask should
> > be: could this file format be (ab)used to leak or modify arbitrary
> > files, or to perform arbitrary syscalls?  If the answer is yes, then it
> > should be checked for executability.  Of course, this excludes bugs
> > exploited in the file format parser.
> >
> > I'll extend the next patch series with this rationale.
> >
> 

