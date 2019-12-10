Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1025119253
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 21:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfLJUnM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 15:43:12 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45653 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfLJUnM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:43:12 -0500
Received: by mail-pf1-f193.google.com with SMTP id 2so396992pfg.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2019 12:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2SQjS8rVUv97zNNTlgrJhbpMsmZd4fG/GoKGJP3eAKE=;
        b=t2EO6d99lKmXKYbF+NcjG6pdHmpetEgBemcsUMAZpxUWm7dMEgHzErpLj84RMbVrrl
         q/YULpcGkowi/C3ioWRByVsTfGmmHPQjvwfgulTU89mv06fY2WB4W/a7mCZSg22V+bfe
         ff9gBdeA4CJCzWrBqh5lBnY3AsmwPzhMv6uvSs85/FBK89HWrICDl4rlw4IU8xL2vrJY
         3HxZehgc5WnbXKJ44rXgtVFgz9AOZaGIQj8XsTmYx/tE+nlE4Hax7kpyxN92mqEDaEFD
         dm8pbha9xoq38chqU+5CbXVZf2Q7+Pae2g6uhL3cc5lt4m6JcvNnPyfzmATr07Z3ipvJ
         Pisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2SQjS8rVUv97zNNTlgrJhbpMsmZd4fG/GoKGJP3eAKE=;
        b=NCubpY7Gv1+ZrwuJ1L/eXE4L0zJPbP4nGgqNNT8tb/zqxojjnx+a8jKXMQ28O+yH/6
         Wt6IeYRtUG7g12bfOpuXLMThZQAwZZw/Rkp5ViUMCacecMDeTERXo6pq1dCnyJtlgn1M
         76trn4kZwbOdjkNHW5URJvlAgW10u381AEMpcPCjpGdIohTRuTYKA+jndAwlrdzb9TSW
         /ObZixhzroIgo5Uz7COXa6B+Fl0BC2HzEfrAoduVG8Nznk3e7+z2j+iVs/zjVQYieKuV
         3uHMruBJwGrpFGt5UaqLrkb7iSrFXpQfcIp+ft7zLHIKxQOEkR3D6e24KbTFeMzpHH32
         vBCw==
X-Gm-Message-State: APjAAAWe2F0MUn6u9twO9bU6/V4RzdxA1VAEJXBKwc+ds3Av5N4Q6lio
        VR0LgeE6vpCGAF8WXehl5Itj/g==
X-Google-Smtp-Source: APXvYqzTgRoxT1fLICFSUMNjgAjkqur+0BZoxOJy8VbolZ0fnYC6tjjgUPCKXQO6qx3bnEMAKKrG3Q==
X-Received: by 2002:a63:4f54:: with SMTP id p20mr7421pgl.246.1576010591369;
        Tue, 10 Dec 2019 12:43:11 -0800 (PST)
Received: from x1.thefacebook.com ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id o15sm4387829pgf.2.2019.12.10.12.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 12:43:10 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     willy@infradead.org, clm@fb.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/5] mm: make generic_perform_write() take a struct kiocb
Date:   Tue, 10 Dec 2019 13:43:01 -0700
Message-Id: <20191210204304.12266-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210204304.12266-1-axboe@kernel.dk>
References: <20191210204304.12266-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Right now all callers pass in iocb->ki_pos, just pass in the iocb. This
is in preparation for using the iocb flags in generic_perform_write().

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/ceph/file.c     | 2 +-
 fs/ext4/file.c     | 2 +-
 fs/nfs/file.c      | 2 +-
 include/linux/fs.h | 3 ++-
 mm/filemap.c       | 8 +++++---
 5 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 11929d2bb594..096c009f188f 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1538,7 +1538,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		 * are pending vmtruncate. So write and vmtruncate
 		 * can not run at the same time
 		 */
-		written = generic_perform_write(file, from, pos);
+		written = generic_perform_write(file, from, iocb);
 		if (likely(written >= 0))
 			iocb->ki_pos = pos + written;
 		ceph_end_io_write(inode);
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 6a7293a5cda2..9ffb857765d5 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -249,7 +249,7 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
 		goto out;
 
 	current->backing_dev_info = inode_to_bdi(inode);
-	ret = generic_perform_write(iocb->ki_filp, from, iocb->ki_pos);
+	ret = generic_perform_write(iocb->ki_filp, from, iocb);
 	current->backing_dev_info = NULL;
 
 out:
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 8eb731d9be3e..d8f51a702a4e 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -624,7 +624,7 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 	result = generic_write_checks(iocb, from);
 	if (result > 0) {
 		current->backing_dev_info = inode_to_bdi(inode);
-		result = generic_perform_write(file, from, iocb->ki_pos);
+		result = generic_perform_write(file, from, iocb);
 		current->backing_dev_info = NULL;
 	}
 	nfs_end_io_write(inode);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 092ea2a4319b..bf58db1bc032 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3103,7 +3103,8 @@ extern ssize_t generic_file_read_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t __generic_file_write_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t generic_file_write_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t generic_file_direct_write(struct kiocb *, struct iov_iter *);
-extern ssize_t generic_perform_write(struct file *, struct iov_iter *, loff_t);
+extern ssize_t generic_perform_write(struct file *, struct iov_iter *,
+				     struct kiocb *);
 
 ssize_t vfs_iter_read(struct file *file, struct iov_iter *iter, loff_t *ppos,
 		rwf_t flags);
diff --git a/mm/filemap.c b/mm/filemap.c
index ed23a11b3e34..fe37bd2b2630 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3302,10 +3302,11 @@ struct page *grab_cache_page_write_begin(struct address_space *mapping,
 EXPORT_SYMBOL(grab_cache_page_write_begin);
 
 ssize_t generic_perform_write(struct file *file,
-				struct iov_iter *i, loff_t pos)
+				struct iov_iter *i, struct kiocb *iocb)
 {
 	struct address_space *mapping = file->f_mapping;
 	const struct address_space_operations *a_ops = mapping->a_ops;
+	loff_t pos = iocb->ki_pos;
 	long status = 0;
 	ssize_t written = 0;
 	unsigned int flags = 0;
@@ -3439,7 +3440,8 @@ ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		if (written < 0 || !iov_iter_count(from) || IS_DAX(inode))
 			goto out;
 
-		status = generic_perform_write(file, from, pos = iocb->ki_pos);
+		pos = iocb->ki_pos;
+		status = generic_perform_write(file, from, iocb);
 		/*
 		 * If generic_perform_write() returned a synchronous error
 		 * then we want to return the number of bytes which were
@@ -3471,7 +3473,7 @@ ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			 */
 		}
 	} else {
-		written = generic_perform_write(file, from, iocb->ki_pos);
+		written = generic_perform_write(file, from, iocb);
 		if (likely(written > 0))
 			iocb->ki_pos += written;
 	}
-- 
2.24.0

