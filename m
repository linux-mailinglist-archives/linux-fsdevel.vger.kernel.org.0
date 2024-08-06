Return-Path: <linux-fsdevel+bounces-25177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 790F29498CF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 22:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 999B71C21C95
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 20:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFB3811F7;
	Tue,  6 Aug 2024 20:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="WwDGIFzN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o8aZ/ee2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFA77580A
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 20:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722974919; cv=none; b=uI5mCFps/mPJ2u5WupkbFeXovziZZdO92opSXPvDliSkhICRApWZY1VQBdZbqQVBKmpPUk9YoyO7YT+pyRPlZzH7e/XfK1Nh5Nylh3D23LSVNJEyOtUWuzBf3zb42IKyngJAfIBMFnFxlrCTkSplXk8un4kNp7Z51VnxtLZTBRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722974919; c=relaxed/simple;
	bh=tNnrp4/tvLcyQkgWsYa2UQjTf84TFpr+8fET66hdpoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e4VpWnQ+qhBIN6gv2eHm6ii71mAP6SOQ4/Cb6nr/lNXqqSH9W/2D5CutwBM4uL8ESG5Sqfos5Fxd3p6xiF7aK4OBfXTnlJ4RUBSHJUBCPJukxa2WKy8/J3/fi65GNR4zVVmOXkRhQoBw3pfp5Fm6PjmQ2zf6QLUN9LSYlRVCCcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=WwDGIFzN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o8aZ/ee2; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8E29B138D0B1;
	Tue,  6 Aug 2024 16:08:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 06 Aug 2024 16:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1722974916;
	 x=1723061316; bh=5tM467nKzL55S8cR/Ghnsb/La5dkk4CYszFRWfv6Vko=; b=
	WwDGIFzNzQW/AE3oq1MVZ0tFJ1cZLuCoMNCoEZTdNR0dqYNPefsqOTPTqCiOh08T
	8+7T3gT3n0iaYBizmSzsOUIXPsRdRRBCoXhDb9KRTfNh87nXq0n0j5sE6lWSTqJV
	r3M9KoWWE38TxdRTIehvZfI6c4vXGDXS9AkhxbrbK9nakC0xnBIDNIAFQxqzOaRn
	U+SiqLkj2qvL1h7nzKwiYXmtGoOsEkcrs8n9pwGWVREZV0yEF9ISzrZuxOJVYuOb
	G3M6CgKul5lvidQo+eb3Q30ls1IpzfuMaV+lLLXB8/aUQ0m3YquJZD120lWwxbGj
	I6NjyHumrib/vCPi8zm8jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722974916; x=
	1723061316; bh=5tM467nKzL55S8cR/Ghnsb/La5dkk4CYszFRWfv6Vko=; b=o
	8aZ/ee2ppwaxGh7KHH237u+gq51leLAh9mF5xxxWWU22XdsQaLfodU1imu3qnZWt
	lwRTo1gq7KzGdRMDw/gaOX5vr9y0d0HE+NT4JvN8LuRWT12aWkZx33lmipBp2MYL
	wK9jxuKbXNMC4Iiy4cg2PoQEtHfQdKeZaM5fksRYp2WPqqbllk0gEf6ScoXbOfyc
	p5otXLRG95b9kB1tLestIhqEZl1naZJ3EOTuVu7yc0CH82ieRZ3LqLglTjX1M5qI
	fgj8pxkZ/kKhZWAc0D/OatWOWHThu6I3Gt/TtYMYQFYD4Mmuylvu+ygkR1wgpQEm
	XejMTaK0unjIdPTh/qipQ==
X-ME-Sender: <xms:xIKyZogry1yw2pX29SieyMuzPKwef5t7lP6WUrr4AO8D4qoYMRhSmA>
    <xme:xIKyZhDV82Sdkvd1v9eVaYRKw0VSsCY6yxeyzkLqMg1yhgV_7_RGufgrn7FVSM4KC
    7uCeO0bnP8KPfMQ>
X-ME-Received: <xmr:xIKyZgFwXk_PakGuBHssK6GktUD3eREAwIE6R5FzgUgDGQQ9Yo4NbELjDL31gaq6xGIT71JwXZwJt5aHFh7SzSikbSYltggNCieEEMtGObXmVGchtyx->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgddugeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepudelfedvudevudevleegleffffekudekgeev
    lefgkeeluedvheekheehheekhfefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:xIKyZpQCpge_YUvCZ6CsvUjeBWvPHJzSWrA1zhGNo3Fp52Yzqpvohg>
    <xmx:xIKyZlzVs1xA6MlQLatuGht8wvwxb7NvGj5tAcdb_LXpYTnEc1_gFQ>
    <xmx:xIKyZn4c-QMrDIUwZa0MX1cRLSsR8Ww5kxyhBpRAylXX7Yolly5YAQ>
    <xmx:xIKyZiznb3vaH2nUBUWw7QVybkQbAX6CtEdPclAax9K1qtqrdMwVaw>
    <xmx:xIKyZsmC-oqQ9qW2KkY5ulqgy4zpliUhSXPLnibrbkDK9ro0DA46mtZN>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Aug 2024 16:08:35 -0400 (EDT)
