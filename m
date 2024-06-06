Return-Path: <linux-fsdevel+bounces-21116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 256DF8FF2C9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 18:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BBDA289FCC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 16:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64BA198A3E;
	Thu,  6 Jun 2024 16:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="4mA5ZvVo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D020C26AE7;
	Thu,  6 Jun 2024 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692314; cv=none; b=nhFggh9R68xTWBB0RZc/vmImZj2WrW4u0F8s3UK965bHXl7nPMmS9GxZzcu6AOyGfdHG9my8pR6+o+SmgZv4HNCcRyPL2dur6/7I5c+1dXrmcW0DA6fgHFQwnW0170TjTPFfIMQBJaLR7rs+JKOHe387LDSrwNTxrlUHFfQiW70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692314; c=relaxed/simple;
	bh=DVWoZ94Ms0F2PXMXl9M29RDWyH9n8ugMwEG4I+rMNwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ddNdLqWTEqhulc7JylpDcS5yqA3XeOlPBpoQeCNcHpRUKZz9peOgruATBcqTKXhEoumnjgaPGfqdN1B1YmBJdf59FRsSIPAHtf3mlgO2EV2Z2LwxBqSHwnoX1+niSq09vXktk2BIPSQeLrDMy0YaJHvBZ/ka5KDvmSedD3awoD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=4mA5ZvVo; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Vw9DS0Qyfz6Cnk9Y;
	Thu,  6 Jun 2024 16:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717692294; x=1720284295; bh=DVWoZ94Ms0F2PXMXl9M29RDW
	yH9n8ugMwEG4I+rMNwk=; b=4mA5ZvVohYkAsNlESeJ3jT48VdyeK8RVsj3ddKMP
	SOZ3qL+U8x9NM1ZGSjH50C5K8oZL02MYFmrM4LLS7LcN6Tnu5zK6VqD49X8s+/Wl
	Q2pqYqBgt3v5m6dNRXCT45LrvYm9WAfeX/gCjCm7WTRpeTMdmX5dtuAQmOOSWnbN
	hg557ukShq3D5vTZUmN6TJw6dClp7RzjuendtlKDt7Nc9zcakDR8XvWcguj3R4PG
	/Sit8qPBUqK5xyJbF0768vVr5bMJMJ09pr7q3k1PsWR5jsUvXJYgUG+4L0lkcnZJ
	KJVBRTo/nHq8gBaiIFh6kHDmcLWyOmgEpPd01gxx+e/Khg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id riXgj8xOY7Yj; Thu,  6 Jun 2024 16:44:54 +0000 (UTC)
Received: from [172.20.24.239] (unknown [204.98.150.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Vw9D15Xxtz6Cnk9X;
	Thu,  6 Jun 2024 16:44:49 +0000 (UTC)
Message-ID: <d4946174-32e1-47f0-b448-38377dae0600@acm.org>
Date: Thu, 6 Jun 2024 10:44:47 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 martin.petersen@oracle.com, david@fromorbit.com, hare@suse.de,
 damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com, joshi.k@samsung.com,
 nitheshshetty@gmail.com, gost.dev@samsung.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20240520102033.9361-3-nj.shetty@samsung.com>
 <eda6c198-3a29-4da4-94db-305cfe28d3d6@acm.org>
 <9f1ec1c1-e1b8-48ac-b7ff-8efb806a1bc8@kernel.org>
 <a866d5b5-5b01-44a2-9ccb-63bf30aa8a51@acm.org>
 <665850bd.050a0220.a5e6b.5b72SMTPIN_ADDED_BROKEN@mx.google.com>
 <abe8c209-d452-4fb5-90eb-f77b5ec1a2dc@acm.org> <20240601055931.GB5772@lst.de>
 <d7ae00c8-c038-4bed-937e-222251bc627a@acm.org>
 <20240604044042.GA29094@lst.de>
 <4ffad358-a3e6-4a88-9a40-b7e5d05aa53c@acm.org>
 <CGME20240606072827epcas5p285de8d4f3b0f6d3a87f8341414336b42@epcas5p2.samsung.com>
 <66618886.630a0220.4d4fc.1c9cSMTPIN_ADDED_BROKEN@mx.google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <66618886.630a0220.4d4fc.1c9cSMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 6/6/24 01:28, Nitesh Shetty wrote:
> On 04/06/24 04:44AM, Bart Van Assche wrote:
>> On 6/3/24 21:40, Christoph Hellwig wrote:
>>> There is no requirement to process them synchronously, there is just
>>> a requirement to preserve the order.=C2=A0 Note that my suggestion a =
few
>>> arounds ago also included a copy id to match them up.=C2=A0 If we don=
't
>>> need that I'm happy to leave it away.=C2=A0 If need it it to make sta=
cking
>>> drivers' lifes easier that suggestion still stands.
>>
>> Including an ID in REQ_OP_COPY_DST and REQ_OP_COPY_SRC operations soun=
ds
>> much better to me than abusing the merge infrastructure for combining
>> these two operations into a single request. With the ID-based approach
>> stacking drivers are allowed to process copy bios asynchronously and i=
t
>> is no longer necessary to activate merging for copy operations if
>> merging is disabled (QUEUE_FLAG_NOMERGES).
>>
> Single request, with bio merging approach:
> The current approach is to send a single request to driver,
> which contains both destination and source information inside separate =
bios.
> Do you have any different approach in mind ?

No. I did not propose to change how copy offload requests are sent to blo=
ck
drivers (other than stacking drivers).

> If we want to proceed with this single request based approach,
> we need to merge the destination request with source BIOs at some point=
.
> a. We chose to do it via plug approach.
> b. Alternative I see is scheduler merging, but here we need some way to
> hold the request which has destination info, until source bio is also
> submitted.
> c. Is there any other way, which I am missing here ?

There are already exceptions in blk_mq_submit_bio() for zoned writes and =
for
flush bios. Another exception could be added for REQ_OP_COPY_* bios. I'm =
not
claiming that this is the best possible alternative. I'm only mentioning =
this
to show that there are alternatives.

> Copy ID approach:
> We see 3 possibilities here:
> 1. No merging: If we include copy-id in src and dst bio, the bio's will=
 get
> submitted separately and reach to the driver as separate requests.
> How do we plan to form a copy command in driver ?
> 2. Merging BIOs:
> At some point we need to match the src bio with the dst bio and send th=
is
> information together to the driver. The current implementation.
> This still does not solve the asynchronous submission problem, mentione=
d
> above.
> 3. Chaining BIOs:
> This won't work with stacked devices as there will be cloning, and henc=
e
> chain won't be maintained.

I prefer option (2). Option (1) could result in a deadlock because the so=
urce
and destination bio both would have to be converted into a request before
these are sent to a request-based driver.

Thanks,

Bart.


