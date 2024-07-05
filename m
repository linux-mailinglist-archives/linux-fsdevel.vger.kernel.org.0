Return-Path: <linux-fsdevel+bounces-23175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C84C927F3B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 02:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE0DA28503E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 00:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67ABE28E8;
	Fri,  5 Jul 2024 00:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwxgWt6e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF98118D;
	Fri,  5 Jul 2024 00:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720137844; cv=none; b=TAz2z4Bsq5q9HzBfpXoPmYT+EqFwwQLZYzJO66i3Qf34oOACR04xm18/XaEGv0TRrEAf6SPd9Hf831UxSGGn8uotfGxgibz1iA47r7CYhWQW3WcYm+ost+MNWW42K5zqNct28fzEm0K4lRMdTsUjvFMvQDJQx3+OTjSVW3ALK+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720137844; c=relaxed/simple;
	bh=J7bhqQDa0BUxtW8BlJTRiOi2E8hGXU59gEoA5xrhETw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5AxIo66W/6guvW+V6hZaaiD4j4XbJrm1xkrEMXldU73z35lFt+0HqiaKqFkTJ4N0NSMr81SsvCO+qT7CmPdLz4g3h3oq8G0CZm3XXNXtf+C5mAwYaGe5d5p6Y8G4PsXWlRx92csZoToSgTHrNcp6KVEsFqKJzoehO7ODBe5UAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwxgWt6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344CCC3277B;
	Fri,  5 Jul 2024 00:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720137844;
	bh=J7bhqQDa0BUxtW8BlJTRiOi2E8hGXU59gEoA5xrhETw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QwxgWt6e+wmGcibU5BE9IGwyJ4Ql3BSpfzKyEgTyirg+SQT9/pX4Pbu8UeDYHXa3K
	 bHcDIbIy8282ubQCTG9RVf8z2BGj3FJkZv1Z5ATlXNPP4S5Hj7BxwI8vbhVnkFL0Tx
	 kZBGrQuAlC1f7G/57v67ZbKuhv6zmsOYCwAXaGhC77Ia5xlgbgXLRdK7OtUTiG7QYZ
	 Th61o/0wqsZYUJcM88zyb4v6pCvUUSGQkwLq2+dfniroCXLoUsWoYOK8ODTz+C4iYy
	 Wx60WNHoQrnOecRvGhfjG4Z58ujW9QM9yxO5bxrMd+7DCVBGzphEyXXx+UW8aIH827
	 WbHvQnbiTuXZw==
Date: Thu, 4 Jul 2024 17:04:03 -0700
From: Kees Cook <kees@kernel.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>, Theodore Ts'o <tytso@mit.edu>,
	Alejandro Colomar <alx.manpages@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Christian Heimes <christian@python.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Eric Chiang <ericchiang@google.com>,
	Fan Wu <wufan@linux.microsoft.com>,
	Florian Weimer <fweimer@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	James Morris <jamorris@linux.microsoft.com>,
	Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Jordan R Abrahams <ajordanr@google.com>,
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
	Luca Boccassi <bluca@debian.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Matthew Wilcox <willy@infradead.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	Scott Shell <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Steve Dower <steve.dower@python.org>,
	Steve Grubb <sgrubb@redhat.com>,
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
	Xiaoming Ni <nixiaoming@huawei.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v19 1/5] exec: Add a new AT_CHECK flag to execveat(2)
Message-ID: <202407041656.3A05153@keescook>
References: <20240704190137.696169-1-mic@digikod.net>
 <20240704190137.696169-2-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240704190137.696169-2-mic@digikod.net>

On Thu, Jul 04, 2024 at 09:01:33PM +0200, Mickaël Salaün wrote:
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

Nice! I much prefer this method of going through the exec machinery so
we always have a single code path for these kinds of checks.

> Because AT_CHECK is dedicated to user space interpreters, it doesn't
> make sense for the kernel to parse the checked files, look for
> interpreters known to the kernel (e.g. ELF, shebang), and return ENOEXEC
> if the format is unknown.  Because of that, security_bprm_check() is
> never called when AT_CHECK is used.

I'd like some additional comments in the code that reminds us that
access control checks have finished past a certain point.

[...]
> diff --git a/fs/exec.c b/fs/exec.c
> index 40073142288f..ea2a1867afdc 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -931,7 +931,7 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
>  		.lookup_flags = LOOKUP_FOLLOW,
>  	};
>  
> -	if ((flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
> +	if ((flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH | AT_CHECK)) != 0)
>  		return ERR_PTR(-EINVAL);
>  	if (flags & AT_SYMLINK_NOFOLLOW)
>  		open_exec_flags.lookup_flags &= ~LOOKUP_FOLLOW;
[...]
> + * To avoid race conditions leading to time-of-check to time-of-use issues,
> + * AT_CHECK should be used with AT_EMPTY_PATH to check against a file
> + * descriptor instead of a path.

I want this enforced by the kernel. Let's not leave trivial ToCToU
foot-guns around. i.e.:

	if ((flags & AT_CHECK) == AT_CHECK && (flags & AT_EMPTY_PATH) == 0)
  		return ERR_PTR(-EBADF);

-- 
Kees Cook

