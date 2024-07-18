Return-Path: <linux-fsdevel+bounces-23945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE0B9350AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 18:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0B41C2110B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 16:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C723144D10;
	Thu, 18 Jul 2024 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="HWWori0j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFB11B86D0
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721320029; cv=none; b=sUirfb+HpFm5d2XtsiJN0BPvMPafZ/4a4NUd7pTI8BkWr7P3yjtxiTidX44c8j4xigS+ygcQVs0+g/68IL3xfMlWkYtDaWvntbm57ImrnrUuzTEZjuRNOIBkdY7CKxIYqCMIOwm9PjMR0o65x9USrboIUk4XytiZC6uPE8OkQqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721320029; c=relaxed/simple;
	bh=dGZHBZwV5ED+dSRipe5EhDJtdeDghBa8j8Jq/NioRhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YekP2b9YETbm44OTwpuxh5ZxQSAH3JGB8VZp39hZf8lZV0fUS1aTxzhGd3nhmlX0hOV10s7SviG+QZKOZqtkjtq8wu5ndqQPMbXiSc5FffQs1h3DRiZkejybcOM1/y/DzVfpMiQ4rMY6a3thqLXf+CM0IfdxEPO0OUv5gXpVSvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=HWWori0j; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WPyj81ClTzTgj;
	Thu, 18 Jul 2024 18:21:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721319660;
	bh=WQSIaqwiEvVj3gx6DfOqox8o8lkmrsd5ZCwrqu/s1AM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HWWori0jewRpVOx64ZbvPSoVqwaxNPFxMiRfakfjEwKE/Yo008MzoGm3I7OQATZY0
	 y0kyD+bse4MWZ1jsgA2qCA+Hn44M6dOT5wKjB9U0X4/yQpyFcezUtW3hwCZpTdBsCz
	 hH0SF4174Nhln/w4kL0Etn1UDFXNe/77Pi1Obw9s=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WPyj26YqKzpt5;
	Thu, 18 Jul 2024 18:20:54 +0200 (CEST)
Date: Thu, 18 Jul 2024 18:20:52 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Kees Cook <kees@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Paul Moore <paul@paul-moore.com>, Theodore Ts'o <tytso@mit.edu>, 
	Alejandro Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Eric Chiang <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	James Morris <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
	Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Scott Shell <scottsh@microsoft.com>, 
	Shuah Khan <shuah@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, Vincent Strubel <vincent.strubel@ssi.gouv.fr>, 
	Xiaoming Ni <nixiaoming@huawei.com>, Yin Fengwei <fengwei.yin@intel.com>, 
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Elliott Hughes <enh@google.com>
Subject: Re: [RFC PATCH v19 2/5] security: Add new SHOULD_EXEC_CHECK and
 SHOULD_EXEC_RESTRICT securebits
Message-ID: <20240718.uo4aeShajahh@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
 <20240704190137.696169-3-mic@digikod.net>
 <202407041711.B7CD16B2@keescook>
 <20240705.IeTheequ7Ooj@digikod.net>
 <202407051425.32AF9D2@keescook>
 <20240706.eng1ieSh0wa5@digikod.net>
 <ae769bbfe51a2c1c270739a91defc0dfbd5b8b5a.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae769bbfe51a2c1c270739a91defc0dfbd5b8b5a.camel@huaweicloud.com>
X-Infomaniak-Routing: alpha

