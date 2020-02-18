Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 553B0163377
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 21:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbgBRUt0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 15:49:26 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3361 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgBRUtZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:49:25 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4c4da80000>; Tue, 18 Feb 2020 12:48:40 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Feb 2020 12:49:11 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Feb 2020 12:49:11 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Feb
 2020 20:49:11 +0000
Subject: Re: [PATCH v6 00/19] Change readahead API
To:     Matthew Wilcox <willy@infradead.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-btrfs@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <cluster-devel@redhat.com>, <ocfs2-devel@oss.oracle.com>,
        <linux-xfs@vger.kernel.org>
References: <20200217184613.19668-1-willy@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <80d98657-2f93-da92-a541-707429a6fcdf@nvidia.com>
Date:   Tue, 18 Feb 2020 12:49:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200217184613.19668-1-willy@infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582058920; bh=sSzUuAsXGIrXy4vQ0zTAGyf0jed9sNlmwz2tpEx8I1w=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=OYgEBVV/ua9FohonQVxYl3qPPXVMYQG31aVJZXFPu7SkYOwxhtaZfQM11ZRWuKWRn
         lVI3HR/RIXFrZMOWjvHUihTcKXkE2jgWZqXXGCNxpXb3Nv2SKAT+FXp4fzmW9R+SbR
         +H8xokJDzpZ6UCukKlMzu/5eKP5axPGrm5jxpyyz73wcaxjN5ykeBaYI4TDMwgMSY8
         xsZHrBQYyHRUHdXgYU3ZVNQuJpgqlmVcDrdSv4XqikXa55cxrAOxN2l1s5oRfr4SZG
         EEyk1LdZCMme+4QhBVN+8g/HUCynjQ8e9lz6/YoFujDdaTBOhd1TQ8nXhH+hrOTVqL
         JwGZHfev+XX/A==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/17/20 10:45 AM, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This series adds a readahead address_space operation to eventually
> replace the readpages operation.  The key difference is that
> pages are added to the page cache as they are allocated (and
> then looked up by the filesystem) instead of passing them on a
> list to the readpages operation and having the filesystem add
> them to the page cache.  It's a net reduction in code for each
> implementation, more efficient than walking a list, and solves
> the direct-write vs buffered-read problem reported by yu kuai at
> https://lore.kernel.org/linux-fsdevel/20200116063601.39201-1-yukuai3@huawei.com/
> 
> The only unconverted filesystems are those which use fscache.
> Their conversion is pending Dave Howells' rewrite which will make the
> conversion substantially easier.

Hi Matthew,

I see that Dave Chinner is reviewing this series, but I'm trying out his recent
advice about code reviews [1], and so I'm not going to read his comments first.
So you may see some duplication or contradictions this time around.


[1] Somewhere in this thread, "[LSF/MM/BPF TOPIC] FS Maintainers Don't Scale": 
https://lore.kernel.org/r/20200131052520.GC6869@magnolia


thanks,
-- 
John Hubbard
NVIDIA

