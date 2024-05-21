Return-Path: <linux-fsdevel+bounces-19878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14D88CAD0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 13:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DABBB2272B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 11:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850F474BE0;
	Tue, 21 May 2024 11:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="T0tRzF6L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB3B55783
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 11:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716289568; cv=none; b=sZjjtEEXvSlz3eZrOvg4EC12kdB/VR/GEqrbXXRw0bcThSrkDmCWaSVNuqycGb2XCKvowoAC3YavZv2MS5DTw2GAmSChS9IiZKYzMszrbq49GduWOdOY6gCGvmNXIl8JzOCseQ+UcoSFQmgycx76S9HstmxSQmBOrenVsnQ65Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716289568; c=relaxed/simple;
	bh=o44WQQLOr+jbcEqW8C4R1uKdiNVbrDAo5or5/+ckeJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=pbZ/Zw482k7/dJX6qYyHQwz/YTVXDd0oLZDviXGKfGIZzXjz1yTdACEj5xH7h+dhTiX0P8u411YBdXS0Ed95lC2vSjnRpfp6InuPzuNIrKV97EZB1Cd2BC8kAIicJHMxSSMbC3pegtiIH5DJOUTOJE0+IR5NE2NxoPfCBFKOZv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=T0tRzF6L; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240521110603epoutp014e9fa111c7afb2e7f3e771af7bbe993e~RfEOq3V4P1346613466epoutp01E
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 11:06:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240521110603epoutp014e9fa111c7afb2e7f3e771af7bbe993e~RfEOq3V4P1346613466epoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716289563;
	bh=wSEDsytbD7se0+xPMl8QsO9Y8bzwKozeONYaDOcAYkA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T0tRzF6LU8276fv8261/fxJeIFN9Ksolvziaebf34uYjfjshTKtrQayMgOdyf2uFU
	 wAGdszepUEDFNtWfWo6l1dTeiiT5TdgEbv/2RBnl6qjpIJx2idC89y0iInW5d9UHhx
	 +Au0Q7ghjg41uhEv9zQzakOIIJLMRfK6AlBIOgEM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240521110602epcas5p1a38d5dca6dd409e90b38345b9894409f~RfEN9tTPy0892108921epcas5p1C;
	Tue, 21 May 2024 11:06:02 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4VkBSS3vmJz4x9Px; Tue, 21 May
	2024 11:06:00 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	09.F5.09688.8108C466; Tue, 21 May 2024 20:06:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240521105753epcas5p18f2c0624aeed49d549cc041a79de0ca3~Re9GlZHVd0195801958epcas5p1r;
	Tue, 21 May 2024 10:57:53 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240521105753epsmtrp203ee2b39fa95d524d64b55226de24106~Re9GiyYM91824018240epsmtrp2K;
	Tue, 21 May 2024 10:57:53 +0000 (GMT)
X-AuditID: b6c32a4a-837fa700000025d8-af-664c8018f4a0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	DA.1C.19234.13E7C466; Tue, 21 May 2024 19:57:53 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240521105749epsmtip1e6401767b96e4918e0ae9e0e52120cd2~Re9CmycwF2242022420epsmtip1l;
	Tue, 21 May 2024 10:57:48 +0000 (GMT)
Date: Tue, 21 May 2024 16:20:50 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, bvanassche@acm.org, david@fromorbit.com,
	hare@suse.de, damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
	joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
