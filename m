Return-Path: <linux-fsdevel+bounces-16149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FDD89937F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 04:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 616F51C21D56
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 02:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF01A1CF92;
	Fri,  5 Apr 2024 02:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5gASsny"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3479679C4;
	Fri,  5 Apr 2024 02:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712285873; cv=none; b=uq+oWlmA6A5in3y6k9CYMvaZOD2opZKX/AIMwhHFLfrrzprEr09AjDMlfn15pDuSdAHRny0oHb43F5lV6BFXjDWXdkEGy6cccTYw7j9d6NW98CgBvvIzidQTmfBdMptdwPYkKTvSAu+vwFzh/h9Uy8tyDAs/Ktoz2xjhijXacQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712285873; c=relaxed/simple;
	bh=m3WXWEEhPhVQl5kxUeImxsYhV8Dw5UIoX9zNL2iPdQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3f+Fgy8TLWPFGPjw2evz31YX56k/B3KXTauiAuVLg5CAstBVPmsvkOnRubtBbgEkdlyPuy+caZUNST0o00kllRuD3CbU/VzVGTuZaU1+QXQ9bMwPryw2jWLfLwgGxPqYYkvxWbWfmPzOG1FCTdHiU1P4PW8KgHD5CnwZQyawrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5gASsny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F57C433C7;
	Fri,  5 Apr 2024 02:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712285872;
	bh=m3WXWEEhPhVQl5kxUeImxsYhV8Dw5UIoX9zNL2iPdQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G5gASsnyx7hojCH91Ban2EgZ8gEwcp4Tu+xcLI+crxd3FBgxgeKQXn1couHyqn/Ip
	 5wNbVbg7n/MwK83IuXiT9PQo03rgBRMI9+yo7qcJbCz0aRtWYfku/11uARkpdBRWpg
	 mVISHzBJLnpn3Bjvcgwc1irjMoeeKJMRzFLnalIcErZc3eyr140Ld/bs1g4cgeHSai
	 kxCN3kLaG4uLqPfDtpxRC55tvQqrn+IvKSkFHb5HgFpgK5H2SRZ4whLh4NhltZgq4S
	 NwxUvSF1vghSMk9I+sZjS/hz5nlachhz9A/urPmRkLTLtMWMjCO4x+aDLzdTogFchU
	 C8ZaEEflV3/TQ==
Date: Thu, 4 Apr 2024 22:57:50 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: aalbersh@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 10/13] fsverity: pass the zero-hash value to the
 implementation
Message-ID: <20240405025750.GH1958@quark.localdomain>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
 <171175868031.1987804.13138670908694064691.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171175868031.1987804.13138670908694064691.stgit@frogsfrogsfrogs>

On Fri, Mar 29, 2024 at 05:35:17PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Compute the hash of a data block full of zeros, and then supply this to
> the merkle tree read and write methods.  A subsequent xfs patch will use

This should say "hash of a block", not "hash of a data block".  What you
actually care about is the hash of a Merkle tree block, not the hash of a data
block.  Yet, there is no difference in how the hashes are calculated for the two
types of blocks, so we should simply write "hash of a block".

> diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
> index de8798f141d4a..195a92f203bba 100644
> --- a/fs/verity/fsverity_private.h
> +++ b/fs/verity/fsverity_private.h
> @@ -47,6 +47,8 @@ struct merkle_tree_params {
>  	u64 tree_size;			/* Merkle tree size in bytes */
>  	unsigned long tree_pages;	/* Merkle tree size in pages */
>  
> +	u8 zero_digest[FS_VERITY_MAX_DIGEST_SIZE]; /* hash of zeroed data block */

Similarly, "block" instead of "data block".

> diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
> index 5dacd30d65353..761a0b76eefec 100644
> --- a/include/linux/fsverity.h
> +++ b/include/linux/fsverity.h
> @@ -66,6 +66,8 @@ struct fsverity_blockbuf {
>   *		if the page at @block->offset isn't already cached.
>   *		Implementations may ignore this argument; it's only a
>   *		performance optimization.
> + * @zero_digest: the hash for a data block of zeroes

Likewise.

>  /**
> @@ -81,12 +85,16 @@ struct fsverity_readmerkle {
>   * @level: level of the block; level 0 are the leaves
>   * @num_levels: number of levels in the tree total
>   * @log_blocksize: log2 of the size of the block
> + * @zero_digest: the hash for a data block of zeroes
> + * @digest_size: size of zero_digest

Likewise.

- Eric

