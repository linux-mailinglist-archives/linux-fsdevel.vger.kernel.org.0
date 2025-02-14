Return-Path: <linux-fsdevel+bounces-41762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA0DA3683B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 23:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07D663AEEA9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 22:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D55F1FC104;
	Fri, 14 Feb 2025 22:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="WCgrY6fq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NENfwtyh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4FA1953A9
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 22:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739571903; cv=none; b=VuNMsTm6xmbMO1M8HNIQzOErW8gJVGkh9efj9WVxiFH9QvATQvTmMXGfJOvCZlOPTnTjkmoiHh5SQsvP3RqbN+wBEqOaXzI+FEjaR6njv7wLdY84K4zDOKN8HLr/4oW7M1icpEUO8eREy1RVP89cLlF2+mAZr97mZzS0RxIbk9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739571903; c=relaxed/simple;
	bh=RaxBKtZB5As2jjOl1vXvWW8zqYsvMQEu385DlGMr9vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bRIigG4fEqUTidje7KKt9XOrt3MZ6tZvqPJpz1J/WYmQxI3Cdt2I+Rls0T4Ni3yhlvGgNhlhDWcLYu+72XGXrpe/9QGhQSRfxjlTQ1I4KDtPagY4wXEF5BsY1z5kobTvTTf4ZO+d6apoHSbFLh0JX35rhUigBjF4VHj4XR1i9c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=WCgrY6fq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NENfwtyh; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 6FE1813801AF;
	Fri, 14 Feb 2025 17:25:00 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 14 Feb 2025 17:25:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739571900;
	 x=1739658300; bh=/Q7/MR8fom6L+KfdjUt9VT3j7R0D+AjofniOi3/vHHU=; b=
	WCgrY6fqKSwlQd4ArbBMNBew/o2bXetdOEMsnSdKq+qXHwmScprP731ub284PIve
	F9jt57o51KOC1rAa3TDXnJY4YD+gYMlL925zslzbn0M0GNx342ifp4dzZnBu8Ntk
	Ya4c0DfH+vyDtrohVECiiqbzrt28NWvlfY9qjna/7+73qfv1lNr+JjhX1yVrAUkk
	5q9XRQDvw4Us9yxSF11yEwxGMLi1c6zECtpYdEwswZz2BjepBrtr53n+VlSReMT0
	sY6q2KpHtBEF01SPhxn6uGWrL3jXB21dDzvfj/uD9NpiE6xb3NOO2MAlrVmuf9IZ
	42cGRY4s3Rk7p/si/yon2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739571900; x=
	1739658300; bh=/Q7/MR8fom6L+KfdjUt9VT3j7R0D+AjofniOi3/vHHU=; b=N
	ENfwtyhdzvzQjmmSmcnq9YVbUDbsU0n2YRinku6LoMFRAK6N5EFRuMAcFlUxAGhw
	DBsOGI4jN4EjSbkVO8UvDrSVzkDLsWCd77RS4MuaGMILkTB92CYACbiEkMkkZGOK
	M1dt61IS4hM4wGZC0HGv2miN3qwOnZyUxOuFwQbBNMhjAQdSqGoDwCPnpSdZAsEl
	pj/25WbpOJxn+UocTSysxvkv6p43v31dW940NMXec+vnnW2VXV4jZEFYTQkWlkHB
	lOHKlf6ZUlO9sXm6aIs7GoQRejzbj072q/mgiDvQBFNsKO6hQqBYcjnDzJ8eeud6
	BCKlKwiZqXF63mQq2XmHA==
X-ME-Sender: <xms:u8KvZ4gQsxknuYvBBH705YIAY-4RZsy-o5i2I29mVCVmRp9P0tHoBA>
    <xme:u8KvZxBWbkfruXODlGGWGnEycvY6QUbRGwa1iIly85kWMi240MrNkirAWXlOYotAd
    -iN4ACmo7MXes1v>
X-ME-Received: <xmr:u8KvZwFdbbl1wRWiCVY1-mDCdHg0PZ4tej-_B0Va4iLyA559lXOEBjsC70R_i8vvKwmOwggBnsFg4jmLPieKmc14iL2fF7_DaJEhuIGjJjMyqGeij0Nx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehtdekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeeutdekieelgeeh
    udekgffhtdduvddugfehleejjeegleeuffeukeehfeehffevleenucffohhmrghinhepgh
    hithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhmpdhnsg
    gprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohgrnhhn
    vghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehmihhklhhoshesshiivg
    hrvgguihdrhhhupdhrtghpthhtohepsghstghhuhgsvghrthesuggunhdrtghomhdprhgt
    phhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjhhoshgvfhesthhogihitghprghnuggrrdgtohhmpdhrtghpthhtohep
    jhgvfhhflhgvgihusehlihhnuhigrdgrlhhisggrsggrrdgtohhm
X-ME-Proxy: <xmx:u8KvZ5Tr7hTTB3tRo9Wv9XI_wvyq75dEFHSaO0SCXII71l8uGSxmqg>
    <xmx:u8KvZ1wKFVINSgfs_tSDjqbslzGSdmrp6EouC7YOZeINqsaWw97FUg>
    <xmx:u8KvZ36t-q80T6ojcnRnwoDvuNU6yxvFxm1qOE8gIfetfoMaCTISHw>
    <xmx:u8KvZyykYMyznr24qUTCQLMeUJOFdsRHs1-xpV_tVsFAoUtEKsizlg>
    <xmx:vMKvZ8mnpRUueEXXR-d3weIVyQ2WlPzfHLuqCO6-V3Z8Qzg2uODgh7LV>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Feb 2025 17:24:58 -0500 (EST)
