Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AE770937C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 11:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjESJhX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 05:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbjESJhA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 05:37:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120B51FC3;
        Fri, 19 May 2023 02:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2vGhRrsGDQG1XODk9UotEfGLA1kaizvBUpauFyMQx+4=; b=TBnMbLul9soaolAwQt3sWNxAv8
        S50hIIY4562VCW+y/Cq8+3LO3VrJg96XVVX2EEiXJHKTs9YdOwSZr3vQ7xKMYQq9loacKBMo2TjQb
        mt2oOAqhwJYf/vwi9ZwUhGiDHZEP+OGyxljgfJPRxypkUk2aYNRd8cRBNC8WigFq4itE5QkV3u6WE
        k6G4AwhOJicC5M2bn3hgQkw1CEDeF7NprlLZ1rD8HkyWJakLoX2ZPgXlNNx1J6pEwSt17Z1ByP739
        zN5MLhg8XrTTTkFcFtuLeIxZDkVu1Lvi1yv+CkNKAggzxH5e0OR08oQL+h60U4KPl67tkcU+vLZ53
        YO6mHBPw==;
Received: from [2001:4bb8:188:3dd5:e8d0:68bb:e5be:210a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzwWR-00Fjew-1b;
        Fri, 19 May 2023 09:35:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net (open list:F2FS FILE SYSTEM),
        cluster-devel@redhat.com, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 05/13] filemap: add a kiocb_invalidate_pages helper
Date:   Fri, 19 May 2023 11:35:13 +0200
Message-Id: <20230519093521.133226-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230519093521.133226-1-hch@lst.de>
References: <20230519093521.133226-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out a helper that calls filemap_write_and_wait_range and
invalidate_inode_pages2_rangefor a the range covered by a write kiocb or
returns -EAGAIN if the kiocb is marked as nowait and there would be pages
to write or invalidate.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/pagemap.h |  1 +
 mm/filemap.c            | 48 ++++++++++++++++++++++++-----------------
 2 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 36fc2cea13ce20..6e4c9ee40baa99 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -30,6 +30,7 @@ static inline void invalidate_remote_inode(struct inode *inode)
 int invalidate_inode_pages2(struct address_space *mapping);
 int invalidate_inode_pages2_range(struct address_space *mapping,
 		pgoff_t start, pgoff_t end);
+int kiocb_invalidate_pages(struct kiocb *iocb, size_t count);
 
 int write_inode_now(struct inode *, int sync);
 int filemap_fdatawrite(struct address_space *);
diff --git a/mm/filemap.c b/mm/filemap.c
index 2d7712b13b95c9..8607220e20eae3 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2777,6 +2777,33 @@ int kiocb_write_and_wait(struct kiocb *iocb, size_t count)
 	return filemap_write_and_wait_range(mapping, pos, end);
 }
 
+int kiocb_invalidate_pages(struct kiocb *iocb, size_t count)
+{
+	struct address_space *mapping = iocb->ki_filp->f_mapping;
+	loff_t pos = iocb->ki_pos;
+	loff_t end = pos + count - 1;
+	int ret;
+
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		/* we could block if there are any pages in the range */
+		if (filemap_range_has_page(mapping, pos, end))
+			return -EAGAIN;
+	} else {
+		ret = filemap_write_and_wait_range(mapping, pos, end);
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * After a write we want buffered reads to be sure to go to disk to get
+	 * the new data.  We invalidate clean cached page from the region we're
+	 * about to write.  We do this *before* the write so that we can return
+	 * without clobbering -EIOCBQUEUED from ->direct_IO().
+	 */
+	return invalidate_inode_pages2_range(mapping, pos >> PAGE_SHIFT,
+					     end >> PAGE_SHIFT);
+}
+
 /**
  * generic_file_read_iter - generic filesystem read routine
  * @iocb:	kernel I/O control block
@@ -3820,30 +3847,11 @@ generic_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	write_len = iov_iter_count(from);
 	end = (pos + write_len - 1) >> PAGE_SHIFT;
 
-	if (iocb->ki_flags & IOCB_NOWAIT) {
-		/* If there are pages to writeback, return */
-		if (filemap_range_has_page(file->f_mapping, pos,
-					   pos + write_len - 1))
-			return -EAGAIN;
-	} else {
-		written = filemap_write_and_wait_range(mapping, pos,
-							pos + write_len - 1);
-		if (written)
-			goto out;
-	}
-
-	/*
-	 * After a write we want buffered reads to be sure to go to disk to get
-	 * the new data.  We invalidate clean cached page from the region we're
-	 * about to write.  We do this *before* the write so that we can return
-	 * without clobbering -EIOCBQUEUED from ->direct_IO().
-	 */
-	written = invalidate_inode_pages2_range(mapping,
-					pos >> PAGE_SHIFT, end);
 	/*
 	 * If a page can not be invalidated, return 0 to fall back
 	 * to buffered write.
 	 */
+	written = kiocb_invalidate_pages(iocb, write_len);
 	if (written) {
 		if (written == -EBUSY)
 			return 0;
-- 
2.39.2

