Return-Path: <linux-fsdevel+bounces-13822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F19ED8741FD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 22:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C1641F21FAD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 21:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A433C1B7F7;
	Wed,  6 Mar 2024 21:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="QlTLvLBl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1F41B286
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 21:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709760680; cv=none; b=OPL8+Edz7kKiV4z9bVxK4S/B3rTqQAY2vHiNnSWwAGgq/oPvjIpHx17s6tvBQM0q1nZpZJDR2UJza44QIejfRHEVqPl8AqCrF4YiQPogwdHj6hokK0HegNEseQMNQZ9TxQz6DS2NVEF6lyTsUj3DDDfXhqCoTKkptCHAW1pCy/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709760680; c=relaxed/simple;
	bh=rMXr7jsfzk/3cDZG8HH1UXSju8881T4mve4OBWJqyrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNtqamMqYzTQhNN/0wdZpmoqzkNOXDEJGXFqEy+dfEyMOZrGN7x31SGK4qCnTs3K+JjDQFnJh8xih8e6jgvxCNYsp0ezK3ZanKn1ngkgxOjXtzsFx9pYVAH1tV24ZVzmdER9puMJlioxJWamXUHqgepTsnqkPgJ7Xrn0vdHO26I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=QlTLvLBl; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e655a12c81so363270b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Mar 2024 13:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709760678; x=1710365478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tTZZBMyXZZhsAcGoSs512++WWmiGxqEzY30iwWIRVf8=;
        b=QlTLvLBlJ0GkQwrmvit3s9ouHH/2norMACvfBMwC2vTeAGjIzxPcT1w+srcBEw3VWm
         Hze9iHJloAF+1v/TtEidTwI0andk15Q+OWsMr/UXl3rEX/ao6EY+WFion6NcXDapmGLq
         6eIvW4dlCr8GIyMX3Kc0ZyuYYZI+Vqg+TwiFRanih6a5NtkQESvH0F+OYibcC652GChh
         +cyyTayRx3U2DsrExrZw3E38MjBUN1/t86x2BDrf2lWoaWAhfHcl2jaS0liRUh11AMIa
         xuia+dX9vZzDAm8t3lLwokECaW1Ol/qcwNWAdsWdGMWxSYEOawEAlPEQDdTVFEuwlOlD
         dfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709760678; x=1710365478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTZZBMyXZZhsAcGoSs512++WWmiGxqEzY30iwWIRVf8=;
        b=wvB5YTstzyoD7fjbF/a5Mf+waynhD/aFX6zPEFVwN1jU+RsoXtWzobCuC7QDyUVa3u
         +YI890z8npNhYD+vfekR+d2YDc5r5HpRbUt5OawM0BksrHQ7w5iqDPwnIPnbJr5JgO+p
         z3mzLw0eNFip/w3kYnv8aD4DsLRkGyAWFzMKRB3PPIYbthCvdeIY3enOSsyHfY8/+WUp
         u9pAe97Che7JHD2KT/Mnkr5caScOX9reKgDVKrUakSKTbiDwGG7nPc4UhF3K3SDr1Z2Y
         9KIRrvWTxJV0uX6goo9S5pafjmO5Q8uAl/TwMrJySjv2uFMId5UP3Hn35t1j+k8A//Ub
         sZsg==
X-Forwarded-Encrypted: i=1; AJvYcCUG1F/7tD0OfhJhkwGHE1d2qKL3fbavbtwuB9Kx9eDRF+uoAGJgu5QdqG5NeEQMGIId4HLLUtfVYvpHMTbLDOVQfDj4ctpxazKjcpQSiQ==
X-Gm-Message-State: AOJu0YzDWDRc5QbXzJ87SpPOC0lD+WBOCPzdBSGZ7/LnisrO5UmRfy7r
	zUPOBoX1GEQxULNMNfnLzLTb7zksqHnVbIXgfDoV6/i470hcQ5Y4IDkmYjSp1fg=
X-Google-Smtp-Source: AGHT+IGfznG5D7PDYe9f3fE6Psrmx2j5uB4shV1ViWMMUU71YGJuVUBX+veGGNuxS5t7qaLelf0QKQ==
X-Received: by 2002:a17:90a:d797:b0:298:a422:937d with SMTP id z23-20020a17090ad79700b00298a422937dmr1622405pju.24.1709760677630;
        Wed, 06 Mar 2024 13:31:17 -0800 (PST)
Received: from dread.disaster.area (pa49-179-47-118.pa.nsw.optusnet.com.au. [49.179.47.118])
        by smtp.gmail.com with ESMTPSA id nh3-20020a17090b364300b0029b7c9319c9sm189240pjb.12.2024.03.06.13.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 13:31:17 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rhyr4-00FyYC-17;
	Thu, 07 Mar 2024 08:31:14 +1100
Date: Thu, 7 Mar 2024 08:31:14 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, chandan.babu@oracle.com,
	axboe@kernel.dk, martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v2 12/14] fs: xfs: Support atomic write for statx
Message-ID: <ZejgovFe/pWCQ4uM@dread.disaster.area>
References: <20240304130428.13026-1-john.g.garry@oracle.com>
 <20240304130428.13026-13-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304130428.13026-13-john.g.garry@oracle.com>

On Mon, Mar 04, 2024 at 01:04:26PM +0000, John Garry wrote:
> Support providing info on atomic write unit min and max for an inode.
> 
> For simplicity, currently we limit the min at the FS block size, but a
> lower limit could be supported in future. This is required by iomap
> DIO.
> 
> The atomic write unit min and max is limited by the guaranteed extent
> alignment for the inode.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_iops.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index a0d77f5f512e..6316448083d2 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -546,6 +546,37 @@ xfs_stat_blksize(
>  	return PAGE_SIZE;
>  }
>  
> +static void
> +xfs_get_atomic_write_attr(
> +	struct xfs_inode	*ip,
> +	unsigned int		*unit_min,
> +	unsigned int		*unit_max)
> +{
> +	xfs_extlen_t		extsz = xfs_get_extsz(ip);
> +	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> +	struct block_device	*bdev = target->bt_bdev;
> +	struct request_queue	*q = bdev->bd_queue;
> +	struct xfs_mount	*mp = ip->i_mount;
> +	struct xfs_sb		*sbp = &mp->m_sb;
> +	unsigned int		awu_min, awu_max;
> +	unsigned int		extsz_bytes = XFS_FSB_TO_B(mp, extsz);
> +
> +	awu_min = queue_atomic_write_unit_min_bytes(q);
> +	awu_max = queue_atomic_write_unit_max_bytes(q);

We really should be storing these in the xfs_buftarg at mount time,
like we do logical and physical sector sizes. Similar to sector
sizes, they *must not change* once the filesystem has been created
on the device, let alone during an active mount. The whole point of
the xfs_buftarg is to store the information the filesystem
needs to do IO to the underlying block device so we don't have to
chase pointers deep into the block device whenever we need to use
static geometry information.....

> +	if (sbp->sb_blocksize > awu_max || awu_min > sbp->sb_blocksize ||
> +	    !xfs_inode_atomicwrites(ip)) {
> +		*unit_min = 0;
> +		*unit_max = 0;
> +		return;
> +	}

Again, this is comparing static geometry - if the block size doesn't
allow atomic writes, then the inode flag should never be set. i.e.
geometry is checked when configuring atomic writes, not in every
place we need to check if atomic writes are supported. Hence this
should simply be:

	if (!xfs_inode_has_atomic_writes(ip)) {
		*unit_min = 0;
		*unit_max = 0;
		return;
	}

before we even look at the xfs_buftarg to get the supported min/max
values for the given device.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

