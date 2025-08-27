Return-Path: <linux-fsdevel+bounces-59345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F301EB37D79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 10:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE4D6365D37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 08:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124FA335BB5;
	Wed, 27 Aug 2025 08:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="nIwesNdK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DAE3164CE
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 08:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756282756; cv=none; b=X4ED+nQqscOaEx9oTnU/cgAYPJIqp+0vN6SlbMNhc+Cguewu+5F6ni7ujPWO4XTojEUcGO9SFn8SIoAysiyn27oTj0kvvpxZaIe3Xslt/WYduRwYZs1XmEBwwZrNrwWWF3F2w7cz5K6+K8AqacJLIJUwIGN7CK2ficeCqJEhtmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756282756; c=relaxed/simple;
	bh=nAP7BNBf756Gwyh56tn1SBrfZqWQsDLT5o0gXuy+g2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeF4+CpJP0qCzhTh+G7dZ+sgVzU4m3bSgYysyKg6N4TsH+o43W7xLaWgQLqolfEJ+4i8VOTkMl0cU4RK3M3HCxVpIyXQw73Ib59ywny3EfGGF51i4kGl/ZL74gJV/IaGMmHehvGBMGlZ+tm3Y352jiVy5dTr/z0BJgcyKwQXako=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=nIwesNdK; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cBcr92zqHzSsR;
	Wed, 27 Aug 2025 10:19:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1756282745;
	bh=T4RPei0DtLnnZYB66tK2dsxFQ5Fek+OuCR7/tQ4qCMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nIwesNdKHJfaQDzsU5qqtQNkWy5jqrsWIlIG7pLsa+xQyzF9Nn3bysidzhtBEq4s5
	 auix8D4X4Equ4OtaucY/q3K3HRCqT4s5FmKpQqbFkcZA8vYC9APYiHXG6rBWBRj6Lp
	 NFA+uIf2ecqGASyaInKvnjJQfy33/h63EhiHs8LI=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4cBcr74Cmwzwcw;
	Wed, 27 Aug 2025 10:19:03 +0200 (CEST)
Date: Wed, 27 Aug 2025 10:19:02 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <keescook@chromium.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <serge@hallyn.com>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Elliott Hughes <enh@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jordan R Abrahams <ajordanr@google.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Luca Boccassi <bluca@debian.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Robert Waite <rowait@microsoft.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Scott Shell <scottsh@microsoft.com>, Steve Dower <steve.dower@python.org>, 
	Steve Grubb <sgrubb@redhat.com>, kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/2] Add O_DENY_WRITE (complement AT_EXECVE_CHECK)
Message-ID: <20250827.ShuD9thahkoh@digikod.net>
References: <20250822170800.2116980-1-mic@digikod.net>
 <20250826-skorpion-magma-141496988fdc@brauner>
 <20250826.aig5aiShunga@digikod.net>
 <20250826123041.GB1603531@mit.edu>
 <20250826.iewie7Et5aiw@digikod.net>
 <20250826205057.GC1603531@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250826205057.GC1603531@mit.edu>
X-Infomaniak-Routing: alpha

On Tue, Aug 26, 2025 at 04:50:57PM -0400, Theodore Ts'o wrote:
> On Tue, Aug 26, 2025 at 07:47:30PM +0200, Mickaël Salaün wrote:
> > 
> >   Passing the AT_EXECVE_CHECK flag to execveat(2) only performs a check
> >   on a regular file and returns 0 if execution of this file would be
> >   allowed, ignoring the file format and then the related interpreter
> >   dependencies (e.g. ELF libraries, script’s shebang).
> 
> But if that's it, why can't the script interpreter (python, bash,
> etc.) before executing the script, checks for executability via
> faccessat(2) or fstat(2)?

From commit a5874fde3c08 ("exec: Add a new AT_EXECVE_CHECK flag to
execveat(2)"):

    This is different from faccessat(2) + X_OK which only checks a subset of
    access rights (i.e. inode permission and mount options for regular
    files), but not the full context (e.g. all LSM access checks).  The main
    use case for access(2) is for SUID processes to (partially) check access
    on behalf of their caller.  The main use case for execveat(2) +
    AT_EXECVE_CHECK is to check if a script execution would be allowed,
    according to all the different restrictions in place.  Because the use
    of AT_EXECVE_CHECK follows the exact kernel semantic as for a real
    execution, user space gets the same error codes.


> 
> The whole O_DONY_WRITE dicsussion seemed to imply that AT_EXECVE_CHECK
> was doing more than just the executability check?

I would say that that AT_EXECVE_CHECK does a full executability check
(with the full caller's credentials checked against the currently
enforced security policy).

The rationale to add O_DENY_WRITE (which is now abandoned) was to avoid a race
condition between the check and the full read.  Indeed, with a full
execveat(2), the kernel write-lock the file to avoid such issue (which can lead
to other issues).

> 
> > There is no other way for user space to reliably check executability of
> > files (taking into account all enforced security
> > policies/configurations).
> 
> Why doesn't faccessat(2) or fstat(2) suffice?  This is why having a
> more substantive requirements and design doc might be helpful.  It
> appears you have some assumptions that perhaps other kernel developers
> are not aware.  I certainly seem to be missing something.....

My reasoning was to explain the rationale for a kernel feature in the commit
message, and the user doc (why and how to use it) in the user-facing
documentation.  Documentation improvements are welcome!

