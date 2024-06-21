Return-Path: <linux-fsdevel+bounces-22092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85483912145
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 11:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1FAF1C21104
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 09:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E036016F85E;
	Fri, 21 Jun 2024 09:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="MKJcxPLG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X7nAgy7B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA79B82D66;
	Fri, 21 Jun 2024 09:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718963567; cv=none; b=QZ/ROz4RRf8N2W2wtQvFp9YBoBOjC7uP2YD/qZLPsDWp5vYe/21DSHe6akkvTws6p56+jX45blE7cJwKjYoL4QuSaW0DtKtIMys3n1WYtXDQ2V5XPXDDlHzG1Jdv+6bjYFRwHwo3lXbvbw/2QHuhU6vIRgmonFKyrLzPj8nH3dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718963567; c=relaxed/simple;
	bh=l0lDQgZrcjAUqFhBaSXXDIaBllThVG1SJNZgat8tRkA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=GHuNi2TNuZphHN1AvGpkNOWDpH/DPdvgz3HR3e0Q4T/+Qg41NuffODU0q+L8j0BaCa67mlNpBe5AjjfPyzReHt5vBAPzmpW9uL+1kxQBujbIb4Iw0WhbmGSk1lM1HMyVmLn+saL1GsX0DCzsrDPWeaB7tssrRopPQW6F50VHqmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=MKJcxPLG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X7nAgy7B; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id B795513801A0;
	Fri, 21 Jun 2024 05:52:44 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 21 Jun 2024 05:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718963564; x=1719049964; bh=WMGDo/weqH
	B9YDWLlQD6sLBRrGER7ScpjCWRSqIRAJU=; b=MKJcxPLGgvmkBY+j/HTLZjZ8KI
	pvGXw459FAlanf7Ac5v5b80QkLQF8xlXMpxYpBvx4w9U/JqBjy+WLg42sp2LCoU7
	Q1b7sVY0U9atF6syLC4XY52fNn0nDOmK/ZAU1NPDw3Ole9FWcIKsJ3WhrUSbjS0O
	i2l2ZiXzugEyGrEBwdm3cuJRW2BdSaCh9EPr80/iCCtKcq6Na1X7f0bajgjej8Tx
	FitYQuzmPjk0hPwNzDjYuPI+Yp1cAv/YSHWqMQzL0+ow//AxFir6unBR1Xx43VMt
	sTtOJWUxx7oJFStml4ol1MIfUqgzo4a50v7aYyXLtepLNGOKd3V6UG9I95kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1718963564; x=1719049964; bh=WMGDo/weqHB9YDWLlQD6sLBRrGER
	7ScpjCWRSqIRAJU=; b=X7nAgy7BTqyAvR65qflUPcwaq1L6pXZMoo47rxn9ZM3V
	sKDdHt5wvqDbT5sa14aR9hCMiL0oj6CvWrv8SKMrJq40IWWOWM8MbFp61EphmqmA
	GCBih7Z83pGEIOJtdrxEY58EcLZTCfr3LtYlO5Bk5HkZc4y2HUPbxdUUvLm78WWR
	6tuoSmWxlD/uu2pPsgmL8g2dFZKC0Xt/QAcoFkPreb180QnAWGYkaopwGC6yCFEm
	/Z+Br4e5r/bgM/ZXXRokPJT4v4p+Ba0c7m4Kpk7n6XdiBc6ZZ4ATNt57/k27/Yh7
	tkRb7e0hgdJYE6Yo5pJL5NM0EiwSlMy6buj3koNHsA==
X-ME-Sender: <xms:a011ZoRKk0xgtXrnk7B-qG7CoQgSoOMrP6uxlJU8ziJL2FLkCKjJ-g>
    <xme:a011ZlxuT2HoJobpF--UwiCQxrck0_h0q9Qbx7ELDLXtD-5We7CXp5ouF-xDkVRRJ
    XeIZNFUDqIuP2U5LAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefgedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:a011Zl39KEhZ-U9AaTAu3qpgNWAWYG4Puo5AAhWDqyHAU63ILvKvOg>
    <xmx:a011ZsDatAkgsBYef_mlo8HxX4iiDqSBQuQ7pbgM9HyizWRoDF7JfA>
    <xmx:a011ZhhozQMBHEtX3Ty6cO1Tqt3jE9LlaBWOyo6ySWIoCH-OSDkLxg>
    <xmx:a011Zop-AXFZkCbuJe_8FCJsMNZLUN5VvVeVPrHUajKBVXxUTW5uxQ>
    <xmx:bE11ZsMsQ8wP4yZocAMKl9MACO-_6K03a9Qh0f0TNL0WVY97DHdpMQGU>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D8547B6008D; Fri, 21 Jun 2024 05:52:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-522-ga39cca1d5-fm-20240610.002-ga39cca1d
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <83613d85-53f9-4644-be68-4f438abe2e52@app.fastmail.com>
In-Reply-To: 
 <a623c1979ac494d01977abe6dfc22e8381dc6e4f.camel@physik.fu-berlin.de>
References: <20240620162316.3674955-1-arnd@kernel.org>
 <20240620162316.3674955-8-arnd@kernel.org>
 <e80809ba-ee81-47a5-9b08-54b11f118a78@gmx.de>
 <1537113c4396cd043a08a72bdca80cccfa2d54d9.camel@physik.fu-berlin.de>
 <ba14c4fb-e6a7-46b3-a030-081482264a99@app.fastmail.com>
 <a623c1979ac494d01977abe6dfc22e8381dc6e4f.camel@physik.fu-berlin.de>
Date: Fri, 21 Jun 2024 11:52:23 +0200
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

On Fri, Jun 21, 2024, at 11:03, John Paul Adrian Glaubitz wrote:
> On Fri, 2024-06-21 at 10:56 +0200, Arnd Bergmann wrote:
>> Feel free to pick up the sh patch directly, I'll just merge whatever
>> is left in the end. I mainly want to ensure we can get all the bugfixes
>> done for v6.10 so I can build my longer cleanup series on top of it
>> for 6.11.
>
> This series is still for 6.10?

Yes, these are all the bugfixes that I think we want to backport
to stable kernels, so it makes sense to merge them as quickly as
possible. The actual stuff I'm working on will come as soon as
I have it in a state for public review and won't need to be
backported.

     Arnd

