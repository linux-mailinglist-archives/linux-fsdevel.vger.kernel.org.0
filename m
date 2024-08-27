Return-Path: <linux-fsdevel+bounces-27396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA97961387
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 18:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DCF8285720
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 16:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C191C86F4;
	Tue, 27 Aug 2024 16:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcN/sGSb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5A31C6F48;
	Tue, 27 Aug 2024 16:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724774604; cv=none; b=phI5PqfA2C9Gmpuv+INcCHKGtBWCfn4GYNhgYS65LOACHeqDf9kBnF/sjP89PZhBQUSWMj1nRSeGuOHAjttbYVg77NDOq1OLx8S8KWwIwbzidPTz/RL3lrToyxlTZ22xJkACyvW2R3G6AZhm8nY0ELyYD2erjze4EaIlKCsYIqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724774604; c=relaxed/simple;
	bh=BSA7m9MsX7jg2ukXv2KevS4NWp1U+FPypHBWP0YNxHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmbYQBUHeVVAPNB2oJOAJ7lFG+nxfGdq34G4Co0rJ1KrxqvTRsxFMPBVreZJ2JcudFf4zzdDaRrlj1Bb+A70PCnuEQjcanqOM7FBhE+a3J5nZ/3+hcEcPkJrSyLz82ASMspgxv3HhBXxmbUClVHs1aWSSzfnXKY1cLhEkvKqKMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcN/sGSb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B4DC4FF4F;
	Tue, 27 Aug 2024 16:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724774603;
	bh=BSA7m9MsX7jg2ukXv2KevS4NWp1U+FPypHBWP0YNxHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NcN/sGSburL7v6gRy4Mlv0Vi6vL6lO2WrqhGQXTwmLf5S/0rT0qUGPquEQXHJbtQ0
	 f9d7SDsdgiCB7V1srTQBFmHdoJLO6EwNwMNLhi9C9PJrVghKiBFI4K6Nxksycp2jso
	 7nFPf2eIsP3qYY+EN7qgym1QNO/BkZzci3icTKEDpqeAHwyM9PCR90o416UTWzC4RR
	 VaSrAFKwD9m1/g48FjgZ/1rpgC1Zj2Zjlw3S735hHpJ46GglPcnSZUDhDkpDVEBrV+
	 qoC/gZqMR+AHscso1W/fuMcJ6+1Bph3m/lf4mYkkqRQxAJApntj5xQJWyByqxyE0p6
	 ablKRh5W3g54w==
Date: Tue, 27 Aug 2024 09:03:23 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Brian Foster <bfoster@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 4/6] xfs: call xfs_flush_unmap_range from
 xfs_free_file_space
Message-ID: <20240827160323.GS865349@frogsfrogsfrogs>
References: <20240827065123.1762168-1-hch@lst.de>
 <20240827065123.1762168-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827065123.1762168-5-hch@lst.de>

On Tue, Aug 27, 2024 at 08:50:48AM +0200, Christoph Hellwig wrote:
> Call xfs_flush_unmap_range from xfs_free_file_space so that
> xfs_file_fallocate doesn't have to predict which mode will call it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Hmm.  I /think/ it's ok to shift the xfs_flush_unmap_range after the
file_modified and some of the other EINVAL bailouts that can happen
before xfs_free_file_space gets called.  Effectively that means that we
can fail faster now? :)

Later on this means that the cow-around code that the rtreflink patchset
introduces will also get flushed to disk before we start
collapsing/zeroing/punching.  AFAICT that should be fine.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_bmap_util.c |  8 ++++++++
>  fs/xfs/xfs_file.c      | 21 ---------------------
>  2 files changed, 8 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> index fe2e2c93097550..187a0dbda24fc4 100644
> --- a/fs/xfs/xfs_bmap_util.c
> +++ b/fs/xfs/xfs_bmap_util.c
> @@ -848,6 +848,14 @@ xfs_free_file_space(
>  	if (len <= 0)	/* if nothing being freed */
>  		return 0;
>  
> +	/*
> +	 * Now AIO and DIO has drained we flush and (if necessary) invalidate
> +	 * the cached range over the first operation we are about to run.
> +	 */
> +	error = xfs_flush_unmap_range(ip, offset, len);
> +	if (error)
> +		return error;
> +
>  	startoffset_fsb = XFS_B_TO_FSB(mp, offset);
>  	endoffset_fsb = XFS_B_TO_FSBT(mp, offset + len);
>  
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 4cdc54dc96862e..5b9e49da06013c 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -890,27 +890,6 @@ xfs_file_fallocate(
>  	 */
>  	inode_dio_wait(inode);
>  
> -	/*
> -	 * Now AIO and DIO has drained we flush and (if necessary) invalidate
> -	 * the cached range over the first operation we are about to run.
> -	 *
> -	 * We care about zero and collapse here because they both run a hole
> -	 * punch over the range first. Because that can zero data, and the range
> -	 * of invalidation for the shift operations is much larger, we still do
> -	 * the required flush for collapse in xfs_prepare_shift().
> -	 *
> -	 * Insert has the same range requirements as collapse, and we extend the
> -	 * file first which can zero data. Hence insert has the same
> -	 * flush/invalidate requirements as collapse and so they are both
> -	 * handled at the right time by xfs_prepare_shift().
> -	 */
> -	if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE |
> -		    FALLOC_FL_COLLAPSE_RANGE)) {
> -		error = xfs_flush_unmap_range(ip, offset, len);
> -		if (error)
> -			goto out_unlock;
> -	}
> -
>  	error = file_modified(file);
>  	if (error)
>  		goto out_unlock;
> -- 
> 2.43.0
> 
> 

