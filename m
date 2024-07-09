Return-Path: <linux-fsdevel+bounces-23444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 502D792C4F5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 22:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C22D6B21F48
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 20:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E9218EA6B;
	Tue,  9 Jul 2024 20:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ZqRVY2T0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DD7187870
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 20:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557804; cv=none; b=fpjcF8Iz1hQt2PkuA5uK/qpWHMHtPrBFTb/r06ww064rzd2/kTSs/7fm43vC1oeetRqOUyYwu23ojonzdqNdcZITujnWO8PpUNfgtKT5XLBb7x2FhuCdVF3sypjNjaHVbGEUsQXUlutz88umaTXffA/gDCA2Vr9OriRgnBgoP0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557804; c=relaxed/simple;
	bh=cunWEuY2wEYMO6Wr7yUm4z/Numf12Hzm81dpJ6PvZGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLDvWqbPsKg00c/8ZngXeDNFsw76z6dwiaH2tH4uGnmFQFavXE8mTHZabbTH43lRU9iCmn+gXJZFpAHbHY4OtdTDip/TfW5otuj7G4rhSkPrYLLTPC9y3mD4BO2xiKggzG9LlUQMLlzsGtkD2HNOEtQdszvjirB9e8PyJP92T/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ZqRVY2T0; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WJXxt03Mszsx6;
	Tue,  9 Jul 2024 22:43:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1720557793;
	bh=DY4ON4k53sWhYGXcmX6VPO/UCUA4DRMBJPJ0GnvYcrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZqRVY2T000kk3VOhlxPReWQIchX7FYTF2wQp4BjX3GAwTn0fhrcoaVg+CigqAOSaD
	 D8aAZvc2WCTOi8EjqQ6s3J3db5HeeRCYYE2W2kAddPCPXeBiQ66hhn14p6fJms5Ayp
	 VX+6dJPd1KiM5p1EE1AXfQ/D2U7LKMPctgbEShYA=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WJXxr5lpqzmTY;
	Tue,  9 Jul 2024 22:43:12 +0200 (CEST)
Date: Tue, 9 Jul 2024 22:43:09 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Mimi Zohar <zohar@linux.ibm.com>
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
	Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, 
	Scott Shell <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Steve Dower <steve.dower@python.org>, 
	Steve Grubb <sgrubb@redhat.com>, Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, 
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>, Xiaoming Ni <nixiaoming@huawei.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v19 0/5] Script execution control (was O_MAYEXEC)
Message-ID: <20240709.AhJ7oTh1biej@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
 <55b4f6291e8d83d420c7d08f4233b3d304ce683d.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55b4f6291e8d83d420c7d08f4233b3d304ce683d.camel@linux.ibm.com>
X-Infomaniak-Routing: alpha

On Mon, Jul 08, 2024 at 04:35:38PM -0400, Mimi Zohar wrote:
> Hi Mickaël,
> 
> On Thu, 2024-07-04 at 21:01 +0200, Mickaël Salaün wrote:
> > Hi,
> > 
> > The ultimate goal of this patch series is to be able to ensure that
> > direct file execution (e.g. ./script.sh) and indirect file execution
> > (e.g. sh script.sh) lead to the same result, especially from a security
> > point of view.
> > 
> > Overview
> > --------
> > 
> > This patch series is a new approach of the initial O_MAYEXEC feature,
> > and a revamp of the previous patch series.  Taking into account the last
> > reviews [1], we now stick to the kernel semantic for file executability.
> > One major change is the clear split between access check and policy
> > management.
> > 
> > The first patch brings the AT_CHECK flag to execveat(2).  The goal is to
> > enable user space to check if a file could be executed (by the kernel).
> > Unlike stat(2) that only checks file permissions, execveat2(2) +
> > AT_CHECK take into account the full context, including mount points
> > (noexec), caller's limits, and all potential LSM extra checks (e.g.
> > argv, envp, credentials).
> > 
> > The second patch brings two new securebits used to set or get a security
> > policy for a set of processes.  For this to be meaningful, all
> > executable code needs to be trusted.  In practice, this means that
> > (malicious) users can be restricted to only run scripts provided (and
> > trusted) by the system.
> > 
> > [1] https://lore.kernel.org/r/CAHk-=wjPGNLyzeBMWdQu+kUdQLHQugznwY7CvWjmvNW47D5sog@mail.gmail.com
> > 
> > Script execution
> > ----------------
> > 
> > One important thing to keep in mind is that the goal of this patch
> > series is to get the same security restrictions with these commands:
> > * ./script.py
> > * python script.py
> > * python < script.py
> > * python -m script.pyT
> 
> This is really needed, but is it the "only" purpose of this patch set or can it
> be used to also monitor files the script opens (for read) with the intention of
> executing.

This feature can indeed also be used to monitor files requested by
scripts to be executed e.g. using
https://docs.python.org/3/library/io.html#io.open_code

IMA/EVM can include this check in its logs.

> 
> > 
> > However, on secure systems, we should be able to forbid these commands
> > because there is no way to reliably identify the origin of the script:
> > * xargs -a script.py -d '\r' -- python -c
> > * cat script.py | python
> > * python
> > 
> > Background
> > ----------
> > 
> > Compared to the previous patch series, there is no more dedicated
> > syscall nor sysctl configuration.  This new patch series only add new
> > flags: one for execveat(2) and four for prctl(2).
> > 
> > This kind of script interpreter restriction may already be used in
> > hardened systems, which may need to fork interpreters and install
> > different versions of the binaries.  This mechanism should enable to
> > avoid the use of duplicate binaries (and potential forked source code)
> > for secure interpreters (e.g. secure Python [2]) by making it possible
> > to dynamically enforce restrictions or not.
> > 
> > The ability to control script execution is also required to close a
> > major IMA measurement/appraisal interpreter integrity [3].
> 
> Definitely.  But it isn't limited to controlling script execution, but also
> measuring the script.  Will it be possible to measure and appraise the indirect
> script calls with this patch set?

Yes. You should only need to implement security_bprm_creds_for_exec()
for IMA/EVM.

BTW, I noticed that IMA only uses the security_bprm_check() hook (which
can be called several times for one execve), but
security_bprm_creds_for_exec() might be more appropriate.

> 
> Mimi
> 
> > This new execveat + AT_CHECK should not be confused with the O_EXEC flag
> > (for open) which is intended for execute-only, which obviously doesn't
> > work for scripts.
> > 
> > I gave a talk about controlling script execution where I explain the
> > previous approaches [4].  The design of the WIP RFC I talked about
> > changed quite a bit since then.
> > 
> > [2] https://github.com/zooba/spython
> > [3] https://lore.kernel.org/lkml/20211014130125.6991-1-zohar@linux.ibm.com/
> > [4] https://lssna2023.sched.com/event/1K7bO
> > 
> 
> 

