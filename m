Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DBD7A0847
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 17:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240628AbjINPA1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 11:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbjINPAZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:00:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA831FC4;
        Thu, 14 Sep 2023 08:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=N2P1sP4TNHc1ikURftWXESxt7tBpXc+ocZgrSYl8k6Q=; b=iSf3gXJV000l4CXPDzPdP8QTq9
        iRJUi8/JKqHD8BMpXh3aRjHcMY2dl6q8EHmpz6U4jjysgI5V2ZmCZh13536GcuWQ7RdgUOtZB9rz0
        x2Gh7BWKWSur2qzhLaK9Che4uZuLEuq6b29J84PPkGU/op2y1hB40iQCqwpuf8uy9EtfIGet54f0s
        arUrxJZP24dRbiYkdCNnBorDZ8T0vEJadqzBTg4bbeuFhSAPQ5/6JaBi3Bnt5rjX94rb31eTrMVo0
        IsSruJPk1n2kPUG/CT+FkxHxbWeDxtXBW7fsZ6kwsmPAhFLWGtZrclmlnbNXDrqE/TMlw1Vp23Ql9
        jzWSYIaw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qgnpF-003XOQ-W6; Thu, 14 Sep 2023 15:00:14 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hui Zhu <teawater@antgroup.com>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: [PATCH v2 4/8] buffer: Use bdev_getblk() to avoid memory reclaim in readahead path
Date:   Thu, 14 Sep 2023 16:00:07 +0100
Message-Id: <20230914150011.843330-5-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230914150011.843330-1-willy@infradead.org>
References: <20230914150011.843330-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

__getblk() adds __GFP_NOFAIL, which is unnecessary for readahead;
we're quite comfortable with the possibility that we may not get a bh
back.  Switch to bdev_getblk() which does not include __GFP_NOFAIL.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 3fe293c9f3ca..58546bfd8903 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1464,7 +1464,9 @@ EXPORT_SYMBOL(__getblk_gfp);
  */
 void __breadahead(struct block_device *bdev, sector_t block, unsigned size)
 {
-	struct buffer_head *bh = __getblk(bdev, block, size);
+	struct buffer_head *bh = bdev_getblk(bdev, block, size,
+			GFP_NOWAIT | __GFP_MOVABLE);
+
 	if (likely(bh)) {
 		bh_readahead(bh, REQ_RAHEAD);
 		brelse(bh);
-- 
2.40.1

