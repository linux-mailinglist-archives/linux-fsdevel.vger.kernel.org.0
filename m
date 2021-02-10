Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4349D315F57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 07:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhBJGXM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 01:23:12 -0500
Received: from mga02.intel.com ([134.134.136.20]:43004 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231616AbhBJGXL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 01:23:11 -0500
IronPort-SDR: 2O/zm42FHyHShvwtNL+5RuzqpoALc7DIDYA4L/mWwWVPqMwEgxLf56Nd0s1Ow+n0wMZnfwjrau
 BE/eN0T9S+xw==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="169145888"
X-IronPort-AV: E=Sophos;i="5.81,167,1610438400"; 
   d="scan'208";a="169145888"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 22:22:30 -0800
IronPort-SDR: qTruads15mMqccyWZFMchzQ9EXF7cCs+MKFZQ9UwVbOgDN5VjeiNU7QhzM01umcj0XVy/N+kR4
 ENlWYTR8W8TA==
X-IronPort-AV: E=Sophos;i="5.81,167,1610438400"; 
   d="scan'208";a="396582732"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 22:22:29 -0800
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>
Cc:     Ira Weiny <ira.weiny@intel.com>, clm@fb.com, josef@toxicpanda.com,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH V2 0/8] btrfs: convert kmaps to core page calls
Date:   Tue,  9 Feb 2021 22:22:13 -0800
Message-Id: <20210210062221.3023586-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Changes from V1:
	Rework commit messages because they were very weak
	Change 'fs/btrfs: X' to 'btrfs: x'
		https://lore.kernel.org/lkml/20210209151442.GU1993@suse.cz/
	Per Andrew
		Split out changes to highmem.h
			The addition memcpy, memmove, and memset page functions
			The change from kmap_atomic to kmap_local_page
			The addition of BUG_ON
			The conversion of memzero_page to zero_user in iov_iter
		Change BUG_ON to VM_BUG_ON
	While we are refactoring adjust the line length down per Chaitany


There are many places where kmap/<operation>/kunmap patterns occur.  We lift a
couple of these patterns to the core common functions and use them as well as
existing core functions in the btrfs file system.  At the same time we convert
those core functions to use kmap_local_page() which is more efficient in those
calls.

Per the conversation on V1 it looks like Andrew would like this to go through
the btrfs tree.  I think that is fine.  The other users of
memcpy_[to|from]_page are probably not ready and I believe could be taken in an
early rc after David submits.

Is that ok with you David?

Thanks,
Ira

Ira Weiny (8):
  mm/highmem: Lift memcpy_[to|from]_page to core
  mm/highmem: Convert memcpy_[to|from]_page() to kmap_local_page()
  mm/highmem: Introduce memcpy_page(), memmove_page(), and memset_page()
  mm/highmem: Add VM_BUG_ON() to mem*_page() calls
  iov_iter: Remove memzero_page() in favor of zero_user()
  btrfs: use memcpy_[to|from]_page() and kmap_local_page()
  btrfs: use copy_highpage() instead of 2 kmaps()
  btrfs: convert to zero_user()

 fs/btrfs/compression.c  | 11 +++-----
 fs/btrfs/extent_io.c    | 22 +++-------------
 fs/btrfs/inode.c        | 33 ++++++++----------------
 fs/btrfs/lzo.c          |  4 +--
 fs/btrfs/raid56.c       | 10 +-------
 fs/btrfs/reflink.c      | 12 ++-------
 fs/btrfs/send.c         |  7 ++----
 fs/btrfs/zlib.c         | 10 +++-----
 fs/btrfs/zstd.c         | 11 +++-----
 include/linux/highmem.h | 56 +++++++++++++++++++++++++++++++++++++++++
 lib/iov_iter.c          | 26 +++----------------
 11 files changed, 89 insertions(+), 113 deletions(-)

-- 
2.28.0.rc0.12.gb6a658bd00c9

