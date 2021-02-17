Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF5031D406
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 03:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhBQCtS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 21:49:18 -0500
Received: from mga07.intel.com ([134.134.136.100]:54811 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230071AbhBQCtQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 21:49:16 -0500
IronPort-SDR: 4QmAf6uelNyeR9ee1nO6CuFkDr+FvXPhyU49N7toE9fTl9gaktL77acl5HF1Lcyo3+iXkleGz0
 lPKNRlTc9oxw==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="247152592"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="247152592"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 18:48:35 -0800
IronPort-SDR: wRHJaJyU1fkz8igK7t+37rtg+DEijII+g+OA8fXQprZevZDzVmF7rgwuw48tQSY3QvqezKqWrR
 7hsEAWZENEmg==
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="384922221"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 18:48:35 -0800
From:   ira.weiny@intel.com
To:     David Sterba <dsterba@suse.cz>
Cc:     Ira Weiny <ira.weiny@intel.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/4] fs/btrfs: Convert raid5/6 kmaps to kmap_local_page()
Date:   Tue, 16 Feb 2021 18:48:24 -0800
Message-Id: <20210217024826.3466046-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210217024826.3466046-1-ira.weiny@intel.com>
References: <20210217024826.3466046-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

These kmaps are thread local and don't need to be atomic.  So they can use
the more efficient kmap_local_page().  However, the mapping of pages in
the stripes and the additional parity and qstripe pages are a bit
trickier because the unmapping must occur in the opposite order from the
mapping.  Furthermore, the pointer array in __raid_recover_end_io() may
get reordered.

Convert these calls to kmap_local_page() taking care to reverse the
unmappings of any page arrays as well as being careful with the mappings
of any special pages such as the parity and qstripe pages.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
This patch depends on the fix to raid5/6 kmapping sent previously

https://lore.kernel.org/lkml/20210205163943.GD5033@iweiny-DESK2.sc.intel.com/#t
---
 fs/btrfs/raid56.c | 57 +++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 9759fb31b73e..04abae305582 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1233,13 +1233,13 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 		/* first collect one page from each data stripe */
 		for (stripe = 0; stripe < nr_data; stripe++) {
 			p = page_in_rbio(rbio, stripe, pagenr, 0);
-			pointers[stripe] = kmap(p);
+			pointers[stripe] = kmap_local_page(p);
 		}
 
 		/* then add the parity stripe */
 		p = rbio_pstripe_page(rbio, pagenr);
 		SetPageUptodate(p);
-		pointers[stripe++] = kmap(p);
+		pointers[stripe++] = kmap_local_page(p);
 
 		if (has_qstripe) {
 
@@ -1249,7 +1249,7 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 			 */
 			p = rbio_qstripe_page(rbio, pagenr);
 			SetPageUptodate(p);
-			pointers[stripe++] = kmap(p);
+			pointers[stripe++] = kmap_local_page(p);
 
 			raid6_call.gen_syndrome(rbio->real_stripes, PAGE_SIZE,
 						pointers);
@@ -1258,10 +1258,8 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 			copy_page(pointers[nr_data], pointers[0]);
 			run_xor(pointers + 1, nr_data - 1, PAGE_SIZE);
 		}
