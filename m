Return-Path: <linux-fsdevel+bounces-58978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F0FB33A09
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 10:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9CB18945ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 08:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DD42BDC27;
	Mon, 25 Aug 2025 08:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPK+XFEU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644F42BDC09
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 08:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756112245; cv=none; b=jApxls/Sl9rWvy1tbm1oC4cCar11aPJ7nozwRA17uJynp2bqUnQ0id6qSVNqeFrnoFaAzSt0AWkBoHPlwXOsH2uRg6bZss9XuvJMhr0OP0YS3nq73Lyxlp9y1RSjNUYiRqIOq0iKSACE79VryJ+JjBpQuUC2z06TDIiM7UIChjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756112245; c=relaxed/simple;
	bh=XmteRMqIfyW1t1SAfI9KMzAV/m4EX4m9sJvSbiUJqpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyNpCp7hxptZF9Nr9K9lWo9jWodQEEUa2y4XrZC3cx8HHdbHZn77AM2Yc2VxpfhPfepJXH3K6dVbkCr8g3G8/MvODJXilmR/0Kdh+jJwdCgPi6neUtl/jpIOiYRkyQMhv2HbLLpbRIiueNnSI8FjCaDIbqDGS/BpIbfS6H1y+Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QPK+XFEU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756112242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MvFCkdmFWuDahsv4SQZaZ/mWWh50fu2t+oCLVs7oQN4=;
	b=QPK+XFEURUYZfv0P/KDEBuRXAIOwxgt2D8bNsmwq0FoeqJZOUm7EQKA94sXnRHs9Wf40sG
	7hksMkEvYgneuGfm7wgRJs9mI3UhY5hh7rZsX3eZXBjzjIt1OtOu+4e8HWasjewYHPxQ/g
	u0+qO44G8BfgjHit76Q0Qb31615+iBI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-t9-ib7rfML6Js5v3Kg-R6g-1; Mon,
 25 Aug 2025 04:57:18 -0400
X-MC-Unique: t9-ib7rfML6Js5v3Kg-R6g-1
X-Mimecast-MFC-AGG-ID: t9-ib7rfML6Js5v3Kg-R6g_1756112236
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C90261800352;
	Mon, 25 Aug 2025 08:57:14 +0000 (UTC)
Received: from fedora (unknown [10.72.116.84])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DAAEC1955F24;
	Mon, 25 Aug 2025 08:57:05 +0000 (UTC)
Date: Mon, 25 Aug 2025 16:56:55 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, rajeevm@hpe.com, yukuai3@huawei.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] loop: fix zero sized loop for block special file
Message-ID: <aKwlVypJuBtPH_EL@fedora>
References: <20250825062300.2485281-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825062300.2485281-1-yukuai1@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Aug 25, 2025 at 02:23:00PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> By default, /dev/sda is block specail file from devtmpfs, getattr will
> return file size as zero, causing loop failed for raw block device.
> 
> We can add bdev_statx() to return device size, however this may introduce
> changes that are not acknowledged by user. Fix this problem by reverting
> changes for block special file, file mapping host is set to bdev inode
> while opening, and use i_size_read() directly to get device size.
> 
> Fixes: 47b71abd5846 ("loop: use vfs_getattr_nosec for accurate file size")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202508200409.b2459c02-lkp@intel.com
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/block/loop.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 57263c273f0f..cde235bd883c 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -153,6 +153,9 @@ static loff_t lo_calculate_size(struct loop_device *lo, struct file *file)
>  		return 0;
>  
>  	loopsize = stat.size;
> +	if (!loopsize && S_ISBLK(stat.mode))
> +		loopsize = i_size_read(file->f_mapping->host);

`stat $BDEV_PATH` never works for getting bdev size, so it looks wrong
to call vfs_getattr_nosec() with bdev path for retrieving bdev's size.

So just wondering why not take the following more readable way?

	/* vfs_getattr() never works for retrieving bdev size */
	if (S_ISBLK(stat.mode)) {
		loopsize = i_size_read(file->f_mapping->host);
	} else {
          ret = vfs_getattr_nosec(&file->f_path, &stat, STATX_SIZE, 0);
          if (ret)
                  return 0;
          loopsize = stat.size;
	}

Also the above looks like how application reads file size in case of bdev
involved.


Thanks,
Ming


