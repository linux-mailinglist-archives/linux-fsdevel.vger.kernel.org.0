Return-Path: <linux-fsdevel+bounces-48832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62089AB5069
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 11:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74CDA1B43FB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 09:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B285023C518;
	Tue, 13 May 2025 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="C3c8Raon";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vsLFxk/O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84AE21D3FB;
	Tue, 13 May 2025 09:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130029; cv=none; b=k8oFOqXsyIj9wOb7h6Gkfudh8MH+bC5zXa1UmDt3r3FftKVw725SvFoEiG/flFykF8RIw2eY9y859NPb0WZZ43DHBVE1zgemfTfeBQPfF+2z+UuMH9LzUeM71HXUBhy4mHVq1hBTvP0YGsrRLIZMI8rU4/MVrzPp0isZMTAI08I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130029; c=relaxed/simple;
	bh=0hdsBjSp459tutLJ6ljFU38BGGSJAYEDerkzM9gXgMY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=AnQvackthfmXo2NuQcBKSDja7SlU3olVZ6HOfdedNivFKj47sAF7i+UC0aptYj/VbH4i14K+HUvU5P0+ezEJuAIqg8dbIvt6VGcjRoQo8dzeU8Nyas+ybTFimua6AUWcT1Oa8WeTfM2hMokz0YtTLMkCdHADl2U8OhuVikHU83c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=C3c8Raon; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vsLFxk/O; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 9B48B138023E;
	Tue, 13 May 2025 05:53:44 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-05.internal (MEProxy); Tue, 13 May 2025 05:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1747130024;
	 x=1747216424; bh=2stkMgjnTvYjnZGlIOEgk4TUXFdwLQsjjGMrGxJEng4=; b=
	C3c8Raon10jNbSWEDJYORU4gm8U567TulRzRqYXvVTZbjR0aq+aByBE2v3CJN1FQ
	KGfe3mZpGMvm3sTTdA/bD4xqfr9/qt+FvJkO3rqB79Pg31A2o/9QmuHNpYiP6YRx
	5Oqhmp7U5spBkf8ZI7vbBVSijXCPkocSiEYxOZC/Onni9aY5io5LzGgT4Pq9viV0
	FxR/+TYDSmfB7orizqIWsWleYCSTadigZVUPKWWu8SAUOAVMNjnmKn0AtzGJWmfW
	n6nzNwgrlX6EoM4p1CSnCJ3VeumN0iyyMXY2jOP60W0IV6bI3CT9OzvBzAkFsxl7
	4cHaLnU9wP0qw8PBRP4/xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747130024; x=
	1747216424; bh=2stkMgjnTvYjnZGlIOEgk4TUXFdwLQsjjGMrGxJEng4=; b=v
	sLFxk/OONbe9qUFpU+vGJs0rbHoUFetAr/fxOXK42jpmXJb5nTIJ7LEBIUPf4M6G
	eTcNYjLTfujnNkmPPXXpyky+qMRxwL3zEmGUVPEH+t0k7GujubIRtLl9rINOsfnn
	X9/Eb5yNN0qQjRVMa37hSc7AaOUvH4JCwUlDvsafU5OLxU9eTZImOa8ptmwo/l2T
	bs233RN+PmjcxkgMgNR7itS59Aeg1pud04SM0rQP9DoVg/4xL7xZnREOVygJrpgd
	OrsLj5e/vgBNPgMcoc68G2ELnrcX8nncMoC0tQ94aIH7VLf5TW0EdedJwnB5PPnu
	dwaxyu40sGpRl3lCZi9tw==
X-ME-Sender: <xms:pxYjaLwrXpLW4klVSCheAqTm4C9UgyAlohVgQXdRm433wH8zPhDjBA>
    <xme:pxYjaDSjqY5BDk9WwQ-tsi8xw0LA5Yl0VTNcBFLnEBSVW1kIb3TJOTrQtdapEL-kV
    LNoh_S6Uafh70HHh0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdefkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    udekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvtghrhihpthhfshesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrlhhphhgrsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghpihesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhiphhssehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgrrhhishgtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshefledtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:pxYjaFWNK6qckU9EAkTTPdmuJ2Lc16lm1lQT8t8gINUyJNodOnPGtg>
    <xmx:qBYjaFj3xNq2z69AdTzdxc9uPqiUSHC7_M62mldtwCjqQlCRnhM-Rg>
    <xmx:qBYjaNAkeq0jmyphK4SpsmNDd9k5fP5xmTQPYh_D3Yac2-YckRFBnw>
    <xmx:qBYjaOIou2p5qtZVJS3F0ZNvV9JGB-543tS1-c1g0WeW8aICtRJVyQ>
    <xmx:qBYjaEnPm2YINp4LCyG4AbGwBe-DC4jdTt3KydIVybuQOabro6nth3RD>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D7A291C20068; Tue, 13 May 2025 05:53:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tdb8541d917685bac
Date: Tue, 13 May 2025 11:53:23 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andrey Albershteyn" <aalbersh@redhat.com>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Matt Turner" <mattst88@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Michal Simek" <monstr@monstr.eu>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Helge Deller" <deller@gmx.de>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Naveen N Rao" <naveen@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Yoshinori Sato" <ysato@users.sourceforge.jp>,
 "Rich Felker" <dalias@libc.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Chris Zankel" <chris@zankel.net>,
 "Max Filippov" <jcmvbkbc@gmail.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 "Stephen Smalley" <stephen.smalley.work@gmail.com>,
 "Ondrej Mosnacek" <omosnace@redhat.com>,
 "Tyler Hicks" <code@tyhicks.com>, "Miklos Szeredi" <miklos@szeredi.hu>,
 "Amir Goldstein" <amir73il@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-api@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 selinux@vger.kernel.org, ecryptfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org,
 "Andrey Albershteyn" <aalbersh@kernel.org>
Message-Id: <399fdabb-74d3-4dd6-9eee-7884a986dab1@app.fastmail.com>
In-Reply-To: <20250513-xattrat-syscall-v5-0-22bb9c6c767f@kernel.org>
References: <20250513-xattrat-syscall-v5-0-22bb9c6c767f@kernel.org>
Subject: Re: [PATCH v5 0/7] fs: introduce file_getattr and file_setattr syscalls
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, May 13, 2025, at 11:17, Andrey Albershteyn wrote:

>
> 	long syscall(SYS_file_getattr, int dirfd, const char *pathname,
> 		struct fsxattr *fsx, size_t size, unsigned int at_flags);
> 	long syscall(SYS_file_setattr, int dirfd, const char *pathname,
> 		struct fsxattr *fsx, size_t size, unsigned int at_flags);

I don't think we can have both the "struct fsxattr" from the uapi
headers, and a variable size as an additional argument. I would
still prefer not having the extensible structure at all and just
use fsxattr, but if you want to make it extensible in this way,
it should use a different structure (name). Otherwise adding
fields after fsx_pad[] would break the ioctl interface.

I also find the bit confusing where the argument contains both
"ignored but assumed zero" flags, and "required to be zero"
flags depending on whether it's in the fsx_pad[] field or
after it. This would be fine if it was better documented.


> 		fsx.fsx_xflags |= FS_XFLAG_NODUMP;
> 		error = syscall(468, dfd, "./foo", &fsx, 0);

The example still uses the calling conventions from a previous
version.

       Arnd

