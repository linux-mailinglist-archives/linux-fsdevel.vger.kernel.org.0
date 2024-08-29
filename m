Return-Path: <linux-fsdevel+bounces-27751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD3C9638AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 05:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DF781C24C50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356247581F;
	Thu, 29 Aug 2024 03:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="NnVcdPwC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278FC487A7
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 03:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724901078; cv=none; b=UdRt3VLyZICJwaw0XytkQpUwyiBYogTgFsjibTc1+FlTyBk6DZ3+FuIIWhOZ1SJqiPtz72crIbAWUGqg7z6XdSr6Wp+GWsM+6CxFC8OW9giCSMsXD1i5SMuun9vDZvPKJZubrlOP2VIBLcdrbFjnQpdQp82cS4nb1/CiOzyizqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724901078; c=relaxed/simple;
	bh=8vNd7eJk+7BqiWgLOIf5f94ZTL26wZSzW4bJHu9N4ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYyXMrRMwysd/HcB9KC4S4CbEcLqRV+0dEdju1ZwgjRAUgbRBYBO08jCS/hW7u/oWAsWTkABNDojmWtwAGyGzVS4ZpxavvRvkSCqNyt5inx+23oU/L/24/vnydO9YX4bBf6eRxon4FP5Geqr+72L7UKXOFL4ZLusHfhfn04ZTqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=NnVcdPwC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-201f7fb09f6so1348735ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 20:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1724901076; x=1725505876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7LFPcUrRfm2Rty5fGa9femgiXFTLjsc0Q2+FGvRfHxc=;
        b=NnVcdPwCPJ+F/K6ZdXqa3P4AIPR7qWdLDjmO+gZRziGpzrbOfsX48/n0df36mcgmgC
         FFy+A72zMXwTJ5ycDm2izsdrVJvZtlnwDGujkBoDHbWkWeEEOgNgu+IarPTucRz24vL3
         ItlYWCvPwDfmp5YTZTC3hK8OEsb9NGGqqRcGDX9Br0GS5+nxnFDLT5BDTIpodLx2Hlzc
         S8q1ZnwZDN/PfrhC8gb0/AsFu1RQYRBuPo+fJwZoDA5RnUkzhoaCyxq/b5LAtIeVnING
         ywpdP+P5CkNeozbh9ybEWKbwOYqPYNAodsbPrz56uOQO7C9cb9csOvqTgxgF+GTCUI52
         WyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724901076; x=1725505876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LFPcUrRfm2Rty5fGa9femgiXFTLjsc0Q2+FGvRfHxc=;
        b=G+cZWm8TLYTsnx7UGYI1RRzwMtBS2itd8vthpmgw/5nyYnueuoE3Jl1ornxeIIy+ep
         MFm80kXPdb9HKN3CSqOOOJiNgZrEaMcGebBHhhJFdbdcNPzIUi/xkzMdCqk74uJxuV77
         vEu+UAmGCx4L8hrRVMy7tW4wnoL5NUhVfxR9zJFWBV0CrC0feFr9PirXjGRJ2ACPZg9W
         y9qEme1YoN8FdW+d/bDyFn68STjvu8JMXwuPH9DjrN245babEvOn7Qo8V5q6uBPpyb5S
         xAwGjYXCrshG46ePX9pRT/M0IHzyIPfMcT1J/Cq2cW730nAkQBgHbQGwVWFngLiZhL9N
         5yyA==
X-Forwarded-Encrypted: i=1; AJvYcCUqP/4kOB6zuGdkhS6yfkNtWuJrxTCk3/1SEcl1nRBrBKEvH2VEb/DpB2GY5X3XaZXCXeYZ6ugmu2+fbIZ6@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt7oVPyREESh2Vi1DTxUhel78gMT4fUQQo+qHqpqF1lUnAohAi
	FKyiUlx8BbMls0TPOjOFzAs/rb8W5wEDLlS6Xf1LFVYGS9CNr4VL9ZG461+506Y=
X-Google-Smtp-Source: AGHT+IF0HizZIxQmIfTO5RgF8t2VuMPRsNbwH/RaEtTlxkHAdS4UOzOzAb8NSNSIxINZnhLS8ywk4g==
X-Received: by 2002:a17:902:d48b:b0:203:a046:d687 with SMTP id d9443c01a7336-2050c2159a0mr19130725ad.7.1724901076201;
        Wed, 28 Aug 2024 20:11:16 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-65.pa.nsw.optusnet.com.au. [49.179.0.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515537a2csm1806355ad.176.2024.08.28.20.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 20:11:15 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sjVZ1-00GSSL-15;
	Thu, 29 Aug 2024 13:11:11 +1000
Date: Thu, 29 Aug 2024 13:11:11 +1000
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Brian Foster <bfoster@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 6/6] xfs: refactor xfs_file_fallocate
Message-ID: <Zs/mz4Gve+znep2M@dread.disaster.area>
References: <20240827065123.1762168-1-hch@lst.de>
 <20240827065123.1762168-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827065123.1762168-7-hch@lst.de>

On Tue, Aug 27, 2024 at 08:50:50AM +0200, Christoph Hellwig wrote:
> Refactor xfs_file_fallocate into separate helpers for each mode,
> two factors for i_size handling and a single switch statement over the
> supported modes.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_file.c | 330 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 208 insertions(+), 122 deletions(-)

Much nicer. :)

And it made an existing issue in the code quite obvious, too:

> +/*
> + * Punch a hole and prealloc the range.  We use a hole punch rather than
> + * unwritten extent conversion for two reasons:
> + *
> + *   1.) Hole punch handles partial block zeroing for us.
> + *   2.) If prealloc returns ENOSPC, the file range is still zero-valued by
> + *	 virtue of the hole punch.
> + */
> +static int
> +xfs_falloc_zero_range(
> +	struct file		*file,
> +	int			mode,
> +	loff_t			offset,
> +	loff_t			len)
> +{
> +	struct inode		*inode = file_inode(file);
> +	unsigned int		blksize = i_blocksize(inode);
> +	loff_t			new_size = 0;
> +	int			error;
> +
> +	trace_xfs_zero_file_space(XFS_I(inode));
> +
> +	error = xfs_falloc_newsize(file, mode, offset, len, &new_size);
> +	if (error)
> +		return error;
> +
> +	error = xfs_free_file_space(XFS_I(inode), offset, len);
> +	if (error)
> +		return error;
> +
> +	len = round_up(offset + len, blksize) - round_down(offset, blksize);
> +	offset = round_down(offset, blksize);
> +	error = xfs_alloc_file_space(XFS_I(inode), offset, len);
> +	if (error)
> +		return error;
> +	return xfs_falloc_setsize(file, new_size);
> +}

Our zeroing operation always does preallocation, but....


> +static int
> +xfs_falloc_allocate_range(
> +	struct file		*file,
> +	int			mode,
> +	loff_t			offset,
> +	loff_t			len)
> +{
> +	struct inode		*inode = file_inode(file);
> +	loff_t			new_size = 0;
> +	int			error;
> +
> +	/*
> +	 * If always_cow mode we can't use preallocations and thus should not
> +	 * create them.
> +	 */
> +	if (xfs_is_always_cow_inode(XFS_I(inode)))
> +		return -EOPNOTSUPP;

... our preallocation operation always returns -EOPNOTSUPP for
COW mode.

Should the zeroing code also have this COW mode check in it after
the hole punch has run so we don't do unnecessary prealloc there?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

