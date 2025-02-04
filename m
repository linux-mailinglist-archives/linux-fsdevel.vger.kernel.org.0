Return-Path: <linux-fsdevel+bounces-40822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D93A27D6B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 22:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3211886B44
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 21:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0966021A94F;
	Tue,  4 Feb 2025 21:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="HwedS1+e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GyOiulYj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CFD2036FD
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 21:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738704683; cv=none; b=n2ySYi24HO24lk59WLrLxqzEF75DzqFYKkc7p+GNqXJdiknSFHD+kz/sQcSeUVD6/FhH8I/LOyLc8ZlpHaMHbv9nvxAiuNmZmxAJG0dFFCvHDR4snN9YekSseEzg79tdslDSgNBp6BxWmoag8nQ28XZbBN6ZmslxtLx8ryKzNMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738704683; c=relaxed/simple;
	bh=aVRwtDzMU13GuNTmHyqWmR8PnjuwWSWQ9Oauy6YhoA0=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=QylPHrK8S4dVY+9MqA9yH7KWwtWY5/ruZdFLCLoF0LW94mUEM3eVdc5oY/fVJ26AmlMEt60oE1sRTLosf8xrnGiL24NVX3DwSapnoc2yBHJRuF+VjIQnhSxHw+KwTZax0VMYVr82bn5JU8FZBGkzEP32qmbj4YR1XzeihKhwKyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=HwedS1+e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GyOiulYj; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1B58A25400FB;
	Tue,  4 Feb 2025 16:31:19 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 04 Feb 2025 16:31:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738704678; x=1738791078; bh=7EJEcnhypQ
	R40RgN4ELn70s4N+Xm9c/ONSON/mQIj08=; b=HwedS1+e3A8bstndMZ7AkVR0zx
	njzFP8DJiQ+8rarvK8p5OxzElyDRJSseBy9lekzjClMLLlivkm24Ebw6R7JqAG8n
	GkxOssHMotciKdYfSP57+zhUvMxvD64Iby4V8/9Ce0vLiAnian6hduis04etWZHo
	wTkOpo0vv/tdPGLnshF843QTDCwkIddwQWoCTgHqp0gC/p1EwPzJkRuz2uzuFiHC
	Z7d9y7ny8SD02vDzYK+E6skq7l34/xkc+zSxWBV9w7cHwt13gSZASquESFVC9/2h
	Mkif5ATLYc945f9iHb3MoHYSswk313vOp0qLQLtZcp5YdDkwDMMQpCq/R8Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738704678; x=1738791078; bh=7EJEcnhypQR40RgN4ELn70s4N+Xm9c/ONSO
	N/mQIj08=; b=GyOiulYjgK6UcSHPJAyhEl/7n4NQFDJZVqOoxev6COkQ0Tv+3Ix
	4cIRi7m1dGAJZfEx6JphNmNm3hUSsopNokEDSn5r+Qwv7aI0OrYoNDna8Eo5c7DN
	LZVwldyJJidIXwxEv1DeUeehSf/Ccw6SRzgV4m8f0ZNVNEYnAYn3NxxooS8wbFhV
	yNNUko25oAZXAZOwFnLXVWLNgU2ByJPnOd+UQQ1hhQeoQIwOeiIr8HyojETD064a
	OikQbJ4LKca6yqVHrqNasFOQewGCmU9hzijx+Sz1YEoljxrhLr65IbV8Eo99MRl9
	eAqbnXOd/5K54ZcMXjyrDDpMX8pNhoF0Axw==
X-ME-Sender: <xms:JoeiZxM-2LWpc0v5Gi7ueAnnh47CWWDw6MxJz5OnUZScHtEsY5jVYQ>
    <xme:JoeiZz-cUbDrXvK5zGBN90fMrgoe3dvcr_npt4_QomKbXLIWYcFHvXaxwx7DChTFj
    UfUvM938YFlzT3b>
X-ME-Received: <xmr:JoeiZwR5lAgyGdsEwmfkqtqm71nZ5WcT6GzM9ZUQlqIiMor4SCOtXureLj6YIpfleCGtDHZx26vJSvaZUUPDfEwT5w4lPU-gUGI61QNdUH8KVKcOM6Xa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpegtkfffgggfuffhvfevfhgjsehmtderredtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepleelheevueelfedu
    tedvtdfgteetheduvdegueevjeefgfekheehiedvtdejkeegnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhht
    sehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgt
    phhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinhhugi
    dqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghr
    nhgvlhdqthgvrghmsehmvghtrgdrtghomh
