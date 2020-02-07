Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 790A4155C8A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 18:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgBGREi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 12:04:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:52942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbgBGRE2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 12:04:28 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5837721775;
        Fri,  7 Feb 2020 17:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581095068;
        bh=ZxvKRMhl7lIThcnne9emlNMv0Ks2BQRDLcIh5ixelek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ixqV4Vj9ZtMDKL2uwwsmYIuCMMTiJgzkyW3Q5SIfbS/E5WdnX4Hl2Ug5YTxXQwf4M
         syoAt6TqtpBQGciunxTzImNBlzlGoqs2yuBF2+HQ/Wrrox2J3uZ9JyrGIQr5hzhh3v
         P2Mb9CuDd3I/2h/didpKn+nf0d+XHtK5eJv2ECkE=
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, andres@anarazel.de, willy@infradead.org,
        dhowells@redhat.com, hch@infradead.org, jack@suse.cz,
        akpm@linux-foundation.org
Subject: [PATCH v3 2/3] buffer: record blockdev write errors in super_block that it backs
Date:   Fri,  7 Feb 2020 12:04:22 -0500
Message-Id: <20200207170423.377931-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207170423.377931-1-jlayton@kernel.org>
References: <20200207170423.377931-1-jlayton@kernel.org>
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
index b8d28370cfd7..451f1be6e1a4 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1166,6 +1166,8 @@ void mark_buffer_write_io_error(struct buffer_head *bh)
 		mapping_set_error(bh->b_page->mapping, -EIO);
 	if (bh->b_assoc_map)
 		mapping_set_error(bh->b_assoc_map, -EIO);
+	if (bh->b_bdev->bd_super)
+		errseq_set(&bh->b_bdev->bd_super->s_wb_err, -EIO);
 }
 EXPORT_SYMBOL(mark_buffer_write_io_error);
 
-- 
2.24.1