Message-ID: <20240521105050.r7webdbevi2ywsni@green245>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8f60ed88-1978-4d7c-9149-aee672aa1b09@kernel.org>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTdxTH97v39lJIMFdA9xPYIDWGV4CCUH+oPIZEL+ACCxE3nIOGXigC
	bdfCFJNtIEMUw1sUykPGmMyC1kG38RQCKFCpbGIRcCAsZVnkLTpinDDKVeN/n9/3nO85Oefk
	x8UtmkysuQmSFEYuESbxSDPi1x4nZ1eYfjiOv1pmg9TaOzg6U/AKR/UT+SSa7XkK0KWlFzgy
	dGUD9FI3hCPNnUmApjr9UXVNJYHGulow1F5ThKFr9bcxVH45E0O31+dJVNQ9AtCMXomhjnEX
	9P3ZWgK1dwwQaLi1gkRXrs6YoLq+NQwVntNjqNmQAdCN2UUC9Y/boKFXfZwAW3r4QSitrYF0
	i3LChB6a/Jmgh3WpdKPqPEk31X5L/9NUBui2sXSS/iGvmEPnZi6QdEvWYw69PDNO0Iu39CSd
	p1EBerC61yTcMipxv5gRihi5PSOJlYoSJPG+vNCI6APR3gK+h6uHD9rDs5cIkxlfXtDhcNeD
	CUkbC+LZfyVMSt2QwoUKBc/db79cmprC2IulihRfHiMTJcm8ZG4KYbIiVRLvJmFS9nrw+Z7e
	G4kxieLnl24C2UDEqUd5tVg6aD2QA0y5kPKCOt1lMgeYcS2oNgBfqIuBMWBBPQWw7tz2tzzU
	YJsDuJuGklufsfktAC60dRPs428A9RMPOEYDQe2C9aWthNFAUi7w7jrXKFtRDrCkuB0Y83Hq
	FxJWPcvfzLekYuC8tnCTzSkBXKooNWF5KxwoM2zWMaX84NI6bZS3Ubaw9MfnuLEOpCZN4Zph
	CWenCYKqCT3BsiV80qcxYdkarix0kCyfhNcu/kSy5u8AVD5UAjbgD7O0+ZuFcEoMBw2a10U/
	gCXaGxirb4G5Lw0Yq5vD5qo3vBM2qKtfN9gBR1YzSHZbNHzUYMcuaBnAqgu9oADYKd+ZTflO
	O5b3wvNLZzjKDTtO2cC6NS6LTlDd6l4NOCqwg5EpkuMZhbfMU8KcfHvuWGlyI9j8Pc4hzWB6
	asmtG2Bc0A0gF+dZmTdqguMszEXCtNOMXBotT01iFN3Ae+NWhbj1tljpxveTpER7ePnwvQQC
	gZfPboEH733z2axKkQUVL0xhEhlGxsjf+DCuqXU6pu4NOHI1cL5QekymKTzxrPDLkT3iKwnR
	kZzOzNmc0k+2wCN9BdPa0KD8mVMRo10BiiCVQ5pusvzj5UG++4nw6ONim3xT5Rw/K+2mY+7o
	E+V/K9Ln5O7ZMsEhFPwwMfBeiJtOlte/1Q8nphci71tO/H5Q/9s+16+LCj6Srbi0PLbfWdFo
	N7rYY8/hhP1haHQUhWbvc+m7wPEzC+x8b/tx/7CVew4O6XPuUaueVTyZz32rbMcosbLi828y
	ul2Cne5q4o+qVZFzy+Zrp5vGPvxC/a+2a1wg1Sn7//y0ixtRPvTXlC62Kms8PsHN7mjYMX1W
	5brvrvqCmLi16yEjQYaLEZrrZ3mEQiz0cMblCuH/8ReFMMYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0xTZxjHfc85nJ5WGw8FxkvrjFbUBCNC0umLNqgLJq9RicH4QWKUKgeK
	UGxa2UREGQSEDpxCuFhFLpZiqQEFIlAuIsh9ShRxgahzWuIFseCEYEhhHMii3375P//Ll4ch
	JROUlImKPcXpYlUxclpE3W2Xr9zof25vhF/VlAhV9XaSKPmSk0TWF3/QaLT9M0B5419JZG+9
	ANDMw34S1Xa+BOjVve2ouLSQQkOtDQRqKs0mkMXaQaCr+SkE6pgbo1F22zOARgaNBGoe3oBK
	0kwUamruodCA7RqNiswjAlTeNUugy+mDBKq3/wZQ5aiDQt3DMtTv7HLZsQIPPN2De0shbjC+
	EOD+l3coPPAwDldXZNC4xnQev6u5AnDjUBKNb1zMccFZKZ9o3JD6twueGBmmsKNlkMYXaysA
	/rP4gWC/W6hIGc7FRP3C6TYFhonUhXXdtHZm/+kP5kaQBNJ2GgDDQFYBc1sOGYCIkbB1AL4e
	/CgwAOG87gXNzgfkIrtBy+zbBV3C2udN1h94pti10Fpgo/gemt0A++YYXnZn18PcnCbAd5Js
	Iw1nvvYtZN3YMDjWe9mFZzG7GY5fKxAsDk8A+OXRPXLx4Ap7rtgpnsl50/Waf0h+gGRlsHyW
	4VHIBsLxOcw7PNgVsKBskrwEXI3fhY3fhY3fwsWArAAenFavidQc1/r76lUafVxspO/xk5pq
	sPAVPiH1wFzl9G0DBAPaAGRIubu4unZ3hEQcroo/w+lOHtXFxXD6NiBjKLmneE1MRriEjVSd
	4qI5Tsvp/r8SjFCaRCR0BICyBIXSM8pxIuB5Wd1wNkEFrOrN3x7kBLdvKbLSpyKmy0PeL9+a
	oAn9UXsoxe3fny/ER3+ZEo/lNlt3UUpvs0QY9KFCuqTFJsvJqv74WJ33pGjdK9NPLW+2hZTl
	nUnHtq2/YntQ8d2JqKsOWeDZ4Ps3vaKNJanjfgdGuoLrhCWk3qf1eepBb0Visl+y0nLinfR8
	pj66e9l9qx2q/4p3bouoZ90zPRsKM8KzH1nab41mujI3i8pXH85IS03M2xm2Pm3NMS+0pVMx
	NfS61ARVd5Yulf6+r3CyoNIcPK3Ofey77Ii3UunobjY9IW6fsxhGFYbNQY7E0Moum6avRE7p
	1Sp/H1KnV/0HFww+7oQDAAA=