X-ME-Proxy: <xmx:JoeiZ9uKhFj38h7MRL_OKM_SA_CA32xiXIvD3bSn_6XgNkAT-ulvLg>
    <xmx:JoeiZ5elV-20Sgb5RWW_IZFj1nQISyUPZ9meBTDCQB-U9L26505eUw>
    <xmx:JoeiZ53HMeeC04pMIrOQywRP9cZGF3EXBHPYjwK2sPvQGx82djtpPw>
    <xmx:JoeiZ1-d4sbphArr4zTuBo5EdaxaG58Rxx1pc4l-nXchwwtquYwcrw>
    <xmx:JoeiZw7ZoHel5Y5u0KUS2Jx4ENQyKV7dFamiYLF05EE2t3-6rJB0JUDB>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 16:31:17 -0500 (EST)
Content-Type: multipart/mixed; boundary="------------dZCoxxMHxiafGvjZ8HaOw7qL"
Message-ID: <e3da9d0c-39df-4994-91d2-a90b9ec7c627@fastmail.fm>
Date: Tue, 4 Feb 2025 22:31:16 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: clear FR_PENDING without holding fiq lock for uring
 requests
From: Bernd Schubert <bernd.schubert@fastmail.fm>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
References: <20250203185040.2365113-1-joannelkoong@gmail.com>
 <ff73c955-2267-4c77-8dca-0e4181d8e8b4@fastmail.fm>
 <CAJnrk1YfPU9qgaq=3KtO8dWxEqwpX-TJ-BD4vjUHsqtAqT859Q@mail.gmail.com>
 <74a5f0ea-e7dc-440b-82c6-5755dea98fa4@fastmail.fm>
 <CAJnrk1ZgHNb78dz-yfNTpxmW7wtT88A=m-zF0ZoLXKLUHRjNTw@mail.gmail.com>
 <bc801a5c-8150-4b6c-b7b6-b587d556d99b@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <bc801a5c-8150-4b6c-b7b6-b587d556d99b@fastmail.fm>

