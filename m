Return-Path: <linux-fsdevel+bounces-43357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D94ABA54C8F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 14:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65E98188E1BB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 13:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277D813AD18;
	Thu,  6 Mar 2025 13:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="W27ujb1n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n7Q2zuFY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835DB1304BA;
	Thu,  6 Mar 2025 13:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741268935; cv=none; b=VaRIOKjhmTN+KP6frFR7AdwlbtNYR5mdU+CFi51V3KMedApY+8xnLXD4DIflBby+6X0GwOQhTds8ZOSaDMnqlWJ8n5Q+4T4B10nmVb0i53+T7EnVVI1mPaF3DJKDu0JN97Dp1MpFYGSJrr2eZDB/L6Jl+v8v0zoKuY7O2Rx/ajY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741268935; c=relaxed/simple;
	bh=CSvJV5TZVr/Tdkwu9yG8y5g87lFrXmWjch0HkszAPHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMbyuVEGUG8L2VbjKOzqZL2zLOrhtKkokBW4QH+iRlizpV+Ti0Z7sZrQeAUKhjNqDwAcSR9I86gcM9YLNmh6ZnWv1jZo05VT52BZGh4vjPKpCbi6jYmPfrEtLqEvrNo5FLjL03ThQes3uWwObGGvIEJYSN33dj9D1ok/WoL5YKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=W27ujb1n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n7Q2zuFY; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 744E6138025C;
	Thu,  6 Mar 2025 08:48:51 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 06 Mar 2025 08:48:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741268931;
	 x=1741355331; bh=qHnoVwhDofD/+pHzdeYi8+pUZrNJoMBOM0bt/JqQaGY=; b=
	W27ujb1nP0GhTrMG6Xcwva/eaHJ80Fkm5z2HxDCoI0TS2vFU9Gh/gXlaDy1nyrAo
	bPYezGd8X/eOr5LZUejGeBhM93g5hOmDfGKG91KfZk1ZE3+YbkPbMgNxnHNRWf0O
	ParlRqKhasRGPcFM08NklZA1qsrwRd1a8LguorHBtuzR5DKhf+YpSwxwkEivNJW+
	aAfSdY7WZVeXuzjq+5O2Ue4sV4y8PVkf7xIbwk3YY0qAiYZVsfS/T9ntcAeLDQEy
	IGudHGflEnv4LjX0kJmbO1qvSDMDUji2ymhPB8C5lZ6d7idlPLZx5//M4FAYyQZY
	UydNYFnx/wtjgWzIRMR8mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741268931; x=
	1741355331; bh=qHnoVwhDofD/+pHzdeYi8+pUZrNJoMBOM0bt/JqQaGY=; b=n
	7Q2zuFYFmVxyqsiG2AGNMkAoyAXmxCrej/YF3vDb4p7FcCRLwIFqZ9CmRSXwCVwv
	ShDiAkxOjXhAHeFpUXaM7CpBgAqaEuUMxFV0AajZFpMcjFj1QO7sB8Ju1jI0u8J/
	Pe3izz7VAbK/H4AO93uUipDnB87jGCOuJSGRjypwakZ4c49SJgq2Oxz01unP/Wqg
	RFqHmhv98t18yHKBnd9B2pNR4b9kEyYVjNKKI868Cv4PmAo+wpuK6Vi41YWvxgO2
	sC1fGEUaAKD6gSnVZCI44qdMWr2hVp94LD3RLlJkAbroXCbN/V0fankV4P7Ogm94
	YKzadrAWZEOXUhF1bvkmg==
X-ME-Sender: <xms:wqfJZ-Gb2C7NC0REXpgeI2WTPWKOvqnTtEFAu-h6dPErWdwWFS2EBg>
    <xme:wqfJZ_WgqKcMSowOQiqGEv_URmSihLVWYcVIADHGMkc1o-JqeEoYXsEBDVlspcRC8
    Siw61SZyPPfvPJY>
