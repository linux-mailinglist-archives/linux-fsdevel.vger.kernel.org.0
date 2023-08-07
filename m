Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9DC772234
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 13:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbjHGLag (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 07:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjHGLaY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:30:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E0D4C2E;
        Mon,  7 Aug 2023 04:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=uTFXJEZ5i5jF3kEHSDPE7oGVWRik+tOZ60zzYQjlfmE=; b=EBQqQnJtiNFns5qlfMoyXuCsnr
        T0TIHY2JSR9GFmQ7VP6BhnJVArZ8UJvd62nri76az1ItrYVIn2WiisuL65TW0IrW6j9WByDeaUMqa
        DZVAYP8iLzPQsOdJLKkaJxg+tA2tBTUjcY1v3S0LS8wJ+O9BNIQ0iSHLpZF63B1PfAjp18eCle5KW
        9QRKWKZrRE4/+rs529iWAsv8fupsHG9oMrSze40CJ4Yzw6dwrUwquNG5G7cDU9KttsjOEaNOewuur
        qlE0CBOLN7G+IghvYtE2PVMWRrO7sZywjp3ehSqH5JBojK+aDLWmaNmbQDNkrrMAfvevOWfOmJhue
        724VPPjQ==;
Received: from [82.33.212.90] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qSyNl-00H57H-2V;
        Mon, 07 Aug 2023 11:26:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, ocfs2-devel@lists.linux.dev,
        linux-block@vger.kernel.org
Subject: [PATCH 1/4] fs: stop using bdev->bd_super in mark_buffer_write_io_error
Date:   Mon,  7 Aug 2023 12:26:22 +0100
Message-Id: <20230807112625.652089-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807112625.652089-1-hch@lst.de>
References: <20230807112625.652089-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

bdev->bd_super is a somewhat awkward backpointer from a block device to
an owning file system with unclear rules.

For the buffer_head code we already have a good backpointer for the
inode that the buffer_head is associated with, even if it lives on the
block device mapping: b_assoc_map. It is used track dirty buffers
associated with an inode but living on the block device mapping like
directory buffers in ext4.

mark_buffer_write_io_error already uses it for the call to
mapping_set_error, and should be doing the same for the per-sb error
sequence.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/buffer.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index bd091329026c0f..f36ef03c078af6 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1225,19 +1225,14 @@ EXPORT_SYMBOL(mark_buffer_dirty);
 
 void mark_buffer_write_io_error(struct buffer_head *bh)
 {
-	struct super_block *sb;
-
 	set_buffer_write_io_error(bh);
 	/* FIXME: do we need to set this in both places? */
 	if (bh->b_folio && bh->b_folio->mapping)
 		mapping_set_error(bh->b_folio->mapping, -EIO);
-	if (bh->b_assoc_map)
+	if (bh->b_assoc_map) {
 		mapping_set_error(bh->b_assoc_map, -EIO);
-	rcu_read_lock();
-	sb = READ_ONCE(bh->b_bdev->bd_super);
-	if (sb)
-		errseq_set(&sb->s_wb_err, -EIO);
-	rcu_read_unlock();
+		errseq_set(&bh->b_assoc_map->host->i_sb->s_wb_err, -EIO);
+	}
 }
 EXPORT_SYMBOL(mark_buffer_write_io_error);
 
-- 
2.39.2

