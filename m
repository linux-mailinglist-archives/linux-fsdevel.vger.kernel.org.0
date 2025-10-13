Return-Path: <linux-fsdevel+bounces-64020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C811BD63D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 22:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F423F4F6BFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 20:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DE3309F03;
	Mon, 13 Oct 2025 20:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="kA5GN/dV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jc0sALQg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E88309EE6;
	Mon, 13 Oct 2025 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760388029; cv=none; b=Qs9mqQ3IomuN8sN4hcQff0POnOfdL2OIo5x1cidXf2rMQDMAbvZTaDwAIDL6Pd8C0gTL/hNEWS3eV7Wst7Ea7WXjxZpO8AEIXLmqg/5h4JQndgOdVSUJ2VZQ9sfYu1A9hJD5cAl2dVW6OkBPtpFg5xmcMffZFoxF9YLU+DEHG2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760388029; c=relaxed/simple;
	bh=SEcuW0g1fHV3FOuswFA2rCp0Rs0f3CmsRg0WLVV0msw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m41sCwF28ScrgNzZtsqhbPN/qhFqwk57lqDdF4jkgBPJF98bX6QUHFn5dNHa2tw3t+mWMekkSW/APAeiqptj77ZwyWjQbOyLjnIl4+GgTuBj0JUp+8wAMrgpDeu3ywPPrUcf75xa11ZwBaDbwCmuclIMAAAS1oRNBGI9QZuq36w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=kA5GN/dV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jc0sALQg; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 84E131D000B9;
	Mon, 13 Oct 2025 16:40:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 13 Oct 2025 16:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760388025;
	 x=1760474425; bh=1iExwgXKoBaPrErs1AXnNTPfeJ9+7thtk3Z9Gc3buPE=; b=
	kA5GN/dVYAJz8Y4F+SqKvTjLJol+4/7GDJ9ea6dJu1zkf3Dq6Bevcp+Siia7CbpT
	nDrCgsi7EXA3/gHApLX077TgNkPB5ZOl7+y06sZwQt54sPSv747f9cQ1RpqAwkZl
	mdL4zHM18nuRCeW3u3J4aEA5khhKvqj4Xmic9TqJhFe2NXOUE64CDoZAtUKUmfMY
	MPPt0l2TVsB6oQN30kB5M4hOGXFEPc0egNRivZoaXRTcYZe5KeJ6pDxhoZXJcVPa
	vt5It1Y9GvJsUf3gEbtbV0Q8i2sblf5DIMNgJR6wSYYKwnzXSjItPZfBq5Fz2a/e
	VSWUCXllUi+1kUQf9MnGMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760388025; x=
	1760474425; bh=1iExwgXKoBaPrErs1AXnNTPfeJ9+7thtk3Z9Gc3buPE=; b=J
	c0sALQgyLT2QR84ijePcWbYGEExTlSFdL8pk717gIi5ECUqOdJ2oFgQgn00T8fDR
	ocWhfEL7KNdlD7dzK7ebsOPntN7b2h2OMfWKhtqG5m06/O3G8t1lvn3fawOEhp6/
	ECcknq2okC4jdtp0dqDFGSvh0uNDFcXyB+ICaIBlWlAKZcNMIs7e3gxW5xGVy1Xn
	FDZWGdDU3AEDDWi8Gw7XvYknDB4wE8i8uWS7yFZV0ULm0ad7x3jhSC2HEaxdvnXh
	rKlaAYiir5Vw9JH6jVsOllRI3pezC5R0G/gP6Z9xYbkWobIzfAXda/Z+An8tzInu
	WHco5oD9U6gN8ScBIgClQ==
X-ME-Sender: <xms:uWPtaJ_B_AwUzDHo7CLRyBNhwCCeDnSrDFynEOs1f_sViP1lymLQGg>
    <xme:uWPtaHC6FOK05_vKw9dEd--WFKOvCQEjqhj2uJ-jCDRiAe1YUsI8mRi1HZ220QCf4
    f_QwWlh31fD1-Mg1QKljg8VDbRri6s4hQl1m_PhZTO6opqYmagm>
X-ME-Received: <xmr:uWPtaOTQCUgxnygJVBuyBxSx6VPaWFRukWbMtJMB-ulT6uZCOaYCkNi60RILsKGtenciGzuLMAaR7sgiSIgSph49qryvFvdT9K2JsPw3O0KhVkl8yEcs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudekieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpedtuedvueduledtudekhfeuleduudeijedvveevveetuddvfeeuvdekffej
    leeuueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdrtgho
    mhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjh
    horghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhikhhlohhs
    sehsiigvrhgvughirdhhuhdprhgtphhtthhopehgihhvvghmvgdrghhulhhusehgmhgrih
    hlrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegsfhhoshhtvghrsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:uWPtaOvnOlf49Zu-tHMexNBzsSzVXnsKAOM_U8fvTbyywkayFVmRBA>
    <xmx:uWPtaK1XHrVQw92u4zHAwlkuE0fZnMJ88gPMInfujAxOpSBrRZWaJg>
    <xmx:uWPtaPXG-ji-RaLpP9CUUHcOFKh8OnzzlOFUs4JiLd6v9pHntD9mXA>
    <xmx:uWPtaFKwplzQy4nrbqrZh7lwma7oiIKq_xbQ7yHSd8jabYStW5XGwQ>
    <xmx:uWPtaJUMTyYfvgd3PJdffGuT-Eb8_eWuDPZSkWUYp7xQzcaHmR4gWJVG>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 16:40:24 -0400 (EDT)
