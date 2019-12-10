Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80E34118D83
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 17:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfLJQZB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 11:25:01 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44595 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbfLJQZA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 11:25:00 -0500
Received: by mail-io1-f65.google.com with SMTP id z23so19356470iog.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2019 08:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2SQjS8rVUv97zNNTlgrJhbpMsmZd4fG/GoKGJP3eAKE=;
        b=KdJPrK92FyMA/n5MuNfAlPHd0oImSTZlalWyF+0fuBSmXkKu6+diP7+rdBUbGQpZkk
         7JPPl86po9n4aQWQLulc8QiRtO0Sp/qDEcuDRd5TS3VvNXvwp6XS/k+pfbmLHDxWl2f+
         AAKVBkYYp9wj6E26MnzpxXrurr2jWtRi0TKky9UukdjDoA7/GdXM6YtsmCFoJ2+Mmr4I
         XbBcEuaesRjidUVjkNZj6QnpApK1tyWIMPyHHOG7cykF3oHdn2wyrzrk0JwXwBC10ZG8
         YNj/QjZkJrssiZZ4EG+YJDYt62y/slOIEv53rD8vHwtBEUZjxJpCV8Qo1jklJy+34ySs
         iP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2SQjS8rVUv97zNNTlgrJhbpMsmZd4fG/GoKGJP3eAKE=;
        b=m1JnMoQB2jd9sQardxOi/YFWrV4s1dRQolPJD6sT5TjZJWbMW2eTkODqXlaBgR5dAV
         0TpJsF2Rc/nre5AiiAvezSaVFndKnjI/ed1gh4VIzynrcrwmOZn8kh5sgfIr2BAKcb0O
         +XyivPBeNVKX/jyy5P6PbS0vP/yZYGF4/qHRwDok61k0EFWre/lc8CiOGoDSf8S1W7Kw
         Ia7+6TIhOXQ76i20NePFZW6urfJJxEpaO4srtnW9+8SpQDhzRHQU2wzRZYKZusChqwB/
         kzFiD4GWULZoCAbrDeu1750EsWe0k5LlOm8s7vPPvhUkuqrogu5IuRJoEs0arT87SpcH
         xoXw==
X-Gm-Message-State: APjAAAXMK/sXzKEkAloOEapimv2NdP4e/cxaKftRT7Hd5coDBQWBMGpX
        Tok4Orsesd+WVIfpwfFrwl58KA==
X-Google-Smtp-Source: APXvYqxLMClXfOrpqdQ+I1lUcEUYXE4y9owWqZYlmjE/yWxjL77FymqW+NlU+FpfZbH+AHoKbGInYA==
X-Received: by 2002:a5e:d617:: with SMTP id w23mr25169022iom.98.1575995099536;
        Tue, 10 Dec 2019 08:24:59 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y11sm791174iol.23.2019.12.10.08.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 08:24:58 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/5] mm: make generic_perform_write() take a struct kiocb
Date:   Tue, 10 Dec 2019 09:24:51 -0700
Message-Id: <20191210162454.8608-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210162454.8608-1-axboe@kernel.dk>
References: <20191210162454.8608-1-axboe@kernel.dk>
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

