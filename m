Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32C43EC8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 00:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbfD2WJw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 18:09:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46734 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728105AbfD2WJw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 18:09:52 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2E63C308624B;
        Mon, 29 Apr 2019 22:09:52 +0000 (UTC)
Received: from max.home.com (unknown [10.40.205.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7467717CCB;
        Mon, 29 Apr 2019 22:09:49 +0000 (UTC)
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
Subject: [PATCH v7 3/5] iomap: Fix use-after-free error in page_done callback
Date:   Tue, 30 Apr 2019 00:09:32 +0200
Message-Id: <20190429220934.10415-4-agruenba@redhat.com>
In-Reply-To: <20190429220934.10415-1-agruenba@redhat.com>
References: <20190429220934.10415-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 29 Apr 2019 22:09:52 +0000 (UTC)
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/buffer.c | 2 +-
 fs/iomap.c  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index e0d4c6a5e2d2..0faa41fb4c88 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2104,7 +2104,6 @@ void __generic_write_end(struct inode *inode, loff_t pos, unsigned copied,
 	}
 
 	unlock_page(page);
-	put_page(page);
 
 	if (old_size < pos)
 		pagecache_isize_extended(inode, old_size, pos);
@@ -2160,6 +2159,7 @@ int generic_write_end(struct file *file, struct address_space *mapping,
 {
 	copied = block_write_end(file, mapping, pos, len, copied, page, fsdata);
 	__generic_write_end(mapping->host, pos, copied, page);
+	put_page(page);
 	return copied;
 }
 EXPORT_SYMBOL(generic_write_end);
diff --git a/fs/iomap.c b/fs/iomap.c
index f8c9722d1a97..62e3461704ce 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -780,6 +780,7 @@ iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
 	__generic_write_end(inode, pos, ret, page);
 	if (iomap->page_done)
 		iomap->page_done(inode, pos, copied, page, iomap);
+	put_page(page);
 
 	if (ret < len)
 		iomap_write_failed(inode, pos, len);
-- 
2.20.1

