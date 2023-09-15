Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9497A2618
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 20:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbjIOSkZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 14:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236720AbjIOSjz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:39:55 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1EE4203;
        Fri, 15 Sep 2023 11:38:56 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RnNHw3yX1z9sTN;
        Fri, 15 Sep 2023 20:38:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
        s=MBO0001; t=1694803132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RoZvNuZjqAZhkeoljsUMq/UbBCDdPgt5L/Mg1Z9UE+Y=;
        b=PgSAERqfjl+6UWQ3YI233vHH6tt0flmW0hL6wajiTzM6TFAIR6rrmdUbs73UeVJV9c58ke
        5Oj4mA+AtBVC/6cTmhWwO/j/L5JDiKzmUZW8SLb8dhT1dtR7lIDEoBHzJlOxrzpVGx4m5j
        SH8JjhMCy6qJJpz4DiTPhVIlgNTPg/OzTtA5bvxdjDIErfGOFKM6r5fNYrvhHLzwGrMPZa
        ILiAVG/U9uXzxIKdrDaPtFN7Sf1rhWHGy9lcHLTiFQE9NyVDEzcIgT4Xk7IMgqKyi8nLEp
        qQoEL/i06O4JHKyys/CCKte2WvjDZquPiMw/AGk3/DcCYqtDjMsHaYiNoJ2H7Q==
From:   Pankaj Raghav <kernel@pankajraghav.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     p.raghav@samsung.com, david@fromorbit.com, da.gomez@samsung.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, djwong@kernel.org, linux-mm@kvack.org,
        chandan.babu@oracle.com, mcgrof@kernel.org, gost.dev@samsung.com
Subject: [RFC 00/23] Enable block size > page size in XFS
Date:   Fri, 15 Sep 2023 20:38:25 +0200
Message-Id: <20230915183848.1018717-1-kernel@pankajraghav.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4RnNHw3yX1z9sTN
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Pankaj Raghav <p.raghav@samsung.com>

There has been efforts over the last 16 years to enable enable Large
Block Sizes (LBS), that is block sizes in filesystems where bs > page
size [1] [2]. Through these efforts we have learned that one of the
main blockers to supporting bs > ps in fiesystems has been a way to
allocate pages that are at least the filesystem block size on the page
cache where bs > ps [3]. Another blocker was changed in filesystems due to
buffer-heads. Thanks to these previous efforts, the surgery by Matthew
Willcox in the page cache for adopting xarray's multi-index support, and
iomap support, it makes supporting bs > ps in XFS possible with only a few
line change to XFS. Most of changes are to the page cache to support minimum
order folio support for the target block size on the filesystem.

A new motivation for LBS today is to support high-capacity (large amount
of Terabytes) QLC SSDs where the internal Indirection Unit (IU) are
typically greater than 4k [4] to help reduce DRAM and so in turn cost
and space. In practice this then allows different architectures to use a
base page size of 4k while still enabling support for block sizes
aligned to the larger IUs by relying on high order folios on the page
cache when needed. It also enables to take advantage of these same
drive's support for larger atomics than 4k with buffered IO support in
Linux. As described this year at LSFMM, supporting large atomics greater
than 4k enables databases to remove the need to rely on their own
journaling, so they can disable double buffered writes [5], which is a
feature different cloud providers are already innovating and enabling
customers for through custom storage solutions.

This series still needs some polishing and fixing some crashes, but it is
mainly targeted to get initial feedback from the community, enable initial
experimentation, hence the RFC. It's being posted now given the results from
our testing are proving much better results than expected and we hope to
polish this up together with the community. After all, this has been a 16
year old effort and none of this could have been possible without that effort.

Implementation:

This series only adds the notion of a minimum order of a folio in the
page cache that was initially proposed by Willy. The minimum folio order
requirement is set during inode creation. The minimum order will
typically correspond to the filesystem block size. The page cache will
in turn respect the minimum folio order requirement while allocating a
folio. This series mainly changes the page cache's filemap, readahead, and
truncation code to allocate and align the folios to the minimum order set for the
filesystem's inode's respective address space mapping.

Only XFS was enabled and tested as a part of this series as it has
supported block sizes up to 64k and sector sizes up to 32k for years.
The only thing missing was the page cache magic to enable bs > ps. However any filesystem
that doesn't depend on buffer-heads and support larger block sizes
already should be able to leverage this effort to also support LBS,
bs > ps.

This also paves the way for supporting block devices where their logical
block size > page size in the future by leveraging iomap's address space
operation added to the block device cache by Christoph Hellwig [6]. We
have work to enable support for this, enabling LBAs > 4k on NVME,  and
at the same time allow coexistence with buffer-heads on the same block
device so to enable support allow for a drive to use filesystem's to
switch between filesystem's which may depend on buffer-heads or need the
iomap address space operations for the block device cache. Patches for
this will be posted shortly after this patch series.

Testing:

The test results show, this isn't so scary. Only a few regressions so
far on xfs where CRCs are disabled on block sizes smaller than 4k and
some generic tests crashing the system for bs > 4k. The crashes are at most a
handful at this point. This series has been cleaned up 3 times now after
we passed our first billion through fsx ops on different block sizes. Not
surprisingly there are a few test bugs for the bs > ps world.

We've established baseline first against linux-next against 14 different
XFS test profiles as maintained in kdevops [7]:

xfs_crc
xfs_reflink
xfs_reflink_normapbt
xfs_reflink_1024
xfs_reflink_2k
xfs_reflink_4k
xfs_nocrc
xfs_nocrc_512
xfs_nocrc_1k
xfs_nocrc_2k
xfs_nocrc_4k
xfs_logdev
xfs_rtdev
xfs_rtlogdev

We first established a high confidence baseline for linux-next and have
kept following that to ensure we don't regress it. The majority of
regressions are fsx ops on no CRC block sizes of 512 and 2k, and we plan
to fix that, but welcome others at this point to jump in and collaborate.

The list of known possible regressions are then can be seen on kdevops
with git grep:

git grep regression workflows/fstests/expunges/6.6.0-rc1-large-block-20230914/ | awk -F"unassigned/" '{print $2}'
xfs_nocrc_2k.txt:generic/075 # possible regression
xfs_nocrc_2k.txt:generic/112 # possible regression
xfs_nocrc_2k.txt:generic/127 # possible regression
xfs_nocrc_2k.txt:generic/231 # possible regression
xfs_nocrc_2k.txt:generic/263 # possible regression
xfs_nocrc_2k.txt:generic/469 # possible regression
xfs_nocrc_512.txt:generic/075 # possible regression
xfs_nocrc_512.txt:generic/112 # possible regression
xfs_nocrc_512.txt:generic/127 # possible regression
xfs_nocrc_512.txt:generic/231 # possible regression
xfs_nocrc_512.txt:generic/263 # possible regression
xfs_nocrc_512.txt:generic/469 # possible regression
xfs_reflink_1024.txt:generic/457 # possible regression crash https://gist.github.com/mcgrof/f182b250a9d091f77dc85782a83224b3
xfs_rtdev.txt:generic/333 # might crash might be a regression, takes forever...

Billion of fsx ops are possible with 16k and so far successful also with
hundreds of millions of fsx ops against 32k and 64k with 4k sector size.

To verify larger IOs are used we have been using Daniel Gomez's lbs-ctl
tool which uses eBPF to verify different IO counts on the block layer.
That tool will soon be published.

For more details please refer to the kernel newbies page on LBS [8].

[1] https://lwn.net/Articles/231793/
[2] https://lwn.net/ml/linux-fsdevel/20181107063127.3902-1-david@fromorbit.com/
[3] https://lore.kernel.org/linux-mm/20230308075952.GU2825702@dread.disaster.area/
[4] https://cdrdv2-public.intel.com/605724/Achieving_Optimal_Perf_IU_SSDs-338395-003US.pdf
[5] https://lwn.net/Articles/932900/
[6] https://lore.kernel.org/lkml/20230801172201.1923299-2-hch@lst.de/T/
[7] https://github.com/linux-kdevops/kdevops/blob/master/playbooks/roles/fstests/templates/xfs/xfs.config
[8] https://kernelnewbies.org/KernelProjects/large-block-size

--
Regards,
Pankaj
Luis

Dave Chinner (1):
  xfs: expose block size in stat

Luis Chamberlain (12):
  filemap: set the order of the index in page_cache_delete_batch()
  filemap: align index to mapping_min_order in filemap_range_has_page()
  mm: call xas_set_order() in replace_page_cache_folio()
  filemap: align the index to mapping_min_order in __filemap_add_folio()
  filemap: align the index to mapping_min_order in
    filemap_get_folios_tag()
  filemap: align the index to mapping_min_order in filemap_get_pages()
  readahead: set file_ra_state->ra_pages to be at least
    mapping_min_order
  readahead: add folio with at least mapping_min_order in
    page_cache_ra_order
  readahead: set the minimum ra size in get_(init|next)_ra
  readahead: align ra start and size to mapping_min_order in
    ondemand_ra()
  truncate: align index to mapping_min_order
  mm: round down folio split requirements

Matthew Wilcox (Oracle) (1):
  fs: Allow fine-grained control of folio sizes

Pankaj Raghav (9):
  pagemap: use mapping_min_order in fgf_set_order()
  filemap: add folio with at least mapping_min_order in
    __filemap_get_folio
  filemap: use mapping_min_order while allocating folios
  filemap: align the index to mapping_min_order in
    do_[a]sync_mmap_readahead
  filemap: align index to mapping_min_order in filemap_fault()
  readahead: allocate folios with mapping_min_order in ra_unbounded()
  readahead: align with mapping_min_order in force_page_cache_ra()
  xfs: enable block size larger than page size support
  xfs: set minimum order folio for page cache based on blocksize

 fs/iomap/buffered-io.c  |  2 +-
 fs/xfs/xfs_icache.c     |  8 +++-
 fs/xfs/xfs_iops.c       |  4 +-
 fs/xfs/xfs_mount.c      |  9 ++++-
 fs/xfs/xfs_super.c      |  7 +---
 include/linux/pagemap.h | 87 ++++++++++++++++++++++++++++++-----------
 mm/filemap.c            | 87 +++++++++++++++++++++++++++++++++--------
 mm/huge_memory.c        | 14 +++++--
 mm/readahead.c          | 86 ++++++++++++++++++++++++++++++++++------
 mm/truncate.c           | 34 +++++++++++-----
 10 files changed, 263 insertions(+), 75 deletions(-)


base-commit: e143016b56ecb0fcda5bb6026b0a25fe55274f56
-- 
2.40.1

