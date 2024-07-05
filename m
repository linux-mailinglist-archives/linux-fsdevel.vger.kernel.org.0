Return-Path: <linux-fsdevel+bounces-23251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1D9928F50
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jul 2024 00:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC431F23598
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 22:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB899146A98;
	Fri,  5 Jul 2024 22:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R82FvL6J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF7512FF89;
	Fri,  5 Jul 2024 22:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720218138; cv=none; b=XKwUYQScvXCAPKHS01JggjTHzyIe00zFJC6t/Oxr61X8UrmBmioeM63mswqEs6BVJRSaMxWxh7SWmwyARx80fLkjJ4a/sZPPPhzxw5OGi7cp9yrWYG+mLr4eaoCgK4HEj18k5c+e5uPRMuUZ4UFKSKyDKKv8rmSCgkyjeh/fKRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720218138; c=relaxed/simple;
	bh=ENklnaGwg7gbVoxwnNN9rxnZRVBjkNfp1WlAFtAN+BM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=kJhAE6Tsh7RsCXuz86R9jFZyPNJ9phgU5vcrvLJoDmBBXj0i1rQFaeVmsULPVE1GErWw9CoufpBANMGdrij9cgpg9MRo5N307Yw1HGpI4L/DPchKmB2UR2EzYuthx3LfsZHv6nyOQDq1JPwkZwi1oHNfK5gePSrXbosMiAF2vdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R82FvL6J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7B9C116B1;
	Fri,  5 Jul 2024 22:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720218138;
	bh=ENklnaGwg7gbVoxwnNN9rxnZRVBjkNfp1WlAFtAN+BM=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=R82FvL6Jp535Akx7VaoouTVyo3yZ0oGQHmxMZDd8FwAEPKBkSuOcmyJ9yJToPi+f9
	 UFyV7ns+xPCXVNrONu4MLRJ+og/16DTLW2nn8UuBAWcIEwgWrhiYRfAE6UC5NF6fEW
	 o8fn/hy3aBZgrLuJfjcZ5BJ5x9sR4unHadsjfrLzWnrBoQTX8zJnvSwCMdcBdRTRiw
	 TXzP3JsHskW93BnEtYnD2cSp6iB3K3VR7Tey1BRNlrZeD9ilvydyOdUhlnBqXbDmwD
	 sGTt5wEsH8n14WZh+M/G2uVc89lBBgwL/9yNfZMoGxCPo4ph3osIyWc0IRFrCqyTX9
	 C3W/JiomT1p3A==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 06 Jul 2024 01:22:06 +0300
Message-Id: <D2HYFLLXVYLS.ORASE7L62L3N@kernel.org>
Subject: Re: [RFC PATCH v19 2/5] security: Add new SHOULD_EXEC_CHECK and
 SHOULD_EXEC_RESTRICT securebits
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Kees Cook" <kees@kernel.org>, =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>
Cc: "Al Viro" <viro@zeniv.linux.org.uk>, "Christian Brauner"
 <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Paul Moore" <paul@paul-moore.com>, "Theodore Ts'o" <tytso@mit.edu>,
 "Alejandro Colomar" <alx@kernel.org>, "Aleksa Sarai" <cyphar@cyphar.com>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Andy Lutomirski"
 <luto@kernel.org>, "Arnd Bergmann" <arnd@arndb.de>, "Casey Schaufler"
 <casey@schaufler-ca.com>, "Christian Heimes" <christian@python.org>,
 "Dmitry Vyukov" <dvyukov@google.com>, "Eric Biggers" <ebiggers@kernel.org>,
 "Eric Chiang" <ericchiang@google.com>, "Fan Wu"
 <wufan@linux.microsoft.com>, "Florian Weimer" <fweimer@redhat.com>, "Geert
 Uytterhoeven" <geert@linux-m68k.org>, "James Morris"
 <jamorris@linux.microsoft.com>, "Jan Kara" <jack@suse.cz>, "Jann Horn"
 <jannh@google.com>, "Jeff Xu" <jeffxu@google.com>, "Jonathan Corbet"
 <corbet@lwn.net>, "Jordan R Abrahams" <ajordanr@google.com>, "Lakshmi
 Ramasubramanian" <nramas@linux.microsoft.com>, "Luca Boccassi"
 <bluca@debian.org>, "Luis Chamberlain" <mcgrof@kernel.org>, "Madhavan T .
 Venkataraman" <madvenka@linux.microsoft.com>, "Matt Bobrowski"
 <mattbobrowski@google.com>, "Matthew Garrett" <mjg59@srcf.ucam.org>,
 "Matthew Wilcox" <willy@infradead.org>, "Miklos Szeredi"
 <mszeredi@redhat.com>, "Mimi Zohar" <zohar@linux.ibm.com>, "Nicolas
 Bouchinet" <nicolas.bouchinet@ssi.gouv.fr>, "Scott Shell"
 <scottsh@microsoft.com>, "Shuah Khan" <shuah@kernel.org>, "Stephen
 Rothwell" <sfr@canb.auug.org.au>, "Steve Dower" <steve.dower@python.org>,
 "Steve Grubb" <sgrubb@redhat.com>, "Thibaut Sautereau"
 <thibaut.sautereau@ssi.gouv.fr>, "Vincent Strubel"
 <vincent.strubel@ssi.gouv.fr>, "Xiaoming Ni" <nixiaoming@huawei.com>, "Yin
 Fengwei" <fengwei.yin@intel.com>, <kernel-hardening@lists.openwall.com>,
 <linux-api@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240704190137.696169-1-mic@digikod.net>
 <20240704190137.696169-3-mic@digikod.net> <202407041711.B7CD16B2@keescook>
 <20240705.IeTheequ7Ooj@digikod.net> <202407051425.32AF9D2@keescook>
In-Reply-To: <202407051425.32AF9D2@keescook>

On Sat Jul 6, 2024 at 12:44 AM EEST, Kees Cook wrote:
> > As explained in the UAPI comments, all parent processes need to be
> > trusted.  This meeans that their code is trusted, their seccomp filters
> > are trusted, and that they are patched, if needed, to check file
> > executability.
>
> But we have launchers that apply arbitrary seccomp policy, e.g. minijail
> on Chrome OS, or even systemd on regular distros. In theory, this should
> be handled via other ACLs.

Or a regular web browser? AFAIK seccomp filtering was the tool to make
secure browser tabs in the first place.

BR, Jarkko

