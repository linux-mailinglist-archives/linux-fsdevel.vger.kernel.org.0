Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2DD629365
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 09:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbiKOIlq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 03:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiKOIlo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 03:41:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C755582;
        Tue, 15 Nov 2022 00:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ragGr8bI09kd4Xs0ZvoiBDX9nwTCjc2Hw6wTuuGKA20=; b=TPd1O1H7nZ/7RTEXOZEv2oGBRL
        Qh+CJpDd/wzK01CHJF3uRd8skvyH8eS4RVhTMHJ9Vw7BslUTnDg31z/dKT6THrC8Kc1S+rnao/feM
        PgWhkWIkg3HSIR7ikXpj5t0sh1wu821pOUJxMmXt/KbbM1ARcvGn4/ajtkUoLdEprhUSS0Udhv3Z8
        M1T40Rlq/6bpMRnrqKqEHYYtYOte0vj8CctzT/g08TRGkTpSuaFNfkPRnoEh+7SIE5D5eTI9/bzeW
        o6I6nTAfMHQrWBIYl51LzsTws0wC1yjhIQ9FazjuME+27ws3DLjBk4ah6PuWertxNOvtI/CVM+CPq
        Uz4bUDXw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ourVm-008zfG-1O; Tue, 15 Nov 2022 08:41:42 +0000
Date:   Tue, 15 Nov 2022 00:41:42 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 3/9] xfs: punching delalloc extents on write failure is
 racy
Message-ID: <Y3NQxoD20SvgInok@infradead.org>
References: <20221115013043.360610-1-david@fromorbit.com>
 <20221115013043.360610-4-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115013043.360610-4-david@fromorbit.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 15, 2022 at 12:30:37PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> xfs_buffered_write_iomap_end() has a comment about the safety of
> punching delalloc extents based holding the IOLOCK_EXCL. This
> comment is wrong, and punching delalloc extents is not race free.
> 
> When we punch out a delalloc extent after a write failure in
> xfs_buffered_write_iomap_end(), we punch out the page cache with
> truncate_pagecache_range() before we punch out the delalloc extents.
> At this point, we only hold the IOLOCK_EXCL, so there is nothing
> stopping mmap() write faults racing with this cleanup operation,
> reinstantiating a folio over the range we are about to punch and
> hence requiring the delalloc extent to be kept.
> 
> If this race condition is hit, we can end up with a dirty page in
> the page cache that has no delalloc extent or space reservation
> backing it. This leads to bad things happening at writeback time.
> 
> To avoid this race condition, we need the page cache truncation to
> be atomic w.r.t. the extent manipulation. We can do this by holding
> the mapping->invalidate_lock exclusively across this operation -
> this will prevent new pages from being inserted into the page cache
> whilst we are removing the pages and the backing extent and space
> reservation.
> 
> Taking the mapping->invalidate_lock exclusively in the buffered
> write IO path is safe - it naturally nests inside the IOLOCK (see
> truncate and fallocate paths). iomap_zero_range() can be called from
> under the mapping->invalidate_lock (from the truncate path via
> either xfs_zero_eof() or xfs_truncate_page(), but iomap_zero_iter()
> will not instantiate new delalloc pages (because it skips holes) and
> hence will not ever need to punch out delalloc extents on failure.
> 
> Fix the locking issue, and clean up the code logic a little to avoid
> unnecessary work if we didn't allocate the delalloc extent or wrote
> the entire region we allocated.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

> +	filemap_invalidate_lock(inode->i_mapping);
> +	truncate_pagecache_range(VFS_I(ip), XFS_FSB_TO_B(mp, start_fsb),
> +				 XFS_FSB_TO_B(mp, end_fsb) - 1);

No need to use VFS_I here, the inode is passed as a funtion argument.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
