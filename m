Return-Path: <linux-fsdevel+bounces-146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCF47C6204
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 03:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE7D12826E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 01:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A909655;
	Thu, 12 Oct 2023 01:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzaS5dJ7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D4D62F
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 01:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1D2C433C9;
	Thu, 12 Oct 2023 01:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697072531;
	bh=yiANFDzQ62tB7ZkTAR1ls+F1QryoZ0mK2oO/chRVDKc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LzaS5dJ7h/XH5ZlVAyfzW8tJV0oac+mUEfgPA4MglhzYbSXfl6RTXqW+3/J00LLWT
	 23KhwKXyC1Y3PB6aed2SZlawoNnVe+mS5pUdD42qbP4Tl93F4uZeA9LipGne+MIawl
	 U3FLobkG5w62P+lEB/hJcrfgOuM4d2Qjm518lGkVV7SR3lUYm6m1i2RynsP38EdkXt
	 tqi1GYh4/ijxvaS+t+0/zKR9TMqnFt48zhco/vkFCJWfNdXU86dAcuqXmHokeT3xyX
	 ZEs3RaMSYFXByh7aW2oDA1xSDe7ANv9q3C3T33jsgjjatuB5miyDF8r6uzKD2eYkgC
	 V1ixt/Dc3xZZw==
Message-ID: <447f3095-66cb-417b-b48c-90005d37b5d3@kernel.org>
Date: Thu, 12 Oct 2023 10:02:07 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] block: Support data lifetime in the I/O priority
 bitfield
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Avri Altman <Avri.Altman@wdc.com>, Bean Huo <huobean@gmail.com>,
 Daejun Park <daejun7.park@samsung.com>, Hannes Reinecke <hare@suse.de>
References: <20231005194129.1882245-1-bvanassche@acm.org>
 <20231005194129.1882245-4-bvanassche@acm.org>
 <8aec03bb-4cef-9423-0ce4-c10d060afce4@kernel.org>
 <46c17c1b-29be-41a3-b799-79163851f972@acm.org>
 <b0b015bf-0a27-4e89-950a-597b9fed20fb@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <b0b015bf-0a27-4e89-950a-597b9fed20fb@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/12/23 05:51, Bart Van Assche wrote:
> On 10/6/23 11:07, Bart Van Assche wrote:
>> On 10/6/23 01:19, Damien Le Moal wrote:
>>> Your change seem to assume that it makes sense to be able to combine CDL with
>>> lifetime hints. But does it really ? CDL is of dubious value for solid state
>>> media and as far as I know, UFS world has not expressed interest. Conversely,
>>> data lifetime hints do not make much sense for spin rust media where CDL is
>>> important. So I would say that the combination of CDL and lifetime hints is of
>>> dubious value.
>>>
>>> Given this, why not simply define the 64 possible lifetime values as plain hint
>>> values (8 to 71, following 1 to 7 for CDL) ?
>>>
>>> The other question here if you really want to keep the bit separation approach
>>> is: do we really need up to 64 different lifetime hints ? While the scsi
>>> standard allows that much, does this many different lifetime make sense in
>>> practice ? Can we ever think of a usecase that needs more than say 8 different
>>> liftimes (3 bits) ? If you limit the number of possible lifetime hints to 8,
>>> then we can keep 4 bits unused in the hint field for future features.
>>
>> Hi Damien,
>>
>> Not supporting CDL for solid state media and supporting eight different
>> lifetime values sounds good to me. Is this perhaps what you had in mind?
>>
>> Thanks,
>>
>> Bart.
>>
>> --- a/include/uapi/linux/ioprio.h
>> +++ b/include/uapi/linux/ioprio.h
>> @@ -100,6 +100,14 @@ enum {
>>          IOPRIO_HINT_DEV_DURATION_LIMIT_5 = 5,
>>          IOPRIO_HINT_DEV_DURATION_LIMIT_6 = 6,
>>          IOPRIO_HINT_DEV_DURATION_LIMIT_7 = 7,
>> +       IOPRIO_HINT_DATA_LIFE_TIME_0 = 8,
>> +       IOPRIO_HINT_DATA_LIFE_TIME_1 = 9,
>> +       IOPRIO_HINT_DATA_LIFE_TIME_2 = 10,
>> +       IOPRIO_HINT_DATA_LIFE_TIME_3 = 11,
>> +       IOPRIO_HINT_DATA_LIFE_TIME_4 = 12,
>> +       IOPRIO_HINT_DATA_LIFE_TIME_5 = 13,
>> +       IOPRIO_HINT_DATA_LIFE_TIME_6 = 14,
>> +       IOPRIO_HINT_DATA_LIFE_TIME_7 = 15,
>>   };
> 
> (replying to my own e-mail)
> 
> Hi Damien,
> 
> Does the above look good to you?

Yes, it is what I was thinking of and I think it looks much better (and
simpler) than coding with different bits. However, I think this is acceptable
only if everyone agrees that combining CDL and lifetime (and potentially other
hints) is not a sensible thing to do. I stated that my thinking is that CDL is
more geared toward rotating media while lifetime is more suitable for solid
state media. But does everyone agree ?

Some have stated interest in CDL in NVMe-oF context, which could imply that
combining CDL and lifetime may be something useful to do in that space...

Getting more opinions about this would be nice. If we do not get any, I would
say that we should go with this.

-- 
Damien Le Moal
Western Digital Research


