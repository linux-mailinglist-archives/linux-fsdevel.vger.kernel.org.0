Return-Path: <linux-fsdevel+bounces-20545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A5A8D5059
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 18:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D05CD1C2224B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 16:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3EF3D579;
	Thu, 30 May 2024 16:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="3M+ykaLY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PkYkhQg9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0883E3B1A1
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 16:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717088371; cv=none; b=c3y83YZoZbQmH1J617SzacS9LES7BIR3W4BYKMz+yAZL1TvVZSIFR+tAReh8KviTlQ/Y8whOQ7IxfiN64TXZi0c1p+zQJSRNxzPmB2LxaK0SW/2tTPTtCiPPTqhnp6O2qGuQ3PvZ2TVSlJ4oE7uX657ps3ZAygKuGcFYluLa7ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717088371; c=relaxed/simple;
	bh=gRx2mrpH5ht3t1SahUHVoW7eRJLIfBO/n+NkaD1DD3s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MivN0yHIigj/f/fAT+spXQBm8If5LRD5RmzAwbAf4BO1N4BGBmY+HFIqfQ0A0bOeKCsWI9YIDdO15ZwZLhGCW3UrXnnb8mb3MYKb/yFqSnL66ammuv+hMWItu3D4AiuudMFKtaswou+XmBPKVM7vgQeV6zzo9GcSI1piuNlO8nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=3M+ykaLY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PkYkhQg9; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2019113800E1;
	Thu, 30 May 2024 12:59:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 30 May 2024 12:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1717088369;
	 x=1717174769; bh=MgwqPMbI3WSXy/+SGPR5Z6nSc1+yGsFUMrlsOW2YCAM=; b=
	3M+ykaLYlZMZiWARE1nCtM9B8FHrUtdPZXP+0NHsHOHPlAqZoJLdo1JQqKpGAdzW
	JOiXJr6eZVxgtOjamGYUDlw2TdQyj7S/UNMoNy7V9rxxFEl2grdnRXBzcRg63a3U
	0YEug4fniDekrmOOuYXdTXbd8q0vddbGqSVVtCkxVXWUTFrGoGh0NjUwGmEFVOy8
	LgD7DvzWNinZsb1AFf4/gCHsALqWUJwaYBqyw675qewxx0q2dRmFa5i2DxSsOxx4
	Ot6hr0POXtKmkcimBumaXF+u7GF/6Uq2TtKW6/KBsIBaN6WPWXo1jHGc2TOxmyo6
	w20/S5Hv3c3pPJSORYWnig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717088369; x=
	1717174769; bh=MgwqPMbI3WSXy/+SGPR5Z6nSc1+yGsFUMrlsOW2YCAM=; b=P
	kYkhQg9nMMFlzk9GmBh2O65TTPNh5slgUI9fdE05IB0e6g8t8iujtB6blPDE5jI5
	Ngg/VP+voIfI55MmlpoQavBaxv+bOpkM/3YJUf0jk+ZaOtHg5qBYB45YAfVto/s+
	tYvQGi9NW0Q3jjVujGatKX08wv1dvle9kKhDRS8eWau94MYR7sxOkwA6EJOWsqqd
	EnceZzABLCVNDrMZUO4ZiT0re2UFeikwrXzPIdVn0V2r95EHaeUYTbXcs2O5Lmwo
	6WHDrhvi0twmRLMpSrx54nmml3o6q0FvG8aqxLKZzKFxwG+SqPey/xbJLLaemkV+
	UqEMXAWx2v0OEpGjiM/5g==
X-ME-Sender: <xms:cLBYZtHLSFhWmACjKGhb-PtPmhn2C44B2qa7IWmUcW7uqlaI6gCFow>
    <xme:cLBYZiWqvmi0ZGH6mmqkSkadm5_mmRfDsQ8_L8Y9rjRJTh6oDA3Xg-r2lDazAGE_j
    wkViGrnExyxnR-h>
