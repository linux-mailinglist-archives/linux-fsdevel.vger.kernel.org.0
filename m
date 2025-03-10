Return-Path: <linux-fsdevel+bounces-43670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 170E1A5A471
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 21:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE5A53AC990
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 20:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE74D1C8FD7;
	Mon, 10 Mar 2025 20:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="hiO6ZetK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZddtfY0f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C80F1CEADB;
	Mon, 10 Mar 2025 20:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637482; cv=none; b=hgayji8dYL7dvvjM5MQ0V9iRuD82NAy+Bdx/PSgGZLc78ZCDmEkBgqX91smj+AJ2Ln762n5gPKFGu5HWkTJLn3Yu9JDqmVVHZsTSWO10pUWP1u6LHPgTU5hNCwy3L2WtoUBXa1Tsu9nhjlCzDZJ3X9ttdq/nIN82xFBXW4r57uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637482; c=relaxed/simple;
	bh=NTmmEk6Y/0bEQNAiPtlqnmpvVmyBIl52/5IQxvWQLEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M91EOgJPuL7KP+ElR3kfl0Y/eQG3ASkpsPQRBEZrd6XJemZCc5O6b2EBP4/S2pf0Obmpt5lMtU7L9bT2KYeo/owQCjgpAbU+I+Bq9JUQdkjucBT3jaIGXxqcruOJZTVxe1aMCarICkyc73WX7pdPLuE/sCJRoLomWD3vDTViRVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=hiO6ZetK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZddtfY0f; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 19C471382CF1;
	Mon, 10 Mar 2025 16:11:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 10 Mar 2025 16:11:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741637479;
	 x=1741723879; bh=dCX5pMMbMGFfjWv/fglntdoyDzZ8q91V84L27+XBwpE=; b=
	hiO6ZetKav547Lt+ZrrSdskO7FE7UOfjG+wyue6wNBS/tTlJLpuyz8lrLwcz86BT
	9oOEx3cLPpfNvmYmV7JvRjGc6CMOi9ZElB/ZjbziHZP2xzg7jaPfuwrC9y+URImL
	m1ktBvqpBj2bkqQ1Vk7v0ttAQuG4X0omvh4B+9hi/f1UMO4cgMQ5xTx1t3Zcyps/
	tzofuDV7irzhGB7+syccomlpMdYxWEe026LCYGIrzrLSQ4Irsy0JFKLFYfUsKL6G
	+Yj17hiTC9GI73z3B4t/mUdT7aMhLDouoqKiMe66mxt+VkPFhubGZ0VfGydlwBlv
	PGz58RkaYhDpTVd9QGsXrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741637479; x=
	1741723879; bh=dCX5pMMbMGFfjWv/fglntdoyDzZ8q91V84L27+XBwpE=; b=Z
	ddtfY0f34QxCq6wcEKGa4VQOkds+kpIhDFkH3/q6GzYC/U6+84MASYbAZQOocrkB
	jIAGF7xP2Kg6BirpfH04NuMtCk84V+Nm8oQx/B64ZD0fkWY/Ug6ptr2+gyWwMiX+
	92dBW0Z39d2fHDQYyPOyhXOUDoqa8r/JGBKVR9Tsh0qBQIwSlmc5H8yTOCX23ufL
	5PwqeEm9jI+a00Rk33swa2wW0Zul2ya1hZ+wWUAlofwApUBLoX6DiMxygiJFOT8d
	apDjOoIZCuYFl1emDG3K+LJ24llCogMRG/w7Sdfsirs5FaTnomTgu5SYAQGs8FaJ
	9zTeDq94VZvK2Hjq+Hi5Q==
X-ME-Sender: <xms:ZkfPZ03YOAnqfK7PWJyHazXjkyhldlQMWQB25nFZ9U3Y3XYqcRDR_Q>
    <xme:ZkfPZ_Fie3RB2wUH7sXe1dmBROWXGmR71-PAWWQ2pHYPdVypp6yLlNSrr8Tg2e482
    eDxt05W1lBt2PvI>
