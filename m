Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286845AC1FC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Sep 2022 04:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiIDCQE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Sep 2022 22:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIDCQC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Sep 2022 22:16:02 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1424037F8B
        for <linux-fsdevel@vger.kernel.org>; Sat,  3 Sep 2022 19:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662257761; x=1693793761;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fnBW3tH05kzrxa7RlM0wu6waCCayGzZFmKPuKurUqcI=;
  b=nVaxccmUSptS/IviQrA8G2Xt+A9EgYBL5YMHmtPs957rs2lIg4fFqVZI
   JgQ/P4hQVb9J7jfMXMjOxS/EL7V1zfQOZgemiAOEhD5ef0D+fnoh9qzSY
   lQd2ypmfPLiKnBdBkqUOVPhGfudzXyft62CurWmo/VmHBeN/5Kcc379Ef
   AKN6Qu8xLlv75MgSFjmRaO3E4If6RrxmVDmqCGcDiP7Pg+GWVzbWcGqpU
   KqhykxZ/3Ks7bAVGfR7Qo1gTBKYxT4pFMHfLGiMi9B++n0SiBdwjki7cx
   mA8N/drGACBQJIHBVxnyjWTQazqpFmJSOQIhHCHNxGHI2nvn/QAqBzefj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="360158653"
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="360158653"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 19:16:00 -0700
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="643384361"
Received: from pg4-mobl3.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.132.198])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 19:16:00 -0700
Subject: [PATCH 00/13] Fix the DAX-gup mistake
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org
Date:   Sat, 03 Sep 2022 19:16:00 -0700
Message-ID: <166225775968.2351842.11156458342486082012.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

tl;dr: Move the pin of 'struct dev_pagemap' instances from gup-time to
map time, move the unpin of 'struct dev_pagemap' to truncate_inode_pages()
for fsdax and devdax inodes, and use page_maybe_dma_pinned() to
determine when filesystems can safely truncate DAX mappings vs DMA.

The longer story is that DAX has caused friction with folio development
and other device-memory use cases due to its hack of using a
page-reference count of 1 to indicate that the page is DMA idle. That
situation arose from the mistake of not managing DAX page reference
counts at map time. The lack of page reference counting at map time grew
organically from the original DAX experiment of attempting to manage DAX
mappings without page structures. The page lock, dirty tracking and
other entry management was supported sans pages. However, the page
support was then bolted on incrementally so solve problems with gup,
memory-failure, and all the other kernel services that are missing when
a pfn does not have an associated page structure.

Since then John has led an effort to account for when a page is pinned
for DMA vs other sources that elevate the reference count. The
page_maybe_dma_pinned() helper slots in seamlessly to replace the need
to track transitions to page->_refount == 1.

The larger change in this set comes from Jason's observation that
inserting DAX mappings without any reference taken is a bug. So
dax_insert_entry(), that fsdax uses, is updated to take 'struct
dev_pagemap' references, and devdax is updated to reuse the same.

This allows for 'struct dev_pagemap' manipulation to be self-contained
to DAX-specific paths. It is also a foundation to build towards removing
pte_devmap() and start treating DAX pages as another vm_normal_page(),
and perhaps more conversions of the DAX infrastructure to reuse typical
page mapping helpers. One of the immediate hurdles is the usage of
pmd_devmap() to distinguish large page mappings that are not transparent
huge pages.

---

Dan Williams (13):
      fsdax: Rename "busy page" to "pinned page"
      fsdax: Use page_maybe_dma_pinned() for DAX vs DMA collisions
      fsdax: Delete put_devmap_managed_page_refs()
      fsdax: Update dax_insert_entry() calling convention to return an error
      fsdax: Cleanup dax_associate_entry()
      fsdax: Rework dax_insert_entry() calling convention
      fsdax: Manage pgmap references at entry insertion and deletion
      devdax: Minor warning fixups
      devdax: Move address_space helpers to the DAX core
      dax: Prep dax_{associate,disassociate}_entry() for compound pages
      devdax: add PUD support to the DAX mapping infrastructure
      devdax: Use dax_insert_entry() + dax_delete_mapping_entry()
      mm/gup: Drop DAX pgmap accounting


 .clang-format             |    1
 drivers/Makefile          |    2
 drivers/dax/Kconfig       |    6
 drivers/dax/Makefile      |    1
 drivers/dax/bus.c         |    2
 drivers/dax/dax-private.h |    1
 drivers/dax/device.c      |   73 ++-
 drivers/dax/mapping.c     | 1020 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/dax/super.c       |    2
 fs/dax.c                  | 1049 ++-------------------------------------------
 fs/ext4/inode.c           |    9
 fs/fuse/dax.c             |   10
 fs/xfs/xfs_file.c         |    8
 fs/xfs/xfs_inode.c        |    2
 include/linux/dax.h       |  124 ++++-
 include/linux/huge_mm.h   |   23 -
 include/linux/memremap.h  |   24 +
 include/linux/mm.h        |   58 +-
 mm/gup.c                  |   92 +---
 mm/huge_memory.c          |   54 --
 mm/memremap.c             |   31 -
 mm/swap.c                 |    2
 22 files changed, 1326 insertions(+), 1268 deletions(-)
 create mode 100644 drivers/dax/mapping.c

base-commit: 1c23f9e627a7b412978b4e852793c5e3c3efc555
