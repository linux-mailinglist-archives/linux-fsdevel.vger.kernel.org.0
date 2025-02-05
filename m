Return-Path: <linux-fsdevel+bounces-40930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60BFA2957E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 16:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E040F7A110A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 15:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9080A191493;
	Wed,  5 Feb 2025 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="mGAWG4mX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PiEwxWBc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D691922C4
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738771083; cv=none; b=Flr/SY1vqQWEXhy9/rXhd/GoFeZrysDdP7fN5Qwf9gUoFBFSEVN/58UycWU+zcG2CM/ynOuqcL1RvfCjNh3Bf5kkruW4dCKn7P6pSxtN5KyeyE8sijtuQviaELBsExXRdCTA0PQ9u8d2x1aLfmqYH/7YDF7ww1peIlPCYbJ3e8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738771083; c=relaxed/simple;
	bh=b81l2/0vuYTQGyyV9wjE37Y3vvlj44SjwOvFzYnBX7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZuImsSxFhLetTBikEG9Nn+8UVU0TVPBFvy4ai98t73miKRTFMpRmP6CXdtkNuGD54/O1OGOlnDf2rP9BJACXqwqRi1ST4B6CTwNY6uiJtPh/079WQwvFAbwDMNZXDbOrHUALLhr7N8IUPLpbGc7WgZCueuR3t8o6RywfgYTDg+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=mGAWG4mX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PiEwxWBc; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 376F311400E4;
	Wed,  5 Feb 2025 10:58:00 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 05 Feb 2025 10:58:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738771080;
	 x=1738857480; bh=t9gxvUdE1xTU4N9V6L0Erj/UAHlw7tm0TBOBYYSVRH0=; b=
	mGAWG4mXILJWhJsGS6Vv03eMg8IkWsYRdx2lVpSaJq+x6AlWxjDVV3h8BC6q3DDS
	kxZtycF2mTiDcSegBEOuCSqOilT955vF2+El8AGGaUFirww5XP+uT4P29ZxNScZJ
	nuOdXc4fDtERsEMV8Q9LIWWVZjh1fFkgoU5Zl1gfNmIiW5HEVJB/YVQNyeIl0YgN
	agaczEPoFk99IP5MPDcO4vDqFgRvfPCHzmmxzi6m/VaQFjCs3zBcbqS5CNE+FnUh
	TJEd4Ec9gTHAOVi4AejgcJqF6RGlgm3XbG1tO/muJ79+N3KkVfg+Ig9rM5R3f2UA
	GCOLvIGVnJXBc6zmKqBsaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738771080; x=
	1738857480; bh=t9gxvUdE1xTU4N9V6L0Erj/UAHlw7tm0TBOBYYSVRH0=; b=P
	iEwxWBcEl2RPyyAJzQFQorXh5WkPuYhtF0M9eL+HScUCeDYoQzgfa3W/xd3cLDsA
	0iHgj87rAFcDF1OBpqdKAMsyRLW4WzaZx/KpHSqfSSteN1ctaxMRMbkeTN34gG3k
	NxLRCfMPS1O16ybqbL3wrjTxU5BqnFOOiE7TeXx6p4PGXBHw0WMcnmqdRrBaadYR
	gqE1dBUzY2ThHU50Noa7IaWoIkNdbNqbbbLmDGyKw+k4aguzf20s51vnZBqUhTjr
	4scM0RJh4QDN6hAN+5lnWkNd/Xqa0hWCD3sXb5Rz8RbIgYI/UwmedPd4PukyjEyG
	mDFeupkqKl3rjMnZimDkw==
X-ME-Sender: <xms:h4qjZ6kXxDXra4V2xPRQ3lCIuYlku5sY-C6WCC_vuUNyQA_L1mtL2Q>
    <xme:h4qjZx0Fgrc1e-e_9UzvGOPkFtPpd5Maa197vxU8ZWY6pOSlEZQ8D74y1Y1h10g_D
    TaAgnYXXsGHXVOu>
X-ME-Received: <xmr:h4qjZ4qTEMd9cej9WM_MAYEbtxXbt9eEQ5jThEe2xSrDKmF9LyARixj629KH33pKEN6tBREkZLA5wZnT-T6GsM-JBDa7g15ZCSFqr5GC-3o4l1o8pTzZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeevgfeukedtfeeu
    gfekueeikeeileejheffjeehleduieefteeufefhteeuhefhfeenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhgrhiht
    ohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesgh
    hmrghilhdrtghomhdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhr
    tghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehmvghtrgdrtghomh
X-ME-Proxy: <xmx:h4qjZ-k5uJp8gVAFx-hx_VDGKGWoYN87PXhLw_e_ijJ0LMJnAjaiAQ>
    <xmx:h4qjZ43ChxEE-ZxCbKNoOZcG7_OhVuVHA5EkRJXNyZGTyIHu0Pfk6A>
    <xmx:h4qjZ1sge5DzxbDP8ccYFLpelcT8sgXt-8h40KWhoG5shNUo4HfkQQ>
    <xmx:h4qjZ0UaAFRS0fG3YL2bIqqJ1JqbfGIwcM_G1wO1hUPvnrf6tr4HtQ>
    <xmx:iIqjZ8_W3-i2QubD0M-HcyHc7SbvYjAYcWn5VqJXw3_1sMT91hkaWxrV>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 10:57:58 -0500 (EST)
