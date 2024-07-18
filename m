Return-Path: <linux-fsdevel+bounces-23934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCFD934FFA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 17:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160BD1F229FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 15:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB0E1448C9;
	Thu, 18 Jul 2024 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="15Yc0S0O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DC41442FD
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721316949; cv=none; b=rvI3SI5inlKTXBwUzOJAPIzZ7iaD8BLBxz5ksznabw+bFwGJ/as4Qmg8UVtKqB04YOzZKEqeoh1G2oF6VIJ5vuNxHUvRcJIDUv0Xs7IRGPEACHeGdgfLE0TQPTS4xvOZSm2PnmC9BaA18FJSVhCuOuMMirabECKW8NkfqlMnLo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721316949; c=relaxed/simple;
	bh=VHuBFKSlr71gbOdtIQLbGSA6bMgPhQCYPXB0gvlN8hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5+Yp/bPy0RiRHo4BwZozcMs6/r3Zlx1zEmYiK1ZGX6BKTC7SFbsp4ZzZQyRqtuxziwAV/493X3STgURnnxZdzzfw5bRqfxfqGkTGUbFCpazNZAUe0i4WM6EbTnXIs3Oc9VgBOveVT7bg06oIwxHek3kr9xJR8RwuRtp+CzfWHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=15Yc0S0O; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WPxhv3R8Mz34s;
	Thu, 18 Jul 2024 17:35:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721316943;
	bh=/oX0SWFonwXZp8ZAmC3Hb1diHldVFLJw2446o3eOM5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=15Yc0S0O5ZUSmioE97yrOTIAGd0Zl2aVwOr9JnKeVUNGkrlu8kRkQrIeUOwKSxySh
	 5/eCqi1ounZDtSx5Oxry1CQncNyJl3cLWh/5YPS63vfafuX0K57BC7Ta2Ypafx8J0w
	 mKFGZWnY56lDSGLMW+GuHf+rtZb8CJ37otIUTh8I=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WPxhq3z0zzmG;
	Thu, 18 Jul 2024 17:35:39 +0200 (CEST)
Date: Thu, 18 Jul 2024 17:35:36 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Jeff Xu <jeffxu@google.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Paul Moore <paul@paul-moore.com>, Theodore Ts'o <tytso@mit.edu>, 
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
	Stephen Rothwell <sfr@canb.auug.org.au>, Steve Dower <steve.dower@python.org>, 
	Steve Grubb <sgrubb@redhat.com>, Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, 
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>, Xiaoming Ni <nixiaoming@huawei.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Elliott Hughes <enh@google.com>
Subject: Re: [RFC PATCH v19 1/5] exec: Add a new AT_CHECK flag to execveat(2)
Message-ID: <20240718.yieCh6miu9en@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
 <20240704190137.696169-2-mic@digikod.net>
 <CALmYWFss7qcpR9D_r3pbP_Orxs55t3y3yXJsac1Wz=Hk9Di0Nw@mail.gmail.com>
 <20240717.neaB5Aiy2zah@digikod.net>
 <CALmYWFt=yXpzhS=HS9FjwVMvx6U1MoR31vK79wxNLhmJm9bBoA@mail.gmail.com>
 <20240718.kaePhei9Ahm9@digikod.net>
 <544d08f5b55a0fbb1dc883bce6cf94c78cf46e42.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <544d08f5b55a0fbb1dc883bce6cf94c78cf46e42.camel@HansenPartnership.com>
X-Infomaniak-Routing: alpha

On Thu, Jul 18, 2024 at 09:03:36AM -0400, James Bottomley wrote:
> On Thu, 2024-07-18 at 14:24 +0200, Mickaël Salaün wrote:
> > On Wed, Jul 17, 2024 at 07:08:17PM -0700, Jeff Xu wrote:
> > > On Wed, Jul 17, 2024 at 3:01 AM Mickaël Salaün <mic@digikod.net>
> > > wrote:
> > > > On Tue, Jul 16, 2024 at 11:33:55PM -0700, Jeff Xu wrote:
> [...]
> > > > > I'm still thinking  execveat(AT_CHECK) vs faccessat(AT_CHECK)
> > > > > in different use cases:
> > > > > 
> > > > > execveat clearly has less code change, but that also means: we
> > > > > can't add logic specific to exec (i.e. logic that can't be
> > > > > applied to config) for this part (from do_execveat_common to
> > > > > security_bprm_creds_for_exec) in future.  This would require
> > > > > some agreement/sign-off, I'm not sure from whom.
> > > > 
> > > > I'm not sure to follow. We could still add new flags, but for now
> > > > I don't see use cases.  This patch series is not meant to handle
> > > > all possible "trust checks", only executable code, which makes
> > > > sense for the kernel.
> > > > 
> > > I guess the "configfile" discussion is where I get confused, at one
> > > point, I think this would become a generic "trust checks" api for
> > > everything related to "generating executable code", e.g.
> > > javascript, java code, and more. We will want to clearly define the
> > > scope of execveat(AT_CHECK)
> > 
> > The line between data and code is blurry.  For instance, a
> > configuration file can impact the execution flow of a program.  So,
> > where to draw the line?
> 
> Having a way to have config files part of the trusted envelope, either
> by signing or measurement would be really useful.  The current standard
> distro IMA deployment is signed executables, but not signed config
> because it's hard to construct a policy that doesn't force the signing
> of too many extraneous files (and files which might change often).
> 
> > It might makes sense to follow the kernel and interpreter semantic:
> > if a file can be executed by the kernel (e.g. ELF binary, file
> > containing a shebang, or just configured with binfmt_misc), then this
> > should be considered as executable code.  This applies to Bash,
> > Python, Javascript, NodeJS, PE, PHP...  However, we can also make a
> > picture executable with binfmt_misc.  So, again, where to draw the
> > line?
> 
> Possibly by making open for config an indication executables can give?
> I'm not advocating doing it in this patch, but if we had an open for
> config indication, the LSMs could do much finer grained policy,
> especially if they knew which executable was trying to open the config
> file.  It would allow things like an IMA policy saying if a signed
> executable is opening a config file, then that file must also be
> signed.

Checking configuration could be a next step, but not with this patch
series.  FYI, the previous version was a (too) generic syscall:
https://lore.kernel.org/all/20220104155024.48023-1-mic@digikod.net/
One of the main concern was alignment with kernel semantic.  For now,
let's focus on script execution control.

> 
> James
> 

