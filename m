Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244111ABF6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 13:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632868AbgDPLfF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 07:35:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633747AbgDPLe5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:34:57 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 895BC221E8;
        Thu, 16 Apr 2020 11:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587036897;
        bh=TOVJ0nXqZ/Pw1D/4pr94s3NTk35dtTlrnCsUWfrJyFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fvzk6TndU70YshFsjL8E9BNXcIPGbyLDwgBTD+hi8Ai4uA5LnQcn9wYHazQZvB4qJ
         4sOdw7ZNGwKkJ15cXifcBKA6zKfQrHBPWGRYdiYUIIaYFeUuFCKaZIfIs54hOYWfGu
         I7iJH08mqdkOOkweqO91/WpWrfHJKJBCUOVM9eYM=
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, andres@anarazel.de, willy@infradead.org,
        dhowells@redhat.com, hch@infradead.org, jack@suse.cz,
        akpm@linux-foundation.org, david@fromorbit.com
Subject: [PATCH v6 2/2] buffer: record blockdev write errors in super_block that it backs
Date:   Thu, 16 Apr 2020 07:34:53 -0400
Message-Id: <20200416113453.227229-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200416113453.227229-1-jlayton@kernel.org>
References: <20200416113453.227229-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

When syncing out a block device (a'la __sync_blockdev), any error
encountered will only be recorded in the bd_inode's mapping. When the
blockdev contains a filesystem however, we'd like to also record the
error in the super_block that's stored there.

Make mark_buffer_write_io_error also record the error in the
corresponding super_block when a writeback error occurs and the block
device contains a mounted superblock.

Since superblocks are RCU freed, hold the rcu_read_lock to ensure
that the superblock doesn't go away while we're marking it.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/buffer.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index f73276d746bb..71be7e6cabca 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1154,12 +1154,19 @@ EXPORT_SYMBOL(mark_buffer_dirty);
 
 void mark_buffer_write_io_error(struct buffer_head *bh)
 {
+	struct super_block *sb;
+
 	set_buffer_write_io_error(bh);
 	/* FIXME: do we need to set this in both places? */
 	if (bh->b_page && bh->b_page->mapping)
 		mapping_set_error(bh->b_page->mapping, -EIO);
 	if (bh->b_assoc_map)
 		mapping_set_error(bh->b_assoc_map, -EIO);
+	rcu_read_lock();
+	sb = READ_ONCE(bh->b_bdev->bd_super);
+	if (sb)
+		errseq_set(&sb->s_wb_err, -EIO);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(mark_buffer_write_io_error);
 
-- 
2.25.2

