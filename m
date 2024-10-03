Return-Path: <linux-fsdevel+bounces-30886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1EA98F0DE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 15:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30B1BB20BC4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 13:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94A719CC3A;
	Thu,  3 Oct 2024 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="AITybi+r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EQsLYZSP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA8E1474A2
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Oct 2024 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727963799; cv=none; b=rn2T22ChBd1UkP3IhChjFMC1zAqQc/mGa/qs+Kqa9tqOeBWEjde2Dm54LgwqfZtgjYVn5CL7b+5qMQr8QTO9G69vxvEet0lUTGQujcVlg0TH2XhrYHqyrp3IuwOEXHrh84WlFP5asyNxD0s5kgDcZbdsy7rTU4a8kTREooODn0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727963799; c=relaxed/simple;
	bh=tOEcsNV45QEjBSB5vWEu/qOjDizJ4iEjRTt9Yv+9zc4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aiRYsgmSwEoESi1HtQsXQqCERe71RdDpo5G40TVC4D8+mH/zR4BTb1sdPghAxBNJiUbhdCghRwX/HPnn3p2RybweLiJF5WHq32hrU+kigBLWf+ZBrhCO6B4iJTL74ygVve9mevhorPMxYwx4ZLxWIhuWGkX9M8Llx82INKW1fC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=AITybi+r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EQsLYZSP; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id C406C1380461;
	Thu,  3 Oct 2024 09:56:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 03 Oct 2024 09:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727963796;
	 x=1728050196; bh=6qMkc0HAPRfYp8DuqsHfn0l5vrSo7XyFBuYxBsWdms4=; b=
	AITybi+rfDWk/W7vW5EMcmvlv4ZwQ8MsqY4HrggU2gGtoyWqxBINAM5qk4EnF5SU
	ESM/K1E9JDEMUnzn3ZYW/5AkTj2ZeaQgHoVnMiBOu5maBfVGxjXkZ91rTS2CBxuj
	mUkqIE+je6J631192p8jHcglLiEQdIfqVrK6ud6Qofs2WyGew3PBObWMa9t+rYzJ
	j6Mr+BKYCv723dNQgDgJhZuu85mECylNEKR0siSVvshCOtePsP5B/033Nv8Ay1rV
	qbdGRcEmKN2o888cBpYyur4kI3VbfswRwuOc7r27MNlx+aujoSOPQvSWbkGV+C7k
	FwAEDCrv2RuD0dQFD/YGtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727963796; x=
	1728050196; bh=6qMkc0HAPRfYp8DuqsHfn0l5vrSo7XyFBuYxBsWdms4=; b=E
	QsLYZSPICv+E4aVc1gcAhv8VZLmDZUU29FuruSnxkie1VZfcQ90zlBkQP/JPkvH5
	BkGSDcdupDC3cUNEI0e+2/aGOQgEQZtJdpIQbZetD+u0yvGM+PGl5YPV+pvjWPHh
	WTg8psRorIdT8EH6pyzZ1Fc8c66kIBSjlzbawX4XFffsOWZwvNbqPrd9HGmgIZVm
	vhHQ1Oh/q+Bd1cHfz9suzI2+WozT0NE3poBUkChOSpa+gxFPeR6ZbCGf0wbtuWoL
	zIZIxF3IdG4+fCa0wXdUVji2MRlq6b0cUZlu9CHtziKSPosvFEcFoHtkbBhLalz/
	PuYkxutDxEMmmpEN232Kw==
X-ME-Sender: <xms:lKL-ZtGxYoPzZv1vWX5YYjZbnFEs_iQKZj1-D3_mDO8BuM1jmjka_w>
    <xme:lKL-ZiWYaQ9iqbFzFp_NjBx97_puElsskwiJ5s1odCaZb4qkYKvi0Olyzhh_gFbtd
    lo1F8g4P64VDALu>
X-ME-Received: <xmr:lKL-ZvJdI75ipbai20UtnbjG1S2vCWUQ5hLkU9KhRXOxocMKMU4H6uVw_jLIOk73xS3yB1rYFqNGWNgIgYSsTps_YJcBgaMTPCKdRySLR40Eh1kGIENz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvuddgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffhvfevfhgjtgfgsehtjeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepieekfedvleetgfff
    vdevfeelvdefffeghfetgeegffduudehieeuteevuedukeejnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhht
    sehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohep
    lhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehjohhs
    vghfsehtohigihgtphgrnhgurgdrtghomh
