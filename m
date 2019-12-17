Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFCD122EF4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 15:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbfLQOjz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 09:39:55 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34576 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbfLQOjy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:39:54 -0500
Received: by mail-io1-f67.google.com with SMTP id z193so7707406iof.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 06:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eKvsGoetsIcjvq9qtw7wq8EOlHDh0dLtS5dcS2crnAM=;
        b=2T6/KvYQuQLJXZ7z69OfzRHfUkIi00yPsJDIgAwSi0vvuhijjnSfxE68no83S8niWu
         4jzOvLSgX/c7gaxyBryaYuILa6HvnP+6BHist5GL9yIZAkFEkCd8+cSblazxNaVhiqcv
         lwZZcg+Ks/yuF1Gm4gOtk+hZKVJcM0Qz6+lpMD1mMWZsqYYqPfStQ6Vj0kmPNZVJrnnv
         5T7Px6Qvf4gmwW81lJw98OofW81TjYZFDOT1up8o63YqZ8IBEohTcpk56PkgqTPwO/c8
         C06udPw6lIKChQqvmExmfG604lXCIcMoo3fcfguwOup6upWiqBrUA3BH+twqfs/XpiHj
         5btQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eKvsGoetsIcjvq9qtw7wq8EOlHDh0dLtS5dcS2crnAM=;
        b=gvKnzcXabayWAHhilJd7+8ADCSCGI7y3f8J8en5IizvibD45Lop5pakdIO+oIXEoAD
         5Xuo+sJEImPF5AibafZ3e+iDwt4Skyo2VtP2GEYdfVv84hjhy+BG0thIviWdg/auTIrR
         4YEjbvsBoEEuLMFYxUDpcOa4zuuuSkcaWE/W4NXaf5DMF6DFGJqgltkINMvWEg0APQOu
         UggqBFRqjllXLhS+0rzmUfrUNHUveUXAfgJ6LPAbEn8DblHA9WbtSE6QIae9K/UDOnCc
         KHQiMTp+DwKlSXTVBthDXotGLAjknldZ7YixCvFFohe0sW5T+ZUmZPqMVN7qIolwX+bf
         sejw==
X-Gm-Message-State: APjAAAVnAKJ82EG9ZzSEE1RGNM/E5K95x3fsmxhd6ZXTaummII8G+PN1
        tXRqH1n12cSriKSLDBKOOIzJkA==
X-Google-Smtp-Source: APXvYqxMdQvhXZ9Q18XgGJtSH0yvOWY1lHHyKek4U1CcHUB2OSSyfo2zR9Bt8k43JQ6faNwcUtoHvg==
X-Received: by 2002:a6b:ed15:: with SMTP id n21mr1525183iog.128.1576593593105;
        Tue, 17 Dec 2019 06:39:53 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w21sm5285255ioc.34.2019.12.17.06.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 06:39:52 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     willy@infradead.org, clm@fb.com, torvalds@linux-foundation.org,
        david@fromorbit.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/6] mm: make generic_perform_write() take a struct kiocb
Date:   Tue, 17 Dec 2019 07:39:44 -0700
Message-Id: <20191217143948.26380-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217143948.26380-1-axboe@kernel.dk>
References: <20191217143948.26380-1-axboe@kernel.dk>
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
index 7ddc4d8386cf..522152ed86d8 100644
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

