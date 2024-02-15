Return-Path: <linux-fsdevel+bounces-11770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F1F857062
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 23:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3127928555B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 22:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AABE1468ED;
	Thu, 15 Feb 2024 22:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="GGrxAmVo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FB01468EA
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 22:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708035108; cv=none; b=kELcRsTTpwrbwjhi0P/avJ+j6BOTbuuppbRbpPv2+G3rJh2FdR6sG9T6rEt/MIKYEahFFyldE44kmBN615LtCiDZpdXtOynfHhpY+yJYdHLIQYmGw3XaedEPplbmjEIon0j2yeHN5aSUTD9nMU7aHBmwLNxokpSppJxOC48hFYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708035108; c=relaxed/simple;
	bh=ICprOwomCirRy6imUqO5lGGFIIbyEqfUsyKUQoV8P28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hexf4v4suq07MBJSfw4HrAK1A/o+8rZSPKzuPY7W43HJFuSQ0sjZeOdE8yYhwWnQoM/eR6WrKtOo5jN+/Qy3DiGArh4VD0UBciPQksVvtrX3sdEWtSAjRENWL9VK/DiDM4WbytwOazJytzuhqVmV91W1p5amvM1n5r9amoSSwiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=GGrxAmVo; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-297108e7001so1150852a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 14:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1708035106; x=1708639906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FGXbKA2yFnDE4E0DN1MX6adUQFulBOw3gnEL0taUc1E=;
        b=GGrxAmVod+fKqNrkgsEEbMI2yohsMGbY9mIJQIMjeCDjWryYFxmcmIWcwWbdGtyvkQ
         v1uqxJbV8wlQqS6AEOsIyZDhM+EkdB7HwxQNXm20qV1KHbVHk/BUD3OFbApldSonLh/v
         Mpo+6/EXe4OzA8WvagSsfWPQKhw4ldKjbtHrhEq5493VEEXkdD2ApPyTT9BFay/RRsoI
         Mov6VlbOehDCS5Er1B5D+HnHZERq8dLSNGEyOgK92aV1toAYQgildrdgxh+J8dkDUTA2
         IQJWEZi6qghkl/w9uNbDICoFw1otem2xTIFG7B5+1OtU+D814qpy1/27FI+LL/LXkoP4
         l+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708035106; x=1708639906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGXbKA2yFnDE4E0DN1MX6adUQFulBOw3gnEL0taUc1E=;
        b=Ttt6F1eM0L2XJogG/31W/x/oSEhLsofzlZAg5eLuyJ3Xe0SBLhmwsNGY10m5BacWof
         VCKN7cf4arEGMX5NIFxaB3pweGcUBnFzT4QmtkfKF98tzcg0SVAY4ghjsCcBMidgpXJr
         Z9JOj7rAs7e9KrExwU+0JnlZcdhLyhXrmuG2qPd7ONorGeiPUhI4sTzHdLwingxktlG6
         aokX/Bg7xW9nSFyaSNExhfKPJKGaXOhpcND72kVj7EPz2su4t21JzU7v0POrko1wNq/y
         3mZn3oJe73pkeDcoBMF5TDSYlY1hdkG57t0FfZoU1jpeZTf8fAGEnNGXIAXUnZVp28o+
         1SeQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6Z5Y/EdRqh1OfTMrabweAOFkr8xxLIMHw/oeOqEvoAcZ3O4V13O2TrI5WlKAjnkyc65s94+aZkWg8z5HbNTK2vRc95ZgHW8d35ZmYbw==
X-Gm-Message-State: AOJu0Yyn7C7inxEhzQiYF6NfUCnX+a5YyW7BS8UYXaPDHZYI+6BT/YRz
	SllKumYEAtISRJz+IdCnP9VopwB3G6VNSBESPIgFK45mRk0L01BjfBBLu0bXYFw=
X-Google-Smtp-Source: AGHT+IGt7YVdQhw+JrYgtsf/Mqgax/s1SpODRgbcCGqji1k3d8F27orVRsC5Co/NARTtYGY8mMnTCA==
X-Received: by 2002:a17:90a:e617:b0:298:beaf:ebd7 with SMTP id j23-20020a17090ae61700b00298beafebd7mr2820840pjy.3.1708035105978;
        Thu, 15 Feb 2024 14:11:45 -0800 (PST)
