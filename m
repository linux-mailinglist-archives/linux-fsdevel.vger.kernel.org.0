Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6242C544F39
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 16:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243194AbiFIOfE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 10:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235304AbiFIOfC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:35:02 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 373FA31CCB6;
        Thu,  9 Jun 2022 07:35:00 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3A8KhIy6spCvB+FPZdJeO2fM3W+OfnVPhcMUV32f8?=
 =?us-ascii?q?akzHdYEJGY0x3y2oWDTuEa/aOYmWhctx/advi/U0PsJXQmoBnTldvr3tgHilAw?=
 =?us-ascii?q?SbnLY7Hdx+vZUt+DSFioHpPtpxYMp+ZRCwNZie0SiyFb/6x/RGQ6YnSHuCmULS?=
 =?us-ascii?q?cY3goLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82cc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTeUtMTKPQPBSVlzxdXK3Kbhpq/3R0i/hkcqFHLxo/ZzahxridzP1XqJW2U?=
 =?us-ascii?q?hZvMKvXhMwTThtZDzpje6ZB/dcrJFDm65DDlhGZIyWEL/JGSRte0Zcj0up+H2B?=
 =?us-ascii?q?C3fICLzUKdBqCm6S9x7fTYulnhuwiKsfxNY8Ss30myivWZd4qQ4/ERari5tJC2?=
 =?us-ascii?q?jo0wMdUEp72YdQVaD9qRBDBeAFUfFMWDo8u2uulmBHXdzxetULQq7E77nbeyCR?=
 =?us-ascii?q?v37X3dtnYYNqHQYNShEnwjmbH+XnpRxIXLtqSzRKb/X+2wOzChyX2XMQVDrLQ3?=
 =?us-ascii?q?vprhkCDg3wdEzUIWlah5/q0kEizX5RYMUN8x8aEhcDe72TyFp+kAUL++yXC43Y?=
 =?us-ascii?q?htxNrO7VSwGmwJmD8um513lQ5cwM=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Av0Dwya3HDS+VGsXGsLDv+AqjBNwkLtp133Aq?=
 =?us-ascii?q?2lEZdPU1SK2lfq+V8MjzuSWetN9zYh8dcLK7V5VoKEm0naKdirN9AV7NZmPbhF?=
 =?us-ascii?q?c=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124814786"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 09 Jun 2022 22:34:59 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id EF0F44D16FFC;
        Thu,  9 Jun 2022 22:34:57 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 9 Jun 2022 22:34:58 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 9 Jun 2022 22:34:37 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <david@fromorbit.com>, <hch@infradead.org>
Subject: [PATCH] xfs: fail dax mount if reflink is enabled on a partition
Date:   Thu, 9 Jun 2022 22:34:35 +0800
Message-ID: <20220609143435.393724-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: EF0F44D16FFC.A55E3
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Failure notification is not supported on partitions.  So, when we mount
a reflink enabled xfs on a partition with dax option, let it fail with
-EINVAL code.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/xfs/xfs_super.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 8495ef076ffc..a3c221841fa6 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -348,8 +348,10 @@ xfs_setup_dax_always(
 		goto disable_dax;
 	}
 
-	if (xfs_has_reflink(mp)) {
-		xfs_alert(mp, "DAX and reflink cannot be used together!");
+	if (xfs_has_reflink(mp) &&
+	    bdev_is_partition(mp->m_ddev_targp->bt_bdev)) {
+		xfs_alert(mp,
+			"DAX and reflink cannot work with multi-partitions!");
 		return -EINVAL;
 	}
 
-- 
2.36.1



