Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8AB311850
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Feb 2021 03:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhBFCeg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 21:34:36 -0500
Received: from mga02.intel.com ([134.134.136.20]:40718 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230160AbhBFCce (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:32:34 -0500
IronPort-SDR: R01nlnaJBPlKoGPc2e5NqDWlQwTim5bkGVnlgiNVe1laLH6uLs9jCME+FJMfblfk4knNlNhEkD
 Yo7XyjnQU/GQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="168620876"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="168620876"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:23:12 -0800
IronPort-SDR: izc2cofWfmiqkAEt3A/XO9/CVuDMcXHCFsgUTOwRMAm2onIliEq6JamDMjLLtLMyfqb3ztEJzN
 UEx+pCZkgvxg==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="394051913"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:23:12 -0800
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/4] fs/btrfs: Use copy_highpage() instead of 2 kmaps()
Date:   Fri,  5 Feb 2021 15:23:03 -0800
Message-Id: <20210205232304.1670522-4-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210205232304.1670522-1-ira.weiny@intel.com>
References: <20210205232304.1670522-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

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

