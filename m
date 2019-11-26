Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9767109DCA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 13:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbfKZMU7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 07:20:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:40608 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728336AbfKZMU7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 07:20:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4159AB2ED;
        Tue, 26 Nov 2019 12:20:58 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH TRIVIAL] iomap: remove unneeded variable in iomap_dio_rw()
Date:   Tue, 26 Nov 2019 13:20:51 +0100
Message-Id: <20191126122051.6041-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The 'start' variable indicates the start of a filemap and is set to the
iocb's position, which we have already cached as 'pos', upon function
entry.

'pos' is used as a cursor indicating the current position and updated
later in iomap_dio_rw(), but not before the last use of 'start'.

Remove 'start' as it's synonym for 'pos' before we're entering the loop
calling iomapp_apply().

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/iomap/direct-io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 1fc28c2da279..405456b12f03 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -397,7 +397,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	struct address_space *mapping = iocb->ki_filp->f_mapping;
 	struct inode *inode = file_inode(iocb->ki_filp);
 	size_t count = iov_iter_count(iter);
-	loff_t pos = iocb->ki_pos, start = pos;
+	loff_t pos = iocb->ki_pos;
 	loff_t end = iocb->ki_pos + count - 1, ret = 0;
 	unsigned int flags = IOMAP_DIRECT;
 	bool wait_for_completion = is_sync_kiocb(iocb);
@@ -451,14 +451,14 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	}
 
 	if (iocb->ki_flags & IOCB_NOWAIT) {
-		if (filemap_range_has_page(mapping, start, end)) {
+		if (filemap_range_has_page(mapping, pos, end)) {
 			ret = -EAGAIN;
 			goto out_free_dio;
 		}
 		flags |= IOMAP_NOWAIT;
 	}
 
-	ret = filemap_write_and_wait_range(mapping, start, end);
+	ret = filemap_write_and_wait_range(mapping, pos, end);
 	if (ret)
 		goto out_free_dio;
 
@@ -469,7 +469,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	 * pretty crazy thing to do, so we don't support it 100%.
 	 */
 	ret = invalidate_inode_pages2_range(mapping,
-			start >> PAGE_SHIFT, end >> PAGE_SHIFT);
+			pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
 	if (ret)
 		dio_warn_stale_pagecache(iocb->ki_filp);
 	ret = 0;
-- 
2.16.4

