Return-Path: <linux-fsdevel+bounces-22085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB81911FD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 11:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C4AF1C23657
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 09:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AA316E893;
	Fri, 21 Jun 2024 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="H7mCTDwx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K4cdFx4S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138D2171668;
	Fri, 21 Jun 2024 08:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718960213; cv=none; b=Whx2tsQkVu3tvnzBK5f/EaJ/hGZTEZ+p+MAGeeFB/Xn5tx9zi4Yd4e5MupJH1RGfd+u+Y+MovcF4Zi+rV9bOgi6kTE29e6vIIdytBsb1o8GHhGYWpjZLSFpfbfmR0N1B0XxQG2hrEH7Q044xJzNokAaY8N0J3cm7ZXl1+GRc8e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718960213; c=relaxed/simple;
	bh=yVhYX7Qb1K30DljPx/XNunSHMQ4LAqLxqGqIBasoGDs=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=qbwSlGgf0dHrC+JSrDEsGznza8P1eAJfPgbFh+dxmJMA2pf7BbR5meDXND4V2WkzzabglokWL1z6tZMSvymEw7eBgB8j5gBgGanlhVZWEnhYN4QkO8TF9g09uqmvfo/IGUqbKlugMIukF6uvbHA07xUGcZJ9XXSQ39MAUlqMP3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=H7mCTDwx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K4cdFx4S; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 153A01140210;
	Fri, 21 Jun 2024 04:56:50 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 21 Jun 2024 04:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718960210; x=1719046610; bh=LCP3GPJDV8
	F/N+nAlcGiBZYx7s7qKdEXuPIAtCYCsw8=; b=H7mCTDwxBhL6/3nl2kvwH7Z2jf
	vHvRWJWjo62xKNC7P63pFKMi0lGQH1oK9d5uLt4KZnRj6RDabX6f042YKlcBY7VL
	ZZq1IVlKZ2tgE49wrDxmbx5ZugEMclHbG+fKzej1xJSCVx2tZvZ3YPE5yAhRu1hX
	g6XV6uYI8W0AZrAHJH7GLQD/PzjDkfnuabR9xUItNv+SX/LSx1+9CeE43E1pWrsw
	H3/6KJ+q3UXf2HjYInaAx+URfx3SrV1MtmOIAqug46Iecs28LMSKwCe+Wulv7Yzh
	+lVLEByNlljBiKAtUqzaNB80GN0U3FbfHu66zSBtt4AZT/eJby+pGlrYPqRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1718960210; x=1719046610; bh=LCP3GPJDV8F/N+nAlcGiBZYx7s7q
	KdEXuPIAtCYCsw8=; b=K4cdFx4S224MYRT+r8L/r9U1j5q9lsA7B7hhlIrlPjWc
	7EDb3ZPjlybzPs2NKQgEkl/fSHKd0CDqzFXj7P3t+qGfnRRJ78YrIYGTuI3sC43Q
	6y8H6AA1V0PIijyE6xMkgGupwrnRWrZbay1fonLCHWP6Qa/M3EcTzWO0bm0ePn1Q
	O38dmf9if6C4B+mrVHd9kbUcCSEJwcWVo6jkCthFmcFHahki2cGoOM3KesCvklVz
	YT5grRrYymPqsYUACYcdY9Sp9ICM60lfM3yEmkxnIiJkr+UigAeW3QKYo6psB+j+
	ytsTijk6h1ZVtxvQRM1KQbzMrZL3rRnt47XsyTlhYw==
X-ME-Sender: <xms:UEB1Zm4izm0yfspkW7ydjajHNz_V1xCdigbmfAZFmL5oM63ee-Wyhw>
    <xme:UEB1Zv6YEV3Oe7A3j2UMK3TBnvu3IWBefk9T9nUTdlpS5WMN3RIeTZ_JYgTz2Q3Id
    Mp3CcHRYUWGMbC0aLk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefgedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:UEB1ZlewerVmgQOEvLDFfmzpJCOmUBZQGyRAmjbsdJfs6xzQkp-YFA>
    <xmx:UEB1ZjKrwsZrMN1BtdbMbDwR4OJmLJPFU-kCoOw2HcS_usyMMgHDsw>
    <xmx:UEB1ZqKUDfHnKePjmuIj68bW7G0CAsctQb5pzimSurs_Ge9Zp4ONZA>
    <xmx:UEB1ZkxxkNjEJAVWyRsEOh7wRilHzDQTxq6cEooXIRlUnDuIBwJ2SA>
    <xmx:UkB1ZqViuRkEf_iw5Waz5bDUqxF18TnrV2GO1kTJMH4GWiGo1Svimx46>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 38B95B6008D; Fri, 21 Jun 2024 04:56:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-522-ga39cca1d5-fm-20240610.002-ga39cca1d
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ba14c4fb-e6a7-46b3-a030-081482264a99@app.fastmail.com>
In-Reply-To: 
 <1537113c4396cd043a08a72bdca80cccfa2d54d9.camel@physik.fu-berlin.de>
References: <20240620162316.3674955-1-arnd@kernel.org>
 <20240620162316.3674955-8-arnd@kernel.org>
 <e80809ba-ee81-47a5-9b08-54b11f118a78@gmx.de>
 <1537113c4396cd043a08a72bdca80cccfa2d54d9.camel@physik.fu-berlin.de>
Date: Fri, 21 Jun 2024 10:56:27 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Helge Deller" <deller@gmx.de>, "Arnd Bergmann" <arnd@kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Cc: "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>, sparclinux@vger.kernel.org,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, "Brian Cain" <bcain@quicinc.com>,
 linux-hexagon@vger.kernel.org, guoren <guoren@kernel.org>,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
 "Rich Felker" <dalias@libc.org>, linux-sh@vger.kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 "Xi Ruoyao" <libc-alpha@sourceware.org>,
 "musl@lists.openwall.com" <musl@lists.openwall.com>,
 "LTP List" <ltp@lists.linux.it>,
 "Adhemerval Zanella Netto" <adhemerval.zanella@linaro.org>
Subject: Re: [PATCH 07/15] parisc: use generic sys_fanotify_mark implementation
Content-Type: text/plain

On Fri, Jun 21, 2024, at 10:52, John Paul Adrian Glaubitz wrote:
> Hi Helge and Arnd,
>
> On Thu, 2024-06-20 at 23:21 +0200, Helge Deller wrote:
>> The patch looks good at first sight.
>> I'll pick it up in my parisc git tree and will do some testing the
>> next few days and then push forward for 6.11 when it opens....
>
> Isn't this supposed to go in as one series or can arch maintainers actually
> pick the patches for their architecture and merge them individually?
>
> If yes, I would prefer to do that for the SuperH patch as well as I usually
> prefer merging SuperH patches in my own tree.

The patches are all independent of one another, except for a couple
of context changes where multiple patches touch the same lines.

Feel free to pick up the sh patch directly, I'll just merge whatever
is left in the end. I mainly want to ensure we can get all the bugfixes
done for v6.10 so I can build my longer cleanup series on top of it
for 6.11.

   Arnd