X-CMS-MailID: 20240521105753epcas5p18f2c0624aeed49d549cc041a79de0ca3
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----0ARpVfROdpzmGW4Ln12FwIta42jNjH8le_L8dBWq-uMGoSqN=_1575d_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520102842epcas5p4949334c2587a15b8adab2c913daa622f
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520102842epcas5p4949334c2587a15b8adab2c913daa622f@epcas5p4.samsung.com>
	<20240520102033.9361-3-nj.shetty@samsung.com>
	<8f60ed88-1978-4d7c-9149-aee672aa1b09@kernel.org>

------0ARpVfROdpzmGW4Ln12FwIta42jNjH8le_L8dBWq-uMGoSqN=_1575d_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 20/05/24 05:00PM, Damien Le Moal wrote:
>On 2024/05/20 12:20, Nitesh Shetty wrote:
>> We add two new opcode REQ_OP_COPY_DST, REQ_OP_COPY_SRC.
>> Since copy is a composite operation involving src and dst sectors/lba,
>> each needs to be represented by a separate bio to make it compatible
>> with device mapper.
>
>Why ? The beginning of the sentence isn't justification enough for the two new
>operation codes ? The 2 sentences should be reversed for easier reading:
>justification first naturally leads to the reader understanding why the codes
>are needed.
>
>Also: s/opcode/operations
>
>
Acked

>> We expect caller to take a plug and send bio with destination information,
>> followed by bio with source information.
>
>expect ? Plugging is optional. Does copy offload require it ? Please clarify this.
>
"caller" here refers to blkdev_copy_offload. The caller of blkdev_copy_offload
does not need to take the plug. We should have made this clear.
Sorry for the confusion, will update the description to reflect the same
in next version.

>> Once the dst bio arrives we form a request and wait for source
>
>arrives ? You mean "is submitted" ?
>
>s/and wait for/and wait for the
>
>> bio. Upon arrival of source bio we merge these two bio's and send
>
>s/arrival/submission ?
>
>s/of/of the
>s/bio's/BIOs
>s/and send/and send the
>s/down to/down to the
>
acked for above.

>> corresponding request down to device driver.
>> Merging non copy offload bio is avoided by checking for copy specific
>> opcodes in merge function.
>
>Super unclear... What are you trying to say here ? That merging copy offload
>BIOs with other BIOs is not allowed ? That is already handled. Only BIOs &
>requests with the same operation can be merged. The code below also suggests
>that you allow merging copy offloads... So I really do not understand this.
>
You are right, only BIOs & requests with same operation can be merged.
We are not merging copy offloads. We are only merging src and dst BIO to
form a copy offload request.
We will remove this in next version.

>> diff --git a/block/blk-merge.c b/block/blk-merge.c
>> index 8534c35e0497..f8dc48a03379 100644
>> --- a/block/blk-merge.c
>> +++ b/block/blk-merge.c
>> @@ -154,6 +154,20 @@ static struct bio *bio_split_write_zeroes(struct bio *bio,
>>  	return bio_split(bio, lim->max_write_zeroes_sectors, GFP_NOIO, bs);
>>  }
>>
>> +static struct bio *bio_split_copy(struct bio *bio,
>> +				  const struct queue_limits *lim,
>> +				  unsigned int *nsegs)
>> +{
>> +	*nsegs = 1;
>> +	if (bio_sectors(bio) <= lim->max_copy_sectors)
>> +		return NULL;
>> +	/*
>> +	 * We don't support splitting for a copy bio. End it with EIO if
>> +	 * splitting is required and return an error pointer.
>> +	 */
>> +	return ERR_PTR(-EIO);
>> +}
>
>Hmm... Why not check that the copy request is small enough and will not be split
>when it is submitted ? Something like blk_check_zone_append() does with
>REQ_OP_ZONE_APPEND ? So adding a blk_check_copy_offload(). That would also
>include the limits check from the previous hunk.
Yes, that could be one way. But we followed approach similar to discard.

