Return-Path: <linux-fsdevel+bounces-10604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B5384CBBA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 14:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A4F1F224DD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 13:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F96177621;
	Wed,  7 Feb 2024 13:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="nxeoGUcL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mvl5jQK1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58795A782
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707313099; cv=none; b=hD9UZ9VABn5QHvGkjAiSowf7LqtsdNrC4+7Ljm0Pi2QSdHr0izXH8RzczLcQrQrOsZz05PyJVsnuCgmqkwneir2tUzJ2QIXQhQSRDt/S+zA8GbcF/s2gaJHgyPCoIjO7jHHvgC+bM2w+5T77CcmZ9/p1so83/LupriwF6+BD/zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707313099; c=relaxed/simple;
	bh=lfSUBukjrQaWmUf/iXkOvCThKRKcFB8eYtz60EO9WJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ba1too646CZRms3UmTLgw5NmGhpRp5LlRl/mWb46VTOnsEQDZb5l6c/z6puvuHbbZSmIZyLdwZEBBUaiIudwmSHctBUTuZCY7aubtXqkF2OfXK9kJGWs9Q8uh+DZgk3Xg+JsQQLxk2A/Sw6rN4W7oKP7RfVEvyZEnGCz9SMwNL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=nxeoGUcL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mvl5jQK1; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 468303200ADD;
	Wed,  7 Feb 2024 08:38:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 07 Feb 2024 08:38:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1707313095;
	 x=1707399495; bh=RuSWFOZg/llIQBIUACjGgaYNybg4gVBaux3JNsp+tzo=; b=
	nxeoGUcLnv+DJF2CsXTTlIlPgY2vBZzXFQr+aW+V9ru/HXy6mzJoeVxRx+dVvMFF
	DwByxJWHdjbceDsd6MkmXWJW1+2TWXI3kec8modl8UVwFu2lW6hfHqtrfxx+WbSC
	KtWeBlsmpGbJ45mGded/2DcB7Fif7M3hWQqtUJ4HObLb8aziGLactfBbi9dCmdDB
	Ib9+zPcOL0IgMGboc1kW3RBURskPELZmeRlPLl7wn+qQwRTRVI2UKoo94sScyY1T
	6KP3d/StYHmOHPXqtbZ5/n4Sn3x58SSl99sk1krLrBORCevmrZqjaCW/T7wTubYD
	kxEw+A6zmfoLEGpFY+ke8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707313095; x=
	1707399495; bh=RuSWFOZg/llIQBIUACjGgaYNybg4gVBaux3JNsp+tzo=; b=m
	vl5jQK1v1ur34Dnr32n7onVVgdDwtLe5V7GtbXXj8PXJ/DCL45gW6yKI4iRdsk5e
	6hrGnWREesbyPa/EAc1QLjIdn1JsWwBcWVpzdgG3prULGXwDhOSvRJ/Rdc8/jahp
	qAbKHCvF0V3y8x/LmMPqt8wKWxY1n5EZBn8MCc6a3uveJIF/fPJ7nEkTtPGfs9+p
	lfGTy1Y7gssbGiUE7Q+MXPzzXvOhdn47F0gcLA/CO/5LBcIjpCcRmKov4ULNE24I
	4iJvdJhE7ifcwGsrOzen4eeiX379QaeEIPkmKDqXNABCWVG6/EFeK/SKZXDYXuNc
	CWGzul8ZvnCGw3Z6WSpRw==
X-ME-Sender: <xms:xYfDZUPu-r8xUUU-VYjTQg5yvooy27TSS6jU_0Oe8lQ7C65fW_e2QA>
    <xme:xYfDZa_AoTf2Q5JgxnNqXyG0pPY0LpgHwlKhFCTNbWZ4fiw2ovQKMYjgyRvjlt6H6
    6Xlw0dPsI_cpfku>
X-ME-Received: <xmr:xYfDZbScsF2HQjrrEkITgtCMgK3u6ne6mBC9vVy3OOTfUAxjuVqDvUNQhnIh1r1BaaUFeN3aZlmxIFq2iWUil8yahaFbawccbSdbF2dtYxBjXbMPK3kk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtddvgdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtje
    ertddtvdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhs
    tghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgf
    dvledtudfgtdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthh
    husggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:xYfDZcvcz2N-_X6qG4b_xZ0DOaaVahplZkFHC_RiWvGVFdRu2WGFBw>
    <xmx:xYfDZccoRxFcz1UzX0-7l9wO0q1aZtfatCKo9y5tGDc-heGoE9flkg>
    <xmx:xYfDZQ3DSfTyYUwL_Ei4OwzCyhNnOS0G9Pl8usn9eFmjV5ApVQ_iHA>
    <xmx:x4fDZb6tgu1L6OM57j6er3lZtujyVaE2jKVGW7K2HRKCA6kyaigcBg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Feb 2024 08:38:13 -0500 (EST)
Message-ID: <b9308f8b-cda3-486f-be23-6e84cc0c8b6d@fastmail.fm>
Date: Wed, 7 Feb 2024 14:38:12 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] fuse: Create helper function if DIO write needs
 exclusive lock
Content-Language: en-US, de-DE, fr
To: Jingbo Xu <jefflexu@linux.alibaba.com>, Bernd Schubert
 <bschubert@ddn.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, dsingh@ddn.com,
 Amir Goldstein <amir73il@gmail.com>
References: <20240131230827.207552-1-bschubert@ddn.com>
 <20240131230827.207552-3-bschubert@ddn.com>
 <2d0d6581-14de-46c4-a664-f6e193ab2518@linux.alibaba.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <2d0d6581-14de-46c4-a664-f6e193ab2518@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/6/24 10:20, Jingbo Xu wrote:
> 
> 
> On 2/1/24 7:08 AM, Bernd Schubert wrote:
>> @@ -1591,10 +1616,10 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>  	else {
>>  		inode_lock_shared(inode);
>>  
>> -		/* A race with truncate might have come up as the decision for
>> -		 * the lock type was done without holding the lock, check again.
>> +		/*
>> +		 * Previous check was without any lock and might have raced.
>>  		 */
>> -		if (fuse_direct_write_extending_i_size(iocb, from)) {
>> +		if (fuse_dio_wr_exclusive_lock(iocb, from)) {
> 			^
> 
> The overall is good.  Maybe fuse_io_past_eof() is better to make it a
> solely cleanup or refactoring.  Actually it's already changed back to
> fuse_io_past_eof() in patch 3/5.

So I'm bit confused what you would like to see improved. Patch 2/5
renames "fuse_direct_write_extending_i_size" to "fuse_io_past_eof" and
also moves it up in the file. (The latter is a preparation for my
direct-write consolidation patches.). It also creates the helper
function fuse_dio_wr_exclusive_lock(). None of that is changed in 3/5,
which just moves the locking/unlocking from fuse_cache_write_iter() into
the functions fuse_dio_lock/fuse_dio_unlock.


Thanks,
Bernd

