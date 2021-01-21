Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32ED72FF397
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 19:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbhAUSvz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 13:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbhAUSo3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 13:44:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7F9C06174A
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jan 2021 10:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dXcuDwvoqNoP4NL97KSkxgI2xxt79APfMRyPL3XfbG4=; b=s8qAsrChiHJHM3e3dm+Vil913r
        dsMYbj166wZ3MpqLY+lsTacSlh2CTq9KkKqwFaHcZpC17BHXPuzd62jFoERqLi6ERZkT0xN77hXjK
        3C2UoQG5n/LvSXDuQRPTizobQpPuwbY+hHicZiAZ9nMcpLqRMmFUPe/JBO2P3ixS5RbGroU3k5JU3
        /33PnsOo/KwcCYoP0jDuQJiK53heCH54L+cJZE2pkPGAbgyKKJjUb6dcZJWaLxZhfsGWUmeuXt1lp
        KN6km+XZtR3BeZOxA2ApjF+YIdqnMOnA6Gnr05Au2mmAkwGGo8/zKvo1Qpbq7JRuqYquNWJr3EBYv
        LPrw3nBg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2eve-00HOCt-9F; Thu, 21 Jan 2021 18:43:35 +0000
Date:   Thu, 21 Jan 2021 18:43:34 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: Re: [PATCH v2 0/4] Remove nrexceptional tracking
Message-ID: <20210121184334.GA4127393@casper.infradead.org>
References: <20201026151849.24232-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026151849.24232-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Ping?  These patches still apply to next-20210121.

On Mon, Oct 26, 2020 at 03:18:45PM +0000, Matthew Wilcox (Oracle) wrote:
> We actually use nrexceptional for very little these days.  It's a minor
> pain to keep in sync with nrpages, but the pain becomes much bigger
> with the THP patches because we don't know how many indices a shadow
> entry occupies.  It's easier to just remove it than keep it accurate.
> 
> Also, we save 8 bytes per inode which is nothing to sneeze at; on my
> laptop, it would improve shmem_inode_cache from 22 to 23 objects per
> 16kB, and inode_cache from 26 to 27 objects.  Combined, that saves
> a megabyte of memory from a combined usage of 25MB for both caches.
> Unfortunately, ext4 doesn't cross a magic boundary, so it doesn't save
> any memory for ext4.
> 
> Matthew Wilcox (Oracle) (4):
>   mm: Introduce and use mapping_empty
>   mm: Stop accounting shadow entries
>   dax: Account DAX entries as nrpages
>   mm: Remove nrexceptional from inode
> 
>  fs/block_dev.c          |  2 +-
>  fs/dax.c                |  8 ++++----
>  fs/gfs2/glock.c         |  3 +--
>  fs/inode.c              |  2 +-
>  include/linux/fs.h      |  2 --
>  include/linux/pagemap.h |  5 +++++
>  mm/filemap.c            | 16 ----------------
>  mm/swap_state.c         |  4 ----
>  mm/truncate.c           | 19 +++----------------
>  mm/workingset.c         |  1 -
>  10 files changed, 15 insertions(+), 47 deletions(-)
> 
> -- 
> 2.28.0
> 
