Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFC55EC8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 00:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbfD2WJt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 18:09:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728105AbfD2WJt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 18:09:49 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1A3BC308624B;
        Mon, 29 Apr 2019 22:09:49 +0000 (UTC)
Received: from max.home.com (unknown [10.40.205.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D9AA1850B;
        Mon, 29 Apr 2019 22:09:46 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     cluster-devel@redhat.com,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Bob Peterson <rpeterso@redhat.com>,
        Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Mark Syms <Mark.Syms@citrix.com>,
        =?UTF-8?q?Edwin=20T=C3=B6r=C3=B6k?= <edvin.torok@citrix.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v7 2/5] fs: Turn __generic_write_end into a void function
Date:   Tue, 30 Apr 2019 00:09:31 +0200
Message-Id: <20190429220934.10415-3-agruenba@redhat.com>
In-Reply-To: <20190429220934.10415-1-agruenba@redhat.com>
References: <20190429220934.10415-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 29 Apr 2019 22:09:49 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The VFS-internal __generic_write_end helper always returns the value of
its @copied argument.  This can be confusing, and it isn't very useful
anyway, so turn __generic_write_end into a function returning void
instead.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/buffer.c   | 6 +++---
 fs/internal.h | 2 +-
 fs/iomap.c    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index ce357602f471..e0d4c6a5e2d2 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2085,7 +2085,7 @@ int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
 }
 EXPORT_SYMBOL(block_write_begin);
 
-int __generic_write_end(struct inode *inode, loff_t pos, unsigned copied,
+void __generic_write_end(struct inode *inode, loff_t pos, unsigned copied,
 		struct page *page)
 {
 	loff_t old_size = inode->i_size;
@@ -2116,7 +2116,6 @@ int __generic_write_end(struct inode *inode, loff_t pos, unsigned copied,
 	 */
 	if (i_size_changed)
 		mark_inode_dirty(inode);
-	return copied;
 }
 
 int block_write_end(struct file *file, struct address_space *mapping,
@@ -2160,7 +2159,8 @@ int generic_write_end(struct file *file, struct address_space *mapping,
 			struct page *page, void *fsdata)
 {
 	copied = block_write_end(file, mapping, pos, len, copied, page, fsdata);
-	return __generic_write_end(mapping->host, pos, copied, page);
+	__generic_write_end(mapping->host, pos, copied, page);
+	return copied;
 }
 EXPORT_SYMBOL(generic_write_end);
 
diff --git a/fs/internal.h b/fs/internal.h
index 6a8b71643af4..530587fdf5d8 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -44,7 +44,7 @@ static inline int __sync_blockdev(struct block_device *bdev, int wait)
 extern void guard_bio_eod(int rw, struct bio *bio);
 extern int __block_write_begin_int(struct page *page, loff_t pos, unsigned len,
 		get_block_t *get_block, struct iomap *iomap);
-int __generic_write_end(struct inode *inode, loff_t pos, unsigned copied,
+void __generic_write_end(struct inode *inode, loff_t pos, unsigned copied,
 		struct page *page);
 
 /*
diff --git a/fs/iomap.c b/fs/iomap.c
index 2344c662e6fc..f8c9722d1a97 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -777,7 +777,7 @@ iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
 		ret = __iomap_write_end(inode, pos, len, copied, page, iomap);
 	}
 
-	ret = __generic_write_end(inode, pos, ret, page);
+	__generic_write_end(inode, pos, ret, page);
 	if (iomap->page_done)
 		iomap->page_done(inode, pos, copied, page, iomap);
 
-- 
2.20.1

