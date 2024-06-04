Return-Path: <linux-fsdevel+bounces-20942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF00E8FB0EA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 13:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0318283257
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 11:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F63145A11;
	Tue,  4 Jun 2024 11:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="m9vmAwAY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BCE1459F7
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 11:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717499823; cv=none; b=Wl4Bc/3kAehBdeXryKQRMjdnC7TwpmFGaUYe/vpUS4TwZr6r3VtmJHGJx73tWjRnJD8//5XP/MWEdtPmP/08+pzJcnTd8QcOnsX29IeIZ9MjvmjRU6pvfQ2qFEyc7VRpy7yoCsOmnbFRveo9fQMaCe5OdiK8OTpVYGsF7+rGO7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717499823; c=relaxed/simple;
	bh=w1qLzV6HLbncwtVgujIXk3Ig+Tx0IuJ6cVsXrxxlnIU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=rGFeJHhN/SMuQ5OtACJWaFBjjaZdm/3p0qPvR7Q2rve2uK7qoh7Lz0w3Hd5oLPnp6zZanRiW3/jV93xTNfl+LoHN31KtJ1HMj2SV5m5U9sLhF771TepT5G+rbsYWnpVaVQlchhshzH++mm3DERbEjjU4Ze3BUM4CJE2wO8eMv/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=m9vmAwAY; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240604111654epoutp033b972d8dc00c26e58fb9d11357678716~VyPtGwM081317813178epoutp03m
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 11:16:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240604111654epoutp033b972d8dc00c26e58fb9d11357678716~VyPtGwM081317813178epoutp03m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717499814;
	bh=W7mPVzQZKRnQDYV+JCtWF0MGoPHuyGT3TYodiOO+3YY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m9vmAwAYD9ZesX8pO9KnR/yMfiQ00Kho/W5I/6d5Z6Uj+zp6fiWCif8ROFnT1PSr/
	 UIZDfdAr7DSKkLHKyRHmhERSgk7MUnu2rd6fMgjDgAzN2wYGcj9Jm3ru5NWsv48Mby
	 7sPIJOsKrk4kRjxZdVy3rYV9TTU6mTKGIT0f3Wvo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240604111652epcas5p2fb3ff3af2b3a5585597af0238a75772f~VyPrPc7rW2355423554epcas5p2h;
	Tue,  4 Jun 2024 11:16:52 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Vtp2T6y1Mz4x9Q2; Tue,  4 Jun
	2024 11:16:49 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C2.66.10047.1A7FE566; Tue,  4 Jun 2024 20:16:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240604105019epcas5p421855f0d2b36c064b41d485af4e2b0cc~Vx4fR6XxJ1521215212epcas5p4c;
	Tue,  4 Jun 2024 10:50:19 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240604105019epsmtrp2dc2736f53c71be92ea56db72bbf4b564~Vx4fP8yoS0411204112epsmtrp2U;
	Tue,  4 Jun 2024 10:50:19 +0000 (GMT)
X-AuditID: b6c32a49-1d5fa7000000273f-2e-665ef7a1bfea
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	42.D4.08336.A61FE566; Tue,  4 Jun 2024 19:50:18 +0900 (KST)
Received: from nj.shetty?samsung.com (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240604105014epsmtip21cc93a7a862e372e31a4b74374219763~Vx4bJDtP80565705657epsmtip2z;
	Tue,  4 Jun 2024 10:50:14 +0000 (GMT)
Date: Tue, 4 Jun 2024 10:50:26 +0000
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg
	<sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, martin.petersen@oracle.com, bvanassche@acm.org,
	david@fromorbit.com, hare@suse.de, damien.lemoal@opensource.wdc.com,
	anuj20.g@samsung.com, joshi.k@samsung.com, nitheshshetty@gmail.com,
	gost.dev@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 03/12] block: add copy offload support
