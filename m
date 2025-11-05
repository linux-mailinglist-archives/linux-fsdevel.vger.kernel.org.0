Return-Path: <linux-fsdevel+bounces-67014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67014C33739
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 01:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25D2F426498
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 00:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7532221F13;
	Wed,  5 Nov 2025 00:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYc5xhMk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC601DFDE;
	Wed,  5 Nov 2025 00:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762301686; cv=none; b=s5jHSu5wc5NV2FuFgO1/FOTl5i72M/fOWA6GZMGZ4LHYTjElnz7hKpxu8VKSkwDNeZAqR0f0SkuqULEbxitHiTKAMxpRa4bQzRfnD19RSfPjhUTSy2qk12KsBbvdTW1E0tyOzlSDlno//2E0qNSdbT5cKSFS7xOY6ZAZIzmAK1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762301686; c=relaxed/simple;
	bh=4+OjzYPim783G2VpmBxIU6MsTjyuOWle5mtI3ZIzbf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqZ/Xyrk6mGsLbZ8+IVb+DCOuDvEIa3Hj58TUf4J8Cv0yQgY1qXnIoy9uOcWGqfh7gV2wePmx6wJefj2pTRmo+MPpJr/E8MrRsKwzFsa1ApUQOhkV79Aca63aiHP9ZIAeMcENpF6fGhax4iL7tBVJIGvTpXlBJTmO6WyvaoI5UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYc5xhMk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89E1C4CEF7;
	Wed,  5 Nov 2025 00:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762301685;
	bh=4+OjzYPim783G2VpmBxIU6MsTjyuOWle5mtI3ZIzbf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dYc5xhMkmKlmESYXPy5QaO+IDAadw2tJR/IBn4pDt2qurgrYmjdULmwqnKGuQH/+1
	 hDUDII7Ws9P6Xd1KOxMHvpcoxJ+nBFC7BD3wX8zlY8DXRzKg8g8W0Qo2y5nz6fxAwb
	 86MaiUKF7FXk/L04cCyiXkTEcL3hW5UuCeHIeP13KOgCYuIXW8EcqlrwRW3/IeW7/2
	 ZZWTCR4UIddO86paXxOFBW9w4wJ1DDCImtz5m1uzxAykvL5zFhfRDVncl4u96dmItS
	 gMOgHssDh975QOlTlBVegzP1JyPpxANdIdokmHbQjAhwJTM/OTtVt+yjHE+KOmVG9f
	 6Gri0XyG1PA8A==
Date: Tue, 4 Nov 2025 16:14:45 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 3/6] xfs: flush eof folio before insert range size update
Message-ID: <20251105001445.GW196370@frogsfrogsfrogs>
References: <20251016190303.53881-1-bfoster@redhat.com>
 <20251016190303.53881-4-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016190303.53881-4-bfoster@redhat.com>

On Thu, Oct 16, 2025 at 03:03:00PM -0400, Brian Foster wrote:
> The flush in xfs_buffered_write_iomap_begin() for zero range over a
> data fork hole fronted by COW fork prealloc is primarily designed to
> provide correct zeroing behavior in particular pagecache conditions.
> As it turns out, this also partially masks some odd behavior in
> insert range (via zero range via setattr).
> 
> Insert range bumps i_size the length of the new range, flushes,
> unmaps pagecache and cancels COW prealloc, and then right shifts
> extents from the end of the file back to the target offset of the
> insert. Since the i_size update occurs before the pagecache flush,
> this creates a transient situation where writeback around EOF can
> behave differently.

Why not flush the file from @offset to EOF, flush the COW
preallocations, extend i_size, and only then start shifting extents?
That would seem a lot more straightforward to me.

--D

> This appears to be corner case situation, but if happens to be
> fronted by COW fork speculative preallocation and a large, dirty
> folio that contains at least one full COW block beyond EOF, the
> writeback after i_size is bumped may remap that COW fork block into
> the data fork within EOF. The block is zeroed and then shifted back
> out to post-eof, but this is unexpected in that it leads to a
> written post-eof data fork block. This can cause a zero range
> warning on a subsequent size extension, because we should never find
> blocks that require physical zeroing beyond i_size.
> 
> To avoid this quirk, flush the EOF folio before the i_size update
> during insert range. The entire range will be flushed, unmapped and
> invalidated anyways, so this should be relatively unnoticeable.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>  fs/xfs/xfs_file.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 5b9864c8582e..cc3a9674ad40 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1226,6 +1226,23 @@ xfs_falloc_insert_range(
>  	if (offset >= isize)
>  		return -EINVAL;
>  
> +	/*
> +	 * Let writeback clean up EOF folio state before we bump i_size. The
> +	 * insert flushes before it starts shifting and under certain
> +	 * circumstances we can write back blocks that should technically be
> +	 * considered post-eof (and thus should not be submitted for writeback).
> +	 *
> +	 * For example, a large, dirty folio that spans EOF and is backed by
> +	 * post-eof COW fork preallocation can cause block remap into the data
> +	 * fork. This shifts back out beyond EOF, but creates an expectedly
> +	 * written post-eof block. The insert is going to flush, unmap and
> +	 * cancel prealloc across this whole range, so flush EOF now before we
> +	 * bump i_size to provide consistent behavior.
> +	 */
> +	error = filemap_write_and_wait_range(inode->i_mapping, isize, isize);
> +	if (error)
> +		return error;
> +
>  	error = xfs_falloc_setsize(file, isize + len);
>  	if (error)
>  		return error;
> -- 
> 2.51.0
> 
> 

