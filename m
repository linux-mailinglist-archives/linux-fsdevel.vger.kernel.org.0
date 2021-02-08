Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED89C313849
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 16:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbhBHPlo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 10:41:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:43186 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233887AbhBHPjy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:39:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 03D05ADDD;
        Mon,  8 Feb 2021 15:39:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AD8FD1E13F9; Mon,  8 Feb 2021 16:39:11 +0100 (CET)
Date:   Mon, 8 Feb 2021 16:39:11 +0100
From:   Jan Kara <jack@suse.cz>
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
        linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
Subject: Re: [PATCH 0/7] fsdax,xfs: Add reflink&dedupe support for fsdax
Message-ID: <20210208153911.GE30081@quack2.suse.cz>
References: <20210207170924.2933035-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210207170924.2933035-1-ruansy.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 08-02-21 01:09:17, Shiyang Ruan wrote:
> This patchset is attempt to add CoW support for fsdax, and take XFS,
> which has both reflink and fsdax feature, as an example.
> 
> One of the key mechanism need to be implemented in fsdax is CoW.  Copy
> the data from srcmap before we actually write data to the destance
> iomap.  And we just copy range in which data won't be changed.
> 
> Another mechanism is range comparison .  In page cache case, readpage()
> is used to load data on disk to page cache in order to be able to
> compare data.  In fsdax case, readpage() does not work.  So, we need
> another compare data with direct access support.
> 
> With the two mechanism implemented in fsdax, we are able to make reflink
> and fsdax work together in XFS.
> 
> Some of the patches are picked up from Goldwyn's patchset.  I made some
> changes to adapt to this patchset.

How do you deal with HWPoison code trying to reverse-map struct page back
to inode-offset pair? This also needs to be fixed for reflink to work with
DAX.

								Honza

> 
> (Rebased on v5.10)
> ==
> 
> Shiyang Ruan (7):
>   fsdax: Output address in dax_iomap_pfn() and rename it
>   fsdax: Introduce dax_copy_edges() for CoW
>   fsdax: Copy data before write
>   fsdax: Replace mmap entry in case of CoW
>   fsdax: Dedup file range to use a compare function
>   fs/xfs: Handle CoW for fsdax write() path
>   fs/xfs: Add dedupe support for fsdax
> 
>  fs/btrfs/reflink.c     |   3 +-
>  fs/dax.c               | 188 ++++++++++++++++++++++++++++++++++++++---
>  fs/ocfs2/file.c        |   2 +-
>  fs/remap_range.c       |  14 +--
>  fs/xfs/xfs_bmap_util.c |   6 +-
>  fs/xfs/xfs_file.c      |  30 ++++++-
>  fs/xfs/xfs_inode.c     |   8 +-
>  fs/xfs/xfs_inode.h     |   1 +
>  fs/xfs/xfs_iomap.c     |   3 +-
>  fs/xfs/xfs_iops.c      |  11 ++-
>  fs/xfs/xfs_reflink.c   |  23 ++++-
>  include/linux/dax.h    |   5 ++
>  include/linux/fs.h     |   9 +-
>  13 files changed, 270 insertions(+), 33 deletions(-)
> 
> -- 
> 2.30.0
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
