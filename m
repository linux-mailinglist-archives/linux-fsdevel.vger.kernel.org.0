Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398D51BC03C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 15:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgD1NwF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 09:52:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbgD1NwB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 09:52:01 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1955206E2;
        Tue, 28 Apr 2020 13:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588081920;
        bh=5DdCwI3stPz5DcXHNz6QeRl8dl1BU5K/ki0kBBLSF+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eye04z2GXBaS6y4uVXFqR7zpeMHKS/A7d842gJM3kyTlZYGDkjg/xx1Cs+ICtVGbw
         FjIvVY+uANXXSHOJ5uay18mIOXrMe9vgjwsUM6zL+IWt00iN0QVo8xwm+B5adhgp+T
         CuAyfLDXjV58jghwU42H73NSaMO1D5NKtJmmizA4=
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, andres@anarazel.de, willy@infradead.org,
        dhowells@redhat.com, hch@infradead.org, jack@suse.cz,
        david@fromorbit.com
Subject: [PATCH v6 RESEND 2/2] buffer: record blockdev write errors in super_block that it backs
Date:   Tue, 28 Apr 2020 09:51:55 -0400
Message-Id: <20200428135155.19223-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200428135155.19223-1-jlayton@kernel.org>
References: <20200428135155.19223-1-jlayton@kernel.org>
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

Reviewed-by: Jan Kara <jack@suse.cz>
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
2.26.1

