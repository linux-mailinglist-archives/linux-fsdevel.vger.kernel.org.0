Return-Path: <linux-fsdevel+bounces-9721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FEC844967
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 22:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89F63B258FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 21:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA65F39846;
	Wed, 31 Jan 2024 21:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="jGPVEa0w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B6138FA4
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 21:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735234; cv=none; b=d+2rz4jKo2Glj4FYPZI06K/AW+KhweRSo840WdYqL3hKMQNTGqH5BjhCjZbFV3Y3Wo9tsZY/+oGe0aQ2qSA4s/3LTPQK54c1p5beUOppt+9/gqr1ndCpyPehHoI6hfhELNP9xR5gRAYsNq9Wl6CSxWxxYR0+I2Jt66yhOP8OCb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735234; c=relaxed/simple;
	bh=IxO8a8L67cWwjXrkecZP+FYE4tDiJRsZJUWJKBQn0Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ako+K/1qsU1DLM23Bb9Z45/kXCxogVY5lvD53ZUAlB6AzOwyZm6+hs12Tgouvbef5yhec2H//4F1nUOPWQ5zM4kTq9ZzHjRZLWYQXoe17JnF79zE/32OFHiCwTj2Logff+Aa4+0WyMEH9Tg1Q4hxhexptL9P9R3YBh+zKfE9dIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=jGPVEa0w; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5986d902ae6so129559eaf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 13:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1706735231; x=1707340031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M6cLTcFD8XT4oeO50GCGwvFcw8Q7L3Ri5cm/Yywom6s=;
        b=jGPVEa0w3BtnV6CQ5L845cxQSrtAz/Krgb5CAoVjSGYz79C8YKQ89VVTILPDrsTOCU
         1wJ34tifCVcTtiQXG6mU9VpvEgYpuFv505I8u3DUdFnjgBcUJDbohlcl4PCz5I+YAnIr
         pkzziMORc+utD+Kcyqp0ZmM0yXXrgSndCxEPsMojh0WwEw04Oy1gB+rhBM9w2efGow4w
         AOAQdehCbc4nF5WRWO5lvWnDREq5zZFvGClRQXNf7y4xnfdyNzacQLEA16mpKtxtjFY8
         u6CQlYJDEOLz0fqZbOFNHOHLT4j1zqf0+bMydRrXWn11kaKsp0/AoeWQqcmR67Z8FwyE
         ySHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706735231; x=1707340031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6cLTcFD8XT4oeO50GCGwvFcw8Q7L3Ri5cm/Yywom6s=;
        b=vt1GvSU3ELcsW74GH00uFwTATKPrldOCap4t0AVU5nq1VH0TAPw2hqfsOMH6D5KPXw
         2sTI6KwP+zBAHsxJy3VyuSV7KjqKVLCzmi9nBriaHKHxIvhco7nprlUGqVj/+LbTZpFR
         TjMRoS2WpmrRrD65H9vMwv0pPmOu6A4QcLLwciFunJZ+XBwxJc9tSJWxJMfOFrzE+Tcu
         1SkE8Qrmzab97OeNAUSWuD5r8t0BN1LYym8iSA9a7hiz3oqxDv2XK8EfLYRNYAJJ5Vxp
         /qBmzNjEVQM9JdNZ56SobLkpjLlhfd02EIRZ+tOzxepibpnKvykw3aQ+A9dWYslvqNDc
         uMKQ==
X-Gm-Message-State: AOJu0Yy2frsfP4aTfJNtZzn3Xt0G+ERN4wYB0O5cyM26gh36khwXbpEQ
	BMIjVKc+QsfFw7wAfuj8EiM+h12zAdkfI7oWoZeKzNzsft6Un1Akn7OwKF21P0Q=
X-Google-Smtp-Source: AGHT+IE2DvjVjVI0vMRCxKImdSao9a6QI1YGOCIDx+2fKz4FZgqyhL3v5huWklky+WSIrZCuMokN8w==
X-Received: by 2002:a05:6358:6f11:b0:178:a1d9:4a9f with SMTP id r17-20020a0563586f1100b00178a1d94a9fmr2460280rwn.31.1706735231492;
        Wed, 31 Jan 2024 13:07:11 -0800 (PST)
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id y136-20020a62ce8e000000b006de30d6786bsm6132265pfg.126.2024.01.31.13.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 13:07:10 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rVHnX-000Jtv-1a;
	Thu, 01 Feb 2024 08:07:07 +1100
Date: Thu, 1 Feb 2024 08:07:07 +1100
From: Dave Chinner <david@fromorbit.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 3/6] fs: Split fcntl_rw_hint()
Message-ID: <Zbq2e7e8Ba1Df6O7@dread.disaster.area>
References: <20240131205237.3540210-1-bvanassche@acm.org>
 <20240131205237.3540210-4-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131205237.3540210-4-bvanassche@acm.org>

On Wed, Jan 31, 2024 at 12:52:34PM -0800, Bart Van Assche wrote:
> Split fcntl_rw_hint() such that there is one helper function per fcntl. No
> functionality is changed by this patch.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  fs/fcntl.c | 47 ++++++++++++++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index f3bc4662455f..5fa2d95114bf 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -290,32 +290,35 @@ static bool rw_hint_valid(u64 hint)
>  	}
>  }
>  
> -static long fcntl_rw_hint(struct file *file, unsigned int cmd,
> -			  unsigned long arg)
> +static long fcntl_get_rw_hint(struct file *file, unsigned int cmd,
> +			      unsigned long arg)
>  {
>  	struct inode *inode = file_inode(file);
>  	u64 __user *argp = (u64 __user *)arg;
> -	u64 hint;
> +	u64 hint = inode->i_write_hint;
>  
> -	switch (cmd) {
> -	case F_GET_RW_HINT:
> -		hint = inode->i_write_hint;
> -		if (copy_to_user(argp, &hint, sizeof(*argp)))
> -			return -EFAULT;
> -		return 0;
> -	case F_SET_RW_HINT:
> -		if (copy_from_user(&hint, argp, sizeof(hint)))
> -			return -EFAULT;
> -		if (!rw_hint_valid(hint))
> -			return -EINVAL;
> +	if (copy_to_user(argp, &hint, sizeof(*argp)))
> +		return -EFAULT;
> +	return 0;
> +}
>  
> -		inode_lock(inode);
> -		inode->i_write_hint = hint;
> -		inode_unlock(inode);
> -		return 0;
> -	default:
> +static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
> +			      unsigned long arg)
> +{
> +	struct inode *inode = file_inode(file);
> +	u64 __user *argp = (u64 __user *)arg;
> +	u64 hint;
> +
> +	if (copy_from_user(&hint, argp, sizeof(hint)))
> +		return -EFAULT;
> +	if (!rw_hint_valid(hint))
>  		return -EINVAL;
> -	}
> +
> +	inode_lock(inode);
> +	inode->i_write_hint = hint;
> +	inode_unlock(inode);

What is this locking serialising against? The inode may or may not
be locked when we access this in IO path, so why isn't this just
WRITE_ONCE() here and READ_ONCE() in the IO paths?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

