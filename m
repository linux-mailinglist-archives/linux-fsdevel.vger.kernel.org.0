Return-Path: <linux-fsdevel+bounces-40812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E98AA27C51
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 21:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0433A1A09
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 20:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3051E9B27;
	Tue,  4 Feb 2025 20:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="cNVZCoOc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BBp5yoDA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595871754B
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 20:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699252; cv=none; b=RT6EVgUJ8ua3I43PpHIhEBexxSCRlQsOYCBLX3mpskKby8OUuTxiOJQlxKkpNhY+b7+vBUVIR+DMj+Ymsg8HCwX8XiNzMMJPkmv4+r6eZ6HZj80Y/DHKxHdpIeXAC2wu6v5JGyVFLJUBY1FAIGrDwRejZruKjicz4DijUmL9sM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699252; c=relaxed/simple;
	bh=AyjCn81CqYWu6OfaucR3FZy9c92F2pmmMyo1iklNOgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VxQHcxKODum7uZmSg2naxBe33ncb0ZS9Pem2nP8ppY+zQZ5d3N9AtdpKsfRzWMyo+6mJU0rlQSAHfS1GMB5h03M1rGglKDvThC4eDG0q0EMTHUX9+Y48ofeaRki77DsGEv7tHQFnGL3BECFU9hk9VVcHSNiow75FuhxE1X9V3gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=cNVZCoOc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BBp5yoDA; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 584331140196;
	Tue,  4 Feb 2025 15:00:49 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 04 Feb 2025 15:00:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738699249;
	 x=1738785649; bh=Mf8eSCWq6vik5fiBF18sZdHW69sx56u49fD7bmLTSwg=; b=
	cNVZCoOc3Kp5ewlfrIHoJPK6j/bJ2aNhZFoR4i3lEeuNo6JZY6W1BsmFujr2YqYs
	b/Q259iGzYiVF7KdxjrfBNf5EEiVQZKHmEc2pPomkDYaqiuab/QTw3hXvUn9LUU/
	tgjYqmNxDbO005IN8JopOFjsVuo5DIRVByoNJNQDH0ptvRGUNfYxVIlJqIUHtCP6
	jP34d8/SWjlERnAF2K1McrrsC/fpuGWKOJ5PwH18soa6E8ITi6Rq1F8y1EZnDtJN
	MsR5XKDCoRbqn3rr5z9tnrwXbeoI3kdMKpR+GM/BR65UKKdX8LWH/eHVlYV3fBIB
	i9cWc0pJzTFAkxroEt/jSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738699249; x=
	1738785649; bh=Mf8eSCWq6vik5fiBF18sZdHW69sx56u49fD7bmLTSwg=; b=B
	Bp5yoDAhCBX0uY3q4p9QUMquoOxfN56+cMUpna7RT4GBPV/p7nyxGrlfCox7uZKN
	AWdsVPJyi+GxqusR894G2kQKSB9b0xnZK+6vkNgfNfkfj8wdWFP1cRUcytxxIhS6
	dS15g1ke030eadtUd8iFe1VLuTYC8NX8NAtb4wd9psUA7ofqNlWeICzGIwgO6jIO
	QKAMkvxBBCpFZviq+3kRJZ9a1jjs+clPtnhv4h5aErX9sBkjOAIYFtJ7pDUDsuIt
	FeNyMJCcKQfTEszq5v1tSIcPtvTBzVw+zhrBEMgoxqXaf+CzT8uASZAow3AsPZ66
	f1kxCSFCXV/X8Fi6I05RA==
X-ME-Sender: <xms:8HGiZ_NLodOWxUXPcPfnanHBqFRuHvgOAVndOrM5EbRawwQ0fQRVEg>
    <xme:8HGiZ5_E4ws1JVtsb3-VfACvezKAO8UXR_Om_Ju30SfcqA7fHfJ8CUnV3iW4RxPeb
    cdCtYmgrvc9YCSu>
X-ME-Received: <xmr:8HGiZ-Tplc5xDFp7rS3e95HGdX4km7guOyW8Son8sHR6KJ0mn0sd4j_KTRvJn-p1N4fEG98xFpfbhfig911XPuB9MybDV77maEuBUZAC2P3N5wBUhB-H>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeduleefvdduvedu
    veelgeelffffkedukeegveelgfekleeuvdehkeehheehkefhfeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehlihhnuh
    igqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgv
    rhhnvghlqdhtvggrmhesmhgvthgrrdgtohhm
X-ME-Proxy: <xmx:8HGiZzvaCkGdRO6CcYG7gIoEWowaSPjLN0swrIEA-GaUgY_O15Q9ig>
    <xmx:8HGiZ3exVwZJEVJvhO3QhClRBDPc_RUIr4bGmo298CKUF1GlAmmCZA>
    <xmx:8HGiZ_0VYsk9swKAaV6vaj_Ef8iGqp9ipB_n9VnRgd6fiA-o-bk5Dg>
    <xmx:8HGiZz88XvzRUy8I1C5-tN5zYsCPq2jjpDtBJoVbLzIo4GRIDwnxAw>
    <xmx:8XGiZ-5znTo-zmFQPh-NBkUwVp-KoBuM8J5_1-BAMgUTidkT30A2Ehyq>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 15:00:47 -0500 (EST)
