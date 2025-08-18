Return-Path: <linux-fsdevel+bounces-58195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A990B2AF6B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 19:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A63CF7A2BDE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 17:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1833570AC;
	Mon, 18 Aug 2025 17:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="KBbBMNuc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WfdFmbXn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C7F32C33A
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755538277; cv=none; b=BF++a7kRLrai/F7Ryjfm1Q2oiq6E9QXl/EkuaygCb04IjrRXXCs54crCiWc9Xjqzwi19pGwwSfvJoYGNXyOW4MWZrEzxahXX6qoqCJrHGtmj4AqYmfv2syOxdUc3yETA3exxHJB4uoFt3CJTpDMFpFgakLAEx9u3YZkM7CU7dCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755538277; c=relaxed/simple;
	bh=AgJVAcA9vu/mGsrQasl6zyGoj6z3wEYCisfA8UGjim0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JkruPwiZ/IR+W20yxmKHTE4gAofQObZNPaDa1vxwa/jPIrv5lEKDmbNnUFFg5zuj0EJM33gtq+pi/7UhjrHmLbmZ0N7QQENNrE1ugge85G8xPzOYc8Q2m3fpKX1Ca99/YIZe9k85OrF7xZGaIMyg5pyxJhN45tBZwWJBRcuQBe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=KBbBMNuc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WfdFmbXn; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F0D2D140051C;
	Mon, 18 Aug 2025 13:31:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 18 Aug 2025 13:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755538272;
	 x=1755624672; bh=BEBOX1CqJoM3Qe/ZAD5hsgcuJ8kWKH7dbXbIjNmHZLE=; b=
	KBbBMNucpgO2FfJoT99dsTnuBZzo+FLDFxseiMtnuP7zwZvj6T77xmwLTfCp3zh8
	f7Em3bXG0utlMk/qOY/U4WuaYPP0h8HnVGAMoBTphT+c0zETrTlhkM+2ne1SlYCO
	X32McDPqaS/vuNxJLEmTwy4gwCyL8XCcbhRBKjpSrOfxCyz0CLocFzqlV2KcEH7z
	liqmWx9BF3QqM4YUApdIMWBOXdwOOEcDVt//TMdFe7jy5Pfeo6150HaJfFCzc9tG
	yQjXS9BcFkYRyHZ3l8tIo6UWqKMBfwQKSKIeNfhxrpVoV3xgmnCzwCpiYyAHm8Gd
	7imBR/JAI5Yd5te4PKCfcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755538272; x=
	1755624672; bh=BEBOX1CqJoM3Qe/ZAD5hsgcuJ8kWKH7dbXbIjNmHZLE=; b=W
	fdFmbXn5+vxHI+MQgUn1ZbI+XabAJzvWlsrKUNK8cH7+CY9ZrzHzR4J2c7ADiXtI
	x1K1+lkT96aJMHc0+G7PawNqZD3lN8mGdpRTlvJUPNQ+GbCFmAViWykW/UD5NbS/
	KJMIbitwKLFSuDRPIFd6pH6d0wqh9ynmr5Bu6VPibKJnez2Z1jWFLSy5VFkC57MI
	gF/XhqjQr8d9DvCoXcV7q8yQqy2OKBZ4tOeWKyK+J4VheslItAZFWI82zDBMPuYW
	79jstKkJrEd6qxFu9ZhDrgN+FkY1y1I50vUkMKSSzEzihdtoamvOdvpB0SoXMVri
	IyewQDkJljSHUj4lJq01Q==
X-ME-Sender: <xms:YGOjaN5gFEtMJUEPl75JmED5UDL6QJQdriuaeIlnpUo1--BddOZOlw>
    <xme:YGOjaLGopUsRMsL_Vkw1krCu1rh9nD9KJQUs_2cU7i-woDJ4LWRt-qfrhM4gx9pqT
    SXlFvfkiWiKwenR>
X-ME-Received: <xmr:YGOjaGQiHjRh2OKJiPwh7sOMd_CwN84O5112V5N-UHlN9-judnIvOADA4Egg4U1D0X63aQsau47oHoMwL2F76LjNpVWnzCGoKvO9plKk1cigglhBCVsU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheefvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekre
    dttddvjeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugessghs
    sggvrhhnugdrtghomheqnecuggftrfgrthhtvghrnhepfeeggeefffekudduleefheelle
    ehgfffhedujedvgfetvedvtdefieehfeelgfdvnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdrtghomhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggthhhg
    vddttddtsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:YGOjaEv6sJllsloiQ5sBjOZ34u0eEdF-v3JIgJWzLNh26rmJp4h9Zw>
    <xmx:YGOjaFzf9dX2y6pUqw_MNXJGdOHuVQC1iE711xMpnBOV8zznW2S2wA>
    <xmx:YGOjaO50wYz9vm7uIXbTTV1482XFwCmp4vrjev5lOhC0FRIZW2BBBw>
    <xmx:YGOjaPWUpp7RdLlCjs02hBcA0j4uJAU-JBys9IJrZfShXzvEBmxGXA>
    <xmx:YGOjaJJLt76jmyJOF1vDhbFmsCcid2qbj2-PdLeE6Wgoy4JWirfZOSgZ>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Aug 2025 13:31:12 -0400 (EDT)
