Return-Path: <linux-fsdevel+bounces-22075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC48E911BCC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 08:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E684B2454E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 06:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2820B15A49F;
	Fri, 21 Jun 2024 06:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="YUfcwoBS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TsA19tge"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936C93C0D;
	Fri, 21 Jun 2024 06:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718951418; cv=none; b=JrJ5X7HnFYyRibmcCf7RKcHoJJt6rcgeXyDEX65aeQtRxlCDvx8opqyR74lnoMAsQDcwrpjRLaKQTq62dKR/PJonIcMH03lPi5Vx25A5JbTtftS0md4dNN5nbLdnWcL4g7z0aOYHagXEL3I91SSrtW2EcH7/RrwyNo+2Ue2xXzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718951418; c=relaxed/simple;
	bh=QTDvmlCgRLlBME4zt8gkdNo0SO4LeIf5kG63XslMO08=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=JTLcaXE9VWs/8QTVR1wiGkx7Ibvw113svzT9wDCrFfJOJ7cVtFR7OxapD/mQz5Dfiz8FRSLsb/jbJ5Dyvxfz2Tl6RZjkxZUdnzV1RThZFphJwaQuw717gR37OHAK8lSQV2Wvjaekq71Lqola5Iu8mDgaN2rSyWvDRMLR+o6UnEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=YUfcwoBS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TsA19tge; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 84F2B138026C;
	Fri, 21 Jun 2024 02:30:14 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 21 Jun 2024 02:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1718951414;
	 x=1719037814; bh=0NAp6YpmQQzb+XaqCHOddozx1CwlQxt9qQHhSQdm/eM=; b=
	YUfcwoBSCsdr4lbdFToY1N/Zs4J4ckS/QAFHkFhDVLoMlvGNE9DG/Up12YB02Xt2
	EvdhpTEPC4jKy9ytn/wkuqfYy4S1cppgeD4oj7WA+/5sqCNg/z+lPwlRbPyO/Flv
	86iciY4yavDos8ifYZIvOfII9G79cFp+BbP22J8pM9RrD+d18AtMZbn8j9nT03bV
	c7xQT06XqtjmkNTJ3loldGGvKZUIHFOFW5y31AIvhjBqlktBLCcT2CdKqNOYzmSV
	sMmQF4/bSVH0PEqvVO/XPs0/1B6SgKYgXBpAog/xndEaqaywJvgFOBJuhrryZ4PT
	p2/5cEIyG3XclTxM5zIk6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1718951414; x=
	1719037814; bh=0NAp6YpmQQzb+XaqCHOddozx1CwlQxt9qQHhSQdm/eM=; b=T
	sA19tgeRrtyO5cROFsAr3JW3gCmvjTkfGvoIFyTvlgeMHOUsPYhUf63dPMHGumOG
	SIVUOPVMYqUiSDU81ctnvLlpO9PEmKT5nYGuN8Yk6mi2deAmhqwvD8T8lcVqcfB1
	GPqL5qicjYl82FohTt6bsxJU60LE/Hsa42KrOIywf7lBtaIPivddS4cPuSL9Zm6B
	LHiJJ7dQip90rRSAu8Rm0KDbhCZ/X7xYsJbH8aqLdEew+kE5apOFPvumBP+Yp5Fz
	Rr5E19oZ7V3IGyh5IXREy5PC+msQ9aq0CnRgKaDNrD+E/iA5xot89u78VGuhZWhK
	zW007umSQsVkCbMOwZN5A==
