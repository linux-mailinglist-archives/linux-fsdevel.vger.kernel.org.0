Return-Path: <linux-fsdevel+bounces-45473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA80BA781C8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 19:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5F947A5236
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 17:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AB320E6E2;
	Tue,  1 Apr 2025 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="I9LW7bYX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eGntcb5E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC7C2040A4
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Apr 2025 17:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743530217; cv=none; b=ZYdWo8VUXJ1jiQcOJaFsg0TgAyccpPDY71bTw6UFEn91/AIGPEDJxIK6PxghHCVvsLLMuggulcqpp4a6F9YIMh6zhJ7gVe6BkoICJYy+MG8Mb4uGCwl9EkHYJiAiFPb52nnXGmOTLo+Iw9ColnlMCqRRJUIlG5Srm5g2yaSpAZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743530217; c=relaxed/simple;
	bh=JyTduEP4DVwOkHOUSCQMBVfbbgfrYWGyYg2B+iIf4sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cVZWeBxuD4JqCbqf9vYgjnmE1y5VgF4RVw+/RqMzpNSaSiHTdRT8UcdX0LUrTXUMkuQdxYAQy4axpP6g//xFstt55l2OM1iNVemEKa49t9gaOyNqmkKKWdEIlPY8xSVObMKCci8yOU+fXLjJG6HzAVNJ2H301J94PbMFfOvaU3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=I9LW7bYX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eGntcb5E; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6EF57254015E;
	Tue,  1 Apr 2025 13:56:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 01 Apr 2025 13:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743530214;
	 x=1743616614; bh=nr7MgYv14SRfGSC+Moo64TjflY+D/+d+5/wt5AIlXho=; b=
	I9LW7bYXl4WBn2zmRsDTrAJ33aBRg2cSu5tdwp/9SOPm2lwiElHqDs0WDBGYAt1q
	QpuPQBZPlvK2oCNZhIfSQnlElkth8VLoq32oqEXnROLodjZIJOtAgmXLsrxio5Vo
	efk7Aohp0zge5dyFbkaQjtL9+MwAFWjA+BhNi1QaevmwzVlfowkspEnbSwRKZgXt
	FzoJBdfkNkkr5m2bBMg+82mj2HXmMp+7TQJdCY301uYmgbcZOck2/65kpJVbxs3T
	e61PNH3JcrWQ71KMOlr1SeH1rq7OeB5GHrfEYF03OFzzXhTE8vTMs0l7D4gpbpIG
	rlriDpU+Fi/Rcqn2iZ/kgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743530214; x=
	1743616614; bh=nr7MgYv14SRfGSC+Moo64TjflY+D/+d+5/wt5AIlXho=; b=e
	Gntcb5ERzFwvAgNs4ExpDMRrZvGHQkQbvV49nv69T7aoOU1n9gimXWviYYf8KPzs
	8xwfN1g2MHOggZe2h6dH58fML+qw175sMchrSPBRaTAoiIP/Ey58Zoui8aizvCA8
	vjgf0V0FDxn5eUlEPMbNhfSWHckU5y8ub+kPBNuZZbbiKhH9GOR9hYQ53su8IjYt
	m0xOb7AvkyGWm02fi7aajiVXooHMthF2gPiKVqRHbw4JLBNER7L3ftT9RXocS/JF
	0+kyo+4qfZfx6ZyNRvkyyvqkKxRvI52juvyLR98y++b07iMthmjjTo7g148ow9ec
	RXqHFDNbXVoi0iib2Q5nA==
X-ME-Sender: <xms:5SjsZyBasxfwCrBoBxrHFqQAjZCUzBSYAz9vSUtmpJnguQ6Celztag>
    <xme:5SjsZ8g7zFdE3_FiSsl-8ZDoDpEeWezr0GpLYQRR_WKuJh2Pb_2enzE36euSSnm_C
    bJyq4MRCS0Rr3q2>
