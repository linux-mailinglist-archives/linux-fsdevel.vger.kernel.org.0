Return-Path: <linux-fsdevel+bounces-54915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE286B05109
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 07:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0437E4A2B8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 05:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428EB263F49;
	Tue, 15 Jul 2025 05:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3tw4+WE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F16925FA13;
	Tue, 15 Jul 2025 05:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752557658; cv=none; b=k8tMeXSH4Vfe6a3JOCcCssia+Q4JxfBsAvxZdzHcxWaaJqnxiNLAlfDcSgJoWu2rTy9BvymYHyR3B3NS9dYYb3OdRjGg4i/pO/HnSvZ5U6WKWlas+UcHM4Vjx6aBQZA/DicYBgocgCQICzeozqZcI02Dj8VG0Tqhf75nB4OmL+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752557658; c=relaxed/simple;
	bh=3qxVG0brYicTYe0lEhYy/WteBjTnpFcuTkkfe4/FAME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQtJH6baB/3nhN4TzE/p+8Ge7J9xocHv1TPxDm1qw/A96gB5D8KDcisfDWeNtGI6vhl6zMXpVRihl2rb5nuv7EZ6DqunhSTDf8DmFmpJAjeo7tN+iCwYKVpx0w9ypj1zPPzDkoMUId/4xKMPjSWPhV+1d17R1gCUkz7bKlJB1LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3tw4+WE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DD8C4CEE3;
	Tue, 15 Jul 2025 05:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752557658;
	bh=3qxVG0brYicTYe0lEhYy/WteBjTnpFcuTkkfe4/FAME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P3tw4+WEW7mZG6qa1HvRa+XiDutd2ozlssmYfWFVFD+adFjYsLESvm+8fznAG0/rf
	 lQCREgloSLNcKGT6c60PvZ3H+n2h0N8akKnkZsJHXfBbeWR5DYtEQsdipU3jp3PUq7
	 pbrX1Aj7VSsBlewO1/JKMwvoUTokBn4rWpYQtot1XNlS2/6CqJpWGjShirwB6AaLLj
	 gI0kja6BIf6KRHbvw1gxMc8EVN7gE93d2P4mNtIIUPiOjsIvAr4AWp8BkedlnhaPEb
	 teBh9buC3YVYTUWMhHiJDfjne0UaDJTacP6Ojcfhy0JcJqZTxsfWINdXoOriZq3q0V
	 3sZ0ldlhQLHKg==
Date: Mon, 14 Jul 2025 22:34:17 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, hch@infradead.org, willy@infradead.org
Subject: Re: [PATCH v3 6/7] iomap: remove old partial eof zeroing optimization
Message-ID: <20250715053417.GR2672049@frogsfrogsfrogs>
References: <20250714204122.349582-1-bfoster@redhat.com>
 <20250714204122.349582-7-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714204122.349582-7-bfoster@redhat.com>

On Mon, Jul 14, 2025 at 04:41:21PM -0400, Brian Foster wrote:
> iomap_zero_range() optimizes the partial eof block zeroing use case
> by force zeroing if the mapping is dirty. This is to avoid frequent
> flushing on file extending workloads, which hurts performance.
> 
> Now that the folio batch mechanism provides a more generic solution
> and is used by the only real zero range user (XFS), this isolated
> optimization is no longer needed. Remove the unnecessary code and
> let callers use the folio batch or fall back to flushing by default.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Heh, I was staring at this last Friday chasing fuse+iomap bugs in
fallocate zerorange and straining to remember what this does.
Is this chunk still needed if the ->iomap_begin implementation doesn't
(or forgets to) grab the folio batch for iomap?

My bug turned out to be a bug in my fuse+iomap design -- with the way
iomap_zero_range does things, you have to flush+unmap, punch the range
and zero the range.  If you punch and realloc the range and *then* try
to zero the range, the new unwritten extents cause iomap to miss dirty
pages that fuse should've unmapped.  Ooops.

--D

> ---
>  fs/iomap/buffered-io.c | 24 ------------------------
>  1 file changed, 24 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 194e3cc0857f..d2bbed692c06 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1484,33 +1484,9 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>  		.private	= private,
>  	};
>  	struct address_space *mapping = inode->i_mapping;
> -	unsigned int blocksize = i_blocksize(inode);
> -	unsigned int off = pos & (blocksize - 1);
> -	loff_t plen = min_t(loff_t, len, blocksize - off);
>  	int ret;
>  	bool range_dirty;
>  
> -	/*
> -	 * Zero range can skip mappings that are zero on disk so long as
> -	 * pagecache is clean. If pagecache was dirty prior to zero range, the
> -	 * mapping converts on writeback completion and so must be zeroed.
> -	 *
> -	 * The simplest way to deal with this across a range is to flush
> -	 * pagecache and process the updated mappings. To avoid excessive
> -	 * flushing on partial eof zeroing, special case it to zero the
> -	 * unaligned start portion if already dirty in pagecache.
> -	 */
> -	if (!iter.fbatch && off &&
> -	    filemap_range_needs_writeback(mapping, pos, pos + plen - 1)) {
> -		iter.len = plen;
> -		while ((ret = iomap_iter(&iter, ops)) > 0)
> -			iter.status = iomap_zero_iter(&iter, did_zero);
> -
> -		iter.len = len - (iter.pos - pos);
> -		if (ret || !iter.len)
> -			return ret;
> -	}
> -
>  	/*
>  	 * To avoid an unconditional flush, check pagecache state and only flush
>  	 * if dirty and the fs returns a mapping that might convert on
> -- 
> 2.50.0
> 
> 