Message-ID: <74a5f0ea-e7dc-440b-82c6-5755dea98fa4@fastmail.fm>
Date: Tue, 4 Feb 2025 21:00:46 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: clear FR_PENDING without holding fiq lock for uring
 requests
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
References: <20250203185040.2365113-1-joannelkoong@gmail.com>
 <ff73c955-2267-4c77-8dca-0e4181d8e8b4@fastmail.fm>
 <CAJnrk1YfPU9qgaq=3KtO8dWxEqwpX-TJ-BD4vjUHsqtAqT859Q@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1YfPU9qgaq=3KtO8dWxEqwpX-TJ-BD4vjUHsqtAqT859Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/4/25 20:26, Joanne Koong wrote:
> Hi Bernd,
> 
> On Tue, Feb 4, 2025 at 3:03 AM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>
>> Hi Joanne,
>>
>> On 2/3/25 19:50, Joanne Koong wrote:
>>> req->flags is set/tested/cleared atomically in fuse. When the FR_PENDING
>>> bit is cleared from the request flags when assigning a request to a
>>> uring entry, the fiq->lock does not need to be held.
>>>
>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>> Fixes: c090c8abae4b6 ("fuse: Add io-uring sqe commit and fetch support")
>>> ---
>>>  fs/fuse/dev_uring.c | 2 --
>>>  1 file changed, 2 deletions(-)
>>>
>>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>>> index ab8c26042aa8..42389d3e7235 100644
>>> --- a/fs/fuse/dev_uring.c
>>> +++ b/fs/fuse/dev_uring.c
>>> @@ -764,9 +764,7 @@ static void fuse_uring_add_req_to_ring_ent(struct fuse_ring_ent *ent,
>>>                       ent->state);
>>>       }
>>>
>>> -     spin_lock(&fiq->lock);
>>>       clear_bit(FR_PENDING, &req->flags);
>>> -     spin_unlock(&fiq->lock);
>>>       ent->fuse_req = req;
>>>       ent->state = FRRS_FUSE_REQ;
>>>       list_move(&ent->list, &queue->ent_w_req_queue);
>>
>> I think that would have an issue in request_wait_answer(). Let's say
>>
>>
>> task-A, request_wait_answer(),
>>                 spin_lock(&fiq->lock);
>>                 /* Request is not yet in userspace, bail out */
>>                 if (test_bit(FR_PENDING, &req->flags)) {  // ========> if passed
>>                         list_del(&req->list);  // --> removes from the list
>>
>> task-B,
>> fuse_uring_add_req_to_ring_ent()
>>         clear_bit(FR_PENDING, &req->flags);
>>         ent->fuse_req = req;
>>         ent->state = FRRS_FUSE_REQ;
>>         list_move_tail(&ent->list, &queue->ent_w_req_queue);
>>         fuse_uring_add_to_pq(ent, req);  // ==> Add to list
>>
>>
>>
>> What I mean is, task-A passes the if, but is then slower than task-B. I.e.
>> task-B runs fuse_uring_add_to_pq() before task-B does the list_del.
>>
> 
> Is this race condition possible given that fiq->ops->send_req() is
> called (and completed) before request_wait_answer() is called? The
> path I see is this:
> 
> __fuse_simple_request()
>     __fuse_request_send()
>         fuse_send_one()
>             fiq->ops->send_req()
>                   fuse_uring_queue_fuse_req()
>                       fuse_uring_add_req_to_ring_ent()
>                            clear FR_PENDING bit
>                            fuse_uring_add_to_pq()
>         request_wait_answer()
> 
> It doesn't seem like task A can call request_wait_answer() while task
> B is running fuse_uring_queue_fuse_req() on the same request while the
> request still has the FR_PENDING bit set.
> 
> This case of task A running request_wait_answer() while task B is
> executing fuse_uring_add_req_to_ring_ent() can happen through
> fuse_uring_commit_fetch() ->  fuse_uring_add_req_to_ring_ent(), but at
> that point the FR_PENDING flag will have already been cleared on the
> request, so this would bypass the "if (test_bit(FR_PENDING,...))"
> check in request_wait_answer().

I mean this case. I don't think FR_PENDING is cleared - why should it?
And where? The request is pending state, waiting to get into 'FR_SENT'?

> 
> Is there something I'm missing? I think if this race condition is
> possible, then we also have a bigger problem where the request can be
> freed out in this request_wait_answer() ->  if (test_bit(FR_PENDING,
> &req->flags))...  case while fuse_uring_add_req_to_ring_ent() ->
> fuse_uring_add_to_pq() dereferences it still.

I don't think so, if we take the lock.


Thanks,
Bernd


