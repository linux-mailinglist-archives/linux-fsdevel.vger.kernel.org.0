Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167EF31D403
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 03:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhBQCtE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 21:49:04 -0500
Received: from mga07.intel.com ([134.134.136.100]:54788 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230179AbhBQCs7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 21:48:59 -0500
IronPort-SDR: 2HwvXUiw6bUxADjh5df9SbnDg8ABUoRBtxusfxQ0+5JdynWq4banHe75ZUEnJ3F52zcewkTNmy
 HCmHJ5a2F1jQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="247152591"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="247152591"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 18:48:34 -0800
IronPort-SDR: Tnx5xrXWshHSWJknOSUxl9Qhfpemy0aj1HGa17C/CLVTz+Jpy9EMK5FRvttZREnbGRQMP4W5aS
 pYy3vzDre9iQ==
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="384922159"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 18:48:34 -0800
From:   ira.weiny@intel.com
To:     David Sterba <dsterba@suse.cz>
Cc:     Ira Weiny <ira.weiny@intel.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/4] fs/btrfs: Convert kmap to kmap_local_page() using coccinelle
Date:   Tue, 16 Feb 2021 18:48:23 -0800
Message-Id: <20210217024826.3466046-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210217024826.3466046-1-ira.weiny@intel.com>
References: <20210217024826.3466046-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Use a simple coccinelle script to help convert the most common
kmap()/kunmap() patterns to kmap_local_page()/kunmap_local().

Note that some kmaps which were caught by this script needed to be
handled by hand because of the strict unmapping order of kunmap_local()
so they are not included in this patch.  But this script got us started.

The development of this patch was aided by the follow script:

// <smpl>
// SPDX-License-Identifier: GPL-2.0-only
// Find kmap and replace with kmap_local_page then mark kunmap
//
// Confidence: Low
// Copyright: (C) 2021 Intel Corporation
// URL: http://coccinelle.lip6.fr/

@ catch_all @
expression e, e2;
@@

(
-kmap(e)
+kmap_local_page(e)
)
...
(
-kunmap(...)
+kunmap_local()
)

// </smpl>

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/btrfs/compression.c | 4 ++--
 fs/btrfs/inode.c       | 4 ++--
 fs/btrfs/lzo.c         | 9 ++++-----
 fs/btrfs/raid56.c      | 4 ++--
 4 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index a219dcdb749e..21833a2fe8c6 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -1578,7 +1578,7 @@ static void heuristic_collect_sample(struct inode *inode, u64 start, u64 end,
 	curr_sample_pos = 0;
 	while (index < index_end) {
 		page = find_get_page(inode->i_mapping, index);
-		in_data = kmap(page);
+		in_data = kmap_local_page(page);
 		/* Handle case where the start is not aligned to PAGE_SIZE */
 		i = start % PAGE_SIZE;
 		while (i < PAGE_SIZE - SAMPLING_READ_SIZE) {
@@ -1591,7 +1591,7 @@ static void heuristic_collect_sample(struct inode *inode, u64 start, u64 end,
 			start += SAMPLING_INTERVAL;
 			curr_sample_pos += SAMPLING_READ_SIZE;
 		}
-		kunmap(page);
+		kunmap_local(in_data);
 		put_page(page);
 
 		index++;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 641f21a11722..66c6f1185de2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6845,7 +6845,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 				if (ret)
 					goto out;
 			} else {
-				map = kmap(page);
+				map = kmap_local_page(page);
 				read_extent_buffer(leaf, map + pg_offset, ptr,
 						   copy_size);
 				if (pg_offset + copy_size < PAGE_SIZE) {
@@ -6853,7 +6853,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 					       PAGE_SIZE - pg_offset -
 					       copy_size);
 				}
-				kunmap(page);
+				kunmap_local(map);
 			}
 			flush_dcache_page(page);
 		}
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 9084a950dc09..cd042c7567a4 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -118,7 +118,7 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	int ret = 0;
 	char *data_in;
-	char *cpage_out;
+	char *cpage_out, *sizes_ptr;
 	int nr_pages = 0;
 	struct page *in_page = NULL;
 	struct page *out_page = NULL;
@@ -258,10 +258,9 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
 	}
 
 	/* store the size of all chunks of compressed data */
-	cpage_out = kmap(pages[0]);
-	write_compress_length(cpage_out, tot_out);
-
-	kunmap(pages[0]);
+	sizes_ptr = kmap_local_page(pages[0]);
+	write_compress_length(sizes_ptr, tot_out);
+	kunmap_local(sizes_ptr);
 
 	ret = 0;
 	*total_out = tot_out;
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 7c3f6dc918c1..9759fb31b73e 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2391,13 +2391,13 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 
 		/* Check scrubbing parity and repair it */
 		p = rbio_stripe_page(rbio, rbio->scrubp, pagenr);
-		parity = kmap(p);
+		parity = kmap_local_page(p);
 		if (memcmp(parity, pointers[rbio->scrubp], PAGE_SIZE))
 			copy_page(parity, pointers[rbio->scrubp]);
 		else
 			/* Parity is right, needn't writeback */
 			bitmap_clear(rbio->dbitmap, pagenr, 1);
-		kunmap(p);
+		kunmap_local(parity);
 
 		for (stripe = 0; stripe < nr_data; stripe++)
 			kunmap(page_in_rbio(rbio, stripe, pagenr, 0));
-- 
2.28.0.rc0.12.gb6a658bd00c9

