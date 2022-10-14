Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57115FF730
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Oct 2022 01:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiJNX5A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 19:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJNX47 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 19:56:59 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEDA8FD47
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 16:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665791818; x=1697327818;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ml8ErNewayS04F/4bGgm1ceLwbVEQIi+J89yFCFoPNQ=;
  b=aqm+G7xV/nga2VAOG4nYNoPyHhI7WjMdfUbr0ngDWo+u6eQCMR5mXs7k
   GdyoK7CKVxAEvyVMc1oGDTawnmxMtqjJ9xnWmlV033adhXUpJ3KKpnWhe
   IwfO5kj5wqjh8QEvp6juS06ZoNKPra7MVwyXATeVwWnfNVWRcbcEdbvf0
   GZArWsiwGyCu1dhAC/ZDlFeDjl978BG/OK5vUVJaGo5ZBZ2mAwugf1FvS
   QRxute4H9HOgXoEonkQre8EqoY6s5W1OXkwQ8P4IjtNwu1YxfVlNSu0YE
   SUXQYuXcAE5n8OTgNqygSACQnHW6/uGiVuTQ+XYoioXhgZdLE6EM1YfXH
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="367522984"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="367522984"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:56:57 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="658759477"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="658759477"
Received: from uyoon-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.90.112])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:56:57 -0700
Subject: [PATCH v3 00/25] Fix the DAX-gup mistake
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-mm@kvack.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>, Jan Kara <jack@suse.cz>,
        Lyude Paul <lyude@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        David Airlie <airlied@linux.ie>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        John Hubbard <jhubbard@nvidia.com>,
        kernel test robot <lkp@intel.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        kernel test robot <lkp@intel.com>,
        Christian =?utf-8?b?S8O2bmln?= <christian.koenig@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>, nvdimm@lists.linux.dev,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org
Date:   Fri, 14 Oct 2022 16:56:56 -0700
Message-ID: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Changes since v2 [1]:
- All of the bandaids in the VFS and filesystems have been dropped. Dave
  made the observation that at iput_final() time the inode is idle so
  a common dax_break_layouts() in the fsdax core is suitable to replace
  new {ext4,xfs}_break_layouts() calls in ->drop_inode(). Additionally,
  the wait for page pins can be handled in the existing
  dax_delete_mapping_entry() called by truncate_inode_pages_final()
  (Dave).

- With the code movement the kbuild robot noticed some long standing
  sparse issues and other fixups.

- Updated the cover letter to try to make the story of how we got here
  easier to follow.

- Rebased on mm-stable, see base-commit. This includes Alistair's recent
  refcount fixups for MEMORY_DEVICE_PRIVATE, and I rework
  zone_device_page_init() into a new pgmap_request_folios() interface.

[1]: http://lore.kernel.org/r/166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com

My expectation is that this goes through -mm since it depends on changes
in mm-stable.

---

ZONE_DEVICE was created to allow for get_user_pages() on DAX mappings.
It has since grown other users, but the main motivation was gup and
synchronizing device shutdown events with pinned pages. Memory
device shutdown triggers driver ->remove(), and ->remove() always
succeeds, so ZONE_DEVICE needed a mechanism to stop new page references
from being taken, and await existing references to drain before allowing
device removal to proceed. This is the origin of 'struct dev_pagemap'
and its percpu_ref.

The original ZONE_DEVICE implementation started by noticing that 'struct
page' initialization, for typical page allocator pages, started pages at
a refcount of 1. Later those pages are 'onlined' by freeing them to the
page allocator via put_page() to drop that initial reference and
populate the free page lists. ZONE_DEVICE abused that "initialized but
never freed" state to both avoid leaking ZONE_DEVICE pages into places
that were not ready for them, and add some metadata to the unused
(because refcount was never 0) page->lru space.

As more users of ZONE_DEVICE arrived that special casing became more and
more unnecessary, and more and more expensive. The 'struct page'
modernization eliminated the need for the ->lru hack. The folio work had
to remember to sprinkle special case ZONE_DEVICE accounting in the right
places. The MEMORY_DEVICE_PRIVATE use case spearheaded much of the work
to support typical reference counting for ZONE_DEVICE pages and allow
them to be used in more kernel code paths. All the while the DAX case
kept its tech debt in place, until now.