Message-ID: <5f63c8e3-c246-442a-a3a6-d455c0ee9302@bsbernd.com>
Date: Mon, 18 Aug 2025 19:31:10 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fuse over io_uring mode cannot handle iodepth > 1 case properly
 like the default mode
To: Gang He <dchg2000@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
References: <CAGmFzScM+UFXCuw5F3B3rZ8iFFyZxwSwBHJD6XwPnHVtqr5JMg@mail.gmail.com>
 <E1CDDCDF-0461-4522-985E-07EF212FE927@bsbernd.com>
 <CAGmFzSe+Qcpmtrav_LUxJtehwXQ3K=5Srd1Y2mvs4Y-k7m05zQ@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAGmFzSe+Qcpmtrav_LUxJtehwXQ3K=5Srd1Y2mvs4Y-k7m05zQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/18/25 03:39, Gang He wrote:
> Hi Bernd,
> 
> Bernd Schubert <bernd@bsbernd.com> 于2025年8月16日周六 04:56写道：
>>
>> On August 15, 2025 9:45:34 AM GMT+02:00, Gang He <dchg2000@gmail.com> wrote:
>>> Hi Bernd,
>>>
>>> Sorry for interruption.
>>> I tested your fuse over io_uring patch set with libfuse null example,
>>> the fuse over io_uring mode has better performance than the default
>>> mode. e.g., the fio command is as below,
>>> fio -direct=1 --filename=/mnt/singfile --rw=read  -iodepth=1
>>> --ioengine=libaio --bs=4k --size=4G --runtime=60 --numjobs=1
>>> -name=test_fuse1
>>>
>>> But, if I increased fio iodepth option, the fuse over io_uring mode
>>> has worse performance than the default mode. e.g., the fio command is
>>> as below,
>>> fio -direct=1 --filename=/mnt/singfile --rw=read  -iodepth=4
>>> --ioengine=libaio --bs=4k --size=4G --runtime=60 --numjobs=1
>>> -name=test_fuse2
>>>
>>> The test result showed the fuse over io_uring mode cannot handle this
>>> case properly. could you take a look at this issue? or this is design
>>> issue?
>>>
>>> I went through the related source code, I do not understand each
>>> fuse_ring_queue thread has only one  available ring entry? this design
>>> will cause the above issue?
>>> the related code is as follows,
>>> dev_uring.c
>>> 1099
>>> 1100     queue = ring->queues[qid];
>>> 1101     if (!queue) {
>>> 1102         queue = fuse_uring_create_queue(ring, qid);
>>> 1103         if (!queue)
>>> 1104             return err;
>>> 1105     }
>>> 1106
>>> 1107     /*
>>> 1108      * The created queue above does not need to be destructed in
>>> 1109      * case of entry errors below, will be done at ring destruction time.
>>> 1110      */
>>> 1111
>>> 1112     ent = fuse_uring_create_ring_ent(cmd, queue);
>>> 1113     if (IS_ERR(ent))
>>> 1114         return PTR_ERR(ent);
>>> 1115
>>> 1116     fuse_uring_do_register(ent, cmd, issue_flags);
>>> 1117
>>> 1118     return 0;
>>> 1119 }
>>>
>>>
>>> Thanks
>>> Gang
>>
>>
>> Hi Gang,
>>
>> we are just slowly traveling back with my family from Germany to France - sorry for delayed responses.
>>
>> Each queue can have up to N ring entries - I think I put in max 65535.
>>
>> The code you are looking at will just add new entries to per queue lists.
>>
>> I don't know why higher fio io-depth results in lower performance. A possible reason is that /dev/fuse request get distributed to multiple threads, while fuse-io-uring might all go the same thread/ring. I had posted patches recently that add request  balancing between queues.
> Io-depth > 1 case means asynchronous IO implementation, but from the
> code in the fuse_uring_commit_fetch() function, this function
> completes one IO request, then fetches the next request. This logic
> will block handling more IO requests before the last request is being
> processed in this thread. Can each thread accept more IO requests
> before the last request in the thread is being processed? Maybe this
> is the root cause for fio (iodepth>1) test case.


Well, there is a missing io-uring kernel feature - io_uring_cmd_done() 
can only complete one SQE at a time. There is no way right now
to to batch multiple "struct io_uring_cmd". Although I personally
doubt that this is the limit you are running into.

