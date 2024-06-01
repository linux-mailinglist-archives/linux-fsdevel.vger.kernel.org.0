Return-Path: <linux-fsdevel+bounces-20698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EC78D6E6D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 08:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790BC1C2439F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 06:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF3418E20;
	Sat,  1 Jun 2024 06:18:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9BE14A8F;
	Sat,  1 Jun 2024 06:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717222726; cv=none; b=Y+FsIgD41+krr5XzI5a4kQw/0uD9BSlQFa7KmTzPTEtDmt1AUDkSBJJdXesg/VmCWCvwrFrJg+0FClJ2PCAanXM1Oo0M5/vQMK33dp02yWQDHBRZ/u/abPbBwb5C2e8SYG9Yp/RTgjEzoGa/Dg2lBBnwTM46gDIiK3EuGNP3nxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717222726; c=relaxed/simple;
	bh=rrBjQRF40NCxkbGV+C8UNlmDmwTUguMTPm33YC2RW1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AunoQjkmJFDRo/1IdxFOeDaIbD0rNYdTo+vXiiFs/H4CQUtjOzThWLgI0llfmIIUFN5IUCSerhBoNDtcxGzLm8cCMeIMxdjS3e/EG2vXWXsZMz2OuMDoa+KzemAsF4Aaff8P1JZj+zJpovxBjXExc9mkRMz8NhlRJU1c2mqekWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C5AF668D17; Sat,  1 Jun 2024 08:18:39 +0200 (CEST)
Date: Sat, 1 Jun 2024 08:18:39 +0200
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
	gost.dev@samsung.com, Vincent Fu <vincent.fu@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 04/12] block: add emulation for copy
Message-ID: <20240601061839.GA6221@lst.de>
References: <20240520102033.9361-1-nj.shetty@samsung.com> <CGME20240520102906epcas5p15b5a0b3c8edd0bf3073030a792a328bb@epcas5p1.samsung.com> <20240520102033.9361-5-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520102033.9361-5-nj.shetty@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 20, 2024 at 03:50:17PM +0530, Nitesh Shetty wrote:
> For the devices which does not support copy, copy emulation is added.
> It is required for in-kernel users like fabrics, where file descriptor is
> not available and hence they can't use copy_file_range.
> Copy-emulation is implemented by reading from source into memory and
> writing to the corresponding destination.
> At present in kernel user of emulation is fabrics.

I still don't see the point of offering this in the block layer,
at least in this form.  Caller usually can pre-allocate a buffer
if they need regular copies instead of doing constant allocation
and freeing which puts a lot of stress on the page allocator.

> +static void *blkdev_copy_alloc_buf(ssize_t req_size, ssize_t *alloc_size,
> +				   gfp_t gfp)
> +{
> +	int min_size = PAGE_SIZE;
> +	char *buf;
> +
> +	while (req_size >= min_size) {
> +		buf = kvmalloc(req_size, gfp);
> +		if (buf) {
> +			*alloc_size = req_size;
> +			return buf;
> +		}
> +		req_size >>= 1;
> +	}
> +
> +	return NULL;

And requiring a kernel mapping for data is is never used through the
kernel mapping is pretty silly as well.