X-ME-Received: <xmr:5SjsZ1l8a2PxBOxL4gjuO8fi6cOuvjyBAy_e1vTZCXMhW0IHtiz7zx9LShpisFX7a3Udi_4jXOOjNlCqjIzSunlGMs8sibuv7goI6LSHkM0b5NRC_Uee>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeefgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuh
    gsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepudelfedvudev
    udevleegleffffekudekgeevlefgkeeluedvheekheehheekhfefnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggv
    rhhtsehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinh
    hugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehk
    vghrnhgvlhdqthgvrghmsehmvghtrgdrtghomh
X-ME-Proxy: <xmx:5SjsZwxUa_s9qkr5doAyM8fAU2F_0Uf0-BDAmSUxhnTTqVLw7ey7CA>
    <xmx:5SjsZ3RViZlMdmRL0NfjTzZ7Y3mgZkixugeh7jDbcAqKeTimIDB2Fw>
    <xmx:5SjsZ7Y2FqJOfrUXUg3i7C2y5bHVW0nhn6kv5Giog0yssT-fysQgtA>
    <xmx:5SjsZwRhAq-EztZ2qo0oCYW1TWThkOyouDCvljFvb9jQyI-isA8W7Q>
    <xmx:5ijsZ1OMFeANmDgk-Zj6VLiQIyI1ot_2YRTwCbYxs4tdVjpqFazA10jJ>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Apr 2025 13:56:53 -0400 (EDT)
Message-ID: <1ae8b7c8-5feb-4b8d-bd89-b8e2ac3c4ab0@fastmail.fm>
Date: Tue, 1 Apr 2025 19:56:51 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fuse: add numa affinity for uring queues
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
References: <20250331205709.1148069-1-joannelkoong@gmail.com>
 <CAJnrk1a4fzz=Z+yTtGXFUyWqkEhbfO1UjxcSk1t5sA7tr8Z-nw@mail.gmail.com>
 <c2ab84de-84b7-4948-8842-21dd8e8904b3@fastmail.fm>
 <CAJnrk1YgRVqQriykVRuburcGK5oN8bzGRNTvyKhr19P-siJ4xg@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1YgRVqQriykVRuburcGK5oN8bzGRNTvyKhr19P-siJ4xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/1/25 19:50, Joanne Koong wrote:
> On Tue, Apr 1, 2025 at 1:11 AM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>
>> On 4/1/25 01:42, Joanne Koong wrote:
>>> On Mon, Mar 31, 2025 at 1:57 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>>>>
>>>> There is a 1:1 mapping between cpus and queues. Allocate the queue on
>>>> the numa node associated with the cpu to help reduce memory access
>>>> latencies.
>>>>
>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>>> ---
>>>>  fs/fuse/dev_uring.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>>>> index accdce2977c5..0762d6229ac6 100644
>>>> --- a/fs/fuse/dev_uring.c
>>>> +++ b/fs/fuse/dev_uring.c
>>>> @@ -256,7 +256,7 @@ static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *ring,
>>>>         struct fuse_ring_queue *queue;
>>>>         struct list_head *pq;
>>>>
>>>> -       queue = kzalloc(sizeof(*queue), GFP_KERNEL_ACCOUNT);
>>>> +       queue = kzalloc_node(sizeof(*queue), GFP_KERNEL_ACCOUNT, cpu_to_node(qid));
>>>>         if (!queue)
>>>>                 return NULL;
>>>>         pq = kcalloc(FUSE_PQ_HASH_SIZE, sizeof(struct list_head), GFP_KERNEL);
>>>
>>> On the same note I guess we should also allocate pq on the
>>> corresponding numa node too.
>>
>> So this is supposed to be called from a thread that already runs on this
>> numa node and then kmalloc will allocate anyway on the right node,
>> afaik. Do you have a use case where this is called from another node? If
>> you do, all allocations in this file should be changed.
>>
> 
> I don't have a use case I'm using but imo it seems hardier to ensure
> this at the kernel level for queue, pq, and ent allocations instead of
> assuming userspace will always submit the registration from the thread
> on the numa node corresponding to the qid it's registering. I don't
> feel strongly about this though so if you think the responsibility
> should be left to userspace, then that's fine with me.
> 

What I basically mean is that these threads are going to send the
initial SQE, shouldn't it? Sounds a bit weird to me if the setup and
sending the registration SQE are from different threads than the later
handling. 


Thanks,
Bernd

