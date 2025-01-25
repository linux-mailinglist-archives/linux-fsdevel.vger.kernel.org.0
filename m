Return-Path: <linux-fsdevel+bounces-40107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EEDA1C294
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 10:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D26331688B2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 09:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86211DC745;
	Sat, 25 Jan 2025 09:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="mK0Y8mLE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pbDcDNAY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E6413C9B3
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jan 2025 09:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737798372; cv=none; b=AQD6s1wmOK039gCGnl96IU1svGipOOLsUYse7iG6a4QOW9GBWHufAvA0MNMDNIKy/XBIdIeJpWP+ueaBiV+ryhCdFKgHm7EPEpFzUECsEn4Km+UMtCg+iNhCZHyWTd4azclZn+IHGcfsrU23G1KIiK+Azoqov53vGqGOwaYlQ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737798372; c=relaxed/simple;
	bh=WmwLq0ekkuhi0wrOcfgdhuGg1QQz1iAw6r0wq8TK5Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XsihaQIwpAGko0zh6dJOYKINiBai3Vx/zpBzurgeqxB1OzIs/bmK8KTwwHNuki/53XgbZxFbjpHkST83BHMiIgozEjr23THsJ7giFIeeEHWpL3343O8W6Dy1bxvYLkL9b5jTxUjSKbeNTNNmnaqW7uw1DLMHYwwVbtLYpIsUtoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=mK0Y8mLE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pbDcDNAY; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 73650254011C;
	Sat, 25 Jan 2025 04:46:07 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 25 Jan 2025 04:46:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1737798367;
	 x=1737884767; bh=FBxnopgcKeyUnHJerWa1b8X0p25GdFAzSlTJ/sD5ipY=; b=
	mK0Y8mLEGfRvDyoF75hCf0aQ73qHc5Q4jaJxtmAH9ksGGG+G465DZgxBm+yXcGQd
	miJWIKOYrml6JNOSctC4nwI3P6AWuJMqWIMTBI6blwpZQ/f4u1CdYopJ4+NWLkbm
	sT0iUKpHOKRHOp2DnIXHuz9JPslMNgKasRsgvlcKKqnDT2pDGj/WtGefB21YkUAW
	QBgJgdQMrWz7XAF9Rrgg9tg82xNh38slx4baRfVf9mX9MuzU8F/7mI0G/5G9xZUB
	QYx6V2OFOT2sriJk8FWOv3WLlPWzMjzIGZvVWocEawv6tHZV6v+xaTfqLrEX0OQr
	3JKZ/BJB5IxPpVs71gPpDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737798367; x=
	1737884767; bh=FBxnopgcKeyUnHJerWa1b8X0p25GdFAzSlTJ/sD5ipY=; b=p
	bDcDNAYbmRHWKoeMlR4hUSB21O3rHdVRg4/8hBzDAmgnBjl1EUHxaSx4KJ+biKUN
	vctT4HkHY1Rd3lGx9K4rb3Tw14ZKKI0SffeZg8Fgn54O63Yp3omHbErSDN6UL2jX
	q6c0S3Z+6PSgUevrk+IdehHXx+5PjGh2NA8UuAN3pkwnUhmx9IpdADqC4PwB16/T
	/V3gRHVZG6UGJhYZZxKUNkHQwnYTnBC8XoLiTcHY1RQirQM5KSro3WCWhb+Wz34q
	T0P2E9sc2lmEkPlDW3oQea6ySlklCI3hT50Sr4qdKVsoalJiYR29IrJVYiU1uPBY
	XaCOxMri6Xqm6/5MoC2Nw==
X-ME-Sender: <xms:37KUZ6dQMCw2nO2u2S1HC7lYUBlW2uD0ZIkC1NLSJPqMTiOwhBOKfQ>
    <xme:37KUZ0N98qzEwRLrlMgaqHyBxpC4uyWCe6aNyI3Pc6UrdbPxLEwPAWmTnrianFKyp
    iBUQ3m3P6HnU5j3>
