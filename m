Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A210E2776EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 18:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbgIXQj5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 12:39:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:36276 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728534AbgIXQjz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:39:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 424F6B298;
        Thu, 24 Sep 2020 16:39:53 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        darrick.wong@oracle.com, josef@toxicpanda.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 06/14] btrfs: Move pos increment and pagecache extension to btrfs_buffered_write()
Date:   Thu, 24 Sep 2020 11:39:13 -0500
Message-Id: <20200924163922.2547-7-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200924163922.2547-1-rgoldwyn@suse.de>
References: <20200924163922.2547-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

While we do this, correct the call to pagecache_isize_extended():
 - pagecache_isisze_extended needs to be called to the starting of the
   write as opposed to i_size
 - We don't need to check range before the call, this is done in the
   function

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/file.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 910e2fd234a9..4c40a2742aab 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1632,6 +1632,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 	int ret = 0;
 	bool only_release_metadata = false;
 	bool force_page_uptodate = false;
+	loff_t old_isize = i_size_read(inode);
 
 	nrptrs = min(DIV_ROUND_UP(iov_iter_count(i), PAGE_SIZE),
 			PAGE_SIZE / (sizeof(struct page *)));
@@ -1852,6 +1853,10 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 	}
 
 	extent_changeset_free(data_reserved);
+	if (num_written > 0) {
+		pagecache_isize_extended(inode, old_isize, iocb->ki_pos);
+		iocb->ki_pos += num_written;
+	}
 	return num_written ? num_written : ret;
 }
 
@@ -1975,7 +1980,6 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	loff_t pos;
 	size_t count;
 	loff_t oldsize;
-	int clean_page = 0;
 
 	if (!(iocb->ki_flags & IOCB_DIRECT) &&
 	    (iocb->ki_flags & IOCB_NOWAIT))
@@ -2057,8 +2061,6 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 			inode_unlock(inode);
 			goto out;
 		}
-		if (start_pos > round_up(oldsize, fs_info->sectorsize))
-			clean_page = 1;
 	}
 
 	if (sync)
@@ -2101,11 +2103,6 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 		current->journal_info = NULL;
 	} else {
 		num_written = btrfs_buffered_write(iocb, from);
-		if (num_written > 0)
-			iocb->ki_pos = pos + num_written;
-		if (clean_page)
-			pagecache_isize_extended(inode, oldsize,
-						i_size_read(inode));
 	}
 
 	inode_unlock(inode);
-- 
2.26.2

