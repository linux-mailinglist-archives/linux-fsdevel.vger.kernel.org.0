Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE692D6362
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 18:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733243AbgLJRV0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 12:21:26 -0500
Received: from mga06.intel.com ([134.134.136.31]:31646 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387487AbgLJRTV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:19:21 -0500
IronPort-SDR: mLRdkECjjCunpUJfr9SWR9Ci0o5stZH3gf0sGgfDU3sNiQL+MeOk5x3lqLCx5vYG2x4IHYFE0k
 g+4DKS9WVjgw==
X-IronPort-AV: E=McAfee;i="6000,8403,9831"; a="235889273"
X-IronPort-AV: E=Sophos;i="5.78,408,1599548400"; 
   d="scan'208";a="235889273"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2020 09:18:37 -0800
IronPort-SDR: ++J+ZzT9cWzZbsmonTh7O3ug91FyfUcZ395M5vZLyclzI81RtVE+M0xrZaDe4hyWG3LP9PpyAH
 XaCxDlqm1DDw==
X-IronPort-AV: E=Sophos;i="5.78,408,1599548400"; 
   d="scan'208";a="484568726"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2020 09:18:37 -0800
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH V3 0/3] Begin converting kmap calls to kmap_local_page()
Date:   Thu, 10 Dec 2020 09:18:32 -0800
Message-Id: <20201210171834.2472353-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Changes from V2[1]:
	Update this cover letter
	Update commit messages
	From Matthew Wilcox
		Put functions in highmem.h rather than pagemap.h
	Investigate 0-day build errors.
		AFAICT the patches were applied to the wrong tree and caused
		build errors.

There are many places in the kernel where kmap is used for a simple memory
operation like memcpy, memset, or memmove and then the page is unmapped.

This kmap/mem*/kunmap pattern is mixed between kmap and kmap_atomic uses.  All
of them could use kmap_atomic() which is faster.  However, kmap_atomic() is
being deprecated in favor of kmap_local_page().

Use kmap_local_page() in the existing page operations.  Lift
memcpy_[to|from]_page to highmem.h.  Remove memzero_page() and use zero_user()
instead.  Add memcpy_page(), memmove_page(), and memset_page() to be used in
future patches.  Finally, add BUG_ON()s to check for any miss use of the API
and prevent data corruption in the same way zero_user() does.

This is V3 to get into 5.11 so that we can start to convert all the various
subsystems in 5.12.[2]

These are based on tip/core/mm.  I'm sending to Andrew and Thomas but I'm
expecting these to go through tip/core/mm via Thomas if that is ok with Andrew.

[1] https://lore.kernel.org/lkml/20201207225703.2033611-1-ira.weiny@intel.com/
[2] https://lore.kernel.org/lkml/20201204160504.GH1563847@iweiny-DESK2.sc.intel.com/


Ira Weiny (2):
  mm/highmem: Remove deprecated kmap_atomic
  mm/highmem: Lift memcpy_[to|from]_page to core

 include/linux/highmem.h | 81 ++++++++++++++++++++++++++++++++++-------
 lib/iov_iter.c          | 26 ++-----------
 2 files changed, 70 insertions(+), 37 deletions(-)

-- 
2.28.0.rc0.12.gb6a658bd00c9

