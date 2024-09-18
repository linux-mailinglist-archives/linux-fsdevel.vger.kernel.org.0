Return-Path: <linux-fsdevel+bounces-29628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D132C97BA00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 11:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E551F224A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 09:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D93176259;
	Wed, 18 Sep 2024 09:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="jvKq6LbI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="avT1wrQB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1625335BA
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 09:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726650757; cv=none; b=MFJoo7NmJ2rSCrvjq+j3EZbPXDN9291f/TP0/k2fGISav7ok/wLJYYHGSb2ka/OTWzvF8RyE6CprhHIoxC9GJmFDtWzAkiGhcd+TyuN1I082zbXRrXN6OlKRHsZtCi6F2MqxRpdPshp5PRvkQxtlqlLIa5K/MX02NGOGhhQFbU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726650757; c=relaxed/simple;
	bh=vzo9aXOcYTnpLmcWUmX/C9rQxZ0ikWBP5CsVSVvqOV8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=OXtGhISPmkFqUUAFMpo3F3X5aUEo3WVn5PlD4KYT3VBiPdvrsk4xG3Yjs8Aw67kHDEBRzNIAPZbZzcG5BtbQD3d073j+zhiMUY6jFg6/DbS1V+3HpnFMtEFMTyYbHWo6uDQvIFw4/ygLg91oZuknkmQPc0vGSQ38JpN4FVJmmCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=jvKq6LbI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=avT1wrQB; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E97FA1140189;
	Wed, 18 Sep 2024 05:12:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 18 Sep 2024 05:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1726650754;
	 x=1726737154; bh=OGL2vQGFP/h2t8UXE34Kxxw4BTytgfW3VXSw1q8eZ0g=; b=
	jvKq6LbIv/ZSh+QI2qEpBG9L9tcRirFLE+QfqYLhtWSoPMbl2sTrsGfqoMIUdkCe
	XG00/RoByLoklPJXsMuinVyPBsNKKuRMqReL2TBy1yrDbxYm9OhCDI0E5G1a63Ug
	OocvpootgsNypCnQLrShKpYFLQci1ebpDdLNDGnrkgCzlHcpkTZ+eQQ2Lrjvud9q
	P2I/V2qWUZR3vkXNEEBZHABLFSrQ0T65M7yN3EWhcRpq/SiQE94FGeFnAhRSPDH7
	r7Qgr2iOQ6RPgjVDCrDX7rKgrTegf2CvYjDaN5THuEWCRGHJWks0O5Ux+pgnB9sQ
	FDHOh6VKpBPjamai3XtRIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726650754; x=
	1726737154; bh=OGL2vQGFP/h2t8UXE34Kxxw4BTytgfW3VXSw1q8eZ0g=; b=a
	vT1wrQBGtbpJG+HCMSxsp+xzVdbQ3zsAqqiDKI6AgpWI8oOXEJNqQg180q13oj7v
	YIa5TXVSNYBQAI+F7WoM23hhmPUOX5MVI7mmnTuyhUASxQt+vJpNhzGp13posXyA
	nRfSIyiBI7p55h8shhOTLTf4jhYyMBB0nVnyhCEaZ4gh1FX7qUWW9n2zq9nh8y5o
	NgNGNR6iu1Ot7fH/rAn3Wn20kHEf++OUIaN1TkAkUpObsA2MmkiBT0L8H8M+mvvw
	9s6LFUjAa1+YyLjnyh37rbhDTlNCIyq1liLSqxEZe7ganNk4S0bve4D6mFsgNYCE
	O/FJyNr1PWVhtAQ2j2kng==
X-ME-Sender: <xms:gZnqZotEhj4PmRbQYCcVzmF1WdmM2iOti5mCw0Gct1yXLiZw0dc4uQ>
    <xme:gZnqZlct2kL-U0hRq4auls0bG6p3OvdY9X1S7X4MH1VeR25eNYEobTxIIFil8mM-R
    rCQCCmc6wEQR_QT>
