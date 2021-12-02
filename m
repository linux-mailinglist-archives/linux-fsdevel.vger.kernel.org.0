Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD731465BD1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 02:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348672AbhLBBxZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 20:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348448AbhLBBxI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 20:53:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78CEC061574;
        Wed,  1 Dec 2021 17:49:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5BF6FB82192;
        Thu,  2 Dec 2021 01:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13494C00446;
        Thu,  2 Dec 2021 01:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638409783;
        bh=/nOyWz9FD57Yc7ekcAIzmjiWYNDVCKOsggfbBTVN6EA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CUmf+GZlPXI21yYAs0MDsPMgA59CtWzchsX09RJ/ZRMeLy4fTzpKWz6wfMGlvQ3mI
         VSCE+wgYSg1gAX81ligONH8m8F8fGtrzV2dks8+XRF4RPf8CGDz/R51FxNkBaAGCMc
         zv0QZnO64QbzUT1590dNrFZchE1aZ/uhctFu9qDF1MQ0KMDR0nOkn4rxixf6VorqiH
         QhXKocj56WxBPsdZnnthBEHrwpVSQ4IfPAAuNeuNW2IENYWfbmBWDq71BeRcsOovs1
         y5cotxAI7U4wBeHn7hnd41VcnhBwrNShUf3rk++0RYe4JQpd/L+8Trr8bqkc2Bw+PT
         vST6HrzyiMfpg==
Date:   Wed, 1 Dec 2021 17:49:42 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: iomap folio conversion for 5.17
Message-ID: <20211202014942.GB8492@magnolia>
References: <20211124183905.GE266024@magnolia>
 <YZ/7O9Zb3PSsCbk9@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZ/7O9Zb3PSsCbk9@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 25, 2021 at 09:08:11PM +0000, Matthew Wilcox wrote:
> On Wed, Nov 24, 2021 at 10:39:05AM -0800, Darrick J. Wong wrote:
> > Hi folks,
> > 
> > The iomap-for-next branch of the xfs-linux repository at:
> > 
> > 	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
> > 
> > has just been updated.
> 
> Hi Darrick,
> 
> Would you like to pull the folio changes from my git tree?
> They are generally as posted previously, with minor tweaks to match
> upstream changes.  They do not introduce any new xfstests problems
> in my testing.

Since you've rebased against 5.16-rc3, would you mind sending a fresh
pull request (in a new thread), please?  Particularly since the tag
commit id isn't the same anymore...

--D

> The following changes since commit b501b85957deb17f1fe0a861fee820255519d526:
> 
>   Merge tag 'asm-generic-5.16-2' of git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic (2021-11-25 10:41:28 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/users/willy/linux.git tags/iomap-folio-5.17
> 
> for you to fetch changes up to 979fe192e8a935968fd739983217128b431f6268:
> 
>   xfs: Support large folios (2021-11-25 14:03:56 -0500)
> 
> ----------------------------------------------------------------
> Convert fs/iomap to use folios
> 
> These patches prepare XFS to use large folios to cache files.
> There are some preliminary patches to add folio interfaces to the
> block layer & buffer layer, then all the iomap functions are
> converted to use folios instead of pages.
> 
> ----------------------------------------------------------------
> Matthew Wilcox (Oracle) (24):
>       block: Add bio_add_folio()
>       block: Add bio_for_each_folio_all()
>       fs/buffer: Convert __block_write_begin_int() to take a folio
>       iomap: Convert to_iomap_page to take a folio
>       iomap: Convert iomap_page_create to take a folio
>       iomap: Convert iomap_page_release to take a folio
>       iomap: Convert iomap_releasepage to use a folio
>       iomap: Add iomap_invalidate_folio
>       iomap: Pass the iomap_page into iomap_set_range_uptodate
>       iomap: Convert bio completions to use folios
>       iomap: Use folio offsets instead of page offsets
>       iomap: Convert iomap_read_inline_data to take a folio
>       iomap: Convert readahead and readpage to use a folio
>       iomap: Convert iomap_page_mkwrite to use a folio
>       iomap: Convert __iomap_zero_iter to use a folio
>       iomap: Convert iomap_write_begin() and iomap_write_end() to folios
>       iomap: Convert iomap_write_end_inline to take a folio
>       iomap,xfs: Convert ->discard_page to ->discard_folio
>       iomap: Simplify iomap_writepage_map()
>       iomap: Simplify iomap_do_writepage()
>       iomap: Convert iomap_add_to_ioend() to take a folio
>       iomap: Convert iomap_migrate_page() to use folios
>       iomap: Support large folios in invalidatepage
>       xfs: Support large folios
> 
>  Documentation/core-api/kernel-api.rst |   1 +
>  block/bio.c                           |  22 ++
>  fs/buffer.c                           |  23 +-
>  fs/internal.h                         |   2 +-
>  fs/iomap/buffered-io.c                | 506 +++++++++++++++++-----------------
>  fs/xfs/xfs_aops.c                     |  24 +-
>  fs/xfs/xfs_icache.c                   |   2 +
>  include/linux/bio.h                   |  56 +++-
>  include/linux/iomap.h                 |   3 +-
>  9 files changed, 363 insertions(+), 276 deletions(-)
> 