-
-
-		for (stripe = 0; stripe < rbio->real_stripes; stripe++)
-			kunmap(page_in_rbio(rbio, stripe, pagenr, 0));
+		for (stripe = stripe - 1; stripe >= 0; stripe--)
+			kunmap_local(pointers[stripe]);
 	}
 
 	/*
@@ -1780,6 +1778,7 @@ static void __raid_recover_end_io(struct btrfs_raid_bio *rbio)
 {
 	int pagenr, stripe;
 	void **pointers;
+	void **unmap_array;
 	int faila = -1, failb = -1;
 	struct page *page;
 	blk_status_t err;
@@ -1791,6 +1790,12 @@ static void __raid_recover_end_io(struct btrfs_raid_bio *rbio)
 		goto cleanup_io;
 	}
 
+	unmap_array = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
+	if (!unmap_array) {
+		err = BLK_STS_RESOURCE;
+		goto cleanup_pointers;
+	}
+
 	faila = rbio->faila;
 	failb = rbio->failb;
 
@@ -1814,6 +1819,9 @@ static void __raid_recover_end_io(struct btrfs_raid_bio *rbio)
 
 		/* setup our array of pointers with pages
 		 * from each stripe
+		 *
+		 * NOTE Store a duplicate array of pointers to preserve the
+		 * pointer order.
 		 */
 		for (stripe = 0; stripe < rbio->real_stripes; stripe++) {
 			/*
@@ -1827,7 +1835,8 @@ static void __raid_recover_end_io(struct btrfs_raid_bio *rbio)
 			} else {
 				page = rbio_stripe_page(rbio, stripe, pagenr);
 			}
-			pointers[stripe] = kmap(page);
+			pointers[stripe] = kmap_local_page(page);
+			unmap_array[stripe] = pointers[stripe];
 		}
 
 		/* all raid6 handling here */
@@ -1920,24 +1929,14 @@ static void __raid_recover_end_io(struct btrfs_raid_bio *rbio)
 				}
 			}
 		}
-		for (stripe = 0; stripe < rbio->real_stripes; stripe++) {
-			/*
-			 * if we're rebuilding a read, we have to use
-			 * pages from the bio list
-			 */
-			if ((rbio->operation == BTRFS_RBIO_READ_REBUILD ||
-			     rbio->operation == BTRFS_RBIO_REBUILD_MISSING) &&
-			    (stripe == faila || stripe == failb)) {
-				page = page_in_rbio(rbio, stripe, pagenr, 0);
-			} else {
-				page = rbio_stripe_page(rbio, stripe, pagenr);
-			}
-			kunmap(page);
-		}
+		for (stripe = rbio->real_stripes - 1; stripe >= 0; stripe--)
+			kunmap_local(unmap_array[stripe]);
 	}
 
 	err = BLK_STS_OK;
 cleanup:
+	kfree(unmap_array);
+cleanup_pointers:
 	kfree(pointers);
 
 cleanup_io:
@@ -2362,13 +2361,13 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 			goto cleanup;
 		}
 		SetPageUptodate(q_page);
-		pointers[rbio->real_stripes - 1] = kmap(q_page);
+		pointers[rbio->real_stripes - 1] = kmap_local_page(q_page);
 	}
 
 	atomic_set(&rbio->error, 0);
 
 	/* map the parity stripe just once */
-	pointers[nr_data] = kmap(p_page);
+	pointers[nr_data] = kmap_local_page(p_page);
 
 	for_each_set_bit(pagenr, rbio->dbitmap, rbio->stripe_npages) {
 		struct page *p;
@@ -2376,7 +2375,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 		/* first collect one page from each data stripe */
 		for (stripe = 0; stripe < nr_data; stripe++) {
 			p = page_in_rbio(rbio, stripe, pagenr, 0);
-			pointers[stripe] = kmap(p);
+			pointers[stripe] = kmap_local_page(p);
 		}
 
 		if (has_qstripe) {
@@ -2399,14 +2398,14 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 			bitmap_clear(rbio->dbitmap, pagenr, 1);
 		kunmap_local(parity);
 
-		for (stripe = 0; stripe < nr_data; stripe++)
-			kunmap(page_in_rbio(rbio, stripe, pagenr, 0));
+		for (stripe = nr_data - 1; stripe >= 0; stripe--)
+			kunmap_local(pointers[stripe]);
 	}
 
-	kunmap(p_page);
+	kunmap_local(pointers[nr_data]);
 	__free_page(p_page);
 	if (q_page) {
-		kunmap(q_page);
+		kunmap_local(pointers[rbio->real_stripes - 1]);
 		__free_page(q_page);
 	}
 
-- 
2.28.0.rc0.12.gb6a658bd00c9

