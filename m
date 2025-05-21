Return-Path: <linux-fsdevel+bounces-49566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F205ABEF10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 11:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C5A7A7453
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 09:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FA623A994;
	Wed, 21 May 2025 09:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="44QKW2Ej";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PiyMkS4t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF4A238C29;
	Wed, 21 May 2025 09:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747818191; cv=none; b=GlTRsbhepQk4aWHmk3lzeAQvXNdN13ZVmM5CbrZjNaEgf9f54xA/EfVe5KI/SgCYjjxPFGBpO3VDmT4Mjv7CjMntbq1Zjc7xjx7h1SOjN5hUXltqXbGJKivqMmc6X4aUcRSl9SPq9VV8Mt8pb+Zs2n5mhRfxba1RXH32u4+siBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747818191; c=relaxed/simple;
	bh=TPCgsW3gKqojbMYnaqiOIUCbBB/zEcZHRB+lyzzANDo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LdHYiFDSppXWtpZBv68HYelc0zW3snKWBTZPcSI+vGjM/JuADmVNG8OuerCwQwm2AyIwtaOYIEgjgp35K0l0chLYiqf1WuPfwnR+mQrXLkQ7GJmOisUPfWZQ3utLMdLR3eo2wc2PDZLjI7mN7sykbcK+LTtAkiegVZ1iJI2aJcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=44QKW2Ej; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PiyMkS4t; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 6CCBC1140117;
	Wed, 21 May 2025 05:03:05 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-05.internal (MEProxy); Wed, 21 May 2025 05:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747818185;
	 x=1747904585; bh=PcLZXiuxQaS428giR3RzU3lnofnEDkKQy05a9KBTIH4=; b=
	44QKW2EjNMBrd4paaBb98Za0n5eQXbDuRmuEyEPl7MzdF8CRsSdDeJn/6KFv1d9/
	J+UqYrs5YbHTYZWp64xosvAVPJu97H2/ESnJBERgyFvsXXdnMVy71RmoopCPzs2K
	8cnpPwY6ccDn8l6hgbVcw4SGVZ9YZxSI0lnnE+oiIDV68NHt/KUlEpj3B6UaggzM
	fXsGFBQ97R3TTp7uDpzCForvxvGV+5w9WntXFpHEQRHiH9z0ekoDndWlx/TNW1RK
	ueIHzMFvlBrs47UNz1s8ENReVj0XcCtaxbx1PpS4jn3+G6m0zRj/ZdYDuEkegNhX
	UBXmHhmbsypk3n4N8ffWFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747818185; x=
	1747904585; bh=PcLZXiuxQaS428giR3RzU3lnofnEDkKQy05a9KBTIH4=; b=P
	iyMkS4tWOmrGv/vpw7irwVReFarSLJuUxrNvQmyMkpEQ8cpSOY70srNEdrBoSott
	08fJHliKKI+BESplRaocdpofajWhnc+bonE2BZTVfJJufh2XP2fS5Bv6+rTzhqt1
	EWUAo1kDKrWqQH7Jq3GejRpNR8D9K4STJk0A4HurL3jP84ET5YFg2Q/Msoa7JMar
	BeTftpPhEDz2DodFoWLVDvvVRsOq9btSG3lFrBCZEyII3wIDzPROw9g5PwZt8Ii9
	glqwjQ/hW4VqcxgaZLKtopR2ydT2yl1h+KtrRlgWJNUyBAw+9Tk+IGLe4oEqjZMw
	F/Eg1mNK7+3q2wGS3eOHw==
X-ME-Sender: <xms:yJYtaAb-TJls2WOkrq9mpn2wOU-KJlEfxbLlOct4EiYiQK4fhALM3Q>
    <xme:yJYtaLaofxvD2GIRhy9a0vnO00FynOzr_dpi6y3Z5dJQ0Obrt4iSZ35KCsui7Fd6H
    Z2jDi0iicV0qI8OeZo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvieejucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgj
    fhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuc
    eorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedu
    keetgefggffhjeeggeetfefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdp
    nhgspghrtghpthhtohepudelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeihsh
    grthhosehushgvrhhsrdhsohhurhgtvghfohhrghgvrdhjphdprhgtphhtthhopegvtghr
    hihpthhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    grlhhphhgrsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    rghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrh
    gthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshgu
    vghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkh
    gvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    mhhiphhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqph
    grrhhishgtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:yJYtaK-xFrqwHFlSoPZsAwI6SH46IFNL08vZdZZnEX48dTBkNJ5g6Q>
    <xmx:yJYtaKpNhHPesWqvCybrcX__rJUQ_l4GwqXIc4b_m8Zteex_AV4onQ>
    <xmx:yJYtaLqRF067g7BLsBZYkcFDJbY3ilyaHz9UIWGgiqSsmznTFSDuCw>
    <xmx:yJYtaITEVJFbPtqN1X1pHXVcfzSO_Ov1_9MfVHbGO_Ly5vQ-bzLLuw>
    <xmx:yZYtaCNRmKcuC8xdsvf4Ayd4y8gO62bGFb5MlZxgaQXse5XtiW7MD5C6>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 341AD1060061; Wed, 21 May 2025 05:03:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tdb8541d917685bac
