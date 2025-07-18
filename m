Return-Path: <linux-fsdevel+bounces-55478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A13CDB0AB40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 23:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22AA11C48425
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 21:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4222215773;
	Fri, 18 Jul 2025 21:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="mFX9cJZc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mURAj0sm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9756518E20
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 21:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752872619; cv=none; b=QPg267xq2nhLlcKV/1j3SZONALRX1Zjs/Rsb4vGXMmsn409myTva9By2DiyWA/mbbf7SuHEspK3cgxkRmSVUs6bPNfGMJlzq+tZvj7gFyZBktWHvHKRNsvK1m2bV8D+SdMJzEjMJCAIF1Taptlco2/TtNY3lSgqfbs6RTIYBJnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752872619; c=relaxed/simple;
	bh=6sUDuY4uVAoj2B6pfXZJd6V7Wh1mOF1QgC96k5JdABk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nvz+BdP79cXMWh7V38suUP1xPOiqbz2vH05MQZT1uRO8Eq5XIHBeThXSI3yw5kYnTkrsMG3OdDBejqjMJGMUjGzBxbGMj7wk4cY5LCk3OZY8YSWUoJXYh0Oc5uGUfJwD6reMVbTE/T1JkPN5WHJX4VRciWlxQuV9Ou7vIfAgfjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=mFX9cJZc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mURAj0sm; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A8038EC009F;
	Fri, 18 Jul 2025 17:03:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 18 Jul 2025 17:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752872616;
	 x=1752959016; bh=IjJ/bLuE5hMKzpwd2091GJM9l+Z8d3Hun0Ag0Ei7Wu8=; b=
	mFX9cJZc64qem42k50xl69zp2ppkpK+Em5JK8V3bvWkrgfKJNTV9SijWxW+o8tcK
	qY6ALrDGc9ofu9/2DhhMCTHdGI0DhFjfFwqSD9ZNSNgIaNitkye+/qvFR1ntFSBp
	yJDNBtyyV0FAPTQ2Nnlk3hnRIokynHzqSaXklrqG48DPwf3TmCK/3Vq7Pa1RrFL5
	c6rTG7LCrmtNoS5jgFEQRO6lvYRebp8wQrCSXyBIn+fhVO/fK2eRLe47Af3k8kAK
	dWbXd3/xAFrrBXJ99Gu7IevzEY3j1SxueEV1iEuE3z/iJ+3WlZQAgkfFx5QGYU5s
	l+Flja/rxE+xdM5yuge1fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752872616; x=
	1752959016; bh=IjJ/bLuE5hMKzpwd2091GJM9l+Z8d3Hun0Ag0Ei7Wu8=; b=m
	URAj0sm1Z7Uwzs8YeFhlVFsZpR5KemsWruiW5e/c5a3Z5OdtAiZLFYUncIo7Sz1+
	QTeoWwjUU117A1iY0Ceoq/lDnKhRfaMlxqEE79tUzxUys6oq5UKIfK3umN/gILz6
	nOC/ubGENtOfx4VVpJBnSnLCDBS/gviL/qlCYKcgrAZWgjWznje9rGkjOkkvJ3HL
	I+C4JrGkRjt2P/66klxeVrB84FsdrZHrCPZvfEXjPRgAXHGt2rdnowfrxv9Vs8eg
	APpUHemvFfD1UlK+SW0i3TsT6cX2PyJ2sSN7pZkNGoAnx8S18J1VKd15boRZ3Vva
	L5ULLIWi3rdt9BDytjjQw==
X-ME-Sender: <xms:p7Z6aO97WiKRlmzyqn-zeSLW2xphbBGTZ_Figag8BNutHxuWJouMGw>
    <xme:p7Z6aMRad1mfLVtpI_FDn5Ul1FMuTWfPp5Ulo1fzsP5MAwUimgajGOToi4BWR7POP
    fjpbyyNNJ-pR1Lp>
X-ME-Received: <xmr:p7Z6aKcrvYZjxNLnpSyNMZtU512aV2HcMg8REKU8_b05fQsQetqTv4wrHAjw0aV-cCKA6VCZF183DmsaK-tZ_kwfY56VB9Mv86IWYm-S5nIes2SeJcNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeigeegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhephefhjeeujeelhedtheetfedvgfdtleffuedujefhheegudefvdfhheeuvedu
    ueegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepughjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepnhgvrghlsehgohhmphgrrdguvghvpdhrtghpthhtohepjhhohhhnsehgrh
    hovhgvshdrnhgvthdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhr
    tghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    ephhgsihhrthhhvghlmhgvrhesuggunhdrtghomh
X-ME-Proxy: <xmx:qLZ6aIB0bKvRDxR9kBirgHS7XuYVoegOXI-zm_fzF4Qpowx1BP2eHA>
    <xmx:qLZ6aEn6JSZ6K0KS0osLhRciNlL5Qq6lP8FPs9EORJE9nDfQ60t0Qw>
    <xmx:qLZ6aLeCL9q8Do9QD6fBQ45uTUMFRrzqmNAQ4IhjFFkpS10SvbG9Bg>
    <xmx:qLZ6aAQNyFbo20om33QaCJhh3gLvEuvWo4JeJlcuimrJLllMbdc6yA>
    <xmx:qLZ6aOQ5qn-xAFiMt0ItGtKAK-d2YLZDbTkSz4IEAv_L_CJXhMAYs-13>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 17:03:34 -0400 (EDT)
Message-ID: <2dbf4c64-bd4d-4368-9805-855fdc32e0d0@bsbernd.com>
Date: Fri, 18 Jul 2025 23:03:33 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] fuse: flush pending fuse events before aborting the
 connection
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, joannelkoong@gmail.com,
 Horst Birthelmer <hbirthelmer@ddn.com>
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
 <175279449501.710975.16858401145201411486.stgit@frogsfrogsfrogs>
 <286e65f0-a54c-46f0-86b7-e997d8bbca21@bsbernd.com>
 <71f7e629-13ed-4320-a9c1-da2a16b2e26d@bsbernd.com>
 <20250718193446.GD2672029@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250718193446.GD2672029@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/18/25 21:34, Darrick J. Wong wrote:
> On Fri, Jul 18, 2025 at 08:07:30PM +0200, Bernd Schubert wrote:
>>
>>>
>>> Please see the two attached patches, which are needed for fuse-io-uring.
>>> I can also send them separately, if you prefer.
>>
>> We (actually Horst) is just testing it as Horst sees failing xfs tests in
>> our branch with tmp page removal
>>
>> Patch 2 needs this addition (might be more, as I didn't test). 
>> I had it in first, but then split the patch and missed that.
> 
> Aha, I noticed that the flush didn't quite work when uring was enabled.
> I don't generally enable uring for testing because I already wrote a lot
> of shaky code and uring support is new.

Yeah, I can understand.

> 
> Though I'm afraid I have no opinion on this, because I haven't looked
> deeply into dev_uring.c.

The updates patches in my branch seem to work. Going to post them
separately, but with reference to your series tomorrow. Difference is
that we cannot call fuse_uring_flush_bg() from flush_bg_queue(), because
the latter is also called from fuse_request_end() - result in double
lock and even it wouldn't flush over all queues is not desirable.


Thanks,
Bernd