X-ME-Proxy: <xmx:lKL-ZjHYcXfwuZGGdZv62RwRSWW0Q7FqSudZ41V0fU_hwDZgDkI_kg>
    <xmx:lKL-ZjXXJCuEg6LLyHT5lj2Q-bN7KD9NxACUjRURGWBfda-o2T2uRg>
    <xmx:lKL-ZuPby1NYZGU3NoB8Pu6jqtKl7r34hCcOnGa2DuwPPgr6ga3P1Q>
    <xmx:lKL-Zi0jPNcYN2QA3JLFAUTjojxMLpXkWauqp_tF7dmw_5WUdLUBFg>
    <xmx:lKL-ZpwKDHbIGc3NwCL0Lr26th__Zmfk6NsNGdjDxrW5nQPBYsS978nt>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 09:56:35 -0400 (EDT)
Message-ID: <a97070c4-c3ec-4545-bff5-496db3c9e967@fastmail.fm>
Date: Thu, 3 Oct 2024 15:56:34 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fuse-io-uring: We need to keep the tag/index
From: Bernd Schubert <bernd.schubert@fastmail.fm>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>
References: <e3a4e7a8-a40f-495f-9c7c-1f296c306a35@fastmail.fm>
 <CAJfpegsCXix+vVRp0O6bxXgwKeq11tU655pk9kjHN85WzWTpWA@mail.gmail.com>
 <813548b9-efd7-40d9-994f-20347071e7b6@fastmail.fm>
 <CAJfpegtazfLLV9FoeUzSMbN3SoVoA6XfcHmOrMZnVMKxbRs0hQ@mail.gmail.com>
 <c2346ef4-7cf1-412a-982c-cf961aa8c433@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <c2346ef4-7cf1-412a-982c-cf961aa8c433@fastmail.fm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/3/24 15:19, Bernd Schubert wrote:
> 
> 
> On 10/3/24 14:02, Miklos Szeredi wrote:
>> On Thu, 3 Oct 2024 at 12:10, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>>
>>> What I mean is that you wanted to get rid of the 'tag' - using any kind of
>>> search means we still need it. I.e. we cannot just take last list head
>>> or tail and use that.
>>> The array is only dynamic at initialization time. And why spending O(logN)
>>> to search instead of O(1)?
>>
>> Because for sane queue depths they are essentially the same.  This is
>> not where we can gain or lose any significant performance.
>>
>>> And I know that it is an implementation detail, I just would like to avoid
>>> many rebasing rounds on these details.
>>
>> I think the logical interface would be:
>>
>>  - pass a userspace buffer to FETCH (you told me, but I don't remember
>> why sqe->addr isn't suitable)
> 
> I think we could change to that now. 
> 
>>
>>  - set sqe->user_data to an implementation dependent value, this could
>> be just the userspace buffer, but it could be a request object
> 
> Libfuse already does this, it points to 'struct fuse_ring_ent', which then
> points to the buffer. Maybe that could be optimized to have 
> 'struct fuse_ring_ent' as part of the buffer.
> 
>>
>>  - kernel allocates an idle request and queues it.
>>
>>  - request comes in, kernel takes a request from the idle queue and fills it
>>
>>  - cqe->user_data is returned with the original sqe->user_data, which
>> should be sufficient for the server to identify the request
>>
>>  - process request, send COMMIT_AND_FETCH with the userspace buffer
>> and user data
>>
>>  - the kernel reads the header from the userspace buffer, finds
>> outh->unique, finds and completes the request
>>
>>  - then queues the request on the idle queue
>>
>> ...
>>
>> What's wrong with that?
> 
> In my opinion a bit sad that we have to search
> instead of just doing an array[ID] access. I certainly don't want to
> rely on the current hashed list search, this only works reasonably
> well, because with the current threading model requests in fly is
> typically small. 
> And then rb entries also have pointers - it won't take 
> any less memory, more on the contrary. 
> 
> At best one could argue that on tear down races are avoided as one
> has to do a search now. Although that was handled but checks
> tear-down checks in fuse_uring_cmd.
> 
> Well, if you really prefer, I'm going to add use an rbtree or maybe
> better xarray search.  No reason for anything like that in libfuse, it can
> just continue to type cast 'user_data'.

I'm inclined to do xarray, but still to assign an index (in the order of
received FUSE_URING_REQ_FETCH per queue) - should still give O(1).


Thanks,
Bernd