X-ME-Received: <xmr:gZnqZjzQNbHNCmou-ZF7N0_h8mfzrNsiiZ1E8-XaIZT1yLm23jRzAw3_tYMvL7l5YPkIvMC6m0h_tXWwZHcL7vCFUANidB82YWI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekledguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevufgfjghfkfggtgfgsehtqhhmtddtreej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepffeugeeihfffteev
    heevveffjeehveekudegfedtfeegudevjedvhfefvdeitdfgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhht
    sehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohep
    jhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugi
    dqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhs
    vghfsehtohigihgtphgrnhgurgdrtghomhdprhgtphhtthhopehjvghffhhlvgiguheslh
    hinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopehlrghorghrrdhshhgrohes
    ghhmrghilhdrtghomhdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehmvghtrgdrtg
    homhdprhgtphhtthhopehjrghkohgsrdgslhhomhgvrhestggvrhhnrdgthh
X-ME-Proxy: <xmx:gpnqZrP9MhE0NcI0EjcfPZONA392w4fib6KB4dV8QQhSgu91w_HcUQ>
    <xmx:gpnqZo-b7HmxGoX2FZwrITPqu7IRm7J5HjdXx8rZVvcFIBfrGBkr9A>
    <xmx:gpnqZjVSO2goD_PhCYIP48KqtAwlmy78ZJV_F5MJE9Y70cPafQKKZQ>
    <xmx:gpnqZhcwl94k-IV8iUERtfrNikBbyMITPjdlE6q8VMEkY2WiwpJ-MQ>
    <xmx:gpnqZsQ_KX1XBRxWp7zJDgs5X879x7WahHjy1VW_k73T3qoExy4ltgus>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Sep 2024 05:12:33 -0400 (EDT)
Date: Wed, 18 Sep 2024 11:12:32 +0200
From: Bernd Schubert <bernd.schubert@fastmail.fm>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org,
 josef@toxicpanda.com, jefflexu@linux.alibaba.com, laoar.shao@gmail.com,
 kernel-team@meta.com, Jakob Blomer <Jakob.Blomer@cern.ch>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6_1/2=5D_fuse=3A_add_optional?=
 =?US-ASCII?Q?_kernel-enforced_timeout_for_requests?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAJfpegsBG_=7Ns=n45Cwc8082OZ7Kg1WU+xoMPNDyyP+V1ik+Q@mail.gmail.com>
References: <20240830162649.3849586-1-joannelkoong@gmail.com> <20240830162649.3849586-2-joannelkoong@gmail.com> <CAJfpegug0MeX7HYDkAGC6fn9HaMtsWf2h3OyuepVQar7E5y0tw@mail.gmail.com> <CAJnrk1ZSEk+GuC1kvNS_Cu9u7UsoFW+vd2xOsrbL5i_GNAoEkQ@mail.gmail.com> <02b45c36-b64c-4b7c-9148-55cbd06cc07b@fastmail.fm> <CAJnrk1ZSp97F3Y2=C-pLe_=0D+2ja5N3572yiY+4SGd=rz1m=Q@mail.gmail.com> <b05ad1ae-fe54-4c0c-af4e-22a6c6e7d217@fastmail.fm> <CAJfpegsBG_=7Ns=n45Cwc8082OZ7Kg1WU+xoMPNDyyP+V1ik+Q@mail.gmail.com>
Message-ID: <9FA70B40-C556-43D9-9965-1290C929CBFC@fastmail.fm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On September 18, 2024 9:29:44 AM GMT+02:00, Miklos Szeredi <miklos@szeredi=
=2Ehu> wrote:
>On Wed, 18 Sept 2024 at 00:00, Bernd Schubert
><bernd=2Eschubert@fastmail=2Efm> wrote:
>
>> > I like this idea a lot=2E I like that it enforces per-request behavio=
r
>> > and guarantees that any stalled request will abort the connection=2E =
I
>> > think it's fine for the timeout to be an interval/epoch so long as th=
e
>> > documentation explicitly makes that clear=2E I think this would need =
to
>> > be done in the kernel instead of libfuse because if the server is in =
a
>> > deadlock when there are no pending requests in the lists and then the
>> > kernel sends requests to the server, none of the requests will make i=
t
>> > to the list for the timer handler to detect any issues=2E
>> >
>> > Before I make this change for v7, Miklos what are your thoughts on
>> > this direction?
>
>I have no problem with epochs, but there are scalability issue with
>shared lists=2E  So I'm not sure=2E  Maybe the individual timers would be
>the best solution but I don't know the overhead and the scalability of
>that solution either=2E
>
>Thanks,
>Miklos

In principle we could also have lists per device and then a bitmap when th=
e lists are empty=2E But now certainly more complex, especially as a device=
 clone can happen any time=2E


Thanks,
Bernd

