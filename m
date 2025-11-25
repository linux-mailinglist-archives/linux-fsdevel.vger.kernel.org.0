Return-Path: <linux-fsdevel+bounces-69840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D24C87075
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 21:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D97CC4EB800
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 20:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F1533BBA0;
	Tue, 25 Nov 2025 20:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="vYNexzAg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eGGnx9QC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C378733BBC5;
	Tue, 25 Nov 2025 20:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764102299; cv=none; b=BXRKxnxbFI9+/yco/VUXWhrnhXGJMvzKdc0OeQ78QoRwSoEYIMj3oFM52o3awYTb2K/z3wHQcwO2tAPwIu06qego8EGC1Z8vIO+t/7WuWNDb63wvWzkLTcKcFYGyi2MDwx0z7Eyn2rEe+PM9C/FFVNgyRlkWMq12H7X6Cj7ayu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764102299; c=relaxed/simple;
	bh=BrHaCs6HFpMrOBc2esg0gwhS19W/QNq+qb42Ay2v89A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cTSchdRI6rVZ6pp6zTvzr5MUsrIO3Us5iKtlV74HaVTYeoJHEnQjv5nC1VWTXh5HDiUVOoMLHWaLCIxAv6i6qQPviJp1uX01QDCm8APNbTeYCe00JFQxVi/3gpVgKtN0nmrIlfSAclBSEGa1yo1dP8umSRB9/UEKe17U9E+bQIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=vYNexzAg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eGGnx9QC; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9F3957A00F8;
	Tue, 25 Nov 2025 15:24:53 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 25 Nov 2025 15:24:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1764102293;
	 x=1764188693; bh=naL5toI8YYx0Cve9aLfAV7cGOf+6YD8UmeuX6y+fcVg=; b=
	vYNexzAgsxdhlfk1ZxFx7HsVNjUrGeCnxFvD5aRpq1W+pqkaislz4+NQaJ5nwiph
	fBsqASjUxmqjiqSaNeENLx6UG52aL0iVwiRwoXbF0Mpjyy2qbd9dJ7A/hwfm20z1
	qKPCu+HXli6FrRqeseWW5vHT0pOG9m+RzyZPGueFN8ircE7aZKY8laAJEVIR//8w
	TANnnTZeTo97SSMDL0T8TQI3KOwDFtcyrf8JbAfHBk944Rlejiubnx7q1bOIlF6s
	kP4JgyIcIq4Uv1ZJ4HmYnPkTa33J5Xp0uUBWyPv56Mg5lcBs5PioST8N3nhMz4pu
	zYvcwnBNITQ4lQ3xgruTrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1764102293; x=
	1764188693; bh=naL5toI8YYx0Cve9aLfAV7cGOf+6YD8UmeuX6y+fcVg=; b=e
	GGnx9QC3kH7W950mlCrParcIku+TpVe1xVjShOetXeRyckVOLtFRBs88AIaIh2TA
	jPUhKIYFDq8T6cGyrNfDUhvEnsS9Jcm6FnT1zKKs8jVOX0kZp5a1TIGar8xMabu3
	w7uukhDltgWLWyTe7iMCJJT4VBt+ul12Z9XjFP4UvIzay7QATLQPqlBVa2GW6Ycv
	Zvlzn1KNmDgWaH2aw4H3aURd+7kVjPH/Z4J8ELwAvS6vSa0cIdSaDfXu/8P5vjPR
	re7U3dLsIIzfPJXEP1l4Pq1GHEKGXqUU/8CBQ0U9QB6K4EooXuz7WsX2gEHHAJaO
	svZWexJsdK8NJdAml50tg==
X-ME-Sender: <xms:lBAmaUQXme06etip9AoIs6QgvoA2uAYMYrcUn92ux321P-Th157pDg>
    <xme:lBAmafkN5vhDw4grABGRPiER2DlarXkHGbG8xsq7wukNgSyIcEhTTLxcYPGWg32xj
    mIymuyTSgp6P47kIJFeID3Q7X7EhrG0WTaCxDPkS1TR-zGISd9W>
X-ME-Received: <xmr:lBAmacTeTidd__ECy6oKItHngXeRiGTwPQD0I5bT2jJnwv4LxoN7M8lub8L5uR2Z1q0bHCGarwvynF5qrtHAiIc_yxgdgGyd59R_iANimSjnspZWUaGN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedvgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeefgeegfeffkeduudelfeehleelhefgffehudejvdfgteevvddtfeeiheef
    lefgvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtg
    homhdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohep
    lhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:lBAmaVM__zsxievYUTsELujRWgt-CRlyErPYCbPRZh7XL1W0TxyIbQ>
    <xmx:lBAmadWbAcEcjSvWMquBcBWy_zniF0LnWVjTiir1kF8N1rsNK6O92Q>
    <xmx:lBAmaUeeORmxz7rrOozuOKruiechGeyBvUdsIdAh-B2pUoL1frgz1w>
    <xmx:lBAmaRvBQqD3YIPAsqvyrBk0t3L6njXMVTz7PlHm4VJz2iZaZ7f0iA>
    <xmx:lRAmadyPW9qsJpvAJ3a4VuTO02kf_NTVBVM1GAs6hkHEmf3C4jXPLkmx>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Nov 2025 15:24:52 -0500 (EST)
Message-ID: <62c31a1a-a1b2-471d-8fca-7989a57d6371@bsbernd.com>
Date: Tue, 25 Nov 2025 21:24:51 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: fix io-uring list corruption for terminated
 non-committed requests
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
References: <20251125181347.667883-1-joannelkoong@gmail.com>
 <CAJnrk1Y+QR8OfRBkZDe6a4R56m62-Evsu2cbRoKHHnK1JB+i1w@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1Y+QR8OfRBkZDe6a4R56m62-Evsu2cbRoKHHnK1JB+i1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/25/25 19:23, Joanne Koong wrote:
> On Tue, Nov 25, 2025 at 10:15 AM Joanne Koong <joannelkoong@gmail.com> wrote:
>>
>> When a request is terminated before it has been committed, the request
>> is not removed from the queue's list. This leaves a dangling list entry
>> that leads to list corruption and use-after-free issues.
>>
>> Remove the request from the queue's list for terminated non-committed
>> requests.
>>
>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>> Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
> 
> Sorry, forgot to add the stable tag. There should be this line:
> 
> Cc: stable@vger.kernel.org
> 
>> ---
>>  fs/fuse/dev_uring.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>> index 0066c9c0a5d5..7760fe4e1f9e 100644
>> --- a/fs/fuse/dev_uring.c
>> +++ b/fs/fuse/dev_uring.c
>> @@ -86,6 +86,7 @@ static void fuse_uring_req_end(struct fuse_ring_ent *ent, struct fuse_req *req,
>>         lockdep_assert_not_held(&queue->lock);
>>         spin_lock(&queue->lock);
>>         ent->fuse_req = NULL;
>> +       list_del_init(&req->list);
>>         if (test_bit(FR_BACKGROUND, &req->flags)) {
>>                 queue->active_background--;
>>                 spin_lock(&fc->bg_lock);
>> --
>> 2.47.3
>>


Thank you, clearly missing in the fuse_uring_prepare_send() ->
fuse_uring_req_end() error code path.

Reviewed-by: Bernd Schubert <bschubert@ddn.com>

