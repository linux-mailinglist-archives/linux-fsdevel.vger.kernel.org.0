Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8040A13AEDF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 17:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgANQMn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 11:12:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43478 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728986AbgANQMl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:12:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gE1ExdwCpfYksx1sroYSdgpkjqJWhJqvmDoS1LitSEk=; b=OkrfZS8NRZAUrCzKeBJ9qWvRAB
        2p1eoX14Slhqy2MdQbUQPF0HUA7/g5EN85LDdIwsd3BB9W7/vFoDRbIUV1u3p8uRTNQdFA89yhgL0
        9jVm1PJqp35970u4WIuAU8p6kNZs2ZRtGJh3MVPfizmEgVpisfkPS5RqCDD065W+lOkbgH/N4b1Bz
        7rnYRufVoQXMjKefjP7lJXcCL1F7uOU+daZA/kor/TTYgisnaIvGQhJJN6++IY5+4HY49K2j6A2Mh
        gq2BDx44Hr656RZ6OjOd0CKj3XN1ffkbrMPs0HMihU+PDNmbAhTVWrX7qp1DCYhsdIKw9HUpFhaEO
        Ej399QhQ==;
Received: from [2001:4bb8:18c:4f54:fcbb:a92b:61e1:719] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irOo4-0000AR-W5; Tue, 14 Jan 2020 16:12:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 05/12] gfs2: fix O_SYNC write handling
Date:   Tue, 14 Jan 2020 17:12:18 +0100
Message-Id: <20200114161225.309792-6-hch@lst.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114161225.309792-1-hch@lst.de>
References: <20200114161225.309792-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Don't ignore the return value from generic_write_sync for the direct to
buffered I/O callback case when written is non-zero.  Also don't bother
to call generic_write_sync for the pure direct I/O case, as iomap_dio_rw
already takes care of that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/gfs2/file.c | 51 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 21d032c4b077..86c0e61407b6 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -847,7 +847,7 @@ static ssize_t gfs2_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
 	struct gfs2_inode *ip = GFS2_I(inode);
-	ssize_t written = 0, ret;
+	ssize_t ret = 0;
 
 	ret = gfs2_rsqa_alloc(ip);
 	if (ret)
@@ -882,52 +882,51 @@ static ssize_t gfs2_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		loff_t pos, endbyte;
 		ssize_t buffered;
 
-		written = gfs2_file_direct_write(iocb, from);
-		if (written < 0 || !iov_iter_count(from))
+		ret = gfs2_file_direct_write(iocb, from);
+		if (ret < 0 || !iov_iter_count(from))
 			goto out_unlock;
 
 		current->backing_dev_info = inode_to_bdi(inode);
-		ret = iomap_file_buffered_write(iocb, from, &gfs2_iomap_ops);
+		buffered = iomap_file_buffered_write(iocb, from,
+						     &gfs2_iomap_ops);
 		current->backing_dev_info = NULL;
-		if (unlikely(ret < 0))
+		if (unlikely(buffered <= 0)) {
+			if (buffered < 0)
+				ret = buffered;
 			goto out_unlock;
-		buffered = ret;
+		}
 
 		/*
 		 * We need to ensure that the page cache pages are written to
 		 * disk and invalidated to preserve the expected O_DIRECT
-		 * semantics.
+		 * semantics.  If the writeback or invalidate fails only report
+		 * the direct I/O range as we don't know if the buffered pages
+		 * made it to disk.
 		 */
 		pos = iocb->ki_pos;
 		endbyte = pos + buffered - 1;
 		ret = filemap_write_and_wait_range(mapping, pos, endbyte);
-		if (!ret) {
-			iocb->ki_pos += buffered;
-			written += buffered;
-			invalidate_mapping_pages(mapping,
-						 pos >> PAGE_SHIFT,
-						 endbyte >> PAGE_SHIFT);
-		} else {
-			/*
-			 * We don't know how much we wrote, so just return
-			 * the number of bytes which were direct-written
-			 */
-		}
+		if (ret)
+			goto out_unlock;
+
+		invalidate_mapping_pages(mapping, pos >> PAGE_SHIFT,
+					 endbyte >> PAGE_SHIFT);
+		ret += buffered;
 	} else {
 		current->backing_dev_info = inode_to_bdi(inode);
 		ret = iomap_file_buffered_write(iocb, from, &gfs2_iomap_ops);
 		current->backing_dev_info = NULL;
-		if (likely(ret > 0))
-			iocb->ki_pos += ret;
+		if (unlikely(ret <= 0))
+			goto out_unlock;
 	}
 
+	iocb->ki_pos += ret;
+	inode_unlock(inode);
+	return generic_write_sync(iocb, ret);
+
 out_unlock:
 	inode_unlock(inode);
-	if (likely(ret > 0)) {
-		/* Handle various SYNC-type writes */
-		ret = generic_write_sync(iocb, ret);
-	}
-	return written ? written : ret;
+	return ret;
 }
 
 static int fallocate_chunk(struct inode *inode, loff_t offset, loff_t len,
-- 
2.24.1

