Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2820556D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 20:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731530AbfFYSNg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 14:13:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59450 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729099AbfFYSNg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 14:13:36 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CE885301D680;
        Tue, 25 Jun 2019 18:13:35 +0000 (UTC)
Received: from max.com (unknown [10.40.205.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 526FE10013D9;
        Tue, 25 Jun 2019 18:13:31 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs: Move mark_inode_dirty out of __generic_write_end
Date:   Tue, 25 Jun 2019 20:13:29 +0200
Message-Id: <20190625181329.3160-1-agruenba@redhat.com>
In-Reply-To: <20190625105011.GA2602@lst.de>
References: <20190618144716.8133-1-agruenba@redhat.com> <20190624065408.GA3565@lst.de> <20190624182243.22447-1-agruenba@redhat.com> <20190625095707.GA1462@lst.de> <20190625105011.GA2602@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 25 Jun 2019 18:13:35 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 25 Jun 2019 at 12:50, Christoph Hellwig <hch@lst.de> wrote:
>
> > That seems way more complicated.  I'd much rather go with something
> > like may patch plus maybe a big fat comment explaining that persisting
> > the size update is the file systems job.  Note that a lot of the modern
> > file systems don't use the VFS inode tracking for that, besides XFS
> > that includes at least btrfs and ocfs2 as well.
>
> I'd suggest something like this as the baseline:
>
> http://git.infradead.org/users/hch/xfs.git/shortlog/refs/heads/iomap-i_size

Alright, can we change this as follows?

[Also, I'm not really sure why we check for (pos + ret > inode->i_size)
when we have already read inode->i_size into old_size.]

Thanks,
Andreas

--

iomap: don't mark the inode dirty in iomap_write_end

Marking the inode dirty for each page copied into the page cache
can be very ineffcient for file systems that use the VFS dirty
inode tracking, and is completely pointless for those that don't
use the VFS dirty tracking.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/bmap.c        |  2 ++
 fs/iomap.c            | 15 ++++++++++++++-
 include/linux/iomap.h |  1 +
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 93ea1d5..f4b895f 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1182,6 +1182,8 @@ static int gfs2_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 
 	if (ip->i_qadata && ip->i_qadata->qa_qd_num)
 		gfs2_quota_unlock(ip);
+	if (iomap->flags & IOMAP_F_SIZE_CHANGED)
+		mark_inode_dirty(inode);
 	gfs2_write_unlock(inode);
 
 out:
diff --git a/fs/iomap.c b/fs/iomap.c
index 12654c2..cd24bd1 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -777,6 +777,7 @@ struct iomap_readpage_ctx {
 		unsigned copied, struct page *page, struct iomap *iomap)
 {
 	const struct iomap_page_ops *page_ops = iomap->page_ops;
+	loff_t old_size = inode->i_size;
 	int ret;
 
 	if (iomap->type == IOMAP_INLINE) {
@@ -788,7 +789,19 @@ struct iomap_readpage_ctx {
 		ret = __iomap_write_end(inode, pos, len, copied, page, iomap);
 	}
 
-	__generic_write_end(inode, pos, ret, page);
+	/*
+	 * Update the in-memory inode size after copying the data into the page
+	 * cache.  It's up to the file system to write the updated size to disk,
+	 * preferably after I/O completion so that no stale data is exposed.
+	 */
+	if (pos + ret > inode->i_size) {
+		i_size_write(inode, pos + ret);
+		iomap->flags |= IOMAP_F_SIZE_CHANGED;
+	}
+	unlock_page(page);
+
+	if (old_size < pos)
+		pagecache_isize_extended(inode, old_size, pos);
 	if (page_ops && page_ops->page_done)
 		page_ops->page_done(inode, pos, copied, page, iomap);
 	put_page(page);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 2103b94..1df9ea1 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -35,6 +35,7 @@
 #define IOMAP_F_NEW		0x01	/* blocks have been newly allocated */
 #define IOMAP_F_DIRTY		0x02	/* uncommitted metadata */
 #define IOMAP_F_BUFFER_HEAD	0x04	/* file system requires buffer heads */
+#define IOMAP_F_SIZE_CHANGED	0x08	/* file size has changed */
 
 /*
  * Flags that only need to be reported for IOMAP_REPORT requests:
-- 
1.8.3.1

