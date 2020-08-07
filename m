Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C759023EDDC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 15:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgHGNOC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 09:14:02 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:4473 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726392AbgHGNOA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 09:14:00 -0400
X-IronPort-AV: E=Sophos;i="5.75,445,1589212800"; 
   d="scan'208";a="97774911"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 07 Aug 2020 21:13:42 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 807F34CE34DD;
        Fri,  7 Aug 2020 21:13:36 +0800 (CST)
Received: from G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 7 Aug 2020 21:13:38 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Fri, 7 Aug 2020 21:13:36 +0800
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>
CC:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <rgoldwyn@suse.de>,
        <qi.fuli@fujitsu.com>, <y-goto@fujitsu.com>
Subject: [RFC PATCH 0/8] fsdax: introduce FS query interface to support reflink
Date:   Fri, 7 Aug 2020 21:13:28 +0800
Message-ID: <20200807131336.318774-1-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 807F34CE34DD.AD5BB
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset is a try to resolve the problem of tracking shared page
for fsdax.

Instead of per-page tracking method, this patchset introduces a query
interface: get_shared_files(), which is implemented by each FS, to
obtain the owners of a shared page.  It returns an owner list of this
shared page.  Then, the memory-failure() iterates the list to be able
to notify each process using files that sharing this page.

The design of the tracking method is as follow:
1. dax_assocaite_entry() associates the owner's info to this page
- For non-reflink case:
  page->mapping,->index stores the file's mapping, offset in file.
    A dax page is not shared by other files. dax_associate_entry() is
    called only once.  So, use page->mapping,->index to store the
    owner's info.
- For reflink case:
  page->mapping,->index stores the block device, offset in device.
    A dax page is shared more than once.  So, dax_assocaite_entry()
    will be called more than once.  We introduce page->zone_device_data
    as reflink counter, to indicate that this page is shared and how
    many owners now is using this page. The page->mapping,->index is
    used to store the block_device of the fs and page offset of this
    device.

2. dax_lock_page() calls query interface to lock each dax entry
- For non-reflink case:
  owner's info is stored in page->mapping,->index.
    So, It is easy to lock its dax entry.
- For reflink case:
  owner's info is obtained by calling get_shared_files(), which is
  implemented by FS.
    The FS context could be found in block_device that stored by
    page->mapping.  Then lock the dax entries of the owners.

In memory-failure(), since the owner list has been obtained in 
dax_lock_page(), just iterate the list and handle the error.  This
patchset didn't handle the memory failure on metadata of FS because
I haven't found a way to distinguish whether this page contains
matadata yet.  Still working on it.

==
I also borrowed and made some changes on Goldwyn's patchsets.
These patches makes up for the lack of CoW mechanism in fsdax.

The rests are dax & reflink support for xfs.

(Rebased on v5.8)
==
Shiyang Ruan (8):
  fs: introduce get_shared_files() for dax&reflink
  fsdax, mm: track files sharing dax page for memory-failure
  fsdax: introduce dax_copy_edges() for COW
  fsdax: copy data before write
  fsdax: replace mmap entry in case of CoW
  fsdax: dedup file range to use a compare function
  fs/xfs: handle CoW for fsdax write() path
  fs/xfs: support dedupe for fsdax

 fs/btrfs/reflink.c     |   3 +-
 fs/dax.c               | 302 +++++++++++++++++++++++++++++++++++------
 fs/ocfs2/file.c        |   2 +-
 fs/read_write.c        |  11 +-
 fs/xfs/xfs_bmap_util.c |   6 +-
 fs/xfs/xfs_file.c      |  10 +-
 fs/xfs/xfs_iomap.c     |   3 +-
 fs/xfs/xfs_iops.c      |  11 +-
 fs/xfs/xfs_reflink.c   |  80 ++++++-----
 fs/xfs/xfs_super.c     |  67 +++++++++
 include/linux/dax.h    |  18 ++-
 include/linux/fs.h     |  11 +-
 include/linux/mm.h     |   8 ++
 mm/memory-failure.c    | 138 ++++++++++++-------
 14 files changed, 529 insertions(+), 141 deletions(-)

-- 
2.27.0