Message-ID: <20240604105026.yqza6ahoo52bbvle@nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240601061653.GA5877@lst.de>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ta1BUZRjHfc/ZPSxOq4eL9gKDwZHJYOOyucALgjSKzCH6AKM1pgbuwOEi
	y+62u2SRU9wRBOQSNiyiK6ErlwSEiKshCgi1EnEbELAS0riHATGM0i67NH77Pf957s88HNz0
	upElJ0qsYGRioYgitrPq79nbO15bDQ53WR4SoKqeThwl5rzAUcX4RQLN3FsC6NLiGo4m29IA
	Wtf04qiucwIgVUkxC420NWKopSQPQ2UVHRgq+iYJQx0bcwTKax8CaGpQiaHWUR66llrKQi2t
	3SzU33SZQFdvTBkhdddLDOWeH8RQw2QCQLdmFljowagV6n3RxX7Xiu4fCKB7SiDdqBw3onsn
	alh0vyaWvl2eTtC1pV/Rz2oLAd08Ek/Q32bns+mspHmCbkx5zKb/nhpl0Qt3Bgk6u64c0D+r
	7hsFmp2I9opkhGGMzIYRh0rCosQR3lTA0ZDDIa5uLnxHvgdyp2zEwhjGm/J9P9DRL0qkXQ5l
	86lQFKuVAoVyOeV80EsmiVUwNpESucKbYqRhIqlA6iQXxshjxRFOYkbhyXdxecdV63g6OrIl
	Z42Qprz9WfVAKRYP6vZmAGMOJAWwNb0IywDbOaZkM4CTCfVsvbEEYH6JkqU3VgAs7nwEtkIG
	ljS4jk3JVgCHMwz8HMBf1mx1zCLt4Fz5U6MMwOEQJA/+tMHRyeYkBaemNZtpcLKAgBtKKx2b
	kQfhj6l3N3UueRheuFJgYBPYXTjJ0rGxNk1efjeh6weSD41h4g9P2Pp+fOH9O5W4ns3gdFed
	kZ4t4fP5VkLPZ2HZ1zcNwckAKoeVhmF8YErPRVzfUSRs+avUkMgaFvTcwvT6Dpi1PonpdS5s
	uLLFe2FllcpQwAIOrSYYmIbKPt2Uus2NATg2m87KAXuUr0ykfKWenj1h+mIiW6ldGE5aQfVL
	jh7tYVWTswqwy4EFI5XHRDByVylfzJz9/8ihkpjbYPNfHPwbwPhvi07tAOOAdgA5OGXOzf7y
	ZLgpN0z4eRwjk4TIYkWMvB24ag+Ui1vuCpVoH06sCOELPFwEbm5uAo/9bnzqde5MSnGYKRkh
	VDDRDCNlZFtxGMfYMh7z7/B7aqPmWqoeV/rffLKslhSuVh6nM8Ufjg0kWqSdW87WaMIbd69Y
	N5PAAf9+/t+l9tPJV8k3XCKDDsQ93Gl7LPiYfZ0ka1/PJytH4Zszw7yPRkVq3q6+U8Hj7h1V
	H8xmBqhNTGw9D9Hni9x3z03gNSd8ugXnAJX28Vt3k0YGHgQe+qKv9ddAdpprfmKB1/Emu6qO
	5f3rSkk6d4f5H+ZN/u9lTo8sbStbexbUW1b0p6ra2ndPk8wjZtqrxC5oQfHPdwdqbBwvWbV1
	i0h6J3XSC3ilnyra5jPV7epsWfja7/sq8nwOHalMTeZVq+p4DTc6eusbzlxHj/zkuW1HLp+Z
	jRuvpVjySCHfAZfJhf8Bt94OkLgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsWy7bCSvG7Wx7g0g+8fjC3WnzrGbNE04S+z
	xeq7/WwWrw9/YrSY9uEns8WTA+2MFr/Pnme22HLsHqPFgkVzWSxuHtjJZLFn0SQmi5WrjzJZ
	zJ7ezGRx9P9bNotJh64xWjy9OovJYu8tbYuFbUtYLPbsPclicXnXHDaL+cueslssP/6PyWJi
	x1Umix1PGhkt1r1+z2Jx4pa0xfm/x1kdpD0uX/H2OLVIwmPnrLvsHufvbWTxuHy21GPTqk42
	j81L6j1ebJ7J6LH7ZgObx+K+yawevc3v2Dx2tt5n9fj49BaLx/t9V9k8+rasYvQ4s+AIe4Bw
	FJdNSmpOZllqkb5dAlfGpb/5Bds1K/oO9bE0MDYodjFyckgImEhc+XSWuYuRi0NIYDejxJOz
	U5kgEpISy/4eYYawhSVW/nvODmILCXxklLiyOxLEZhFQkXi7CiTOwcEmoC1x+j8HSFhEQEni
	6auzjCA2s8BMNokz83NBbGEBO4n9bQfB4rwCzhLd86YyQuy9xygxbdcbFoiEoMTJmU9YIJrN
	JOZtfsgMMp9ZQFpi+T+w+ZxAqyZNPsk2gVFgFpKOWUg6ZiF0LGBkXsUomVpQnJueW2xYYJiX
	Wq5XnJhbXJqXrpecn7uJEZwStDR3MG5f9UHvECMTB+MhRgkOZiUR3r666DQh3pTEyqrUovz4
	otKc1OJDjNIcLErivOIvelOEBNITS1KzU1MLUotgskwcnFINTOs+bj92WPe7Q1ZYfL/AE+cV
	uzTSbO2zBA4Wxm6JO7J9o96KUpHG6eW6CRxNrHc/nWzI+/lq8d865tisE0V1AofZvvUpe9br
	JL3XzBMoyl/76CTnInZRpb7dXhkCT91PyRxRy//byPvadunJhr4J00NimFdcZz32kV880d3x
	/+rtXtuDqj87Pbg399Ndn6cPfuW8lPtUuHLFvZMil561RLWcvfS61UEv88TqSoUjLzhFmVT2
	/9r7YntAo+tRwfMmc9nVn7NqvOoXuyq5d6G8yKmTS3lkmteeXVEbtdH8pNW+D4qSm/ve7dVP
	mbjfKPNyZR/Pwt32cUfezr3afShkoZm5p3dSje4vj4pL1d5v1yqxFGckGmoxFxUnAgC7zesq
	eAMAAA==
