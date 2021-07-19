Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F98C3CD264
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 12:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbhGSKAa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 06:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236358AbhGSKA2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:00:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05EFC061574;
        Mon, 19 Jul 2021 02:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=qd+WEYiXZlJ37IUM1ZUcVt/jgs3r9kPizrSaj4rOc20=; b=rh0FL7pHt+khRQekVmfuV96L0a
        roitaa+2qpf6YsfhUp5+A3BWMKxmtpIUkifODyLKpjrcRCwww1lipEZ4aKh4NJ0NSoeH/b+jI5nQg
        sBIQdlGsl6lsPfVWulnYMJU1Sjz0jBJtI08FQczHbm89nYgHX529+aH5rE3FDFpVKud0M3efsVAHR
        vCbzZWbx4BiDs7YP5oPzAAeoyHJAOF/ZEWahGobDNHEKSldsi68K00stzKrB4J6AO2SndjW/DF1Wh
        Url/xmGIQ7A5jzBwL42cdD2Sb6hIgA839WI7qn84rSK586zb+fwmsRsu3Bg2kbULKkmQqg8/uRhP7
        yR/M0uZA==;
Received: from [2001:4bb8:193:7660:d2a4:8d57:2e55:21d0] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5QfL-006kdL-56; Mon, 19 Jul 2021 10:38:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: [PATCH 04/27] fs: mark the iomap argument to __block_write_begin_int const
Date:   Mon, 19 Jul 2021 12:34:57 +0200
Message-Id: <20210719103520.495450-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719103520.495450-1-hch@lst.de>
References: <20210719103520.495450-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

__block_write_begin_int never modifies the passed in iomap, so mark it
const.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/buffer.c   | 4 ++--
 fs/internal.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 6290c3afdba488..bd6a9e9fbd64c9 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1912,7 +1912,7 @@ EXPORT_SYMBOL(page_zero_new_buffers);
 
 static void
 iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
-		struct iomap *iomap)
+		const struct iomap *iomap)
 {
 	loff_t offset = block << inode->i_blkbits;
 
@@ -1966,7 +1966,7 @@ iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
 }
 
 int __block_write_begin_int(struct page *page, loff_t pos, unsigned len,
-		get_block_t *get_block, struct iomap *iomap)
+		get_block_t *get_block, const struct iomap *iomap)
 {
 	unsigned from = pos & (PAGE_SIZE - 1);
 	unsigned to = from + len;
diff --git a/fs/internal.h b/fs/internal.h
index 3ce8edbaa3ca2f..9ad6b5157584b8 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -48,8 +48,8 @@ static inline int emergency_thaw_bdev(struct super_block *sb)
 /*
  * buffer.c
  */
-extern int __block_write_begin_int(struct page *page, loff_t pos, unsigned len,
-		get_block_t *get_block, struct iomap *iomap);
+int __block_write_begin_int(struct page *page, loff_t pos, unsigned len,
+		get_block_t *get_block, const struct iomap *iomap);
 
 /*
  * char_dev.c
-- 
2.30.2

