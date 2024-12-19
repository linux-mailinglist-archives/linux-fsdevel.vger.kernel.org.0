Return-Path: <linux-fsdevel+bounces-37781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE589F7600
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 08:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BA46168E2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 07:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B0121771B;
	Thu, 19 Dec 2024 07:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="0PaeD2mZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BFE21770F
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 07:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734594313; cv=none; b=qAg5lzgZYaOKZ29QjfSJ6MAQA5Z0fM6GegH4HWnBQ+YdYiVt1Ob9BRPYezdNjvDs3QK958iekrUXx+b7S/eirg2ItXuVQIpUm9ZNhUnDCspIf2Nq7gQohs71VO1lsCU0Gb2uiEIcBUgcIW/R9vZpaIqIaPg0poA+MLT96Z6g0y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734594313; c=relaxed/simple;
	bh=4kZV05gAcdH13bba/KY+LydZ9n98bA1dNYEnzu9VffA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyikaLzzLJC9dujQ2gm2matNtMkcoj4iL0iAIFoWTYiITXjQV0iBah29DOd1pMMB3B5bcdpNKMzIbyvjqEyrW9UgoiG6O8a2rCjbPkB0/zLMFsnRZvQRugIDw5VsZemJUKfP2fGpJzLn0IYESWmybNaN1U5LS0IbEYJ9wE5/n/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=0PaeD2mZ; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YDMyk2dlLzg73;
	Thu, 19 Dec 2024 08:45:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1734594302;
	bh=oKhFkfeKlHLMteV17dJwPYDJMj25IWwSaNtedn4t5og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0PaeD2mZXMVXSB0s3zaJLGesGRhVGJwjco61VkN0AtFjed07nbQSnjPZq0OMG4Uiu
	 6GGqjloRLZ+q2vtgOzexlRTyqCRQmT7TjrWl+anvbdbs6ryn0zJs5ggkQ/7y6qXsl9
	 4EbXr0LzwyzvuSLNxj4fMgTNVxzVW43NV/jKyqCA=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YDMyf3syCzYXg;
	Thu, 19 Dec 2024 08:44:58 +0100 (CET)
Date: Thu, 19 Dec 2024 08:44:56 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Kees Cook <kees@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <serge@hallyn.com>, Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, 
	Alejandro Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Elliott Hughes <enh@google.com>, 
	Eric Biggers <ebiggers@kernel.org>, Eric Chiang <ericchiang@google.com>, 
	Fan Wu <wufan@linux.microsoft.com>, Florian Weimer <fweimer@redhat.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, James Morris <jamorris@linux.microsoft.com>, 
	Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jordan R Abrahams <ajordanr@google.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Scott Shell <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, Theodore Ts'o <tytso@mit.edu>, 
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, Vincent Strubel <vincent.strubel@ssi.gouv.fr>, 
	Xiaoming Ni <nixiaoming@huawei.com>, kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v23 0/8] Script execution control (was O_MAYEXEC)
Message-ID: <20241219.CaiVie9caNge@digikod.net>
References: <20241212174223.389435-1-mic@digikod.net>
 <20241218.aBaituy0veK7@digikod.net>
 <202412181130.84A2FCF2@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202412181130.84A2FCF2@keescook>
X-Infomaniak-Routing: alpha

On Wed, Dec 18, 2024 at 11:31:57AM -0800, Kees Cook wrote:
> On Wed, Dec 18, 2024 at 11:40:59AM +0100, Mickaël Salaün wrote:
> > In the meantime I've pushed it in my tree, it should appear in -next
> > tomorrow.  Please, let me know when you take it, I'll remove it from my
> > tree.
> 
> Thanks! Yeah, I was just finally getting through my email after my
> pre-holiday holiday. ;)
> 
> I'll get this into my -next tree now.

Thanks, I just removed mine.

> 
> -Kees
> 
> -- 
> Kees Cook

