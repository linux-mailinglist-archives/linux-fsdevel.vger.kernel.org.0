Return-Path: <linux-fsdevel+bounces-23274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E601929E90
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 10:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18E5F28337D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 08:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2245579F;
	Mon,  8 Jul 2024 08:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="0MfGmOLJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B0F47F53;
	Mon,  8 Jul 2024 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720429040; cv=none; b=tZeVDWLGresdKc7DQBv+V4lx5+Ilrtwfy+VHjXzwL0CZSsNUNetUb9VLDa7rEt4aFEmJcyoMKb5hgaFofxbq4TLUngoPt2meu5WzS0wJqJKVAgZ0aYQEETXic8GcQkaYepXadLiYbTffqZKVoPFfE3k9JwqFMzHnsjZ5DVBOJlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720429040; c=relaxed/simple;
	bh=Cb1AF0mLzMpKLDzenlvnWCSwmMf5JIIi0U9107W5+ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAk31DnJzBvjmUQjMC5yhwpmuwlQg64nqJ3Qw29xNkhYU5rX29cgJmS8pc9w56DZ6ENv2KpuMsp2AXGY5/DUPpCiOCxz8fwxGzh1dIbzNOWHUH1kdJKwPosw1r6vmeVkN4CaNtTcrVNeo9VjK/hrKs2kR0dmwF/rrsBTVdIxZcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=0MfGmOLJ; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WHdKc1k4lzkyc;
	Mon,  8 Jul 2024 10:57:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1720429028;
	bh=7bLt7WxO3ulEYXhk1rhXT6KKMcWMaVDQidRXNgAZAWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0MfGmOLJXnmucGesfHgTcGIrV1AuYeLm7OPKPfCmEW0e1L+aQfqE3m5322nbHkmbp
	 o/g25CO5nyDvvCCX0mNrl+9Vxi2omD86s/oTmd2DYsR4YvIMPmAftfijfVaZPvAxYt
	 1uPPfRCpd1M7aQnk90+oYq6XmUBltSw7ahYrQLDs=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WHdKV00tCzWdS;
	Mon,  8 Jul 2024 10:57:01 +0200 (CEST)
Date: Mon, 8 Jul 2024 10:56:59 +0200
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
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v19 1/5] exec: Add a new AT_CHECK flag to execveat(2)
Message-ID: <20240708.zooj9Miaties@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
 <20240704190137.696169-2-mic@digikod.net>
 <87bk3bvhr1.fsf@oldenburg.str.redhat.com>
 <20240706.poo9ahd3La9b@digikod.net>
 <871q46bkoz.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871q46bkoz.fsf@oldenburg.str.redhat.com>
X-Infomaniak-Routing: alpha

On Sat, Jul 06, 2024 at 05:32:12PM +0200, Florian Weimer wrote:
> * Mickaël Salaün:
> 
> > On Fri, Jul 05, 2024 at 08:03:14PM +0200, Florian Weimer wrote:
> >> * Mickaël Salaün:
> >> 
> >> > Add a new AT_CHECK flag to execveat(2) to check if a file would be
> >> > allowed for execution.  The main use case is for script interpreters and
> >> > dynamic linkers to check execution permission according to the kernel's
> >> > security policy. Another use case is to add context to access logs e.g.,
> >> > which script (instead of interpreter) accessed a file.  As any
> >> > executable code, scripts could also use this check [1].
> >> 
> >> Some distributions no longer set executable bits on most shared objects,
> >> which I assume would interfere with AT_CHECK probing for shared objects.
> >
> > A file without the execute permission is not considered as executable by
> > the kernel.  The AT_CHECK flag doesn't change this semantic.  Please
> > note that this is just a check, not a restriction.  See the next patch
> > for the optional policy enforcement.
> >
> > Anyway, we need to define the policy, and for Linux this is done with
> > the file permission bits.  So for systems willing to have a consistent
> > execution policy, we need to rely on the same bits.
> 
> Yes, that makes complete sense.  I just wanted to point out the odd
> interaction with the old binutils bug and the (sadly still current)
> kernel bug.
> 
> >> Removing the executable bit is attractive because of a combination of
> >> two bugs: a binutils wart which until recently always set the entry
> >> point address in the ELF header to zero, and the kernel not checking for
> >> a zero entry point (maybe in combination with an absent program
> >> interpreter) and failing the execve with ELIBEXEC, instead of doing the
> >> execve and then faulting at virtual address zero.  Removing the
> >> executable bit is currently the only way to avoid these confusing
> >> crashes, so I understand the temptation.
> >
> > Interesting.  Can you please point to the bug report and the fix?  I
> > don't see any ELIBEXEC in the kernel.
> 
> The kernel hasn't been fixed yet.  I do think this should be fixed, so
> that distributions can bring back the executable bit.

Can you please point to the mailing list discussion or the bug report?

