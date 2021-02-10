Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59577315F65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 07:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhBJGYM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 01:24:12 -0500
Received: from mga03.intel.com ([134.134.136.65]:39559 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231621AbhBJGXq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 01:23:46 -0500
IronPort-SDR: EfUsD2mweXMBX5ZU6ZdGdg/cmhuAHvGfpXg1IQVPm/fZlQbK7CGdqXxPccxWhhBghE9om2+vQu
 3wwHuV2ljDYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="182086732"
X-IronPort-AV: E=Sophos;i="5.81,167,1610438400"; 
   d="scan'208";a="182086732"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 22:22:38 -0800
IronPort-SDR: HvyGlHM1zqqfKNKBQT0UxACkarW6tPnvLOUy2OyS/Z3h19sBMixGqzl2XSFXeA46J8r9MS6BsS
 2jzW/Hblx7ZA==
X-IronPort-AV: E=Sophos;i="5.81,167,1610438400"; 
   d="scan'208";a="587246178"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 22:22:37 -0800
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>
Cc:     Ira Weiny <ira.weiny@intel.com>, clm@fb.com, josef@toxicpanda.com,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH V2 7/8] btrfs: use copy_highpage() instead of 2 kmaps()
Date:   Tue,  9 Feb 2021 22:22:20 -0800
Message-Id: <20210210062221.3023586-8-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210210062221.3023586-1-ira.weiny@intel.com>
References: <20210210062221.3023586-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

There are many places where kmap/memove/kunmap patterns occur.

This pattern exists in the core common function copy_highpage().

Use copy_highpage to avoid open coding the use of kmap and leverages the
core functions use of kmap_local_page().

Development of this patch was aided by the following coccinelle script:

// <smpl>
// SPDX-License-Identifier: GPL-2.0-only
// Find kmap/copypage/kunmap pattern and replace with copy_highpage calls
//
// NOTE: The expressions in the copy page version of this kmap pattern are
// overly complex and so these all need individual attention.
//
// Confidence: Low
// Copyright: (C) 2021 Intel Corporation
// URL: http://coccinelle.lip6.fr/
// Comments:
// Options:

//
// Then a copy_page where we have 2 pages involved.
//
@ copy_page_rule @
expression page, page2, To, From, Size;
identifier ptr, ptr2;
type VP, VP2;
@@

/* kmap */
(
-VP ptr = kmap(page);
...
-VP2 ptr2 = kmap(page2);
|
-VP ptr = kmap_atomic(page);
...
-VP2 ptr2 = kmap_atomic(page2);
|
-ptr = kmap(page);
...
-ptr2 = kmap(page2);
|
-ptr = kmap_atomic(page);
...
-ptr2 = kmap_atomic(page2);
)

// 1 or more copy versions of the entire page
<+...
(
-copy_page(To, From);
+copy_highpage(To, From);
|
-memmove(To, From, Size);
+memmoveExtra(To, From, Size);
)
...+>

/* kunmap */
(
-kunmap(page2);
...
-kunmap(page);
|
-kunmap(page);
...
-kunmap(page2);
|
-kmap_atomic(ptr2);
...
-kmap_atomic(ptr);
)

// Remove any pointers left unused
@
depends on copy_page_rule
@
identifier copy_page_rule.ptr;
identifier copy_page_rule.ptr2;
type VP, VP1;
type VP2, VP21;
@@

-VP ptr;
	... when != ptr;
? VP1 ptr;
-VP2 ptr2;
	... when != ptr2;
? VP21 ptr2;

// </smpl>

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from v1:
	Update commit message per David
		https://lore.kernel.org/lkml/20210209151442.GU1993@suse.cz/
---
 fs/btrfs/raid56.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index dbf52f1a379d..7c3f6dc918c1 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -250,8 +250,6 @@ int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info)
 static void cache_rbio_pages(struct btrfs_raid_bio *rbio)
 {
 	int i;
-	char *s;
-	char *d;
 	int ret;
 
 	ret = alloc_rbio_pages(rbio);
@@ -262,13 +260,7 @@ static void cache_rbio_pages(struct btrfs_raid_bio *rbio)
 		if (!rbio->bio_pages[i])
 			continue;
 
-		s = kmap(rbio->bio_pages[i]);
-		d = kmap(rbio->stripe_pages[i]);
-
-		copy_page(d, s);
-
-		kunmap(rbio->bio_pages[i]);
-		kunmap(rbio->stripe_pages[i]);
+		copy_highpage(rbio->stripe_pages[i], rbio->bio_pages[i]);
 		SetPageUptodate(rbio->stripe_pages[i]);
 	}
 	set_bit(RBIO_CACHE_READY_BIT, &rbio->flags);
-- 
2.28.0.rc0.12.gb6a658bd00c9

