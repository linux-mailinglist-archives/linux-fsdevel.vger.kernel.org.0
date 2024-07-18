Return-Path: <linux-fsdevel+bounces-23914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AEF934D21
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 14:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092D11F2143F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 12:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B5913CFA3;
	Thu, 18 Jul 2024 12:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="gy83JArL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4590713C67D
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 12:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721305416; cv=none; b=leoEquWTaX19ve0iWVxPQaEnPvPL/ZXptWpq0ZLaJ2IBXFTD+oIBihiFe0ew70GVnHJ8EMFvcn6vcQGmMJHSeadXB97/jvBsxfLuO8nEd6wZ6++fdsQ2atTZqP5nqohTsEntYOm3JX7hyW2h4DbXPrdLes+3U1GiLGZF/a3tEOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721305416; c=relaxed/simple;
	bh=tCO23iD0368Et/1o4qT6WL+wA0X9IKDVICq61hs8H5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7VbLWkfaDS8oNnP95Pqa7RzR2dn8CLRHqvlSf7a+FsJxSHiSL3zSgrD3STkP6Mm1brlXMa8UJjsMEVOduTA5jxt87sjTSW6V6fP5Hh/YecCsDv4LW+zZ/WbTIdIL4JjUmS9rL5Upt5HCCjQb3iE62yoqwFS3qXQg53KoqjhaKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=gy83JArL; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WPsQy5jNMzQ3K;
	Thu, 18 Jul 2024 14:23:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721305402;
	bh=2miiI/5j4wTJs9zVbOsNd+rOxv6jp8fs/L7lmo5Xt3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gy83JArLMq864jKTREMY1Kn2Kfo3QT5j03SQkLmXwJryYVvObFoTAR0tvHMpGFGPN
	 URCOIjHWu2cVo1uWWxNDPbO0VqEVGtxcbbezzRaNyXizzRIpp/q6ln8nyKGU/scq+u
	 fBbAw+t6lcv38UVvqf0UWNtLJfRnqBjQr2qzl5lM=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WPsQx5DMZzp3w;
	Thu, 18 Jul 2024 14:23:21 +0200 (CEST)
Date: Thu, 18 Jul 2024 14:23:19 +0200
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
	linux-security-module@vger.kernel.org, Elliott Hughes <enh@google.com>
Subject: Re: [RFC PATCH v19 1/5] exec: Add a new AT_CHECK flag to execveat(2)
Message-ID: <20240718.ahph4che5Shi@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
 <20240704190137.696169-2-mic@digikod.net>
 <CALmYWFss7qcpR9D_r3pbP_Orxs55t3y3yXJsac1Wz=Hk9Di0Nw@mail.gmail.com>
 <a0da7702-dabe-49e4-87f4-5d6111f023a8@python.org>
 <20240717.AGh2shahc9ee@digikod.net>
 <CALmYWFvxJSyi=BT5BKDiKCNanmbhLuZ6=iAMvv1ibnP24SC7fA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALmYWFvxJSyi=BT5BKDiKCNanmbhLuZ6=iAMvv1ibnP24SC7fA@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Jul 17, 2024 at 06:51:11PM -0700, Jeff Xu wrote:
> On Wed, Jul 17, 2024 at 3:00 AM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > On Wed, Jul 17, 2024 at 09:26:22AM +0100, Steve Dower wrote:
> > > On 17/07/2024 07:33, Jeff Xu wrote:
> > > > Consider those cases: I think:
> > > > a> relying purely on userspace for enforcement does't seem to be
> > > > effective,  e.g. it is trivial  to call open(), then mmap() it into
> > > > executable memory.
> > >
> > > If there's a way to do this without running executable code that had to pass
> > > a previous execveat() check, then yeah, it's not effective (e.g. a Python
> > > interpreter that *doesn't* enforce execveat() is a trivial way to do it).
> > >
> > > Once arbitrary code is running, all bets are off. So long as all arbitrary
> > > code is being checked itself, it's allowed to do things that would bypass
> > > later checks (and it's up to whoever audited it in the first place to
> > > prevent this by not giving it the special mark that allows it to pass the
> > > check).
> >
> We will want to define what is considered as "arbitrary code is running"
> 
> Using an example of ROP, attackers change the return address in stack,
> e.g. direct the execution flow to a gauge to call "ld.so /tmp/a.out",
> do you consider "arbitrary code is running" when stack is overwritten
> ? or after execve() is called.

Yes, ROP is arbitrary code execution (which can be mitigated with CFI).
ROP could be enough to interpret custom commands and create a small
interpreter/VM.

> If it is later, this patch can prevent "ld.so /tmp/a.out".
> 
> > Exactly.  As explained in the patches, one crucial prerequisite is that
> > the executable code is trusted, and the system must provide integrity
> > guarantees.  We cannot do anything without that.  This patches series is
> > a building block to fix a blind spot on Linux systems to be able to
> > fully control executability.
> 
> Even trusted executable can have a bug.

Definitely, but this patch series is dedicated to script execution
control.

> 
> I'm thinking in the context of ChromeOS, where all its system services
> are from trusted partitions, and legit code won't load .so from a
> non-exec mount.  But we want to sandbox those services, so even under
> some kind of ROP attack, the service still won't be able to load .so
> from /tmp. Of course, if an attacker can already write arbitrary
> length of data into the stack, it is probably already a game over.
> 

OK, you want to tie executable file permission to mmap.  That makes
sense if you have a consistent execution model.  This can be enforced by
LSMs.  Contrary to script interpretation which is a full user space
implementation (and then controlled by user space), mmap restrictions
should indeed be enforced by the kernel.