X-ME-Received: <xmr:cLBYZvIHiM39Aw3l1YthB5-g9Xm7HsM3YTWzmXo4xkhMw42HNYm_u_sALk9LAUHTBfN7CY-3GKxzzbcxHZlQBkveQSKqkH2T1V7uDftDe9Lhj7V3rDLT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfhuffvvehfjggtgfesthekredttddvjeenucfhrhhomhepuegv
    rhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpeeukeduudekheegieellefgfeehledtudfg
    udelfeetvdehveegtdefiedvhedtgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhl
    rdhfmh
X-ME-Proxy: <xmx:cLBYZjE6Ci5vy1JDYOyqlO4BPkUY-4CaqM1r7nA6p9c0C6wVj2FSMQ>
    <xmx:cLBYZjWREiqOCwGcFBZbypxViz8jhcem1uLFelOSVw2boauCCnht-Q>
    <xmx:cLBYZuMNIOwtSYz04-TtUpbsaQmgeexFQgXzFA6kRy7WJvtPeysAOQ>
    <xmx:cLBYZi1tAXC7L2zSEF3YZgh4iej4fScgXnnGS5SsjX7j9ZNQL3PTTQ>
    <xmx:cbBYZpdkjIsoMhca-3064P640ZvH7ZNHiVbvUHR-FOi0To8nHZAikvTc>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 12:59:27 -0400 (EDT)
Message-ID: <b52576cd-9128-4ef8-9b64-0dd2543c609d@fastmail.fm>
Date: Thu, 30 May 2024 18:59:27 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Subject: Re: [PATCH RFC v2 16/19] fuse: {uring} Wake requests on the the
 current cpu
To: Shachar Sharon <synarete@gmail.com>, Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
 linux-fsdevel@vger.kernel.org
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-16-d149476b1d65@ddn.com>
 <CAL_uBtfpdFAjZuALySuMoyegGpoyPFg32tw5K+vKzDsrzs=ZAg@mail.gmail.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAL_uBtfpdFAjZuALySuMoyegGpoyPFg32tw5K+vKzDsrzs=ZAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/30/24 18:44, Shachar Sharon wrote:
> On Wed, May 29, 2024 at 10:36 PM Bernd Schubert <bschubert@ddn.com> wrote:
>>
>> Most of the performance improvements
>> with fuse-over-io-uring for synchronous requests is the possibility
>> to run processing on the submitting cpu core and to also wake
>> the submitting process on the same core - switching between
>> cpu cores.
>>
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> ---
>>  fs/fuse/dev.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index c7fd3849a105..851c5fa99946 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -333,7 +333,10 @@ void fuse_request_end(struct fuse_req *req)
>>                 spin_unlock(&fc->bg_lock);
>>         } else {
>>                 /* Wake up waiter sleeping in request_wait_answer() */
>> -               wake_up(&req->waitq);
>> +               if (fuse_per_core_queue(fc))
>> +                       __wake_up_on_current_cpu(&req->waitq, TASK_NORMAL, NULL);
>> +               else
>> +                       wake_up(&req->waitq);
> 
> Would it be possible to apply this idea for regular FUSE connection?

I probably should have written it in the commit message, without uring
performance is the same or slightly worse. With direct-IO reads

jobs    /dev/fuse         /dev/fuse
        (migrate off)     (migrate on)
1           2023             1652
2           3375   	     2805
4           3823             4193
8           7796             8161
16          8520             8518
24          8361             8084
32          8717             8342


(in MB/s).

I think there is no improvement as daemon threads process requests on
random cores. I.e. request processing doesn't happen on the same core
a request was submitted to.


> What would happen if some (buggy or malicious) userspace FUSE server uses
> sched_setaffinity(2) to run only on a subset of active CPUs?


The request goes to the ring, which cpu it eventually handles should not
matter. Performance will not be optimal then.
That being said, the introduction mail points out an issue with xfstest
generic/650,
which disables/enables CPUs in a loop - I need to investigate what
happens there.


Thanks,
Bernd