X-CMS-MailID: 20240604105019epcas5p421855f0d2b36c064b41d485af4e2b0cc
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----NniuWcEa.zZVU-iq4JS_ZFjyXsesTFtE.O7X-O5.k3Ud19D7=_58104_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520102853epcas5p42d635d6712b8876ea22a45d730cb1378
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520102853epcas5p42d635d6712b8876ea22a45d730cb1378@epcas5p4.samsung.com>
	<20240520102033.9361-4-nj.shetty@samsung.com> <20240601061653.GA5877@lst.de>

------NniuWcEa.zZVU-iq4JS_ZFjyXsesTFtE.O7X-O5.k3Ud19D7=_58104_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 01/06/24 08:16AM, Christoph Hellwig wrote:
>> +/* Keeps track of all outstanding copy IO */
>> +struct blkdev_copy_io {
>> +	atomic_t refcount;
>> +	ssize_t copied;
>> +	int status;
>> +	struct task_struct *waiter;
>> +	void (*endio)(void *private, int status, ssize_t copied);
>> +	void *private;
>> +};
>> +
>> +/* Keeps track of single outstanding copy offload IO */
>> +struct blkdev_copy_offload_io {
>> +	struct blkdev_copy_io *cio;
>> +	loff_t offset;
>> +};
>
>The structure names confuse me, and the comments make things even worse.
>
>AFAICT:
>
>blkdev_copy_io is a per-call structure, I'd name it blkdev_copy_ctx.
>blkdev_copy_offload_io is per-bio pair, and something like blkdev_copy_chunk
Acked, your suggestion for structure name looks better.

>might be a better idea.  Or we could just try to kill it entirely and add
>a field to struct bio in the union currently holding the integrity
>information.
We will explore this.

>I'm also quite confused what kind of offset this offset field is.  The
>type and name suggest it is an offset in a file, which for a block device
>based helper is pretty odd to start with.  blkdev_copy_offload
>initializes it to len - rem, so it kind is an offset, but relative
>to the operation and not to a file. blkdev_copy_offload_src_endio then
>uses to set the ->copied field, but based on a min which means
>->copied can only be decreased.  Something is really off there.
>
Offset in this context, is with respect to the operation.
Overall idea was to handle partial copy, where in some of the split copy IO fails.
In this case we want to return minimum bytes copied.
We can try to store the offset in a temporary variable similar to
pos_out, pos_in instead of current (len - rem), to avoid the confusion.
We will update this in next version.

