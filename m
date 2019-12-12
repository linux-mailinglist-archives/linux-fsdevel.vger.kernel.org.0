Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6185111D68F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 20:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbfLLTBl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 14:01:41 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:36965 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730261AbfLLTBl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 14:01:41 -0500
Received: by mail-il1-f195.google.com with SMTP id t9so2954771iln.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2019 11:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fbpmMkO7cF3l0nX3uMERV011BvImxrSyna50D9UZcqY=;
        b=rE2OUvxuQQR9e+OCoGeKlkc1cUF+15y3F4LLwx3WdT9h9LKQx9Didy7wYh+VA3fSF7
         +kBrzd+B6vQBJ0BrZhLXL5rA1NJtQb1kW55UJegziee7iRIJmTwOZof3aRylNyXxDQE/
         9NInFTkvbNMXc/kGMTruW1JYbiZlao4XdqjBv44yo0w9Nsoz+b8GvVSzNGWSO9pZ9KCi
         eryZPEPld3a91/bVkFB8/ZmFKbm8VB5H3+AlH/E+v/ywydEuAbDKyIcI5rxTFnd2AsLe
         EJQOubuj/XMvejkd3wuiuhsBsbnsxPEwo2TeWY//2ctQl8ezMe9JqMTrm393hK/J0Xhy
         ihVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fbpmMkO7cF3l0nX3uMERV011BvImxrSyna50D9UZcqY=;
        b=LszUqR7+2Q0H+XFdDt80r3hpR7qX5dzsQR/w99iSP2sRbdfMG8Hd7rn/Tp8xzMz0qY
         4fDYzsroc3egeibZeuZuG6agWOs3fHwfi8lhnaAgXRw4Elm+pFerxtAphXKaqfpl5aMu
         bLpY7BHlWs32fIwXziGMEbPDxsb6VxGDGDFnP2HDxT4/85izuHBzIelsY56QzILyiNiT
         S/n5dC0xfh6BdQUAVwlwUZrl0HLo8gHPD0fe9KemNHWIgyFdsvpGiWUm+LKa3dur4EoP
         EWYRrBdqGr+9np5UOHao/lOMNNveG3+BJI99uRg1WuPisQiwZy8G3PXNG6wSjhaBLT1X
         6N0A==
X-Gm-Message-State: APjAAAX18PUdzn0Cfoo9OBkEEhWAvYfl3aWzV3KHocz1YI1ylQw3YbdN
        a4ugAFZ+xbK8Byd4BgZRo4aOfA==
X-Google-Smtp-Source: APXvYqyITTmNy4tNYMAf6rKh/QJj2zfjnSElNIDEYONualw6iMY3maR+LVOkyIy1eJVakzqREBT76g==
X-Received: by 2002:a92:b657:: with SMTP id s84mr8881028ili.253.1576177300212;
        Thu, 12 Dec 2019 11:01:40 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id i22sm1957745ill.40.2019.12.12.11.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 11:01:39 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     willy@infradead.org, clm@fb.com, torvalds@linux-foundation.org,
        david@fromorbit.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/5] mm: make generic_perform_write() take a struct kiocb
Date:   Thu, 12 Dec 2019 12:01:30 -0700
Message-Id: <20191212190133.18473-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191212190133.18473-1-axboe@kernel.dk>
References: <20191212190133.18473-1-axboe@kernel.dk>
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
index 5d299d69b185..00b8e87fb9cf 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3292,10 +3292,11 @@ struct page *grab_cache_page_write_begin(struct address_space *mapping,
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
@@ -3429,7 +3430,8 @@ ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		if (written < 0 || !iov_iter_count(from) || IS_DAX(inode))
 			goto out;
 
-		status = generic_perform_write(file, from, pos = iocb->ki_pos);
+		pos = iocb->ki_pos;
+		status = generic_perform_write(file, from, iocb);
 		/*
 		 * If generic_perform_write() returned a synchronous error
 		 * then we want to return the number of bytes which were
@@ -3461,7 +3463,7 @@ ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			 */
 		}
 	} else {
-		written = generic_perform_write(file, from, iocb->ki_pos);
+		written = generic_perform_write(file, from, iocb);
 		if (likely(written > 0))
 			iocb->ki_pos += written;
 	}
-- 
2.24.1

