Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985C01A7A45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 14:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439819AbgDNMES (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 08:04:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439808AbgDNMEO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:04:14 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8C712076B;
        Tue, 14 Apr 2020 12:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586865853;
        bh=dUeyL9occ1LadJp/YkgyEFBnPUbUwozdIxbmk4qkG6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D40h5ckhi3GEWYC1jSo/8d5JhiNN18OfiGl6Crk4JTEhlkB4kDpOvEVtd7UPqIKTL
         EWNjrFziaIWg0wBpq7bKhzQopenc5qtJXzWNCPtQpZHaCe+0j9hLX2vvWurnmf5LF8
         eiuMaUY8GUbMO4OoGR+YXiF755razhzWl//KyDFk=
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, andres@anarazel.de, willy@infradead.org,
        dhowells@redhat.com, hch@infradead.org, jack@suse.cz,
        akpm@linux-foundation.org, david@fromorbit.com
Subject: [PATCH v4 RESEND 2/2] buffer: record blockdev write errors in super_block that it backs
Date:   Tue, 14 Apr 2020 08:04:09 -0400
Message-Id: <20200414120409.293749-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200414120409.293749-1-jlayton@kernel.org>
References: <20200414120409.293749-1-jlayton@kernel.org>
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

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/buffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index f73276d746bb..a9d986d27fa1 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1160,6 +1160,8 @@ void mark_buffer_write_io_error(struct buffer_head *bh)
 		mapping_set_error(bh->b_page->mapping, -EIO);
 	if (bh->b_assoc_map)
 		mapping_set_error(bh->b_assoc_map, -EIO);
+	if (bh->b_bdev->bd_super)
+		errseq_set(&bh->b_bdev->bd_super->s_wb_err, -EIO);
 }
 EXPORT_SYMBOL(mark_buffer_write_io_error);
 
-- 
2.25.2

