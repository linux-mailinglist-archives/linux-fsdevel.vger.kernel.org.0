Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB5D9E7CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 18:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbfD2Qcv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 12:32:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41606 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728524AbfD2Qcv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 12:32:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E995887623;
        Mon, 29 Apr 2019 16:32:50 +0000 (UTC)
Received: from max.home.com (unknown [10.40.205.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 17BCD17A64;
        Mon, 29 Apr 2019 16:32:46 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     cluster-devel@redhat.com, Christoph Hellwig <hch@lst.de>
Cc:     Bob Peterson <rpeterso@redhat.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Mark Syms <Mark.Syms@citrix.com>,
        =?UTF-8?q?Edwin=20T=C3=B6r=C3=B6k?= <edvin.torok@citrix.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v6 2/4] iomap: Fix use-after-free error in page_done callback
Date:   Mon, 29 Apr 2019 18:32:37 +0200
Message-Id: <20190429163239.4874-2-agruenba@redhat.com>
In-Reply-To: <20190429163239.4874-1-agruenba@redhat.com>
References: <20190429163239.4874-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 29 Apr 2019 16:32:51 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In iomap_write_end, we're not holding a page reference anymore when
calling the page_done callback, but the callback needs that reference to
access the page.  To fix that, move the put_page call in
__generic_write_end into the callers of __generic_write_end.  Then, in
iomap_write_end, put the page after calling the page_done callback.

Reported-by: Jan Kara <jack@suse.cz>
Fixes: 63899c6f8851 ("iomap: add a page_done callback")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/buffer.c | 5 +++--
 fs/iomap.c  | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index ce357602f471..6e2c95160ce3 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2104,7 +2104,6 @@ int __generic_write_end(struct inode *inode, loff_t pos, unsigned copied,
 	}
 
 	unlock_page(page);
-	put_page(page);
 
 	if (old_size < pos)
 		pagecache_isize_extended(inode, old_size, pos);
@@ -2160,7 +2159,9 @@ int generic_write_end(struct file *file, struct address_space *mapping,
 			struct page *page, void *fsdata)
 {
 	copied = block_write_end(file, mapping, pos, len, copied, page, fsdata);
-	return __generic_write_end(mapping->host, pos, copied, page);
+	copied = __generic_write_end(mapping->host, pos, copied, page);
+	put_page(page);
+	return copied;
 }
 EXPORT_SYMBOL(generic_write_end);
 
diff --git a/fs/iomap.c b/fs/iomap.c
index 2344c662e6fc..b01ed5a28d2c 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -780,6 +780,7 @@ iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
 	ret = __generic_write_end(inode, pos, ret, page);
 	if (iomap->page_done)
 		iomap->page_done(inode, pos, copied, page, iomap);
+	put_page(page);
 
 	if (ret < len)
 		iomap_write_failed(inode, pos, len);
-- 
2.20.1

