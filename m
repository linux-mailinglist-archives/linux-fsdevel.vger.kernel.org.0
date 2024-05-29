Return-Path: <linux-fsdevel+bounces-20497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB378D417D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 00:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8AC81F2389F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 22:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C272A178CEA;
	Wed, 29 May 2024 22:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="PJ33HDfE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99C5177991;
	Wed, 29 May 2024 22:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717022540; cv=none; b=WcHKCL8ZfcVTz0bYP969GrXuMpXGJ3eT39srrnhk7bRmsC/r447OF3Qh8GrlFLSQCy2686kPxi/sBBq/jd3NoMyHkXo6crq1TyBjHFfY2zKy5+SXPuLdBa8Gq6bCGP4c86QSGXX+3fyNYMOVihyrQq5Y5Gut9jsDnBVcVqFfFPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717022540; c=relaxed/simple;
	bh=OVpH2Iy+UNqNaSBm+18bef9LK4uwfGTVFbqySkhuG4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AfVTBBlJvWsrRwNI7KsE7Kb0p8CiwIx49MogYA2aAj0fOPoaRZrBCu3pPW0L2+UhYleA70b7o33LgBxnyPjjvZQnXyQBhzRjyrYxFt6GZTeDe5eG8STEHrdCzJU33bKUwVSEYyLl45YDzYtJjwBLNzWAf7BMFzL+FaOk+PhGqT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=PJ33HDfE; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VqPXB0kc4z6Cnk97;
	Wed, 29 May 2024 22:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717022525; x=1719614526; bh=wmqAutlJJibPd6rU+UVnuwTK
	NEx0bdku7UkT7t6UWI8=; b=PJ33HDfElBr6B2EjMPAfwGu7bE9RZoyBwrnjF5kb
	ldVDQ25YGiOYb3pvO+o2X4KwZcFOl2ybOFgIkCOc0Ovy3mSs/Qkku5fBtZSpDMAH
	mo9zWgWAO/CJ+wjKd7BKsK3R35ll6PbtNTvvc0E3qu33t6NW2oxmMmYoqJ0SyYV/
	CkMts1Kxkn0f77eR5bgC4+EQtVRK5DWNELILtuJUAh/9D3uk14Q74GoSmyK2dSs8
	ZCbwXv16vYl8xhRpUrE/FHWvAtX/lSM95PUP8DM2HTM46/7eMAE0O6yZP9PjEk+T
	mNqQ5EKt9zBW3jpgOkylLeHIVqfmpQAEVzpoWX4wuRTsHg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id b0OFq5KM274R; Wed, 29 May 2024 22:42:05 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VqPWk5M18z6Cnk94;
	Wed, 29 May 2024 22:41:54 +0000 (UTC)
Message-ID: <a866d5b5-5b01-44a2-9ccb-63bf30aa8a51@acm.org>
Date: Wed, 29 May 2024 15:41:51 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
To: Damien Le Moal <dlemoal@kernel.org>, Nitesh Shetty <nj.shetty@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, martin.petersen@oracle.com, david@fromorbit.com,
 hare@suse.de, damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
 joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520102842epcas5p4949334c2587a15b8adab2c913daa622f@epcas5p4.samsung.com>
 <20240520102033.9361-3-nj.shetty@samsung.com>
 <eda6c198-3a29-4da4-94db-305cfe28d3d6@acm.org>
 <20240529061736.rubnzwkkavgsgmie@nj.shetty@samsung.com>
 <9f1ec1c1-e1b8-48ac-b7ff-8efb806a1bc8@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <9f1ec1c1-e1b8-48ac-b7ff-8efb806a1bc8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/24 12:48 AM, Damien Le Moal wrote:
> On 5/29/24 15:17, Nitesh Shetty wrote:
>> On 24/05/24 01:33PM, Bart Van Assche wrote:
>>> On 5/20/24 03:20, Nitesh Shetty wrote:
>>>> We add two new opcode REQ_OP_COPY_DST, REQ_OP_COPY_SRC.
>>>> Since copy is a composite operation involving src and dst sectors/lba,
>>>> each needs to be represented by a separate bio to make it compatible
>>>> with device mapper.
>>>> We expect caller to take a plug and send bio with destination information,
>>>> followed by bio with source information.
>>>> Once the dst bio arrives we form a request and wait for source
>>>> bio. Upon arrival of source bio we merge these two bio's and send
>>>> corresponding request down to device driver.
>>>> Merging non copy offload bio is avoided by checking for copy specific
>>>> opcodes in merge function.
>>>
>>> In this patch I don't see any changes for blk_attempt_bio_merge(). Does
>>> this mean that combining REQ_OP_COPY_DST and REQ_OP_COPY_SRC will never
>>> happen if the QUEUE_FLAG_NOMERGES request queue flag has been set?
>>>
>> Yes, in this case copy won't work, as both src and dst bio reach driver
>> as part of separate requests.
>> We will add this as part of documentation.
> 
> So that means that 2 major SAS HBAs which set this flag (megaraid and mpt3sas)
> will not get support for copy offload ? Not ideal, by far.

QUEUE_FLAG_NOMERGES can also be set through sysfs (see also
queue_nomerges_store()). This is one of the reasons why using the merge
infrastructure for combining REQ_OP_COPY_DST and REQ_OP_COPY_SRC is
unacceptable.

Thanks,

Bart.