X-ME-Received: <xmr:ZkfPZ87--Z5YbLFQFi7VxWqJQMaUAvoUWYb1yIbOcfcrxbZ6gX5OJwls3lr71MDPWPUsQ8UHdOATE7ltnofH8xQEX69DUb6_RcozxGCEhTDbkn8x_Gb->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddtvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvg
    hrnhgurdgtohhmqeenucggtffrrghtthgvrhhnpeeugfevvdeggeeutdelgffgiefgffej
    heffkedtieduffehledvfeevgeejhedtjeenucffohhmrghinhepghhithhhuhgsrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggv
    rhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphht
    thhopehluhhishesihhgrghlihgrrdgtohhmpdhrtghpthhtohepsghstghhuhgsvghrth
    esuggunhdrtghomhdprhgtphhtthhopegurghvihgusehfrhhomhhorhgsihhtrdgtohhm
    pdhrtghpthhtohepmhhhrghrvhgvhiesjhhumhhpthhrrgguihhnghdrtghomhdprhgtph
    htthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ZkfPZ939KRpJniMCDKAIQL1oZwx5fLzCnj1b9kMS53RWOTmFoOTBmQ>
    <xmx:ZkfPZ3Fp9cfth7i76Qm5PQfvd9lzD0GnsL6YF-lRimdhZsK2nB7Bow>
    <xmx:ZkfPZ28HTFMsAXZ1tAmP2ZdMbzTFpoIosfEANAFa_JXlDrf4GfRysg>
    <xmx:ZkfPZ8l1_lTgxWC8ga-iWdekOhYM6xy3ll0xajymSoc9dIKDC6jfSw>
    <xmx:Z0fPZ22Lt7HCiYTtGAFV42gRfmpEcbXTKuWPeTHnz58gki7DG59Pty1J>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 16:11:17 -0400 (EDT)
Message-ID: <0bd342bf-df71-4026-8d26-2c990e99b40d@bsbernd.com>
Date: Mon, 10 Mar 2025 21:11:14 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] fuse: add more control over cache invalidation
 behaviour
To: Miklos Szeredi <miklos@szeredi.hu>, Luis Henriques <luis@igalia.com>
Cc: Bernd Schubert <bschubert@ddn.com>, Dave Chinner <david@fromorbit.com>,
 Matt Harvey <mharvey@jumptrading.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250226091451.11899-1-luis@igalia.com>
 <87msdwrh72.fsf@igalia.com>
 <CAJfpegvcEgJtmRkvHm+WuPQgdyeCQZggyExayc5J9bdxWwOm4w@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegvcEgJtmRkvHm+WuPQgdyeCQZggyExayc5J9bdxWwOm4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/10/25 17:42, Miklos Szeredi wrote:
> On Fri, 7 Mar 2025 at 16:31, Luis Henriques <luis@igalia.com> wrote:
> 
>> Any further feedback on this patch, or is it already OK for being merged?
> 
> The patch looks okay.  I have ideas about improving the name, but that can wait.
> 
> What I think is still needed is an actual use case with performance numbers.
> 
>> And what about the extra call to shrink_dcache_sb(), do you think that
>> would that be acceptable?  Maybe that could be conditional, by for example
>> setting a flag.
> 
> My wish would be a more generic "garbage collection" mechanism that
> would collect stale cache entries and get rid of them in the
> background.  Doing that synchronously doesn't really make sense, IMO.
> 
> But that can be done independently of this patch, obviously.

Can't that be done in fuse-server? Maybe we should improve
notifications to allow a batch of invalidations?

I'm a bit thinking about
https://github.com/libfuse/libfuse/issues/1131

I.e. userspace got out of FDs and my guess is it happens
because of dentry/inode cache in the kernel. Here userspace
could basically need to create its own LRU and then send
invalidations. It also could be done in kernel,
but kernel does not know amount of max open userspace FDs.
We could add it into init-reply, but wouldn't be better
to keep what we can in userspace?


Thanks,
Bernd

