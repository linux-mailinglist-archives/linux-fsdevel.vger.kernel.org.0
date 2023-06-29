Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC3D7421F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 10:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjF2IVG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 04:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbjF2ITp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 04:19:45 -0400
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D5730E5;
        Thu, 29 Jun 2023 01:18:17 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="110917759"
X-IronPort-AV: E=Sophos;i="6.01,168,1684767600"; 
   d="scan'208";a="110917759"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 17:18:15 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 1689F11475;
        Thu, 29 Jun 2023 17:18:13 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 4DBD8CF7ED;
        Thu, 29 Jun 2023 17:18:12 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.234.230])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id E62E36C9C4;
        Thu, 29 Jun 2023 17:18:05 +0900 (JST)
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Cc:     dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
        akpm@linux-foundation.org, djwong@kernel.org, mcgrof@kernel.org
Subject: [PATCH v12 1/2] xfs: fix the calculation for "end" and "length"
Date:   Thu, 29 Jun 2023 16:16:50 +0800
Message-Id: <20230629081651.253626-2-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230629081651.253626-1-ruansy.fnst@fujitsu.com>
References: <20230629081651.253626-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27720.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27720.006
X-TMASE-Result: 10--2.821700-10.000000
X-TMASE-MatchedRID: EXd9akoenk2hhjsqgSuNbxF4zyLyne+ATJDl9FKHbrm/XSsQNWtCeMJ0
        8DtUl59d4vM1YF6AJbbieYV7J8ae4wtuKBGekqUpnH7sbImOEBSyUkKnsigAVUOq1cc3wR7p3qY
        uO0eYbQA38/3PGuNu2whL582BEnpEUGPLb8eYNh9sPkQVQvEczTS8aTKeU4mx11kmIvi83kKbDR
        BqS2n66yzP5xAyz9Oenvkw4sh/+PcMX5CwH5DTUmgGZNLBHGNe
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The value of "end" should be "start + length - 1".

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_notify_failure.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
index c4078d0ec108..4a9bbd3fe120 100644
--- a/fs/xfs/xfs_notify_failure.c
+++ b/fs/xfs/xfs_notify_failure.c
@@ -114,7 +114,8 @@ xfs_dax_notify_ddev_failure(
 	int			error = 0;
 	xfs_fsblock_t		fsbno = XFS_DADDR_TO_FSB(mp, daddr);
 	xfs_agnumber_t		agno = XFS_FSB_TO_AGNO(mp, fsbno);
-	xfs_fsblock_t		end_fsbno = XFS_DADDR_TO_FSB(mp, daddr + bblen);
+	xfs_fsblock_t		end_fsbno = XFS_DADDR_TO_FSB(mp,
+							     daddr + bblen - 1);
 	xfs_agnumber_t		end_agno = XFS_FSB_TO_AGNO(mp, end_fsbno);
 
 	error = xfs_trans_alloc_empty(mp, &tp);
@@ -210,7 +211,7 @@ xfs_dax_notify_failure(
 	ddev_end = ddev_start + bdev_nr_bytes(mp->m_ddev_targp->bt_bdev) - 1;
 
 	/* Ignore the range out of filesystem area */
-	if (offset + len < ddev_start)
+	if (offset + len - 1 < ddev_start)
 		return -ENXIO;
 	if (offset > ddev_end)
 		return -ENXIO;
@@ -222,8 +223,8 @@ xfs_dax_notify_failure(
 		len -= ddev_start - offset;
 		offset = 0;
 	}
-	if (offset + len > ddev_end)
-		len -= ddev_end - offset;
+	if (offset + len - 1 > ddev_end)
+		len = ddev_end - offset + 1;
 
 	return xfs_dax_notify_ddev_failure(mp, BTOBB(offset), BTOBB(len),
 			mf_flags);
-- 
2.40.1

