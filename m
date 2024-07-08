Return-Path: <linux-fsdevel+bounces-23327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1E492A9E5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 21:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247761F21E01
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 19:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A9514A61A;
	Mon,  8 Jul 2024 19:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jfb5YOAv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DD11CD2B;
	Mon,  8 Jul 2024 19:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720467500; cv=none; b=m8lvAYbmfdg7QGGB3g4zlHOpR2PePe/K+7c3j27mbHxbeGd2+XLshTqNySSqJ/lNoZQcPfhvxCYzeyfZ5UbgT1Etqk2lpSMOmL4B6HUgv06j+xiPyG8/XKlWuipPhk6CZRthwyk9tEePKQOUkDrVoyJ4ULJ4vqDmvChX9ASy7q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720467500; c=relaxed/simple;
	bh=e5oHiwwZ0DY7Dmv393o9ZUxAt+dMtNFWFPwbkMtnVJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CX0O0owb6TOb/HBNhzyL41pecY2E1nykaC0pGCVIZB8F5lCNhtNuC0SqNZ1oxw253Ql/Q3hBXHpYDRBShzuvxy01bp//5Dn7Jin0xSqL/egb5Wb5U0StawqspLaDnjbB8aLCmIQcSysaZdEhyWniMuYzQX9xIQ3rjtSXbIVeBnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jfb5YOAv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050BFC116B1;
	Mon,  8 Jul 2024 19:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720467500;
	bh=e5oHiwwZ0DY7Dmv393o9ZUxAt+dMtNFWFPwbkMtnVJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jfb5YOAvhFAWSlZd9EaSBneZ/YcVipzNxWs4j8tWUSij/ubtl3hRK2uYE+qVesZk8
	 L+ZMtxuh+PC5igYpPTqAUN1mef7sfB2u6n/PWF0O8s3cbQmc0OxIs49tnpe/fdX6Q7
	 P/yKUh0CNat8czIKYGHk/p/ioGlbNn8Dn4gMc15PHkuUQ/VC2/GkSGooGnAXzMVgpb
	 2rkWcXcpWR3oZIR4MGr5SJPDPwtdVVOLu+uft6AMPYOl0CGNmO0vg1F2Q9Kc/xWLCB
	 REf//u5kAPiLeRho9Yfk8b8TcVfRACOr0RIAzQibnvhTJ03AjzgTNn2CDd9k86IOj2
	 5XOChLcu7orZQ==
Date: Mon, 8 Jul 2024 12:38:19 -0700
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
Subject: Re: [RFC PATCH v19 1/5] exec: Add a new AT_CHECK flag to execveat(2)
Message-ID: <202407081237.42C50C2F7@keescook>
References: <20240704190137.696169-1-mic@digikod.net>
 <20240704190137.696169-2-mic@digikod.net>
 <202407041656.3A05153@keescook>
 <20240705.uch1saeNi6mo@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240705.uch1saeNi6mo@digikod.net>

On Fri, Jul 05, 2024 at 07:53:10PM +0200, Mickaël Salaün wrote:
> On Thu, Jul 04, 2024 at 05:04:03PM -0700, Kees Cook wrote:
> > On Thu, Jul 04, 2024 at 09:01:33PM +0200, Mickaël Salaün wrote:
> > > Add a new AT_CHECK flag to execveat(2) to check if a file would be
> > > allowed for execution.  The main use case is for script interpreters and
> > > dynamic linkers to check execution permission according to the kernel's
> > > security policy. Another use case is to add context to access logs e.g.,
> > > which script (instead of interpreter) accessed a file.  As any
> > > executable code, scripts could also use this check [1].
> > > 
> > > This is different than faccessat(2) which only checks file access
> > > rights, but not the full context e.g. mount point's noexec, stack limit,
> > > and all potential LSM extra checks (e.g. argv, envp, credentials).
> > > Since the use of AT_CHECK follows the exact kernel semantic as for a
> > > real execution, user space gets the same error codes.
> > 
> > Nice! I much prefer this method of going through the exec machinery so
> > we always have a single code path for these kinds of checks.
> > 
> > > Because AT_CHECK is dedicated to user space interpreters, it doesn't
> > > make sense for the kernel to parse the checked files, look for
> > > interpreters known to the kernel (e.g. ELF, shebang), and return ENOEXEC
> > > if the format is unknown.  Because of that, security_bprm_check() is
> > > never called when AT_CHECK is used.
> > 
> > I'd like some additional comments in the code that reminds us that
> > access control checks have finished past a certain point.
> 
> Where in the code? Just before the bprm->is_check assignment?

Yeah, that's what I was thinking.

-- 
Kees Cook

