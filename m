Return-Path: <linux-fsdevel+bounces-55467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8329BB0AA5D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 20:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A415F5A424C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 18:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C502E8DE7;
	Fri, 18 Jul 2025 18:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="RU/KUWLv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FNyHbEuy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE322E88A2
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 18:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864673; cv=none; b=GCFy8vsMjCPOqf8vDAO9hZDW0JMSrzO/Y++SeKoDfEawTsYd2YeizG+cd7M4hxxhQUbqfbOKGCplvajgJqbcBzc/k0oWmZvaE0vGBXzZFo6oaySK5+Cd8ESKxwS+hPys7oSwB6BXnQHfmLFz5KPtHpZhBNrL51QOaXiZcb5LgVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864673; c=relaxed/simple;
	bh=hQh9A04BJINxmbMIMTn2Zvtk5Qw5X8R1NIzAg1pSVeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mOaNDJcgFN01GMGeLgdL5oGtIXH7mksAsYLJDgRr+0ZuhOdOL3We8ToqWIarrbE0T3gZfGdTePnWbS/u63SuZLDznWTm8JmmVFWP20wpYBH8BHg9F3AxWWR6Y0THkBLABrJ1nFsDeaSdKViWdFz3JRPAtrO/W45A7R8FzqeJX5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=RU/KUWLv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FNyHbEuy; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 938AB14000F5;
	Fri, 18 Jul 2025 14:51:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 18 Jul 2025 14:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752864667;
	 x=1752951067; bh=WPqEAYJRtyER8slEEJPaYm7TVoq5pMbs71YclNRcbVw=; b=
	RU/KUWLvzBMioJfZpdBBDRc4N0Ojs78VsUg75kNTig9vxkqIPys+OxejHT5ggasQ
	CLyfjcM7GK/Em6qkSqL0mU2w8iwiiQfVJpp9cAxDuAdDZ8cJCkZ5wLfaabapYGhS
	lGzHX4A6F/ocI4gjuFV9df5Qut+pzKfBObCT/dgNBGETweWBIfsZy7np7A4laYfg
	t394kQnazMQ9HQUBQZT0M+daWOqRNtquP4QHgsqPgBoV6XiBvXFmEkEW02/OygxI
	rLYmYqU0DtjpBOTY0D/yFJtlHOlbDTwBwzya70caPOAxgHKzyXA+FrJamL/9H0G2
	BMQ7kd+8wYC8WnVz93/fXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752864667; x=
	1752951067; bh=WPqEAYJRtyER8slEEJPaYm7TVoq5pMbs71YclNRcbVw=; b=F
	NyHbEuyPq+hRtOnG7GUMuCozWXXu4O2IXiExYD8T8Ge9sGk9M3jVP45F/ErOrvVR
	71orXSeCSOZnDzfWvd6EfnSWRgX7OUrY24j63R1oTGS/M9Im0ImMGzB+Z7vK82AV
	pemZtHEJOV2JOOZWyG2PkpTkzZ2OjVgSiM+IX58MkmZ0uIfAz6vWP2ufWcFGjUGD
	JifdYdAc/f8RP4TZOU5diY1vIImBFVfaG7sdug2x7C9kOvvEos80PZQ4Loul9nZa
	TVvvpSZU4dtEdSQZLA3v8DRAEGAQRxd4mwgk42POKIicEpJBnQXBz9i3iNxNZVe4
	NtZjLZo9chwdM9GEKyKug==
X-ME-Sender: <xms:m5d6aLXoeEDiWPZer9PAu1rlbkTG5YkDCBRgNeMNg4FeUiVwBojvnQ>
    <xme:m5d6aBKPrXyHjlsr99hfWRmaXwDJjYjV31_t-QH6czJ0c6eAsXkiM0XD8Gd-eNGwf
    vcQPiFTXaLGrvOl>
X-ME-Received: <xmr:m5d6aN2EtxO_yfIgdr-vRl2ISXiMqAHBvTZMpTGsy19ZVXQDaKL5Ce0uMBm-CUZQtnZ-IU1gz38VgBsA1Ao4i9FYrrnu9lIM0JWguzf6Lr1_YbXyxN3B>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeigedvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhephefhjeeujeelhedtheetfedvgfdtleffuedujefhheegudefvdfhheeuvedu
    ueegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepughjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegsshgthhhusggvrhhtseguughnrdgtohhmpdhrtghpthhtohepjhhohhhnsehg
    rhhovhgvshdrnhgvthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilh
    drtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepnhgvrghlsehgohhmphgrrdguvghvpdhrtghpthhtoh
    epmhhikhhlohhssehsiigvrhgvughirdhhuh
