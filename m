Return-Path: <linux-fsdevel+bounces-59411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3149B388B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 19:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44991BA54C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 17:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C306A2BEC20;
	Wed, 27 Aug 2025 17:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxcM90Mr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF4721FF55
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 17:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756316142; cv=none; b=iv2U9sL/kX9Ud/FSsNR9LhrHSTS0reIb0UY98WWPn1vpUg9IQdInC4jmI5z/gdOefMf+2qR722DSjZ3Atqy5zckcyadmINkr6f1wshfMzLfrto8FoN40XTpP2KMZ94kwvFcMTCJD9/3wuId/XYkPb7ZxjQmjHcWsj5DYW8s6Ops=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756316142; c=relaxed/simple;
	bh=FIed+i9mU8QVyJwJUuYJhiPLw4w7Z4LZFu4tEeKK2tQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i1JbjopmvAOJtJHMrZ0wjzQPBDiiYcirGDHvlw29f85OinVm9UCprlVOu/YFn7IzFMkD1RDOxOncezz5vOom1o1ex3vFNVc+2g6i7L54tvYexOaXtWOJNZMV5k0dFLD/a2D34ik7EHLHy6JdafraiqKqeMIwJ00K/WFh2MUFz/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxcM90Mr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBA4C4CEEB
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 17:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756316142;
	bh=FIed+i9mU8QVyJwJUuYJhiPLw4w7Z4LZFu4tEeKK2tQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rxcM90Mr7RLpuUh7uleG8dKJQyT7RaI0Xnq+WTZK+85Dx6J+7v5UhTymmilOudGvS
	 ENBzUWXBQnykk4ork6goPhQrsRxhXqB2KsqXdzcG4yroDdvgKUquOIKsCddJcgFMWb
	 /REcfpuedCSwUMesMYQ7NwIBx5iJocUbOmIc7TKXfVe13ej6qwy+8GoE635+Gqfbjb
	 u/KG7s55NH8OQP7pfd7isrbxhlS9N9DX51mGcNacb5BE6piKCAhMfeEN0RU0kMkA5o
	 m+XoPDLBkZocfzA+N2LEXxhOhcKzsaqUVALdAf/aFRL5emh1HAiw3MHPPEip45MW+E
	 g6Gi4J1spr58w==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3367c60ca36so749411fa.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 10:35:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgHXZEKniFJ3aFOb5oiQW6FaGMRdwmvsW9r0ssR49rIt4Tdx9bnFhvBDncDogcXEp033fkISnjm9fkO1Ou@vger.kernel.org
X-Gm-Message-State: AOJu0YxSkBQ4pIaUvJOhq0cjYV6viC29xFPb7jHiRfJYlwi7K8PeFog6
	VYHKmA9tZiY1NZvbaCOET3ZpmePusSU2QK0WYlPAi46oeko0quzf2HBVDU/Eh0F0v7SB5aBavBx
	Nozb7A6AhCEzHSbXpXhjUfCom3tie0gFdJPMScNGE
X-Google-Smtp-Source: AGHT+IHUn8MO0aESC/OldXVkEKhuKEEb6fGxgOuf4xrzSp6WeZVtALeUAoQkfV5FV3cUoazA0fJyWvYRcGm5SnNCYls=
X-Received: by 2002:a05:651c:23d2:10b0:333:f086:3092 with SMTP id
 38308e7fff4ca-33650e704femr46730461fa.11.1756316140285; Wed, 27 Aug 2025
 10:35:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822170800.2116980-1-mic@digikod.net> <20250826-skorpion-magma-141496988fdc@brauner>
 <20250826.aig5aiShunga@digikod.net> <20250826123041.GB1603531@mit.edu> <20250826.iewie7Et5aiw@digikod.net>
