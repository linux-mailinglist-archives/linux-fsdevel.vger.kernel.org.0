Return-Path: <linux-fsdevel+bounces-56282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95426B1550F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 00:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F410918A5913
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 22:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA32275867;
	Tue, 29 Jul 2025 22:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiEv0YZD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA1C21B908;
	Tue, 29 Jul 2025 22:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753826864; cv=none; b=MNfVFWb89+7uzqY6oKkYiyYQgzuMeKzfqdgcczUCarXIWsHT+1nA1E6Row7P7fHy4Bs60XsWFu/UMC59Jxb/E4u8uTTLrWq+Jokv65Dqgzaj6C4AuQ5J4Jf8odU9V7JARORHb7p27p4uuqNS6J9Syou55WShuH79ZY1CzfIzZyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753826864; c=relaxed/simple;
	bh=Sfq5QjFkz2SK/zAK/YtWTk1A6MRQh5sud+qPxZdZ2UI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVTNgYqYPn4GTqKWuf1xQ5JzOB1fY2vzNyS324HyJtELPWstFrkd2l5LPGzFnVnEaHRWjFBzTlKTQrTTem4Ul8Drg5ddXk0syxLwgwkHW1/ivNYz2U5Q6koTbgTPn9r+rnYoDLPVxhT8Ia3fB5VnWn0jDs5Cc0w0gD6WZpBL8Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiEv0YZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E36C4CEEF;
	Tue, 29 Jul 2025 22:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753826864;
	bh=Sfq5QjFkz2SK/zAK/YtWTk1A6MRQh5sud+qPxZdZ2UI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tiEv0YZDlW9mt7pcAEZrIjsReOnlk/q2o2nmkTr+6pj4Tum/Hwh2Z8/qlLqORRpD3
	 KnFnkONMivW7z0uuWTy/R+iVy6F7A7c2tHEzUgIB7/hY6BE/5VbI/lR5WN5vNwgtWI
	 p4HJfkPEG0THW0p4M8uAQjZ7Z10Kv2Al/2jcrieGR95EH4AAhUGHwkCbhTwcdff5P6
	 ur68rXT/89u36NUzfE3NTADEjEtoSiZhq8E+Z1W1nltJUsgUmvapM7/rbc62v00nqk
	 V0HniZxZ2Tv4PeVd6NiOwSkLVoDbW/4X1olB0gQUEhmBGkzJ6N49tGGgLgfqK5L3f0
	 0nz4oj2sDrmQg==
Date: Tue, 29 Jul 2025 15:07:43 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, david@fromorbit.com, ebiggers@kernel.org,
	hch@lst.de, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH RFC 01/29] iomap: add iomap_writepages_unbound() to write
 beyond EOF
Message-ID: <20250729220743.GI2672049@frogsfrogsfrogs>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
 <20250728-fsverity-v1-1-9e5443af0e34@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728-fsverity-v1-1-9e5443af0e34@kernel.org>

On Mon, Jul 28, 2025 at 10:30:05PM +0200, Andrey Albershteyn wrote:
> From: Andrey Albershteyn <aalbersh@redhat.com>
> 
> Add iomap_writepages_unbound() without limit in form of EOF. XFS
> will use this to write metadata (fs-verity Merkle tree) in range far
> beyond EOF.

...and I guess some day fscrypt might use it to encrypt merkle trees
too?

> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/iomap/buffered-io.c | 51 +++++++++++++++++++++++++++++++++++++++-----------
>  include/linux/iomap.h  |  3 +++
>  2 files changed, 43 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 3729391a18f3..7bef232254a3 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1881,18 +1881,10 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	int error = 0;
>  	u32 rlen;
>  
> -	WARN_ON_ONCE(!folio_test_locked(folio));
> -	WARN_ON_ONCE(folio_test_dirty(folio));
> -	WARN_ON_ONCE(folio_test_writeback(folio));
> -
> -	trace_iomap_writepage(inode, pos, folio_size(folio));
> -
> -	if (!iomap_writepage_handle_eof(folio, inode, &end_pos)) {
> -		folio_unlock(folio);
> -		return 0;
> -	}
>  	WARN_ON_ONCE(end_pos <= pos);
>  
> +	trace_iomap_writepage(inode, pos, folio_size(folio));
> +
>  	if (i_blocks_per_folio(inode, folio) > 1) {
>  		if (!ifs) {
>  			ifs = ifs_alloc(inode, folio, 0);
> @@ -1956,6 +1948,23 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	return error;
>  }
>  
> +/* Map pages bound by EOF */
> +static int iomap_writepage_map_eof(struct iomap_writepage_ctx *wpc,

iomap_writepage_map_within_eof ?

> +		struct writeback_control *wbc, struct folio *folio)
> +{
> +	int error;
> +	struct inode *inode = folio->mapping->host;
> +	u64 end_pos = folio_pos(folio) + folio_size(folio);
> +
> +	if (!iomap_writepage_handle_eof(folio, inode, &end_pos)) {
> +		folio_unlock(folio);
> +		return 0;
> +	}
> +
> +	error = iomap_writepage_map(wpc, wbc, folio);
> +	return error;
> +}
> +
>  int
>  iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
>  		struct iomap_writepage_ctx *wpc,
> @@ -1972,9 +1981,29 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
>  			PF_MEMALLOC))
>  		return -EIO;
>  
> +	wpc->ops = ops;
> +	while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
> +		WARN_ON_ONCE(!folio_test_locked(folio));
> +		WARN_ON_ONCE(folio_test_dirty(folio));
> +		WARN_ON_ONCE(folio_test_writeback(folio));
> +
> +		error = iomap_writepage_map_eof(wpc, wbc, folio);
> +	}
> +	return iomap_submit_ioend(wpc, error);
> +}
> +EXPORT_SYMBOL_GPL(iomap_writepages);
> +
> +int
> +iomap_writepages_unbound(struct address_space *mapping, struct writeback_control *wbc,

Might want to leave a comment here explaining what's the difference
between the two iomap_writepages exports:

/*
 * Write dirty pages, including any beyond EOF.  This is solely for use
 * by files that allow post-EOF pagecache, which means fsverity.
 */

> +		struct iomap_writepage_ctx *wpc,
> +		const struct iomap_writeback_ops *ops)
> +{
> +	struct folio *folio = NULL;
> +	int error;
> +

...and you might want a:

	WARN_ON(!IS_VERITY(wpc->inode));

to keep it that way.

--D

>  	wpc->ops = ops;
>  	while ((folio = writeback_iter(mapping, wbc, folio, &error)))
>  		error = iomap_writepage_map(wpc, wbc, folio);
>  	return iomap_submit_ioend(wpc, error);
>  }
> -EXPORT_SYMBOL_GPL(iomap_writepages);
> +EXPORT_SYMBOL_GPL(iomap_writepages_unbound);
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 522644d62f30..4a0b5ebb79e9 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -464,6 +464,9 @@ void iomap_sort_ioends(struct list_head *ioend_list);
>  int iomap_writepages(struct address_space *mapping,
>  		struct writeback_control *wbc, struct iomap_writepage_ctx *wpc,
>  		const struct iomap_writeback_ops *ops);
> +int iomap_writepages_unbound(struct address_space *mapping,
> +		struct writeback_control *wbc, struct iomap_writepage_ctx *wpc,
> +		const struct iomap_writeback_ops *ops);
>  
>  /*
>   * Flags for direct I/O ->end_io:
> 
> -- 
> 2.50.0
> 
> 

