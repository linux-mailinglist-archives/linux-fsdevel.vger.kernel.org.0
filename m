Return-Path: <linux-fsdevel+bounces-30780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB9D98E3EF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 22:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F6DF1F2816A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 20:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51006216A30;
	Wed,  2 Oct 2024 20:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="sSRNorAg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cbWoRtVh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73AA2141C5;
	Wed,  2 Oct 2024 20:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727899713; cv=none; b=LavmT8UK+LVp7N7oYEirLnDLH21g6PSePjbOseSC/2Da61Q4aQRJQZeiRlNnFWTs1KBhNfekh7mEc8apa0yhLZLL1hWcTY3GWQZ6T0vD/042C5+MvlYKNBcRgCAZLwxVkjNUSTnWD+BYTcxQW4eHTHCeuy0iFUlYKV/AGPEh3Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727899713; c=relaxed/simple;
	bh=jp7AeLVt3aR1BweOkGmxwMvt46RFKGHXRusdatLgbdM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TA3PJxpckzB+We8XcSO+C+2MOGL+Sc5VKx3qlZa+pk56Y2JMuUvtjMapMOFVlO72skaxGfvxmSLzxwD03GTOO/IkEqCDQmNla3HaH6/B0yXwi320WHsEGT3sRMRyHD0lL4RquaxEAjtfddJVhrEVO+z5gd8jF0COvQQB4iOxeIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=sSRNorAg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cbWoRtVh; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AE3D811401C3;
	Wed,  2 Oct 2024 16:08:29 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 02 Oct 2024 16:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1727899709;
	 x=1727986109; bh=9+1NjGZK/IAxJh84gykukyntGbIk5j2hDFy71XnCnxY=; b=
	sSRNorAgb/W+FK0fCQ+OWxB9cw9k9pA1ybI1DiKPSyt7RTL72Mlm5yr3XzrpeU4I
	fm9UDCi+gFC/W3hhq1VTPVUSV0wtg/0o0Ow+ZPMHI6OVKsY0dVtDiy/sVA1ZWqkN
	Css1VTKhC/d9/w2yDPBuo/jswLQ1RC0zm2jDfbZznuYcaVtfBXfwJycb5fzu17bO
	STO+c0yzeExSZxLY0THavRXpsgL6E2KjNZeJ+CfQ9ObvrodRy1tmuetHwo2jPdHv
	dKxte9ujJ6qyMD70MPFwY+ayY01lVmLmGhCZl+Y0jBfw5LznncIzr/8UsMgdSYR4
	jJ7+m2knbKyPl5OnxX2ukg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727899709; x=
	1727986109; bh=9+1NjGZK/IAxJh84gykukyntGbIk5j2hDFy71XnCnxY=; b=c
	bWoRtVhBDPbofaQ6zv8CMWju/vhvMAP5cTM+2FKB1Vyj/d8bd3XZmMsQZm1Io3jt
	yBeRrzeYaPUfoqfYd6sMrRmgvIHSYYdIXj0ew740XQeD7YOwHpzlERLFnn2QShj5
	62ynAum0wsPyKMMERb2fbJ+ysFexXnXXtZW11oaXNtymAXztmY0Erca7q/Hh7o13
	YnmWaV/i+xJBixoPskMPRqenIxWRiCmbkvS2qiDaCieVtlI/6boPTxe9z5YJ1T9J
	jSl7VhpYMJ41w4PVEDurQFz6e4QfEKgOV2+R8nV+Selj0RUaMRw3KdmsBUtupZMn
	UHG5BhW51jPPQoCpu6KOQ==
X-ME-Sender: <xms:PKj9ZqP9O3SLRMYKzFWQunwnPzKszpvr808m8k3cRO9E5Jg5n9Husw>
    <xme:PKj9Zo-Mpdft6LBygl_Tla_BR8JdTSXZBJr0DwJf6ocr6HhO-pfjBp3hU9kk8ymEt
    w_RqcwQDoPpfYcuofA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    hedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhihsehgrghrhihguhhord
    hnvghtpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghp
    thhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprgdrhh
    hinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgt
    phhtthhopegsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhope
    gsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomh
X-ME-Proxy: <xmx:PKj9ZhSr-Rqf25noQfFsnP703k5V-HHHP1tHnXcHE8v2UlFzHVLsmg>
    <xmx:PKj9Zqs7VR9vG_fis2SoDyWBpG3IEZo0YLzgFCAPbnukGTzD5l0TXg>
    <xmx:PKj9ZifOzXL4Arx6Ic_oUYt11DwRXAYkR_zXnnqIGtXeZx10hrsVdg>
    <xmx:PKj9Zu1ssidTAthG5CY5dquuJTPUvSTcaD3NN3B5QCch-X8srEdj1g>
    <xmx:Paj9Zt0JHmZ-Oni3rHBuCrJ0H_cHiI5CmxMDB28mDQvE3rAtOcBuIpf7>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BC20A2220071; Wed,  2 Oct 2024 16:08:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 02 Oct 2024 20:08:02 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <bdb276f3-154c-4e1a-95ef-15f9c2745da3@app.fastmail.com>
In-Reply-To: <2024100223-unwitting-girdle-92a5@gregkh>
References: <20241001-b4-miscdevice-v2-0-330d760041fa@google.com>
 <20241001-b4-miscdevice-v2-2-330d760041fa@google.com>
 <af1bf81f-ae37-48b9-87c0-acf39cf7eca7@app.fastmail.com>
 <20241002-rabiat-ehren-8c3d1f5a133d@brauner>
 <CAH5fLgjdpF7F03ORSKkb+r3+nGfrnA+q1GKw=KHCHASrkz1NPw@mail.gmail.com>
 <20241002-inbegriff-getadelt-9275ce925594@brauner>
 <10dca723-73e2-4757-8e94-22407f069a75@app.fastmail.com>
 <2024100223-unwitting-girdle-92a5@gregkh>
Subject: Re: [PATCH v2 2/2] rust: miscdevice: add base miscdevice abstraction
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 2, 2024, at 16:04, Greg Kroah-Hartman wrote:
> On Wed, Oct 02, 2024 at 03:45:08PM +0000, Arnd Bergmann wrote:
>> On Wed, Oct 2, 2024, at 14:23, Christian Brauner wrote:
>> 
>> Here, the 64-bit 'old' has the same size as the 32-bit 'new',
>> so if we try to handle them in a shared native/compat ioctl
>> function, this needs an extra in_conmpat_syscall() check that
>> adds complexity and is easy to forget.
>
> Agreed, "extending" ioctls is considered a bad thing and it's just
> easier to create a new one.  Or use some flags and reserved fields, if
> you remember to add them in the beginning...
>
> Anyway, this is all great, but for now, I'll take this series in my tree
> and we can add onto it from there.  I'll dig up some sample code that
> uses this too, so that we make sure it works properly.  Give me a few
> days to catch up before it lands in my trees...

Sounds good to me, it's clear we don't get a quick solution and
there is nothing stopping us from revisiting this after we have a
couple of drivers using ioctl.

      Arnd

