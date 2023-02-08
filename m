Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6E168F353
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 17:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjBHQjc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 11:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjBHQjb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:39:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D0F4DE12;
        Wed,  8 Feb 2023 08:39:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80BB6B81D42;
        Wed,  8 Feb 2023 16:39:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2228EC433EF;
        Wed,  8 Feb 2023 16:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675874360;
        bh=7xFUNQG3xYOOYbpiWsRp4reL9yCaXW7oM7d8qlnJh80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MgrnGtdBIRsUy4vNiURvec5UWQltBtMqCbMwFkeFN+4ug5+powR2UnS62vrIh4cqE
         eCKwN6c8Igp9L+QJcFGT2E8F3S3eETEWBXkJUdFUXHp7Tgwg0L96Wyw23XrX9JvRbz
         UoF0BCbhFfpe7mT87/Gpv7leVPB9tTsVR96qbjzWsznAu2hk9comDc0Rl3uTojM2Kg
         r/k1IB1yxafaVGDxjZ9+QQ+Ae2bRQTS7ypMtC1OGNXa2/Jp8YgZ4Ud6sWe42K7kUol
         faH0d3dYVOgqMu7qJ+UzAE9+qrJJJxDPKgBmbz7RhZt5y5XnWkU1Sg1V/oBUcyruNB
         KF7GwN3K/dnpA==
Date:   Wed, 8 Feb 2023 08:39:19 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/3] xfs: Remove xfs_filemap_map_pages() wrapper
Message-ID: <Y+PQN8cLdOXST20D@magnolia>
References: <20230208145335.307287-1-willy@infradead.org>
 <20230208145335.307287-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208145335.307287-2-willy@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 08, 2023 at 02:53:33PM +0000, Matthew Wilcox (Oracle) wrote:
> XFS doesn't actually need to be holding the XFS_MMAPLOCK_SHARED
> to do this, any more than it needs the XFS_MMAPLOCK_SHARED for a
> read() that hits in the page cache.

Hmm.  From commit cd647d5651c0 ("xfs: use MMAPLOCK around
filemap_map_pages()"):

    The page faultround path ->map_pages is implemented in XFS via
    filemap_map_pages(). This function checks that pages found in page
    cache lookups have not raced with truncate based invalidation by
    checking page->mapping is correct and page->index is within EOF.

    However, we've known for a long time that this is not sufficient to
    protect against races with invalidations done by operations that do
    not change EOF. e.g. hole punching and other fallocate() based
    direct extent manipulations. The way we protect against these
    races is we wrap the page fault operations in a XFS_MMAPLOCK_SHARED
    lock so they serialise against fallocate and truncate before calling
    into the filemap function that processes the fault.

    Do the same for XFS's ->map_pages implementation to close this
    potential data corruption issue.

How do we prevent faultaround from racing with fallocate and reflink
calls that operate below EOF?

--D

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/xfs/xfs_file.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 705250f9f90a..528fc538b6b9 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1388,25 +1388,10 @@ xfs_filemap_pfn_mkwrite(
>  	return __xfs_filemap_fault(vmf, PE_SIZE_PTE, true);
>  }
>  
> -static vm_fault_t
> -xfs_filemap_map_pages(
> -	struct vm_fault		*vmf,
> -	pgoff_t			start_pgoff,
> -	pgoff_t			end_pgoff)
> -{
> -	struct inode		*inode = file_inode(vmf->vma->vm_file);
> -	vm_fault_t ret;
> -
> -	xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
> -	ret = filemap_map_pages(vmf, start_pgoff, end_pgoff);
> -	xfs_iunlock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
> -	return ret;
> -}
> -
>  static const struct vm_operations_struct xfs_file_vm_ops = {
>  	.fault		= xfs_filemap_fault,
>  	.huge_fault	= xfs_filemap_huge_fault,
> -	.map_pages	= xfs_filemap_map_pages,
> +	.map_pages	= filemap_map_pages,
>  	.page_mkwrite	= xfs_filemap_page_mkwrite,
>  	.pfn_mkwrite	= xfs_filemap_pfn_mkwrite,
>  };
> -- 
> 2.35.1
> 
