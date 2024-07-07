Return-Path: <linux-fsdevel+bounces-23264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CAF929738
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jul 2024 11:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91A9D1C20A80
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jul 2024 09:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F190117997;
	Sun,  7 Jul 2024 09:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="bIkt82a7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C7810A03;
	Sun,  7 Jul 2024 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720342915; cv=none; b=Hy3pqckf49XYMOMBy+Z/6iCG40p5JzVoSDS2cKXn1gDrOp7IsD87w+FeUUuRV1iX20eUu804DeBtyKxzUuH4FdjDIKHs8v1i6nSqdNGAYlAIHGHfAGN5E+t86MlzK1C27+wlwQBX4Bk45BG8Z1gOz2STysyRg9SsCbOWOeVw+wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720342915; c=relaxed/simple;
	bh=8vDD3Vs0nX7RWoUIPW9UfV0zdvhLtFiF3W2BsPp7AJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPtK30meeZeZltmNvi8luXEgQTbsCY54weTAxcuACkHQQeJnE9MxIPRe1e5QEUhI81o9gAhGWdq+0tZ7GvYa4quYnbzehL5TZ2mWv0W15/JIW4/SE4yX1z0TW1wmvCvus8qNA8VrTna9BV1HkEjK8wYLC7fPn3CzA+IBmLwZG/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=bIkt82a7; arc=none smtp.client-ip=185.125.25.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WH1TM21N8zf5n;
	Sun,  7 Jul 2024 11:01:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1720342903;
	bh=ccGFCfJj+0USx7pg3qPSDeXuTuHIjg7grW1wNNxHys8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bIkt82a7I8VPRqv3rTQdA+pgpoxitwyozvqGeJ4KUWValN2cRICPwmkUdzbgGzxDa
	 IUWbccgD9cibggSsBHFiciIxPs5pAFPXpwu5dk9dvBHycOPrRLo9DcjvGweGvSvlz3
	 hjjD6U5FN41zUmMGThnwwb0k4cncBRpi7n+Dw6bw=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WH1TH2v0lzFns;
	Sun,  7 Jul 2024 11:01:39 +0200 (CEST)
Date: Sun, 7 Jul 2024 11:01:36 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Andy Lutomirski <luto@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Paul Moore <paul@paul-moore.com>, Theodore Ts'o <tytso@mit.edu>, 
	Alejandro Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
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
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v19 1/5] exec: Add a new AT_CHECK flag to execveat(2)
Message-ID: <20240706.fiquaeCodoo8@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
 <20240704190137.696169-2-mic@digikod.net>
 <CALCETrWYu=PYJSgyJ-vaa+3BGAry8Jo8xErZLiGR3U5h6+U0tA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrWYu=PYJSgyJ-vaa+3BGAry8Jo8xErZLiGR3U5h6+U0tA@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Sat, Jul 06, 2024 at 04:52:42PM +0800, Andy Lutomirski wrote:
> On Fri, Jul 5, 2024 at 3:03 AM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > Add a new AT_CHECK flag to execveat(2) to check if a file would be
> > allowed for execution.  The main use case is for script interpreters and
> > dynamic linkers to check execution permission according to the kernel's
> > security policy. Another use case is to add context to access logs e.g.,
> > which script (instead of interpreter) accessed a file.  As any
> > executable code, scripts could also use this check [1].
> >
> 
> Can you give a worked-out example of how this is useful?

Which part?  Please take a look at CLIP OS, chromeOS, and PEP 578 use
cases and related code (see cover letter).

> 
> I assume the idea is that a program could open a file, then pass the
> fd to execveat() to get the kernel's idea of whether it's permissible
> to execute it.  And then the program would interpret the file, which
> is morally like executing it.  And there would be a big warning in the
> manpage that passing a *path* is subject to a TOCTOU race.

yes

> 
> This type of usage will do the wrong thing if LSM policy intends to
> lock down the task if the task were to actually exec the file.  I

Why? LSMs should currently only change the bprm's credentials not the
current's credentials.  If needed, we can extend the current patch
series with LSM specific patches for them to check bprm->is_check.

> personally think this is a mis-design (let the program doing the
> exec-ing lock itself down, possibly by querying a policy, but having
> magic happen on exec seems likely to do the wrong thing more often
> that it does the wright thing), but that ship sailed a long time ago.

The execveat+AT_CHECK is only a check that doesn't impact the caller.
Maybe you're talking about process transition with future LSM changes?
In this case, we could add another flag, but I'm convinced it would be
confusing for users.  Anyway, let LSMs experiment with that and we'll
come up with a new flag if needed.  The current approach is a good and
useful piece to fill a gap in Linux access control systems.

