Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FF22651DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 23:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgIJVD6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 17:03:58 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:23587 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731188AbgIJOh5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599748676; x=1631284676;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IxrbI32KPLb5Chwt7ucPItRM+kRMo+8HCLTGl87af+8=;
  b=DwFANoHxjJfTILqRI+gmcRyVWHp9R/GYMPOoViqLtG7uOKTI8dzwAKLg
   zKKVOSRz/xHjb5J+nXeS3mYom0P/bLpYpPAmCH/6b/i0m2W4y42yoD1vl
   SicZwoSS+I8FDPiouHCP8MXJKfYmSrtQqborUi7ITlM+LVJYlQmMAaxsz
   MhA7lTlv1+KDUyyS58kLMgj7g458L/vh3vfRAqivJGlO3RQ9r15IJnFhF
   Fcmu9t8FGDKjSRMRW1ejfTZ3jOPjHbM9s2HsSYnUFYmli0/P+lwg4IXk4
   PafLf67lxB2i2RSoNY3kY9AINGVYS+2q1AENM4beZ/M24vWd4FY8HiVK2
   w==;
IronPort-SDR: Xtxdf+HQAI97oauRdN5xF92gkZr+80wYpR7tD7ZSEaSxuyoGx4PvgJ9PR+IUIzj2gNlWHGuY7u
 yft6CoGIMyvFAthTxDWy4iRMye+Hucop0eDU3rLzhpYYspvgaDDWofiexl2DzwT800sXNq0Obc
 2TD9NfJbrSnLFkIRYL6kgdjJCF/T5HG0Ij0foWHKHIXm1VV7kUAVrh1g5LMEpo7WWlxwyhc4ZS
 DJ2/PWMk+4aLFzhdHydL0uuhI8w/EdAUjay8cPN6VQRZ/g5m+sXS+pxuEI8Tgwb3GpFpaUKTm6
 Cu0=
X-IronPort-AV: E=Sophos;i="5.76,413,1592841600"; 
   d="scan'208";a="148261188"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Sep 2020 22:37:52 +0800
IronPort-SDR: 2EUjN5CzPlQ2SlZsnxKVwlxyOY6I32Co1tYW+bEBqr2Rk26mjCxkbrXcN0pCJyUBaeMvghg2VF
 TINGM6C/1jjg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 07:24:15 -0700
IronPort-SDR: QByy0YNcsjP9VDf1Wh+I8IaauDO1lSE9FYp97NWl5Y5qKc2gBHtN5bP+vHL12y+T3CKH3ydkCS
 RVv8SLq8zRRQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Sep 2020 07:37:51 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 2/4] zonefs: provide zonefs_io_error variant that can be called with i_truncate_mutex held
Date:   Thu, 10 Sep 2020 23:37:42 +0900
Message-Id: <20200910143744.17295-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910143744.17295-1-johannes.thumshirn@wdc.com>
References: <20200910143744.17295-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Subsequent patches need to call zonefs_io_error() with the i_truncate_mutex
already held, so factor out the body of zonefs_io_error() into
__zonefs_io_error() which can be called from with the i_truncate_mutex
held.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/zonefs/super.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 6e13a5127b01..3db28a06e1a2 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -341,14 +341,7 @@ static int zonefs_io_error_cb(struct blk_zone *zone, unsigned int idx,
 	return 0;
 }
 
-/*
- * When an file IO error occurs, check the file zone to see if there is a change
- * in the zone condition (e.g. offline or read-only). For a failed write to a
- * sequential zone, the zone write pointer position must also be checked to
- * eventually correct the file size and zonefs inode write pointer offset
- * (which can be out of sync with the drive due to partial write failures).
- */
-static void zonefs_io_error(struct inode *inode, bool write)
+static void __zonefs_io_error(struct inode *inode, bool write)
 {
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
 	struct super_block *sb = inode->i_sb;
@@ -362,8 +355,6 @@ static void zonefs_io_error(struct inode *inode, bool write)
 	};
 	int ret;
 
-	mutex_lock(&zi->i_truncate_mutex);
-
 	/*
 	 * Memory allocations in blkdev_report_zones() can trigger a memory
 	 * reclaim which may in turn cause a recursion into zonefs as well as
@@ -379,7 +370,21 @@ static void zonefs_io_error(struct inode *inode, bool write)
 		zonefs_err(sb, "Get inode %lu zone information failed %d\n",
 			   inode->i_ino, ret);
 	memalloc_noio_restore(noio_flag);
+}
 
+/*
+ * When an file IO error occurs, check the file zone to see if there is a change
+ * in the zone condition (e.g. offline or read-only). For a failed write to a
+ * sequential zone, the zone write pointer position must also be checked to
+ * eventually correct the file size and zonefs inode write pointer offset
+ * (which can be out of sync with the drive due to partial write failures).
+ */
+static void zonefs_io_error(struct inode *inode, bool write)
+{
+	struct zonefs_inode_info *zi = ZONEFS_I(inode);
+
+	mutex_lock(&zi->i_truncate_mutex);
+	__zonefs_io_error(inode, write);
 	mutex_unlock(&zi->i_truncate_mutex);
 }
 
-- 
2.26.2

