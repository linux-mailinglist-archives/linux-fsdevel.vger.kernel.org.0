Return-Path: <linux-fsdevel+bounces-39304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBE7A12755
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 16:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81E717A0F4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 15:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52011487C8;
	Wed, 15 Jan 2025 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="eftFZdAR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDE31465B3
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736954688; cv=none; b=ehfsYQQuMoqddwGMjFoo2vUIsDv2LmvYLv/zsoZCBIselmua1/5OnY9TMRJCD22c3OFmaggABkVddU5tdU8jm6alONwozOWlOlHc6lzKauG33n5tHX4yJ67MOVzCy5hg9T7kPeDbSOnYob+DttfvMQlr0GL/Uf2M265gBCjs8iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736954688; c=relaxed/simple;
	bh=kOY3vFWLP+FEHx5M1IiPDdVvOJzmSd4CLBlalrm5bTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0NWar+ErADiigJZrjFHDbh9b6yY3rkYyt/ykF2Q9Rkab8uk3w/Eqztza8GZtqV5Y3+iz02Y9RxvRJzYSQMz6lGBNcN+w6D5TshFTTbQQ7o/YcGBNGddq8uedGODh3owglI2vtTs+9ywAX3OdfKI5cvdeldEUvRMA33sTdZLauE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=eftFZdAR; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YY8td4YsHzVMr;
	Wed, 15 Jan 2025 16:24:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736954681;
	bh=OKke/r7WO2oX+n3KadtktTVK+uXU2ESxGj2KaHjaNJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eftFZdARawb0lOmamDXKZ8GxSfXruL53Rhh7T90IwPVKUPGqVjddobOiO6hqNVNqE
	 Mo8zFpDcn703TYsLDqeqKTtpk0O9kvmY2ktGgmx5C+vmNV29VYZ/6kCS47gFFUauLS
	 iFQPjWpppKW7Ye7YBY0wqf3aD1EfkI6wP8zJUKEs=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YY8tV0cZGzCXZ;
	Wed, 15 Jan 2025 16:24:34 +0100 (CET)
Date: Wed, 15 Jan 2025 16:24:33 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <serge@hallyn.com>, 
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
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Scott Shell <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, Theodore Ts'o <tytso@mit.edu>, 
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, Vincent Strubel <vincent.strubel@ssi.gouv.fr>, 
	Xiaoming Ni <nixiaoming@huawei.com>, kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v23 7/8] samples/check-exec: Add an enlighten "inc"
 interpreter and 28 tests
Message-ID: <20250115.asu4ueXao3ho@digikod.net>
References: <20241212174223.389435-1-mic@digikod.net>
 <20241212174223.389435-8-mic@digikod.net>
 <20250114205645.GA2825031@ax162>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250114205645.GA2825031@ax162>
X-Infomaniak-Routing: alpha

On Tue, Jan 14, 2025 at 01:56:45PM -0700, Nathan Chancellor wrote:
> Hi Mickaël,
> 
> On Thu, Dec 12, 2024 at 06:42:22PM +0100, Mickaël Salaün wrote:
> > Add a very simple script interpreter called "inc" that can evaluate two
> > different commands (one per line):
> > - "?" to initialize a counter from user's input;
> > - "+" to increment the counter (which is set to 0 by default).
> > 
> > It is enlighten to only interpret executable files according to
> > AT_EXECVE_CHECK and the related securebits:
> > 
> >   # Executing a script with RESTRICT_FILE is only allowed if the script
> >   # is executable:
> >   ./set-exec -f -- ./inc script-exec.inc # Allowed
> >   ./set-exec -f -- ./inc script-noexec.inc # Denied
> > 
> >   # Executing stdin with DENY_INTERACTIVE is only allowed if stdin is an
> >   # executable regular file:
> >   ./set-exec -i -- ./inc -i < script-exec.inc # Allowed
> >   ./set-exec -i -- ./inc -i < script-noexec.inc # Denied
> > 
> >   # However, a pipe is not executable and it is then denied:
> >   cat script-noexec.inc | ./set-exec -i -- ./inc -i # Denied
> > 
> >   # Executing raw data (e.g. command argument) with DENY_INTERACTIVE is
> >   # always denied.
> >   ./set-exec -i -- ./inc -c "+" # Denied
> >   ./inc -c "$(<script-ask.inc)" # Allowed
> > 
> >   # To directly execute a script, we can update $PATH (used by `env`):
> >   PATH="${PATH}:." ./script-exec.inc
> > 
> >   # To execute several commands passed as argument:
> > 
> > Add a complete test suite to check the script interpreter against all
> > possible execution cases:
> > 
> >   make TARGETS=exec kselftest-install
> >   ./tools/testing/selftests/kselftest_install/run_kselftest.sh
> > 
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: Serge Hallyn <serge@hallyn.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > Link: https://lore.kernel.org/r/20241212174223.389435-8-mic@digikod.net
> ...
> > diff --git a/samples/check-exec/inc.c b/samples/check-exec/inc.c
> > new file mode 100644
> > index 000000000000..94b87569d2a2
> > --- /dev/null
> > +++ b/samples/check-exec/inc.c
> ...
> > +/* Returns 1 on error, 0 otherwise. */
> > +static int interpret_stream(FILE *script, char *const script_name,
> > +			    char *const *const envp, const bool restrict_stream)
> > +{
> > +	int err;
> > +	char *const script_argv[] = { script_name, NULL };
> > +	char buf[128] = {};
> > +	size_t buf_size = sizeof(buf);
> > +
> > +	/*
> > +	 * We pass a valid argv and envp to the kernel to emulate a native
> > +	 * script execution.  We must use the script file descriptor instead of
> > +	 * the script path name to avoid race conditions.
> > +	 */
> > +	err = execveat(fileno(script), "", script_argv, envp,
> > +		       AT_EMPTY_PATH | AT_EXECVE_CHECK);
> > +	if (err && restrict_stream) {
> > +		perror("ERROR: Script execution check");
> > +		return 1;
> > +	}
> > +
> > +	/* Reads script. */
> > +	buf_size = fread(buf, 1, buf_size - 1, script);
> > +	return interpret_buffer(buf, buf_size);
> > +}
> 
> The use of execveat() in this test case breaks the build when glibc is
> less than 2.34, as that is the earliest version that has the execveat()
> wrapper:
> 
> https://sourceware.org/git/?p=glibc.git;a=commit;h=19d83270fcd993cc349570164e21b06d57036704
> 
>   $ ldd --version | head -1
>   ldd (Debian GLIBC 2.31-13+deb11u11) 2.31
> 
>   $ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- mrproper allmodconfig samples/
>   ...
>   samples/check-exec/inc.c:81:8: error: call to undeclared function 'execveat'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>      81 |         err = execveat(fileno(script), "", script_argv, envp,
>         |               ^
>   samples/check-exec/inc.c:81:8: note: did you mean 'execve'?
>   /usr/include/unistd.h:551:12: note: 'execve' declared here
>     551 | extern int execve (const char *__path, char *const __argv[],
>         |            ^
>   1 error generated.
>   ...
> 
> Should this just use the syscall directly?

Thanks for the report, I sent a fix:
https://lore.kernel.org/r/20250115144753.311152-1-mic@digikod.net

> 
> Cheers,
> Nathan

