Return-Path: <linux-fsdevel+bounces-40106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AEEA1C290
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 10:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14E7F1888A01
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 09:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36F11DB933;
	Sat, 25 Jan 2025 09:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="kf7+uh7+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Brocooic"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAC225A623
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jan 2025 09:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737798256; cv=none; b=KYrPH1WbVY/UaWzKOkq4agsaEEmnnHYaAdlAHbLnRDBhrxd1vEO1E74k3iQnQp+SlilLMtevehmoWRoAaK6y2HSucsKkq9lgZAKfeQkGCqeK8AmHusVWbQgjrJIIqxvpRhw64deGW+hpZiEG0HSbrUNGVL2bLB/eoM/ghmYQW84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737798256; c=relaxed/simple;
	bh=YQYEAyNvgIFSJCxnpIWX69nZQvwhicki96Bk1RMkZJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZ9Nf+zi5VS0j3BM8WuqCb0vsN0LTsDvzo0d4iws16/dKkIurz+XklDsX1E75oQkeOXCSOKxmt81nrmm8FrSDO6kN8G130QwitPQ6352zrgo0RdvdVEuZ5P/8XXHqGyokwfgmq0TIch0r5WNZ0MRHHs7HpHt8oZ7K7LHuwedo40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=kf7+uh7+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Brocooic; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 610B811400E6;
	Sat, 25 Jan 2025 04:44:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sat, 25 Jan 2025 04:44:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1737798252;
	 x=1737884652; bh=OOaujop1BS2PzLSde3XSjA0vJ37GDWoCYtVgZkFi9/8=; b=
	kf7+uh7+sMQGyzrnyM+sBnGzeMf1jdmXG7y9lS+5yBHohJcGjnnvBoPoHsYHd4U+
	oc/x1nVRZtVK42DMGwK+G4ZJWZyCA8EICHv01fZF0uXtsBxmUmJSNCalAzYxUtFp
	zfM6qFjl3vK36ciWKDQeeUDzz4QbFUQJ/W3DNT/RAWV9vQrGvQy5PcdV6kPCVNnS
	B66vAdpUky7+oxCwSX2HrbSikCSvOFRm39ZMdONVKe1vCO6OqQV5Fc70RxydsN3R
	L7b/MXjaWRMgG8z6cM08oT6ssdAPypP1jAlHpdsT4QtWCQ5aEm90gEh48ll4q1uB
	0sF1eEpxqelr43teJC+45g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737798252; x=
	1737884652; bh=OOaujop1BS2PzLSde3XSjA0vJ37GDWoCYtVgZkFi9/8=; b=B
	rocooicbtDfdxcLUNaWczWcN+DOBmtmDviMKr0oyHVXTvB59n+6oGgpQJ0KlXw4t
	GDOGDx0HGOQ/rb8Q7vjlUBfVkk5oWDWQMurb+hAngwg+coyyDtayuJLopYfQPaNW
	SJAuVKpqokZQRubqevyYBv0Fp3JHAPxZ+I/gb6vGXRglml7Ng8dkHCOIaly3WULS
	MeYD8rAAA661r49+wrO+scutEFz6J8pAyEQdk3/A7eGcgsCoKpm7kTCOtMwrpgGF
	0i19MixEdF+vNCSziVuo3/y0mKlFRgXvRlx3MYK8VAulRMepKec6yHxuuui7cm+A
	7McuykhWesWWOvpJdWPzw==
X-ME-Sender: <xms:a7KUZ_F0K-rVNHRA2hZZsOOFhjHtUSL2Lt8P6T3T91jgbans5STkMw>
    <xme:a7KUZ8Vss9MSYSrVgcdxbAuyv3fWfuqcIKQ9-yAzrYXwT8lzz-9VB__wwTqlkn1Xw
    nk6_NSK7pW5_MNi>
