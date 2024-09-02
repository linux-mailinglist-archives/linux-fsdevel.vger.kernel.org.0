Return-Path: <linux-fsdevel+bounces-28288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF76968E73
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 21:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34A651C22E72
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 19:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BA71AB6F5;
	Mon,  2 Sep 2024 19:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="kYS17uwl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fd0XsXTD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD20F15CD49;
	Mon,  2 Sep 2024 19:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725305052; cv=none; b=i4xaxpwPihLGIaD74nDClBYLjILop9+FyBCTxaCSb+Txn8Lo+93qOoVku6O4f8/Q0s8liWSGPhCCHraObk22kYOLo22tA4oslr2m3GP6eTS0reOq2AgCBxkCiAcAtIxREEyQTZo9AFZXIjVsRgOjEQW/mo2H7hXlqjjNKdou3UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725305052; c=relaxed/simple;
	bh=+6sndHk1cC890cCE8qSqOM/U5/AapJx58aGOL1j9Lzg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pBzdBqMqeGaYtjP+CWwrj6vFEZOeM7qkbh4hp7Ztg0MpvtWDgDLVXCedHF74RvDYS4xAFHN1yp5vKMTWv9x6WVmcA7ixTb6/YBJwZFSZrY7W52+JGiZY1tN3FQeMIpwQoHfoJ2JP7ZnrE/45lM9gxAgA2oSO58PNXi/qnauS9zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=kYS17uwl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fd0XsXTD; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id DB5BF13801F5;
	Mon,  2 Sep 2024 15:24:08 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-04.internal (MEProxy); Mon, 02 Sep 2024 15:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1725305048;
	 x=1725391448; bh=FIkfggRvlXFcRPLeJORBzcKCauI6djscbZezqFrZhqU=; b=
	kYS17uwl3bJgwT+U/IDIoJ/p/MZRGS0OsrSUWfKGwtvrVLghRNf9DjeffPbFOebN
	6ihFg71jKmHvFlHi0Kqe+k0zzgsMy45vT+DsSAQYH7tGX1+QRnsVGDNW+1BClrun
	PwLwfN+jiDxZkeoxWIsEjPmsQm2tDar1K2ELICv3gb4CFBXtkZK8iJdLf5kEYvHO
	/hc3dTiL3K1ftda6NqGelD4rJGkZMeD4zzmqiG1tHJcrzSQ2nsXn6FJCJgjy9hr6
	QOJrbW7BLB8nvXHPyiB8OgpjtUNXEc/+YODvviFAvSprDPIeLC0tPTl89jDdrLEm
	EFhItVWE8gDqGCi0Lck52A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725305048; x=
	1725391448; bh=FIkfggRvlXFcRPLeJORBzcKCauI6djscbZezqFrZhqU=; b=F
	d0XsXTDvdhjAGxaj1FUhEBfryK7ggVPEt6xnvxgCXuzvQIqpzrT/cy0c869nRK60
	pVYx69hAXZ/+2BF+Tf9v3ER2dwIMnyqIsH87E4kbxKs+uO0baP71agiQh06kmU6m
	M+E8Acv9XzwNydgFSZ5aJfN3xOX0RD1o/OppDpysu1IkkPjsXBwA7pJBClTxUyZv
	LXW2XRLg4sm6Be/sj7DoliA5KO7ZZ83+KEXKz1l35LcWIHRv4FqFNX4eWLvveen5
	T4Q7T0UEbzonUk+yjIDsKuurRJmjmjbIbD1mD+WlGRx4tMisTb+HcFqTfp4MC2dh
	WtWWWSQtQadEKKYK6tRNg==
