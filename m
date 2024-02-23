Return-Path: <linux-fsdevel+bounces-12537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 398AD860A41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 06:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0AB0288DA7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 05:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25CB11CAE;
	Fri, 23 Feb 2024 05:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/bx2gRH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5525412B61;
	Fri, 23 Feb 2024 05:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708666179; cv=none; b=VCaaiBym7Wt4JeEFUiK3xOemrLMXGPKL6HM2kKQxAo2VL8LpV2+wzq+ZoRDw8lk2kHYPyndxpprDpWQp17qR5qYBr9kHwW9LLDfJh4KTmM54wQB67bKNUEel2EAzMuULkJ+iqdzCS3+RoB7Fkbz0rDDoBoldzBWlfVTiREOBl78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708666179; c=relaxed/simple;
	bh=qEOpU+J7nbavnwrhSLeCq5QIaATVinqTG5zrsF+IGqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFJ/V3PwZXnuRYj4BhLc20cCxceuC4gGMDNS1mFV4b+/pqj+DVrXbYgn58DeGtG/E1W/hJcGDtyqXX+pWt1M8uxMkIk2We1x/lQptqKKfYdEP7pAfSqQLOJfYw/Rsnn+OHmfgtPcBnUgyPySF4HfLZWMkE6B+EYFlFjWpWX0mS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/bx2gRH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9229C433C7;
	Fri, 23 Feb 2024 05:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708666178;
	bh=qEOpU+J7nbavnwrhSLeCq5QIaATVinqTG5zrsF+IGqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e/bx2gRHNQkervzAE5E3yypB3Vm7uE7sHrV10P6zq+DDzmY9eYX7vEFj7et3MTNh1
	 9AEe7sYQ2KxJCFjdszLcmZQt0NLwVU0RmaYmp5F4bg3VyoHNITLj5FTJEy1uCIPotD
	 0HVXHt6qArqmSndbNP4erZQcf74fGgx8aV2SU1ym58v33uDWBJCImyskoumV+FtS7B
	 j8x/B68ZPReCNdAIsUn9uXGUTPgIBVovM6yFD1q95T98zJs8QM98h598SXxMu7jQfA
	 /EG69fN21uE5BxRw+8Ozte7s6WJ/foiIjJ1mk0DKUuH5BdruPcgrT3tr+tGzRAiH2h
	 trDCp+KYfBIAw==
Date: Thu, 22 Feb 2024 21:29:37 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com,
	djwong@kernel.org
Subject: Re: [PATCH v4 08/25] fsverity: calculate readahead in bytes instead
 of pages
Message-ID: <20240223052937.GD25631@sol.localdomain>
References: <20240212165821.1901300-1-aalbersh@redhat.com>
 <20240212165821.1901300-9-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212165821.1901300-9-aalbersh@redhat.com>

On Mon, Feb 12, 2024 at 05:58:05PM +0100, Andrey Albershteyn wrote:
> +		u64 block_offset;

'hblock_pos', to make it clear that it's in bytes, and that it's for the hash
block, not the data block.

> +		u64 ra_bytes = 0;
> +		u64 tree_size;
>  
>  		/*
>  		 * The index of the block in the current level; also the index
> @@ -105,18 +106,20 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
>  		/* Index of the hash block in the tree overall */
>  		hblock_idx = params->level_start[level] + next_hidx;
>  
> -		/* Index of the hash page in the tree overall */
> -		hpage_idx = hblock_idx >> params->log_blocks_per_page;
> +		/* Offset of the Merkle tree block into the tree */
> +		block_offset = hblock_idx << params->log_blocksize;
>  
>  		/* Byte offset of the hash within the block */
>  		hoffset = (hidx << params->log_digestsize) &
>  			  (params->block_size - 1);
>  
> -		num_ra_pages = level == 0 ?
> -			min(max_ra_pages, params->tree_pages - hpage_idx) : 0;
> +		if (level == 0) {
> +			tree_size = params->tree_pages << PAGE_SHIFT;
> +			ra_bytes = min(max_ra_bytes, (tree_size - block_offset));
> +		}

How about:

		ra_bytes = level == 0 ?
			min(max_ra_bytes, params->tree_size - hblock_pos) : 0;

- Eric