X-ME-Received: <xmr:a7KUZxKmGmpq4lf0lsQh5fKtygBTlbV9iutwPhvio673RggWwImhUTCA4386IJLnZbKC5Umd7cOFe3cyiBsejKHcZSt-BYZzBRzBFQ5b-SW44M2Ajor1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgjedtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugessghssggvrh
    hnugdrtghomheqnecuggftrfgrthhtvghrnhepfeeggeefffekudduleefheelleehgfff
    hedujedvgfetvedvtdefieehfeelgfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhorghnnhgvlh
    hkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghstghhuhgsvghrthesuggu
    nhdrtghomhdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpth
    htoheprghsmhhlrdhsihhlvghntggvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhu
    ihhssehighgrlhhirgdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:a7KUZ9FNCBj6HT96ZiPRHbOn6m-gRLMlMfU9NT51AqQsY7snarqLvA>
    <xmx:a7KUZ1WsYujv_rbYqBr7IqQaGdCT6OFGenXqjmYGlQjPrKnBgKxA9w>
    <xmx:a7KUZ4NaGq6llij1KfbvBWNVysw-nL4_urqODIXVFs9rLuQNU3ywbg>
    <xmx:a7KUZ03N60sUz0PjFI9ZZnuWklYmWne_QFxBYHgPaO6h8_W-RgG91A>
    <xmx:bLKUZ3L4k9THGWkQbauZfqvnUMDXLR0khopzul-88FuzNpojnLtumO33>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Jan 2025 04:44:10 -0500 (EST)
Message-ID: <e881b4bb-bf10-4855-8835-c6b8a52457cf@bsbernd.com>
Date: Sat, 25 Jan 2025 10:44:09 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] fuse: {io-uring} Use READ_ONCE in
 fuse_uring_send_in_task
To: Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
 Pavel Begunkov <asml.silence@gmail.com>, Luis Henriques <luis@igalia.com>,
 linux-fsdevel@vger.kernel.org
References: <20250124-optimize-fuse-uring-req-timeouts-v1-0-b834b5f32e85@ddn.com>
 <20250124-optimize-fuse-uring-req-timeouts-v1-1-b834b5f32e85@ddn.com>
 <CAJnrk1aDH0kPdXOrEh4=ApW4biNzOtkCKKT=57-T64=ZO1BEUg@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1aDH0kPdXOrEh4=ApW4biNzOtkCKKT=57-T64=ZO1BEUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/25/25 01:31, Joanne Koong wrote:
> On Fri, Jan 24, 2025 at 8:47 AM Bernd Schubert <bschubert@ddn.com> wrote:
>>
>> The value is read from another task without, while the task that
>> had set the value was holding queue->lock. Better use READ_ONCE
>> to ensure the compiler cannot optimize the read.
>>
>> Fixes: 284985711dc5 ("fuse: Allow to queue fg requests through io-uring")
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> ---
>>  fs/fuse/dev_uring.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>> index 5c9b5a5fb7f7539149840378e224eb640cf8ef08..1834c1933d2bbab0342257fde4b030f06506c55d 100644
>> --- a/fs/fuse/dev_uring.c
>> +++ b/fs/fuse/dev_uring.c
>> @@ -1202,10 +1202,12 @@ static void fuse_uring_send_in_task(struct io_uring_cmd *cmd,
>>  {
>>         struct fuse_ring_ent *ent = uring_cmd_to_ring_ent(cmd);
>>         struct fuse_ring_queue *queue = ent->queue;
>> +       struct fuse_req *req;
>>         int err;
>>
>>         if (!(issue_flags & IO_URING_F_TASK_DEAD)) {
>> -               err = fuse_uring_prepare_send(ent);
>> +               req = READ_ONCE(ent->fuse_req);
>> +               err = fuse_uring_prepare_send(ent, req);
> 
> Hi Bernd,  did you mean something like this?:
> 
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 5c9b5a5fb7f7..692e97f9870d 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -676,7 +676,7 @@ static int fuse_uring_copy_to_ring(struct
> fuse_ring_ent *ent,
> 
>  static int fuse_uring_prepare_send(struct fuse_ring_ent *ent)
>  {
> -       struct fuse_req *req = ent->fuse_req;
> +       struct fuse_req *req = READ_ONCE(ent->fuse_req);
>         int err;
> 
>         err = fuse_uring_copy_to_ring(ent, req);
> 
> I'm on top of the for-next tree but I'm not seeing where
> fuse_uring_prepare_send() takes in req as an arg.
> 
> 

Wrong order of patches. Initially it was all in one patch 
and I had split it up and was in a hurry - didn't test
compilation of individual patches. 


Thanks,
Bernd

