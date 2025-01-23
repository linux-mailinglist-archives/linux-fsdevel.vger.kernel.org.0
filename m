Return-Path: <linux-fsdevel+bounces-39983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 924DCA1A8D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 18:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072A418828F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 17:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771F2147C91;
	Thu, 23 Jan 2025 17:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="pZzyMIY8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qWL4JFAd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3CE13AA53
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737652747; cv=none; b=SXIA17Z5ZjUklj8ObJYKrAr/zMQXVb6yzJ8Hb/KC5doRG9RfjXQbESfsCu8xgASwCnIhplr8fkOSia99rGscONEQu4LdVln8PUfJLQvqpck5eEBkfr1C7xHMHpwcPM4JcSVOeUwjEPk0XuxwHkCQSK6YKRisvcuoy0vJwa2qIeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737652747; c=relaxed/simple;
	bh=6d8u7z5x4PMq6FiV0hgDJnhjhZOVmpfDRTTn0wh2h2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cA8J07GGBXYNaLPhuFXWTroDx63mEG0j7DeGNOoDtoU64bN+ssE3GFM+oViRNz/vUtiRfapvJQNkoxUIK4B0TnMSKy48u5sfe29i5FWPrHAdCh6q+m82TNxWVFGWg9zzAU0Nc5xclrQ32Leu/eE+EzxbGACkil6/SaCYiVsEp28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=pZzyMIY8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qWL4JFAd; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 62A7B1140120;
	Thu, 23 Jan 2025 12:19:04 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 23 Jan 2025 12:19:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737652744;
	 x=1737739144; bh=B20RKC0pmrDk0psag9FVuqC7Q0ObAvV5j/H/1/ay+Rc=; b=
	pZzyMIY8wTFRWVLL02eO3t/ivNMLphpUSA4uZiEc21yTmZoicYwGOjmrFsApX4qw
	VZNYlZKWXJLASTDwzxrMhYGr0VJbmD6opn4MIerJLdyh4hjCMhfvaVOevHV04qYT
	rWIWFAa42sCsz0rx2thZ7nCTKXAdA679A2LQrSJYgdmkUJGJ0WkylWH6UuC9K02i
	Q/13Avo0Ny/pnPMKxFgqgfv65rBsi5A6PEc4iigK8hzr4tjW+fFBLVtDN/DYpMgE
	nzeX6+HhbdGx3R/MZB4ZfApXGSEJVzIGnq7JKl5lYifFsdvRAxGH1moi9VGqy4Jx
	ytsNQ7sHD8izEB4m6u3FFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737652744; x=
	1737739144; bh=B20RKC0pmrDk0psag9FVuqC7Q0ObAvV5j/H/1/ay+Rc=; b=q
	WL4JFAdT708CUaKJBKWf37qfo4RAStgW/L9fL3vAxix4OMLfu7OxScPfye/xoTfr
	aOyvWsZ8LNpktpiTZEOr7YCMRqDaJooPnBg2BoQXJfwC6l0KmhNj+GUAPXy4jGoQ
	CJgj1RocO+pXiVuWBz6ajPKUDKaSP1WBWQ3AVhqMJkg5FN1EuzeSdGJQkk+2hW5d
	mKbp/8DoJ+Z7NQ5bqu8cCyej1TyD1oMKGDE/+diqG9ZsFU2tLAYSbaj4TntMoTIE
	+J13IxsvC+mucgt9F1vNF1CPgpLr0q8RBQZH3otUAJ2BD5/anEK4sG9bN4eY1dbO
	YEU5Dng5DivX5JNfRSmUw==
X-ME-Sender: <xms:BnqSZ7uPKVD7MN5q5PHjcfArRXE-rYPb_ga8XxNHOMEzjGQ_LgJI5w>
    <xme:BnqSZ8dQLms4IxPgXWAsRD2PENHUX6dwHjJdC7fx5XH4VxHQUcrbzLLECHCH2Fbak
    -ZpTIURH8LkdEMS>