X-ME-Received: <xmr:37KUZ7jf7QrWqKtCiQdhSQGfdfmNX_NIou3A2Pkfzt40iqPPETwtfSkwS5WGY02VwPnwDXOo34VW--0Do3VQriBXR2F7cPMmPRyh42s4z68sa_VcMxGE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgjedtjecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:37KUZ3_9ynDCfZxhuLuKmxbQvLL6Ymnnwrq5FLEE6GZOJd9RaTH2GQ>
    <xmx:37KUZ2vNhXWnKLC_ZvjA-Ze9jDlr6onhHiIk_0uCY0HRR4mEZKtsEg>
    <xmx:37KUZ-E0EepqRzeT22BcyERFqNh9VDibcRBQNys75y9Zi1nzd2uqnQ>
    <xmx:37KUZ1M7324-gSa0jkNiDI5xXJ8YdBbrIUOYZ3KKczzbjXsMY5sAMA>
    <xmx:37KUZ6gt_29LYDF-AQSQB-ATJVH2wQK35tCmPe-ve4J4SN3zH5K8BdrT>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Jan 2025 04:46:06 -0500 (EST)
Message-ID: <d7e0d9a2-96dd-4800-af37-86e99ccd7187@bsbernd.com>
Date: Sat, 25 Jan 2025 10:46:05 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] fuse: {io-uring} Access entries with queue lock in
 fuse_uring_entry_teardown
To: Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
 Pavel Begunkov <asml.silence@gmail.com>, Luis Henriques <luis@igalia.com>,
 linux-fsdevel@vger.kernel.org
References: <20250124-optimize-fuse-uring-req-timeouts-v1-0-b834b5f32e85@ddn.com>
 <20250124-optimize-fuse-uring-req-timeouts-v1-2-b834b5f32e85@ddn.com>
 <CAJnrk1ZB0u6jb3=oReHex=C=f1chEQ0RdPu9LxG=o7OeAk1qGw@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1ZB0u6jb3=oReHex=C=f1chEQ0RdPu9LxG=o7OeAk1qGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/25/25 01:37, Joanne Koong wrote:
> On Fri, Jan 24, 2025 at 8:47 AM Bernd Schubert <bschubert@ddn.com> wrote:
>>
>> This ensures that ent->cmd and ent->fuse_req are accessed in
>> fuse_uring_entry_teardown while holding the queue lock.
>>
>> Fixes: a4bdb3d786c0 ("fuse: enable fuse-over-io-uring")
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> ---
>>  fs/fuse/dev_uring.c | 27 +++++++++++++++++++--------
>>  1 file changed, 19 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>> index 1834c1933d2bbab0342257fde4b030f06506c55d..87bb89994c311f435c370f78984be060fcb8036f 100644
>> --- a/fs/fuse/dev_uring.c
>> +++ b/fs/fuse/dev_uring.c
>> @@ -315,14 +315,20 @@ static void fuse_uring_stop_fuse_req_end(struct fuse_ring_ent *ent)
>>   */
>>  static void fuse_uring_entry_teardown(struct fuse_ring_ent *ent)
>>  {
>> -       struct fuse_ring_queue *queue = ent->queue;
>> -       if (ent->cmd) {
>> -               io_uring_cmd_done(ent->cmd, -ENOTCONN, 0, IO_URING_F_UNLOCKED);
>> -               ent->cmd = NULL;
>> -       }
>> +       struct fuse_req *req;
>> +       struct io_uring_cmd *cmd;
>>
>> -       if (ent->fuse_req)
>> -               fuse_uring_stop_fuse_req_end(ent);
>> +       struct fuse_ring_queue *queue = ent->queue;
>> +
>> +       spin_lock(&queue->lock);
>> +       ent->fuse_req = NULL;
>> +
>> +       req = ent->fuse_req;
> 
> I think you meant here to switch these two lines? otherwise i think
> req will alwyas be null here.
> 

Ah yes, thanks for spotting it, it is for extra safety, so bypassed my
basic testing.


Thanks,
Bernd

