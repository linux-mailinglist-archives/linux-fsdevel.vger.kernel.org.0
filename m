Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBD6379DFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 05:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhEKD6a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 23:58:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230096AbhEKD60 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 23:58:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A87B66191A;
        Tue, 11 May 2021 03:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620705427;
        bh=KUxSfdHuT0OzxKcmushlCf+iiGLeisPcY+my+vMSNNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XA4NRg2XadNBSNYtby2zm8km5MLfULMiSS8oFp/rowdp1wF4KaICxoyLe0XOXlSLQ
         dAzqy1GaCwX0GXO2mQtRIgCFJbVNLR6YG7Wb51ID2ezfLw9ZU5D+E1UYmzTTiXU8/9
         dK5oIlBZ9wzqFCsp9FvDDLJeD2klTKBCtqOOrg3ekFcl9rpQu95XyoyO3dT6b95LXA
         okn07Xswk7QRewU03CuFaHwqWV02X5zBRnJZi9i78mPhu9whxd2l7o6lOnQvlnRjkr
         Ksj2BOYzGH6Ji74D9XKC0tFZvmKUNgrxzOGqPYF6iadWOteVMQIeGHSerUCYeIeW+D
         GDTXwujDTFTMw==
Date:   Mon, 10 May 2021 20:57:06 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, viro@zeniv.linux.org.uk, david@fromorbit.com,
        hch@lst.de, rgoldwyn@suse.de
Subject: Re: [PATCH v5 0/7] fsdax,xfs: Add reflink&dedupe support for fsdax
Message-ID: <20210511035706.GL8582@magnolia>
References: <20210511030933.3080921-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511030933.3080921-1-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 11, 2021 at 11:09:26AM +0800, Shiyang Ruan wrote:
> This patchset is attempt to add CoW support for fsdax, and take XFS,
> which has both reflink and fsdax feature, as an example.

Slightly off topic, but I noticed all my pmem disappeared once I rolled
forward to 5.13-rc1.  Am I the only lucky one?  Qemu 4.2, with fake
memory devices backed by tmpfs files -- info qtree says they're there,
but the kernel doesn't show anything in /proc/iomem.

--D

> Changes from V4:
>  - Fix the mistake of breaking dax layout for two inodes
>  - Add CONFIG_FS_DAX judgement for fsdax code in remap_range.c
>  - Fix other small problems and mistakes
> 
> Changes from V3:
>  - Take out the first 3 patches as a cleanup patchset[1], which has been
>     sent yesterday.
>  - Fix usage of code in dax_iomap_cow_copy()
>  - Add comments for macro definitions
>  - Fix other code style problems and mistakes
> 
> One of the key mechanism need to be implemented in fsdax is CoW.  Copy
> the data from srcmap before we actually write data to the destance
> iomap.  And we just copy range in which data won't be changed.
> 
> Another mechanism is range comparison.  In page cache case, readpage()
> is used to load data on disk to page cache in order to be able to
> compare data.  In fsdax case, readpage() does not work.  So, we need
> another compare data with direct access support.
> 
> With the two mechanisms implemented in fsdax, we are able to make reflink
> and fsdax work together in XFS.
> 
> Some of the patches are picked up from Goldwyn's patchset.  I made some
> changes to adapt to this patchset.
> 
> 
> (Rebased on v5.13-rc1 and patchset[1])
> [1]: https://lkml.org/lkml/2021/4/22/575
> 
> Shiyang Ruan (7):
>   fsdax: Introduce dax_iomap_cow_copy()
>   fsdax: Replace mmap entry in case of CoW
>   fsdax: Add dax_iomap_cow_copy() for dax_iomap_zero
>   iomap: Introduce iomap_apply2() for operations on two files
>   fsdax: Dedup file range to use a compare function
>   fs/xfs: Handle CoW for fsdax write() path
>   fs/xfs: Add dax dedupe support
> 
>  fs/dax.c               | 206 +++++++++++++++++++++++++++++++++++------
>  fs/iomap/apply.c       |  52 +++++++++++
>  fs/iomap/buffered-io.c |   2 +-
>  fs/remap_range.c       |  57 ++++++++++--
>  fs/xfs/xfs_bmap_util.c |   3 +-
>  fs/xfs/xfs_file.c      |  11 +--
>  fs/xfs/xfs_inode.c     |  66 ++++++++++++-
>  fs/xfs/xfs_inode.h     |   1 +
>  fs/xfs/xfs_iomap.c     |  61 +++++++++++-
>  fs/xfs/xfs_iomap.h     |   4 +
>  fs/xfs/xfs_iops.c      |   7 +-
>  fs/xfs/xfs_reflink.c   |  15 +--
>  include/linux/dax.h    |   7 +-
>  include/linux/fs.h     |  12 ++-
>  include/linux/iomap.h  |   7 +-
>  15 files changed, 449 insertions(+), 62 deletions(-)
> 
> -- 
> 2.31.1
> 
> 
> 
