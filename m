Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365D052281A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 02:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbiEKAD6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 20:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237231AbiEKAD4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 20:03:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7347417D3A0;
        Tue, 10 May 2022 17:03:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 241BEB8200B;
        Wed, 11 May 2022 00:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF03C385CC;
        Wed, 11 May 2022 00:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652227432;
        bh=D/PLmHe0Zv3XheUzevz5zG1/nRmA8yHnhXCml3/8gkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EddLpvy7HeOKm5EzULh0Ier9AwMnU0HS2Bu8QyfZHXoKsRtaMcGBmbglQfQF25liJ
         xlFgK5bzN32RGDZZC3xqvZlSmz3mThbkM2pGSjABwYp2uChHhc4KufDkTu+MUqlgPT
         Vm205PemxYt0euqESK17v4vPq4QooA6dFnk6gwb2WYsonhjbWTXaXbBrg3zMm/4OCQ
         UEXjyrBAVbLJoooI5BaOPX1eFesaZT3jpFyFGqqmMRRIRFLBCiBhx4OHYJ9s/JjPH+
         hW3e5hEmpiRxDnQ/fyoHY1MEfxEK7DddUXSTo6kSnlDtF4SimRk11XqyFpvmp13lp9
         GBXtnwbSkO+Iw==
Date:   Tue, 10 May 2022 17:03:52 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        david@fromorbit.com, hch@infradead.org, jane.chu@oracle.com,
        rgoldwyn@suse.de, viro@zeniv.linux.org.uk, willy@infradead.org,
        naoya.horiguchi@nec.com, linmiaohe@huawei.com
Subject: Re: [PATCHSETS] v14 fsdax-rmap + v11 fsdax-reflink
Message-ID: <20220511000352.GY27195@magnolia>
References: <20220508143620.1775214-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220508143620.1775214-1-ruansy.fnst@fujitsu.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 08, 2022 at 10:36:06PM +0800, Shiyang Ruan wrote:
> This is a combination of two patchsets:
>  1.fsdax-rmap: https://lore.kernel.org/linux-xfs/20220419045045.1664996-1-ruansy.fnst@fujitsu.com/
>  2.fsdax-reflink: https://lore.kernel.org/linux-xfs/20210928062311.4012070-1-ruansy.fnst@fujitsu.com/
> 
>  Changes since v13 of fsdax-rmap:
>   1. Fixed mistakes during rebasing code to latest next-
>   2. Rebased to next-20220504
> 
>  Changes since v10 of fsdax-reflink:
>   1. Rebased to next-20220504 and fsdax-rmap
>   2. Dropped a needless cleanup patch: 'fsdax: Convert dax_iomap_zero to
>       iter model'
>   3. Fixed many conflicts during rebasing
>   4. Fixed a dedupe bug in Patch 05: the actuall length to compare could be
>       shorter than smap->length or dmap->length.
>   PS: There are many changes during rebasing.  I think it's better to
>       review again.
> 
> ==
> Shiyang Ruan (14):
>   fsdax-rmap:
>     dax: Introduce holder for dax_device
>     mm: factor helpers for memory_failure_dev_pagemap
>     pagemap,pmem: Introduce ->memory_failure()
>     fsdax: Introduce dax_lock_mapping_entry()
>     mm: Introduce mf_dax_kill_procs() for fsdax case

Hmm.  This patchset touches at least the dax, pagecache, and xfs
subsystems.  Assuming it's too late for 5.19, how should we stage this
for 5.20?

I could just add the entire series to iomap-5.20-merge and base the
xfs-5.20-merge off of that?  But I'm not sure what else might be landing
in the other subsystems, so I'm open to input.

--D

>     xfs: Implement ->notify_failure() for XFS
>     fsdax: set a CoW flag when associate reflink mappings
>   fsdax-reflink:
>     fsdax: Output address in dax_iomap_pfn() and rename it
>     fsdax: Introduce dax_iomap_cow_copy()
>     fsdax: Replace mmap entry in case of CoW
>     fsdax: Add dax_iomap_cow_copy() for dax zero
>     fsdax: Dedup file range to use a compare function
>     xfs: support CoW in fsdax mode
>     xfs: Add dax dedupe support
> 
>  drivers/dax/super.c         |  67 +++++-
>  drivers/md/dm.c             |   2 +-
>  drivers/nvdimm/pmem.c       |  17 ++
>  fs/dax.c                    | 398 ++++++++++++++++++++++++++++++------
>  fs/erofs/super.c            |  13 +-
>  fs/ext2/super.c             |   7 +-
>  fs/ext4/super.c             |   9 +-
>  fs/remap_range.c            |  31 ++-
>  fs/xfs/Makefile             |   5 +
>  fs/xfs/xfs_buf.c            |  10 +-
>  fs/xfs/xfs_file.c           |   9 +-
>  fs/xfs/xfs_fsops.c          |   3 +
>  fs/xfs/xfs_inode.c          |  69 ++++++-
>  fs/xfs/xfs_inode.h          |   1 +
>  fs/xfs/xfs_iomap.c          |  46 ++++-
>  fs/xfs/xfs_iomap.h          |   3 +
>  fs/xfs/xfs_mount.h          |   1 +
>  fs/xfs/xfs_notify_failure.c | 220 ++++++++++++++++++++
>  fs/xfs/xfs_reflink.c        |  12 +-
>  fs/xfs/xfs_super.h          |   1 +
>  include/linux/dax.h         |  56 ++++-
>  include/linux/fs.h          |  12 +-
>  include/linux/memremap.h    |  12 ++
>  include/linux/mm.h          |   2 +
>  include/linux/page-flags.h  |   6 +
>  mm/memory-failure.c         | 257 ++++++++++++++++-------
>  26 files changed, 1087 insertions(+), 182 deletions(-)
>  create mode 100644 fs/xfs/xfs_notify_failure.c
> 
> -- 
> 2.35.1
> 
> 
> 