>
>> +
>>  /*
>>   * Return the maximum number of sectors from the start of a bio that may be
>>   * submitted as a single request to a block device. If enough sectors remain,
>> @@ -362,6 +376,12 @@ struct bio *__bio_split_to_limits(struct bio *bio,
>>  	case REQ_OP_WRITE_ZEROES:
>>  		split = bio_split_write_zeroes(bio, lim, nr_segs, bs);
>>  		break;
>> +	case REQ_OP_COPY_SRC:
>> +	case REQ_OP_COPY_DST:
>> +		split = bio_split_copy(bio, lim, nr_segs);
>> +		if (IS_ERR(split))
>> +			return NULL;
>> +		break;
>
>See above.
>
>>  	default:
>>  		split = bio_split_rw(bio, lim, nr_segs, bs,
>>  				get_max_io_size(bio, lim) << SECTOR_SHIFT);
>> @@ -925,6 +945,9 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
>>  	if (!rq_mergeable(rq) || !bio_mergeable(bio))
>>  		return false;
>>
>> +	if (blk_copy_offload_mergable(rq, bio))
>> +		return true;
>> +
>>  	if (req_op(rq) != bio_op(bio))
>>  		return false;
>>
>> @@ -958,6 +981,8 @@ enum elv_merge blk_try_merge(struct request *rq, struct bio *bio)
>>  {
>>  	if (blk_discard_mergable(rq))
>>  		return ELEVATOR_DISCARD_MERGE;
>> +	else if (blk_copy_offload_mergable(rq, bio))
>> +		return ELEVATOR_COPY_OFFLOAD_MERGE;
>>  	else if (blk_rq_pos(rq) + blk_rq_sectors(rq) == bio->bi_iter.bi_sector)
>>  		return ELEVATOR_BACK_MERGE;
>>  	else if (blk_rq_pos(rq) - bio_sectors(bio) == bio->bi_iter.bi_sector)
>> @@ -1065,6 +1090,20 @@ static enum bio_merge_status bio_attempt_discard_merge(struct request_queue *q,
>>  	return BIO_MERGE_FAILED;
>>  }
>>
>> +static enum bio_merge_status bio_attempt_copy_offload_merge(struct request *req,
>> +							    struct bio *bio)
>> +{
>> +	if (req->__data_len != bio->bi_iter.bi_size)
>> +		return BIO_MERGE_FAILED;
>> +
>> +	req->biotail->bi_next = bio;
>> +	req->biotail = bio;
>> +	req->nr_phys_segments++;
>> +	req->__data_len += bio->bi_iter.bi_size;
>
>Arg... You seem to be assuming that the source BIO always comes right after the
>destination request... What if copy offloads are being concurrently issued ?
>Shouldn't you check somehow that the pair is a match ? Or are you relying on the
>per-context plugging which prevents that from happening in the first place ? But
>that would assumes that you never ever sleep trying to allocate the source BIO
>after the destination BIO/request are prepared and plugged.
>
Yes, we are rely on per-context plugging for copy to work.
Incase for any reason we are not able to merge src and dst BIOs, and the
request reaches driver layer with only one of the src or dst BIO,
we fail this request in driver layer.
This approach simplifies the overall copy plumbing.

>> +
>> +	return BIO_MERGE_OK;
>> +}
>> +
>>  static enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
>>  						   struct request *rq,
>>  						   struct bio *bio,
>> @@ -1085,6 +1124,8 @@ static enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
>>  		break;
>>  	case ELEVATOR_DISCARD_MERGE:
>>  		return bio_attempt_discard_merge(q, rq, bio);
>> +	case ELEVATOR_COPY_OFFLOAD_MERGE:
>> +		return bio_attempt_copy_offload_merge(rq, bio);
>>  	default:
>>  		return BIO_MERGE_NONE;
>>  	}
>> diff --git a/block/blk.h b/block/blk.h
>> index 189bc25beb50..6528a2779b84 100644
>> --- a/block/blk.h
>> +++ b/block/blk.h
>> @@ -174,6 +174,20 @@ static inline bool blk_discard_mergable(struct request *req)
>>  	return false;
>>  }
>>
>> +/*
>> + * Copy offload sends a pair of bio with REQ_OP_COPY_DST and REQ_OP_COPY_SRC
>> + * operation by taking a plug.
>> + * Initially DST bio is sent which forms a request and
>> + * waits for SRC bio to arrive. Once SRC bio arrives
>> + * we merge it and send request down to driver.
>> + */
>> +static inline bool blk_copy_offload_mergable(struct request *req,
>> +					     struct bio *bio)
>> +{
>> +	return (req_op(req) == REQ_OP_COPY_DST &&
>> +		bio_op(bio) == REQ_OP_COPY_SRC);
>> +}
>
>This function is really not needed at all (used in one place only).
>
This is used at two places and we felt this provides better readability,
similar to discard.

