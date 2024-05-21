Return-Path: <linux-fsdevel+bounces-19979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFCF8CBB13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 08:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7F941F22CE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 06:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE1178C89;
	Wed, 22 May 2024 06:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="t1m8OqUv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369EB78C6D
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 06:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716358852; cv=none; b=lGKTUJAHq4UWU+yhIMFZu7YraRp1C6TJFMY9EyNeRha451XsrcGcO9cVOldCmr91k91M/DgzORPUh/2J9zHc53FcV6Pq7DNHTwvXoGRtDgYnRjtQ1frL7RF+Sa0+N2I4C9X8bUG7loR/KbTlp43VFg3bHQ2y6VUP8PDcF4kyiZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716358852; c=relaxed/simple;
	bh=JQGfFka2gc6MqoiCaoTwU0i2lfFMAhKUkq974SM9rFo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=k8Uq2yrCzEsUSxjOpj8FZ+8/KcPK2O5ihWTYKLDaA0HlE6oERfa/n8Rnoue58AxexnLXCD/PX4RFKTkpTa8pzjm8z1n/+LSdWiJhC815V0lXIShtWFc8cji4EMYFuNkr79mdIbMtLu2FIaMnGTrYaWXVyrH+VRNVaeD2h2rDvTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=t1m8OqUv; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240522062047epoutp037c6267fa91b4461029a9bfc4bb233f50~Ru0cb6xrb2195221952epoutp032
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 06:20:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240522062047epoutp037c6267fa91b4461029a9bfc4bb233f50~Ru0cb6xrb2195221952epoutp032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716358847;
	bh=GE9xNl5h7Gni8ZU02Gpsaa26vJXObmgtTpzWLJiAi9I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t1m8OqUvEiFzWQWPq52WrwG4fSylvkHxizx4ov6VIEoeBlvR5YbtOsCQAT7gbBWUn
	 KNPONrHKX56NHFX5MRq83cDltxttmcH67PdwVeaymoXD7jn+qIbxfjol6kIYIutK0K
	 I+56ssoWGO4JGG6SaUxcfB7+MU214G9pBtJGtuuQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240522062046epcas5p27fdddf32b52fdd92905e56d93836e634~Ru0bopxgA2089020890epcas5p2S;
	Wed, 22 May 2024 06:20:46 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Vkh4r2KVfz4x9Q2; Wed, 22 May
	2024 06:20:44 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D2.B0.19431.CBE8D466; Wed, 22 May 2024 15:20:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240521082243epcas5p47990dcc3e3825847cba5512aa0f9a1fd~Rc1oXt2Uq1609416094epcas5p4O;
	Tue, 21 May 2024 08:22:43 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240521082243epsmtrp1615c124d853e5a21a8d962be681a2f63~Rc1oQ_mMT2514125141epsmtrp1W;
	Tue, 21 May 2024 08:22:43 +0000 (GMT)
X-AuditID: b6c32a50-ccbff70000004be7-00-664d8ebc8f4f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	15.D2.09238.3D95C466; Tue, 21 May 2024 17:22:43 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240521082239epsmtip1cf08c34c43d1f1fad60542f584456f55~Rc1kkDSmX2492124921epsmtip1p;
	Tue, 21 May 2024 08:22:39 +0000 (GMT)
Date: Tue, 21 May 2024 13:45:41 +0530
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
Subject: Re: [PATCH v20 01/12] block: Introduce queue limits and sysfs for
 copy-offload support
