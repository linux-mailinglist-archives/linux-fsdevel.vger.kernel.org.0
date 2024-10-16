Return-Path: <linux-fsdevel+bounces-32144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6019A1393
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 22:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 505CB282240
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 20:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1BC215F6E;
	Wed, 16 Oct 2024 20:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1ZfgBAq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F095A20FA84;
	Wed, 16 Oct 2024 20:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109621; cv=none; b=jM3Ey746HeTRFKEKVVkCTgtpAtr5JkbLc2iGl0iax3YLwUWXpqqofhQOOb+D14hNQ5e5uzBKaQZnN79MDuQlG2Pp0sTBAQzMxA+7Uco9EcgrghKrmRmF8C93mFQV1o4JOPql92cvayncJBXcDkZAT/fL3Y2XYponMdRfp9HbzyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109621; c=relaxed/simple;
	bh=XeEmwdlnrGCmiPuThMEx8Sc0rwthBwlI1gzpvmO+KOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTMgmupktbc+7Cm7T/zbqcpSlSGs+HlwbShbAMnP3yBm/t4gb4aF9+UysgGCuxzNEtnAJgSL44/HwpzKfO3ZlLWTSOMa0RPjR+9i9prM8MIzYlhUllfklH32FCpsrlW8XCesLUMWaMCv2dhQ/nV7s3wULWDyxGlbQHMEeT1XhQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1ZfgBAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C201DC4CEC5;
	Wed, 16 Oct 2024 20:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729109620;
	bh=XeEmwdlnrGCmiPuThMEx8Sc0rwthBwlI1gzpvmO+KOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G1ZfgBAqw2Mw3eYLg0oNxy37wLer5/GQ9CSwX7uIoTfEy84OwSHuYZxbyB5BhtYsZ
	 3o/cmAEsyhDn7AiNGhBwj0AU+QhWcFmmBA4IlL+pizxaFf7mUStsO0ghIw6KqDlmYd
	 SulN/67f+AKdVABNmyB9VCHPIocB4hvqaXiVI/mS4VSu9cyPWbJkWkkQqYyof9RyNM
	 wWLxkjoQsvBOmjXEgO1lfOWa6Jjh5auDqE9wddIAQv0Gq31ax1EoXqkC7ulUCZpQlq
	 P5FkXSUBM0MqkZu0OvQZFbwVnYb+6+/G1fAk1wpoS0g5+IAd40LWr/sFqigtqVwas0
	 5YAxQQIv9/Jsw==
Date: Wed, 16 Oct 2024 13:13:40 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, dchinner@redhat.com, hch@lst.de, cem@kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	hare@suse.de, martin.petersen@oracle.com,
	catherine.hoang@oracle.com, mcgrof@kernel.org,
	ritesh.list@gmail.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH v9 7/8] xfs: Validate atomic writes
Message-ID: <20241016201340.GQ21853@frogsfrogsfrogs>
References: <20241016100325.3534494-1-john.g.garry@oracle.com>
 <20241016100325.3534494-8-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016100325.3534494-8-john.g.garry@oracle.com>

On Wed, Oct 16, 2024 at 10:03:24AM +0000, John Garry wrote:
> Validate that an atomic write adheres to length/offset rules. Currently
> we can only write a single FS block.
> 
> For an IOCB with IOCB_ATOMIC set to get as far as xfs_file_write_iter(),
> FMODE_CAN_ATOMIC_WRITE will need to be set for the file; for this,
> ATOMICWRITES flags would also need to be set for the inode.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

This looks ok to me now,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_file.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index b19916b11fd5..1ccbc1eb75c9 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -852,6 +852,20 @@ xfs_file_write_iter(
>  	if (IS_DAX(inode))
>  		return xfs_file_dax_write(iocb, from);
>  
> +	if (iocb->ki_flags & IOCB_ATOMIC) {
> +		/*
> +		 * Currently only atomic writing of a single FS block is
> +		 * supported. It would be possible to atomic write smaller than
> +		 * a FS block, but there is no requirement to support this.
> +		 * Note that iomap also does not support this yet.
> +		 */
> +		if (ocount != ip->i_mount->m_sb.sb_blocksize)
> +			return -EINVAL;
> +		ret = generic_atomic_write_valid(iocb, from);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	if (iocb->ki_flags & IOCB_DIRECT) {
>  		/*
>  		 * Allow a directio write to fall back to a buffered
> -- 
> 2.31.1
> 
> 