>> +
>>  static inline unsigned int blk_rq_get_max_segments(struct request *rq)
>>  {
>>  	if (req_op(rq) == REQ_OP_DISCARD)
>> @@ -323,6 +337,8 @@ static inline bool bio_may_exceed_limits(struct bio *bio,
>>  	case REQ_OP_DISCARD:
>>  	case REQ_OP_SECURE_ERASE:
>>  	case REQ_OP_WRITE_ZEROES:
>> +	case REQ_OP_COPY_SRC:
>> +	case REQ_OP_COPY_DST:
>>  		return true; /* non-trivial splitting decisions */
>
>See above. Limits should be checked on submission.
>
>>  	default:
>>  		break;
>> diff --git a/block/elevator.h b/block/elevator.h
>> index e9a050a96e53..c7a45c1f4156 100644
>> --- a/block/elevator.h
>> +++ b/block/elevator.h
>> @@ -18,6 +18,7 @@ enum elv_merge {
>>  	ELEVATOR_FRONT_MERGE	= 1,
>>  	ELEVATOR_BACK_MERGE	= 2,
>>  	ELEVATOR_DISCARD_MERGE	= 3,
>> +	ELEVATOR_COPY_OFFLOAD_MERGE	= 4,
>>  };
>>
>>  struct blk_mq_alloc_data;
>> diff --git a/include/linux/bio.h b/include/linux/bio.h
>> index d5379548d684..528ef22dd65b 100644
>> --- a/include/linux/bio.h
>> +++ b/include/linux/bio.h
>> @@ -53,11 +53,7 @@ static inline unsigned int bio_max_segs(unsigned int nr_segs)
>>   */
>>  static inline bool bio_has_data(struct bio *bio)
>>  {
>> -	if (bio &&
>> -	    bio->bi_iter.bi_size &&
>> -	    bio_op(bio) != REQ_OP_DISCARD &&
>> -	    bio_op(bio) != REQ_OP_SECURE_ERASE &&
>> -	    bio_op(bio) != REQ_OP_WRITE_ZEROES)
>> +	if (bio && (bio_op(bio) == REQ_OP_READ || bio_op(bio) == REQ_OP_WRITE))
>>  		return true;
>
>This change seems completely broken and out of place. This would cause a return
>of false for zone append operations.
>
We changed this based on previous review comments[1].
Idea is to replace this with a positive check.
But we did miss adding ZONE_APPEND in this.
We will add ZONE_APPEND check in next version.

[1] https://lore.kernel.org/linux-block/20230720074256.GA5042@lst.de/
>>
>>  	return false;
>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>> index 781c4500491b..7f692bade271 100644
>> --- a/include/linux/blk_types.h
>> +++ b/include/linux/blk_types.h
>> @@ -342,6 +342,10 @@ enum req_op {
>>  	/* reset all the zone present on the device */
>>  	REQ_OP_ZONE_RESET_ALL	= (__force blk_opf_t)15,
>>
>> +	/* copy offload src and dst operation */
>
>s/src/source
>s/dst/destination
>s/operation/operations
>
Acked

>> +	REQ_OP_COPY_SRC		= (__force blk_opf_t)18,
>> +	REQ_OP_COPY_DST		= (__force blk_opf_t)19,
>> +
>>  	/* Driver private requests */
>>  	REQ_OP_DRV_IN		= (__force blk_opf_t)34,
>>  	REQ_OP_DRV_OUT		= (__force blk_opf_t)35,
>> @@ -430,6 +434,12 @@ static inline bool op_is_write(blk_opf_t op)
>>  	return !!(op & (__force blk_opf_t)1);
>>  }
>>
>> +static inline bool op_is_copy(blk_opf_t op)
>> +{
>> +	return ((op & REQ_OP_MASK) == REQ_OP_COPY_SRC ||
>> +		(op & REQ_OP_MASK) == REQ_OP_COPY_DST);
>> +}
>
>May be use a switch here to avoid the double masking of op ?
>
Acked

Thank you,
Nitesh Shetty

------0ARpVfROdpzmGW4Ln12FwIta42jNjH8le_L8dBWq-uMGoSqN=_1575d_
Content-Type: text/plain; charset="utf-8"


------0ARpVfROdpzmGW4Ln12FwIta42jNjH8le_L8dBWq-uMGoSqN=_1575d_--

