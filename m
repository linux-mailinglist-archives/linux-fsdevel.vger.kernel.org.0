Return-Path: <linux-fsdevel+bounces-23248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BE4928EEA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 23:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90CD41C22B91
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 21:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D3E146A73;
	Fri,  5 Jul 2024 21:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmA/MqpH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6AA13A26F;
	Fri,  5 Jul 2024 21:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720215845; cv=none; b=eQCFpxFd2n5N1apNiJtD+Zh7g87N1mcFrYBPhfn7Tewuk7DZnNywXHE9lHKymLWFalW/ZQ6cfUu3nNTjj0mkocUsTO/cKbiNe0Wp+MeZ+TAYIV9b8Bx409GGwRDCKb9epu88AGPWw4j4Kc2+Cdrh1ttR++8Mb/HqxqJNp1MJwaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720215845; c=relaxed/simple;
	bh=C8dzzeBxki3NVPz5SLBDhzLlRbF8DdRlaoB+upRLStw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTxdwk/sRf5kGVbWBqii6pElGRbi243a0NM+YURMSudguBOInN6jS4UO7YKzzq9kvlPS8c3I/eUoHZxMF/BsqtOm23lL/peQGfU+OhNV6YVMS1d9kSi2YGxS213CZxaHdRYZf8Ba3gZ36HXO3rbf6TfFAFOdo2a+4Swmo5XVCyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmA/MqpH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84822C116B1;
	Fri,  5 Jul 2024 21:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720215844;
	bh=C8dzzeBxki3NVPz5SLBDhzLlRbF8DdRlaoB+upRLStw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YmA/MqpHvxbBzpbTc6a2FOvrfPb4OIVnkRcyMZqvqh9C/IaHKhfDEwkLDMfqBAZKE
	 lLtV3XmpRZnW5tCPDKPkoKOTWVowP8K7NRpKAJ9LHi4T1ILYDGiF7MIuMLER2u6091
	 FVOyYCqnGEDEIZPcXEnF0Se3zIMDxqtuouIkG8VyS/ktA3M28+mc/apOcH+XZsMcbb
	 /v9pBelPJJAnQaPCu1em+kb7npPHZmTbUi3yhMXToh60NEfdZeAMBSBzCpoUp7hgI7
	 Wu7FElBENaUT6HJ8lrykCAzO484DugOXOBEuhZNCIKND8xqN1dc1p1TW7fbg9L0Wyz
	 Hc+0YX7HazBiA==
Date: Fri, 5 Jul 2024 14:44:03 -0700
From: Kees Cook <kees@kernel.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>, Theodore Ts'o <tytso@mit.edu>,
	Alejandro Colomar <alx@kernel.org>,
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
Subject: Re: [RFC PATCH v19 2/5] security: Add new SHOULD_EXEC_CHECK and
 SHOULD_EXEC_RESTRICT securebits
Message-ID: <202407051425.32AF9D2@keescook>
References: <20240704190137.696169-1-mic@digikod.net>
 <20240704190137.696169-3-mic@digikod.net>
 <202407041711.B7CD16B2@keescook>
 <20240705.IeTheequ7Ooj@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240705.IeTheequ7Ooj@digikod.net>

On Fri, Jul 05, 2024 at 07:54:16PM +0200, Mickaël Salaün wrote:
> On Thu, Jul 04, 2024 at 05:18:04PM -0700, Kees Cook wrote:
> > On Thu, Jul 04, 2024 at 09:01:34PM +0200, Mickaël Salaün wrote:
> > > Such a secure environment can be achieved with an appropriate access
> > > control policy (e.g. mount's noexec option, file access rights, LSM
> > > configuration) and an enlighten ld.so checking that libraries are
> > > allowed for execution e.g., to protect against illegitimate use of
> > > LD_PRELOAD.
> > > 
> > > Scripts may need some changes to deal with untrusted data (e.g. stdin,
> > > environment variables), but that is outside the scope of the kernel.
> > 
> > If the threat model includes an attacker sitting at a shell prompt, we
> > need to be very careful about how process perform enforcement. E.g. even
> > on a locked down system, if an attacker has access to LD_PRELOAD or a
> 
> LD_PRELOAD should be OK once ld.so will be patched to check the
> libraries.  We can still imagine a debug library used to bypass security
> checks, but in this case the issue would be that this library is
> executable in the first place.

Ah yes, that's fair: the shell would discover the malicious library
while using AT_CHECK during resolution of the LD_PRELOAD.

> > seccomp wrapper (which you both mention here), it would be possible to
> > run commands where the resulting process is tricked into thinking it
> > doesn't have the bits set.
> 
> As explained in the UAPI comments, all parent processes need to be
> trusted.  This meeans that their code is trusted, their seccomp filters
> are trusted, and that they are patched, if needed, to check file
> executability.

But we have launchers that apply arbitrary seccomp policy, e.g. minijail
on Chrome OS, or even systemd on regular distros. In theory, this should
be handled via other ACLs.

> > But this would be exactly true for calling execveat(): LD_PRELOAD or
> > seccomp policy could have it just return 0.
> 
> If an attacker is allowed/able to load an arbitrary seccomp filter on a
> process, we cannot trust this process.
> 
> > 
> > While I like AT_CHECK, I do wonder if it's better to do the checks via
> > open(), as was originally designed with O_MAYEXEC. Because then
> > enforcement is gated by the kernel -- the process does not get a file
> > descriptor _at all_, no matter what LD_PRELOAD or seccomp tricks it into
> > doing.
> 
> Being able to check a path name or a file descriptor (with the same
> syscall) is more flexible and cover more use cases.

If flexibility costs us reliability, I think that flexibility is not
a benefit.

> The execveat(2)
> interface, including current and future flags, is dedicated to file
> execution.  I then think that using execveat(2) for this kind of check
> makes more sense, and will easily evolve with this syscall.

Yeah, I do recognize that is feels much more natural, but I remain
unhappy about how difficult it will become to audit a system for safety
when the check is strictly per-process opt-in, and not enforced by the
kernel for a given process tree. But, I think this may have always been
a fiction in my mind. :)

> > And this thinking also applies to faccessat() too: if a process can be
> > tricked into thinking the access check passed, it'll happily interpret
> > whatever. :( But not being able to open the fd _at all_ when O_MAYEXEC
> > is being checked seems substantially safer to me...
> 
> If attackers can filter execveat(2), they can also filter open(2) and
> any other syscalls.  In all cases, that would mean an issue in the
> security policy.

Hm, as in, make a separate call to open(2) without O_MAYEXEC, and pass
that fd back to the filtered open(2) that did have O_MAYEXEC. Yes, true.

I guess it does become morally equivalent.

Okay. Well, let me ask about usability. Right now, a process will need
to do:

- should I use AT_CHECK? (check secbit)
- if yes: perform execveat(AT_CHECK)

Why not leave the secbit test up to the kernel, and then the program can
just unconditionally call execveat(AT_CHECK)?

Though perhaps the issue here is that an execveat() EINVAL doesn't
tell the program if AT_CHECK is unimplemented or if something else
went wrong, and the secbit prctl() will give the correct signal about
AT_CHECK availability?

-- 
Kees Cook

