Return-Path: <linux-fsdevel+bounces-37228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9279EFCD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 20:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F0C16A0AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 19:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0DA1A83E3;
	Thu, 12 Dec 2024 19:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJ/qS7jc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C5B25948B;
	Thu, 12 Dec 2024 19:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734033419; cv=none; b=Af9U9db0eFw08H8WWSFjq0ObvWgcRpwC9c4/ZC6S20tAuT9Ma2LxjPnJJgnyGGyYycsCIxuGNxCox7bPrjFJQMDNhBEKEeVYaSOsxoNDW//FCG8S/7HRuI1NVT/m6eWxFJFlBdOQOgdvElUTTDWRYGqp2rtqpszm/TkOTCs5srE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734033419; c=relaxed/simple;
	bh=wiFZJpsobcr+yJCVPiyuBtwpZHwd89DN2Oo077orAhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJigIhs9l2wWU3PvQsEDdEFLlUtpY7XgkL+jiiTfd3w8U3aviclxAehyaTc4VbYYyoxQpHi+EygvhywFDvcdb0qBSCdBITbjjA3EasDQsyEL3kH36/OYvxxJ6qxP9VqdkX/c5Nj9JYxIFi0I4q4gtl3NMnAmu49fSwimqX9/ce4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJ/qS7jc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BE6C4CED3;
	Thu, 12 Dec 2024 19:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734033419;
	bh=wiFZJpsobcr+yJCVPiyuBtwpZHwd89DN2Oo077orAhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DJ/qS7jcjVGXTo7vuwPlwCWz/h4lJOeMCoWhrAjUjCKauxSyXcVGBLHWkDwhMIbXH
	 SrKpicyrhc8oZDlduIgAtXyOLWiDzA427zKnay5i5nznJAQWdrNx3rwoYBd6smQtWX
	 4J2DAV6+KVscClS2IfJ4qFBsyzlm7Zc2YsWp0BtZmNaJjePXcTM1sQXoIkUUvt2mUa
	 ViopQchx+UiftFuBm+AgaPZ3HU4/BE/mmrNB5LhidmhQle1FASxHFv7LCT4ag+UOoc
	 hffXk36uPSwk4w0fb0upy+QUmP8BN6+yoXvXU4IAFiGGG0tXMrpIr1xIPk0Ce5QzLr
	 v/HP3vTe6TWcw==
Date: Thu, 12 Dec 2024 11:56:58 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 8/8] iomap: pass private data to iomap_truncate_page
Message-ID: <20241212195658.GJ6678@frogsfrogsfrogs>
References: <20241211085420.1380396-1-hch@lst.de>
 <20241211085420.1380396-9-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211085420.1380396-9-hch@lst.de>

On Wed, Dec 11, 2024 at 09:53:48AM +0100, Christoph Hellwig wrote:
> Allow the file system to pass private data which can be used by the
> iomap_begin and iomap_end methods through the private pointer in the
> iomap_iter structure.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Patches 6-8 look obviously correct to me, so for those three:
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 4 ++--
>  fs/xfs/xfs_iomap.c     | 2 +-
>  include/linux/iomap.h  | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 6bfee1c7aedb..ccb2c6cbb18e 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1464,7 +1464,7 @@ EXPORT_SYMBOL_GPL(iomap_zero_range);
>  
>  int
>  iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
> -		const struct iomap_ops *ops)
> +		const struct iomap_ops *ops, void *private)
>  {
>  	unsigned int blocksize = i_blocksize(inode);
>  	unsigned int off = pos & (blocksize - 1);
> @@ -1473,7 +1473,7 @@ iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
>  	if (!off)
>  		return 0;
>  	return iomap_zero_range(inode, pos, blocksize - off, did_zero, ops,
> -			NULL);
> +			private);
>  }
>  EXPORT_SYMBOL_GPL(iomap_truncate_page);
>  
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 3410c55f544a..5dd0922fe2d1 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1512,5 +1512,5 @@ xfs_truncate_page(
>  		return dax_truncate_page(inode, pos, did_zero,
>  					&xfs_dax_write_iomap_ops);
>  	return iomap_truncate_page(inode, pos, did_zero,
> -				   &xfs_buffered_write_iomap_ops);
> +				   &xfs_buffered_write_iomap_ops, NULL);
>  }
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 2a88dfa6ec55..19a2554622e6 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -315,7 +315,7 @@ int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
>  int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
>  		bool *did_zero, const struct iomap_ops *ops, void *private);
>  int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
> -		const struct iomap_ops *ops);
> +		const struct iomap_ops *ops, void *private);
>  vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops,
>  		void *private);
>  typedef void (*iomap_punch_t)(struct inode *inode, loff_t offset, loff_t length,
> -- 
> 2.45.2
> 
> 