Message-ID: <20240521081541.whboo4m4ybe2lzhx@green245>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c31f663f-36c0-4db2-8bf6-8e3c699073ca@kernel.org>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA02TezBcVxzHe+69e/cyQ25J6nTJlG3VhHqssDlSj7TRunl0xqSjY6pT2XKD
	sdZmH4nS1FsS8QiJJlnEI0SQoRFN0CVKQmnxh66iKPEMaclGYzKp6HLp5L/P+Z7f9/c75/eb
	H4WbNfIFVIRMxSpkEqmQNCbutO+yc9RmfXLMZWTWCNV2d+Ao6fwqjqpHs0m00K4H6Lul5zia
	aj0N0IuePhzVd4wBNH7PBxWXFhJoqLURQ9rSXAxVVj/AUP6lZAw9WPuLRLltAwBN6zQYah52
	QCVpZQTSNncRqL+pgERF16f5qKLzJYZyzugw1DCVCFDNwiKBfh62RH2rnbx9Vkz/b4eY7lLI
	NGpG+Uzf2C2C6e9RM3VVZ0nmdlk8M3f7CmB+HEogmWtZF3hMZvLfJNOY+iePeTI9TDCLLTqS
	yaqvAsyvxff5/uafR3qGs5JQVmHNykKiQyNkYV7CQ58G7w92F7uIHEUeaI/QWiaJYr2Evof9
	HT+OkBoaJLQ+IZGqDZK/RKkUOnt7KqLVKtY6PFqp8hKy8lCp3E3upJREKdWyMCcZq9orcnFx
	dTcEHo0M70vvx+TNnjFzugoiAVx2TQdGFKTdYGXbJEgHxpQZrQWwvGaAzx30ABZ06Qnu8AzA
	xfwWcsuiS6zlcRfNAI5W9W5aZgBMvp9ErEcRtC3UP0/A0wFFkbQD/GWNWpe303Yw74J2ox5O
	/0DCq8vZvPULc1oCK4aawTqb0GKof5TJ5/h12HVlaiOnEe0N52f+2IjZQVvBy+X/4OuJIP3Q
	CF78dxLnnucLa1aeAo7N4XxnPZ9jAXyUnbbJJ2HlxRskZ04BUPO7ZtPgA1O7szcS4XQ41Dcs
	8zh9J8zrrsE43RRmvpjCON0ENlzd4rfhzdrizR69CQdWEjeZgfnT7RjXoieGYo8reefBW5pX
	fqd5pR7He+HZpSQDUwa2hBUvKQ53wdom52LAqwICVq6MCmND3OUiRxl78v+hh0RH1YGNHbL3
	bwDV3686tQGMAm0AUrhwu0ld/YFjZiahkq9jWUV0sEItZZVtwN0wrhxcsCMk2rCEMlWwyM3D
	xU0sFrt57BaLhBYmC6mFoWZ0mETFRrKsnFVs+TDKSJCAbaOCnk6+5zuk71M7rUgD7EvNP3wj
	vd5lYGLCCroPlrTckeV9OXjrod2gl5eydaJ9hGcaLjxisRCTq7OfTZn7bC7g3I27cffGRDH7
	Z8bfjbI4HheY77bkL7UrVo/zfXi9Xmzet4FHjl7LLftmWLtmm9Dh2H5XVrDnsXPN7CLqWjx9
	qsbSpsl+tfDMByOxduYtxmaDX5V+tBP+lDGf7X6isYE6+I71db9LI/7PviC2xe0u6YmXrvaW
	+9n4HNxXVe166oBmGOsJsPVwUPHP4VOefvF92sPe7V0VGeOmMP+1uKKgSso3TZCRsGQlmIpL
	OR7b834Oa1M0NnfTlQwMWU4O0iUWCwlluERkjyuUkv8AvcauLMwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0xTZxjHfc85nB7qmhxa1LfiJikxEnAoCc7XuKEJiXnJ5iXGLuqM0smR
	axFbLhsftjJgYzgZ4AVoBTtk1lKVWOom12JFsEXECDUrhnqhFQS5yETTGOps2TK//fP8/pcv
	D0MKX1PLmZSMLE6RIUuX0HzqjxuSjz4e2PvF4XU1f4eiRls3iX4omyeRYfhXGk3cmAXo9IyH
	RK7OnwB609dPIlO3E6BH5s1IW1dDIUdnM4Ha6ioIpDfcJJCmsoBAN99O0qjCch8gt11NoPah
	SPTbj/UUamu3Umig5QyNzp5385Cux0ug8mI7ga658gG6PDFNoVtDIah/vidgywo8MPg5ttVB
	3Kwe5uF+5xUKD/RlY2PDzzRuqv8ejzVVA9zqUNH4XOmJAHy8YIrGzUUPA/AL9xCFpzvsNC41
	NQB8W9vF2ynax/80kUtPyeEUa2MT+MmOznWZ0xu/KTC7SRVwrS0BgQxkY6A9vzGgBPAZIdsK
	4KvxTrAAxPD8fBe5oEVQ7x3lLZhcAB7reEL7AMWugrMe1TsTw9BsJOx9y/jOwexqeOpEG/D5
	SbaVhm88vTwfELEyqHO0+wcE7Cdw9tnxf0tfADieX85bAEHQWu2ifJp8Z6pteuwfINkQqPP6
	BwLZWDj+9IG/Zwm7Alb9PkeWgSD1e2n1e2n1/2ktIBuAmMtUypPkh6IzozO43CilTK7MzkiK
	OnREbgT+34gIvwacZ71RFkAwwAIgQ0qCBUZT/GGhIFH2bR6nOHJQkZ3OKS0ghKEkywTRVZpE
	IZsky+LSOC6TU/xHCSZwuYqYHI2qj9yh3/6g5cNWw+usPWONbKHDOLjp5eInniLvl0XW0BH7
	oKBvF6oka8Wa3JV30sJsqWsem+Smi7lXubTkiD8re8Y9ewd1nxnS+KIYcagtYWvHaOroAenT
	GMOz5/eau7Qyqesr3UhtfrlJYBYQVv3cvvWiXDfQ2qe+e3g3BH+tqZiMUznJpWFxJcZj6caT
	Bs+F4rziuIM8sbAl/OTwhqOM0calFE5sy9E05jyXjrFiRd7uvyz67l7pTPkv+69vNEaCrWUV
	L7WxcFHyyvCZOadlS3vQBYVr6UhVasL9D2IaLotnLrUVN+2Jry66XmiQ3ptyOMwTVusBc0Gw
	hFImy6IjSIVS9g8nPpMSigMAAA==