X-ME-Received: <xmr:wqfJZ4L-pLJt2T6ho5_eTbagd54ejqFohUXX8cTj1qMSnkf2xWBFww7sDLObp9m4aw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdejleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvg
    hrnhgurdgtohhmqeenucggtffrrghtthgvrhhnpeehhfejueejleehtdehteefvdfgtdel
    ffeuudejhfehgedufedvhfehueevudeugeenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggp
    rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehluhhishesih
    hgrghlihgrrdgtohhmpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdp
    rhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepkhgvrhhnvghlqdguvghvsehighgrlhhirgdrtghomh
X-ME-Proxy: <xmx:wqfJZ4GVpO0ydRhvWGj2riORkw_lIgS1z-CmpACDT_3C8DdcWlCS7w>
    <xmx:wqfJZ0VSlfqGuEMUh09K6ce69DD-ABQvpLMG27X6tsZZzyJK4m9-yQ>
    <xmx:wqfJZ7OhAAiz471IDfReuxnlHTeTel_Go7VF-rEaVcMMAdpfGACB9Q>
    <xmx:wqfJZ708Lbd_1eZBHgffP224KEjwKhprDClx8cjx3mqZ22OA4ZOhTQ>
    <xmx:w6fJZ-feyBtwDmq3OwOPEis2uKMUsQeZho1tvE1Xlg5EFarNvQs3QckK>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 08:48:49 -0500 (EST)
Message-ID: <e3ccbd42-4178-4bc4-ba13-477d1f121868@bsbernd.com>
Date: Thu, 6 Mar 2025 14:48:47 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: fix possible deadlock if rings are never
 initialized
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
References: <20250306111218.13734-1-luis@igalia.com>
 <1dc28f9d-c453-42f4-8edb-1d5c8084d576@bsbernd.com>
 <87bjue2tbh.fsf@igalia.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US
In-Reply-To: <87bjue2tbh.fsf@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/6/25 14:16, Luis Henriques wrote:
> On Thu, Mar 06 2025, Bernd Schubert wrote:
> 
>> On 3/6/25 12:12, Luis Henriques wrote:
>>> When mounting a user-space filesystem using io_uring, the initialization
>>> of the rings is done separately in the server side.  If for some reason
>>> (e.g. a server bug) this step is not performed it will be impossible to
>>> unmount the filesystem if there are already requests waiting.
>>>
>>> This issue is easily reproduced with the libfuse passthrough_ll example,
>>> if the queue depth is set to '0' and a request is queued before trying to
>>> unmount the filesystem.  When trying to force the unmount, fuse_abort_conn()
>>> will try to wake up all tasks waiting in fc->blocked_waitq, but because the
>>> rings were never initialized, fuse_uring_ready() will never return 'true'.
>>>
>>> Fixes: 3393ff964e0f ("fuse: block request allocation until io-uring init is complete")
>>> Signed-off-by: Luis Henriques <luis@igalia.com>
>>> ---
>>>   fs/fuse/dev.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>>> index 7edceecedfa5..2fe565e9b403 100644
>>> --- a/fs/fuse/dev.c
>>> +++ b/fs/fuse/dev.c
>>> @@ -77,7 +77,7 @@ void fuse_set_initialized(struct fuse_conn *fc)
>>>   static bool fuse_block_alloc(struct fuse_conn *fc, bool for_background)
>>>   {
>>>   	return !fc->initialized || (for_background && fc->blocked) ||
>>> -	       (fc->io_uring && !fuse_uring_ready(fc));
>>> +	       (fc->io_uring && fc->connected && !fuse_uring_ready(fc));
>>>   }
>>>   
>>>   static void fuse_drop_waiting(struct fuse_conn *fc)
>>>
>>
>> Oh yes, I had missed that.
>>
>> Reviewed-by: Bernd Schubert <bschubert@ddn.com>
> 
> Thanks!  And... by the way, Bernd:
> 
> I know io_uring support in libfuse isn't ready yet, but I think there's
> some error handling missing in your uring branch.  In particular, the
> return of fuse_uring_start() is never checked, and thus if the rings
> initialization fails, the server will not get any error.
> 
> I found that out because I blindly tried the patch below, and I was
> surprised that the server was started just fine.

Thank you! I will work a bit on splitting the uring branch into 
merge-able patches later today, but probably won't finish today (too 
many other things to do).


Thanks,
Bernd

