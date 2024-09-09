Return-Path: <linux-fsdevel+bounces-28940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D112797190F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 14:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5ADE1C22A88
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 12:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229DC1B6549;
	Mon,  9 Sep 2024 12:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="YvuDxi42";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fimP6L2u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEB51B29A3
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Sep 2024 12:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725884121; cv=none; b=dxUS2CJ2HGLbk1UbxfSGZePdzFlq0nSdp+dBu9I4gLQcmXXLhrjIUkTywxZReHFZwrQ46EbI8xzkJkxSwCVCflWwUEAE7hjYRxb/GYJJm0ajWz6m/j2qq6+4wKUZgq1ezk7FdTY11xGxopcf9Evrt2upGjJI2f/IOUwo6sne2MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725884121; c=relaxed/simple;
	bh=mZYbixztIViVldWjt5LzJvGGvr4hJlGDLFBJWbWSfaQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CWcqfpV2/CYwHyp9B7RuS1Rfo4P1ssQiWr4Bq8Nvd5pqCFZYjlsr5X7FA4sjkIyvWgNLfgUftE1ZM3SYSfEmR7GgH6YjBZQ9DVIl9IVMr2FpFkkU5niWqwUX2g1+BQ2oi4CBYBpHVqhBrBFb7L+hYtMBuUOiOzngB6yIQhtcjuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=YvuDxi42; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fimP6L2u; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 0972313802DC;
	Mon,  9 Sep 2024 08:15:18 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 09 Sep 2024 08:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1725884118;
	 x=1725970518; bh=CgLgudbLDYfmS+qKBAFvUu698HtGa2VzY0t6nzClv+I=; b=
	YvuDxi42ZCCkntXgFXcRWVMjSzZva7+zmGR8GolfAe/sZRzItLW7qKfDIMa0y07Z
	knIt24oWw2p89q1vt/LIGMavSwKEAQkGspQCNkQ9wmtyns4+Ormh0wbNnfigpkpE
	Yi1PZcmSN086ooQE9aPoi7YXiLH4ZhvCYEAyn4nHLiENHoBK0jmhfO2Sl9VsRVQz
	WIxn3WgCCl3khBAs7ehKeuB4B3f/fpc+MQ5PM+5Pa7UEg6j3fvN/384ZLfn3ToRc
	hcHI5EIuoghFouJ9xdHgAV9zBcpl+c//UweY2MyX6b2izfDDYxG95/up5Eqm/sJj
	rOL2s3bkcF5/sWCJNPsc4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725884118; x=
	1725970518; bh=CgLgudbLDYfmS+qKBAFvUu698HtGa2VzY0t6nzClv+I=; b=f
	imP6L2uMw+F+rBzvoPLBANmsy4F4xUq5V1z5KVXxFjNquMbVEQDcDzriw0xagOwg
	AY8Hnq0f1lBA2tDW7k534kyeSGHuDNWKwK5xsa3ljbFAxzr7s6jJ1RHDH7GqbfGI
	3LFyILTuHZDojU22l867nka8uRNa79WDUWq9rRQQmw9M1hcAGiz6ZYjnVTLKD3sf
	oLJdaAzRjAmwibgWpfE2NkNxD+s/E68QAYqIR1tyj9RkfScCdOjmHSD3s1Lp0w5+
	lCdKUJOCVgG8WUaCX7BqylADzcu36krHHzEBT6RBiap/y3sSeQwZOEvsyzZt/VlN
	bYjeTupAlDmzp/qvnwybQ==
X-ME-Sender: <xms:1ebeZn9auBC00cm6x1TH4FYAUudcO9YOTdRDJkfdD1ydZhtvd1Rb4A>
    <xme:1ebeZju-1pYSQGQHig9MZyb60bq9YaGRDS_XiUxhrQUFG2tyf6BVw9BWZP_fttgkj
    1nnIAkvsSnzOPeHEGI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeijedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddu
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthihphhgrrhestgihphhhrghrrd
    gtohhmpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegsrhgruhhnvg
    hrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrphhptheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtohepth
    hglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepthhorhhvrghlughssehl
    ihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehjrggtkhesshhush
    gvrdgtii
X-ME-Proxy: <xmx:1ebeZlBZHKgBTHm4vMQaTvmfelcISBKGO0CaHgv8t2grFO6wcsuRMg>
    <xmx:1ebeZjdT8wbuJxYn6FQrqC8_oeH-L0ol7dEDYWOGNx20lPVnS6frEA>
    <xmx:1ebeZsOcVTcfTbHDFd9OnJ5pmEJsTlGINPnWIv_jxlEiAU7JwOVLsQ>
    <xmx:1ebeZlmN9Zi7tO73KmR4Nv61pGOApE_SdCfzwgXJFfYQY16Rh-kFuA>
    <xmx:1ubeZtHluHDz-q376fTY_96wJMxrM1BhT0F-qaVrSDYb0KqCvWilaXiF>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 891F8222006F; Mon,  9 Sep 2024 08:15:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 09 Sep 2024 12:14:57 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christian Brauner" <brauner@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Jan Kara" <jack@suse.cz>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Amir Goldstein" <amir73il@gmail.com>, "Aleksa Sarai" <cyphar@cyphar.com>,
 "Mike Rapoport" <rppt@kernel.org>, "Vlastimil Babka" <vbabka@suse.cz>,
 "Matthew Wilcox" <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Message-Id: <d3b12900-f936-4c94-881d-8679bb8c878e@app.fastmail.com>
In-Reply-To: <20240909-zutrifft-seetang-ad1079d96d70@brauner>
References: <4psosyj7qxdadmcrt7dpnk4xi2uj2ndhciimqnhzamwwijyxpi@feuo6jqg5y7u>
 <20240909-zutrifft-seetang-ad1079d96d70@brauner>
Subject: Re: copying from/to user question
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 9, 2024, at 09:18, Christian Brauner wrote:
> On Mon, Sep 09, 2024 at 10:50:10AM GMT, Christian Brauner wrote:
>> 
>> This is another round of Christian's asking sus questions about kernel
>> apis. I asked them a few people and generally the answers I got was
>> "Good question, I don't know." or the reasoning varied a lot. So I take
>> it I'm not the only one with that question.
>> 
>> I was looking at a potential epoll() bug and it got me thinking about
>> dos & don'ts for put_user()/copy_from_user() and related helpers as
>> epoll does acquire the epoll mutex and then goes on to loop over a list
>> of ready items and calls __put_user() for each item. Granted, it only
>> puts a __u64 and an integer but still that seems adventurous to me and I
>> wondered why.
>> 
>> Generally, new vfs apis always try hard to call helpers that copy to or
>> from userspace without any locks held as my understanding has been that
>> this is best practice as to avoid risking taking page faults while
>> holding a mutex or semaphore even though that's supposedly safe.
>> 
>> Is this understanding correct? And aside from best practice is it in
>> principle safe to copy to or from userspace with sleeping locks held?

I would be very suspicious if it's an actual __put_user() rather
than the normal put_user() since at least on x86 that skips the
__might_fault() instrumentation.

With the normal put_user() at least I would expect the
might_lock_read(&current->mm->mmap_lock) instrumentation
in __might_fault() to cause a lockdep splat if you are holding
a mutex that is also required during a page fault, which
in turn would deadlock if your __user pointer is paged out.

I have not seen that particular lockdep output, but I imagine
that is why VFS code tends to avoids the put_user() inside
of a mutex, while code that is nowhere near paging gets away
with it.

    Arnd

