Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DFF265C0F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 10:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbgIKI5U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 04:57:20 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:58876 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgIKI5A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 04:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599814620; x=1631350620;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bEWC6HFgbb+Y6fu3xjZjsnc7uaaqXo/mLp9u93jWXhU=;
  b=f6YU5jnhA87qLzj/IX/Kt+rwIav+/619rs1Hkztfw/CeDjnSjWUjFu2t
   K4hjD47o7NZHmoCaVFmPR+UrnodRzb6EBpRyzuKsOu5I1rdQj05FRSuAo
   T13NeGkNHM9KpFq6hmKRgVoc8R+nUEfWZmWfavTNGDrfcYuRyc6uiZQrf
   PiFCpscUoZwPCXYkMkdXd6tEVPEzFgWLtp1vAHTpgvpYObqN5K8bUmjmA
   pIC01TLA0zdReUZ6svLc0nWToml+pNd4/bpFwbbRdjxLN3+wsdDRECULm
   VR7/1bm8Pzdw1C4+iXSqOYUT9wtzpaGw9BEUNvIYzOjHh9TC4nCtIr2w6
   g==;
IronPort-SDR: XESHdm+xI5lqO/Hckc+BZPTm9YYozmmQr145UpfI1tLbEQ0GPuOgm4BKdnitWBoKsSpCbyKQtq
 ZaM+zfh+TsBpGpC08r/mYrRMENdjV/CQH0s9zG9vFZXmzCzdZwLQLxBp8qio2j38CDrX1+0e47
 nlSKmZES6vyZKoKZkFs2eaX+wJVHKM7waIWh2yDq8V2yzQpsRlrA4NtO7S8JHIMTnnytLBoqHT
 FAuLlEBTFeXDRhhvEBCB1e73Rw6o+qli8Gpdg4KnUEA70Ces1gwBscW9rgwN5gBteAomVieZxg
 Caw=
X-IronPort-AV: E=Sophos;i="5.76,414,1592841600"; 
   d="scan'208";a="147041239"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 16:56:59 +0800
IronPort-SDR: ClbI/BLXbLN/1ClPDNMuYmuKFDPmuJX6by7oZgNQBXuP06tD2SNI6CpL/dJcZM/uEbjv8NV4aq
 nc2EZ2cb3EZw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 01:44:16 -0700
IronPort-SDR: 22sKthLyhQAaoLbFiwqwP2XqJAEIJLC/VlCP7eqd+AMaUulRszEZuQsu6iZQEZ0IQ66peXW0Vr
 xpXyim6o9dHg==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Sep 2020 01:56:58 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 2/4] zonefs: provide zonefs_io_error variant that can be called with i_truncate_mutex held
Date:   Fri, 11 Sep 2020 17:56:49 +0900
Message-Id: <20200911085651.23526-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200911085651.23526-1-johannes.thumshirn@wdc.com>
References: <20200911085651.23526-1-johannes.thumshirn@wdc.com>
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
 fs/zonefs/super.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 6e13a5127b01..4309979eeb36 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -348,7 +348,7 @@ static int zonefs_io_error_cb(struct blk_zone *zone, unsigned int idx,
  * eventually correct the file size and zonefs inode write pointer offset
  * (which can be out of sync with the drive due to partial write failures).
  */
-static void zonefs_io_error(struct inode *inode, bool write)
+static void __zonefs_io_error(struct inode *inode, bool write)
 {
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
 	struct super_block *sb = inode->i_sb;
@@ -362,8 +362,6 @@ static void zonefs_io_error(struct inode *inode, bool write)
 	};
 	int ret;
 
-	mutex_lock(&zi->i_truncate_mutex);
-
 	/*
 	 * Memory allocations in blkdev_report_zones() can trigger a memory
 	 * reclaim which may in turn cause a recursion into zonefs as well as
@@ -379,7 +377,14 @@ static void zonefs_io_error(struct inode *inode, bool write)
 		zonefs_err(sb, "Get inode %lu zone information failed %d\n",
 			   inode->i_ino, ret);
 	memalloc_noio_restore(noio_flag);
+}
 
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

