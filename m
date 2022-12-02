Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80DF63FC6E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 01:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiLBAFP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 19:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiLBAFO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 19:05:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CAABFCE0;
        Thu,  1 Dec 2022 16:05:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBECCB82059;
        Fri,  2 Dec 2022 00:05:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F792C433D6;
        Fri,  2 Dec 2022 00:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669939510;
        bh=c+iAZh65tKEp0i1bpbgnXu4ijblLpd36N+S65zLMVJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ApbQWgm3zmiXoDBkYjYpFoW9skHXwiyIWGCChZFbFtYfyL/YbgcMAzunHiGm9p2Sc
         WXQjFS1l+AExzW6SmzLiVNqIgeLFsTZahlObbCldXwZSb+Ur+NYkSMk4JM0QhX8WQW
         I5/20cyOXzOq5j9+6Lg69WpogPFn/mhmHAhmaNepIfFauk4JIs81TbLEnUzFqm4seG
         8yf3qc9PJVyUNKJCTKqmnxN5ezo02ragmaaZIv3ZiblYyRYuSuJpw9Rd6d7YcQ86Ak
         wsRalmm5RmGZeAKPqb49OvtiZgUodB6EK0diNga6mQ2+bDpv0AlxDvXrI4nVqS0s17
         SOmhJWR6UG+Ag==
Date:   Thu, 1 Dec 2022 16:05:09 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, dan.j.williams@intel.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH v2 4/8] fsdax,xfs: set the shared flag when file extent
 is shared
Message-ID: <Y4lBNf7kPwWlT4Tv@magnolia>
References: <1669908538-55-1-git-send-email-ruansy.fnst@fujitsu.com>
 <1669908538-55-5-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669908538-55-5-git-send-email-ruansy.fnst@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 01, 2022 at 03:28:54PM +0000, Shiyang Ruan wrote:
> If a dax page is shared, mapread at different offsets can also trigger
> page fault on same dax page.  So, change the flag from "cow" to
> "shared".  And get the shared flag from filesystem when read.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

Makes sense.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/dax.c           | 19 +++++++------------
>  fs/xfs/xfs_iomap.c |  2 +-
>  2 files changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 6b6e07ad8d80..f1eb59bee0b5 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -846,12 +846,6 @@ static bool dax_fault_is_synchronous(const struct iomap_iter *iter,
>  		(iter->iomap.flags & IOMAP_F_DIRTY);
>  }
>  
> -static bool dax_fault_is_cow(const struct iomap_iter *iter)
> -{
> -	return (iter->flags & IOMAP_WRITE) &&
> -		(iter->iomap.flags & IOMAP_F_SHARED);
> -}
> -
>  /*
>   * By this point grab_mapping_entry() has ensured that we have a locked entry
>   * of the appropriate size so we don't have to worry about downgrading PMDs to
> @@ -865,13 +859,14 @@ static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
>  {
>  	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
>  	void *new_entry = dax_make_entry(pfn, flags);
> -	bool dirty = !dax_fault_is_synchronous(iter, vmf->vma);
> -	bool cow = dax_fault_is_cow(iter);
> +	bool write = iter->flags & IOMAP_WRITE;
> +	bool dirty = write && !dax_fault_is_synchronous(iter, vmf->vma);
> +	bool shared = iter->iomap.flags & IOMAP_F_SHARED;
>  
>  	if (dirty)
>  		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
>  
> -	if (cow || (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE))) {
> +	if (shared || (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE))) {
>  		unsigned long index = xas->xa_index;
>  		/* we are replacing a zero page with block mapping */
>  		if (dax_is_pmd_entry(entry))
> @@ -883,12 +878,12 @@ static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
>  
>  	xas_reset(xas);
>  	xas_lock_irq(xas);
> -	if (cow || dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
> +	if (shared || dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
>  		void *old;
>  
>  		dax_disassociate_entry(entry, mapping, false);
>  		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address,
> -				cow);
> +				shared);
>  		/*
>  		 * Only swap our new entry into the page cache if the current
>  		 * entry is a zero page or an empty entry.  If a normal PTE or
> @@ -908,7 +903,7 @@ static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
>  	if (dirty)
>  		xas_set_mark(xas, PAGECACHE_TAG_DIRTY);
>  
> -	if (cow)
> +	if (write && shared)
>  		xas_set_mark(xas, PAGECACHE_TAG_TOWRITE);
>  
>  	xas_unlock_irq(xas);
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 07da03976ec1..881de99766ca 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1215,7 +1215,7 @@ xfs_read_iomap_begin(
>  		return error;
>  	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb, &imap,
>  			       &nimaps, 0);
> -	if (!error && (flags & IOMAP_REPORT))
> +	if (!error && ((flags & IOMAP_REPORT) || IS_DAX(inode)))
>  		error = xfs_reflink_trim_around_shared(ip, &imap, &shared);
>  	xfs_iunlock(ip, lockmode);
>  
> -- 
> 2.38.1
> 
