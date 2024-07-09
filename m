Return-Path: <linux-fsdevel+bounces-23442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E50092C4D5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 22:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3406E281C15
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 20:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9813B187863;
	Tue,  9 Jul 2024 20:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="p6fMaJ47"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC67F152E1D
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 20:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557772; cv=none; b=sFLery1RB4PVnz0tQ7K/VAuZEoQSFLNcNCMirY8yO+iPvYXfVJa049Ggjg3W1Eaqn2aCG1Z/DksPFlGoC631o2SahyFW1zrpq0GYwRfQqawNmO2CCF5vftqqUBhJIsV/Me9h5Yne4cBw5rdIkWa/7atICHcutkD8dHcVee9vz+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557772; c=relaxed/simple;
	bh=1QBKXu3jqFWHp7ODXEq4PElTSHgXNyLv8UHEElkesGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=px73M3pVQf5tOMPVhibWykMWTy9N0gtPzl4xsfnkvK22ZlYcTrr3EXc5e5FVUAG4O25ivp/HIiyUCesNm0Qb3F8JE4pdDuE8e3i4dC/JLGS/MxyH9CAXU/Km+Uxd7zu3BNLn+5YbDCmf5ooUlN0CQYO5sPmWXeJxhQnLNRyjLgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=p6fMaJ47; arc=none smtp.client-ip=83.166.143.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WJXxF4bqpz7MX;
	Tue,  9 Jul 2024 22:42:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1720557761;
	bh=+M0cj9RJBsMQlDlXWmP2+vv32bVUSk1HwJJOYHICSoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p6fMaJ47GOnH3pyV97wzKVJkhfBcX43IFGH9mW68qQleai1N0F2E5svaC9Rpeni25
	 rODWCAzpEGcQyW354+RE76PuMO5fIDChw2WVaSHVjg0h+Wj55sNtGK5SZ3juJ/T99O
	 iuvNor9EklPGxRbDO5m72LLpb8sdTQt6OAwDTHxo=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WJXxD4M7kzVTf;
	Tue,  9 Jul 2024 22:42:40 +0200 (CEST)
Date: Tue, 9 Jul 2024 22:42:37 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jeff Xu <jeffxu@google.com>
Cc: Steve Dower <steve.dower@python.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Paul Moore <paul@paul-moore.com>, Theodore Ts'o <tytso@mit.edu>, 
	Alejandro Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Eric Chiang <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	James Morris <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jordan R Abrahams <ajordanr@google.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Luca Boccassi <bluca@debian.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Matthew Garrett <mjg59@srcf.ucam.org>, 
	Matthew Wilcox <willy@infradead.org>, Miklos Szeredi <mszeredi@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, 
	Scott Shell <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Steve Grubb <sgrubb@redhat.com>, 
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, Vincent Strubel <vincent.strubel@ssi.gouv.fr>, 
	Xiaoming Ni <nixiaoming@huawei.com>, Yin Fengwei <fengwei.yin@intel.com>, 
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v19 2/5] security: Add new SHOULD_EXEC_CHECK and
 SHOULD_EXEC_RESTRICT securebits
Message-ID: <20240709.aech3geeMoh0@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
 <20240704190137.696169-3-mic@digikod.net>
 <CALmYWFscz5W6xSXD-+dimzbj=TykNJEDa0m5gvBx93N-J+3nKA@mail.gmail.com>
 <CALmYWFsLUhkU5u1NKH8XWvSxbFKFOEq+A_eqLeDsN29xOEAYgg@mail.gmail.com>
 <20240708.quoe8aeSaeRi@digikod.net>
 <CALmYWFuVJiRZgB0ye9eR95dvBOigoOVShgS9i_ESjEre-H5pLA@mail.gmail.com>
 <ef3281ad-48a5-4316-b433-af285806540d@python.org>
 <CALmYWFuFE=V7sGp0_K+2Vuk6F0chzhJY88CP1CAE9jtd=rqcoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALmYWFuFE=V7sGp0_K+2Vuk6F0chzhJY88CP1CAE9jtd=rqcoQ@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Mon, Jul 08, 2024 at 03:07:24PM -0700, Jeff Xu wrote:
> On Mon, Jul 8, 2024 at 2:25 PM Steve Dower <steve.dower@python.org> wrote:
> >
> > On 08/07/2024 22:15, Jeff Xu wrote:
> > > IIUC:
> > > CHECK=0, RESTRICT=0: do nothing, current behavior
> > > CHECK=1, RESTRICT=0: permissive mode - ignore AT_CHECK results.
> > > CHECK=0, RESTRICT=1: call AT_CHECK, deny if AT_CHECK failed, no exception.
> > > CHECK=1, RESTRICT=1: call AT_CHECK, deny if AT_CHECK failed, except
> > > those in the "checked-and-allowed" list.
> >
> > I had much the same question for Mickaël while working on this.
> >
> > Essentially, "CHECK=0, RESTRICT=1" means to restrict without checking.
> > In the context of a script or macro interpreter, this just means it will
> > never interpret any scripts. Non-binary code execution is fully disabled
> > in any part of the process that respects these bits.
> >
> I see, so Mickaël does mean this will block all scripts.

That is the initial idea.

> I guess, in the context of dynamic linker, this means: no more .so
> loading, even "dlopen" is called by an app ?  But this will make the
> execve()  fail.

Hmm, I'm not sure this "CHECK=0, RESTRICT=1" configuration would make
sense for a dynamic linker except maybe if we want to only allow static
binaries?

The CHECK and RESTRICT securebits are designed to make it possible a
"permissive mode" and an enforcement mode with the related locked
securebits.  This is why this "CHECK=0, RESTRICT=1" combination looks a
bit weird.  We can replace these securebits with others but I didn't
find a better (and simple) option.  I don't think this is an issue
because with any security policy we can create unusable combinations.
The three other combinations makes a lot of sense though.

> 
> > "CHECK=1, RESTRICT=1" means to restrict unless AT_CHECK passes. This
> > case is the allow list (or whatever mechanism is being used to determine
> > the result of an AT_CHECK check). The actual mechanism isn't the
> > business of the script interpreter at all, it just has to refuse to
> > execute anything that doesn't pass the check. So a generic interpreter
> > can implement a generic mechanism and leave the specifics to whoever
> > configures the machine.
> >
> In the context of dynamic linker. this means:
> if .so passed the AT_CHECK, ldopen() can still load it.
> If .so fails the AT_CHECK, ldopen() will fail too.

Correct

> 
> Thanks
> -Jeff
> 
> > The other two case are more obvious. "CHECK=0, RESTRICT=0" is the
> > zero-overhead case, while "CHECK=1, RESTRICT=0" might log, warn, or
> > otherwise audit the result of the check, but it won't restrict execution.
> >
> > Cheers,
> > Steve

