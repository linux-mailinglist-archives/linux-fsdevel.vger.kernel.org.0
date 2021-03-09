Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D008331F61
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Mar 2021 07:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhCIGjf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 01:39:35 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:45134 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229929AbhCIGjH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 01:39:07 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0UR3PFCN_1615271941;
Received: from 30.225.32.219(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0UR3PFCN_1615271941)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 09 Mar 2021 14:39:01 +0800
Subject: Re: [PATCH v2 00/10] fsdax,xfs: Add reflink&dedupe support for fsdax
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org
Cc:     darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
        linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Message-ID: <5e7766f9-0224-10be-6810-2e516e610191@linux.alibaba.com>
Date:   Tue, 9 Mar 2021 14:36:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

hi,

First thanks for your patchset.
I'd like to know whether your patchset pass fstests? Thanks.

Regards,
Xiaoguang Wang

> This patchset is attempt to add CoW support for fsdax, and take XFS,
> which has both reflink and fsdax feature, as an example.
> 
> Changes from V1:
>   - Factor some helper functions to simplify dax fault code
>   - Introduce iomap_apply2() for dax_dedupe_file_range_compare()
>   - Fix mistakes and other problems
>   - Rebased on v5.11
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
> With the two mechanism implemented in fsdax, we are able to make reflink
> and fsdax work together in XFS.
> 
> 
> Some of the patches are picked up from Goldwyn's patchset.  I made some
> changes to adapt to this patchset.
> 
> (Rebased on v5.11)
> ==
> 
> Shiyang Ruan (10):
>    fsdax: Factor helpers to simplify dax fault code
>    fsdax: Factor helper: dax_fault_actor()
>    fsdax: Output address in dax_iomap_pfn() and rename it
>    fsdax: Introduce dax_iomap_cow_copy()
>    fsdax: Replace mmap entry in case of CoW
>    fsdax: Add dax_iomap_cow_copy() for dax_iomap_zero
>    iomap: Introduce iomap_apply2() for operations on two files
>    fsdax: Dedup file range to use a compare function
>    fs/xfs: Handle CoW for fsdax write() path
>    fs/xfs: Add dedupe support for fsdax
> 
>   fs/dax.c               | 532 +++++++++++++++++++++++++++--------------
>   fs/iomap/apply.c       |  51 ++++
>   fs/iomap/buffered-io.c |   2 +-
>   fs/remap_range.c       |  45 +++-
>   fs/xfs/xfs_bmap_util.c |   3 +-
>   fs/xfs/xfs_file.c      |  29 ++-
>   fs/xfs/xfs_inode.c     |   8 +-
>   fs/xfs/xfs_inode.h     |   1 +
>   fs/xfs/xfs_iomap.c     |  30 ++-
>   fs/xfs/xfs_iomap.h     |   1 +
>   fs/xfs/xfs_iops.c      |  11 +-
>   fs/xfs/xfs_reflink.c   |  16 +-
>   include/linux/dax.h    |   7 +-
>   include/linux/fs.h     |  15 +-
>   include/linux/iomap.h  |   7 +-
>   15 files changed, 550 insertions(+), 208 deletions(-)
> 
