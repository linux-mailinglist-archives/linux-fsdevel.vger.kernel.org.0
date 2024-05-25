Return-Path: <linux-fsdevel+bounces-20163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CD38CF216
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 01:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E201C210C2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 23:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE66112A179;
	Sat, 25 May 2024 23:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="TYAcnYSZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B2912A174
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 May 2024 23:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716678592; cv=none; b=DdSweo5MtrPAlcNlVtRQGVGni6Zvkp764jcnD3EWa58pS3Sq5C7SxD+mw5oHSa38/smVtbfmiW7NDzFHP0aX2La+KDKV0/57PD1tPl5Yrb7DvnzoyHFVu7r3cT6XXXRxnlgXWu39atEnyLLb3q0WMKrmB706TKLAvhbzOjNf5m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716678592; c=relaxed/simple;
	bh=faN9rNSdcMcbjtK47u0oId+ibnqpzDbiA+nKCknSZ+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMTTcVnHczRXABlTIPJ4oe8OTUMrSwsqOIh+Ecx+89QsHRfZkuukbdj1IwgJnn+cxCsLOmwEvqrwiDGnyxt/envrYLt5zOQc4fJjJrjxA7RkPYKaUDJ9jQ4WSbEg7amFlh/b3wKFQzQF7OjX+uoSszREVk4rQURcFyWH/ZelSq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=TYAcnYSZ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f48bd643a0so525ad.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 May 2024 16:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1716678571; x=1717283371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Crh6RjgT+TcJb1jq4rCjRtTqJLBvMRyCXUhpelsfOKA=;
        b=TYAcnYSZr305sH9XLnMvStIEDlJaWfuAxeIKJ8RHPQ2FdZChlHVw3WOedEm+oJTNqI
         stTuZ4fQcw6UxiGfRHR90Bp74bwzaixt2GDlsFinFqwsc869LKAliJMxIv9qTmLKte90
         sq9F8bi8bpvUJzN0IUjLPRE9fJjkfjv5gfgmowNLTuqBzw1qcIAMQNDSly1A1w3VVbGl
         8+P7OVtW0gK8XJZGCmv5e1rowLpX51EXhR5iPw/zYbDLRoTZIL2nRgW5TTKIhnQ6151n
         cTidOa1KmAj+ZAT11fKYV1i4bpCfpO+pzVNGRkUDuJnBIDt7bLWMHaeIDv9F1c8BEZf0
         OwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716678571; x=1717283371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Crh6RjgT+TcJb1jq4rCjRtTqJLBvMRyCXUhpelsfOKA=;
        b=q/MgRZVGDLTTf4QyyGT6oeSfEKd8Z4SMfpR2+jHy8JDuN5FvHRsY3OddrSJOPPGpIz
         eWWbeOG5VWe9aEQyum+t6wZOY0Gb+ewX33IPJ+TcD2Q472MYz+cCF1XRerc+vIn240fR
         LkrIDQlnGf2oA/RUowBFBmm4II+t1RHBi8LXhLroKqW11HSY6yjkZDGTQIOHlRRC3ckz
         mFoxGnYN6+CvVpKKtzQqXamYFWX8eAYlCHKbNtweYAGTn4z70Z/5l14FPjUNXdumLRUe
         lWypjD1EjunP7nRPz1RegqwKPoZTlGdQaDzi+DosSBemE3PqGoBE3hxIPPrxfzHlvt1o
         pzFw==
X-Forwarded-Encrypted: i=1; AJvYcCXOr9kKDk0gkr0KeUfR2tCNKfar9BClI0NEFdYbYyyqycsXdEjynj2rX8/QGpcbcanchYDZc5joajJbfKC5syu7B8RrfwGSkquP3GrfTA==
X-Gm-Message-State: AOJu0Yx9174lQm+o5xpE/sEnDIzmMHEplPuIgHFw4U+bJX4fDhZE6kGP
	Fe43Ah64Czpb8tQ24Lx1UKkg1YayNPiIQL9j+POJyNBpdbQ/KVWRczcLUxwOeFE=
X-Google-Smtp-Source: AGHT+IGYciyTBhNiI5PZlCjyMDogB+ANQNNWDCUuYjIsBj+L8eTBYhs5xE8S13XEF72yE6eBkoNGvg==
X-Received: by 2002:a17:902:d50b:b0:1f4:768b:445e with SMTP id d9443c01a7336-1f4768b4768mr21943575ad.24.1716678570642;
        Sat, 25 May 2024 16:09:30 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9afba1sm34658165ad.246.2024.05.25.16.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 16:09:30 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sB0Vz-00AUvI-1V;
	Sun, 26 May 2024 09:09:27 +1000
Date: Sun, 26 May 2024 09:09:27 +1000
From: Dave Chinner <david@fromorbit.com>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, bvanassche@acm.org, hare@suse.de,
	damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
	joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 06/12] fs, block: copy_file_range for def_blk_ops for
 direct block device
Message-ID: <ZlJvp47RSFKkbwRJ@dread.disaster.area>
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520102929epcas5p2f4456f6fa0005d90769615eb2c2bf273@epcas5p2.samsung.com>
 <20240520102033.9361-7-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520102033.9361-7-nj.shetty@samsung.com>

On Mon, May 20, 2024 at 03:50:19PM +0530, Nitesh Shetty wrote:
> For direct block device opened with O_DIRECT, use blkdev_copy_offload to
> issue device copy offload, or use splice_copy_file_range in case
> device copy offload capability is absent or the device files are not open
> with O_DIRECT.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---
>  block/fops.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/block/fops.c b/block/fops.c
> index 376265935714..5a4bba4f43aa 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -17,6 +17,7 @@
>  #include <linux/fs.h>
>  #include <linux/iomap.h>
>  #include <linux/module.h>
> +#include <linux/splice.h>
>  #include "blk.h"
>  
>  static inline struct inode *bdev_file_inode(struct file *file)
> @@ -754,6 +755,30 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	return ret;
>  }
>  
> +static ssize_t blkdev_copy_file_range(struct file *file_in, loff_t pos_in,
> +				      struct file *file_out, loff_t pos_out,
> +				      size_t len, unsigned int flags)
> +{
> +	struct block_device *in_bdev = I_BDEV(bdev_file_inode(file_in));
> +	struct block_device *out_bdev = I_BDEV(bdev_file_inode(file_out));
> +	ssize_t copied = 0;
> +
> +	if ((in_bdev == out_bdev) && bdev_max_copy_sectors(in_bdev) &&
> +	    (file_in->f_iocb_flags & IOCB_DIRECT) &&
> +	    (file_out->f_iocb_flags & IOCB_DIRECT)) {
> +		copied = blkdev_copy_offload(in_bdev, pos_in, pos_out, len,
> +					     NULL, NULL, GFP_KERNEL);
> +		if (copied < 0)
> +			copied = 0;
> +	} else {
> +		copied = splice_copy_file_range(file_in, pos_in + copied,
> +						 file_out, pos_out + copied,
> +						 len - copied);
> +	}

This should not fall back to a page cache copy.

We keep being told by application developers that if the fast
hardware/filesystem offload fails, then an error should be returned
so the application can determine what the fallback operation should
be.

It may well be that the application falls back to "copy through the
page cache", but that is an application policy choice, not a
something the kernel offload driver should be making mandatory.

Userspace has to handle copy offload failure anyway, so they a
fallback path regardless of whether copy_file_range() works on block
devices or not...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

