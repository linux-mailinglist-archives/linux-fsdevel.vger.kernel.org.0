Return-Path: <linux-fsdevel+bounces-40970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C09E4A299F8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 20:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E7A53A4450
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 19:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CAB1DE89E;
	Wed,  5 Feb 2025 19:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABc7zYEB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21F32040B2;
	Wed,  5 Feb 2025 19:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738783022; cv=none; b=crHArWaxuhyNGyKZTvOibaExA3BAAWo//qYFw55d/+QfegNuDrCEAMcxS9J6a3NiyHvyzqsJ5vkc45CHR6bvVMQkN11v9tBm0FO8R5UHbVaIYmvWCFnrSq03XPVVYExYtfng/y64ARVVOF3ov65LsvoozO6ZzptYChgP9SN5Va0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738783022; c=relaxed/simple;
	bh=FTKoa2QfAzqhXJZOV6Jak9Fwtx1K77rbg7Y/4m0GAbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEdO8jNa5SVTPv90Gbe4sKgU4sc9+owVFcpAdT0IpAMCqYBjersgSSOnjmG0Ygeov0uiX9tb0t8YycljSVmpVuw2NVYFL/IvdTmClqgG8XoEPTuz2F+f7JcCBLeogGACEYHTxDPzRXAhglrN1DWaHOw0mwewlFEgP1GWyEpRqSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABc7zYEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F474C4CED1;
	Wed,  5 Feb 2025 19:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738783022;
	bh=FTKoa2QfAzqhXJZOV6Jak9Fwtx1K77rbg7Y/4m0GAbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ABc7zYEBnHHDOCUIntFaosbVGRJ2goTL2FekcHZF57+mx7XMZA1gK+E6zJk96h49T
	 oXdqe6+BLPl+/ekpmNkXR5G8GQ+wAMMaHabEe8oz1xf+8DplIpLiMa+gYJKmKYWiMt
	 vUCJlksQGH5fHnWNRlpXCWZF3RGRTxMUmIXVP2u5zQOrOYB3IQmYP3qG8FZgxV/xNF
	 NQse4+vWhHEE3u4Tb0FEjutklHg9/zFv/4fQfG3zwxIM02mUTgWtLR5VOqaA2Bp8Li
	 mh0UZZaJpsUdStdiSAIgDpdyWZ7d13KlWy4J0v+/qoECjOMQvhNSR+GMrB+eK2um7n
	 SP9mm3Lyyqc1Q==
Date: Wed, 5 Feb 2025 11:17:01 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v5 08/10] iomap: advance the iter directly on buffered
 writes
Message-ID: <20250205191701.GT21808@frogsfrogsfrogs>
References: <20250205135821.178256-1-bfoster@redhat.com>
 <20250205135821.178256-9-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205135821.178256-9-bfoster@redhat.com>

On Wed, Feb 05, 2025 at 08:58:19AM -0500, Brian Foster wrote:
> Modify the buffered write path to advance the iter directly. Replace
> the local pos and length calculations with direct advances and loop
> based on iter state instead.
> 
> Also remove the -EAGAIN return hack as it is no longer necessary now
> that separate return channels exist for processing progress and error
> returns. For example, the existing write handler must return either a
> count of bytes written or error if the write is interrupted, but
> presumably wants to return -EAGAIN directly in order to break the higher
> level iomap_iter() loop.
> 
> Since the current iteration may have made some progress, it unwinds the
> iter on the way out to return the error while ensuring that portion of
> the write can be retried. If -EAGAIN occurs at any point beyond the
> first iteration, iomap_file_buffered_write() will then observe progress
> based on iter->pos to return a short write.
> 
> With incremental advances on the iomap_iter, iomap_write_iter() can
> simply return the error. iomap_iter() completes whatever progress was
> made based on iomap_iter position and still breaks out of the iter loop
> based on the error code in iter.processed. The end result of the write
> is similar in terms of being a short write if progress was made or error
> return otherwise.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

LGTM
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index d303e6c8900c..678c189faa58 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -909,8 +909,6 @@ static bool iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
>  
>  static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  {
> -	loff_t length = iomap_length(iter);
> -	loff_t pos = iter->pos;
>  	ssize_t total_written = 0;
>  	long status = 0;
>  	struct address_space *mapping = iter->inode->i_mapping;
> @@ -923,7 +921,8 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  		size_t offset;		/* Offset into folio */
>  		size_t bytes;		/* Bytes to write to folio */
>  		size_t copied;		/* Bytes copied from user */
> -		size_t written;		/* Bytes have been written */
> +		u64 written;		/* Bytes have been written */
> +		loff_t pos = iter->pos;
>  
>  		bytes = iov_iter_count(i);
>  retry:
> @@ -934,8 +933,8 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  		if (unlikely(status))
>  			break;
>  
> -		if (bytes > length)
> -			bytes = length;
> +		if (bytes > iomap_length(iter))
> +			bytes = iomap_length(iter);
>  
>  		/*
>  		 * Bring in the user page that we'll copy from _first_.
> @@ -1006,17 +1005,12 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  				goto retry;
>  			}
>  		} else {
> -			pos += written;
>  			total_written += written;
> -			length -= written;
> +			iomap_iter_advance(iter, &written);
>  		}
> -	} while (iov_iter_count(i) && length);
> +	} while (iov_iter_count(i) && iomap_length(iter));
>  
> -	if (status == -EAGAIN) {
> -		iov_iter_revert(i, total_written);
> -		return -EAGAIN;
> -	}
> -	return total_written ? total_written : status;
> +	return total_written ? 0 : status;
>  }
>  
>  ssize_t
> -- 
> 2.48.1
> 
> 

