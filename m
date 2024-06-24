Return-Path: <linux-fsdevel+bounces-22235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11203914A45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 14:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422621C231DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 12:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B0813C8FE;
	Mon, 24 Jun 2024 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="HKfHHn7u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SqE/KFUp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E959F1386DA;
	Mon, 24 Jun 2024 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719232631; cv=none; b=u5PKPBsMQh5BdRTxwEXl6ZxRP6b4l3dIEgTLuKi3VEAAUeeWAOEp9KanPjqZH4nLOOmlXWzur+VSf/VFgGNZQaIMb93F9I0tPJU5iaiqsh4NriKvmAueQ+qYBINSvrMelxKwlKip5zoukTXLIwncXVJ82V1yWr6bz8Bke7p4cH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719232631; c=relaxed/simple;
	bh=TbmH+yoyAgf4fe9CUvwuV5yJgzh5ZHwbkVCsLRZgEQ8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=UyEObqEv0W7q47teygKnMYdf+FuJzUPP+2QoJRe/Len2hnAvPYUzi9gww2O4ecbPQBXejxKwAZE+6IhAPorNIXblrp4elQvOYBxt3TyFdFkgbqzlXzvE3Vc0J5OTHS1M2PaDsXvI7syb2fIGp6aJihVJYiJgSQ5mFo9X+J+LYjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=HKfHHn7u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SqE/KFUp; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 07C5B11400E4;
	Mon, 24 Jun 2024 08:37:08 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 24 Jun 2024 08:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1719232628; x=1719319028; bh=lFXvov0ksU
	8Pc4ucksxO9SvwB7S7ZcSyst60pbeeZH8=; b=HKfHHn7umsdW+0c1ehuSJQ99eI
	Myjn3JHII41XjBGkBE82U3ZLF1gpqJUHWfu0fD1R2wDTT4O5lDapBn9tPESvQu77
	8adNnRplVreG2sPNDp0X/rfGleHLut9Gk/BSzkxRKhL04EDXsG1YRKgxv6IL6gBV
	hiECEd8aKPxpc7cvdwq2YkiIfftlQjXB9+KAYBuvYvOjmxwZ7/F9l3LRlEL5RFo3
	063MmLg36ab0j12O1asXtLt3D5DVUiK5EvC72HFvCSk3AleE/g7i2STrQpvD5No4
	i+lJKlbqcQQIUGGQGOvBpwpmcMBptK7y9aRt5R4yzWI1IbKl5+ANpAHr7VSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719232628; x=1719319028; bh=lFXvov0ksU8Pc4ucksxO9SvwB7S7
	ZcSyst60pbeeZH8=; b=SqE/KFUphRWeVMJb+kfwzgwN1/Hu23nlRESAJfYgc8ML
	pUz2mmmI8F5nmEqE+5ox0g/rjJ6d0Zb285uqwFyeJQcQZsscUdL/sXj/UaEluip+
	Y8hGi2uVUqhxSS2j+Tg9/Mp0Zm2wYNokTin+aYRk4BLKmOWC6+/LDFt4sIkWw2DL
	h/Je6x5AernFk742JykHMAJAodzv6NFC7WvmD1gw90TOsbHe5Ze1AinDq0CmjjKA
	Z95MIl9q9aP4NXQ+7dphFhlbY9tl+CfCvo6YBxD12RGqejBt7qQshI8pAPifYgLG
	pqaC18LuaHL4DH+Btw3GZ5ixeMLofnITMxBNO+thYQ==
X-ME-Sender: <xms:cWh5ZrLj7Is9v5gIq1mXIwuK3B6Z67FMFXi_sBM56MqeKqAR64n6TQ>
    <xme:cWh5ZvL6fPST5egK7_VqUyPLzOA0tCn6X6DlKYOektXFx1cgWvkKCjEMrv6PEjXyW
    4yPi_m7QPeT9rWgx9c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeguddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:cWh5ZjudJI3oixudlca83stC9GtoJPVF-yfqIooUyooPVxKMkRay5w>
    <xmx:cWh5ZkZgIV_EAxNKJdd3dn5ts0jsz0iQNgpwAoaYwIkaiwKIL8UoqA>
    <xmx:cWh5ZiamgC5g2Z463RDvkqIdIU3iA-8c5MxvqJ4odiwM6cjvoG_-fQ>
    <xmx:cWh5ZoB--wGmM0xyN9laN1DWgxiskyw40gTH9IFx_cFQRyZCDpYBHA>
    <xmx:c2h5ZhnZnhgadejE1PelPCjBJhfYQ9s6ZgcSotBgFkM80Ux8nV4bq0wf>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 838B9B6008D; Mon, 24 Jun 2024 08:37:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-522-ga39cca1d5-fm-20240610.002-ga39cca1d
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <eaa0ffaf-e42d-4b86-9eed-534684815cf8@app.fastmail.com>
In-Reply-To: <20240620162316.3674955-15-arnd@kernel.org>
References: <20240620162316.3674955-1-arnd@kernel.org>
 <20240620162316.3674955-15-arnd@kernel.org>
Date: Mon, 24 Jun 2024 14:36:45 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Arnd Bergmann" <arnd@kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Cc: "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 linux-mips@vger.kernel.org, "Helge Deller" <deller@gmx.de>,
 linux-parisc@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>, sparclinux@vger.kernel.org,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, "Brian Cain" <bcain@quicinc.com>,
 linux-hexagon@vger.kernel.org, guoren <guoren@kernel.org>,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
 "Rich Felker" <dalias@libc.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 linux-sh@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 "Xi Ruoyao" <libc-alpha@sourceware.org>,
 "musl@lists.openwall.com" <musl@lists.openwall.com>,
 "LTP List" <ltp@lists.linux.it>, stable@vger.kernel.org
Subject: Re: [PATCH 14/15] asm-generic: unistd: fix time32 compat syscall handling
Content-Type: text/plain

On Thu, Jun 20, 2024, at 18:23, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> arch/riscv/ appears to have accidentally enabled the compat time32
> syscalls in 64-bit kernels even though the native 32-bit ABI does
> not expose those.
>
> Address this by adding another level of indirection, checking for both
> the target ABI (32 or 64) and the __ARCH_WANT_TIME32_SYSCALLS macro.
>
> The macro arguments are meant to follow the syscall.tbl format, the idea
> here is that by the end of the series, all other syscalls are changed
> to the same format to make it possible to move all architectures over
> to generating the system call table consistently.
> Only this patch needs to be backported though.
>
> Cc: stable@vger.kernel.org # v5.19+
> Fixes: 7eb6369d7acf ("RISC-V: Add support for rv32 userspace via COMPAT")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I had pulled this in from my longer series, but as the kernel
build bot reported, this produced build time regressions, so
I'll drop it from the v6.10 fixes and will integrated it back
as part of the cleanup series.

     Arnd

