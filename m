Return-Path: <linux-fsdevel+bounces-68401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F24F9C5A504
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 23:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C03D134BAAE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B35632573A;
	Thu, 13 Nov 2025 22:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="vuBHp57G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HlzJAe6V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C80C2417F2
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 22:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763072844; cv=none; b=N7cQj2dELN3OeHtDyW5DM39YsOb/icTKEs1NyC18TFN9xypfZnKQaAxzTVhyNJ4T+KJGBR8VAm6rPgYSjEG8g1db4GYLy9vNNQIa9MjlAb588RdFg932MAGN1P5icHeN3RQsHlpeUpS4TsJ8215HTTFTezWLDYBUI2OSmX7Oh2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763072844; c=relaxed/simple;
	bh=vmHsU37ovUzGfmJhQAhQbQoyPFLQoeHRxxJMSgNPBXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BdyCkGDqw/VRE6GxpYICIM9bds0RUvRULxAJ4upcZ7a+RfTHaLPENAePvRafSVBUkWzScYGGuRci5FVTI1v/AlOImj3HM3u8MuwSpnOXRg5IiYOKS/1j3I10eS4OEHSdN3wRCmICnJaLPwmWTqn6XCco+XQqFtt6e1/505kP1KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=vuBHp57G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HlzJAe6V; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id 143761380160;
	Thu, 13 Nov 2025 17:27:20 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 13 Nov 2025 17:27:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1763072840;
	 x=1763080040; bh=6Vos9Y9wNkSZSASDZyZ/X++Mf4Yu5xKq1/JBt/9En2U=; b=
	vuBHp57GzzuBWIRfq+LsBbpFTHuyWghB95I3RDWY+7g22mPR2oXz8QWfkqhNS/ap
	xRlK2ICGshCA4A88w65+I15KEuVz5+Tel+QN8s5380Cu/pQ91hEoOT543CyyrnOz
	WdHJDPjZvEHwGas55twUALDH0nZAMnn7u6tGtFX4ZiqZitqLNY78tSGcsEV8qkFS
	XE2etcLQBHWs7E8ocC+/dVV9XGIenfAfm83IiFGX+nfCi4ftvrL2LJ65oseVt64V
	pOK/wh+/HfMyzIWlp0o0KntzXKHaD0bacmwKXA2cLlLCRWmTQmMmN+vXfy7L/B4L
	EIhqUUk+/ksb46+7dmhZxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763072840; x=
	1763080040; bh=6Vos9Y9wNkSZSASDZyZ/X++Mf4Yu5xKq1/JBt/9En2U=; b=H
	lzJAe6VRAOg6Kq/TbFJkzWyKV97L6r81eJNdAmdv2nLozBSY72LLSpwF1NnuR9Hu
	s9SF3b9MVUaCLF0EBSxPJlLryROLogdaaBOME4nnwWG2VWYL4LTtvm/10+QBQVJG
	zUsTxMRCDLwV7kPrRIVBNSISsRnUN/InFOfGE1cQmNX/mMvj4njdHqqi2LwgBCgp
	s+E6y8GcXMbwmPP7oRj5wIURMxT7s1UDXj3ItjNOMMfKso4H5bSknk6GaSuwE3ng
	B3O6reLRFSKx6dA/mNg2uvhAb9BUP/KS5VDDr6TDOysWC+aATOPSH+PA5GnGwNBs
	MQW2kfSMn5kt0IK7Zgl+A==
X-ME-Sender: <xms:R1sWaV_jiIr4l2pn8hEDUgwFLr_n5_3kk0kAntLUl6L8559xmr1vmg>
    <xme:R1sWaQkQURFp-8KHoIxlUdA-2fXHgUgfq5LBSU9POsEp5TQV80yWgZEYmdWTf5l-o
    hrZ6xnVqKesRmnuQ6Qv2Dw8iGlI4wz0qtWKf48jVzvB4UwkO1Zx>
X-ME-Received: <xmr:R1sWabV8Sm1no8_2aK5G7v6ohw5I6drDM48A3t6_6cqUBwCygaKoFqMnUid6MCg-N73nLkH7grLkY_oqzsMhLHY3u7pMr3e8mq60O5QkTHeV0QCtJd1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdekudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucfrhhhishhhihhnghdqkffkrfgprhhtucdliedtjedmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtf
    frrghtthgvrhhnpeejgfeljeeuffehhfeukedvudfhteethedtheefjefhveduteehhfdt
    tedvkeekveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdr
    tghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopegsshgthhhusggvrhht
    seguughnrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehhohifvgihgihusehtvghntggvnhhtrdgt
    ohhmpdhrtghpthhtohepiihhrghnghhjihgrtghhvghnrdhjrgihtggvvgessgihthgvug
    grnhgtvgdrtghomh
X-ME-Proxy: <xmx:R1sWaVHhPueUE6JHxzemDI3MYHrjLXtVLnqch_706n6rDpT1KbqYSQ>
    <xmx:R1sWaXdy9h3LBYVVsyrSbrxNCl1uhHhke0e1GZeH6R60AxEqxmMQLQ>
    <xmx:R1sWaWIAduhJcXxXyt0_k_GTbqKSK2cBQCKl1Cs5xlI5uhueAoZVyw>
    <xmx:R1sWacF9J6vP9-nEc6PjSD5VavbTY3gfn054jGBqIesiiP2nXCz4aQ>
    <xmx:SFsWaZFbekrbWMkt6AMfh_--0SXNytpLBm8FSlbqnLpfdfxa74TrSju9>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Nov 2025 17:27:18 -0500 (EST)
Message-ID: <00ac745d-f0a6-4fe2-8279-a4dcc3101996@bsbernd.com>
Date: Thu, 13 Nov 2025 23:27:17 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fuse: Avoid reading stale page cache after competing
 DIO write
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org, Hao Xu <howeyxu@tencent.com>,
 Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
References: <20251023-fix-fopen-direct-io-post-invalidation-v1-0-3f93a411cd00@ddn.com>
 <CAJfpegsL2BiUnK+8a-rRE8gc8i=8SYY1KoiTiadKtscOVmgUZw@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegsL2BiUnK+8a-rRE8gc8i=8SYY1KoiTiadKtscOVmgUZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/13/25 15:40, Miklos Szeredi wrote:
> On Thu, 23 Oct 2025 at 00:21, Bernd Schubert <bschubert@ddn.com> wrote:
>>
>> This is for FOPEN_DIRECT_IO only and and fixes xfstests generic/209,
>> which tests direct-io and competing read-ahead.
> 
> This is stable material right?
> 
>> Also modified is the page cache invalidation before the write, the
>> condition on allow_mmap is removed, as file might be opened multiple
>> times - with and without FOPEN_DIRECT_IO.
> 
> I don't think the mixed use was considered previously and probably no
> filesystem does this without NOTIFY_INVAL_INODE in between.   But I
> agree that this is the correct thing to do.
> 
> I guess these are unlikely to have any performance impacts in the no
> cached pages case, but maybe we should check?

I can give this a quick testing when I send out the next version
for the reduced queue patch.

In principle we might re-consider my previous attempt to merge 
FOPEN_DIRECT_IO and direct-io, as that handled it.

https://lore.kernel.org/r/20230829161116.2914040-1-bschubert@ddn.com

I now also understand why that series had reduced number of xfstest failures.


Thanks,
Bernd

