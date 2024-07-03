Return-Path: <linux-fsdevel+bounces-23047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 807E192655E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 17:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BC912832EA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 15:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A7918131E;
	Wed,  3 Jul 2024 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="LTo4Ovau";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WeeTzrXA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC5418131D
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jul 2024 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720022306; cv=none; b=YmXmQrEvTGGzXyhOlUFumIo1SoJCx2Ta9HpmJlpP5bV4GBn6qXBZnSt7Vyx81Bakof8Li9fExoqDGMb67uN35l+1fkBzvnkL7V9NzanxK0EZBD7KLZ5mu150yet6mbJnbqhEJT0phYcPuZK1kkMXpR91CLyi8speIPDyQSf439U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720022306; c=relaxed/simple;
	bh=bAiyMpGKabi3JNgo3VC6GBBEDuCx7xIR4tqwNWxkb8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nw8ctSYFt4P6JCh/mJJt6zQ9iZ1VWEZDm8f8C3MGGJR05aHvJaotrl1b9wAHgccer5oEeqvIjuGDWPjUjPWT2hTloyROd/AOAdjmNAZ+vuoc5Gt49ZfPKlW0uaDUiH/XwOAFkHbputVscG+2wa1INfUuHeO0Fy6G7b6Aq8J6CUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=LTo4Ovau; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WeeTzrXA; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id E5530138029A;
	Wed,  3 Jul 2024 11:58:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 03 Jul 2024 11:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1720022302;
	 x=1720108702; bh=dfJ7HJk3pNJIvoNsKCHQjOPt6n6Q9xfJVUhCpOXbe6U=; b=
	LTo4OvauL8VFJIoGJvSGsX1dqipqfHPS+gzZNgfr//BfsfYE/FtpYRaJchkqO8pF
	e5V1sjeaZboYEsuTMQjAOA8+aKmJR7R9xhqzBlkcPAPBo0Ak/7GEeB8YR9R7LG2D
	SaS9k1BWxZw3Ct3h9ab0QrnnOHVXVBsQ3nhsd5c355cpu2x6ZJvlMDSqBuEIa1Ie
	Vlj27XCpliZUqf7hVovmC8cH3g/ZykYfAAtXjUIVaVtN6JMZyBkZgzIQfrF16G4v
	TApBbcUaO48qJ3Xjd3utUR3DvQd601oKgqadpLnDBKJmXB9DfqaJrppPQxtFzimF
	pkhl2vYtk+9plhjZalmQXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720022302; x=
	1720108702; bh=dfJ7HJk3pNJIvoNsKCHQjOPt6n6Q9xfJVUhCpOXbe6U=; b=W
	eeTzrXA1vunO7n4YAXA7UWuPzsgCgZIoxq0MgIrRHGexQ9XCkIyBiWsfPU8+77jO
	KRYUd0CnR56pd7gYwoJBtjQG1kksEtyl2mGxE+Px/eJr12a4UeQSy69sVoTY22Kn
	Ign32YnHICr6d9lQYA10oCZpU/wdaavomUHnozUTjsFuZbX/34C6Cdb4CiqNUBfC
	aqbJQpV4eCgz/VVKhvuzC7EnOsC5dgKra/A6jwXqF5sKJohrOPRFixI6YwPDwLAd
	G9Ln2shN7e/pY440BBibAAECgP41Y/uJvhBdGA0SxoaHi+MxxnZzFWNHoc2NuypZ
	lsByfqd7pH5xZYFqF2Yyg==
X-ME-Sender: <xms:HnWFZolnsT3v0moO30SCGFIWWX3XJ5VEovcUcOjzgqmG095T7HCcMw>
    <xme:HnWFZn1H0C8z2ISLxY0IJD1Rk4tlkYp9TF2iXkjpzcUtMArQzKxoT7OpInq3jGex7
    xMyhAoLvgJTtspZ>
