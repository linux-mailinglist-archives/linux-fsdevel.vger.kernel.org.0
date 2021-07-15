Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1D43CAEF6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 00:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbhGOWOT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 18:14:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229927AbhGOWOT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 18:14:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49D436117A;
        Thu, 15 Jul 2021 22:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626387085;
        bh=mU8IxQLXIJVg/zkRJqgrYqRpoPatjq8fJe0GfF1JrvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IPKe3q105/TOxOYPtJTTOwkQ2S2H8ZphuTtkriYun61+2wdi0Mzgz4vXxxe7Suy2j
         DpetdcbMIUT/px8vmMx5FzwTD8FNWp8kKVPKQe6jyJ66oDBw/1zyOL0Y1NxV1m3vt0
         mNMLwq81F5fFiRYstSfU3z9HxuKIF+tEcYONMMyCl0c3IofjC6DzOkEhkj0kuR3whn
         jufl3KN1egpswiqxexvZEo53XdGzhrEBNTullMAIokX6cOxaEjuiFqrMEji6Yc0XT2
         kux9DD8+4mue5DltD1KKbi2WWp1hdBXnCmL4ufRrJ+xcX4wmOa6uWEO4ttmOcIwv+n
         GvPpwOyxgZE4Q==
Date:   Thu, 15 Jul 2021 15:11:25 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 129/138] xfs: Support THPs
Message-ID: <20210715221125.GU22357@magnolia>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-130-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-130-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:36:55AM +0100, Matthew Wilcox (Oracle) wrote:
> There is one place which assumes the size of a page; fix it.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/xfs/xfs_aops.c  | 11 ++++++-----
>  fs/xfs/xfs_super.c |  3 ++-
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index cb4e0fcf4c76..9ffbd116592a 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -432,10 +432,11 @@ xfs_discard_page(
>  	struct page		*page,
>  	loff_t			fileoff)

/me wonders if this parameter ought to become pos like most other
places, but as a straight-up conversion it looks fine to me.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  {
> -	struct inode		*inode = page->mapping->host;
> +	struct folio		*folio = page_folio(page);
> +	struct inode		*inode = folio->mapping->host;
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	struct xfs_mount	*mp = ip->i_mount;
> -	unsigned int		pageoff = offset_in_page(fileoff);
> +	size_t			pageoff = offset_in_folio(folio, fileoff);
>  	xfs_fileoff_t		start_fsb = XFS_B_TO_FSBT(mp, fileoff);
>  	xfs_fileoff_t		pageoff_fsb = XFS_B_TO_FSBT(mp, pageoff);
>  	int			error;
> @@ -445,14 +446,14 @@ xfs_discard_page(
>  
>  	xfs_alert_ratelimited(mp,
>  		"page discard on page "PTR_FMT", inode 0x%llx, offset %llu.",
> -			page, ip->i_ino, fileoff);
> +			folio, ip->i_ino, fileoff);
>  
>  	error = xfs_bmap_punch_delalloc_range(ip, start_fsb,
> -			i_blocks_per_page(inode, page) - pageoff_fsb);
> +			i_blocks_per_folio(inode, folio) - pageoff_fsb);
>  	if (error && !XFS_FORCED_SHUTDOWN(mp))
>  		xfs_alert(mp, "page discard unable to remove delalloc mapping.");
>  out_invalidate:
> -	iomap_invalidatepage(page, pageoff, PAGE_SIZE - pageoff);
> +	iomap_invalidatepage(&folio->page, pageoff, folio_size(folio) - pageoff);
>  }
>  
>  static const struct iomap_writeback_ops xfs_writeback_ops = {
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 2c9e26a44546..24adea02b887 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1891,7 +1891,8 @@ static struct file_system_type xfs_fs_type = {
>  	.init_fs_context	= xfs_init_fs_context,
>  	.parameters		= xfs_fs_parameters,
>  	.kill_sb		= kill_block_super,
> -	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
> +	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | \
> +				  FS_THP_SUPPORT,
>  };
>  MODULE_ALIAS_FS("xfs");
>  
> -- 
> 2.30.2
> 
