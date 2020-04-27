Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06531B9AC0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 10:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgD0Isl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 04:48:41 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:3131 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726700AbgD0Isj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:48:39 -0400
X-IronPort-AV: E=Sophos;i="5.73,323,1583164800"; 
   d="scan'208";a="90547651"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Apr 2020 16:48:31 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id B686750A9991;
        Mon, 27 Apr 2020 16:37:48 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 27 Apr 2020 16:48:31 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Mon, 27 Apr 2020 16:48:30 +0800
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>
CC:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <rgoldwyn@suse.de>,
        <qi.fuli@fujitsu.com>, <y-goto@fujitsu.com>
Subject: [RFC PATCH 0/8] dax: Add a dax-rmap tree to support reflink
Date:   Mon, 27 Apr 2020 16:47:42 +0800
Message-ID: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: B686750A9991.AE152
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset is a try to resolve the shared 'page cache' problem for
fsdax.

In order to track multiple mappings and indexes on one page, I
introduced a dax-rmap rb-tree to manage the relationship.  A dax entry
will be associated more than once if is shared.  At the second time we
associate this entry, we create this rb-tree and store its root in
page->private(not used in fsdax).  Insert (->mapping, ->index) when
dax_associate_entry() and delete it when dax_disassociate_entry().

We can iterate the dax-rmap rb-tree before any other operations on
mappings of files.  Such as memory-failure and rmap.

Same as before, I borrowed and made some changes on Goldwyn's patchsets.
These patches makes up for the lack of CoW mechanism in fsdax.

The rests are dax & reflink support for xfs.

(Rebased to 5.7-rc2)


Shiyang Ruan (8):
  fs/dax: Introduce dax-rmap btree for reflink
  mm: add dax-rmap for memory-failure and rmap
  fs/dax: Introduce dax_copy_edges() for COW
  fs/dax: copy data before write
  fs/dax: replace mmap entry in case of CoW
  fs/dax: dedup file range to use a compare function
  fs/xfs: handle CoW for fsdax write() path
  fs/xfs: support dedupe for fsdax

 fs/dax.c               | 343 +++++++++++++++++++++++++++++++++++++----
 fs/ocfs2/file.c        |   2 +-
 fs/read_write.c        |  11 +-
 fs/xfs/xfs_bmap_util.c |   6 +-
 fs/xfs/xfs_file.c      |  10 +-
 fs/xfs/xfs_iomap.c     |   3 +-
 fs/xfs/xfs_iops.c      |  11 +-
 fs/xfs/xfs_reflink.c   |  79 ++++++----
 include/linux/dax.h    |  11 ++
 include/linux/fs.h     |   9 +-
 mm/memory-failure.c    |  63 ++++++--
 mm/rmap.c              |  54 +++++--
 12 files changed, 498 insertions(+), 104 deletions(-)

-- 
2.26.2



