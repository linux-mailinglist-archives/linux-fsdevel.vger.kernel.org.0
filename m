Return-Path: <linux-fsdevel+bounces-58892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A62EFB32F39
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Aug 2025 13:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB5694486CC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Aug 2025 11:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAE6275B0E;
	Sun, 24 Aug 2025 11:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="1WXDHzqg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [83.166.143.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEF617C91;
	Sun, 24 Aug 2025 11:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756033408; cv=none; b=M20Fj2UMWeRSbxq5fdvfJaHB6oQbObxs2HuPn87PiT+nf+InN8oXiYNSlALb1LLTg2iw4yg1d33sqpjdIqQ+GlvvsCzJighm0ksDwBdsDftbhwMwymAtDekr4opppBxUdW6WzmApN4uAVDVLgNjq+Tul7CFLUnCVLRwjd++V7QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756033408; c=relaxed/simple;
	bh=zhuxzzhCeIpMw+ZyZuGmrlzOFR/5Ur5sddoaNjY8BH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Woa4cQCL90B+dL1Fqw1rismCOFWAMxOLxVl+sUmzsu8fPJqjFz8hdG8n64A0XU++3FTRttOpJtCYAodW1pPaHdYKQcUlwObF2P1ewHQXXIk/yjM7Ns9pnYlf2h5pijb9zEV9+rrtkUB4s5jjaJUi3+0m3/dXcaPsFxI47y1ak/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=1WXDHzqg; arc=none smtp.client-ip=83.166.143.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4c8rd05FnbzRc5;
	Sun, 24 Aug 2025 13:03:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1756033396;
	bh=npswCwX0a24vJxWw7gY+qI0TbgVywqqUB4cDV+3jp+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1WXDHzqg/P9JB/nnDxxpueGJBM3RmJ6uqsbQWCIbvmI2W8btShCyr99j6/RnOTwsd
	 zvp2JBaO4ueW7lSCf6nU1zM8s2cg1npfkPPbhf5gTLdumHsaPBFkmqP8jj9SHE39CQ
	 MxIho8S6SakTYtQbqpej882GLb/vs7g55Ho0kuzI=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4c8rcw4v18zt0L;
	Sun, 24 Aug 2025 13:03:12 +0200 (CEST)
Date: Sun, 24 Aug 2025 13:03:09 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jann Horn <jannh@google.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <serge@hallyn.com>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Elliott Hughes <enh@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Robert Waite <rowait@microsoft.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Scott Shell <scottsh@microsoft.com>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, 
	Jeff Xu <jeffxu@chromium.org>
Subject: Re: [RFC PATCH v1 1/2] fs: Add O_DENY_WRITE
Message-ID: <20250824.Ujoh8unahy5a@digikod.net>
References: <20250822170800.2116980-1-mic@digikod.net>
 <20250822170800.2116980-2-mic@digikod.net>
 <CAG48ez1XjUdcFztc_pF2qcoLi7xvfpJ224Ypc=FoGi-Px-qyZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1XjUdcFztc_pF2qcoLi7xvfpJ224Ypc=FoGi-Px-qyZw@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Fri, Aug 22, 2025 at 09:45:32PM +0200, Jann Horn wrote:
> On Fri, Aug 22, 2025 at 7:08 PM Mickaël Salaün <mic@digikod.net> wrote:
> > Add a new O_DENY_WRITE flag usable at open time and on opened file (e.g.
> > passed file descriptors).  This changes the state of the opened file by
> > making it read-only until it is closed.  The main use case is for script
> > interpreters to get the guarantee that script' content cannot be altered
> > while being read and interpreted.  This is useful for generic distros
> > that may not have a write-xor-execute policy.  See commit a5874fde3c08
> > ("exec: Add a new AT_EXECVE_CHECK flag to execveat(2)")
> >
> > Both execve(2) and the IOCTL to enable fsverity can already set this
> > property on files with deny_write_access().  This new O_DENY_WRITE make
> 
> The kernel actually tried to get rid of this behavior on execve() in
> commit 2a010c41285345da60cece35575b4e0af7e7bf44.; but sadly that had
> to be reverted in commit 3b832035387ff508fdcf0fba66701afc78f79e3d
> because it broke userspace assumptions.

Oh, good to know.

> 
> > it widely available.  This is similar to what other OSs may provide
> > e.g., opening a file with only FILE_SHARE_READ on Windows.
> 
> We used to have the analogous mmap() flag MAP_DENYWRITE, and that was
> removed for security reasons; as
> https://man7.org/linux/man-pages/man2/mmap.2.html says:
> 
> |        MAP_DENYWRITE
> |               This flag is ignored.  (Long ago—Linux 2.0 and earlier—it
> |               signaled that attempts to write to the underlying file
> |               should fail with ETXTBSY.  But this was a source of denial-
> |               of-service attacks.)"
> 
> It seems to me that the same issue applies to your patch - it would
> allow unprivileged processes to essentially lock files such that other
> processes can't write to them anymore. This might allow unprivileged
> users to prevent root from updating config files or stuff like that if
> they're updated in-place.

Yes, I agree, but since it is the case for executed files I though it
was worth starting a discussion on this topic.  This new flag could be
restricted to executable files, but we should avoid system-wide locks
like this.  I'm not sure how Windows handle these issues though.

Anyway, we should rely on the access control policy to control write and
execute access in a consistent way (e.g. write-xor-execute).  Thanks for
the references and the background!

