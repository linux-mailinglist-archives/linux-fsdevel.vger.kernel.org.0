Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625497093C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 11:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjESJil (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 05:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjESJhz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 05:37:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E98910C9;
        Fri, 19 May 2023 02:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=lKV8h274a8dJZYXDnZBnFaYep44iQbnn3gg/wqWXLcU=; b=cWIcWF+NCJsR16lt+GN3SyqYi8
        20m98Sg1zXHAv7DP2DoTSsINVBJLT/jPU8582VtWjlVAlPAxQNKVTFaC0YOnpEd5FvRMnBLi4ey94
        K4WsXk4K1iXMjE0WTmxaYPPuCk8QMzpH/S5exdIPqIWUyCVLjzR3cBZl2UWcus5acmbfLvwlunIjm
        4ycE2BJo+CC540gWRfo2M+hpyeOMIoCToQspTNQ3U/ipx7csq77R4XMThx+m4QCcDyjZBfA7VJFoS
        hKoo+WYpC8HvPYhP5WamSeG2WcUggfS4/afnmf7Abg1NQrcteg0tvokFZlTlL+/0VmwC02dijjfgF
        XYj4OTgA==;
Received: from [2001:4bb8:188:3dd5:e8d0:68bb:e5be:210a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzwWm-00Fjl7-2x;
        Fri, 19 May 2023 09:36:01 +0000
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
Subject: [PATCH 13/13] fuse: use direct_write_fallback
Date:   Fri, 19 May 2023 11:35:21 +0200
Message-Id: <20230519093521.133226-14-hch@lst.de>
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

Use the generic direct_write_fallback helper instead of duplicating the
logic.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/fuse/file.c | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 5f7b58798f99fc..02ab446ab57f1f 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1340,11 +1340,9 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
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
@@ -1382,28 +1380,9 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		written = generic_file_direct_write(iocb, from);
-		if (written < 0 || !iov_iter_count(from))
-			goto out;
-
-		written_buffered = fuse_perform_write(iocb, from);
-		if (written_buffered < 0) {
-			err = written_buffered;
-			goto out;
-		}
-		endbyte = iocb->ki_pos + written_buffered - 1;
-
-		err = filemap_write_and_wait_range(file->f_mapping,
-						   iocb->ki_pos,
-						   endbyte);
-		if (err)
-			goto out;
-
-		invalidate_mapping_pages(file->f_mapping,
-					 iocb->ki_pos >> PAGE_SHIFT,
-					 endbyte >> PAGE_SHIFT);
-
-		written += written_buffered;
-		iocb->ki_pos += written_buffered;
+		if (written >= 0 && iov_iter_count(from))
+			written = direct_write_fallback(iocb, from, written,
+					fuse_perform_write(iocb, from));
 	} else {
 		written = fuse_perform_write(iocb, from);
 	}
-- 
2.39.2

