Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81B4138B1F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 15:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbfFGNLw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 09:11:52 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53172 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729380AbfFGNLw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559913112; x=1591449112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GKTLJDMPSC7oI+dEroHu1zACnrTugLVZNcumBahEBmo=;
  b=B2UKT4d3JsOHykMpUlqg2pHIlVri7GvGwt1Atpk48/GKVGVGckbwm5cy
   O853VRBtoGP0bjLNuWyzOmJxLWsOSeKTu6DgVTghNyOu1IzdFcA+gapKV
   StLb1uhveO0ffEYjz5jQ55/TfcCP3ZAWfAL0abxr//gvVwiQ+M0FwS+xa
   BSaqnOSM2yFiUFuz+JsDKXkxFe8fL7I5869PSzPSSGlvgqwQr3z8IiMWh
   G8foA4vAWf3sXFmqc+pIsjIpr27R3CFrnk/Q2CJHnpq4fZp5mTi7MH8Tb
   x08RsDgBHiq5hBReGlognKx/X0qPgg0SXkWgDI06XpDto2ZIH1VY8hrJK
   A==;
X-IronPort-AV: E=Sophos;i="5.63,563,1557158400"; 
   d="scan'208";a="110027833"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 21:11:51 +0800
IronPort-SDR: jqRFCCLG0nmeDNsMiHbogjZ+eUNuZb7uV/Do2HAEKihQPJb+mMCylE+cDj+nRsu0J2dVSEz0cv
 051RjdOW8mjfQrTwpRGdHOgYJEtZewwubAMr14BMmbCGn0ucDAsvvzmKN+4Yc2GuHx04L5IIPN
 em25PoWUpHuaEYUAeD8buIXav5ATeOIBVt6WttedufqbVB4VX7/c2N8ySXI0pO7fnv+D81TWh/
 UrD/ETD0a5Hdoc03uTjLBHfjaXWlaU+RJdDRsNH4ClagCk4WPRjwZ6q2WDtS8VXB8liPjIDcuB
 5BM+3Kzbe5fIkoOBHqztiQE7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 05:49:08 -0700
IronPort-SDR: N4hXjbYkwpT0Rm7GGc+XOG4jjckvPLd/sRk5mC7ndisiGr/S9C24fE5PFMbLCE8EILow8OVYHb
 cXXOn7E69piuGZ6+76vgHNhaXuLC5rgBvFjisyHJYwy0v4IzdIrxmxd9uN2aTqHMUBiXugb2ky
 hFutFfqr5Hbm4Zkq9QWNrI2yVNIDuXO3+wNhP5e/Gluy0tSE/iIIhB0fSyP4ibphvpTPyhEAof
 SzYH9JqoIUshxY2xeX/Mo4nNk1jpX6YKOcNqlePn4uFUrKr9mHJyDHpj/Hst9lHt2/+icPeprv
 xOs=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 06:11:50 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 17/19] btrfs: shrink delayed allocation size in HMZONED mode
Date:   Fri,  7 Jun 2019 22:10:23 +0900
Message-Id: <20190607131025.31996-18-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607131025.31996-1-naohiro.aota@wdc.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In a write heavy workload, the following scenario can occur:

1. mark page #0 to page #2 (and their corresponding extent region) as dirty
   and candidate for delayed allocation

pages    0 1 2 3 4
dirty    o o o - -
towrite  - - - - -
delayed  o o o - -
alloc

2. extent_write_cache_pages() mark dirty pages as TOWRITE

pages    0 1 2 3 4
dirty    o o o - -
towrite  o o o - -
delayed  o o o - -
alloc

3. Meanwhile, another write dirties page #3 and page #4

pages    0 1 2 3 4
dirty    o o o o o
towrite  o o o - -
delayed  o o o o o
alloc

4. find_lock_delalloc_range() decide to allocate a region to write page #0
   to page #4
5. but, extent_write_cache_pages() only initiate write to TOWRITE tagged
   pages (#0 to #2)

So the above process leaves page #3 and page #4 behind. Usually, the
periodic dirty flush kicks write IOs for page #3 and #4. However, if we try
to mount a subvolume at this timing, mount process takes s_umount write
lock to block the periodic flush to come in.

To deal with the problem, shrink the delayed allocation region to have only
expected to be written pages.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent_io.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c73c69e2bef4..ea582ff85c73 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3310,6 +3310,33 @@ static noinline_for_stack int writepage_delalloc(struct inode *inode,
 			delalloc_start = delalloc_end + 1;
 			continue;
 		}
+
+		if (btrfs_fs_incompat(btrfs_sb(inode->i_sb), HMZONED) &&
+		    (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages) &&
+		    ((delalloc_start >> PAGE_SHIFT) <
+		     (delalloc_end >> PAGE_SHIFT))) {
+			unsigned long i;
+			unsigned long end_index = delalloc_end >> PAGE_SHIFT;
+
+			for (i = delalloc_start >> PAGE_SHIFT;
+			     i <= end_index; i++)
+				if (!xa_get_mark(&inode->i_mapping->i_pages, i,
+						 PAGECACHE_TAG_TOWRITE))
+					break;
+
+			if (i <= end_index) {
+				u64 unlock_start = (u64)i << PAGE_SHIFT;
+
+				if (i == delalloc_start >> PAGE_SHIFT)
+					unlock_start += PAGE_SIZE;
+
+				unlock_extent(tree, unlock_start, delalloc_end);
+				__unlock_for_delalloc(inode, page, unlock_start,
+						      delalloc_end);
+				delalloc_end = unlock_start - 1;
+			}
+		}
+
 		ret = btrfs_run_delalloc_range(inode, page, delalloc_start,
 				delalloc_end, &page_started, nr_written, wbc);
 		/* File system has been set read-only */
-- 
2.21.0

