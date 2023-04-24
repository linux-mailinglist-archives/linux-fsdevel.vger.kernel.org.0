Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEA76EC586
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 07:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjDXFv5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 01:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbjDXFvf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 01:51:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967D64226;
        Sun, 23 Apr 2023 22:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Y0+yvpTOTD7M6v1Yq6rfSkRSonNSi3NR5WwAu/cW1ss=; b=ZQNPwJKfnD/XoJEl/XtSriZEb/
        qPTxNVzmqOnJMzTZ5iTdaf9XqBSw+BBu2uTCUsDMrzAjWPNC6D9SVDVDH6rgShfNoncH7mFyV3luD
        sxCPuCpJEwm0G0klK3ha3UCo2LmEucN7OYhH/wziwE8/fW14ToiwebLf+FpusKtDu6RpIeIvF8maX
        xPF4tsipjrrtTTnYVAfuLNG5qQXZUfgRHhaC4tq5yxrW3TuZiBF7KM9G8skbrq2iBZzLJMvdl05I+
        6PwoN1Mz5APQFRqOdoUiJWha+6Ca0DLyuFLok7PIf+C183kOeH+iqnbjhsdqjiAuEjiaZ4+/sXmAv
        QEucEtcw==;
Received: from [2001:4bb8:189:a74f:e8a5:5f73:6d2:23b8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pqp5R-00FP6k-2n;
        Mon, 24 Apr 2023 05:50:06 +0000
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
Subject: [PATCH 12/17] fuse: use direct_write_fallback
Date:   Mon, 24 Apr 2023 07:49:21 +0200
Message-Id: <20230424054926.26927-13-hch@lst.de>
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

Refator the fuse direct write code so that the fuse_perform_write
callig convention is simplified to match generic_perform_write and
it's updating ki_pos directly, and the generic direct_write_fallback
helper is used to consolidate buffered I/O fallback code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/fuse/file.c | 44 +++++++++++---------------------------------
 1 file changed, 11 insertions(+), 33 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index de37a3a06a7169..55b64dac175d68 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1280,13 +1280,13 @@ static inline unsigned int fuse_wr_pages(loff_t pos, size_t len,
 		     max_pages);
 }
 
-static ssize_t fuse_perform_write(struct kiocb *iocb,
-				  struct address_space *mapping,
-				  struct iov_iter *ii, loff_t pos)
+static ssize_t fuse_perform_write(struct kiocb *iocb, struct iov_iter *ii)
 {
+	struct address_space *mapping = iocb->ki_filp->f_mapping;
 	struct inode *inode = mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_inode *fi = get_fuse_inode(inode);
+	loff_t pos = iocb->ki_pos;
 	int err = 0;
 	ssize_t res = 0;
 
@@ -1329,7 +1329,10 @@ static ssize_t fuse_perform_write(struct kiocb *iocb,
 	fuse_write_update_attr(inode, pos, res);
 	clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
 
-	return res > 0 ? res : err;
+	if (!res)
+		return err;
+	iocb->ki_pos += res;
+	return res;
 }
 
 static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
@@ -1337,11 +1340,9 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
 	ssize_t written = 0;
-	ssize_t written_buffered = 0;
 	struct inode *inode = mapping->host;
 	ssize_t err;
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	loff_t endbyte = 0;
 
 	if (fc->writeback_cache) {
 		/* Update size (EOF optimization) and mode (SUID clearing) */
@@ -1378,35 +1379,12 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		goto out;
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
-		loff_t pos = iocb->ki_pos;
 		written = generic_file_direct_write(iocb, from);
-		if (written < 0 || !iov_iter_count(from))
-			goto out;
-
-		pos += written;
-
-		written_buffered = fuse_perform_write(iocb, mapping, from, pos);
-		if (written_buffered < 0) {
-			err = written_buffered;
-			goto out;
-		}
-		endbyte = pos + written_buffered - 1;
-
-		err = filemap_write_and_wait_range(file->f_mapping, pos,
-						   endbyte);
-		if (err)
-			goto out;
-
-		invalidate_mapping_pages(file->f_mapping,
-					 pos >> PAGE_SHIFT,
-					 endbyte >> PAGE_SHIFT);
-
-		written += written_buffered;
-		iocb->ki_pos = pos + written_buffered;
+		if (written >= 0 && iov_iter_count(from))
+			written = direct_write_fallback(iocb, from, written,
+					fuse_perform_write(iocb, from));
 	} else {
-		written = fuse_perform_write(iocb, mapping, from, iocb->ki_pos);
-		if (written >= 0)
-			iocb->ki_pos += written;
+		written = fuse_perform_write(iocb, from);
 	}
 out:
 	current->backing_dev_info = NULL;
-- 
2.39.2

