Return-Path: <linux-fsdevel+bounces-39995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A896A1A9BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 19:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8692E1623BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 18:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557B215B0F2;
	Thu, 23 Jan 2025 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="K3rkr4kV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="df1OfOjZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A6B15574E
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 18:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737657731; cv=none; b=Vu2JbUHJGBEGUqgOnualEdclP5K04/INUuyBmQ9sS36L8EfSc2R9JmEnoI0dn/EW01InUl1uIqLpQMZWicMV+er/4E0kf3xYNbwhlb5EXiagkHVxuLgNFybaTjHO2xfVLvOUz3DIfna9oeKZ5ASXu3tEMBUPF6wdCu+Ld6ixNzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737657731; c=relaxed/simple;
	bh=bTf1xurTTbNXRPdGiNP8OjSjLoVsjqDv8ETb6t4FuGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fE5oRhlkX4GM0V+HWqh+LuOboQ2gE4RbmvMMy/8bZQda7k9UA2wpwIxt7EqkyJRSfd0AMVhYdIWqzcF2YkQXjXn0FtLHpJxcrxlSJ7SZe9fTo8oDWVc/4CVVg20vAOc0RZJ0W/98unQafPy9sUpHcXMxOZvk19d8sAZYHdGouq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=K3rkr4kV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=df1OfOjZ; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8827B254011D;
	Thu, 23 Jan 2025 13:42:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 23 Jan 2025 13:42:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737657728;
	 x=1737744128; bh=CsKzSvvBmvw8AeZ+WrYm9+sct1ouxkP7dtcZG1SniaU=; b=
	K3rkr4kV1iA10l0u7EkPfqUw2HvLMH+dr3S6QYp8HUnVKyYAlRBQY7qP1Xf08Xph
	NjYxY90U6LErzSb1AvLQpXwgzqN9gTxO0930P3POfMebuiGuYS74UionQkTRZ471
	xjo73C2L+KCyWQlgYKyivnVteLjl83/zRMZbpMCWRlAR1kO8VO5pAwZehulezfNi
	FVL31btgiszNSJqZKbWImixkR0t/Fl/xXd/Y6AN+GtQmzUDtbgXnxbztMVeegU/4
	wIWueEG9CCllu6YBO0ERr4sBlo5DOB8mSb2WQE0YqvdQaigu8b8F3m+yuvLfmFDm
	aH+f8wwoGijVfzDRMypqWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737657728; x=
	1737744128; bh=CsKzSvvBmvw8AeZ+WrYm9+sct1ouxkP7dtcZG1SniaU=; b=d
	f1OfOjZOT92U5C0CaXUWwc9dCLR8odIfQsKq+y04GFFxL6SVk1WqRoH83Jv/kvna
	TDCoAgnlCM4Ckeen+4kT3elqlWCqxJLkdEeNC9oMvzZcOwGqRAjqUrezs843l8ed
	KzD57p7LfG4bOSrmjd15YB3Y6pFJN1CHh6IrKtX9yXtpd4aQRXa26igrk07M7AL4
	V9n0rj8YCOabHiqj6707nWzSyWkZmIzjMpE+2rmibz4QZQ62ge3+6O3Fd9udjC1m
	CtFWDZn89IquRaDNlA9xN4MOu/7bm7C6qsT3iJcoTHjyB9JpdjbXtQXJd0WPmOLJ
	skUJWUBaZPhWC1OYc44Kg==
X-ME-Sender: <xms:gI2SZ6j-GLyvl-vMuu-AbCKpn12pxfGraWSwwVWuVMFMokfEVai42Q>
    <xme:gI2SZ7B5RUaiGEwODvSNSy9ih3tbcIoXtKyNyfRj160yfOsbbje9aRp1P5YAZa8-1
    eKN8Is8_kqStl_F>
X-ME-Received: <xmr:gI2SZyFIiRx5woRy_R4_Sy9S9O4UM3hIe56znzFLC8dw3RkAbaauAtu8rQVMYpIAy2HlqZpllCzWBq93eJbCYB-U-Y6E50bwb1S3oJPkDO-vCTgRDbZv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgvdegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddu
    gfdtgfegleefvdehfeeiveejieefveeiteeggffggfeulefgjeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthht
    ohepsghstghhuhgsvghrthesuggunhdrtghomhdprhgtphhtthhopehjohgrnhhnvghlkh
    hoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgvfhhflhgvgihusehlih
    hnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtoheplhgrohgrrhdrshhhrghosehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshgvnhhoiihhrghtshhkhiestghhrhhomhhiuhhmrdhorhhgpdhrtghp
    thhtohepthhfihhgrgestghhrhhomhhiuhhmrdhorhhg
X-ME-Proxy: <xmx:gI2SZzTIkN6g0L5S64IK-8GvQLZRhvkApMxq--sLemvPP_MK7KKCeA>
    <xmx:gI2SZ3y6t7sucUbWAgAUVbH8gm_JyOBKrfH_4UY2mdowA8ZHbnlLew>
    <xmx:gI2SZx5r_PHcICgEhdlQ-9TtxwRXLPxI0WbX28U1LPZpqtyZZSYy4A>
    <xmx:gI2SZ0wh_AY3SqwfBSeqkq9Qcipkq93KvpwvHraTXKi8EMaoXjjuJQ>
    <xmx:gI2SZ8K5Qi9E5OBQ3-SBJmjEBkwUNDq4Cr2WOMapPkzN62G7nCOmzcS9>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jan 2025 13:42:06 -0500 (EST)
Message-ID: <c4cb7ca9-11ba-41a3-bfa7-2a51eaec9c7c@fastmail.fm>
Date: Thu, 23 Jan 2025 19:42:05 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/2] fuse: add default_request_timeout and
 max_request_timeout sysctls
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org,
 jefflexu@linux.alibaba.com, laoar.shao@gmail.com, jlayton@kernel.org,
 senozhatsky@chromium.org, tfiga@chromium.org, bgeffon@google.com,
 etmartin4313@gmail.com, kernel-team@meta.com,
 Josef Bacik <josef@toxicpanda.com>, Luis Henriques <luis@igalia.com>
References: <20250122215528.1270478-1-joannelkoong@gmail.com>
 <20250122215528.1270478-3-joannelkoong@gmail.com> <87ikq5x4ws.fsf@igalia.com>
 <CAJfpegtNrTrGUNrEKrcxEc-ecybetAqQ9fF60bCf7-==9n_1dg@mail.gmail.com>
 <9248bca5-9b16-4b5c-b1b2-b88325429bbe@ddn.com>
 <CAJfpegsP2C-RgGqY9Wd2D_C2vdWGtcN1JOcwdGxYx29DCm=eVA@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegsP2C-RgGqY9Wd2D_C2vdWGtcN1JOcwdGxYx29DCm=eVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/23/25 15:54, Miklos Szeredi wrote:
> On Thu, 23 Jan 2025 at 15:41, Bernd Schubert <bschubert@ddn.com> wrote:
> 
>> I don't think the timeouts do work with io-uring yet, I'm not sure
>> yet if I have time to work on that today or tomorrow (on something
>> else right now, I can try, but no promises).
>>
>> How shall we handle it, if I don't manage in time?
> 
> Okay.  Let's just put the timeout patches on hold until this is resolved.

Sorry, my fault, I had missed that Joanne had already rebased to linux-next
and already handles uring queues.


Thanks,
Bernd

