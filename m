Return-Path: <linux-fsdevel+bounces-23469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAA692CED1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 12:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA43A1F23848
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 10:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1596118FC89;
	Wed, 10 Jul 2024 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="DNVbx2ud"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A386318FC74
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2024 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720605920; cv=none; b=m/CEN+5GA5Owh/45WF9Rk2XfjhdzT7pGMc5lNN+sIhY/rXSze/f7fJfPlPmKyOagrO7ip4b7DykCPODMKb2gPiPoHGlcNFDGI+9ANEjJgxNr3nVsW7J8yHqJU4RiX+gU7R0zwZapRZ9itOObXH8gGf/K5NYqYDzUscicXKOILV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720605920; c=relaxed/simple;
	bh=6XjeGM1uoLScdRWcAjqr9FYRJeKY3sUp1jjgMn0Q/rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hU4VWAqVE7J71HIBDGw+1MSEAu4JzVvgU3tmneGjaeb0NSOLWLf6WE6lMs3NfatXrMYiqlqd9LJ3qy/nFI/DL+f7QSJRnwXCHVjCpC8Xvxc/xbmwV000p39oUQfyzWYOTA/wAtlzOWha0uprSTomzn+U7pteemEXmywnR9jCe00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=DNVbx2ud; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WJtlB1RbmzSKT;
	Wed, 10 Jul 2024 12:05:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1720605910;
	bh=58eL5zKFVrJFUT+TpbxjO2RgasvOa3v7FdFqIaHbAZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DNVbx2udibxVu+14OKvyFsM2tte1G7+GSl8Z+NOcHcVVvvBg1ydxpZsw6h/1RkTaN
	 ejzvZofhsiG9dNul4ThaAxY28YALObLrSzblZ8Zjk8uwQdQKc/EuaduylSGnGw3pZ7
	 LEta7bCt/CqWCCKmMGDr9F+uKDtZtEAT6JChcVeQ=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WJtl848ghzL4p;
	Wed, 10 Jul 2024 12:05:08 +0200 (CEST)
Date: Wed, 10 Jul 2024 12:05:05 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Florian Weimer <fweimer@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Paul Moore <paul@paul-moore.com>, Theodore Ts'o <tytso@mit.edu>, 
	Alejandro Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Eric Chiang <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, James Morris <jamorris@linux.microsoft.com>, 
	Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jordan R Abrahams <ajordanr@google.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Luca Boccassi <bluca@debian.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Matthew Garrett <mjg59@srcf.ucam.org>, 
	Matthew Wilcox <willy@infradead.org>, Miklos Szeredi <mszeredi@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, 
	Scott Shell <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Steve Dower <steve.dower@python.org>, 
	Steve Grubb <sgrubb@redhat.com>, Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, 
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>, Xiaoming Ni <nixiaoming@huawei.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, linux-mm@kvack.org
Subject: Re: [PATCH] binfmt_elf: Fail execution of shared objects with
 ELIBEXEC (was: Re: [RFC PATCH v19 1/5] exec: Add a new AT_CHECK flag to
 execveat(2))
Message-ID: <20240710.Lu2thiemeil2@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
 <20240704190137.696169-2-mic@digikod.net>
 <87bk3bvhr1.fsf@oldenburg.str.redhat.com>
 <20240706.poo9ahd3La9b@digikod.net>
 <871q46bkoz.fsf@oldenburg.str.redhat.com>
 <20240708.zooj9Miaties@digikod.net>
 <878qybet6t.fsf_-_@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878qybet6t.fsf_-_@oldenburg.str.redhat.com>
X-Infomaniak-Routing: alpha

On Mon, Jul 08, 2024 at 06:37:14PM +0200, Florian Weimer wrote:
> * Mickaël Salaün:
> 
> > On Sat, Jul 06, 2024 at 05:32:12PM +0200, Florian Weimer wrote:
> >> * Mickaël Salaün:
> >> 
> >> > On Fri, Jul 05, 2024 at 08:03:14PM +0200, Florian Weimer wrote:
> >> >> * Mickaël Salaün:
> >> >> 
> >> >> > Add a new AT_CHECK flag to execveat(2) to check if a file would be
> >> >> > allowed for execution.  The main use case is for script interpreters and
> >> >> > dynamic linkers to check execution permission according to the kernel's
> >> >> > security policy. Another use case is to add context to access logs e.g.,
> >> >> > which script (instead of interpreter) accessed a file.  As any
> >> >> > executable code, scripts could also use this check [1].
> >> >> 
> >> >> Some distributions no longer set executable bits on most shared objects,
> >> >> which I assume would interfere with AT_CHECK probing for shared objects.
> >> >
> >> > A file without the execute permission is not considered as executable by
> >> > the kernel.  The AT_CHECK flag doesn't change this semantic.  Please
> >> > note that this is just a check, not a restriction.  See the next patch
> >> > for the optional policy enforcement.
> >> >
> >> > Anyway, we need to define the policy, and for Linux this is done with
> >> > the file permission bits.  So for systems willing to have a consistent
> >> > execution policy, we need to rely on the same bits.
> >> 
> >> Yes, that makes complete sense.  I just wanted to point out the odd
> >> interaction with the old binutils bug and the (sadly still current)
> >> kernel bug.
> >> 
> >> >> Removing the executable bit is attractive because of a combination of
> >> >> two bugs: a binutils wart which until recently always set the entry
> >> >> point address in the ELF header to zero, and the kernel not checking for
> >> >> a zero entry point (maybe in combination with an absent program
> >> >> interpreter) and failing the execve with ELIBEXEC, instead of doing the
> >> >> execve and then faulting at virtual address zero.  Removing the
> >> >> executable bit is currently the only way to avoid these confusing
> >> >> crashes, so I understand the temptation.
> >> >
> >> > Interesting.  Can you please point to the bug report and the fix?  I
> >> > don't see any ELIBEXEC in the kernel.
> >> 
> >> The kernel hasn't been fixed yet.  I do think this should be fixed, so
> >> that distributions can bring back the executable bit.
> >
> > Can you please point to the mailing list discussion or the bug report?
> 
> I'm not sure if this was ever reported upstream as an RFE to fail with
> ELIBEXEC.  We have downstream bug report:
> 
>   Prevent executed .so files with e_entry == 0 from attempting to become
>   a process.
>   <https://bugzilla.redhat.com/show_bug.cgi?id=2004942>

Thanks for the info.

> 
> I've put together a patch which seems to work, see below.
> 
> I don't think there's any impact on AT_CHECK with execveat because that
> mode will never get to this point.

Correct, that is not an issue for AT_CHECK use cases.

