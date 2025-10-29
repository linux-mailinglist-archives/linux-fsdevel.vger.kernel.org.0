Return-Path: <linux-fsdevel+bounces-66333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CCBC1BF6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 17:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A6575E0460
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 15:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10ECB3451A6;
	Wed, 29 Oct 2025 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sl8vO++y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AF633A03F;
	Wed, 29 Oct 2025 15:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753455; cv=none; b=mwQsPsS7ry6GbETtvNgeslMTIf7S7PkAYQFSLCEp2v/yKuhlrmqS/q4XcnqmFdUkfuOrvgviU2d9hP30WtsMwpW9SzWYcUkaxINY5F6xyKFSsJNms6hU9DheZpFwyPi3kKdJtFUIDpH88ZTK3nRnFrl06dbXg/gT6M++1u22FYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753455; c=relaxed/simple;
	bh=gdBT7RGAcvNZIAmXTRdX9CBhEySRzp4H9DzlkxrSvJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWrVD/RNxvYCwxJFUcEgXU1g1G0GYhZvyw+SyPeZ+CgGxBLQpq6O0RXUEtYBgv4K2E2zLERro6kL1Rgb0jqQ8wE+ukyta+5KswzuWNM9GOJM/8nTneEuOA9BiMEK1cwfD9/5gpHhV4gPsuKofxQJqiPiNVb9Of7rXIhrRgjawkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sl8vO++y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD42C4CEF7;
	Wed, 29 Oct 2025 15:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761753455;
	bh=gdBT7RGAcvNZIAmXTRdX9CBhEySRzp4H9DzlkxrSvJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sl8vO++yy8LE5VN1jxLfkD7i/YiTjiLMBaZLE7vU3HUzw/xOjgxKCUk+hmg+yZ1Uu
	 RzFRlnQ2OdGIeRFuBXWJlP673k8CH1i9LnFWnD83fMXidYVPmG2yCVErms+cbAvxlf
	 ej2ItBho4PdxhOJNa1SzBIjLzgNLQln0+IXgdpgZIgmJ3b1+rq0hI9p3OTaCcPITN8
	 hInYjqdnzb/G1z1AcOpHT/6DRXxfYr/YTH4uqthANY4kD2CoR0ClWUR974AvDjSkCj
	 dFyXHgp8EZrQEemU4+Y8MzXsU6i9Btjf7xFvyDYRaVfjfyD2anX506w0rYkDCp/Rox
	 xnCrFX63o0oig==
Date: Wed, 29 Oct 2025 08:57:34 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 3/4] xfs: use IOCB_DONTCACHE when falling back to
 buffered writes
Message-ID: <20251029155734.GD3356773@frogsfrogsfrogs>
References: <20251029071537.1127397-1-hch@lst.de>
 <20251029071537.1127397-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029071537.1127397-4-hch@lst.de>

On Wed, Oct 29, 2025 at 08:15:04AM +0100, Christoph Hellwig wrote:
> Doing sub-block direct writes to COW inodes is not supported by XFS,
> because new blocks need to be allocated as a whole.  Such writes
> fall back to buffered I/O, and really should be using the
> IOCB_DONTCACHE that didn't exist when the code was added to mimic
> direct I/O semantics as closely as possible.  Also clear the
> IOCB_DIRECT flags so that later code can't get confused by it being
> set for something that at this point is not a direct I/O operation
> any more.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Seems like a reasonable fallback now that we have dontcache
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_file.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 5703b6681b1d..e09ae86e118e 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1119,6 +1119,9 @@ xfs_file_write_iter(
>  		ret = xfs_file_dio_write(iocb, from);
>  		if (ret != -ENOTBLK)
>  			return ret;
> +
> +		iocb->ki_flags &= ~IOCB_DIRECT;
> +		iocb->ki_flags |= IOCB_DONTCACHE;
>  	}
>  
>  	if (xfs_is_zoned_inode(ip))
> -- 
> 2.47.3
> 
> 