>Taking about types and units: blkdev_copy_offload obviously can only
>work in terms of LBAs.  Any reason to not make it work in terms of
>512-byte block layer sectors instead of in bytes?
>
Just that number of places where we need to sector shift were
comparatively more. We will update this to 512-byte sectors in next
version.

>> +	if ((pos_in & align) || (pos_out & align) || (len & align) || !len ||
>> +	    len >= BLK_COPY_MAX_BYTES)
>> +		return -EINVAL;
>
>This can be cleaned up an optimized a bit:
>
>	if (!len || len >= BLK_COPY_MAX_BYTES)
>		return -EINVAL;
>	if ((pos_in | pos_out | len) & align)
>		return -EINVAL;
>	
Acked.

>> + *
>> + * For synchronous operation returns the length of bytes copied or error
>> + * For asynchronous operation returns -EIOCBQUEUED or error
>> + *
>> + * Description:
>> + *	Copy source offset to destination offset within block device, using
>> + *	device's native copy offload feature.
>> + *	We perform copy operation using 2 bio's.
>> + *	1. We take a plug and send a REQ_OP_COPY_DST bio along with destination
>> + *	sector and length. Once this bio reaches request layer, we form a
>> + *	request and wait for dst bio to arrive.
>> + *	2. We issue REQ_OP_COPY_SRC bio along with source sector, length.
>> + *	Once this bio reaches request layer and find a request with previously
>> + *	sent destination info we merge the source bio and return.
>> + *	3. Release the plug and request is sent to driver
>> + *	This design works only for drivers with request queue.
>
>The wording with all the We here is a bit odd.  Much of this also seem
>superfluous or at least misplaced in the kernel doc comment as it doesn't
>document the API, but just what is done in the code below.
>
Since we were doing IO in unconventional way, we felt would be better to
document this, for easy followup.
We will remove this in next version and document just API.

>> +	cio = kzalloc(sizeof(*cio), gfp);
>> +	if (!cio)
>> +		return -ENOMEM;
>> +	atomic_set(&cio->refcount, 1);
>> +	cio->waiter = current;
>> +	cio->endio = endio;
>> +	cio->private = private;
>
>For the main use this could be allocated on-stack.  Is there any good
>reason to not let callers that really want an async version to implement
>the async behavior themselves using suitable helpers?
>
We cannot do on-stack allocation of cio as we use it in endio handler.
cio will be used to track partial IO completion as well.
Callers requiring async implementation would need to manage all this
bookkeeping themselves, leading to duplication of code. We felt it is
better to do it here onetime.
Do you see it any differently ?

>> +		src_bio = blk_next_bio(dst_bio, bdev, 0, REQ_OP_COPY_SRC, gfp);
>
>Please switch to use bio_chain_and_submit, which is a easier to
>understand API.  I'm trying to phase out blk_next_bio in favour of
>bio_chain_and_submit over the next few merge windows.
>
Acked

>> +		if (!src_bio)
>> +			goto err_free_dst_bio;
>> +		src_bio->bi_iter.bi_size = chunk;
>> +		src_bio->bi_iter.bi_sector = pos_in >> SECTOR_SHIFT;
>> +		src_bio->bi_end_io = blkdev_copy_offload_src_endio;
>> +		src_bio->bi_private = offload_io;
>> +
>> +		atomic_inc(&cio->refcount);
>> +		submit_bio(src_bio);
>> +		blk_finish_plug(&plug);
>
>plugs should be hold over all  I/Os, submitted from the same caller,
>which is the point of them.
>
Acked

Thank You,
Nitesh Shetty

------NniuWcEa.zZVU-iq4JS_ZFjyXsesTFtE.O7X-O5.k3Ud19D7=_58104_
Content-Type: text/plain; charset="utf-8"


------NniuWcEa.zZVU-iq4JS_ZFjyXsesTFtE.O7X-O5.k3Ud19D7=_58104_--

