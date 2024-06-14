Return-Path: <linux-fsdevel+bounces-21690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E72B0908374
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 07:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042DD1C20F65
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 05:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D80B1482E2;
	Fri, 14 Jun 2024 05:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QwxU+VsQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A81145B34;
	Fri, 14 Jun 2024 05:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718344619; cv=none; b=poavpz4qubKfDCxc8YKZFIB18M2xEpGBgqrAOv8BQ/fU164KnA+4mlu46THuyMTEnu/CI/0zy/h70Ayj+kAHeTZPAXP/b5y/95PJ2q7RBfD6IHd6VJ4AVBTBvgduYm9y5JI/UeQU4HJTOhCD8pgf9ojMeOgIMwYQQ05ixTHeDM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718344619; c=relaxed/simple;
	bh=9e63V/aitR05S10xPdwh2WzKG5CZqxBgdcljUnT4fEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAbb3CUWuJsSBEyGDpUzXkdfEuvOFVJ6HXwTn48mBWcE84IMo6E6PRiXmPBawS1Tm6rfxoOCuE3XQ6vh7JS3ql5mqhYsfM2YGE81zK9RDlTLUE6LXfPFNN73ai+dkbN9sdm8n6uBSdHqcQIbIOVUOE+I5rSTBJOk0Y4b3+P3mWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QwxU+VsQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BdOBQlv2UEIzA+JbBGsNcVjy+aAn9V5BzVl0meTkVSA=; b=QwxU+VsQXgVdPLL57Z0m45O0sg
	LkN8a04tcbHxhOlGe2TpZE9QE2WdGtFmJJ0mGzIUgjCb3+2LRw1MR0dik3CwdEkjg9PS0bJU9nuyp
	Ul766Xa9OOmq/h49xysJLA7aMX1qI5WXrOsjFwKqFShyzQLsAsheGs2e3uWrEt51cUnPV7pZ1gD/q
	AyRbDac0g//Z0Lfh8Joaw4cxBu2lVSRDSDLiOOCo0X+RnAubuU0bRt8UrWNpWMk/tMqcWwq2g4q0l
	EumSgTp2jndVrqke0/6mN5CVtIkp9RFriQg94qpw+NPlJLTRONIH08Rw6RA6cUH77iITnXW1YKyZw
	Mi8jU9Jg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHzvg-00000001Yqi-20XX;
	Fri, 14 Jun 2024 05:56:52 +0000
Date: Thu, 13 Jun 2024 22:56:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
	jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: Re: [PATCH -next v5 2/8] iomap: pass blocksize to
 iomap_truncate_page()
Message-ID: <ZmvbpFjEkYguGHha@infradead.org>
References: <20240613090033.2246907-1-yi.zhang@huaweicloud.com>
 <20240613090033.2246907-3-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613090033.2246907-3-yi.zhang@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jun 13, 2024 at 05:00:27PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> iomap_truncate_page() always assumes the block size of the truncating
> inode is i_blocksize(), this is not always true for some filesystems,
> e.g. XFS does extent size alignment for realtime inodes. Drop this
> assumption and pass the block size for zeroing into
> iomap_truncate_page(), allow filesystems to indicate the correct block
> size.

FYI, I still prefer to just kill iomap_truncate_page in it's current
form instead.

>  #include "../internal.h"
> @@ -1453,11 +1454,10 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>  EXPORT_SYMBOL_GPL(iomap_zero_range);
>  
>  int
> -iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
> -		const struct iomap_ops *ops)
> +iomap_truncate_page(struct inode *inode, loff_t pos, unsigned int blocksize,
> +		bool *did_zero, const struct iomap_ops *ops)
>  {
> -	unsigned int blocksize = i_blocksize(inode);
> -	unsigned int off = pos & (blocksize - 1);
> +	unsigned int off = rem_u64(pos, blocksize);
>  
>  	/* Block boundary? Nothing to do */
>  	if (!off)
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 378342673925..32306804b01b 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1471,10 +1471,11 @@ xfs_truncate_page(
>  	bool			*did_zero)
>  {
>  	struct inode		*inode = VFS_I(ip);
> +	unsigned int		blocksize = i_blocksize(inode);
>  
>  	if (IS_DAX(inode))
>  		return dax_truncate_page(inode, pos, did_zero,
>  					&xfs_dax_write_iomap_ops);
> -	return iomap_truncate_page(inode, pos, did_zero,
> +	return iomap_truncate_page(inode, pos, blocksize, did_zero,
>  				   &xfs_buffered_write_iomap_ops);
>  }
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 6fc1c858013d..d67bf86ec582 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -273,8 +273,8 @@ int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
>  		const struct iomap_ops *ops);
>  int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
>  		bool *did_zero, const struct iomap_ops *ops);
> -int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
> -		const struct iomap_ops *ops);
> +int iomap_truncate_page(struct inode *inode, loff_t pos, unsigned int blocksize,
> +		bool *did_zero, const struct iomap_ops *ops);
>  vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf,
>  			const struct iomap_ops *ops);
>  int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> -- 
> 2.39.2
> 
> 
---end quoted text---