> 
> So maybe what's actually needed is a rather different API: a way to
> check *and perform* the security transition for an exec without
> actually execing.  This would need to be done NO_NEW_PRIVS style for
> reasons that are hopefully obvious, but it would permit:

NO_NEW_PRIVS is not that obvious in this case because the restrictions
are enforced by user space, not the kernel.  NO_NEW_PRIVS makes sense to
avoid kernel restrictions be requested by a malicious/unprivileged
process to change the behavior of a (child) privileged/trusted process.
We are not in this configuration here.  The only change would be for
ptrace, which is a good thing either way and should not harm SUID
processes but avoid confused deputy attack for them too.

If this is about an LSM changing the caller's credentials, then yes it
might want to set additional flags, but that would be specific to their
implementation, not part of this patch.

> 
> fd = open(some script);
> if (do_exec_transition_without_exec(fd) != 0)
>   return;  // don't actually do it
> 
> // OK, we may have just lost privileges.  But that's okay, because we
> meant to do that.
> // Make sure we've munmapped anything sensitive and erased any secrets
> from memory,
> // and then interpret the script!
> 
> I think this would actually be straightforward to implement in the
> kernel -- one would need to make sure that all the relevant
> no_new_privs checks are looking in the right place (as the task might
> not actually have no_new_privs set, but LSM_UNSAFE_NO_NEW_PRIVS would
> still be set), but I don't see any reason this would be
> insurmountable, nor do I expect there would be any fundamental
> problems.

OK, that's what is described below with security_bprm_creds_for_exec().
Each LSM can implement this change with the current patch series, but
that should be part of a dedicated patch series per LSM, for those
willing to leverage this new feature.

> 
> 
> > This is different than faccessat(2) which only checks file access
> > rights, but not the full context e.g. mount point's noexec, stack limit,
> > and all potential LSM extra checks (e.g. argv, envp, credentials).
> > Since the use of AT_CHECK follows the exact kernel semantic as for a
> > real execution, user space gets the same error codes.
> >
> > With the information that a script interpreter is about to interpret a
> > script, an LSM security policy can adjust caller's access rights or log
> > execution request as for native script execution (e.g. role transition).
> > This is possible thanks to the call to security_bprm_creds_for_exec().
> >
> > Because LSMs may only change bprm's credentials, use of AT_CHECK with
> > current kernel code should not be a security issue (e.g. unexpected role
> > transition).  LSMs willing to update the caller's credential could now
> > do so when bprm->is_check is set.  Of course, such policy change should
> > be in line with the new user space code.
> >
> > Because AT_CHECK is dedicated to user space interpreters, it doesn't
> > make sense for the kernel to parse the checked files, look for
> > interpreters known to the kernel (e.g. ELF, shebang), and return ENOEXEC
> > if the format is unknown.  Because of that, security_bprm_check() is
> > never called when AT_CHECK is used.
> >
> > It should be noted that script interpreters cannot directly use
> > execveat(2) (without this new AT_CHECK flag) because this could lead to
> > unexpected behaviors e.g., `python script.sh` could lead to Bash being
> > executed to interpret the script.  Unlike the kernel, script
> > interpreters may just interpret the shebang as a simple comment, which
> > should not change for backward compatibility reasons.
> >
> > Because scripts or libraries files might not currently have the
> > executable permission set, or because we might want specific users to be
> > allowed to run arbitrary scripts, the following patch provides a dynamic
> > configuration mechanism with the SECBIT_SHOULD_EXEC_CHECK and
> > SECBIT_SHOULD_EXEC_RESTRICT securebits.
> 
> Can you explain what those bits do?  And why they're useful?

I didn't want to duplicate the comments above their definition
explaining their usage.  Please let me know if it's not enough.

> 
> >
> > This is a redesign of the CLIP OS 4's O_MAYEXEC:
> > https://github.com/clipos-archive/src_platform_clip-patches/blob/f5cb330d6b684752e403b4e41b39f7004d88e561/1901_open_mayexec.patch
> > This patch has been used for more than a decade with customized script
> > interpreters.  Some examples can be found here:
> > https://github.com/clipos-archive/clipos4_portage-overlay/search?q=O_MAYEXEC
> 
> This one at least returns an fd, so it looks less likely to get
> misused in a way that adds a TOCTOU race.

We can use both an FD or a path name with execveat(2).  See discussion
with Kees and comment from Linus.