X-CMS-MailID: 20240521082243epcas5p47990dcc3e3825847cba5512aa0f9a1fd
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----NniuWcEa.zZVU-iq4JS_ZFjyXsesTFtE.O7X-O5.k3Ud19D7=_14c0f_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520102830epcas5p27274901f3d0c2738c515709890b1dec4
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520102830epcas5p27274901f3d0c2738c515709890b1dec4@epcas5p2.samsung.com>
	<20240520102033.9361-2-nj.shetty@samsung.com>
	<c31f663f-36c0-4db2-8bf6-8e3c699073ca@kernel.org>

------NniuWcEa.zZVU-iq4JS_ZFjyXsesTFtE.O7X-O5.k3Ud19D7=_14c0f_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 20/05/24 04:33PM, Damien Le Moal wrote:
>On 2024/05/20 12:20, Nitesh Shetty wrote:
>> @@ -231,10 +237,11 @@ int blk_set_default_limits(struct queue_limits *lim)
>>  {
>>  	/*
>>  	 * Most defaults are set by capping the bounds in blk_validate_limits,
>> -	 * but max_user_discard_sectors is special and needs an explicit
>> -	 * initialization to the max value here.
>> +	 * but max_user_discard_sectors and max_user_copy_sectors are special
>> +	 * and needs an explicit initialization to the max value here.
>
>s/needs/need

acked
>
>>  	 */
>>  	lim->max_user_discard_sectors = UINT_MAX;
>> +	lim->max_user_copy_sectors = UINT_MAX;
>>  	return blk_validate_limits(lim);
>>  }
>>
>> @@ -316,6 +323,25 @@ void blk_queue_max_discard_sectors(struct request_queue *q,
>>  }
>>  EXPORT_SYMBOL(blk_queue_max_discard_sectors);
>>
>> +/*
>> + * blk_queue_max_copy_hw_sectors - set max sectors for a single copy payload
>> + * @q:	the request queue for the device
>> + * @max_copy_sectors: maximum number of sectors to copy
>> + */
>> +void blk_queue_max_copy_hw_sectors(struct request_queue *q,
>> +				   unsigned int max_copy_sectors)
>> +{
>> +	struct queue_limits *lim = &q->limits;
>> +
>> +	if (max_copy_sectors > (BLK_COPY_MAX_BYTES >> SECTOR_SHIFT))
>> +		max_copy_sectors = BLK_COPY_MAX_BYTES >> SECTOR_SHIFT;
>> +
>> +	lim->max_copy_hw_sectors = max_copy_sectors;
>> +	lim->max_copy_sectors =
>> +		min(max_copy_sectors, lim->max_user_copy_sectors);
>> +}
>> +EXPORT_SYMBOL_GPL(blk_queue_max_copy_hw_sectors);
>
>Hmm... Such helper seems to not fit with Christoph's changes of the limits
>initialization as that is not necessarily done using &q->limits but depending on
>the driver, a different limit structure. So shouldn't this function be passed a
>queue_limits struct pointer instead of the request queue pointer ?
>
Acked, we made a mistake, we are no longer using this function after moving
to atomic limits change. We will remove this function in next version.

