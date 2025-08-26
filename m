Return-Path: <linux-fsdevel+bounces-59192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E22EAB35F32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 14:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AEE8462ADE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 12:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB04338F51;
	Tue, 26 Aug 2025 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="DVv3Cy/r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A512FAC02
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 12:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756211723; cv=none; b=Sw1FiZmoasCoqemY4NHT+2Gf3Q6c7ISngW7LIs0tmYPIY3ztfH/yhSMJqhY+96ku6BtrtmvjesKyTHMKOU64qU2tf4WG14Az8rFZB/CM/BzzNGsgPB3bAJ9SHOAQn0eNTWEo+1UBFCkzbH7dClUfPxYp4D7hxXAnm+bYcHOwGc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756211723; c=relaxed/simple;
	bh=rlitfwKw6m8qm0mxEs/6cnYt/upIMsMd+WjUZGJict0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gexo0AzrZaMJn9AIrRT4QsALN36/EXq+0GZb6tH3GHV6VrOG4RyA+9dadvFUt5CVFjEqDQxjyWqTEgrf6z1BBlUg4c5BK2okzJOAqBabvO5PAn/dpTbGazfDXOjG1lgYLWYvtaf/LBKepFyZ6qegfDc8hUL/kVxZjWc8oJDckrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=DVv3Cy/r; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cB6Z738bNzLcG;
	Tue, 26 Aug 2025 14:35:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1756211711;
	bh=R8XQ+qnr9SZ/BmQ7yIcGbNm53gzbfSqxt8B1gBqiUxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DVv3Cy/rQOpb1FageSeGpGJiQ0vQ9qK2YvEr44f/YXumQ0jgQLQbn01zyRrrPE6Fr
	 ztkIi3ltRzcLAUKGOSoRq/UYWQx6o+d/49io54LxzL/W9LzI8HgvK9kN3UmFUeBspK
	 JjbE8yzV9pYsgoKq3TcmYBkfEPA4TM5OCUV87IGQ=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4cB6Z44FXQztlg;
	Tue, 26 Aug 2025 14:35:08 +0200 (CEST)
Date: Tue, 26 Aug 2025 14:35:08 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Florian Weimer <fweimer@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>, Jann Horn <jannh@google.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <serge@hallyn.com>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Elliott Hughes <enh@google.com>, Fan Wu <wufan@linux.microsoft.com>, Jeff Xu <jeffxu@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jordan R Abrahams <ajordanr@google.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Luca Boccassi <bluca@debian.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Robert Waite <rowait@microsoft.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Scott Shell <scottsh@microsoft.com>, Steve Dower <steve.dower@python.org>, 
	Steve Grubb <sgrubb@redhat.com>, kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
Subject: Re: [RFC PATCH v1 1/2] fs: Add O_DENY_WRITE
Message-ID: <20250826.Lie3ye8to7yo@digikod.net>
References: <20250822170800.2116980-1-mic@digikod.net>
 <20250822170800.2116980-2-mic@digikod.net>
 <CAG48ez1XjUdcFztc_pF2qcoLi7xvfpJ224Ypc=FoGi-Px-qyZw@mail.gmail.com>
 <20250824.Ujoh8unahy5a@digikod.net>
 <CALCETrWwd90qQ3U2nZg9Fhye6CMQ6ZF20oQ4ME6BoyrFd0t88Q@mail.gmail.com>
 <20250825.mahNeel0dohz@digikod.net>
 <lhuikibbv0g.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <lhuikibbv0g.fsf@oldenburg.str.redhat.com>
X-Infomaniak-Routing: alpha

On Mon, Aug 25, 2025 at 11:39:11AM +0200, Florian Weimer wrote:
> * Mickaël Salaün:
> 
> > The order of checks would be:
> > 1. open script with O_DENY_WRITE
> > 2. check executability with AT_EXECVE_CHECK
> > 3. read the content and interpret it
> >
> > The deny-write feature was to guarantee that there is no race condition
> > between step 2 and 3.  All these checks are supposed to be done by a
> > trusted interpreter (which is allowed to be executed).  The
> > AT_EXECVE_CHECK call enables the caller to know if the kernel (and
> > associated security policies) allowed the *current* content of the file
> > to be executed.  Whatever happen before or after that (wrt.
> > O_DENY_WRITE) should be covered by the security policy.
> 
> Why isn't it an improper system configuration if the script file is
> writable?

It is, except if the system only wants to track executions (e.g. record
checksum of scripts) without restricting file modifications.

> 
> In the past, the argument was that making a file (writable and)
> executable was an auditable even, and that provided enough coverage for
> those people who are interested in this.

Yes, but in this case there is a race condition that this patch tried to
fix.