Message-ID: <54e30e4a-36c3-4775-a788-dc15e3558b9b@bsbernd.com>
Date: Mon, 13 Oct 2025 22:40:23 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, lu gu <giveme.gulu@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Brian Foster <bfoster@redhat.com>
References: <20251009110623.3115511-1-giveme.gulu@gmail.com>
 <CAJnrk1aZ4==a3-uoRhH=qDKA36-FE6GoaKDZB7HX3o9pKdibYA@mail.gmail.com>
 <CAFS-8+VcZn7WZgjV9pHz4c8DYHRdP0on6-er5fm9TZF9RAO0xQ@mail.gmail.com>
 <CAFS-8+V1QU8kCWV1eF3-SZtpQwWAuiSuKzCOwKKnEAjmz+rrmw@mail.gmail.com>
 <CAJfpegsFCsEgG74bMUH2rb=9-72rMGrHhFjWik2fV4335U0sCw@mail.gmail.com>
 <CAJfpegs85DzZjzyCNQ+Lh8R2cLDBG=GcMbEfr5PGSS531hxAeA@mail.gmail.com>
 <d82f3860-6964-4ad2-a917-97148782a76a@bsbernd.com>
 <CAJnrk1ZCXcM4iDq5bN6YVK75Q4udJNytVe2OpF3DmZ_FpuR7nA@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1ZCXcM4iDq5bN6YVK75Q4udJNytVe2OpF3DmZ_FpuR7nA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/13/25 22:27, Joanne Koong wrote:
> On Mon, Oct 13, 2025 at 1:16 PM Bernd Schubert <bernd@bsbernd.com> wrote:
>>
>> On 10/13/25 15:39, Miklos Szeredi wrote:
>>> On Fri, 10 Oct 2025 at 10:46, Miklos Szeredi <miklos@szeredi.hu> wrote:
>>>
>>>> My idea is to introduce FUSE_I_MTIME_UNSTABLE (which would work
>>>> similarly to FUSE_I_SIZE_UNSTABLE) and when fetching old_mtime, verify
>>>> that it hasn't been invalidated.  If old_mtime is invalid or if
>>>> FUSE_I_MTIME_UNSTABLE signals that a write is in progress, the page
>>>> cache is not invalidated.
>>>
>>> [Adding Brian Foster, the author of FUSE_AUTO_INVAL_DATA patches.
>>> Link to complete thread:
>>> https://lore.kernel.org/all/20251009110623.3115511-1-giveme.gulu@gmail.com/#r]
>>>
>>> In summary: auto_inval_data invalidates data cache even if the
>>> modification was done in a cache consistent manner (i.e. write
>>> through). This is not generally a consistency problem, because the
>>> backing file and the cache should be in sync.  The exception is when
>>> the writeback to the backing file hasn't yet finished and a getattr()
>>> call triggers invalidation (mtime change could be from a previous
>>> write), and the not yet written data is invalidated and replaced with
>>> stale data.
>>>
>>> The proposed fix was to exclude concurrent reads and writes to the same region.
>>>
>>> But the real issue here is that mtime changes triggered by this client
>>> should not cause data to be invalidated.  It's not only racy, but it's
>>> fundamentally wrong.  Unfortunately this is hard to do this correctly.
>>> Best I can come up with is that any request that expects mtime to be
>>> modified returns the mtime after the request has completed.
>>>
>>> This would be much easier to implement in the fuse server: perform the
>>> "file changed remotely" check when serving a FUSE_GETATTR request and
>>> return a flag indicating whether the data needs to be invalidated or
>>> not.
>>
>> For an intelligent server maybe, but let's say one uses
>> <libfuse>/example/passthrough*, in combination with some external writes
>> to the underlying file system outside of fuse. How would passthrough*
>> know about external changes?
>>
>> The part I don't understand yet is why invalidate_inode_pages2() causes
>> an issue - it has folio_wait_writeback()?
>>
> 
> This issue is for the writethrough path which doesn't use writeback.


Oh right. So we need some kind of fuse_invalidate_pages(), that would
wait for for all current fuse_send_write_pages() to complete? Is that
what you meant with 'fi->writectr bias'?

Thanks,
Bernd

