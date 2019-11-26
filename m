Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D742109803
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 04:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfKZDPx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Nov 2019 22:15:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:34268 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726016AbfKZDPx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Nov 2019 22:15:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F3945B390;
        Tue, 26 Nov 2019 03:15:51 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, hch@infradead.org,
        darrick.wong@oracle.com, fdmanana@kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 4/5] btrfs: Wait for extent bits to release page
Date:   Mon, 25 Nov 2019 21:14:55 -0600
Message-Id: <20191126031456.12150-5-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191126031456.12150-1-rgoldwyn@suse.de>
References: <20191126031456.12150-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

While trying to release a page, the extent containing the page may be locked
which would stop the page from being released. Wait for the
extent lock to be cleared, if blocking is allowed and then clear
the bits.

While we are at it, clean the code of try_release_extent_state() to make
it simpler.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/extent_io.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index cceaf05aada2..a7c32276702d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4367,28 +4367,23 @@ static int try_release_extent_state(struct extent_io_tree *tree,
 {
 	u64 start = page_offset(page);
 	u64 end = start + PAGE_SIZE - 1;
-	int ret = 1;
 
 	if (test_range_bit(tree, start, end, EXTENT_LOCKED, 0, NULL)) {
-		ret = 0;
-	} else {
-		/*
-		 * at this point we can safely clear everything except the
-		 * locked bit and the nodatasum bit
-		 */
-		ret = __clear_extent_bit(tree, start, end,
-				 ~(EXTENT_LOCKED | EXTENT_NODATASUM),
-				 0, 0, NULL, mask, NULL);
-
-		/* if clear_extent_bit failed for enomem reasons,
-		 * we can't allow the release to continue.
-		 */
-		if (ret < 0)
-			ret = 0;
-		else
-			ret = 1;
+		if (!gfpflags_allow_blocking(mask))
+			return 0;
+		wait_extent_bit(tree, start, end, EXTENT_LOCKED);
 	}
-	return ret;
+	/*
+	 * At this point we can safely clear everything except the locked and
+	 * nodatasum bits. If clear_extent_bit failed due to -ENOMEM,
+	 * don't allow release.
+	 */
+	if (__clear_extent_bit(tree, start, end,
+				~(EXTENT_LOCKED | EXTENT_NODATASUM), 0, 0,
+				NULL, mask, NULL) < 0)
+		return 0;
+
+	return 1;
 }
 
 /*
-- 
2.16.4

