Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E489C2C1DD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 07:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgKXGIE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 01:08:04 -0500
Received: from mga14.intel.com ([192.55.52.115]:51611 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728113AbgKXGID (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:08:03 -0500
IronPort-SDR: GOowKN6p1A6bGWcgqUJVOHVIkU9ZREMdq82/iC+8jsAR8tFSLAYdwiJrZNKw0UEh7QDk+zJ/ES
 vhOdjU8Cw2Bg==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="171114706"
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="171114706"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 22:08:03 -0800
IronPort-SDR: GPJEf40arfky0g/F29XxaT9Krhv6lv2p2pNnqLKzAIgj1TpKsaP2EbEkWrdl+6kBQtDS+brxCx
 giwZRSN9BmeA==
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="546707680"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 22:08:02 -0800
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Steve French <sfrench@samba.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Brian King <brking@us.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 00/17] kmap: Create mem*_page interfaces
Date:   Mon, 23 Nov 2020 22:07:38 -0800
Message-Id: <20201124060755.1405602-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The following pattern is used often:

	kmap()
	memcpy(), memmove(), or memset()
	kunmap()

The problem with this is 2 fold: 1) This is best done with k[un]map_atomic().
2) kmap() is expanding and evolving beyond the use of highmem.

To the second point we have new functionality being placed behind kmap, such as
PKS, which has nothing to do with highmem.  Also we have new kmap interfaces,
kmap_local() which allow for a more fined grained mapping of pages and would be
very appropriate for the above pattern.

iov_iter.c already defined 3 functions which do most of what we want.

	memcpy_from_page()
	memcpy_to_page()
	memzero_page()

Lift these to the core and enhance with memcpy_page(), memmove_page(), and
memset_page().  Then replace the patterns throughout the kernel as appropriate.

Once the kmap_local() implementation is finalized the kmap_atomic() can be
replaced with kmap_local().  For the moment use kmap_atomic().


Ira Weiny (17):
  mm/highmem: Lift memcpy_[to|from]_page and memset_page to core
  drivers/firmware_loader: Use new memcpy_[to|from]_page()
  drivers/gpu: Convert to mem*_page()
  fs/afs: Convert to memzero_page()
  fs/btrfs: Convert to memzero_page()
  fs/hfs: Convert to mem*_page() interface
  fs/cifs: Convert to memcpy_page()
  fs/hfsplus: Convert to mem*_page()
  fs/f2fs: Remove f2fs_copy_page()
  fs/freevxfs: Use memcpy_to_page()
  fs/reiserfs: Use memcpy_from_page()
  fs/cramfs: Use memcpy_from_page()
  drivers/target: Convert to mem*_page()
  drivers/scsi: Use memcpy_to_page()
  drivers/staging: Use memcpy_to/from_page()
  lib: Use mempcy_to/from_page()
  samples: Use memcpy_to/from_page()

 drivers/base/firmware_loader/fallback.c   | 11 +++--
 drivers/gpu/drm/gma500/gma_display.c      |  7 ++-
 drivers/gpu/drm/gma500/mmu.c              |  4 +-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c |  6 +--
 drivers/gpu/drm/i915/gt/intel_gtt.c       |  9 +---
 drivers/gpu/drm/i915/gt/shmem_utils.c     |  8 ++--
 drivers/scsi/ipr.c                        | 11 +----
 drivers/staging/rts5208/rtsx_transport.c  |  8 ++--
 drivers/target/target_core_rd.c           |  6 +--
 drivers/target/target_core_transport.c    | 10 ++---
 fs/afs/write.c                            |  5 +--
 fs/btrfs/inode.c                          | 21 +++------
 fs/cifs/smb2ops.c                         | 10 ++---
 fs/cramfs/inode.c                         |  3 +-
 fs/f2fs/f2fs.h                            | 10 -----
 fs/f2fs/file.c                            |  3 +-
 fs/freevxfs/vxfs_immed.c                  |  6 +--
 fs/hfs/bnode.c                            | 13 ++----
 fs/hfsplus/bnode.c                        | 53 +++++++----------------
 fs/reiserfs/journal.c                     |  9 ++--
 include/linux/pagemap.h                   | 49 +++++++++++++++++++++
 lib/iov_iter.c                            | 21 ---------
 lib/test_bpf.c                            | 11 +----
 lib/test_hmm.c                            | 10 +----
 samples/vfio-mdev/mbochs.c                |  8 ++--
 25 files changed, 119 insertions(+), 193 deletions(-)

-- 
2.28.0.rc0.12.gb6a658bd00c9