X-ME-Proxy: <xmx:m5d6aH708q8Q4qa2g7bi8o86AUjSAqGoMis7nWarprG_iU7APsH6lA>
    <xmx:m5d6aG-tkCwOTODYXFC-K2aGWxb-7KfvQSLZ5ezpqv5mr0zcG3SoGg>
    <xmx:m5d6aOXtmY2cClBr-xRcER-L3sN2UsmW3fHBmX3wqu9ffnieOUa1dA>
    <xmx:m5d6aJoDywluQ7iWCA83v1SCKwmb5ebtGsrIA_p8xNSHHtRr3tw8rQ>
    <xmx:m5d6aOvj4OXn-2nc5baiYX9Swo5ebKs1po-nYzBTRSrdk2fFm-nqYiKN>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 14:51:06 -0400 (EDT)
Message-ID: <2f92be5f-5246-4e9d-ae2f-2fad4582ef93@bsbernd.com>
Date: Fri, 18 Jul 2025 20:51:05 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] libfuse: enable iomap cache management
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Bernd Schubert <bschubert@ddn.com>, "John@groves.net" <John@groves.net>,
 "joannelkoong@gmail.com" <joannelkoong@gmail.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "neal@gompa.dev" <neal@gompa.dev>, "miklos@szeredi.hu" <miklos@szeredi.hu>
References: <175279460162.714730.17358082513177016895.stgit@frogsfrogsfrogs>
 <175279460180.714730.8674508220056498050.stgit@frogsfrogsfrogs>
 <573af180-296d-4d75-a43d-eb0825ed9af8@ddn.com>
 <20250718182213.GX2672029@frogsfrogsfrogs>
 <a0971aee-6f10-4279-b90a-beeb5c3f3637@bsbernd.com>
 <20250718184006.GZ2672029@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250718184006.GZ2672029@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/18/25 20:40, Darrick J. Wong wrote:
> On Fri, Jul 18, 2025 at 08:35:29PM +0200, Bernd Schubert wrote:
>>
>>
>> On 7/18/25 20:22, Darrick J. Wong wrote:
>>> On Fri, Jul 18, 2025 at 04:16:28PM +0000, Bernd Schubert wrote:
>>>> On 7/18/25 01:38, Darrick J. Wong wrote:
>>>>> From: Darrick J. Wong <djwong@kernel.org>
>>>>>
>>>>> Add the library methods so that fuse servers can manage an in-kernel
>>>>> iomap cache.  This enables better performance on small IOs and is
>>>>> required if the filesystem needs synchronization between pagecache
>>>>> writes and writeback.
>>>>
>>>> Sorry, if this ready to be merged? I don't see in linux master? Or part
>>>> of your other patches (will take some to go through these).
>>>
>>> No, everything you see in here is all RFC status and not for merging.
>>> We're past -rc6, it's far too late to be trying to get anything new
>>> merged in the kernel.
>>>
>>> Though I say that as a former iomap maintainer who wouldn't take big
>>> core code changes after -rc4 or XFS changes after -rc6.  I think I was
>>> much more conservative about that than most maintainers. :)
>>>
>>> (The cover letter yells very loudly about do not merge any of this,
>>> btw.)
>>
>>
>> This is  [PATCH 1/1] and when I wrote the mail it was not sorted in
>> threaded form - I didn't see a cover letter for this specific patch.
>> Might also be because some mails go to my ddn address and some to 
>> my own one. I use the DDN address for patches to give DDN credits 
>> for the work, but fastmail provides so much better filtering - I
>> prefer my private address for CCs.
>>
>> So asked because I was confused about this [1/1] - it made it look
>> like it is ready.
> 
> Ah, yeah.  My stgit maintainer^Wwrapper scripts only know how to put the
> RFC tag on the cover letter, not the patches themselves.  Would you
> prefer that I send to your bsbernd.com domain from now on so the emails
> all end up in the same place?

Yes please! bsbernd.com gets routed to fastmail and I have quite some
mail sorting rules there.

Btw, interesting that you manage to handle cover
letters with stgit. Must be your wrapper scripts.
I basically switched to b4 to send patches
because stgit doesn't handle it well. 


Thanks,
Bernd