Message-ID: <015b0ab9-1346-40d6-a94f-e6ef56239db4@fastmail.fm>
Date: Fri, 14 Feb 2025 23:24:56 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: Add open-gettr for fuse-file-open
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>,
 linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
 jefflexu@linux.alibaba.com
References: <20240820211735.2098951-1-bschubert@ddn.com>
 <CAJfpegvdXpkaxL9sdDCE=MePdDDoLVGfLsJrTafk=9L1iSQ0vg@mail.gmail.com>
 <38c1583f-aa19-4c8a-afb7-a0528d1035b0@fastmail.fm>
 <CAJfpegsFdWun1xZ-uHXnWBeRz3Bmyf0FSYWiX1pGYU8LEz12WA@mail.gmail.com>
 <CAJnrk1YaE3O91hTjicR6UMcLYiXHSntyqMkRWngxWW58Uu0-4g@mail.gmail.com>
 <0d766a98-9da7-4448-825a-3f938b1c09d9@fastmail.fm>
 <CAJnrk1b0z7+hrs3q9dGqhtnC3e2wQEEoHEyKQgvgTwg9THd_Xw@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1b0z7+hrs3q9dGqhtnC3e2wQEEoHEyKQgvgTwg9THd_Xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/14/25 22:26, Joanne Koong wrote:
> On Fri, Feb 14, 2025 at 12:27 PM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>
>> Hi Joanne,
>>
>> On 2/14/25 21:01, Joanne Koong wrote:
>>> On Wed, Aug 21, 2024 at 8:04 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>>>
>>>> On Wed, 21 Aug 2024 at 16:44, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>>>>
>>>>> struct atomic_open
>>>>> {
>>>>>         uint64_t atomic_open_flags;
>>>>>         struct fuse_open_out open_out;
>>>>>         uint8_t future_padding1[16];
>>>>>         struct fuse_entry_out entry_out;
>>>>>         uint8_t future_padding2[16];
>>>>> }
>>>>>
>>>>>
>>>>> What do you think?
>>>>
>>>> I'm wondering if something like the "compound procedure" in NFSv4
>>>> would work for fuse as well?
>>>
>>> Are compound requests still something that's planned to be added to
>>> fuse given that fuse now has support for sending requests over uring,
>>> which diminishes the overhead of kernel/userspace context switches for
>>> sending multiple requests vs 1 big compound request?
>>>
>>> The reason I ask is because the mitigation for the stale attributes
>>> data corruption for servers backed by network filesystems we saw in
>>> [1]  is dependent on this patch / compound requests. If compound
>>> requests are no longer useful / planned, then what are your thoughts
>>> on [1] as an acceptable solution?
>>
> 
> Hi Bernd,
> 
>> sorry, I have it in our ticket system, but I'm totally occupied with
>> others issues for weeks *sigh*
>>
> 
> No worries!
> 
>> Does io-uring really help if there is just on application doing IO to
>> the current core/ring-queue?
>>
>> open - blocking fg request
>> getattr - blocking fg request
>>
> 
> My understanding (and please correct me here if i'm wrong) is that the
> main benefit of compound requests is that it bundles multiple requests
> into 1 request to minimize kernel/userspace context switches. For fuse

I think it would be good, to give fuse-server also the chance to handle
the compound on its own. Example, sshfs would benefit from it as well
(ok, the sftp protocol needs to get an extension, afaik), see here

https://github.com/libfuse/libfuse/issues/945

If sshfs would now do two requests, it would introduce double network
latency - not your about you, but from my home to main lab hardware 
(US) that would already be quite noticeable.
If sshfs/sftp would get a protocol extension and handle open+getattr
in one request, there would be basically zero overhead.

> io-uring [2], "motivation ... is... to increase fuse performance by:
> Reducing kernel/userspace context switches. Part of that is given by
> the ring ring - handling multiple requests on either side of
> kernel/userspace without the need to switch per request".
> 
> Am I missing something in my understanding of io-uring reducing
> context switches?

With fuse-io-uring we have reduced context switches, because
result submit can immediately fetch the next request, vs previous
read + write.

Then we also avoid context switches if the ring is busy - it
can stay on either side if there is still work to do.

For open and then getattr and if the ring is idle, we still
have the overhead of two independent operations.

One issue I'm currently working is is reducing memory overhead,
we actually might need a fuse-io-uring mode with less rings. 
In that mode chances to have a busy ring are higher. Although
I'm still fighting against it, because it takes away core affinity
and that was showing 3x performance gains with blocking / fg requests.


> 
> 
>> If we could dispatch both as bg request and wait for the response it
>> might work out, but in the current form not ideal.
>>
>> I can only try to find the time over the weekend to work on the
>> compound reuqest, although need to send out the other patch and
>> especially to test it (the one about possible list corruption).
> 
> If you need an extra pair of hands, i'm happy to help out with this.
> Internally, we'd like to get the proper fix in for the issue in [1],
> but we have a hacky workaround for it right now (returning -ESTALE to
> redo the lookup and update the file size), so we're not in a huge
> rush.


Could you ping me in latest two weeks again? Either I found some
time for compound requests by then, or we need to go the easier
way. As long as our DLM mode is not ready we also need this
feature, just a lot of the more urgent issues before that.



Thanks,
Bernd

