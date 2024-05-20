Return-Path: <linux-fsdevel+bounces-19850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 133918CA52A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 01:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442CF1C21968
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 23:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D181386BD;
	Mon, 20 May 2024 23:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="kCzSBQht"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549663B182;
	Mon, 20 May 2024 23:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716248595; cv=none; b=VKQLpVSV9gSnNfW+aAQb2XgmtkafvY+mr+BEPTbQxg46Y0MI4y2qewJxJdoQjEIAS7dcQEHscjLHEtw2XieJSP1/q8q9luA8w5s5+z5ogT+jMiQMEww1gKFreOox6VW+J0uB2Pc5+cnpvlJPZeBZcj4Iu6xMH/qaL6zK7xPTqzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716248595; c=relaxed/simple;
	bh=XI0ilmooLeYwpmsoKJHHHdPY4156763P5d8LFnYqgoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YV/NB7vKtQD28boJSeSxTupHMFg3v4Gd+o4tt7yCSmZGawTGg28MQZfvUGHLsjBSJFT5DrqjwpYPP6qrZnF5P589pdbljl0NcuSTt62MlqzjXa/7BL5NbiXsQeorPOCYAPEBb+Bsf+8IZUKozNv5oAhET6rhkE/M98yYmxlFgG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=kCzSBQht; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VjvJd4CZRzlgT1M;
	Mon, 20 May 2024 23:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1716248582; x=1718840583; bh=OyFlC0B3t3C3QPALfJEi8R8r
	d3f1cHbIyvzodAAs6QI=; b=kCzSBQhtvR/gwexX/OBMgW8+9uPM2XLI1Io3VPXA
	ExEWQOuBhyfGPlN9tKDNhM1K5E9x0eL/9Ri9AdYtHgjzysrJytIcu7gSGlYMqkC1
	Ca0Br0owVaLiVVu/FpxEEeojwBG57vo0FCdc3OsdSmOf3dbvEfYzJI+8HE3qe1mY
	vWMZfvF/OU5X5BG4RLWTW0ODrCRsLtIGJvzZdTxgA+cC1AMYouzEw6foDJqXDpTK
	uX+zra2D0UtQsL7OjinTTCVPnMzbGsRgtbIkhkpB3RbRPFifE6E+Yyl7LBzNEdmL
	zV5OOA6ldYfH80zPuAQxjF6hg/HtlnLKdM/Dhm7yFWNcsw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id EgVMztfS5ec5; Mon, 20 May 2024 23:43:02 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VjvJH2Hf4zlgT1K;
	Mon, 20 May 2024 23:42:54 +0000 (UTC)
Message-ID: <2433bc0d-3867-475d-b472-0f6725f9a296@acm.org>
Date: Mon, 20 May 2024 16:42:52 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 12/12] null_blk: add support for copy offload
To: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: martin.petersen@oracle.com, david@fromorbit.com, hare@suse.de,
 damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com, joshi.k@samsung.com,
 nitheshshetty@gmail.com, gost.dev@samsung.com,
 Vincent Fu <vincent.fu@samsung.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520103039epcas5p4373f7234162a32222ac225b976ae30ce@epcas5p4.samsung.com>
 <20240520102033.9361-13-nj.shetty@samsung.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240520102033.9361-13-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/24 03:20, Nitesh Shetty wrote:
> +	if (blk_rq_nr_phys_segments(req) != BLK_COPY_MAX_SEGMENTS)
> +		return status;

Why is this check necessary?

> +	/*
> +	 * First bio contains information about destination and last bio
> +	 * contains information about source.
> +	 */

Please check this at runtime (WARN_ON_ONCE()?).

> +	__rq_for_each_bio(bio, req) {
> +		if (seg == blk_rq_nr_phys_segments(req)) {
> +			sector_in = bio->bi_iter.bi_sector;
> +			if (rem != bio->bi_iter.bi_size)
> +				return status;
> +		} else {
> +			sector_out = bio->bi_iter.bi_sector;
> +			rem = bio->bi_iter.bi_size;
> +		}
> +		seg++;
> +	}

_rq_for_each_bio() iterates over the bios in a request. Does a copy
offload request always have two bios - one copy destination bio and
one copy source bio? If so, is 'seg' a bio counter? Why is that bio
counter compared with the number of physical segments in the request?

> +	trace_nullb_copy_op(req, sector_out << SECTOR_SHIFT,
> +			    sector_in << SECTOR_SHIFT, rem);
> +
> +	spin_lock_irq(&nullb->lock);
> +	while (rem > 0) {
> +		chunk = min_t(size_t, nullb->dev->blocksize, rem);
> +		offset_in = (sector_in & SECTOR_MASK) << SECTOR_SHIFT;
> +		offset_out = (sector_out & SECTOR_MASK) << SECTOR_SHIFT;
> +
> +		if (null_cache_active(nullb) && !is_fua)
> +			null_make_cache_space(nullb, PAGE_SIZE);
> +
> +		t_page_in = null_lookup_page(nullb, sector_in, false,
> +					     !null_cache_active(nullb));
> +		if (!t_page_in)
> +			goto err;
> +		t_page_out = null_insert_page(nullb, sector_out,
> +					      !null_cache_active(nullb) ||
> +					      is_fua);
> +		if (!t_page_out)
> +			goto err;
> +
> +		in = kmap_local_page(t_page_in->page);
> +		out = kmap_local_page(t_page_out->page);
> +
> +		memcpy(out + offset_out, in + offset_in, chunk);
> +		kunmap_local(out);
> +		kunmap_local(in);
> +		__set_bit(sector_out & SECTOR_MASK, t_page_out->bitmap);
> +
> +		if (is_fua)
> +			null_free_sector(nullb, sector_out, true);
> +
> +		rem -= chunk;
> +		sector_in += chunk >> SECTOR_SHIFT;
> +		sector_out += chunk >> SECTOR_SHIFT;
> +	}
> +
> +	status = 0;
> +err:
> +	spin_unlock_irq(&nullb->lock);

In the worst case, how long does this loop disable interrupts?

> +TRACE_EVENT(nullb_copy_op,
> +		TP_PROTO(struct request *req,
> +			 sector_t dst, sector_t src, size_t len),
> +		TP_ARGS(req, dst, src, len),
> +		TP_STRUCT__entry(
> +				 __array(char, disk, DISK_NAME_LEN)
> +				 __field(enum req_op, op)
> +				 __field(sector_t, dst)
> +				 __field(sector_t, src)
> +				 __field(size_t, len)
> +		),

Isn't __string() preferred over __array() since the former occupies less space
in the trace buffer?

Thanks,

Bart.