However, while fixing the DAX page refcount semantics and arranging for
free_zone_device_page() to be the common end of life of all ZONE_DEVICE
pages, the mitigation for truncate() vs pinned DAX pages was found to be
incomplete. Unlike typical pages that surprisingly can remain pinned for
DMA after they have been truncated from a file, the DAX core must
enforce that nobody has access to a page after truncate() has
disconnected it from inode->i_pages. I.e. the file block that is
identical to the page still remains an extent of the file. The existing
mitigation handled explicit truncate while the inode was alive, but not
the implicit truncate right before the inode is freed.

So, in addition to moving DAX pages to be refcount-0 at idle, and add
'break_layouts' wakeups to free_zone_device_page(), this series also
introduces another occurrence of 'break_layouts' to the inode freeing
path. Recall that 'break_layouts' for DAX is the mechanism to await code
paths that previously arbitrated page access to drop their interest /
page-pins. This new synchronization point is implemented by special
casing dax_delete_mapping_entry(), called by
truncate_inode_pages_final(), to await page pins when mapping_exiting()
is true.

Thanks to Jason for the nudge to get this fixed up properly and the
review on v1, Dave, Jan, and Jason for the discussion on what to do
about the inode end-of-life-truncate problem, and Alistair for cleaning
up the last of the refcount-1 assumptions in the MEMORY_DEVICE_PRIVATE
users.

---

Dan Williams (25):
      fsdax: Wait on @page not @page->_refcount
      fsdax: Use dax_page_idle() to document DAX busy page checking
      fsdax: Include unmapped inodes for page-idle detection
      fsdax: Introduce dax_zap_mappings()
      fsdax: Wait for pinned pages during truncate_inode_pages_final()
      fsdax: Validate DAX layouts broken before truncate
      fsdax: Hold dax lock over mapping insertion
      fsdax: Update dax_insert_entry() calling convention to return an error
      fsdax: Rework for_each_mapped_pfn() to dax_for_each_folio()
      fsdax: Introduce pgmap_request_folios()
      fsdax: Rework dax_insert_entry() calling convention
      fsdax: Cleanup dax_associate_entry()
      devdax: Minor warning fixups
      devdax: Fix sparse lock imbalance warning
      libnvdimm/pmem: Support pmem block devices without dax
      devdax: Move address_space helpers to the DAX core
      devdax: Sparse fixes for xarray locking
      devdax: Sparse fixes for vmfault_t / dax-entry conversions
      devdax: Sparse fixes for vm_fault_t in tracepoints
      devdax: add PUD support to the DAX mapping infrastructure
      devdax: Use dax_insert_entry() + dax_delete_mapping_entry()
      mm/memremap_pages: Replace zone_device_page_init() with pgmap_request_folios()
      mm/memremap_pages: Initialize all ZONE_DEVICE pages to start at refcount 0
      mm/meremap_pages: Delete put_devmap_managed_page_refs()
      mm/gup: Drop DAX pgmap accounting


 .clang-format                            |    1 
 arch/powerpc/kvm/book3s_hv_uvmem.c       |    3 
 drivers/Makefile                         |    2 
 drivers/dax/Kconfig                      |    5 
 drivers/dax/Makefile                     |    1 
 drivers/dax/bus.c                        |    9 
 drivers/dax/dax-private.h                |    2 
 drivers/dax/device.c                     |   73 +-
 drivers/dax/mapping.c                    | 1083 ++++++++++++++++++++++++++++++
 drivers/dax/super.c                      |   10 
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |    3 
 drivers/gpu/drm/nouveau/nouveau_dmem.c   |    3 
 drivers/nvdimm/Kconfig                   |    3 
 drivers/nvdimm/pmem.c                    |   47 +
 fs/dax.c                                 | 1069 ++----------------------------
 fs/ext4/inode.c                          |    9 
 fs/fuse/dax.c                            |    9 
 fs/xfs/xfs_file.c                        |    7 
 fs/xfs/xfs_inode.c                       |    4 
 include/linux/dax.h                      |  149 +++-
 include/linux/huge_mm.h                  |   26 -
 include/linux/memremap.h                 |   22 +
 include/linux/mm.h                       |   30 -
 include/linux/mm_types.h                 |   26 -
 include/trace/events/fs_dax.h            |   16 
 lib/test_hmm.c                           |    3 
 mm/gup.c                                 |   89 +-
 mm/huge_memory.c                         |   48 -
 mm/memremap.c                            |  123 ++-
 mm/page_alloc.c                          |    9 
 mm/swap.c                                |    2 
 31 files changed, 1535 insertions(+), 1351 deletions(-)
 create mode 100644 drivers/dax/mapping.c

base-commit: ef6e06b2ef87077104d1145a0fd452ff8dbbc4b7
