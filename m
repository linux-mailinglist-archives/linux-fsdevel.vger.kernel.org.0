Return-Path: <linux-fsdevel+bounces-42128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF3CA3CC56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 23:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4D516BDB8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 22:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863F2259495;
	Wed, 19 Feb 2025 22:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnFmO668"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E321517CA12;
	Wed, 19 Feb 2025 22:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740004288; cv=none; b=J7ecrSvZ6f2yVQAr0SgelMMyiZNpKZU9A9WYtRiuoAEr3JEkmq1k6DHsWDVwPTpvDSNW7zEBzcDo8rZPAYA9RgigVofN33vfAGAHJc88xdmsgNExewiSm03u3go6hYKKgsM1qCMsKO2QWDY2kA4erkDxpUhui+NJaZ0xWC1PM3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740004288; c=relaxed/simple;
	bh=h1Xhu0bhIC0Z6639lhwDoB8xl/OFImHogFzEz8t32DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJb7fQndxzaJ0nnj/QLJg6GYo7DBMnGlwKuDe6GR3nW9RNuP2gg8/yrAXkiYMJd38SIyMRg93vS1UBj8A1sLwGOWaGVGlYdJFqSP/iAMHXv3fNyolX/r49f/rh6PAnDUCppE3TE9LuOGuC3CkptX6iFp16DUZvxg0sYHDHkCLzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnFmO668; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB483C4CED1;
	Wed, 19 Feb 2025 22:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740004287;
	bh=h1Xhu0bhIC0Z6639lhwDoB8xl/OFImHogFzEz8t32DI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DnFmO668vpwTC9mYm4J9MtA3NLoDC8WF3bbrEfZsJvEoCsRkJqEH/q5c4PiHKGhAW
	 r62PlE+ksuYke8TAg4DqK4/8y77zYbDopPG6XZ82ECOXvXzxE1sqUARMgd2nwm6IJ+
	 JyeOQCyyiYH1Bq8fkruxjlj9cu+NN4FIYa3g1sN8CR4FsSeKpFg7vv5Yxg4nKtbNqu
	 PiRo7hPCgzcWx2CPEHOCLo9TDu2jOzNXe2a3RHNCabzTcj/ttqSR06xKYF2FveVCqa
	 aqtdybXrKpLqwDWkDQlPkgkDaRQv1yoUk+i2CP6qfJ+ECa+He6Wz7oFxT7k/RTMHCs
	 xR3S2mizGHr4g==
Date: Wed, 19 Feb 2025 14:31:27 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 12/12] iomap: introduce a full map advance helper
Message-ID: <20250219223127.GG21808@frogsfrogsfrogs>
References: <20250219175050.83986-1-bfoster@redhat.com>
 <20250219175050.83986-13-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219175050.83986-13-bfoster@redhat.com>

