Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2160F306D80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 07:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbhA1GPy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 01:15:54 -0500
Received: from mga04.intel.com ([192.55.52.120]:24335 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229892AbhA1GPw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 01:15:52 -0500
IronPort-SDR: MkrC852xUQ/X6/8ewZYky7nLyK2UEbApcwSRv/AZ/9WDQE/xTYgE/senzNs4WTYLrzGe5W81Bs
 s2uruIdydXYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="177622374"
X-IronPort-AV: E=Sophos;i="5.79,381,1602572400"; 
   d="scan'208";a="177622374"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:15:10 -0800
IronPort-SDR: BmzLm6FN4u7yhGcv3/T9vs/EQWMOgBfjr/kDyT1ZdHVp6bFV+Z9pVr8mP97QPxQlvWYGBOWm1E
 zkpyqIkM49qg==
X-IronPort-AV: E=Sophos;i="5.79,381,1602572400"; 
   d="scan'208";a="410791453"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:15:10 -0800
From:   ira.weiny@intel.com
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     Ira Weiny <ira.weiny@intel.com>, Miao Xie <miaox@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/btrfs: Fix raid6 qstripe kmap'ing
Date:   Wed, 27 Jan 2021 22:15:03 -0800
Message-Id: <20210128061503.1496847-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

When a qstripe is required an extra page is allocated and mapped.  There
were 3 problems.

1) There is no reason to map the qstripe page more than 1 time if the
   number of bits set in rbio->dbitmap is greater than one.
2) There is no reason to map the parity page and unmap it each time
   through the loop.
3) There is no corresponding call of kunmap() for the qstripe page.

The page memory can continue to be reused with a single mapping on each
iteration by raid6_call.gen_syndrome() without remapping.  So map the
page for the duration of the loop.

Similarly, improve the algorithm by mapping the parity page just 1 time.

Fixes: 5a6ac9eacb49 ("Btrfs, raid56: support parity scrub on raid56")
To: Chris Mason <clm@fb.com>
To: Josef Bacik <josef@toxicpanda.com>
To: David Sterba <dsterba@suse.com>
Cc: Miao Xie <miaox@cn.fujitsu.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
This was found while replacing kmap() with kmap_local_page().  After
this patch unwinding all the mappings becomes pretty straight forward.

I'm not exactly sure I've worded this commit message intelligently.
Please forgive me if there is a better way to word it.
---
 fs/btrfs/raid56.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 93fbf87bdc8d..b8a39dad0f00 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2363,16 +2363,21 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 	SetPageUptodate(p_page);
 
 	if (has_qstripe) {
+		/* raid6, allocate and map temp space for the qstripe */
 		q_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
 		if (!q_page) {
 			__free_page(p_page);
 			goto cleanup;
 		}
 		SetPageUptodate(q_page);
+		pointers[rbio->real_stripes] = kmap(q_page);
 	}
 
 	atomic_set(&rbio->error, 0);
 
+	/* map the parity stripe just once */
+	pointers[nr_data] = kmap(p_page);
+
 	for_each_set_bit(pagenr, rbio->dbitmap, rbio->stripe_npages) {
 		struct page *p;
 		void *parity;
@@ -2382,16 +2387,8 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 			pointers[stripe] = kmap(p);
 		}
 
-		/* then add the parity stripe */
-		pointers[stripe++] = kmap(p_page);
-
 		if (has_qstripe) {
-			/*
-			 * raid6, add the qstripe and call the
-			 * library function to fill in our p/q
-			 */
-			pointers[stripe++] = kmap(q_page);
-
+			/* raid6, call the library function to fill in our p/q */
 			raid6_call.gen_syndrome(rbio->real_stripes, PAGE_SIZE,
 						pointers);
 		} else {
@@ -2412,12 +2409,14 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 
 		for (stripe = 0; stripe < nr_data; stripe++)
 			kunmap(page_in_rbio(rbio, stripe, pagenr, 0));
-		kunmap(p_page);
 	}
 
+	kunmap(p_page);
 	__free_page(p_page);
-	if (q_page)
+	if (q_page) {
+		kunmap(q_page);
 		__free_page(q_page);
+	}
 
 writeback:
 	/*
-- 
2.28.0.rc0.12.gb6a658bd00c9