> 
> v6:
>  - Name the private members of readahead_control with a leading underscore
>    (suggested by Christoph Hellwig)
>  - Fix whitespace in rst file
>  - Remove misleading comment in btrfs patch
>  - Add readahead_next() API and use it in iomap
>  - Add iomap_readahead kerneldoc.
>  - Fix the mpage_readahead kerneldoc
>  - Make various readahead functions return void
>  - Keep readahead_index() and readahead_offset() pointing to the start of
>    this batch through the body.  No current user requires this, but it's
>    less surprising.
>  - Add kerneldoc for page_cache_readahead_limit
>  - Make page_idx an unsigned long, and rename it to just 'i'
>  - Get rid of page_offset local variable
>  - Add patch to call memalloc_nofs_save() before allocating pages (suggested
>    by Michal Hocko)
>  - Resplit a lot of patches for more logical progression and easier review
>    (suggested by John Hubbard)
>  - Added sign-offs where received, and I deemed still relevant
> 
> v5 switched to passing a readahead_control struct (mirroring the
> writepages_control struct passed to writepages).  This has a number of
> advantages:
>  - It fixes a number of bugs in various implementations, eg forgetting to
>    increment 'start', an off-by-one error in 'nr_pages' or treating 'start'
>    as a byte offset instead of a page offset.
>  - It allows us to change the arguments without changing all the
>    implementations of ->readahead which just call mpage_readahead() or
>    iomap_readahead()
>  - Figuring out which pages haven't been attempted by the implementation
>    is more natural this way.
>  - There's less code in each implementation.
> 
> Matthew Wilcox (Oracle) (19):
>   mm: Return void from various readahead functions
>   mm: Ignore return value of ->readpages
>   mm: Use readahead_control to pass arguments
>   mm: Rearrange readahead loop
>   mm: Remove 'page_offset' from readahead loop
>   mm: rename readahead loop variable to 'i'
>   mm: Put readahead pages in cache earlier
>   mm: Add readahead address space operation
>   mm: Add page_cache_readahead_limit
>   fs: Convert mpage_readpages to mpage_readahead
>   btrfs: Convert from readpages to readahead
>   erofs: Convert uncompressed files from readpages to readahead
>   erofs: Convert compressed files from readpages to readahead
>   ext4: Convert from readpages to readahead
>   f2fs: Convert from readpages to readahead
>   fuse: Convert from readpages to readahead
>   iomap: Restructure iomap_readpages_actor
>   iomap: Convert from readpages to readahead
>   mm: Use memalloc_nofs_save in readahead path
> 
>  Documentation/filesystems/locking.rst |   6 +-
>  Documentation/filesystems/vfs.rst     |  13 ++
>  drivers/staging/exfat/exfat_super.c   |   7 +-
>  fs/block_dev.c                        |   7 +-
>  fs/btrfs/extent_io.c                  |  46 ++-----
>  fs/btrfs/extent_io.h                  |   3 +-
>  fs/btrfs/inode.c                      |  16 +--
>  fs/erofs/data.c                       |  39 ++----
>  fs/erofs/zdata.c                      |  29 ++--
>  fs/ext2/inode.c                       |  10 +-
>  fs/ext4/ext4.h                        |   3 +-
>  fs/ext4/inode.c                       |  23 ++--
>  fs/ext4/readpage.c                    |  22 ++-
>  fs/ext4/verity.c                      |  35 +----
>  fs/f2fs/data.c                        |  50 +++----
>  fs/f2fs/f2fs.h                        |   5 +-
>  fs/f2fs/verity.c                      |  35 +----
>  fs/fat/inode.c                        |   7 +-
>  fs/fuse/file.c                        |  46 +++----
>  fs/gfs2/aops.c                        |  23 ++--
>  fs/hpfs/file.c                        |   7 +-
>  fs/iomap/buffered-io.c                | 118 +++++++----------
>  fs/iomap/trace.h                      |   2 +-
>  fs/isofs/inode.c                      |   7 +-
>  fs/jfs/inode.c                        |   7 +-
>  fs/mpage.c                            |  38 ++----
>  fs/nilfs2/inode.c                     |  15 +--
>  fs/ocfs2/aops.c                       |  34 ++---
>  fs/omfs/file.c                        |   7 +-
>  fs/qnx6/inode.c                       |   7 +-
>  fs/reiserfs/inode.c                   |   8 +-
>  fs/udf/inode.c                        |   7 +-
>  fs/xfs/xfs_aops.c                     |  13 +-
>  fs/zonefs/super.c                     |   7 +-
>  include/linux/fs.h                    |   2 +
>  include/linux/iomap.h                 |   3 +-
>  include/linux/mpage.h                 |   4 +-
>  include/linux/pagemap.h               |  90 +++++++++++++
>  include/trace/events/erofs.h          |   6 +-
>  include/trace/events/f2fs.h           |   6 +-
>  mm/internal.h                         |   8 +-
>  mm/migrate.c                          |   2 +-
>  mm/readahead.c                        | 184 +++++++++++++++++---------
>  43 files changed, 474 insertions(+), 533 deletions(-)
> 
> 
> base-commit: 11a48a5a18c63fd7621bb050228cebf13566e4d8
> 