On Thu, Jul 18, 2024 at 04:16:45PM +0200, Roberto Sassu wrote:
> On Sat, 2024-07-06 at 16:56 +0200, Mickaël Salaün wrote:
> > On Fri, Jul 05, 2024 at 02:44:03PM -0700, Kees Cook wrote:
> > > On Fri, Jul 05, 2024 at 07:54:16PM +0200, Mickaël Salaün wrote:
> > > > On Thu, Jul 04, 2024 at 05:18:04PM -0700, Kees Cook wrote:
> > > > > On Thu, Jul 04, 2024 at 09:01:34PM +0200, Mickaël Salaün wrote:
> > > > > > Such a secure environment can be achieved with an appropriate access
> > > > > > control policy (e.g. mount's noexec option, file access rights, LSM
> > > > > > configuration) and an enlighten ld.so checking that libraries are
> > > > > > allowed for execution e.g., to protect against illegitimate use of
> > > > > > LD_PRELOAD.
> > > > > > 
> > > > > > Scripts may need some changes to deal with untrusted data (e.g. stdin,
> > > > > > environment variables), but that is outside the scope of the kernel.
> > > > > 
> > > > > If the threat model includes an attacker sitting at a shell prompt, we
> > > > > need to be very careful about how process perform enforcement. E.g. even
> > > > > on a locked down system, if an attacker has access to LD_PRELOAD or a
> > > > 
> > > > LD_PRELOAD should be OK once ld.so will be patched to check the
> > > > libraries.  We can still imagine a debug library used to bypass security
> > > > checks, but in this case the issue would be that this library is
> > > > executable in the first place.
> > > 
> > > Ah yes, that's fair: the shell would discover the malicious library
> > > while using AT_CHECK during resolution of the LD_PRELOAD.
> > 
> > That's the idea, but it would be checked by ld.so, not the shell.
> > 
> > > 
> > > > > seccomp wrapper (which you both mention here), it would be possible to
> > > > > run commands where the resulting process is tricked into thinking it
> > > > > doesn't have the bits set.
> > > > 
> > > > As explained in the UAPI comments, all parent processes need to be
> > > > trusted.  This meeans that their code is trusted, their seccomp filters
> > > > are trusted, and that they are patched, if needed, to check file
> > > > executability.
> > > 
> > > But we have launchers that apply arbitrary seccomp policy, e.g. minijail
> > > on Chrome OS, or even systemd on regular distros. In theory, this should
> > > be handled via other ACLs.
> > 
> > Processes running with untrusted seccomp filter should be considered
> > untrusted.  It would then make sense for these seccomp filters/programs
> > to be considered executable code, and then for minijail and systemd to
> > check them with AT_CHECK (according to the securebits policy).
> > 
> > > 
> > > > > But this would be exactly true for calling execveat(): LD_PRELOAD or
> > > > > seccomp policy could have it just return 0.
> > > > 
> > > > If an attacker is allowed/able to load an arbitrary seccomp filter on a
> > > > process, we cannot trust this process.
> > > > 
> > > > > 
> > > > > While I like AT_CHECK, I do wonder if it's better to do the checks via
> > > > > open(), as was originally designed with O_MAYEXEC. Because then
> > > > > enforcement is gated by the kernel -- the process does not get a file
> > > > > descriptor _at all_, no matter what LD_PRELOAD or seccomp tricks it into
> > > > > doing.
> > > > 
> > > > Being able to check a path name or a file descriptor (with the same
> > > > syscall) is more flexible and cover more use cases.
> > > 
> > > If flexibility costs us reliability, I think that flexibility is not
> > > a benefit.
> > 
> > Well, it's a matter of letting user space do what they think is best,
> > and I think there are legitimate and safe uses of path names, even if I
> > agree that this should not be used in most use cases.  Would we want
> > faccessat2(2) to only take file descriptor as argument and not file
> > path? I don't think so but I'd defer to the VFS maintainers.
> > 
> > Christian, Al, Linus?
> > 
> > Steve, could you share a use case with file paths?
> > 
> > > 
> > > > The execveat(2)
> > > > interface, including current and future flags, is dedicated to file
> > > > execution.  I then think that using execveat(2) for this kind of check
> > > > makes more sense, and will easily evolve with this syscall.
> > > 
> > > Yeah, I do recognize that is feels much more natural, but I remain
> > > unhappy about how difficult it will become to audit a system for safety
> > > when the check is strictly per-process opt-in, and not enforced by the
> > > kernel for a given process tree. But, I think this may have always been
> > > a fiction in my mind. :)
> > 
> > Hmm, I'm not sure to follow. Securebits are inherited, so process tree.
> > And we need the parent processes to be trusted anyway.
> > 
> > > 
> > > > > And this thinking also applies to faccessat() too: if a process can be
> > > > > tricked into thinking the access check passed, it'll happily interpret
> > > > > whatever. :( But not being able to open the fd _at all_ when O_MAYEXEC
> > > > > is being checked seems substantially safer to me...
> > > > 
> > > > If attackers can filter execveat(2), they can also filter open(2) and
> > > > any other syscalls.  In all cases, that would mean an issue in the
> > > > security policy.
> > > 
> > > Hm, as in, make a separate call to open(2) without O_MAYEXEC, and pass
> > > that fd back to the filtered open(2) that did have O_MAYEXEC. Yes, true.
> > > 
> > > I guess it does become morally equivalent.
> > > 
> > > Okay. Well, let me ask about usability. Right now, a process will need
> > > to do:
> > > 
> > > - should I use AT_CHECK? (check secbit)
> > > - if yes: perform execveat(AT_CHECK)
> > > 
> > > Why not leave the secbit test up to the kernel, and then the program can
> > > just unconditionally call execveat(AT_CHECK)?
> > 
> > That was kind of the approach of the previous patch series and Linus
> > wanted the new interface to follow the kernel semantic.  Enforcing this
> > kind of restriction will always be the duty of user space anyway, so I
> > think it's simpler (i.e. no mix of policy definition, access check, and
> > policy enforcement, but a standalone execveat feature), more flexible,
> > and it fully delegates the policy enforcement to user space instead of
> > trying to enforce some part in the kernel which would only give the
> > illusion of security/policy enforcement.
> 
> A problem could be that from IMA perspective there is no indication on
> whether the interpreter executed or not execveat(). Sure, we can detect
> that the binary supports it, but if the enforcement was
> enabled/disabled that it is not recorded.

We should assume that if the interpreter call execveat+AT_CHECK, it will
enforce restrictions according to its securebits.

> 
> Maybe, setting the process flags should be influenced by the kernel,
> for example not allowing changes and enforcing when there is an IMA
> policy loaded requiring to measure/appraise scripts.

LSMs can set the required securebits per task/interpreter according to
their policies.

> 
> Roberto
> 
> > > 
> > > Though perhaps the issue here is that an execveat() EINVAL doesn't
> > > tell the program if AT_CHECK is unimplemented or if something else
> > > went wrong, and the secbit prctl() will give the correct signal about
> > > AT_CHECK availability?
> > 
> > This kind of check could indeed help to identify the issue.
> 
> 

