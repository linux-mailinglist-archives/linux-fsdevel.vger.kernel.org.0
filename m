Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7FA6EC557
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 07:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjDXFuG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 01:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjDXFtx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 01:49:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A380735A6;
        Sun, 23 Apr 2023 22:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FZ/oX6CCuoV1bgBWAGOx8K6ORykPZ4voWywQ/l5w2pE=; b=LPBHKUTFShS6lFcY9XAvrDO0zy
        2lv9lSVBz58fAlT2EQi21jkueDOTS4twSStbFX5syhvx3ExuYVTYHf7Uj4O+4gRkholvUzQfsBcGM
        tdLNzfyJevRkb6vfEGgqTSROsy9NbDiGm1YGQ+aUl4dzdtQ7j5D4onehk+I1FYoOC/PnDCk9rdzOP
        Jw8L43J/TAXvVuHlvExzZqOHSCZWdqzV2HplCDpDQjup3RzBEOjFY66ho4n+n3SwT6MAzQBaWtIUq
        5KlfoqP7K2wthTABWhRz6wnhfsdxVwTKphcpG74JgjuxMocweMuLa0NGt3sY0/TpYPdgIZSJTnEL8
        OEkt1oog==;
Received: from [2001:4bb8:189:a74f:e8a5:5f73:6d2:23b8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pqp59-00FOvi-2z;
        Mon, 24 Apr 2023 05:49:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/17] filemap: add a kiocb_write_and_wait helper
Date:   Mon, 24 Apr 2023 07:49:15 +0200
Message-Id: <20230424054926.26927-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424054926.26927-1-hch@lst.de>
References: <20230424054926.26927-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out a helper that does filemap_write_and_wait_range for a the
range covered by a read kiocb, or returns -EAGAIN if the kiocb
is marked as nowait and there would be pages to write.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/fops.c            | 18 +++---------------
 include/linux/pagemap.h |  2 ++
 mm/filemap.c            | 30 ++++++++++++++++++------------
 3 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index d2e6be4e3d1c7d..c194939b851cfb 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -576,21 +576,9 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		goto reexpand; /* skip atime */
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
-		struct address_space *mapping = iocb->ki_filp->f_mapping;
-
-		if (iocb->ki_flags & IOCB_NOWAIT) {
-			if (filemap_range_needs_writeback(mapping, pos,
-							  pos + count - 1)) {
-				ret = -EAGAIN;
-				goto reexpand;
-			}
-		} else {
-			ret = filemap_write_and_wait_range(mapping, pos,
-							   pos + count - 1);
-			if (ret < 0)
-				goto reexpand;
-		}
-
+		ret = kiocb_write_and_wait(iocb, count);
+		if (ret < 0)
+			goto reexpand;
 		file_accessed(iocb->ki_filp);
 
 		ret = blkdev_direct_IO(iocb, to);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 0acb8e1fb7afdc..51f7aea51169c4 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -30,6 +30,7 @@ static inline void invalidate_remote_inode(struct inode *inode)
 int invalidate_inode_pages2(struct address_space *mapping);
 int invalidate_inode_pages2_range(struct address_space *mapping,
 		pgoff_t start, pgoff_t end);
+
 int write_inode_now(struct inode *, int sync);
 int filemap_fdatawrite(struct address_space *);
 int filemap_flush(struct address_space *);
@@ -54,6 +55,7 @@ int filemap_check_errors(struct address_space *mapping);
 void __filemap_set_wb_err(struct address_space *mapping, int err);
 int filemap_fdatawrite_wbc(struct address_space *mapping,
 			   struct writeback_control *wbc);
+int kiocb_write_and_wait(struct kiocb *iocb, size_t count);
 
 static inline int filemap_write_and_wait(struct address_space *mapping)
 {
diff --git a/mm/filemap.c b/mm/filemap.c
index 0110bde3708b3f..28ea9804191d6b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2765,6 +2765,21 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 }
 EXPORT_SYMBOL_GPL(filemap_read);
 
+int kiocb_write_and_wait(struct kiocb *iocb, size_t count)
+{
+	struct address_space *mapping = iocb->ki_filp->f_mapping;
+	loff_t pos = iocb->ki_pos;
+	loff_t end = pos + count - 1;
+
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (filemap_range_needs_writeback(mapping, pos, end))
+			return -EAGAIN;
+		return 0;
+	}
+
+	return filemap_write_and_wait_range(mapping, pos, end);
+}
+
 /**
  * generic_file_read_iter - generic filesystem read routine
  * @iocb:	kernel I/O control block
@@ -2800,18 +2815,9 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		struct address_space *mapping = file->f_mapping;
 		struct inode *inode = mapping->host;
 
-		if (iocb->ki_flags & IOCB_NOWAIT) {
-			if (filemap_range_needs_writeback(mapping, iocb->ki_pos,
-						iocb->ki_pos + count - 1))
-				return -EAGAIN;
-		} else {
-			retval = filemap_write_and_wait_range(mapping,
-						iocb->ki_pos,
-					        iocb->ki_pos + count - 1);
-			if (retval < 0)
-				return retval;
-		}
-
+		retval = kiocb_write_and_wait(iocb, count);
+		if (retval < 0)
+			return retval;
 		file_accessed(file);
 
 		retval = mapping->a_ops->direct_IO(iocb, iter);
-- 
2.39.2