X-ME-Received: <xmr:BnqSZ-yGH0A78ndpE5TwT2YtO4bSJhPJsyyh2Rc4Uv1mIXtrOc3xQpxKzokoNj10QdEGtnzyQy1EkKzd3W2C1iupSXotdurP9OQFw4igaXleS7u__W5P>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgvddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddu
    gfdtgfegleefvdehfeeiveejieefveeiteeggffggfeulefgjeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdp
    rhgtphhtthhopegsshgthhhusggvrhhtseguughnrdgtohhmpdhrtghpthhtohepmhhikh
    hlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgvfhhflhgvgihusehlih
    hnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtoheplhgrohgrrhdrshhhrghosehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshgvnhhoiihhrghtshhkhiestghhrhhomhhiuhhmrdhorhhgpdhrtghp
    thhtohepthhfihhgrgestghhrhhomhhiuhhmrdhorhhg
X-ME-Proxy: <xmx:BnqSZ6PmF--UPmAofcY-i2IfKjpIT2ekZtTTUyn9txSxPfp3bzC8Zw>
    <xmx:BnqSZ79p63ox2v7nXSYtYlht3QERQz5lLeyADF8mcuGnhkzrnXHwAA>
    <xmx:BnqSZ6U8OHbFPEmtDwNTU1Dyx6j23XWrTBQxdeOtZ_4KiAM6FWkWZg>
    <xmx:BnqSZ8ehJ03PEADe6Z4FlMN7uAErIFbK8jqnsnCIo-c-OztGLgmrZQ>
    <xmx:CHqSZ_U8fOAPHIls_-fXVOMHFR8RR8332ovOQrYzDKAjzXjZRcuRKNES>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jan 2025 12:19:00 -0500 (EST)
Message-ID: <4f642283-d529-4e5f-b0ba-190aa9bf888c@fastmail.fm>
Date: Thu, 23 Jan 2025 18:19:00 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/2] fuse: add default_request_timeout and
 max_request_timeout sysctls
To: Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 jefflexu@linux.alibaba.com, laoar.shao@gmail.com, jlayton@kernel.org,
 senozhatsky@chromium.org, tfiga@chromium.org, bgeffon@google.com,
 etmartin4313@gmail.com, kernel-team@meta.com,
 Josef Bacik <josef@toxicpanda.com>, Luis Henriques <luis@igalia.com>
References: <20250122215528.1270478-1-joannelkoong@gmail.com>
 <20250122215528.1270478-3-joannelkoong@gmail.com> <87ikq5x4ws.fsf@igalia.com>
 <CAJfpegtNrTrGUNrEKrcxEc-ecybetAqQ9fF60bCf7-==9n_1dg@mail.gmail.com>
 <9248bca5-9b16-4b5c-b1b2-b88325429bbe@ddn.com>
 <CAJnrk1bbvfxhYmtxYr58eSQpxR-fsQ0O8BBohskKwCiZSN4XWg@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1bbvfxhYmtxYr58eSQpxR-fsQ0O8BBohskKwCiZSN4XWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Joanne,

>>> Thanks, applied and pushed with some cleanups including Luis's clamp idea.
>>
>> Hi Miklos,
>>
>> I don't think the timeouts do work with io-uring yet, I'm not sure
>> yet if I have time to work on that today or tomorrow (on something
>> else right now, I can try, but no promises).
> 
> Hi Bernd,
> 
> What are your thoughts on what is missing on the io-uring side for
> timeouts? If a request times out, it will abort the connection and
> AFAICT, the abort logic should already be fine for io-uring, as users
> can currently abort the connection through the sysfs interface and
> there's no internal difference in aborting through sysfs vs timeouts.
> 

in fuse_check_timeout() it iterates over each fud and then fpq.
In dev_uring.c fpq is is per queue but unrelated to fud. In current
fuse-io-uring fud is not cloned anymore - using fud won't work.
And Requests are also not queued at all on the other list 
fuse_check_timeout() is currently checking.

Also, with a ring per core, maybe better to use
a per queue check that is core bound? I.e. zero locking overhead?
And I think we can also avoid iterating over hash lists (queue->fpq), 
but can use the 'ent_in_userspace' list.

We need to iterate over these other entry queues anyway:

ent_w_req_queue
fuse_req_bg_queue
ent_commit_queue


And we also need to iterate over

fuse_req_queue
fuse_req_bg_queue



Thanks,
Bernd