This is a multi-part message in MIME format.
--------------dZCoxxMHxiafGvjZ8HaOw7qL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/4/25 21:38, Bernd Schubert wrote:
> 
> 
> On 2/4/25 21:29, Joanne Koong wrote:
>> On Tue, Feb 4, 2025 at 12:00 PM Bernd Schubert
>> <bernd.schubert@fastmail.fm> wrote:
>>>
>>>
>>>
>>> On 2/4/25 20:26, Joanne Koong wrote:
>>>> Hi Bernd,
>>>>
>>>> On Tue, Feb 4, 2025 at 3:03 AM Bernd Schubert
>>>> <bernd.schubert@fastmail.fm> wrote:
>>>>>
>>>>> Hi Joanne,
>>>>>
>>>>> On 2/3/25 19:50, Joanne Koong wrote:
>>>>>> req->flags is set/tested/cleared atomically in fuse. When the FR_PENDING
>>>>>> bit is cleared from the request flags when assigning a request to a
>>>>>> uring entry, the fiq->lock does not need to be held.
>>>>>>
>>>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>>>>> Fixes: c090c8abae4b6 ("fuse: Add io-uring sqe commit and fetch support")
>>>>>> ---
>>>>>>  fs/fuse/dev_uring.c | 2 --
>>>>>>  1 file changed, 2 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>>>>>> index ab8c26042aa8..42389d3e7235 100644
>>>>>> --- a/fs/fuse/dev_uring.c
>>>>>> +++ b/fs/fuse/dev_uring.c
>>>>>> @@ -764,9 +764,7 @@ static void fuse_uring_add_req_to_ring_ent(struct fuse_ring_ent *ent,
>>>>>>                       ent->state);
>>>>>>       }
>>>>>>
>>>>>> -     spin_lock(&fiq->lock);
>>>>>>       clear_bit(FR_PENDING, &req->flags);
>>>>>> -     spin_unlock(&fiq->lock);
>>>>>>       ent->fuse_req = req;
>>>>>>       ent->state = FRRS_FUSE_REQ;
>>>>>>       list_move(&ent->list, &queue->ent_w_req_queue);
>>>>>
>>>>> I think that would have an issue in request_wait_answer(). Let's say
>>>>>
>>>>>
>>>>> task-A, request_wait_answer(),
>>>>>                 spin_lock(&fiq->lock);
>>>>>                 /* Request is not yet in userspace, bail out */
>>>>>                 if (test_bit(FR_PENDING, &req->flags)) {  // ========> if passed
>>>>>                         list_del(&req->list);  // --> removes from the list
>>>>>
>>>>> task-B,
>>>>> fuse_uring_add_req_to_ring_ent()
>>>>>         clear_bit(FR_PENDING, &req->flags);
>>>>>         ent->fuse_req = req;
>>>>>         ent->state = FRRS_FUSE_REQ;
>>>>>         list_move_tail(&ent->list, &queue->ent_w_req_queue);
>>>>>         fuse_uring_add_to_pq(ent, req);  // ==> Add to list
>>>>>
>>>>>
>>>>>
>>>>> What I mean is, task-A passes the if, but is then slower than task-B. I.e.
>>>>> task-B runs fuse_uring_add_to_pq() before task-B does the list_del.
>>>>>
>>>>
>>>> Is this race condition possible given that fiq->ops->send_req() is
>>>> called (and completed) before request_wait_answer() is called? The
>>>> path I see is this:
>>>>
>>>> __fuse_simple_request()
>>>>     __fuse_request_send()
>>>>         fuse_send_one()
>>>>             fiq->ops->send_req()
>>>>                   fuse_uring_queue_fuse_req()
>>>>                       fuse_uring_add_req_to_ring_ent()
>>>>                            clear FR_PENDING bit
>>>>                            fuse_uring_add_to_pq()
>>>>         request_wait_answer()
>>>>
>>>> It doesn't seem like task A can call request_wait_answer() while task
>>>> B is running fuse_uring_queue_fuse_req() on the same request while the
>>>> request still has the FR_PENDING bit set.
>>>>
>>>> This case of task A running request_wait_answer() while task B is
>>>> executing fuse_uring_add_req_to_ring_ent() can happen through
>>>> fuse_uring_commit_fetch() ->  fuse_uring_add_req_to_ring_ent(), but at
>>>> that point the FR_PENDING flag will have already been cleared on the
>>>> request, so this would bypass the "if (test_bit(FR_PENDING,...))"
>>>> check in request_wait_answer().
>>>
>>> I mean this case. I don't think FR_PENDING is cleared - why should it?
>>> And where? The request is pending state, waiting to get into 'FR_SENT'?
>>>
>>>>
>>>> Is there something I'm missing? I think if this race condition is
>>>> possible, then we also have a bigger problem where the request can be
>>>> freed out in this request_wait_answer() ->  if (test_bit(FR_PENDING,
>>>> &req->flags))...  case while fuse_uring_add_req_to_ring_ent() ->
>>>> fuse_uring_add_to_pq() dereferences it still.
>>>
>>> I don't think so, if we take the lock.
>>>
>>
>> the path I'm looking at is this:
>>
>> task A -
>> __fuse_simple_request()
>>     fuse_get_req() -> request is allocated (req refcount is 1)
>>     __fuse_request_send()
>>         __fuse_get_request() -> req refcount is 2
>>         fuse_send_one() -> req gets sent to uring
>>         request_wait_answer()
>>                ...
>>                hits the interrupt case, goes into "if
>> test_bit(FR_PENDING, ...)" case which calls __fuse_put_request(), req
>> refcount is now 1
>>     fuse_put_request() -> req refcount is dropped to 0, request is freed
>>
>> while in task B -
>> fuse_uring_commit_fetch()
>>     fuse_uring_next_fuse_req()
>>         fuse_uring_ent_assign_req()
>>             gets req off fuse_req_queue
>>             fuse_uring_add_req_to_ring_ent()
>>                  clear FR_PENDING
>>                  fuse_uring_add_to_pq()
>>                      dereferences req
>>
>> if task A hits the interrupt case in request_wait_answer() and then
>> calls fuse_put_request() before task B clears the pending flag (and
>> after it's gotten the request from the fuse_req_queue in
>> fuse_uring_ent_assign_req()), then I think we hit this case, no?
>>
> 
> Oh no, yes, you are right. It is a bit ugly to use fiq lock for list
> handling. I think I'm going to add uring handler for that to
> request_wait_answer. In general, basically request_wait_answer
> is currently operating on the wrong list - it assumes fiq, but that
> is not where the request it waiting on.

Please see the attached patch, I need to think about a way to test this
and will send out properly tomorrow. So far it is only basically
compilation tested.


Thanks,
Bernd

--------------dZCoxxMHxiafGvjZ8HaOw7qL
Content-Type: text/plain; charset=UTF-8; name="req-cancellation-race"
Content-Disposition: attachment; filename="req-cancellation-race"
Content-Transfer-Encoding: base64

ZnVzZToge2lvLXVyaW5nfSBGaXggYSBwb3NzaWJsZSByZXEgY2FuY2VsbGF0aW9uIHJhY2UK
CkZyb206IEJlcm5kIFNjaHViZXJ0IDxic2NodWJlcnRAZGRuLmNvbT4KCnRhc2stQSAoYXBw
bGljYXRpb24pIG1pZ2h0IGJlIGluIHJlcXVlc3Rfd2FpdF9hbnN3ZXIgYW5kCnRyeSB0byBy
ZW1vdmUgdGhlIHJlcXVlc3Qgd2hlbiBpdCBoYXMgRlJfUEVORElORyBzZXQuCgp0YXNrLUIg
KGEgZnVzZS1zZXJ2ZXIgaW8tdXJpbmcgdGFzaykgbWlnaHQgaGFuZGxlIHRoaXMKcmVxdWVz
dCB3aXRoIEZVU0VfSU9fVVJJTkdfQ01EX0NPTU1JVF9BTkRfRkVUQ0gsIHdoZW4KZmV0Y2hp
bmcgdGhlIG5leHQgcmVxdWVzdCBhbmQgYWNjZXNzZWQgdGhlIHJlcSBmcm9tCnRoZSBwZW5k
aW5nIGxpc3QgaW4gZnVzZV91cmluZ19lbnRfYXNzaWduX3JlcSgpLgpUaGF0IGNvZGUgcGF0
aCB3YXMgbm90IHByb3RlY3RlZCBieSBmaXEtPmxvY2sgYW5kIHNvCm1pZ2h0IHJhY2Ugd2l0
aCB0YXNrLUEuCgpGb3Igc2NhbGluZyByZWFzb25zIHdlIGJldHRlciBkb24ndCB1c2UgZmlx
LT5sb2NrLCBidXQKYWRkIGEgaGFuZGxlciB0byByZW1vdmUgY2FuY2VsZWQgcmVxdWVzdHMg
ZnJvbSB0aGUgcXVldWUuCgpGaXhlczogYzA5MGM4YWJhZTRiICgiZnVzZTogQWRkIGlvLXVy
aW5nIHNxZSBjb21taXQgYW5kIGZldGNoIHN1cHBvcnQiKQpSZXBvcnRlZC1ieTogSm9hbm5l
IEtvb25nIDxqb2FubmVsa29vbmdAZ21haWwuY29tPgpDbG9zZXM6IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2FsbC9DQUpucmsxWmdITmI3OGR6LXlmTlRweG1XN3d0VDg4QT1tLXpGMFpv
TFhLTFVIUmpOVHdAbWFpbC5nbWFpbC5jb20vClNpZ25lZC1vZmYtYnk6IEJlcm5kIFNjaHVi
ZXJ0IDxic2NodWJlcnRAZGRuLmNvbT4KCi0tCkNvbXBpbGF0aW9uIHRlc3RlZCBvbmx5Ci0t
LQogZnMvZnVzZS9kZXYuYyAgICAgICAgIHwgICAyNSArKysrKysrKysrKysrKysrLS0tLS0t
LS0tCiBmcy9mdXNlL2Rldl91cmluZy5jICAgfCAgIDI1ICsrKysrKysrKysrKysrKysrKysr
Ky0tLS0KIGZzL2Z1c2UvZGV2X3VyaW5nX2kuaCB8ICAgIDYgKysrKysrCiBmcy9mdXNlL2Z1
c2VfZGV2X2kuaCAgfCAgICAyICsrCiBmcy9mdXNlL2Z1c2VfaS5oICAgICAgfCAgICAyICsr
CiA1IGZpbGVzIGNoYW5nZWQsIDQ3IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2ZzL2Z1c2UvZGV2LmMgYi9mcy9mdXNlL2Rldi5jCmluZGV4IDgwYTEx
ZWY0YjY5YS4uMDQ5NGVhNDc4OTNhIDEwMDY0NAotLS0gYS9mcy9mdXNlL2Rldi5jCisrKyBi
L2ZzL2Z1c2UvZGV2LmMKQEAgLTE1Nyw3ICsxNTcsNyBAQCBzdGF0aWMgdm9pZCBfX2Z1c2Vf
Z2V0X3JlcXVlc3Qoc3RydWN0IGZ1c2VfcmVxICpyZXEpCiB9CiAKIC8qIE11c3QgYmUgY2Fs
bGVkIHdpdGggPiAxIHJlZmNvdW50ICovCi1zdGF0aWMgdm9pZCBfX2Z1c2VfcHV0X3JlcXVl
c3Qoc3RydWN0IGZ1c2VfcmVxICpyZXEpCit2b2lkIF9fZnVzZV9wdXRfcmVxdWVzdChzdHJ1
Y3QgZnVzZV9yZXEgKnJlcSkKIHsKIAlyZWZjb3VudF9kZWMoJnJlcS0+Y291bnQpOwogfQpA
QCAtNTI5LDE2ICs1MjksMjMgQEAgc3RhdGljIHZvaWQgcmVxdWVzdF93YWl0X2Fuc3dlcihz
dHJ1Y3QgZnVzZV9yZXEgKnJlcSkKIAkJaWYgKCFlcnIpCiAJCQlyZXR1cm47CiAKLQkJc3Bp
bl9sb2NrKCZmaXEtPmxvY2spOwotCQkvKiBSZXF1ZXN0IGlzIG5vdCB5ZXQgaW4gdXNlcnNw
YWNlLCBiYWlsIG91dCAqLwotCQlpZiAodGVzdF9iaXQoRlJfUEVORElORywgJnJlcS0+Zmxh
Z3MpKSB7Ci0JCQlsaXN0X2RlbCgmcmVxLT5saXN0KTsKKwkJaWYgKHRlc3RfYml0KEZSX1VS
SU5HLCAmcmVxLT5mbGFncykpIHsKKwkJCWJvb2wgcmVtb3ZlZCA9IGZ1c2VfdXJpbmdfcmVt
b3ZlX3BlbmRpbmdfcmVxKHJlcSk7CisKKwkJCWlmIChyZW1vdmVkKQorCQkJCXJldHVybjsK
KwkJfSBlbHNlIHsKKwkJCXNwaW5fbG9jaygmZmlxLT5sb2NrKTsKKwkJCS8qIFJlcXVlc3Qg
aXMgbm90IHlldCBpbiB1c2Vyc3BhY2UsIGJhaWwgb3V0ICovCisJCQlpZiAodGVzdF9iaXQo
RlJfUEVORElORywgJnJlcS0+ZmxhZ3MpKSB7CisJCQkJbGlzdF9kZWwoJnJlcS0+bGlzdCk7
CisJCQkJc3Bpbl91bmxvY2soJmZpcS0+bG9jayk7CisJCQkJX19mdXNlX3B1dF9yZXF1ZXN0
KHJlcSk7CisJCQkJcmVxLT5vdXQuaC5lcnJvciA9IC1FSU5UUjsKKwkJCQlyZXR1cm47CisJ
CQl9CiAJCQlzcGluX3VubG9jaygmZmlxLT5sb2NrKTsKLQkJCV9fZnVzZV9wdXRfcmVxdWVz
dChyZXEpOwotCQkJcmVxLT5vdXQuaC5lcnJvciA9IC1FSU5UUjsKLQkJCXJldHVybjsKIAkJ
fQotCQlzcGluX3VubG9jaygmZmlxLT5sb2NrKTsKIAl9CiAKIAkvKgpkaWZmIC0tZ2l0IGEv
ZnMvZnVzZS9kZXZfdXJpbmcuYyBiL2ZzL2Z1c2UvZGV2X3VyaW5nLmMKaW5kZXggMWUyYmNl
YjRmZjFlLi5mOWFiZGNmNWY3ZTYgMTAwNjQ0Ci0tLSBhL2ZzL2Z1c2UvZGV2X3VyaW5nLmMK
KysrIGIvZnMvZnVzZS9kZXZfdXJpbmcuYwpAQCAtNzcxLDggKzc3MSw2IEBAIHN0YXRpYyB2
b2lkIGZ1c2VfdXJpbmdfYWRkX3JlcV90b19yaW5nX2VudChzdHJ1Y3QgZnVzZV9yaW5nX2Vu
dCAqZW50LAogCQkJCQkgICBzdHJ1Y3QgZnVzZV9yZXEgKnJlcSkKIHsKIAlzdHJ1Y3QgZnVz
ZV9yaW5nX3F1ZXVlICpxdWV1ZSA9IGVudC0+cXVldWU7Ci0Jc3RydWN0IGZ1c2VfY29ubiAq
ZmMgPSByZXEtPmZtLT5mYzsKLQlzdHJ1Y3QgZnVzZV9pcXVldWUgKmZpcSA9ICZmYy0+aXE7
CiAKIAlsb2NrZGVwX2Fzc2VydF9oZWxkKCZxdWV1ZS0+bG9jayk7CiAKQEAgLTc4Miw5ICs3
ODAsNyBAQCBzdGF0aWMgdm9pZCBmdXNlX3VyaW5nX2FkZF9yZXFfdG9fcmluZ19lbnQoc3Ry
dWN0IGZ1c2VfcmluZ19lbnQgKmVudCwKIAkJCWVudC0+c3RhdGUpOwogCX0KIAotCXNwaW5f
bG9jaygmZmlxLT5sb2NrKTsKIAljbGVhcl9iaXQoRlJfUEVORElORywgJnJlcS0+ZmxhZ3Mp
OwotCXNwaW5fdW5sb2NrKCZmaXEtPmxvY2spOwogCWVudC0+ZnVzZV9yZXEgPSByZXE7CiAJ
ZW50LT5zdGF0ZSA9IEZSUlNfRlVTRV9SRVE7CiAJbGlzdF9tb3ZlX3RhaWwoJmVudC0+bGlz
dCwgJnF1ZXVlLT5lbnRfd19yZXFfcXVldWUpOwpAQCAtMTI4NSw2ICsxMjgxLDggQEAgdm9p
ZCBmdXNlX3VyaW5nX3F1ZXVlX2Z1c2VfcmVxKHN0cnVjdCBmdXNlX2lxdWV1ZSAqZmlxLCBz
dHJ1Y3QgZnVzZV9yZXEgKnJlcSkKIAlpZiAodW5saWtlbHkocXVldWUtPnN0b3BwZWQpKQog
CQlnb3RvIGVycl91bmxvY2s7CiAKKwlzZXRfYml0KEZSX1VSSU5HLCAmcmVxLT5mbGFncyk7
CisJcmVxLT5yaW5nX3F1ZXVlID0gcXVldWU7CiAJZW50ID0gbGlzdF9maXJzdF9lbnRyeV9v
cl9udWxsKCZxdWV1ZS0+ZW50X2F2YWlsX3F1ZXVlLAogCQkJCSAgICAgICBzdHJ1Y3QgZnVz
ZV9yaW5nX2VudCwgbGlzdCk7CiAJaWYgKGVudCkKQEAgLTEzMjMsNiArMTMyMSw4IEBAIGJv
b2wgZnVzZV91cmluZ19xdWV1ZV9icV9yZXEoc3RydWN0IGZ1c2VfcmVxICpyZXEpCiAJCXJl
dHVybiBmYWxzZTsKIAl9CiAKKwlzZXRfYml0KEZSX1VSSU5HLCAmcmVxLT5mbGFncyk7CisJ
cmVxLT5yaW5nX3F1ZXVlID0gcXVldWU7CiAJbGlzdF9hZGRfdGFpbCgmcmVxLT5saXN0LCAm
cXVldWUtPmZ1c2VfcmVxX2JnX3F1ZXVlKTsKIAogCWVudCA9IGxpc3RfZmlyc3RfZW50cnlf
b3JfbnVsbCgmcXVldWUtPmVudF9hdmFpbF9xdWV1ZSwKQEAgLTEzNTMsNiArMTM1MywyMyBA
QCBib29sIGZ1c2VfdXJpbmdfcXVldWVfYnFfcmVxKHN0cnVjdCBmdXNlX3JlcSAqcmVxKQog
CXJldHVybiB0cnVlOwogfQogCitib29sIGZ1c2VfdXJpbmdfcmVtb3ZlX3BlbmRpbmdfcmVx
KHN0cnVjdCBmdXNlX3JlcSAqcmVxKQoreworCXN0cnVjdCBmdXNlX3JpbmdfcXVldWUgKnF1
ZXVlID0gcmVxLT5yaW5nX3F1ZXVlOworCisJc3Bpbl9sb2NrKCZxdWV1ZS0+bG9jayk7CisJ
aWYgKHRlc3RfYml0KEZSX1BFTkRJTkcsICZyZXEtPmZsYWdzKSkgeworCQlsaXN0X2RlbCgm
cmVxLT5saXN0KTsKKwkJc3Bpbl91bmxvY2soJnF1ZXVlLT5sb2NrKTsKKwkJX19mdXNlX3B1
dF9yZXF1ZXN0KHJlcSk7CisJCXJlcS0+b3V0LmguZXJyb3IgPSAtRUlOVFI7CisJCXJldHVy
biB0cnVlOworCX0KKwlzcGluX3VubG9jaygmcXVldWUtPmxvY2spOworCisJcmV0dXJuIGZh
bHNlOworfQorCiBzdGF0aWMgY29uc3Qgc3RydWN0IGZ1c2VfaXF1ZXVlX29wcyBmdXNlX2lv
X3VyaW5nX29wcyA9IHsKIAkvKiBzaG91bGQgYmUgc2VuZCBvdmVyIGlvLXVyaW5nIGFzIGVu
aGFuY2VtZW50ICovCiAJLnNlbmRfZm9yZ2V0ID0gZnVzZV9kZXZfcXVldWVfZm9yZ2V0LApk
aWZmIC0tZ2l0IGEvZnMvZnVzZS9kZXZfdXJpbmdfaS5oIGIvZnMvZnVzZS9kZXZfdXJpbmdf
aS5oCmluZGV4IGEzNzk5MWQxN2QzNC4uODYwNzE3NTg2MjhmIDEwMDY0NAotLS0gYS9mcy9m
dXNlL2Rldl91cmluZ19pLmgKKysrIGIvZnMvZnVzZS9kZXZfdXJpbmdfaS5oCkBAIC0xNDMs
NiArMTQzLDcgQEAgaW50IGZ1c2VfdXJpbmdfY21kKHN0cnVjdCBpb191cmluZ19jbWQgKmNt
ZCwgdW5zaWduZWQgaW50IGlzc3VlX2ZsYWdzKTsKIHZvaWQgZnVzZV91cmluZ19xdWV1ZV9m
dXNlX3JlcShzdHJ1Y3QgZnVzZV9pcXVldWUgKmZpcSwgc3RydWN0IGZ1c2VfcmVxICpyZXEp
OwogYm9vbCBmdXNlX3VyaW5nX3F1ZXVlX2JxX3JlcShzdHJ1Y3QgZnVzZV9yZXEgKnJlcSk7
CiBib29sIGZ1c2VfdXJpbmdfcmVxdWVzdF9leHBpcmVkKHN0cnVjdCBmdXNlX2Nvbm4gKmZj
KTsKK2Jvb2wgZnVzZV91cmluZ19yZW1vdmVfcGVuZGluZ19yZXEoc3RydWN0IGZ1c2VfcmVx
ICpyZXEpOwogCiBzdGF0aWMgaW5saW5lIHZvaWQgZnVzZV91cmluZ19hYm9ydChzdHJ1Y3Qg
ZnVzZV9jb25uICpmYykKIHsKQEAgLTIwNiw2ICsyMDcsMTEgQEAgc3RhdGljIGlubGluZSBi
b29sIGZ1c2VfdXJpbmdfcmVxdWVzdF9leHBpcmVkKHN0cnVjdCBmdXNlX2Nvbm4gKmZjKQog
CXJldHVybiBmYWxzZTsKIH0KIAorc3RhdGljIGlubGluZSBib29sIGZ1c2VfdXJpbmdfcmVt
b3ZlX3BlbmRpbmdfcmVxKHN0cnVjdCBmdXNlX3JlcSAqcmVxKQoreworCXJldHVybiBmYWxz
ZTsKK30KKwogI2VuZGlmIC8qIENPTkZJR19GVVNFX0lPX1VSSU5HICovCiAKICNlbmRpZiAv
KiBfRlNfRlVTRV9ERVZfVVJJTkdfSV9IICovCmRpZmYgLS1naXQgYS9mcy9mdXNlL2Z1c2Vf
ZGV2X2kuaCBiL2ZzL2Z1c2UvZnVzZV9kZXZfaS5oCmluZGV4IDE5YzI5YzYwMDBhNy4uMzZi
OTA5MjA2MWVhIDEwMDY0NAotLS0gYS9mcy9mdXNlL2Z1c2VfZGV2X2kuaAorKysgYi9mcy9m
dXNlL2Z1c2VfZGV2X2kuaApAQCAtNDksNiArNDksOCBAQCBzdGF0aWMgaW5saW5lIHN0cnVj
dCBmdXNlX2RldiAqZnVzZV9nZXRfZGV2KHN0cnVjdCBmaWxlICpmaWxlKQogdW5zaWduZWQg
aW50IGZ1c2VfcmVxX2hhc2godTY0IHVuaXF1ZSk7CiBzdHJ1Y3QgZnVzZV9yZXEgKmZ1c2Vf
cmVxdWVzdF9maW5kKHN0cnVjdCBmdXNlX3BxdWV1ZSAqZnBxLCB1NjQgdW5pcXVlKTsKIAor
dm9pZCBfX2Z1c2VfcHV0X3JlcXVlc3Qoc3RydWN0IGZ1c2VfcmVxICpyZXEpOworCiB2b2lk
IGZ1c2VfZGV2X2VuZF9yZXF1ZXN0cyhzdHJ1Y3QgbGlzdF9oZWFkICpoZWFkKTsKIAogdm9p
ZCBmdXNlX2NvcHlfaW5pdChzdHJ1Y3QgZnVzZV9jb3B5X3N0YXRlICpjcywgaW50IHdyaXRl
LApkaWZmIC0tZ2l0IGEvZnMvZnVzZS9mdXNlX2kuaCBiL2ZzL2Z1c2UvZnVzZV9pLmgKaW5k
ZXggZGNjMWMzMjdhMDU3Li4yOWE3YTZlNTc1NzcgMTAwNjQ0Ci0tLSBhL2ZzL2Z1c2UvZnVz
ZV9pLmgKKysrIGIvZnMvZnVzZS9mdXNlX2kuaApAQCAtNDA4LDYgKzQwOCw3IEBAIGVudW0g
ZnVzZV9yZXFfZmxhZyB7CiAJRlJfRklOSVNIRUQsCiAJRlJfUFJJVkFURSwKIAlGUl9BU1lO
QywKKwlGUl9VUklORywKIH07CiAKIC8qKgpAQCAtNDU3LDYgKzQ1OCw3IEBAIHN0cnVjdCBm
dXNlX3JlcSB7CiAKICNpZmRlZiBDT05GSUdfRlVTRV9JT19VUklORwogCXZvaWQgKnJpbmdf
ZW50cnk7CisJdm9pZCAqcmluZ19xdWV1ZTsKICNlbmRpZgogCS8qKiBXaGVuIChpbiBqaWZm
aWVzKSB0aGUgcmVxdWVzdCB3YXMgY3JlYXRlZCAqLwogCXVuc2lnbmVkIGxvbmcgY3JlYXRl
X3RpbWU7Cg==

--------------dZCoxxMHxiafGvjZ8HaOw7qL--