Message-ID: <291bb7de-181b-4338-93ce-2d56a99f717c@fastmail.fm>
Date: Tue, 6 Aug 2024 22:08:34 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] fuse: add timeout option for requests
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, kernel-team@meta.com
References: <20240730002348.3431931-1-joannelkoong@gmail.com>
 <CALOAHbD=PY+forv4WebU06igfTdk2UpuwEpNosimWKE=Y=QmYg@mail.gmail.com>
 <CAJnrk1ZQReyeySuPZctDFKt=_AwRfBE8cZEjLNU3SbEuaO49+w@mail.gmail.com>
 <CALOAHbCWQOw6Hj6+zEiivRtfd4haqO+Q8KZQj2OPpsJ3M2=3AA@mail.gmail.com>
 <CAJnrk1ZGR_a6=GHExrAeQN339++R_rcFqtiRrQ0AS4btr4WDLQ@mail.gmail.com>
 <CAJnrk1bCrsy7s2ODTgZvrXk_4HwC=9hjeHjPvRm8MHDx+yE6PQ@mail.gmail.com>
 <CALOAHbCsqi1LeXkdZr2RT0tMTmuCHJ+h0X1fMipuo1-DWXARWA@mail.gmail.com>
 <CAJnrk1ZMYj3uheexfb3gG+pH6P_QBrmW-NPDeedWHGXhCo7u_g@mail.gmail.com>
 <CALOAHbA3MRp7X=A52HEZq6A-c2Qi=zZS8dinALGcgsisJ6Ck2g@mail.gmail.com>
 <CAJnrk1ZRBuEtL65m2e1rwU9wJn3FTLCiJctv_T-fKAQaAbwLFQ@mail.gmail.com>
 <CAJnrk1YL8zvTRESyf_nXvHwHBt-1HLSSpO7s=Ys7ZF28g5YQeA@mail.gmail.com>
 <d3b42254-3cd0-41f9-8cc1-fd528c150da2@fastmail.fm>
 <CAJnrk1YVvyv9pEddeKBvisqu5O7z_WtoEhUSzmJmxpCX0UaDWw@mail.gmail.com>
 <CAJnrk1ah5KP97A6o6kGa+CJE_hwdM1knTfniiwEqsyMGW0A3ew@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, fr, ru
In-Reply-To: <CAJnrk1ah5KP97A6o6kGa+CJE_hwdM1knTfniiwEqsyMGW0A3ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/6/24 20:37, Joanne Koong wrote:
> On Tue, Aug 6, 2024 at 11:26 AM Joanne Koong <joannelkoong@gmail.com> wrote:
>>
>> On Tue, Aug 6, 2024 at 10:11 AM Bernd Schubert
>> <bernd.schubert@fastmail.fm> wrote:
>>>
>>> On 8/6/24 18:23, Joanne Koong wrote:
>>>
>>>>>
>>>>> This is very interesting. These logs (and the ones above with the
>>>>> lxcfs server running concurrently) are showing that the read request
>>>>> was freed but not through the do_fuse_request_end path. It's weird
>>>>> that fuse_simple_request reached fuse_put_request without
>>>>> do_fuse_request_end having been called (which is the only place where
>>>>> FR_FINISHED gets set and wakes up the wait events in
>>>>> request_wait_answer).
>>>>>
>>>>> I'll take a deeper look tomorrow and try to make more sense of it.
>>>>
>>>> Finally realized what's happening!
>>>> When we kill the cat program, if the request hasn't been sent out to
>>>> userspace yet when the fatal signal interrupts the
>>>> wait_event_interruptible and wait_event_killable in
>>>> request_wait_answer(), this will clean up the request manually (not
>>>> through the fuse_request_end() path), which doesn't delete the timer.
>>>>
>>>> I'll fix this for v3.
>>>>
>>>> Thank you for surfacing this and it would be much appreciated if you
>>>> could test out v3 when it's submitted to make sure.
>>>
>>> It is still just a suggestion, but if the timer would have its own ref,
>>> any oversight of another fuse_put_request wouldn't be fatal.
>>>
>>
>> Thanks for the suggestion. My main concerns are whether it's worth the
>> extra (minimal?) performance penalty for something that's not strictly
>> needed and whether it ends up adding more of a burden to keep track of
>> the timer ref (eg in error handling like the case above where the
>> fatal signal is for a request that hasn't been sent to userspace yet,
>> having to account for the extra timer ref if the timer callback didn't
>> execute). I don't think adding a timer ref would prevent fatal crashes
>> on fuse_put_request oversights (unless we also mess up not releasing a
>> corresponding timer ref  :))
> 
> I amend this last sentence - I just realized your point about the
> fatal crashes is that if we accidentally miss a fuse_put_request
> altogether, we'd also miss releasing the timer ref in that path, which
> means the timer callback would be the one releasing the last ref.
> 

Yeah, that is what I meant. It is a bit defensive coding, but I don't
have a strong opinion about it.


Thanks,
Bernd