X-ME-Sender: <xms:2BDWZoVL2xtCQ3WLF5Wb6oW397_NETzYexZ0y6dURlDkqL0q1DlDnw>
    <xme:2BDWZsnByh7ChGyPo5yOZxvD4Otc-j9KEPDiG4_nrohAqe8HqAYbFLtPsXmZTKpwV
    PoY_X73MbwE4mJPaKs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehfedgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedv
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepughivghtmhgrrhdrvghgghgvmh
    grnhhnsegrrhhmrdgtohhmpdhrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhgusegrrhhm
    rdgtohhmpdhrtghpthhtoheptgihphhhrghrsegthihphhgrrhdrtghomhdprhgtphhtth
    hopehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtohepsghsvghgrghl
    lhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrg
    gurdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepkhgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhhurghhsehkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2BDWZsZwGzGYyB9WFg6EWx1zQFqXBmVWedNyJlBxDQ6Nq1PS69l2MA>
    <xmx:2BDWZnVUbH-5zipttfFVWPM1sLhvms_RK7Zw7fRZSwoxW4eWNBhxeQ>
    <xmx:2BDWZinYICP3lPnBKewO2apgaKvEL3s3YltmTcgPfrT5YTOAAAbIvg>
    <xmx:2BDWZsd748uiIonRMUQ7kgFvzdf4COBSLkUKxHdnwKMJMuoueecXwQ>
    <xmx:2BDWZkWMfZMs016-pk_blB0KV_aQo0-MIqGaOf71kxSBaIjX-mMu8R7F>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id BED9B2220083; Mon,  2 Sep 2024 15:24:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 02 Sep 2024 19:23:47 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Aleksa Sarai" <cyphar@cyphar.com>
Cc: "Ingo Molnar" <mingo@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>,
 "Juri Lelli" <juri.lelli@redhat.com>,
 "Vincent Guittot" <vincent.guittot@linaro.org>,
 "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Benjamin Segall" <bsegall@google.com>, "Mel Gorman" <mgorman@suse.de>,
 "Valentin Schneider" <vschneid@redhat.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 shuah <shuah@kernel.org>, "Kees Cook" <kees@kernel.org>,
 "Florian Weimer" <fweimer@redhat.com>, "Mark Rutland" <mark.rutland@arm.com>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Message-Id: <0455ebf7-3f84-44c7-84b3-9ed6e218cdc0@app.fastmail.com>
In-Reply-To: 
 <20240902.160305-cuddly.doc.quaint.provider-RsRaXpw78cll@cyphar.com>
References: 
 <20240902-extensible-structs-check_fields-v1-0-545e93ede2f2@cyphar.com>
 <20240902-extensible-structs-check_fields-v1-3-545e93ede2f2@cyphar.com>
 <63193b87-7057-4ad0-aef2-fdb5d15138c3@app.fastmail.com>
 <20240902.160305-cuddly.doc.quaint.provider-RsRaXpw78cll@cyphar.com>
Subject: Re: [PATCH RFC 3/8] openat2: explicitly return -E2BIG for (usize > PAGE_SIZE)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 2, 2024, at 16:08, Aleksa Sarai wrote:
>> >  	if (unlikely(usize < OPEN_HOW_SIZE_VER0))
>> >  		return -EINVAL;
>> > +	if (unlikely(usize > PAGE_SIZE))
>> > +		return -E2BIG;
>> > 
>> 
>> Is PAGE_SIZE significant here? If there is a need to enforce a limit,
>> I would expect this to be the same regardless of kernel configuration,
>> since the structure layout is also independent of the configuration.
>
> PAGE_SIZE is what clone3, perf_event_open, sched_setattr, bpf, etc all
> use. The idea was that PAGE_SIZE is the absolute limit of any reasonable
> extensible structure size because we are never going to have argument
> structures that are larger than a page (I think this was discussed in
> the original copy_struct_from_user() patchset thread in late 2019, but I
> can't find the reference at the moment.)
>
> I simply forgot to add this when I first submitted openat2, the original
> intention was to just match the other syscalls.

Ok, I see. I guess it makes sense to keep this one consistent with the
other ones, but we may want to revisit this in the future and
come up with something that is independent of CONFIG_PAGE_SIZE.

>> Where is the current -EFAULT for users passing more than a page?
>> I only see it for reads beyond the VMA, but not e.g. when checking
>> terabytes of zero pages from an anonymous mapping.
>
> I meant that we in practice return -EFAULT if you pass a really large
> size (because you end up running off the end of mapped memory). There is
> no explicit -EFAULT for large sizes, which is exactly the problem. :P

Got it, thanks.

     Arnd

