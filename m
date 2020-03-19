Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 470DD18BA78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 16:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgCSPH1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 11:07:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46452 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgCSPH0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=afkW/GXwClATqJVNGZL4WCMk+C+uRt19IQKH4try+WM=; b=Ue5UIy6ox5oGMsvmrX3eXfceUe
        qF3P12a1P3Rymfi3CIZUuYOdyo88B0Oy66ji6AyJbbcoUWcdQ5n/DhJ+SFE9ub6zjEoQTl0H+D0Z1
        xpct6R8alMiYPAoPERXwo6G3km3JntSnQeupTnxYOs2haPvrrq3aAWdAIFpyL6WWDrxDxv8miI0Fw
        18uGAjZ8NW+rD4wS+l/L3sqIWp6+pAw94LfDe0Vymn/HGX+IGG1maSoEsTjtz9xOHYf/nuEBpu65j
        v1tRtPX/gtRMmLePnwiQu9enHhFS9W159BCpdtY30TxqN5SFwSZOjyis9snRpQfQWAO5U5BeJdamv
        zElpMR/g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEwlZ-00013C-GR; Thu, 19 Mar 2020 15:07:25 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Dave Chinner <dchinner@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH] iomap: Submit BIOs at the end of each extent
Date:   Thu, 19 Mar 2020 08:07:20 -0700
Message-Id: <20200319150720.24622-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

By definition, an extent covers a range of consecutive blocks, so
it would be quite rare to be able to just add pages to the BIO from
a previous range.  The only case we can think of is a mapped extent
followed by a hole extent, followed by another mapped extent which has
been allocated immediately after the first extent.  We believe this to
be an unlikely layout for a filesystem to choose and, since the queue
is plugged, those two BIOs would be merged by the block layer.

The reason we care is that ext2/ext4 choose to lay out blocks 0-11
consecutively, followed by the indirect block, and we want to merge those
two BIOs.  If we don't submit the data BIO before asking the filesystem
for the next extent, then the indirect BIO will be submitted first,
and waited for, leading to inefficient I/O patterns.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 83438b3257de..8d26920ddf00 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -388,6 +388,11 @@ iomap_readahead_actor(struct inode *inode, loff_t pos, loff_t length,
 				ctx, iomap, srcmap);
 	}
 
+	if (ctx->bio) {
+		submit_bio(ctx->bio);
+		ctx->bio = NULL;
+	}
+
 	return done;
 }
 
-- 
2.25.1

