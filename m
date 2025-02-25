Return-Path: <linux-fsdevel+bounces-42567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC3EA43C0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 11:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C1BC3A8094
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 10:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2C023BD11;
	Tue, 25 Feb 2025 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="RBJ4drAk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XoA4obnl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01422661B5;
	Tue, 25 Feb 2025 10:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740480079; cv=none; b=Rak1327ANNcFUSUUILhbTh6doSLcD4czdtp+Z/dqLR0/BlL7eHjoQ9VGvR96zVv7Osl1qt2FUD6aZtQBQqiDqK8CVz4cWOtBvW4erobKK+t3jPpmP1rkNgZxuQNg9hAJDzDyVP8PNRUmqPjqa5Hy8dSrcLvbuz9XUJZ5Mn1bgbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740480079; c=relaxed/simple;
	bh=xfJ/tP0KEVZjgcjFjGNS5v96EkfIzgw/9MuCJaXzLxo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=c9XAoTb2J3Dn2HPpYsoW6PH4ZhhurCmi0ABIzwwo9G1V5WT9vcwJFy2Wmoesx95Zkv1DGAX8d5FhS2dOL3z13J+t3zDuxBXc8mv6WKy7eEztjwo5kWF36qYlSKDjNbz5K1G0Ob57tO9P/ve8x+HfAEHbNo8Y8B7Kwu1ZaiBiM0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=RBJ4drAk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XoA4obnl; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailflow.stl.internal (Postfix) with ESMTP id 771401D40AAF;
	Tue, 25 Feb 2025 05:41:15 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-11.internal (MEProxy); Tue, 25 Feb 2025 05:41:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1740480075;
	 x=1740487275; bh=XK5p1hiUrczS04SoL3Bp/F/Lh9UgXsKum/DNMyd+O3I=; b=
	RBJ4drAkDi4M6YBkaCDOqDyN5wCHQPYi9+AfGeMwqY/qpNlNFQ3tUtNMuSxkJ916
	AnAegG6ilVT6O5uhDSEx4RZgpKZtmcqPbnB/tH9tRlk4RDW39k0AGiYBU1jRhdUr
	0Wp8LzI5Xq4OSPrzxTYuGKCxBqH536zeTNHfAmYadWnxvyQLwTwug8UaY2x0sBhE
	TaYKcfLoj6PBTY+w1ccIaD5DeAY7uj6B+MKb8xxobj3E0SCTdBkjZE39GHupz8I8
	P4/OLlpAFyiajOh9YEldB+9a/ToImHuvkhihwEDeZU56TrrvssXSpocCa1psxdvw
	fzxLkrazdsA6vRMN18y2SA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740480075; x=
	1740487275; bh=XK5p1hiUrczS04SoL3Bp/F/Lh9UgXsKum/DNMyd+O3I=; b=X
	oA4obnliMVtK81ARPbqdZ07OboZjzjkmDRfWTS1tcVjsjmsa17tHABHV4RDSsdyq
	KN0jtmkGK6jEcr3bnIjGm1udZPSR6Y/uRgz1obXxSGFcBdpZaNQlhrIbaOxzmjYe
	v3oAm5kFs7hXBLtLO0she2IdbNoY4zE/nrLXuZ1NjF8hTEg03kDl6iohyRjlXxEu
	wn0e6sw6GsaW9VF7xzEMVXuISb6u7cPbSiHT4yPKL43ke1j540dT6H7CvcdaxoRj
	OeXZ44bFHFPdTDULpkJM7vwnp1E9nq0r3biwQBKaVYKkPrA373Xv2tyaX/FfxTg3
	L7XIQyDN1NK8yjsyyf9Ig==
X-ME-Sender: <xms:SJ69Z8PIPrKoIf0WLmDVsJZRD0UIErH0GFbM-vreL38xFgXO-WbIGQ>
    <xme:SJ69Zy_J1MKQPKLDORJXm1Rch9Uhl8hOI_pv6gYaR1AaaUjQuZHUiMJN3beSmP7Gm
    kPv2q8QxKGje-8bV68>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudegkecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:SJ69ZzQ7DlK47wxwEdju5ydbxXko8vqNS1vPjJgdtsbTgehkaks9OQ>
    <xmx:SJ69Z0tZE6pDE5BZwf2s5KHij7mengaxDMV7dwwvVFAexTZQz6Zx_w>
    <xmx:SJ69Z0cr3mO3NoRQleVX3wpKPk9j9PA-yGSDh95R3j9y8YpsBBW7pQ>
    <xmx:SJ69Z43T1BgmWCTnSnOsbP_Zj1FXm0XrXiAlYIW-7e5AqkjZ2TzBxA>
    <xmx:S569Z7uEE9GKvRJyoyVMzDIQM5s6J6f_qx_1sZuvcT1k8e2bLBLD7mtJ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 82A852220072; Tue, 25 Feb 2025 05:41:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Feb 2025 11:40:51 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Amir Goldstein" <amir73il@gmail.com>,
 "Andrey Albershteyn" <aalbersh@redhat.com>,
 "Darrick J. Wong" <djwong@kernel.org>,
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
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-api@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-xfs@vger.kernel.org, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 "Theodore Ts'o" <tytso@mit.edu>
Message-Id: <3c860dc0-ba8d-4324-b286-c160b7d8d2c4@app.fastmail.com>
In-Reply-To: <20250225-strom-kopflos-32062347cd13@brauner>
References: <20250211-xattrat-syscall-v3-1-a07d15f898b2@kernel.org>
 <20250221181135.GW21808@frogsfrogsfrogs>
 <CAOQ4uxgyYBFqkq6cQsso4LxJsPJ4uECOdskXmz-nmGhhV5BQWg@mail.gmail.com>
 <20250224-klinke-hochdekoriert-3f6be89005a8@brauner>
 <6b51ffa2-9d67-4466-865e-e703c1243352@app.fastmail.com>
 <20250225-strom-kopflos-32062347cd13@brauner>
Subject: Re: [PATCH v3] fs: introduce getfsxattrat and setfsxattrat syscalls
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Feb 25, 2025, at 11:22, Christian Brauner wrote:
> On Tue, Feb 25, 2025 at 09:02:04AM +0100, Arnd Bergmann wrote:
>> On Mon, Feb 24, 2025, at 12:32, Christian Brauner wrote:
>> 
>> The ioctl interface relies on the existing behavior, see
>> 0a6eab8bd4e0 ("vfs: support FS_XFLAG_COWEXTSIZE and get/set of
>> CoW extent size hint") for how it was previously extended
>> with an optional flag/word. I think that is fine for the syscall
>> as well, but should be properly documented since it is different
>> from how most syscalls work.
>
> If we're doing a new system call I see no reason to limit us to a
> pre-existing structure or structure layout.

Obviously we could create a new structure, but I also see no
reason to do so. The existing ioctl interface was added in
in 2002 as part of linux-2.5.35 with 16 bytes of padding, half
of which have been used so far.

If this structure works for another 23 years before we run out
of spare bytes, I think that's good enough. Building in an
incompatible way to handle potential future contents would
just make it harder to use for any userspace that wants to
use the new syscalls but still needs a fallback to the
ioctl version.

     Arnd

