Return-Path: <linux-fsdevel+bounces-38760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC543A080F8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 21:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAFA93A80EF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 20:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC5E1FF1C0;
	Thu,  9 Jan 2025 20:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="wqTVVK7d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bA527m9P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D4C1FBEB6;
	Thu,  9 Jan 2025 20:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736452811; cv=none; b=sVbqXsO1e0wTAt/yCkdz1lY5Hx0JJO3D44XqAzaYjA8mVeR/Yfc4SKKbdIzpvXC8CpSszp2YQtdNua2cEqnt1nPdASDGwN/emh6ofThKJRL8BPDTOCX/vPV2Lc3koxp+psrgLVwIrudnKuVNenA3y+dXBGAPGgzQ8CfMqKJo3Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736452811; c=relaxed/simple;
	bh=Z2Nx8enSglc7LcdfuFFSOlFjCaW3fClvgCHT8rxPpww=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Dgg1m4cVnugJA+6c3j4wVpiyWwDMs0F2KRs55SA9fDP73L9WKi552Rtwv+ELRX1v/bZ1zL5r/ziQU2ZOh3Cn4gxpIdlubRg5WXq6b+Yp1Hp5OvDAHxhRTJlagQ/WFI7q5cS5khZngH3yyxc9SYSZwBa0gu7jA1cEJLwucjCKJQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=wqTVVK7d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bA527m9P; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 744621140235;
	Thu,  9 Jan 2025 15:00:07 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 09 Jan 2025 15:00:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736452807;
	 x=1736539207; bh=XLTeDIvd7zmMPfL4q/D1OTLpXR3HFsMk56y3E9zO+KA=; b=
	wqTVVK7dPXJAB2lQStsN6IxoHN2Pj6d34ve3t+KQvJ1KMQpnsys/eJQxWbYklwb4
	OsAq8M5IBNnqSL6OP9ObN9lr1L2N76Jh+6gWue2R38DKnnIcsvnf5SSJ0z+xqUHQ
	k5dOQV1qZHGqvuxUSA02veKmYONF1xtJvge/c/zqo/kH6B8bYyNs93WlOHT71sGP
	OlC6sDDYVpY9/OGJbtI1wLJYkApPIRi0rjmpZfypp+IxOMcDTNEytl825EaViivU
	32seRLxpGbGkw6mREV5QxVROg6A++lg+UsVLWipHxI/BkNAcGSx08Ye90dmQzxxq
	/FY6hWjgMoCCZh//DUbtbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736452807; x=
	1736539207; bh=XLTeDIvd7zmMPfL4q/D1OTLpXR3HFsMk56y3E9zO+KA=; b=b
	A527m9PBFcwabQVd8yZImD6568uyMmtm1JIXXCIYUtS3OODLVDiYD73bOCWkQxOq
	IGGey/epZxo5OWqYFPFL8rmC7fhw/Q+IyiAT4QmpyKQt71us7NEESH5zp+RMXxna
	6lCvGMlG4XUUcA+x0ENll/WMwi8uArmiDWwLZy8Lhkk+o47kJY7jFeGE/fMWv+Kq
	ZGb3DufO/RK2ExnAnrnEyiPiU1W3sCftOJ7rPnMecgSN25NPcw3XLMBl+cGdfdek
	Hm9ctEPXkfxwxvPkYjHAYb4ZCzrSz/fuTqKDVscM59oGy2U+fe1Pg6ZVHUUHociA
	kPLBFE8EdrdczZbulsLGg==
X-ME-Sender: <xms:xSqAZxrURnPaa3dQJakFaALo8nuiVsSBuuMgSpV2-x-zITx1qK10sg>
    <xme:xSqAZzrHpROl3dL67vMtZhKKA_tifFhkQO_R26Mf-AF2U_ABfXmWosZQou3cFhhqa
    uM3BVx34LXfG9uiZj0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegiedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeef
    uddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpd
    hrtghpthhtoheptghhrhhishhtohhphhgvrdhlvghrohihsegtshhgrhhouhhprdgvuhdp
    rhgtphhtthhopehmphgvsegvlhhlvghrmhgrnhdrihgurdgruhdprhgtphhtthhopehjtg
    hmvhgskhgstgesghhmrghilhdrtghomhdprhgtphhtthhopehnphhighhgihhnsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhuthhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnrghvvggvnhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:xSqAZ-NHbDtZv25PVnvrhdYKkO_XGBK5uacgLxnGjuRiVCxVJfbe3g>
    <xmx:xSqAZ8751_nx_wm3T7pycbKPKjyX_DprmSOI810Jf_zWkUQlYQfEwA>
    <xmx:xSqAZw41kJVFxoksZLEJIHGUPsJY1LDXgJMdaMNo21UuhcvsUuDuMQ>
    <xmx:xSqAZ0jH38ur-qtEMUQVvfGvkDvk5Ja80JKFM3V-VkHaqlAUxsRLKg>
    <xmx:xyqAZ8FPs8CB2q6dYLLfVz8oFDTaugCG4o3zlqe7SWmIznMsnuK4VEBV>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6DFD82220072; Thu,  9 Jan 2025 15:00:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 09 Jan 2025 20:59:45 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andrey Albershteyn" <aalbersh@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: linux-api@vger.kernel.org, "Michal Simek" <monstr@monstr.eu>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Naveen N Rao" <naveen@kernel.org>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, chris@zankel.net,
 "Max Filippov" <jcmvbkbc@gmail.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <e7deabf6-8bba-45d7-a0f4-395bc8e5aabe@app.fastmail.com>
In-Reply-To: <20250109174540.893098-1-aalbersh@kernel.org>
References: <20250109174540.893098-1-aalbersh@kernel.org>
Subject: Re: [PATCH] fs: introduce getfsxattrat and setfsxattrat syscalls
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jan 9, 2025, at 18:45, Andrey Albershteyn wrote:
>
>  arch/alpha/kernel/syscalls/syscall.tbl      |   2 +
>  arch/m68k/kernel/syscalls/syscall.tbl       |   2 +
>  arch/microblaze/kernel/syscalls/syscall.tbl |   2 +
>  arch/parisc/kernel/syscalls/syscall.tbl     |   2 +
>  arch/powerpc/kernel/syscalls/syscall.tbl    |   2 +
>  arch/s390/kernel/syscalls/syscall.tbl       |   2 +
>  arch/sh/kernel/syscalls/syscall.tbl         |   2 +
>  arch/sparc/kernel/syscalls/syscall.tbl      |   2 +
>  arch/x86/entry/syscalls/syscall_32.tbl      |   2 +
>  arch/x86/entry/syscalls/syscall_64.tbl      |   2 +
>  arch/xtensa/kernel/syscalls/syscall.tbl     |   2 +

You seem to be missing a couple of files here: 

arch/arm/tools/syscall.tbl
arch/arm64/tools/syscall_32.tbl
arch/mips/kernel/syscalls/syscall_n32.tbl
arch/mips/kernel/syscalls/syscall_n64.tbl
arch/mips/kernel/syscalls/syscall_o32.tbl

       Arnd