Message-ID: <a4052199-92cf-4dd8-83cd-ebf4b54364e4@fastmail.fm>
Date: Wed, 5 Feb 2025 16:57:57 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: clear FR_PENDING without holding fiq lock for uring
 requests
To: Jeff Layton <jlayton@kernel.org>, Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
References: <20250203185040.2365113-1-joannelkoong@gmail.com>
 <ff73c955-2267-4c77-8dca-0e4181d8e8b4@fastmail.fm>
 <CAJnrk1YfPU9qgaq=3KtO8dWxEqwpX-TJ-BD4vjUHsqtAqT859Q@mail.gmail.com>
 <74a5f0ea-e7dc-440b-82c6-5755dea98fa4@fastmail.fm>
 <CAJnrk1ZgHNb78dz-yfNTpxmW7wtT88A=m-zF0ZoLXKLUHRjNTw@mail.gmail.com>
 <bc801a5c-8150-4b6c-b7b6-b587d556d99b@fastmail.fm>
 <e3da9d0c-39df-4994-91d2-a90b9ec7c627@fastmail.fm>
 <7822667d74f4cb748ff207857da9138887a19611.camel@kernel.org>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <7822667d74f4cb748ff207857da9138887a19611.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/5/25 16:53, Jeff Layton wrote:
> On Tue, 2025-02-04 at 22:31 +0100, Bernd Schubert wrote:
>> fuse: {io-uring} Fix a possible req cancellation race
>>
>> From: Bernd Schubert <bschubert@ddn.com>
>>
>> task-A (application) might be in request_wait_answer and
>> try to remove the request when it has FR_PENDING set.
>>
>> task-B (a fuse-server io-uring task) might handle this
>> request with FUSE_IO_URING_CMD_COMMIT_AND_FETCH, when
>> fetching the next request and accessed the req from
>> the pending list in fuse_uring_ent_assign_req().
>> That code path was not protected by fiq->lock and so
>> might race with task-A.
>>
>> For scaling reasons we better don't use fiq->lock, but
>> add a handler to remove canceled requests from the queue.
>>
>> Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
>> Reported-by: Joanne Koong <joannelkoong@gmail.com>
>> Closes: https://lore.kernel.org/all/CAJnrk1ZgHNb78dz-yfNTpxmW7wtT88A=m-zF0ZoLXKLUHRjNTw@mail.gmail.com/
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>>
>> --
>> Compilation tested only
>> ---
>>  fs/fuse/dev.c         |   25 ++++++++++++++++---------
>>  fs/fuse/dev_uring.c   |   25 +++++++++++++++++++++----
>>  fs/fuse/dev_uring_i.h |    6 ++++++
>>  fs/fuse/fuse_dev_i.h  |    2 ++
>>  fs/fuse/fuse_i.h      |    2 ++
>>  5 files changed, 47 insertions(+), 13 deletions(-)
>>
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index 80a11ef4b69a..0494ea47893a 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -157,7 +157,7 @@ static void __fuse_get_request(struct fuse_req *req)
>>  }
>>  
>>  /* Must be called with > 1 refcount */
>> -static void __fuse_put_request(struct fuse_req *req)
>> +void __fuse_put_request(struct fuse_req *req)
>>  {
>>  	refcount_dec(&req->count);
>>  }
>> @@ -529,16 +529,23 @@ static void request_wait_answer(struct fuse_req *req)
>>  		if (!err)
>>  			return;
>>  
>> -		spin_lock(&fiq->lock);
>> -		/* Request is not yet in userspace, bail out */
>> -		if (test_bit(FR_PENDING, &req->flags)) {
>> -			list_del(&req->list);
>> +		if (test_bit(FR_URING, &req->flags)) {
>> +			bool removed = fuse_uring_remove_pending_req(req);
>> +
>> +			if (removed)
>> +				return;
>> +		} else {
>> +			spin_lock(&fiq->lock);
>> +			/* Request is not yet in userspace, bail out */
>> +			if (test_bit(FR_PENDING, &req->flags)) {
>> +				list_del(&req->list);
>> +				spin_unlock(&fiq->lock);
>> +				__fuse_put_request(req);
>> +				req->out.h.error = -EINTR;
>> +				return;
>> +			}
> 
> One thing that bothers me with the existing code and this patch is that
> the semantics around FR_PENDING are unclear.
> 
> I know it's supposed to mean that the req is waiting for userland to
> read it, but in the above case for instance, we're removing it from the
> list and dropping its refcount while leaving the bit set. Shouldn't we
> clear it there and in fuse_uring_remove_pending_req()?
> 

Yeah, I think the assumption from the code is that the request is now
getting destructed, I will add in to clear FR_PENDING. 


Thanks,
Bernd