X-ME-Received: <xmr:HnWFZmoWhcCLQMfONx47N68BCxheXOgu_csnEmR6BfGgtHySB3OUwOvi20SN5cRNNYMKA6yEfCfG17uCR5_-1MEfLO6-n-BTaf2Qg1iIQ6F-5-EK1Jmi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpedtudeggfejfeektdeghfehgedvtdefjeehheeu
    ueffhfefleefueehteefuddtieenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdr
    shgthhhusggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:HnWFZkkzaWXDOW_e_L3E9QZDZpNuqSrBccjTiRDRATzkkRHGc2hS9w>
    <xmx:HnWFZm0wboOaRdUiBMTOfxZhTF1zuuoy9BSsAbFpgweciCT_zqrqVQ>
    <xmx:HnWFZrsoz6B5xfejXfmVNFOoYO5rhsujBz7AA_DDeXpzuUkvjquy_Q>
    <xmx:HnWFZiXrzb_0g_YzmMZGARQsydghFEH_lhZqqpFQbldXTbNd9yz-nA>
    <xmx:HnWFZpTZ4eqDybN3CW2DF7lorfWtwZeURQNW3YRy2jAdqvt_EoAQaIU3>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jul 2024 11:58:21 -0400 (EDT)
Message-ID: <e6a58319-e6b1-40dc-81b8-11bd3641a9ca@fastmail.fm>
Date: Wed, 3 Jul 2024 17:58:20 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: Allow to align reads/writes
To: Josef Bacik <josef@toxicpanda.com>, Bernd Schubert <bschubert@ddn.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
References: <20240702163108.616342-1-bschubert@ddn.com>
 <20240703151549.GC734942@perftesting>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: fr, en-US
In-Reply-To: <20240703151549.GC734942@perftesting>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/3/24 17:15, Josef Bacik wrote:
> On Tue, Jul 02, 2024 at 06:31:08PM +0200, Bernd Schubert wrote:
>> Read/writes IOs should be page aligned as fuse server
>> might need to copy data to another buffer otherwise in
>> order to fulfill network or device storage requirements.
>>
>> Simple reproducer is with libfuse, example/passthrough*
>> and opening a file with O_DIRECT - without this change
>> writing to that file failed with -EINVAL if the underlying
>> file system was using ext4 (for passthrough_hp the
>> 'passthrough' feature has to be disabled).
>>
>> Given this needs server side changes as new feature flag is
>> introduced.
>>
>> Disadvantage of aligned writes is that server side needs
>> needs another splice syscall (when splice is used) to seek
>> over the unaligned area - i.e. syscall and memory copy overhead.
>>
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>>
>> ---
>> From implementation point of view 'struct fuse_in_arg' /
>> 'struct fuse_arg' gets another parameter 'align_size', which has to
>> be set by fuse_write_args_fill. For all other fuse operations this
>> parameter has to be 0, which is guranteed by the existing
>> initialization via FUSE_ARGS and C99 style
>> initialization { .size = 0, .value = NULL }, i.e. other members are
>> zero.
>> Another choice would have been to extend fuse_write_in to
>> PAGE_SIZE - sizeof(fuse_in_header), but then would be an
>> arch/PAGE_SIZE depending struct size and would also require
>> lots of stack usage.
> 
> Can I see the libfuse side of this?  I'm confused why we need the align_size at
> all?  Is it enough to just say that this connection is aligned, negotiate what
> the alignment is up front, and then avoid sending it along on every write?

Sure, I had forgotten to post it
https://github.com/bsbernd/libfuse/commit/89049d066efade047a72bcd1af8ad68061b11e7c

We could also just act on fc->align_writes / FUSE_ALIGN_WRITES and always use 
sizeof(struct fuse_in_header) + sizeof(struct fuse_write_in) in libfuse and would
avoid to send it inside of fuse_write_in. We still need to add it to struct fuse_in_arg,
unless you want to check the request type within fuse_copy_args().

The part I don't like in general about current fuse header handling (besides alignment)
is that any header size changes will break fuse server and therefore need to be very
carefully handled. See for example libfuse commit 681a0c1178fa.



Thanks,
Bernd