In-Reply-To: <20250826.iewie7Et5aiw@digikod.net>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 27 Aug 2025 10:35:28 -0700
X-Gmail-Original-Message-ID: <CALCETrW=V9vst_ho2Q4sQUJ5uZECY5h7TnF==sG4JWq8PsWb8Q@mail.gmail.com>
X-Gm-Features: Ac12FXxYtvycqmWfxuJptxMotttRmHwSaZZf5AQ5i4iJuwxj-1Y4BGUYtJz7etM
Message-ID: <CALCETrW=V9vst_ho2Q4sQUJ5uZECY5h7TnF==sG4JWq8PsWb8Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/2] Add O_DENY_WRITE (complement AT_EXECVE_CHECK)
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <serge@hallyn.com>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Elliott Hughes <enh@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jordan R Abrahams <ajordanr@google.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Luca Boccassi <bluca@debian.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Robert Waite <rowait@microsoft.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Scott Shell <scottsh@microsoft.com>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 10:47=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
>
> On Tue, Aug 26, 2025 at 08:30:41AM -0400, Theodore Ts'o wrote:
> > Is there a single, unified design and requirements document that
> > describes the threat model, and what you are trying to achieve with
> > AT_EXECVE_CHECK and O_DENY_WRITE?  I've been looking at the cover
> > letters for AT_EXECVE_CHECK and O_DENY_WRITE, and the documentation
> > that has landed for AT_EXECVE_CHECK and it really doesn't describe
> > what *are* the checks that AT_EXECVE_CHECK is trying to achieve:
> >
> >    "The AT_EXECVE_CHECK execveat(2) flag, and the
> >    SECBIT_EXEC_RESTRICT_FILE and SECBIT_EXEC_DENY_INTERACTIVE
> >    securebits are intended for script interpreters and dynamic linkers
> >    to enforce a consistent execution security policy handled by the
> >    kernel."
>
> From the documentation:
>
>   Passing the AT_EXECVE_CHECK flag to execveat(2) only performs a check
>   on a regular file and returns 0 if execution of this file would be
>   allowed, ignoring the file format and then the related interpreter
>   dependencies (e.g. ELF libraries, script=E2=80=99s shebang).
>
> >
> > Um, what security policy?
>
> Whether the file is allowed to be executed.  This includes file
> permission, mount point option, ACL, LSM policies...

This needs *waaaaay* more detail for any sort of useful evaluation.
Is an actual credible security policy rolling dice?  Asking ChatGPT?
Looking at security labels?  Does it care who can write to the file,
or who owns the file, or what the file's hash is, or what filesystem
it's on, or where it came from?  Does it dynamically inspect the
contents?  Is it controlled by an unprivileged process?

I can easily come up with security policies for which DENYWRITE is
completely useless.  I can come up with convoluted and
not-really-credible policies where DENYWRITE is important, but I'm
honestly not sure that those policies are actually useful.  I'm
honestly a bit concerned that AT_EXECVE_CHECK is fundamentally busted
because it should have been parametrized by *what format is expected*
-- it might be possible to bypass a policy by executing a perfectly
fine Python script using bash, for example.

I genuinely have not come up with a security policy that I believe
makes sense that needs AT_EXECVE_CHECK and DENYWRITE.  I'm not saying
that such a policy does not exist -- I'm saying that I have not
thought of such a thing after a few minutes of thought and reading
these threads.


> > And then on top of it, why can't you do these checks by modifying the
> > script interpreters?
>
> The script interpreter requires modification to use AT_EXECVE_CHECK.
>
> There is no other way for user space to reliably check executability of
> files (taking into account all enforced security
> policies/configurations).
>

As mentioned above, even AT_EXECVE_CHECK does not obviously accomplish
this goal.  If it were genuinely useful, I would much, much prefer a
totally different API: a *syscall* that takes, as input, a file
descriptor of something that an interpreter wants to execute and a
whole lot of context as to what that interpreter wants to do with it.
And I admit I'm *still* not convinced.

Seriously, consider all the unending recent attacks on LLMs an
inspiration.  The implications of viewing an image, downscaling the
image, possibly interpreting the image as something containing text,
possibly following instructions in a given language contained in the
image, etc are all wildly different.  A mechanism for asking for
general permission to "consume this image" is COMPLETELY MISSING THE
POINT.  (Never mind that the current crop of LLMs seem entirely
incapable of constraining their own use of some piece of input, but
that's a different issue and is besides the point here.)

