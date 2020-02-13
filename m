Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 435CB15CCE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 22:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgBMVDB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 16:03:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:57328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728288AbgBMVDA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 16:03:00 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A6B1218AC;
        Thu, 13 Feb 2020 21:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581627780;
        bh=ZxvKRMhl7lIThcnne9emlNMv0Ks2BQRDLcIh5ixelek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iqeX0StcunKlHH8Oe+rECXOBBZZAHtJfSzyrjYvDuXWxZ9sCPqjUqtGXArs+PD0hr
         Wg4Ef2eeS7nmyWUuNfXpJkiNXx0sFJa8xMBhEdGOAUL+8vKN710wNtW0Ou7c/EAdpn
         maR0gsmGQ0GL8LKWUNs0MCK7hSrkRS30LFPsGq8w=
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, andres@anarazel.de, willy@infradead.org,
        dhowells@redhat.com, hch@infradead.org, jack@suse.cz,
        akpm@linux-foundation.org, david@fromorbit.com
Subject: [PATCH v4 2/2] buffer: record blockdev write errors in super_block that it backs
Date:   Thu, 13 Feb 2020 16:02:55 -0500
Message-Id: <20200213210255.871579-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213210255.871579-1-jlayton@kernel.org>
References: <20200213210255.871579-1-jlayton@kernel.org>
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