X-ME-Sender: <xms:9B11ZuBxjRBAW0tNynq8H1-YRQjdkmL-JPoLIbLq-orE5Mdjc1QF6A>
    <xme:9B11ZojY_qLmvoF_ar3eB4_lK44-YnS7iEik2csxzA9Ys1vKqB1JAHCw16DZLb5Ul
    cdeR1H2mE3zhLekbAU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeffedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepueelffeiudevhfettedvhfevkeekveevffehveehhefftdeiheduledu
    iedtvdffnecuffhomhgrihhnpegrkhgrrdhmshenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:9B11Zhm6zOHfU1WuWgDdoSU71qsQzLDsjAJ7Nhxw117RxV0KzM2GHQ>
    <xmx:9B11ZsweTZURJjYSmpSNhPg_buY1pvgdHiULQsyQVa-AcYIqIMlFBA>
    <xmx:9B11ZjQp1WOoJc2XCjVhKQs5UkDHi7Xc0oSg1RRu1sY5kpyhJuIyfA>
    <xmx:9B11ZnbfnZmS9DMt_cIsivY9q90FCfqmpn7bFXeT3Vnm0PLjcHHdDQ>
    <xmx:9h11Zm92tL5faK9ZKeseMNCfbg9AEZegZt4gth5vlZ0KCBBhZQ4GEtV8>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 60EDBB6008D; Fri, 21 Jun 2024 02:30:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-522-ga39cca1d5-fm-20240610.002-ga39cca1d
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1308b23a-d7c0-449e-becd-53c42114661e@app.fastmail.com>
In-Reply-To: <e22d7cd7-d247-4426-9506-a3a644ae03c4@cs-soprasteria.com>
References: <20240620162316.3674955-1-arnd@kernel.org>
 <20240620162316.3674955-8-arnd@kernel.org>
 <e80809ba-ee81-47a5-9b08-54b11f118a78@gmx.de>
 <e22d7cd7-d247-4426-9506-a3a644ae03c4@cs-soprasteria.com>
Date: Fri, 21 Jun 2024 08:28:40 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "LEROY Christophe" <christophe.leroy2@cs-soprasteria.com>,
 "Helge Deller" <deller@gmx.de>, "Arnd Bergmann" <arnd@kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Rich Felker" <dalias@libc.org>, "Andreas Larsson" <andreas@gaisler.com>,
 guoren <guoren@kernel.org>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "musl@lists.openwall.com" <musl@lists.openwall.com>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "LTP List" <ltp@lists.linux.it>, "Brian Cain" <bcain@quicinc.com>,
 "Christian Brauner" <brauner@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Xi Ruoyao" <libc-alpha@sourceware.org>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "Adhemerval Zanella Netto" <adhemerval.zanella@linaro.org>,
 "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 07/15] parisc: use generic sys_fanotify_mark implementation
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024, at 07:26, LEROY Christophe wrote:
> Le 20/06/2024 =C3=A0 23:21, Helge Deller a =C3=A9crit :
>> [Vous ne recevez pas souvent de courriers de deller@gmx.de. D=C3=A9co=
uvrez
>> pourquoi ceci est important =C3=A0
>> https://aka.ms/LearnAboutSenderIdentification ]
>>
>> On 6/20/24 18:23, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> The sys_fanotify_mark() syscall on parisc uses the reverse word order
>>> for the two halves of the 64-bit argument compared to all syscalls on
>>> all 32-bit architectures. As far as I can tell, the problem is that
>>> the function arguments on parisc are sorted backwards (26, 25, 24, 2=
3,
>>> ...) compared to everyone else,
>>
>> r26 is arg0, r25 is arg1, and so on.
>> I'm not sure I would call this "sorted backwards".
>> I think the reason is simply that hppa is the only 32-bit big-endian
>> arch left...
>
> powerpc/32 is big-endian: r3 is arg0, r4 is arg1, ... r10 is arg7.

Right, I'm pretty sure the ordering is the same on arm, mips,
s390, m68k, openrisc, sh and sparc when running 32-bit big-endian
code.

It's more likely to be related to the upward growing stack.
I checked the gcc sources and found that out of the 50 supported
architectures, ARGS_GROW_DOWNWARD is set on everything except
for gcn, stormy16 and  32-bit parisc. The other two are
little-endian though. STACK_GROWS_DOWNWARD in turn is set on
everything other than parisc (both 32-bit and 64-bit).

      Arnd