On Wed, Feb 19, 2025 at 12:50:50PM -0500, Brian Foster wrote:
> Various iomap_iter_advance() calls advance by the full mapping
> length and thus have no need for the current length input or
> post-advance remaining length output from the standard advance
> function. Add an iomap_iter_advance_full() helper to clean up these
> cases.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>  fs/dax.c               | 10 ++++------
>  fs/iomap/buffered-io.c |  3 +--
>  fs/iomap/fiemap.c      |  3 +--
>  fs/iomap/swapfile.c    |  4 +---
>  include/linux/iomap.h  |  9 +++++++++
>  5 files changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index cab3c5abe5cb..7fd4cd9a51f2 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1266,11 +1266,11 @@ static int dax_unshare_iter(struct iomap_iter *iter)
>  	u64 copy_len = iomap_length(iter);
>  	u32 mod;
>  	int id = 0;
> -	s64 ret = iomap_length(iter);
> +	s64 ret;
>  	void *daddr = NULL, *saddr = NULL;
>  
>  	if (!iomap_want_unshare_iter(iter))
> -		return iomap_iter_advance(iter, &ret);
> +		return iomap_iter_advance_full(iter);
>  
>  	/*
>  	 * Extend the file range to be aligned to fsblock/pagesize, because
> @@ -1300,16 +1300,14 @@ static int dax_unshare_iter(struct iomap_iter *iter)
>  	if (ret < 0)
>  		goto out_unlock;
>  
> -	if (copy_mc_to_kernel(daddr, saddr, copy_len) == 0)
> -		ret = iomap_length(iter);
> -	else
> +	if (copy_mc_to_kernel(daddr, saddr, copy_len) != 0)
>  		ret = -EIO;
>  
>  out_unlock:
>  	dax_read_unlock(id);
>  	if (ret < 0)
>  		return dax_mem2blk_err(ret);
> -	return iomap_iter_advance(iter, &ret);
> +	return iomap_iter_advance_full(iter);
>  }
>  
>  int dax_file_unshare(struct inode *inode, loff_t pos, loff_t len,
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 2b86978010bb..e53ac635e47c 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1436,8 +1436,7 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>  				range_dirty = false;
>  				status = iomap_zero_iter_flush_and_stale(&iter);
>  			} else {
> -				u64 length = iomap_length(&iter);
> -				status = iomap_iter_advance(&iter, &length);
> +				status = iomap_iter_advance_full(&iter);
>  			}
>  			iter.status = status;
>  			continue;
> diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
> index 6776b800bde7..80675c42e94e 100644
> --- a/fs/iomap/fiemap.c
> +++ b/fs/iomap/fiemap.c
> @@ -42,7 +42,6 @@ static int iomap_to_fiemap(struct fiemap_extent_info *fi,
>  static int iomap_fiemap_iter(struct iomap_iter *iter,
>  		struct fiemap_extent_info *fi, struct iomap *prev)
>  {
> -	u64 length = iomap_length(iter);
>  	int ret;
>  
>  	if (iter->iomap.type == IOMAP_HOLE)
> @@ -56,7 +55,7 @@ static int iomap_fiemap_iter(struct iomap_iter *iter,
>  		return 0;
>  
>  advance:
> -	return iomap_iter_advance(iter, &length);
> +	return iomap_iter_advance_full(iter);
>  }
>  
>  int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fi,
> diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
> index 9ea185e58ca7..c1a762c10ce4 100644
> --- a/fs/iomap/swapfile.c
> +++ b/fs/iomap/swapfile.c
> @@ -97,8 +97,6 @@ static int iomap_swapfile_fail(struct iomap_swapfile_info *isi, const char *str)
>  static int iomap_swapfile_iter(struct iomap_iter *iter,
>  		struct iomap *iomap, struct iomap_swapfile_info *isi)
>  {
> -	u64 length = iomap_length(iter);
> -
>  	switch (iomap->type) {
>  	case IOMAP_MAPPED:
>  	case IOMAP_UNWRITTEN:
> @@ -135,7 +133,7 @@ static int iomap_swapfile_iter(struct iomap_iter *iter,
>  		memcpy(&isi->iomap, iomap, sizeof(isi->iomap));
>  	}
>  
> -	return iomap_iter_advance(iter, &length);
> +	return iomap_iter_advance_full(iter);
>  }
>  
>  /*
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 29b72a671104..4c7e9fe32117 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -264,6 +264,15 @@ static inline u64 iomap_length(const struct iomap_iter *iter)
>  	return iomap_length_trim(iter, iter->pos, iter->len);
>  }
>  
> +/**
> + * iomap_iter_advance_full - advance by the full length of current map
> + */
> +static inline int iomap_iter_advance_full(struct iomap_iter *iter)
> +{
> +	u64 length = iomap_length(iter);
> +	return iomap_iter_advance(iter, &length);

Dumb nit: blank line between the variable definition and the return
statement.

With that fixed
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> +}
> +
>  /**
>   * iomap_iter_srcmap - return the source map for the current iomap iteration
>   * @i: iteration structure
> -- 
> 2.48.1
> 
> 