Received: from dread.disaster.area (pa49-195-8-86.pa.nsw.optusnet.com.au. [49.195.8.86])
        by smtp.gmail.com with ESMTPSA id mg17-20020a17090b371100b00299101c1341sm1755289pjb.18.2024.02.15.14.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 14:11:45 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rajxH-0071B4-0J;
	Fri, 16 Feb 2024 09:11:43 +1100
Date: Fri, 16 Feb 2024 09:11:43 +1100
From: Dave Chinner <david@fromorbit.com>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com,
	djwong@kernel.org, ebiggers@kernel.org
Subject: Re: [PATCH v4 13/25] xfs: introduce workqueue for post read IO work
Message-ID: <Zc6MHxQ0PTJ7Qck0@dread.disaster.area>
References: <20240212165821.1901300-1-aalbersh@redhat.com>
 <20240212165821.1901300-14-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212165821.1901300-14-aalbersh@redhat.com>

On Mon, Feb 12, 2024 at 05:58:10PM +0100, Andrey Albershteyn wrote:
> As noted by Dave there are two problems with using fs-verity's
> workqueue in XFS:
> 
> 1. High priority workqueues are used within XFS to ensure that data
>    IO completion cannot stall processing of journal IO completions.
>    Hence using a WQ_HIGHPRI workqueue directly in the user data IO
>    path is a potential filesystem livelock/deadlock vector.
> 
> 2. The fsverity workqueue is global - it creates a cross-filesystem
>    contention point.
> 
> This patch adds per-filesystem, per-cpu workqueue for fsverity
> work.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  fs/xfs/xfs_aops.c  | 15 +++++++++++++--
>  fs/xfs/xfs_linux.h |  1 +
>  fs/xfs/xfs_mount.h |  1 +
>  fs/xfs/xfs_super.c |  9 +++++++++
>  4 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 7a6627404160..70e444c151b2 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -548,19 +548,30 @@ xfs_vm_bmap(
>  	return iomap_bmap(mapping, block, &xfs_read_iomap_ops);
>  }
>  
> +static inline struct workqueue_struct *
> +xfs_fsverity_wq(
> +	struct address_space	*mapping)
> +{
> +	if (fsverity_active(mapping->host))
> +		return XFS_I(mapping->host)->i_mount->m_postread_workqueue;
> +	return NULL;
> +}
> +
>  STATIC int
>  xfs_vm_read_folio(
>  	struct file		*unused,
>  	struct folio		*folio)
>  {
> -	return iomap_read_folio(folio, &xfs_read_iomap_ops, NULL);
> +	return iomap_read_folio(folio, &xfs_read_iomap_ops,
> +				xfs_fsverity_wq(folio->mapping));
>  }
>  
>  STATIC void
>  xfs_vm_readahead(
>  	struct readahead_control	*rac)
>  {
> -	iomap_readahead(rac, &xfs_read_iomap_ops, NULL);
> +	iomap_readahead(rac, &xfs_read_iomap_ops,
> +			xfs_fsverity_wq(rac->mapping));
>  }

Ok, Now I see how this workqueue is specified, I just don't see
anything XFS specific about this, and it adds complexity to the
whole system by making XFS special.

Either the fsverity code provides a per-sb workqueue instance, or
we use the global fsverity workqueue. i.e. the filesystem itself
should not have to supply this, nor should it be plumbed into
generic iomap IO path.

We already do this with direct IO completion to use a
per-superblock workqueue for defering write completions
(sb->s_dio_done_wq), so I think that is what we should be doing
here, too. i.e. a generic per-sb post-read workqueue.

That way iomap_read_bio_alloc() becomes:

+#ifdef CONFIG_FS_VERITY
+	if (fsverity_active(inode)) {
+		bio = bio_alloc_bioset(bdev, nr_vecs, REQ_OP_READ, gfp,
+					&iomap_fsverity_bioset);
+		if (bio) {
+			bio->bi_private = inode->i_sb->i_postread_wq;
+			bio->bi_end_io = iomap_read_fsverity_end_io;
+		}
+		return bio;
+	}

And we no longer need to pass a work queue through the IO stack.
This workqueue can be initialised when we first initialise fsverity
support for the superblock at mount time, and it would be relatively
trivial to convert all the fsverity filesytsems to use this
mechanism, getting rid of the global workqueue altogether.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

