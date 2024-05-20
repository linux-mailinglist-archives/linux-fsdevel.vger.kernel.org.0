Return-Path: <linux-fsdevel+bounces-19845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BAA8CA48D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 00:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85BE282141
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 22:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AA74F613;
	Mon, 20 May 2024 22:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="l3/NWJ5L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8415CA929;
	Mon, 20 May 2024 22:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716244965; cv=none; b=EHXkdD8daWGFtz4Jop2xVZqwYEeyBSdBHBpPmXzl99rtwSl7Gf3iXsCAXUUQqYPcHUh0TQ5Pwth3eihI4Jp8OVBfxPhA9E64nfaWBdgnbIkxXrOhnePuXeT1c2zIHRUDscEm+kazsSQhh6E25s+8daAJDoLFEcMmyYdPsBHDXbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716244965; c=relaxed/simple;
	bh=heA4s3lERjam+6Larr6TOOfCA1T/Ts00JtBoUfmIlMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OAygTUHlBdsmaxf/DcHFnmDgGbqPO64FbjB/sj3cdeei3we0JgvoBX47KH6IN7tNZI3Kt0Ug2vsU52L6lprwCk3NVTvi8O4itxDe+/dpzA9OiENksOredV2DJbGmZrELbUPZfJmMjH2NOsVkZnVRzb1TxPafLKaVQRO+AYgwluQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=l3/NWJ5L; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Vjsyn5ZRFz6Cnk8t;
	Mon, 20 May 2024 22:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1716244947; x=1718836948; bh=0pJSnqKU4Io+VCN5eICuTeI+
	NiAtDO/zLNkz8Pxl2Wg=; b=l3/NWJ5LX8oUM5iUAXCMbAS/xJWypIHnCgFgjhg1
	1JT2cmlLGjH004Vw3IsbcB4Y6PoVXdT0cD9f4/g86ByrfSidSdCrQmnUfaUBtXh3
	R6FHhxz0mpFhcitcDGM7hsnV1cwQ3lCKq/xl5pxLcD7R5oV31Us6Ayj6zjDEoYVG
	GGY9NGYDWBFiKg8LLeEFkmX6tvDt0v6Qc6lEwoHx6Y05yPekdF2Per+daViCzgkV
	9VqunyYQrIJTYqTK5U1KKS8iy48HUStLR5TKFKvZM3LTxfSEK5S8DBZ+4sGVTnaw
	yeBtaCtoHBqzWeXaMfiQuvd+SAksf8Q+r5AmXseC1nGVRA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id RDRQgEpz2QIf; Mon, 20 May 2024 22:42:27 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VjsyP5zMJz6Cnk8s;
	Mon, 20 May 2024 22:42:21 +0000 (UTC)
Message-ID: <d47b55ac-b986-4bb0-84f4-e193479444e3@acm.org>
Date: Mon, 20 May 2024 15:42:17 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 01/12] block: Introduce queue limits and sysfs for
 copy-offload support
To: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: martin.petersen@oracle.com, david@fromorbit.com, hare@suse.de,
 damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com, joshi.k@samsung.com,
 nitheshshetty@gmail.com, gost.dev@samsung.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520102830epcas5p27274901f3d0c2738c515709890b1dec4@epcas5p2.samsung.com>
 <20240520102033.9361-2-nj.shetty@samsung.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240520102033.9361-2-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/24 03:20, Nitesh Shetty wrote:
> +static ssize_t queue_copy_max_show(struct request_queue *q, char *page)
> +{
> +	return sprintf(page, "%llu\n", (unsigned long long)
> +		       q->limits.max_copy_sectors << SECTOR_SHIFT);
> +}
> +
> +static ssize_t queue_copy_max_store(struct request_queue *q, const char *page,
> +				    size_t count)
> +{
> +	unsigned long max_copy_bytes;
> +	struct queue_limits lim;
> +	ssize_t ret;
> +	int err;
> +
> +	ret = queue_var_store(&max_copy_bytes, page, count);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (max_copy_bytes & (queue_logical_block_size(q) - 1))
> +		return -EINVAL;

Wouldn't it be more user-friendly if this check would be left out? Does any code
depend on max_copy_bytes being a multiple of the logical block size?

> +	blk_mq_freeze_queue(q);
> +	lim = queue_limits_start_update(q);
> +	lim.max_user_copy_sectors = max_copy_bytes >> SECTOR_SHIFT;
> +	err = queue_limits_commit_update(q, &lim);
> +	blk_mq_unfreeze_queue(q);
> +
> +	if (err)
> +		return err;
> +	return count;
> +}

queue_copy_max_show() shows max_copy_sectors while queue_copy_max_store()
modifies max_user_copy_sectors. Is that perhaps a bug?

> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index aefdda9f4ec7..109d9f905c3c 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -309,6 +309,10 @@ struct queue_limits {
>   	unsigned int		discard_alignment;
>   	unsigned int		zone_write_granularity;
>   
> +	unsigned int		max_copy_hw_sectors;
> +	unsigned int		max_copy_sectors;
> +	unsigned int		max_user_copy_sectors;

Two new limits are documented in Documentation/ABI/stable/sysfs-block while three
new parameters are added in struct queue_limits. Why three new limits instead of
two? Please add a comment above the new parameters that explains the role of the
new parameters.

> +/* maximum copy offload length, this is set to 128MB based on current testing */
> +#define BLK_COPY_MAX_BYTES		(1 << 27)

"current testing" sounds vague. Why is this limit required? Why to cap what the
driver reports instead of using the value reported by the driver without modifying it?

Additionally, since this constant is only used in source code that occurs in the
block/ directory, please move the definition of this constant into a source or header
file in the block/ directory.

Thanks,

Bart.

