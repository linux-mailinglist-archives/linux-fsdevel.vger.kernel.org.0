Return-Path: <linux-fsdevel+bounces-20697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 009088D6E60
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 08:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8DA128A448
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 06:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666D417999;
	Sat,  1 Jun 2024 06:17:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6580613ACC;
	Sat,  1 Jun 2024 06:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717222623; cv=none; b=aLziQIB0HFKy/vj7iVg/zduHzNeaEGkpQEmkqIXLf74rpT+lYmJvg+DkNHahCAzhZUJX+C1riyzZ/+1ADO+BGDfZZoX4feibN0+bx6U27kLhg8W0b9rYf9lNrQOPfG71mGiy7Hqq/lIp61Tl2Y4TNRP3ujPqZNnhn1Mizf5rxvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717222623; c=relaxed/simple;
	bh=mYTv4Ug6TvETmhZN74+UA6IaoscRuhFzUwxgDby3ZU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8R6t4Ka88OEjnHQMD40TxZQCaMnPS8r6e37sc0TnX9m3zY9TWHxvL0s/iTwBiRjv3Rznr8cwKeV5+GXm3fmkNigKXyCyYVuh8YP0zK+H+Lf5cer990hsoxLiEyMw4bWhh5DP1B4AVnsCWSsS2mHVk5Cu/bKRzjyV0hNLz6Gpmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 97C0668D17; Sat,  1 Jun 2024 08:16:53 +0200 (CEST)
Date: Sat, 1 Jun 2024 08:16:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, bvanassche@acm.org, david@fromorbit.com,
	hare@suse.de, damien.lemoal@opensource.wdc.com,
	anuj20.g@samsung.com, joshi.k@samsung.com, nitheshshetty@gmail.com,
	gost.dev@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 03/12] block: add copy offload support
Message-ID: <20240601061653.GA5877@lst.de>
References: <20240520102033.9361-1-nj.shetty@samsung.com> <CGME20240520102853epcas5p42d635d6712b8876ea22a45d730cb1378@epcas5p4.samsung.com> <20240520102033.9361-4-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520102033.9361-4-nj.shetty@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +/* Keeps track of all outstanding copy IO */
> +struct blkdev_copy_io {
> +	atomic_t refcount;
> +	ssize_t copied;
> +	int status;
> +	struct task_struct *waiter;
> +	void (*endio)(void *private, int status, ssize_t copied);
> +	void *private;
> +};
> +
> +/* Keeps track of single outstanding copy offload IO */
> +struct blkdev_copy_offload_io {
> +	struct blkdev_copy_io *cio;
> +	loff_t offset;
> +};

The structure names confuse me, and the comments make things even worse.

AFAICT:

blkdev_copy_io is a per-call structure, I'd name it blkdev_copy_ctx.
blkdev_copy_offload_io is per-bio pair, and something like blkdev_copy_chunk
might be a better idea.  Or we could just try to kill it entirely and add
a field to struct bio in the union currently holding the integrity
information.

I'm also quite confused what kind of offset this offset field is.  The
type and name suggest it is an offset in a file, which for a block device
based helper is pretty odd to start with.  blkdev_copy_offload
initializes it to len - rem, so it kind is an offset, but relative
to the operation and not to a file. blkdev_copy_offload_src_endio then
uses to set the ->copied field, but based on a min which means
->copied can only be decreased.  Something is really off there.

Taking about types and units: blkdev_copy_offload obviously can only
work in terms of LBAs.  Any reason to not make it work in terms of
512-byte block layer sectors instead of in bytes?

> +	if ((pos_in & align) || (pos_out & align) || (len & align) || !len ||
> +	    len >= BLK_COPY_MAX_BYTES)
> +		return -EINVAL;

This can be cleaned up an optimized a bit:

	if (!len || len >= BLK_COPY_MAX_BYTES)
		return -EINVAL;
	if ((pos_in | pos_out | len) & align)
		return -EINVAL;
	
> + *
> + * For synchronous operation returns the length of bytes copied or error
> + * For asynchronous operation returns -EIOCBQUEUED or error
> + *
> + * Description:
> + *	Copy source offset to destination offset within block device, using
> + *	device's native copy offload feature.
> + *	We perform copy operation using 2 bio's.
> + *	1. We take a plug and send a REQ_OP_COPY_DST bio along with destination
> + *	sector and length. Once this bio reaches request layer, we form a
> + *	request and wait for dst bio to arrive.
> + *	2. We issue REQ_OP_COPY_SRC bio along with source sector, length.
> + *	Once this bio reaches request layer and find a request with previously
> + *	sent destination info we merge the source bio and return.
> + *	3. Release the plug and request is sent to driver
> + *	This design works only for drivers with request queue.

The wording with all the We here is a bit odd.  Much of this also seem
superfluous or at least misplaced in the kernel doc comment as it doesn't
document the API, but just what is done in the code below.

> +	cio = kzalloc(sizeof(*cio), gfp);
> +	if (!cio)
> +		return -ENOMEM;
> +	atomic_set(&cio->refcount, 1);
> +	cio->waiter = current;
> +	cio->endio = endio;
> +	cio->private = private;

For the main use this could be allocated on-stack.  Is there any good
reason to not let callers that really want an async version to implement
the async behavior themselves using suitable helpers?

> +		src_bio = blk_next_bio(dst_bio, bdev, 0, REQ_OP_COPY_SRC, gfp);

Please switch to use bio_chain_and_submit, which is a easier to
understand API.  I'm trying to phase out blk_next_bio in favour of
bio_chain_and_submit over the next few merge windows.

> +		if (!src_bio)
> +			goto err_free_dst_bio;
> +		src_bio->bi_iter.bi_size = chunk;
> +		src_bio->bi_iter.bi_sector = pos_in >> SECTOR_SHIFT;
> +		src_bio->bi_end_io = blkdev_copy_offload_src_endio;
> +		src_bio->bi_private = offload_io;
> +
> +		atomic_inc(&cio->refcount);
> +		submit_bio(src_bio);
> +		blk_finish_plug(&plug);

plugs should be hold over all  I/Os, submitted from the same caller,
which is the point of them.


