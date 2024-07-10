Return-Path: <linux-fsdevel+bounces-23500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DFF92D6C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 18:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8B9EB2AF62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 16:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138CF1953A1;
	Wed, 10 Jul 2024 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOoq4U1y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6AB19AD93;
	Wed, 10 Jul 2024 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628775; cv=none; b=lHhJxuTtPpjLe2I8cZaaL2Wl+vxxb6SVjBfo7Y497DE3ZSczGFeRIq7R2SVvl7aQY7bS4h85EJMEIwLpETHzuoUVDQUctxms46Qmz5/ejlE3HeQ8PwnJaGdtZtGz0iAxxmJKJSRQ8RaJAX1mJSVczj3TCH690kBTCDoD9Yb2Us4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628775; c=relaxed/simple;
	bh=6SS1VzsAN02ABjDahpP3q5Q9MfB8o/CX8E1l3SuhboU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0rJ2UsM9GsZAIBp/3eYFux3omGov92dhC4OwOVvDlx7RhoGh5q2Lu4b0kY0/7SJKpveKvCjglSD6XJwjf0LhvBKwaBOQtP3T8h2KaUml74JFcpe5tjB4smzA7eGpD+0Uudpe68gDfTGAJiUNlCH4Iq5shmD8rEGJthv2awGfeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOoq4U1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA285C32781;
	Wed, 10 Jul 2024 16:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720628774;
	bh=6SS1VzsAN02ABjDahpP3q5Q9MfB8o/CX8E1l3SuhboU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EOoq4U1ybtMOS83+O4Pt4y4wluYXnG29O5G4LSWXFYV7rH7syR0lBDZXcbc5UcYX/
	 kF7a+kOhG55Bs6NXCmkFwZOISzkENspnSwr20lmmJ4e4t1G9JWChqIj2cFUYHjr7qJ
	 vTRo+9wwBKa5v8080kSQHhQlUNv85enpW4fd+p71m4AdtrwBNuwW/SUgbxG354jNsB
	 56Hc7+4q62olrBxTzcuFPicf4rL7SCaydxmqd4S4V6N0yoXaZigjjMyB4RdORKLxLt
	 t6+nJ4XirQdY0UcjIyyOrqjGM3BXXDzn7z3d6qc6gxRqDu6003ehkGL+VNHUDUROZR
	 CcOJjjW1YTdjQ==
Date: Wed, 10 Jul 2024 09:26:14 -0700
From: Kees Cook <kees@kernel.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Steve Dower <steve.dower@python.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
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
	Jonathan Corbet <corbet@lwn.net>,
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
Message-ID: <202407100921.687BE1A6@keescook>
References: <20240704190137.696169-3-mic@digikod.net>
 <CALmYWFscz5W6xSXD-+dimzbj=TykNJEDa0m5gvBx93N-J+3nKA@mail.gmail.com>
 <CALmYWFsLUhkU5u1NKH8XWvSxbFKFOEq+A_eqLeDsN29xOEAYgg@mail.gmail.com>
 <20240708.quoe8aeSaeRi@digikod.net>
 <CALmYWFuVJiRZgB0ye9eR95dvBOigoOVShgS9i_ESjEre-H5pLA@mail.gmail.com>
 <ef3281ad-48a5-4316-b433-af285806540d@python.org>
 <CALmYWFuFE=V7sGp0_K+2Vuk6F0chzhJY88CP1CAE9jtd=rqcoQ@mail.gmail.com>
 <20240709.aech3geeMoh0@digikod.net>
 <CALmYWFuOXAiT05Pi2rZ1nUAKDGe9JyTH7fro2EYS1fh3zeGV5Q@mail.gmail.com>
 <20240710.eiKohpa4Phai@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240710.eiKohpa4Phai@digikod.net>

On Wed, Jul 10, 2024 at 11:58:25AM +0200, Mickaël Salaün wrote:
> Here is another proposal:
> 
> We can change a bit the semantic by making it the norm to always check
> file executability with AT_CHECK, and using the securebits to restrict
> file interpretation and/or command injection (e.g. user supplied shell
> commands).  Non-executable checked files can be reported/logged at the
> kernel level, with audit, configured by sysadmins.
> 
> New securebits (feel free to propose better names):
> 
> - SECBIT_EXEC_RESTRICT_FILE: requires AT_CHECK to pass.

Would you want the enforcement of this bit done by userspace or the
kernel?

IIUC, userspace would always perform AT_CHECK regardless of
SECBIT_EXEC_RESTRICT_FILE, and then which would happen?

1) userspace would ignore errors from AT_CHECK when
   SECBIT_EXEC_RESTRICT_FILE is unset

or

2) kernel would allow all AT_CHECK when SECBIT_EXEC_RESTRICT_FILE is
   unset

I suspect 1 is best and what you intend, given that
SECBIT_EXEC_DENY_INTERACTIVE can only be enforced by userspace.

> - SECBIT_EXEC_DENY_INTERACTIVE: deny any command injection via
>   command line arguments, environment variables, or configuration files.
>   This should be ignored by dynamic linkers.  We could also have an
>   allow-list of shells for which this bit is not set, managed by an
>   LSM's policy, if the native securebits scoping approach is not enough.
> 
> Different modes for script interpreters:
> 
> 1. RESTRICT_FILE=0 DENY_INTERACTIVE=0 (default)
>    Always interpret scripts, and allow arbitrary user commands.
>    => No threat, everyone and everything is trusted, but we can get
>    ahead of potential issues with logs to prepare for a migration to a
>    restrictive mode.
> 
> 2. RESTRICT_FILE=1 DENY_INTERACTIVE=0
>    Deny script interpretation if they are not executable, and allow
>    arbitrary user commands.
>    => Threat: (potential) malicious scripts run by trusted (and not
>       fooled) users.  That could protect against unintended script
>       executions (e.g. sh /tmp/*.sh).
>    ==> Makes sense for (semi-restricted) user sessions.
> 
> 3. RESTRICT_FILE=1 DENY_INTERACTIVE=1
>    Deny script interpretation if they are not executable, and also deny
>    any arbitrary user commands.
>    => Threat: malicious scripts run by untrusted users.
>    ==> Makes sense for system services executing scripts.
> 
> 4. RESTRICT_FILE=0 DENY_INTERACTIVE=1
>    Always interpret scripts, but deny arbitrary user commands.
>    => Goal: monitor/measure/assess script content (e.g. with IMA/EVM) in
>       a system where the access rights are not (yet) ready.  Arbitrary
>       user commands would be much more difficult to monitor.
>    ==> First step of restricting system services that should not
>        directly pass arbitrary commands to shells.

I like these bits!

-- 
Kees Cook

