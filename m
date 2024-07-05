Return-Path: <linux-fsdevel+bounces-23177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC545927F4C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 02:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19BB11C2256F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 00:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED92A6125;
	Fri,  5 Jul 2024 00:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTICkINT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D9EED9;
	Fri,  5 Jul 2024 00:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720138685; cv=none; b=XZZpEzCIrr6BQ8GaGj24n4l0ClZA3nGRDUkFHZIDM1lsPMSyUdNVlU68V1/GNcoLggmIJENYksaz9pSFj7NCq9ARm9e3OxsoNIE9grski6SZ8oGChhi/Sx98XNImVb80tA85p3Uusnht50gpJZ3BRUUJ2mk0y/nZFsyiKTnSbSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720138685; c=relaxed/simple;
	bh=5af+DRO8rWEXOnw6IOc48Ov2WwkK5joBTlWm01wXltM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l27kiHywQ1W5LKybPDX/dWfJyDzFlnqvMjyYq0mUWkp6sG3Wm927b9e5WrGDqHyjsavMQn1UJaDrZYJblBIlFMp7WT3MpvYXNJW3UiOrGEMSDRr6sbE+bTbzB2omxJ6QJbJ/yCNO9hb4xdRz7fDAEpsMTD+Zzu5bppyEA+svbrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTICkINT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A69C3277B;
	Fri,  5 Jul 2024 00:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720138684;
	bh=5af+DRO8rWEXOnw6IOc48Ov2WwkK5joBTlWm01wXltM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VTICkINTStb85dDsvisEftl1X0r68/zfAO4xLYD7kb1F8/Z5ERt/7oqFMWp/Z79bR
	 FX1FDeXC4RuC6ECne5DIV1RFOg/M68nAs22Pdbv6HaFYgEot5lB4XEWHuYnmoad0Uz
	 fJQySERKu4g85/Pa20vCn/jPl5JSNmGUFT2BTH5yFQ3SC1h8dvuM9nn2eFSOXyQNTY
	 Ypn8Z9tbW5W5OvugpM6kDGWPviy6GjDMUM04+9PJ4IenEy1IIZ7eelPUOs1kNTmuiK
	 LzLsiTqYlZcCezV4AhZE+r3KHp3ZgANlcAclUNRPlIaJ95W28SmSDs7UyBwzonYAUU
	 K1CEAD7cNxMhg==
Date: Thu, 4 Jul 2024 17:18:04 -0700
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
Subject: Re: [RFC PATCH v19 2/5] security: Add new SHOULD_EXEC_CHECK and
 SHOULD_EXEC_RESTRICT securebits
Message-ID: <202407041711.B7CD16B2@keescook>
References: <20240704190137.696169-1-mic@digikod.net>
 <20240704190137.696169-3-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240704190137.696169-3-mic@digikod.net>

On Thu, Jul 04, 2024 at 09:01:34PM +0200, Mickaël Salaün wrote:
> Such a secure environment can be achieved with an appropriate access
> control policy (e.g. mount's noexec option, file access rights, LSM
> configuration) and an enlighten ld.so checking that libraries are
> allowed for execution e.g., to protect against illegitimate use of
> LD_PRELOAD.
> 
> Scripts may need some changes to deal with untrusted data (e.g. stdin,
> environment variables), but that is outside the scope of the kernel.

If the threat model includes an attacker sitting at a shell prompt, we
need to be very careful about how process perform enforcement. E.g. even
on a locked down system, if an attacker has access to LD_PRELOAD or a
seccomp wrapper (which you both mention here), it would be possible to
run commands where the resulting process is tricked into thinking it
doesn't have the bits set.

But this would be exactly true for calling execveat(): LD_PRELOAD or
seccomp policy could have it just return 0.

While I like AT_CHECK, I do wonder if it's better to do the checks via
open(), as was originally designed with O_MAYEXEC. Because then
enforcement is gated by the kernel -- the process does not get a file
descriptor _at all_, no matter what LD_PRELOAD or seccomp tricks it into
doing.

And this thinking also applies to faccessat() too: if a process can be
tricked into thinking the access check passed, it'll happily interpret
whatever. :( But not being able to open the fd _at all_ when O_MAYEXEC
is being checked seems substantially safer to me...

-- 
Kees Cook

