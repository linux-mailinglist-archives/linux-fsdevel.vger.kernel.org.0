Return-Path: <linux-fsdevel+bounces-23777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D87932F19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 19:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 516951F22AF4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 17:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9731A00C2;
	Tue, 16 Jul 2024 17:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="BhoDx/d0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0718A19DF87
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jul 2024 17:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721151119; cv=none; b=EHDbCMFxWvJflOQYtMmGrmVDY/zFKynXYzMp2LbSG//cT+9lNSAOLqIBGIPHbZQIo9SvUyzsQZQcntWgQ7k88H902Rm/rt6iRtiRZnAw9h4JhDJOYrTJkDsXwAzQjWaN32mO18H/SYt+EgntV1/BA2qfxmRlYCpHDQgJz5aHuKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721151119; c=relaxed/simple;
	bh=MW5MM0UiDoNQ5jIccGyeCS2wNwBx87O/gkIYwsEBj+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oleHjWSgMM+4oPizmy1eg1MxK+us6JtW3yGoupDdv+YfkSoPk9iMH4AmHD5DL7elnvWtk3y/oXZLDNT7mBSR3yL+g5TCUbwGcRCiXV3wvfiou5GqAeFwvnYMexXpVnPQ4atcL55lefWMNmGowPahtAIklwG9GSlrrq1xxESgt1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=BhoDx/d0; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WNmMj5yz5z4Mp;
	Tue, 16 Jul 2024 19:31:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721151105;
	bh=Xu6GB1mmYQXJSoJZK4nvtCnpIij3wppCLjoOW51w6fM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BhoDx/d0FL+9WOZsjJfJW8taaEo6bVoFn6l1M02l3CmqODMqqKPv7R3eCAw4USrP/
	 G+nhmkrZacHDd01il83mrHH+zULbipwD/RLRES9qWSMAIN23MFh2hYqoKE2W5cieGD
	 HBnwBBUcQ3ZObdCcIHv/DM7C3kLPxfeMt0lO2WTY=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WNmMc22bKz12m6;
	Tue, 16 Jul 2024 19:31:39 +0200 (CEST)
Date: Tue, 16 Jul 2024 19:31:38 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Al Viro <viro@zeniv.linux.org.uk>, 
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
Message-ID: <20240716.leeV4ooveinu@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
 <55b4f6291e8d83d420c7d08f4233b3d304ce683d.camel@linux.ibm.com>
 <20240709.AhJ7oTh1biej@digikod.net>
 <9e3df65c2bf060b5833558e9f8d82dcd2fe9325a.camel@huaweicloud.com>
 <ee1ae815b6e75021709612181a6a4415fda543a4.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ee1ae815b6e75021709612181a6a4415fda543a4.camel@HansenPartnership.com>
X-Infomaniak-Routing: alpha

On Tue, Jul 16, 2024 at 12:12:49PM -0400, James Bottomley wrote:
> On Tue, 2024-07-16 at 17:57 +0200, Roberto Sassu wrote:
> > But the Clip OS 4 patch does not cover the redirection case:
> > 
> > # ./bash < /root/test.sh
> > Hello World
> > 
> > Do you have a more recent patch for that?

Bash was only partially restricted for CLIP OS because it was used for
administrative tasks (interactive shell).

Python was also restricted for user commands though:
https://github.com/clipos-archive/clipos4_portage-overlay/blob/master/dev-lang/python/files/python-2.7.9-clip-mayexec.patch

Steve and Christian could help with a better Python implementation.

> 
> How far down the rabbit hole do you want to go?  You can't forbid a
> shell from executing commands from stdin because logging in then won't
> work.  It may be possible to allow from a tty backed file and not from
> a file backed one, but you still have the problem of the attacker
> manually typing in the script.

Yes, that's why we'll have the (optional) SECBIT_EXEC_DENY_INTERACTIVE:
https://lore.kernel.org/all/20240710.eiKohpa4Phai@digikod.net/

> 
> The saving grace for this for shells is that they pretty much do
> nothing on their own (unlike python) so you can still measure all the
> executables they call out to, which provides reasonable safety.

Exactly. Python is a much more interesting target for attacker because
it opens the door for arbitrary syscalls (see the cover letter).

If we want to have a more advanced access control (e.g. allow Bash but
not Python), we should extend existing LSMs to manage the appropriate
securebits according to programs/subjects.

