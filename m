Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D881AA6F5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 17:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390340AbfIEPHa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 11:07:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:57100 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390336AbfIEPH1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:07:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6E64DB692;
        Thu,  5 Sep 2019 15:07:26 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, darrick.wong@oracle.com, hch@lst.de,
        linux-xfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 15/15] xfs: Use the new iomap infrastructure for CoW
Date:   Thu,  5 Sep 2019 10:06:50 -0500
Message-Id: <20190905150650.21089-16-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190905150650.21089-1-rgoldwyn@suse.de>
References: <20190905150650.21089-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Set the IOMAP_F_COW flag and create the srcmap based on
current extents to read from.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/xfs/xfs_iomap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 8321733c16c3..13495d8a1ee2 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1006,7 +1006,10 @@ xfs_file_iomap_begin(
 		 */
 		if (directio || imap.br_startblock == HOLESTARTBLOCK)
 			imap = cmap;
+		else
+			xfs_bmbt_to_iomap(ip, srcmap, &cmap, false);
 
+		iomap->flags |= IOMAP_F_COW;
 		end_fsb = imap.br_startoff + imap.br_blockcount;
 		length = XFS_FSB_TO_B(mp, end_fsb) - offset;
 	}
-- 
2.16.4

