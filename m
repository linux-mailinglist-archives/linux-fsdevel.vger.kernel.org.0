Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6264C43814F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Oct 2021 03:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhJWBqt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 21:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhJWBqt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 21:46:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3656C061764;
        Fri, 22 Oct 2021 18:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LXEayIy7A2I2HmjBcTEteE8UWBJjbYkuRFN80Z5gstQ=; b=DgpSdptv1rHV7FelV2b1FOpMJZ
        Fsb+vv/zpiX+nUi8+nu0bQVi10uSxwaxkPIfjs2hwrisz6mcgPwKPfseCavrp8w6cBC5NaFsAwwuT
        hy1p/4AzLZ2ECHANcg3z6BfaCURIdSOmi2IlAMech9uctbYTpW5iTppN5GieiVD1xKHAQzdas3D70
        ShbVQLzD/VE28Eodnim8QhTiHRwvluBjBnbI/QKOa1FcNNmZHLmZlOI9l7spXHLcIbwbfWOWWV7Fv
        pwWnX0Y9eEOuORyJKI6ETqRXpS9ANLTm0IbM7NaxrX2vY5NBdIfUE0UI3PbOXCMD+svReyB/mgcQl
        jYxNv8og==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1me64L-00EJz0-KV; Sat, 23 Oct 2021 01:43:43 +0000
Date:   Sat, 23 Oct 2021 02:43:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [RFC PATCH 0/5] Shared memory for shared extents
Message-ID: <YXNoxZqKPkxZvr3E@casper.infradead.org>
References: <cover.1634933121.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1634933121.git.rgoldwyn@suse.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 22, 2021 at 03:15:00PM -0500, Goldwyn Rodrigues wrote:
> This is an attempt to reduce the memory footprint by using a shared
> page(s) for shared extent(s) in the filesystem. I am hoping to start a
> discussion to iron out the details for implementation.

When you say "Shared extents", you mean reflinks, which are COW, right?
A lot of what you say here confuses me because you talk about dirty
shared pages, and that doesn't make any sense.  A write fault or
call to write() should be intercepted by the filesystem in order to
break the COW.  There's no such thing as a shared page which is dirty,
or has been written back.

You might (or might not!) choose to copy the pages from the shared
extent to the inode when breaking the COW.  But you can't continue
to share them!

> Abstract
> If mutiple files share an extent, reads from each of the files would
> read individual page copies in the inode pagecache mapping, leading to
> waste of memory. Instead add the read pages of the filesystem to
> underlying device's bd_inode as opposed to file's inode mapping. The
> cost is that file offset to device offset conversion happens early in
> the read cycle.
> 
> Motivation:
>  - Reduce memory usage for shared extents
>  - Ease DAX implementation for shared extents
>  - Reduce Container memory utilization
> 
> Implementation
> In the read path, pages are read and added to the block_device's
> inode's mapping as opposed to the inode's mapping. This is limited
> to reads, while write's (and read before writes) still go through
> inode's i_mapping. The path does check the inode's i_mapping before
> falling back to block device's i_mapping to read pages which may be
> dirty. The cost of the operation is file_to_device_offset() translation
> on reads. The translation should return a valid value only in case
> the file is CoW.
> 
> This also means that page->mapping may not point to file's mapping.
> 
> Questions:
> 1. Are there security implications for performing this for read-only
> pages? An alternate idea is to add a "struct fspage", which would be
> pointed by file's mapping and would point to the block device's page.
> Multiple files with shared extents have their own independent fspage
> pointing to the same page mapped to block device's mapping.
> Any security parameters, if required, would be in this structure. The
> advantage of this approach is it would be more flexible with respect to
> CoW when the page is dirtied after reads. With the current approach, a
> read for write is an independent operation so we can end up with two
> copies of the same page. This implementation got complicated too quickly.
> 
> 2. Should pages be dropped after writebacks (and clone_range) to avoid
> duplicate copies?
> 
> Limitations:
> 1. The filesystem have exactly one underlying device.
> 2. Page size should be equal to filesystem block size
> 
> Goldwyn Rodrigues (5):
>   mm: Use file parameter to determine bdi
>   mm: Switch mapping to device mapping
>   btrfs: Add sharedext mount option
>   btrfs: Set s_bdev for btrfs super block
>   btrfs: function to convert file offset to device offset
> 
>  fs/btrfs/ctree.h   |  1 +
>  fs/btrfs/file.c    | 42 ++++++++++++++++++++++++++++++++++++++++--
>  fs/btrfs/super.c   |  7 +++++++
>  include/linux/fs.h |  7 ++++++-
>  mm/filemap.c       | 34 ++++++++++++++++++++++++++--------
>  mm/readahead.c     |  3 +++
>  6 files changed, 83 insertions(+), 11 deletions(-)
> 
> -- 
> 2.33.1
> 
