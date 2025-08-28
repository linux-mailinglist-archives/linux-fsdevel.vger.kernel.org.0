Return-Path: <linux-fsdevel+bounces-59525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5944B3AC6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C78172CEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 21:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A30030EF7E;
	Thu, 28 Aug 2025 21:01:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901DB29ACC0;
	Thu, 28 Aug 2025 21:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414878; cv=none; b=QTqNnjJSUjoU3Qb6rYsgkiiIzXnbiEUFU5zxWrGCnyfcSWWElUxN+oQ0x9VeH+gjjPxcaAhFRuYovLku2IR0iyI3ebBxnsXftzBbgHKuTIdFHbyTQ/agsSkjhEJrVhtsM6KUoc+Qi0mol9sHTEeQhh6d/IlrHaZiKu9X9QRJn5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414878; c=relaxed/simple;
	bh=6fkQFSGQvqVzVgsB612AOtefqBcF6RpXwcdHFKAEcMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prATWFMGa4AvuUVoyRyklW74gRF4niHRLRmQOzVpZSwFTvPl0+jZR2y3FXCj8flr+u8rhgBD2vIBgjNssUJoWXLZUpi46ZSNpxoEPP98fNl2LYT3i/YrbBA3hlciiggqUwWBMajIvR6CdlmvomDS+damYOKNm1fUTupa7VXssWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id A988F201; Thu, 28 Aug 2025 16:01:07 -0500 (CDT)
Date: Thu, 28 Aug 2025 16:01:07 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <serge@hallyn.com>, Arnd Bergmann <arnd@arndb.de>,
	Christian Heimes <christian@python.org>,
	Dmitry Vyukov <dvyukov@google.com>, Elliott Hughes <enh@google.com>,
	Fan Wu <wufan@linux.microsoft.com>,
	Florian Weimer <fweimer@redhat.com>, Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Jordan R Abrahams <ajordanr@google.com>,
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
	Luca Boccassi <bluca@debian.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Robert Waite <rowait@microsoft.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Scott Shell <scottsh@microsoft.com>,
	Steve Dower <steve.dower@python.org>,
	Steve Grubb <sgrubb@redhat.com>,
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/2] Add O_DENY_WRITE (complement AT_EXECVE_CHECK)
Message-ID: <aLDDk4x7QBKxLmoi@mail.hallyn.com>
References: <20250822170800.2116980-1-mic@digikod.net>
 <20250826-skorpion-magma-141496988fdc@brauner>
 <20250826.aig5aiShunga@digikod.net>
 <2025-08-27-obscene-great-toy-diary-X1gVRV@cyphar.com>
 <CALCETrWHKga33bvzUHnd-mRQUeNXTtXSS8Y8+40d5bxv-CqBhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrWHKga33bvzUHnd-mRQUeNXTtXSS8Y8+40d5bxv-CqBhw@mail.gmail.com>

On Wed, Aug 27, 2025 at 05:32:02PM -0700, Andy Lutomirski wrote:
> On Wed, Aug 27, 2025 at 5:14 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
> >
> > On 2025-08-26, Mickaël Salaün <mic@digikod.net> wrote:
> > > On Tue, Aug 26, 2025 at 11:07:03AM +0200, Christian Brauner wrote:
> > > > Nothing has changed in that regard and I'm not interested in stuffing
> > > > the VFS APIs full of special-purpose behavior to work around the fact
> > > > that this is work that needs to be done in userspace. Change the apps,
> > > > stop pushing more and more cruft into the VFS that has no business
> > > > there.
> > >
> > > It would be interesting to know how to patch user space to get the same
> > > guarantees...  Do you think I would propose a kernel patch otherwise?
> >
> > You could mmap the script file with MAP_PRIVATE. This is the *actual*
> > protection the kernel uses against overwriting binaries (yes, ETXTBSY is
> > nice but IIRC there are ways to get around it anyway).
> 
> Wait, really?  MAP_PRIVATE prevents writes to the mapping from
> affecting the file, but I don't think that writes to the file will
> break the MAP_PRIVATE CoW if it's not already broken.
> 
> IPython says:
> 
> In [1]: import mmap, tempfile
> 
> In [2]: f = tempfile.TemporaryFile()
> 
> In [3]: f.write(b'initial contents')
> Out[3]: 16
> 
> In [4]: f.flush()
> 
> In [5]: map = mmap.mmap(f.fileno(), f.tell(), flags=mmap.MAP_PRIVATE,
> prot=mmap.PROT_READ)
> 
> In [6]: map[:]
> Out[6]: b'initial contents'
> 
> In [7]: f.seek(0)
> Out[7]: 0
> 
> In [8]: f.write(b'changed')
> Out[8]: 7
> 
> In [9]: f.flush()
> 
> In [10]: map[:]
> Out[10]: b'changed contents'

That was surprising to me, however, if I split the reader
and writer into different processes, so

P1:
f = open("/tmp/3", "w")
f.write('initial contents')
f.flush()

P2:
import mmap
f = open("/tmp/3", "r")
map = mmap.mmap(f.fileno(), f.tell(), flags=mmap.MAP_PRIVATE, prot=mmap.PROT_READ)

Back to P1:
f.seek(0)
f.write('changed')

Back to P2:
map[:]

Then P2 gives me:

b'initial contents'

-serge