Date: Wed, 21 May 2025 11:02:42 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andrey Albershteyn" <aalbersh@redhat.com>,
 "Dave Chinner" <david@fromorbit.com>
Cc: "Amir Goldstein" <amir73il@gmail.com>,
 "Christian Brauner" <brauner@kernel.org>,
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
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 "Stephen Smalley" <stephen.smalley.work@gmail.com>,
 "Ondrej Mosnacek" <omosnace@redhat.com>,
 "Tyler Hicks" <code@tyhicks.com>, "Miklos Szeredi" <miklos@szeredi.hu>,
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-api@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 selinux@vger.kernel.org, ecryptfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org,
 "Andrey Albershteyn" <aalbersh@kernel.org>
Message-Id: <d638db28-2603-448f-b149-b33eca821a64@app.fastmail.com>
In-Reply-To: 
 <sfmrojifgnrpeilqxtixyqrdjj5uvvpbvirxmlju5yce7z72vi@ondnx7qbie4y>
References: <20250513-xattrat-syscall-v5-0-22bb9c6c767f@kernel.org>
 <399fdabb-74d3-4dd6-9eee-7884a986dab1@app.fastmail.com>
 <20250515-bedarf-absagen-464773be3e72@brauner>
 <CAOQ4uxicuEkOas2UR4mqfus9Q2RAeKKYTwbE2XrkcE_zp8oScQ@mail.gmail.com>
 <aCsX4LTpAnGfFjHg@dread.disaster.area>
 <sfmrojifgnrpeilqxtixyqrdjj5uvvpbvirxmlju5yce7z72vi@ondnx7qbie4y>
Subject: Re: [PATCH v5 0/7] fs: introduce file_getattr and file_setattr syscalls
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, May 21, 2025, at 10:48, Andrey Albershteyn wrote:
> On 2025-05-19 21:37:04, Dave Chinner wrote:

>> > +struct fsx_fileattr {
>> > +       __u32           fsx_xflags;     /* xflags field value (get/set) */
>> > +       __u32           fsx_extsize;    /* extsize field value (get/set)*/
>> > +       __u32           fsx_nextents;   /* nextents field value (get)   */
>> > +       __u32           fsx_projid;     /* project identifier (get/set) */
>> > +       __u32           fsx_cowextsize; /* CoW extsize field value (get/set)*/
>> > +};
>> > +
>> > +#define FSXATTR_SIZE_VER0 20
>> > +#define FSXATTR_SIZE_LATEST FSXATTR_SIZE_VER0
>> 
>> If all the structures overlap the same, all that is needed in the
>> code is to define the structure size that should be copied in and
>> parsed. i.e:
>> 
>> 	case FSXATTR..._V1:
>> 		return ioctl_fsxattr...(args, sizeof(fsx_fileattr_v1));
>> 	case FSXATTR..._V2:
>> 		return ioctl_fsxattr...(args, sizeof(fsx_fileattr_v2));
>> 	case FSXATTR...:
>> 		return ioctl_fsxattr...(args, sizeof(fsx_fileattr));

I think user space these days, in particular glibc, expects that
you can build using new kernel headers and run on older kernels
but still get behavior that is compatible with old headers, so
redefining FS_IOC_FSGETXATTR would be considered a bug.

I'm fairly sure that in the past it was common to expect userspace
to never be built against newer headers and run on older kernels,
but the expectation seems to have gradually shifted away from that.

> So, looks like there's at least two solutions to this concern.
> Considering also that we have a bit of space in fsxattr,
> 'fsx_pad[8]', I think it's fine to stick with the current fsxattr
> for now.

You still have to document what you expect to happen with the
padding fields for both the ioctl and the syscall, as the
current behavior of ignoring the padding in the ioctl is not
what we expect for a syscall which tends to check unknown
fields for zero. I don't see a good solution here if you
use the same structure.

      Arnd

