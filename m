Return-Path: <linux-fsdevel+bounces-23944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBAD935095
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 18:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE1B31C21638
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 16:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB213144D3A;
	Thu, 18 Jul 2024 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="cap6pZEi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9130F143C60
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721319679; cv=none; b=nqtaHvLCO+qmmdQVb/OD9Tttj9e+vW5bOpdmdSecr+SYcmC0S6vUpKMwvHQpRxKF+xTzY5m/4/TmRCKHzsD8KSvFpjA65MTvCl5BpAy3MUsbVreUJtyModZlDUyTs33JAk9WOMwMda1O7x/eRjeiY9nG4Ahz4p81p2E9JGMpVHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721319679; c=relaxed/simple;
	bh=zg/TB+s/swO2+QzhdteQScL+2ZmFzIH3ab1lFl01ato=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gE2Sq8qup65v5uxDGtWig/33zYDipTVBtRi//o8f1+Jn+I7Lv10sFHRLWDC7qzzwPLMjAQdgLkTdIWRuSq8yi0BweeANnJDudsWoy5IVEXQNy3ee7fqb1xOh58oi5bDtFQXCQF3jH3J6wukmS7zcs/w9no+aWBMZSZ1mO1zQxTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=cap6pZEi; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WPyjQ6RzNzVjL;
	Thu, 18 Jul 2024 18:21:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721319674;
	bh=M+3Yoh5cYMc8D5M9gZ15CD0RTPe/f2BBnjb9c6H9rvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cap6pZEiKXn1RU9fTx+Yo6v0BUHSTWCJS5tpiaoWBPry/FJev2m5rLi6mXU9q6QuC
	 z87bUnjBE1Z9w9ADOsYdHd49b1XVKauOW8Dmvr09VCdjJsgFrPZvIJmgG9EVv7P4CI
	 +3PWxO7BC6lNsOlLPGHoqi9wakqGFqMRQy84F+vg=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WPyjQ0JnkzBbT;
	Thu, 18 Jul 2024 18:21:14 +0200 (CEST)
Date: Thu, 18 Jul 2024 18:21:11 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Paul Moore <paul@paul-moore.com>, Theodore Ts'o <tytso@mit.edu>, 
	Alejandro Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Eric Chiang <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	James Morris <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
	Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, 
	Scott Shell <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Steve Dower <steve.dower@python.org>, 
	Steve Grubb <sgrubb@redhat.com>, Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, 
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>, Xiaoming Ni <nixiaoming@huawei.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Elliott Hughes <enh@google.com>
Subject: Re: [RFC PATCH v19 0/5] Script execution control (was O_MAYEXEC)
Message-ID: <20240718.ZuXiejae2ohy@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
 <55b4f6291e8d83d420c7d08f4233b3d304ce683d.camel@linux.ibm.com>
 <20240709.AhJ7oTh1biej@digikod.net>
 <9e3df65c2bf060b5833558e9f8d82dcd2fe9325a.camel@huaweicloud.com>
 <ee1ae815b6e75021709612181a6a4415fda543a4.camel@HansenPartnership.com>
 <20240716.leeV4ooveinu@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240716.leeV4ooveinu@digikod.net>
X-Infomaniak-Routing: alpha

On Tue, Jul 16, 2024 at 07:31:45PM +0200, Mickaël Salaün wrote:
> On Tue, Jul 16, 2024 at 12:12:49PM -0400, James Bottomley wrote:
> > On Tue, 2024-07-16 at 17:57 +0200, Roberto Sassu wrote:
> > > But the Clip OS 4 patch does not cover the redirection case:
> > > 
> > > # ./bash < /root/test.sh
> > > Hello World
> > > 
> > > Do you have a more recent patch for that?
> 
> Bash was only partially restricted for CLIP OS because it was used for
> administrative tasks (interactive shell).
> 
> Python was also restricted for user commands though:
> https://github.com/clipos-archive/clipos4_portage-overlay/blob/master/dev-lang/python/files/python-2.7.9-clip-mayexec.patch
> 
> Steve and Christian could help with a better Python implementation.

I'll include a toy interpreter in the next patch series.  That should
help for experiments.

