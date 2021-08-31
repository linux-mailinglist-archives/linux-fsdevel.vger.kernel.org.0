Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4923FCFBB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 01:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238727AbhHaXBL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Aug 2021 19:01:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230291AbhHaXBK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Aug 2021 19:01:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5FDD61008;
        Tue, 31 Aug 2021 22:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630450814;
        bh=Cx3MuIuVBVJhXs6mGbeECmG65uZjw5Ixf+O9JVrX9dI=;
        h=Date:From:To:Cc:Subject:From;
        b=sqk+nbqHS3gxA0/TSb7B1Jfp17xpdHcS1wO03uuNh3EQaFitNV6Aj1umrpYFE6aqm
         TCeGqT2PVacZTZkZ/Y0f3GpG02+jH1ZwjlapCY7dpBHvXMC9L6vUAuXNyL3+u4U6p4
         Tf7wU1m7KTTZikMxDYXWGLogEh46f+zpnhGRADgJnj2OR1P72tEPfSe6yB0L6ODjwz
         8FuvbU3+0M9iz3+zwBA3iTQbtISiJp+1lLQ+AHa5AtKy7PnWVU4utloL31f+Wok7gm
         X6XawyxMGvYtMzGGlZLfObE2wgOjK3kWgoBiCcs6TQfXpxNBFQ2CPdrikoi3PiQW8e
         zUKm1NLKAVKFA==
Date:   Wed, 1 Sep 2021 06:59:42 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        Dan Williams <dan.j.williams@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Huang Jianan <huangjianan@oppo.com>,
        Yue Hu <huyue2@yulong.com>, Miao Xie <miaoxie@huawei.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>
Subject: [GIT PULL] erofs updates for 5.15-rc1
Message-ID: <20210831225935.GA26537@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        Dan Williams <dan.j.williams@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Huang Jianan <huangjianan@oppo.com>, Yue Hu <huyue2@yulong.com>,
        Miao Xie <miaoxie@huawei.com>, Liu Bo <bo.liu@linux.alibaba.com>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus.

Could you consider this pull request for 5.15-rc1?

In this cycle, direct I/O and fsdax support for uncompressed files
are now added in order to avoid double-caching for loop device and
VM container use cases. All uncompressed cases are now turned into
iomap infrastructure, which looks much simpler and cleaner.

Besides, fiemap support is added for both (un)compressed files by
using iomap infrastructure as well so end users can easily get file
distribution. We've also added chunk-based uncompressed files support
for data deduplication as the next step of VM container use cases.

All commits have been tested and have been in linux-next. Note that
in order to support iomap tail-packing inline, I had to merge iomap
core branch (I've created a merge commit with the reason) in advance
to resolve such functional dependency, which is now merged into
upstream. Hopefully I did the right thing...

Also, there is a merge conflict detected by Stephen with new fsdax
cleanups in the nvdimm tree, which can be resolved as below if needed:
https://lore.kernel.org/r/20210830170938.6fd8813d@canb.auug.org.au

Thanks,
Gao Xiang

The following changes since commit c500bee1c5b2f1d59b1081ac879d73268ab0ff17:

  Linux 5.14-rc4 (2021-08-01 17:04:17 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.15-rc1

for you to fetch changes up to 1266b4a7ecb679587dc4d098abe56ea53313d569:

  erofs: fix double free of 'copied' (2021-08-25 22:05:58 +0800)

----------------------------------------------------------------
Changes since last update:

 - support direct I/O for all uncompressed files;

 - support fsdax for non-tailpacking regular files;

 - use iomap infrastructure for all uncompressed cases;

 - support fiemap for both (un)compressed files;

 - introduce chunk-based files for chunk deduplication.

 - some cleanups.

----------------------------------------------------------------
Andreas Gruenbacher (1):
      iomap: Fix some typos and bad grammar

Christoph Hellwig (2):
      iomap: simplify iomap_readpage_actor
      iomap: simplify iomap_add_to_ioend

Gao Xiang (9):
      iomap: support reading inline data from non-zero pos
      erofs: dax support for non-tailpacking regular file
      Merge tag 'iomap-5.15-merge-2' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
      erofs: convert all uncompressed cases to iomap
      erofs: add support for the full decompressed length
      erofs: add fiemap support with iomap
      erofs: introduce chunk-based file on-disk format
      erofs: support reading chunk-based uncompressed files
      erofs: fix double free of 'copied'

Huang Jianan (1):
      erofs: iomap support for non-tailpacking DIO

Matthew Wilcox (Oracle) (3):
      iomap: Support inline data with block size < page size
      iomap: Use kmap_local_page instead of kmap_atomic
      iomap: Add another assertion to inline data handling

Yue Hu (2):
      erofs: directly use wrapper erofs_page_is_managed() when shrinking
      erofs: remove the mapping parameter from erofs_try_to_free_cached_page()

 Documentation/filesystems/erofs.rst |  19 +-
 fs/erofs/Kconfig                    |   1 +
 fs/erofs/data.c                     | 415 +++++++++++++++++++-----------------
 fs/erofs/erofs_fs.h                 |  47 +++-
 fs/erofs/inode.c                    |  29 ++-
 fs/erofs/internal.h                 |  22 +-
 fs/erofs/namei.c                    |   1 +
 fs/erofs/super.c                    |  61 +++++-
 fs/erofs/zdata.c                    |   6 +-
 fs/erofs/zmap.c                     | 133 +++++++++++-
 fs/iomap/buffered-io.c              | 169 +++++++--------
 fs/iomap/direct-io.c                |  10 +-
 include/linux/iomap.h               |  18 ++
 13 files changed, 627 insertions(+), 304 deletions(-)
