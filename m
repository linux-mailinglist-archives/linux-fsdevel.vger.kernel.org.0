Return-Path: <linux-fsdevel+bounces-19847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D26C28CA4D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 01:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FEF71C2194B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 23:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69E6137C3D;
	Mon, 20 May 2024 23:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="PehElcPu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A198821A19;
	Mon, 20 May 2024 23:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716246056; cv=none; b=cva0bfEKHBwDbT2BFrJ2qmLeflgW43zRdG4ZWZDlyaHJ3rrhqopBNp8TS4UyXP4yWFPr+UYpuq4I5bms7THmRUIMy4GcFBHSrDESqeyN8zD5nFUtjyd42UPB6dG7oCVepIqCbyZ3usPE/xByQEbyt8tDgIl4fbNBHCWnnsLawwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716246056; c=relaxed/simple;
	bh=YlyTrSSipIq1XdyrNQcG1cVd/lYeIVy80ljs/ukemSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eAzzQ8pMo4lfYzNGKYLzCoR4HnBSD4rw8vYPx8LRypbM62ttzQUMQFiiAPJEsyjxPQHAtNiAe9jWG9IZMxUkJEnhlJ1/glypO0d5pW+JdAipXwp5YOiZe5GJEzfeK1kQ1sEp6EPr6L+l4pCzsQgJurlnvRtR24dwv42wenIeHZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=PehElcPu; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VjtMn72SPzlgT1M;
	Mon, 20 May 2024 23:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1716246043; x=1718838044; bh=aQw2Zj5KUIsDa/ieOYZbm2/6
	v2+/XhgWeavOqCOY00I=; b=PehElcPuR16ne23nVJjyCLEC5pZTGgL7HlZ2Kxua
	n2cwa+5UETakW7BozQAxpiAOpJNiQFoblE0sO8W9zGZntLgVq+L4+ssB7w8ydWF0
	e4GcyRfpv0dqMzQcYSOQJtonTQj/RgJPpG6TZPrLRHqk6q0ODeVa4IIGzLpomuVb
	KYkARosoHEDcCYuqQIoi56SXg+zG1cb0ynEhlwnZ9hatPelhQSc1RG4KuAFfhInH
	fvDLZKA3tDDmosxmSsRsejPyax7kXYcOdl2G4tVfdrUPo+0VihiYOqfd7nfyaxnR
	y4eTSKEkR1JoNPCQfutPSg+Wnle/Lby43uuuoMcMS5w46g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id hxkO5ubB-DWu; Mon, 20 May 2024 23:00:43 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VjtMT2NMKzlgT1K;
	Mon, 20 May 2024 23:00:36 +0000 (UTC)
Message-ID: <086804a4-daa4-48a3-a7db-1d38385df0c1@acm.org>
Date: Mon, 20 May 2024 16:00:34 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
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
 <CGME20240520102842epcas5p4949334c2587a15b8adab2c913daa622f@epcas5p4.samsung.com>
 <20240520102033.9361-3-nj.shetty@samsung.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240520102033.9361-3-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/24 03:20, Nitesh Shetty wrote:
> Upon arrival of source bio we merge these two bio's and send
> corresponding request down to device driver.

bios with different operation types must not be merged.

> +static enum bio_merge_status bio_attempt_copy_offload_merge(struct request *req,
> +							    struct bio *bio)
> +{
> +	if (req->__data_len != bio->bi_iter.bi_size)
> +		return BIO_MERGE_FAILED;
> +
> +	req->biotail->bi_next = bio;
> +	req->biotail = bio;
> +	req->nr_phys_segments++;
> +	req->__data_len += bio->bi_iter.bi_size;
> +
> +	return BIO_MERGE_OK;
> +}

This function appends a bio to a request. Hence, the name of this function is
wrong.

> @@ -1085,6 +1124,8 @@ static enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
>   		break;
>   	case ELEVATOR_DISCARD_MERGE:
>   		return bio_attempt_discard_merge(q, rq, bio);
> +	case ELEVATOR_COPY_OFFLOAD_MERGE:
> +		return bio_attempt_copy_offload_merge(rq, bio);
>   	default:
>   		return BIO_MERGE_NONE;
>   	}

Is any code added in this patch series that causes an I/O scheduler to return
ELEVATOR_COPY_OFFLOAD_MERGE?

> +static inline bool blk_copy_offload_mergable(struct request *req,
> +					     struct bio *bio)
> +{
> +	return (req_op(req) == REQ_OP_COPY_DST &&
> +		bio_op(bio) == REQ_OP_COPY_SRC);
> +}

bios with different operation types must not be merged. Please rename this function.

> +static inline bool op_is_copy(blk_opf_t op)
> +{
> +	return ((op & REQ_OP_MASK) == REQ_OP_COPY_SRC ||
> +		(op & REQ_OP_MASK) == REQ_OP_COPY_DST);
> +}

The above function is not used in this patch. Please introduce new functions in the
patch in which these are used for the first time.

Thanks,

Bart.


