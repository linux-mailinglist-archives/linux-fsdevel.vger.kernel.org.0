Return-Path: <linux-fsdevel+bounces-41537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A86AA31543
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 20:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5622188ABB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 19:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D796264F86;
	Tue, 11 Feb 2025 19:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="H1mk6Diq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kpJwh4ER"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744B6267F67;
	Tue, 11 Feb 2025 19:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301870; cv=none; b=ozkpFW1S6Y+Kj4zsGYLayzJzldIlmn5jyuxiTBWOEGkU4oRB/x7IwADSFuN5SwTMcJS+ce2XJa1MjeKO3L1vrCF3DRP8LXoVYuGnTUE5c16+9EuER+ttCxVbY3urquXoP48qCkrP2SlUj2raZ2fjcGLGh7NmsO2nNYU6zMTKPac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301870; c=relaxed/simple;
	bh=c3d2vNEaLKWV5MP/R/ATr1E1H0RvMwxHYf1Cp5qlV3I=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=P2UyWOC1qw7OhZcdqBzsiXLhZ1BD7ZxTuGLBbab+C4skTev0MlQXYnUY8NtGIaACbXOBch4QVCFBgCd3PO1KLnBfhum1y8GCDawbjtDS2cVFtG4e7zOn3m6gvNgUUaZGVE9PfO4GxS1hw7b//Rma3GV6VFMhPC9osuUK+XyBXoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=H1mk6Diq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kpJwh4ER; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailflow.phl.internal (Postfix) with ESMTP id 33B60201429;
	Tue, 11 Feb 2025 14:24:27 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 11 Feb 2025 14:24:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1739301867;
	 x=1739309067; bh=c3d2vNEaLKWV5MP/R/ATr1E1H0RvMwxHYf1Cp5qlV3I=; b=
	H1mk6DiqkFxdaYDq+XrnH8tSDTT8Wz0IzX6XL6dUXhL78edeBCmXPGsNalqy0uVh
	qfVX/eprmx9jfhnZLIibSxEnb/yvox+Psohl6D+biy1usicOOYfycAQ2/lHbv7lM
	ms22mxqpOENU1kVoeVGl9qKtHG5mrujViCEqY0VqdFfcppxn9atgtNyvfUPWmoke
	iSaUJwdmeT5vL2m9nOgiPbOQ8inT6fzN26/QdI3b3ROKoE+2F5hJFKlCRtQC3y3c
	pNkD/sKqZig+fogqosYE5BTnVmyK6o10RK5f/h5GDNzrhM5tSiEXUMV0Q3nN/9rS
	xa4XKlLduvuE5qltdHFuwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739301867; x=
	1739309067; bh=c3d2vNEaLKWV5MP/R/ATr1E1H0RvMwxHYf1Cp5qlV3I=; b=k
	pJwh4ERJCdsI83YQZOuod4nqq8kn1u8tNVYkl/OjbgBveJxUNjHPRWiuP/sMWePe
	hWZL7RWcLgrDzeKv5GrR3PoYeTufoc3U4SB55vLC3FbOavO5wEdBzvHuqivBxaRF
	6YUgMOaaWBUp0mJhL6e90goXp5VxfeaB5fOPaZMtqvaTzZGmRI8co5Pb+1yhZ1Jd
	+tqS4S/sXSHnDsDIvtzzmvXuOx5xRuW4+VXNR41QorPX56/udIxvXWKZq54TC1r5
	JYZoW9xCcEKfQyyQAwd/KvNTPMcZsKIIArH5WPCoYAMp23vY3HTia10D0pKRzo20
	tsZ725bobRorlkRPbnT9Q==
X-ME-Sender: <xms:56OrZ_4r1fGeTYVnaod-wO2NzZ2NHYdVHCIZdYDdVEN3CUE3aLipBw>
    <xme:56OrZ04LaJcJB8g_4vy2jK4AcZwVH4jm5wnhLceIhsETEDChYT_p2vDhAdsalScNE
    UHLbNjYgU53zxr38K0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegudekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeeh
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpd
    hrtghpthhtohepthhssghoghgvnhgusegrlhhphhgrrdhfrhgrnhhkvghnrdguvgdprhgt
    phhtthhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtghpthhtoh
    eplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegthhhrihhs
    thhophhhvgdrlhgvrhhohiestghsghhrohhuphdrvghupdhrtghpthhtohepuggrvhgvmh
    esuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehmihgtseguihhgihhkohgurdhn
    vghtpdhrtghpthhtohepmhhpvgesvghllhgvrhhmrghnrdhiugdrrghupdhrtghpthhtoh
    eprghnughrvggrshesghgrihhslhgvrhdrtghomh
X-ME-Proxy: <xmx:56OrZ2c8vfiXY8n3dexb_wHcIKTMgG6o3iBcrDJCGSo83cktB116vA>
    <xmx:56OrZwKurjJ9VsGmWmqTvUmqikgs5yszNjLYSbIodcQKb37uQS1vVg>
    <xmx:56OrZzKn0eY8SDxacs2AIw8al8AHb-BF-N93qSumfcz0FNW0tdUaZQ>
    <xmx:56OrZ5y4eaI6MBsTqZJwzGJSKmez8ij-IaW_MKIlyU1hTpHti9F-SA>
    <xmx:66OrZ5ZaEgYHz5-gr-91ZnpSgt3C2jX-ZjBTONvD9HLTwxOizyBpb0N7>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6103B2220072; Tue, 11 Feb 2025 14:24:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 11 Feb 2025 20:24:02 +0100
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
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-api@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-xfs@vger.kernel.org
Message-Id: <f4276a02-57cd-4703-be3c-4210e4a033a9@app.fastmail.com>
In-Reply-To: <20250211-xattrat-syscall-v3-1-a07d15f898b2@kernel.org>
References: <20250211-xattrat-syscall-v3-1-a07d15f898b2@kernel.org>
Subject: Re: [PATCH v3] fs: introduce getfsxattrat and setfsxattrat syscalls
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Feb 11, 2025, at 18:22, Andrey Albershteyn wrote:
> From: Andrey Albershteyn <aalbersh@redhat.com>
>
> Introduce getfsxattrat and setfsxattrat syscalls to manipulate inode
> extended attributes/flags. The syscalls take parent directory fd and
> path to the child together with struct fsxattr.
>
> This is an alternative to FS_IOC_FSSETXATTR ioctl with a difference
> that file don't need to be open as we can reference it with a path
> instead of fd. By having this we can manipulated inode extended
> attributes not only on regular files but also on special ones. This
> is not possible with FS_IOC_FSSETXATTR ioctl as with special files
> we can not call ioctl() directly on the filesystem inode using fd.
>
> This patch adds two new syscalls which allows userspace to get/set
> extended inode attributes on special files by using parent directory
> and a path - *at() like syscall.
>
> Also, as vfs_fileattr_set() is now will be called on special files
> too, let's forbid any other attributes except projid and nextents
> (symlink can have an extent).
>
> CC: linux-api@vger.kernel.org
> CC: linux-fsdevel@vger.kernel.org
> CC: linux-xfs@vger.kernel.org
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>

I checked the syscall.tbl additions and the ABI to ensure that
it follows the usual guidelines and is portable across
all architectures, this looks good. Thanks for addressing
my v1 comments:

Acked-by: Arnd Bergmann <arnd@arndb.de>

Disclaimer: I have no idea if the new syscalls are a good
idea or if they are fit for the purpose, I trust the
VFS maintainers will take care of reviewing that.

