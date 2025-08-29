Return-Path: <linux-fsdevel+bounces-59657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0625BB3C061
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 18:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99046584D73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 16:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAC1326D7A;
	Fri, 29 Aug 2025 16:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="WEQTgmGb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jy6lexL3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B024326D6E
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 16:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756483911; cv=none; b=jW83KKt214Yo6E4MAFBDKuFJSt5YOAg5QmTK3JK0js/JYNDGvE0NFC6rtsCEMvDYQIXBxsEePUbHpaca+5isOxcPgJQ0uEjt2W1xWYBLtvQ510+4RmutLdpdpJrb1cIUddwLWz5kjF9bVYjsPkq2b3/EPeQaTeCCpVysC73HKMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756483911; c=relaxed/simple;
	bh=m64EoFdW6HctH4XYEYLvnYPzs+hITkfnbPon2iLqlPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NPFLm6jbUNWD+lcRj/e9ic6fDKZCLoBN4+Q8Qg/TGRZ5aVFlpd2qbasznbCTh43qjmyU1C5r5O0AH/r5GNfa49erkvgwDdLLeddZtBCohR0yGlgV0FUufD52dfpDwHdm4nA9KtFd4EFTyISh6nMnqBX8QtF15m4kKzC1mhiO2KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=WEQTgmGb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jy6lexL3; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 196057A00AF;
	Fri, 29 Aug 2025 12:11:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 29 Aug 2025 12:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1756483906;
	 x=1756570306; bh=u9eKpapxcGROxuqpEOO5YlCpcGvGdDAyxlKAff/7e5I=; b=
	WEQTgmGbxMt5b9katr5TS6z8iws3T94EzXHQhYEolWE5aHapojdF2obrPIh8u9Kq
	xHQjPqfi7x71vbu6c8RwZoFVma7tAr1xykIMWKH/qG8e0soKiGyRd861xACchqjN
	fuetKQCoLhnZCz+UFNxeUyyCYzR6QDQ3UwpB9Ea0WZWJzxdR2UJP/DMORpnRpINK
	tvF/TPDTefQ07m5vwI/0VtiL5cTgeZM/7YgdS4kVaexizV2lc1k7B81Zx95cJbxU
	HGIipRgQaf4hi0y+RZzNjU0ohyzTStR4KB3ePXfQyTGDViEdH0+Pe3vXu5Bf9rwB
	Q2GtKSlUJYwJBwti4B34RA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756483906; x=
	1756570306; bh=u9eKpapxcGROxuqpEOO5YlCpcGvGdDAyxlKAff/7e5I=; b=J
	y6lexL37EoN2HIypgXNyrSWy+NsDXwPqE/kaX/2WbONL998hWFRNf4df4/XhKiV8
	AHHstN9IB8p9udU2gujKUqdFNP2wfNTsaRAtf8T2YqU5+fjHd0sfQ++kDRgA+7OE
	FS/uoh28ZQezhxOux41LwVKZ1gJBVc6FUgWoJvSo2WvWQT7UFEjT42AkdvjWkP9D
	lIK0Lmgtc62sUYiJ7eIAE9xynh6m5JvnT0+o8+uosydtIHd5PiuIRXUsyfMFQmCs
	wH7BPE2HWDXBlaGiGcbWCI6b4yMJXqrfz/UhkjneQjucU/KEdVfhmj9bKAY3MpzT
	4JTKwaLoolLdVnwS7wyTA==
X-ME-Sender: <xms:QtGxaB73NiLzAJ4AsdzDbWa30kxjftwMLWxC--JegpITt6Cauuga7g>
    <xme:QtGxaKa-Jmrg4Ry-2QCfbWDzn-a31UwumWrqSsaxSoVgYg5CZBBzWKM-KMqKPs7pO
    rF9T-2SnHT-IYV_>
X-ME-Received: <xmr:QtGxaO56cTyd49ZxOmq_z_jAZnmbT5pl0TJcEjc0BartJEdE-8Q-Oh3WnO4DUzfnpT2Kolf6H9dHsdCYH2vLHHZ_qMvgyEMQ83FjoIiiJiEjUjZjt-Qb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeegvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepmhhsiigvrhgvughisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhn
    uhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjh
    horghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhhnsehg
    rhhovhgvshdrnhgvth
X-ME-Proxy: <xmx:QtGxaFDoQJ1Sp7UMlEUTSS9ejci7LYkgvhT_kJu8Ennuf6NJJij6WQ>
    <xmx:QtGxaMcjF9Px-ya62f36dtP7mCtPqH6nvkRisJbF3hJDrOkWnT0rAw>
    <xmx:QtGxaMJNrI51Esxfc1Dr8Uv47bkKe0vkm-6Rz6c2UxZGoOeqPBpqXA>
    <xmx:QtGxaP2ogm_XNA8wQjWYYtZjX7-1r7BSEmS-EBnCh5V8rJGY9D8Tkg>
    <xmx:QtGxaKSmgkpgv0ScyjW6yAnWUNuuQTd-fuajyazSJgJPr7p1riSo9jfW>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Aug 2025 12:11:45 -0400 (EDT)
Message-ID: <2b20fd05-f1b2-459a-9d45-c485a56f8228@bsbernd.com>
Date: Fri, 29 Aug 2025 18:11:44 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fuse: allow synchronous FUSE_INIT
To: "Darrick J. Wong" <djwong@kernel.org>,
 Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>,
 John Groves <John@groves.net>
References: <20250827110004.584582-1-mszeredi@redhat.com>
 <20250829154317.GA1587915@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250829154317.GA1587915@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/29/25 17:43, Darrick J. Wong wrote:
> On Wed, Aug 27, 2025 at 12:59:55PM +0200, Miklos Szeredi wrote:
>> FUSE_INIT has always been asynchronous with mount.  That means that the
>> server processed this request after the mount syscall returned.
>>
>> This means that FUSE_INIT can't supply the root inode's ID, hence it
>> currently has a hardcoded value.  There are other limitations such as not
>> being able to perform getxattr during mount, which is needed by selinux.
>>
>> To remove these limitations allow server to process FUSE_INIT while
>> initializing the in-core super block for the fuse filesystem.  This can
>> only be done if the server is prepared to handle this, so add
>> FUSE_DEV_IOC_SYNC_INIT ioctl, which
>>
>>  a) lets the server know whether this feature is supported, returning
>>  ENOTTY othewrwise.
>>
>>  b) lets the kernel know to perform a synchronous initialization
>>
>> The implementation is slightly tricky, since fuse_dev/fuse_conn are set up
>> only during super block creation.  This is solved by setting the private
>> data of the fuse device file to a special value ((struct fuse_dev *) 1) and
>> waiting for this to be turned into a proper fuse_dev before commecing with
>> operations on the device file.
> 
> By the way, how is libfuse supposed to use SYNC_INIT?  I gather libfuse
> will have to start up the background fuse workers threads to listen for
> events /before/ the actual mount() call?


libfuse actually starts worker threads dynamically. Not something that I
like too much, but I also don't want to change it too much. The io-uring
threads are started all at once, when FUSE_INIT is received. 
Regarding the /dev/fuse worker threads, there are also existing races with
actual thread buffer size - I'm going to change it to only allow one
thread until FUSE_INIT is processed.


Thanks,
Bernd