>> +
>>  /**
>>   * blk_queue_max_secure_erase_sectors - set max sectors for a secure erase
>>   * @q:  the request queue for the device
>> @@ -633,6 +659,10 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
>>  	t->max_segment_size = min_not_zero(t->max_segment_size,
>>  					   b->max_segment_size);
>>
>> +	t->max_copy_sectors = min(t->max_copy_sectors, b->max_copy_sectors);
>> +	t->max_copy_hw_sectors = min(t->max_copy_hw_sectors,
>> +				     b->max_copy_hw_sectors);
>> +
>>  	t->misaligned |= b->misaligned;
>>
>>  	alignment = queue_limit_alignment_offset(b, start);
>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>> index f0f9314ab65c..805c2b6b0393 100644
>> --- a/block/blk-sysfs.c
>> +++ b/block/blk-sysfs.c
>> @@ -205,6 +205,44 @@ static ssize_t queue_discard_zeroes_data_show(struct request_queue *q, char *pag
>>  	return queue_var_show(0, page);
>>  }
>>
>> +static ssize_t queue_copy_hw_max_show(struct request_queue *q, char *page)
>> +{
>> +	return sprintf(page, "%llu\n", (unsigned long long)
>> +		       q->limits.max_copy_hw_sectors << SECTOR_SHIFT);
>> +}
>> +
>> +static ssize_t queue_copy_max_show(struct request_queue *q, char *page)
>> +{
>> +	return sprintf(page, "%llu\n", (unsigned long long)
>> +		       q->limits.max_copy_sectors << SECTOR_SHIFT);
>> +}
>
>Given that you repeat the same pattern twice, may be add a queue_var64_show()
>helper ? (naming can be changed).
>
Acked

>> +
>> +static ssize_t queue_copy_max_store(struct request_queue *q, const char *page,
>> +				    size_t count)
>> +{
>> +	unsigned long max_copy_bytes;
>> +	struct queue_limits lim;
>> +	ssize_t ret;
>> +	int err;
>> +
>> +	ret = queue_var_store(&max_copy_bytes, page, count);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	if (max_copy_bytes & (queue_logical_block_size(q) - 1))
>> +		return -EINVAL;
>> +
>> +	blk_mq_freeze_queue(q);
>> +	lim = queue_limits_start_update(q);
>> +	lim.max_user_copy_sectors = max_copy_bytes >> SECTOR_SHIFT;
>
>max_copy_bytes is an unsigned long, so 64 bits on 64-bit arch and
>max_user_copy_sectors is an unsigned int, so 32-bits. There are thus no
>guarantees that this will not overflow. A check is needed.
>
Acked

>> +	err = queue_limits_commit_update(q, &lim);
>> +	blk_mq_unfreeze_queue(q);
>> +
>> +	if (err)
>
>You can reuse ret here. No need for adding the err variable.
Acked

>
>> +		return err;
>> +	return count;
>> +}
>> +
>>  static ssize_t queue_write_same_max_show(struct request_queue *q, char *page)
>>  {
>>  	return queue_var_show(0, page);
>> @@ -505,6 +543,9 @@ QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");
>>  QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones");
>>  QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");
>>
>> +QUEUE_RO_ENTRY(queue_copy_hw_max, "copy_max_hw_bytes");
>> +QUEUE_RW_ENTRY(queue_copy_max, "copy_max_bytes");
>> +
>>  QUEUE_RW_ENTRY(queue_nomerges, "nomerges");
>>  QUEUE_RW_ENTRY(queue_rq_affinity, "rq_affinity");
>>  QUEUE_RW_ENTRY(queue_poll, "io_poll");
>> @@ -618,6 +659,8 @@ static struct attribute *queue_attrs[] = {
>>  	&queue_discard_max_entry.attr,
>>  	&queue_discard_max_hw_entry.attr,
>>  	&queue_discard_zeroes_data_entry.attr,
>> +	&queue_copy_hw_max_entry.attr,
>> +	&queue_copy_max_entry.attr,
>>  	&queue_write_same_max_entry.attr,
>>  	&queue_write_zeroes_max_entry.attr,
>>  	&queue_zone_append_max_entry.attr,
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index aefdda9f4ec7..109d9f905c3c 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -309,6 +309,10 @@ struct queue_limits {
>>  	unsigned int		discard_alignment;
>>  	unsigned int		zone_write_granularity;
>>
>> +	unsigned int		max_copy_hw_sectors;
>> +	unsigned int		max_copy_sectors;
>> +	unsigned int		max_user_copy_sectors;
>> +
>>  	unsigned short		max_segments;
>>  	unsigned short		max_integrity_segments;
>>  	unsigned short		max_discard_segments;
>> @@ -933,6 +937,8 @@ void blk_queue_max_secure_erase_sectors(struct request_queue *q,
>>  		unsigned int max_sectors);
>>  extern void blk_queue_max_discard_sectors(struct request_queue *q,
>>  		unsigned int max_discard_sectors);
>> +extern void blk_queue_max_copy_hw_sectors(struct request_queue *q,
>> +					  unsigned int max_copy_sectors);
>>  extern void blk_queue_max_write_zeroes_sectors(struct request_queue *q,
>>  		unsigned int max_write_same_sectors);
>>  extern void blk_queue_logical_block_size(struct request_queue *, unsigned int);
>> @@ -1271,6 +1277,14 @@ static inline unsigned int bdev_discard_granularity(struct block_device *bdev)
>>  	return bdev_get_queue(bdev)->limits.discard_granularity;
>>  }
>>
>> +/* maximum copy offload length, this is set to 128MB based on current testing */
>
>Current testing will not be current in a while... So may be simply say
>"arbitrary" or something. Also please capitalize the first letter of the
>comment. So something like:
>
>/* Arbitrary absolute limit of 128 MB for copy offload. */
>
>> +#define BLK_COPY_MAX_BYTES		(1 << 27)
>
>Also, it is not clear from the name if this is a soft limit or a cap on the
>hardware limit... So at least please adjust the comment to say which one it is.
>
Acked, it is a soft limit.

Thank You,
Nitesh Shetty

------NniuWcEa.zZVU-iq4JS_ZFjyXsesTFtE.O7X-O5.k3Ud19D7=_14c0f_
Content-Type: text/plain; charset="utf-8"


------NniuWcEa.zZVU-iq4JS_ZFjyXsesTFtE.O7X-O5.k3Ud19D7=_14c0f_--

