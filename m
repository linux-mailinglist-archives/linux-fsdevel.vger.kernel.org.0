Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8254AD7F4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 20:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389258AbfJOSnP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 14:43:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35347 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389245AbfJOSnI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 14:43:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id p30so12672954pgl.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2019 11:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/DGeX/s/F7y1Ptg4TXfC149/3MNxfqpqB94L2lN+tho=;
        b=14vSyNX0fzDf9xngY1AfBlds+lZ2FMgpQ6oeFmWsWrEdx+Idny6JEU716Serthufy3
         qLzTc7wkNyAJ/7IRT1Njsimn3NbWdgg0ICOBELgJoR+GWwwUsSJmbKNeZx5fmu2Us/Ap
         L9R65uNRI/fkUFAzYRVIVr7ND98NMrVA/tvHl13/I+JkbO+CtftuwHg9poXQ+P8u7a1Z
         n4w4mvXw6vhFtiWVVHAcvq3QXG+EMb9oJfhiwkx0LPgVoJlL857xC1QNpSH70ZkfqyR9
         JSVZIQJ9/EAfzeKJEPY+ySXZiOOTMqZQe1dmDsvDWdNxHBimKI6h82RJ4powbqWfGCJ5
         D+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/DGeX/s/F7y1Ptg4TXfC149/3MNxfqpqB94L2lN+tho=;
        b=T3QI1j7Fd1etPZny35D/+8Yfk5bvMf09nLcWGWH4ZBcXgSuvd37xWZ4vvC1sqdY6F6
         Z43kMCzTp7yp4rxnHxLtUiSqdCpOAACM0Ba1aNiPES7sJB1f6xNCAYsY5qpP7uOvYKp2
         ImoobCGUUWLwkfz4xpOioBIs69dIYRsQVsfRwm4Dqiw7Yzx7hqKDiN36YfWt/zcCAcSR
         I3SYHTpFrD4fJsckRQ03KwMluOW4/gL+Dpv1tb7aHct63M/zh+0RGs6fh9Y0ZA4BNBtv
         59OqKMzDIYlin8TP2RzvmDVGxyxxJlK13PyPR53ZC33uukIqWqgRDGqdN6ec2uzZ2+JC
         PMqQ==
X-Gm-Message-State: APjAAAUu3QPaf+dipfLwHM16R45SYYnN4cFAXJ0lXfBWZk8K37km9JX9
        xMDIuz21MeqJosQGfOkJftWbgiTnxlM=
X-Google-Smtp-Source: APXvYqywC9a+xVFtPcV06leUtXOTMWAiybNplGHzlZII4ICbIq6sFGKGH4YHelYXDu92DH8tF0PqUQ==
X-Received: by 2002:a62:3387:: with SMTP id z129mr38560916pfz.253.1571164986127;
        Tue, 15 Oct 2019 11:43:06 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::2:3e5e])
        by smtp.gmail.com with ESMTPSA id z3sm40396pjd.25.2019.10.15.11.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 11:43:05 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        linux-api@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH v2 2/5] fs: add RWF_ENCODED for reading/writing compressed data
Date:   Tue, 15 Oct 2019 11:42:40 -0700
Message-Id: <7f98cf5409cf2b583cd5b3451fc739fd3428873b.1571164762.git.osandov@fb.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571164762.git.osandov@fb.com>
References: <cover.1571164762.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Btrfs supports transparent compression: data written by the user can be
compressed when written to disk and decompressed when read back.
However, we'd like to add an interface to write pre-compressed data
directly to the filesystem, and the matching interface to read
compressed data without decompressing it. This adds support for
so-called "encoded I/O" via preadv2() and pwritev2().

A new RWF_ENCODED flags indicates that a read or write is "encoded". If
this flag is set, iov[0].iov_base points to a struct encoded_iov which
is used for metadata: namely, the compression algorithm, unencoded
(i.e., decompressed) length, and what subrange of the unencoded data
should be used (needed for truncated or hole-punched extents and when
reading in the middle of an extent). For reads, the filesystem returns
this information; for writes, the caller provides it to the filesystem.
iov[0].iov_len must be set to sizeof(struct encoded_iov), which can be
used to extend the interface in the future. The remaining iovecs contain
the encoded extent.

Filesystems must indicate that they support encoded writes by setting
FMODE_ENCODED_IO in ->file_open().

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 include/linux/fs.h      | 14 +++++++
 include/uapi/linux/fs.h | 26 ++++++++++++-
 mm/filemap.c            | 82 ++++++++++++++++++++++++++++++++++-------
 3 files changed, 108 insertions(+), 14 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index e0d909d35763..54681f21e05e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -175,6 +175,9 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* File does not contribute to nr_files count */
 #define FMODE_NOACCOUNT		((__force fmode_t)0x20000000)
 
+/* File supports encoded IO */
+#define FMODE_ENCODED_IO	((__force fmode_t)0x40000000)
+
 /*
  * Flag for rw_copy_check_uvector and compat_rw_copy_check_uvector
  * that indicates that they should check the contents of the iovec are
@@ -314,6 +317,7 @@ enum rw_hint {
 #define IOCB_SYNC		(1 << 5)
 #define IOCB_WRITE		(1 << 6)
 #define IOCB_NOWAIT		(1 << 7)
+#define IOCB_ENCODED		(1 << 8)
 
 struct kiocb {
 	struct file		*ki_filp;
@@ -3088,6 +3092,11 @@ extern int sb_min_blocksize(struct super_block *, int);
 extern int generic_file_mmap(struct file *, struct vm_area_struct *);
 extern int generic_file_readonly_mmap(struct file *, struct vm_area_struct *);
 extern ssize_t generic_write_checks(struct kiocb *, struct iov_iter *);
+struct encoded_iov;
+extern int generic_encoded_write_checks(struct kiocb *, struct encoded_iov *);
+extern ssize_t check_encoded_read(struct kiocb *, struct iov_iter *);
+extern int import_encoded_write(struct kiocb *, struct encoded_iov *,
+				struct iov_iter *);
 extern int generic_remap_checks(struct file *file_in, loff_t pos_in,
 				struct file *file_out, loff_t pos_out,
 				loff_t *count, unsigned int remap_flags);
@@ -3403,6 +3412,11 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
 			return -EOPNOTSUPP;
 		ki->ki_flags |= IOCB_NOWAIT;
 	}
+	if (flags & RWF_ENCODED) {
+		if (!(ki->ki_filp->f_mode & FMODE_ENCODED_IO))
+			return -EOPNOTSUPP;
+		ki->ki_flags |= IOCB_ENCODED;
+	}
 	if (flags & RWF_HIPRI)
 		ki->ki_flags |= IOCB_HIPRI;
 	if (flags & RWF_DSYNC)
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 379a612f8f1d..ed92a8a257cb 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -284,6 +284,27 @@ struct fsxattr {
 
 typedef int __bitwise __kernel_rwf_t;
 
+enum {
+	ENCODED_IOV_COMPRESSION_NONE,
+	ENCODED_IOV_COMPRESSION_ZLIB,
+	ENCODED_IOV_COMPRESSION_LZO,
+	ENCODED_IOV_COMPRESSION_ZSTD,
+	ENCODED_IOV_COMPRESSION_TYPES = ENCODED_IOV_COMPRESSION_ZSTD,
+};
+
+enum {
+	ENCODED_IOV_ENCRYPTION_NONE,
+	ENCODED_IOV_ENCRYPTION_TYPES = ENCODED_IOV_ENCRYPTION_NONE,
+};
+
+struct encoded_iov {
+	__u64 len;
+	__u64 unencoded_len;
+	__u64 unencoded_offset;
+	__u32 compression;
+	__u32 encryption;
+};
+
 /* high priority request, poll if possible */
 #define RWF_HIPRI	((__force __kernel_rwf_t)0x00000001)
 
@@ -299,8 +320,11 @@ typedef int __bitwise __kernel_rwf_t;
 /* per-IO O_APPEND */
 #define RWF_APPEND	((__force __kernel_rwf_t)0x00000010)
 
+/* encoded (e.g., compressed or encrypted) IO */
+#define RWF_ENCODED	((__force __kernel_rwf_t)0x00000020)
+
 /* mask of flags supported by the kernel */
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
-			 RWF_APPEND)
+			 RWF_APPEND | RWF_ENCODED)
 
 #endif /* _UAPI_LINUX_FS_H */
diff --git a/mm/filemap.c b/mm/filemap.c
index 1146fcfa3215..d2e6d9caf353 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2948,24 +2948,15 @@ static int generic_write_check_limits(struct file *file, loff_t pos,
 	return 0;
 }
 
-/*
- * Performs necessary checks before doing a write
- *
- * Can adjust writing position or amount of bytes to write.
- * Returns appropriate error code that caller should return or
- * zero in case that write should be allowed.
- */
-inline ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
+static int generic_write_checks_common(struct kiocb *iocb, loff_t *count)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_mapping->host;
-	loff_t count;
-	int ret;
 
 	if (IS_SWAPFILE(inode))
 		return -ETXTBSY;
 
-	if (!iov_iter_count(from))
+	if (!*count)
 		return 0;
 
 	/* FIXME: this is for backwards compatibility with 2.4 */
@@ -2975,8 +2966,21 @@ inline ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	if ((iocb->ki_flags & IOCB_NOWAIT) && !(iocb->ki_flags & IOCB_DIRECT))
 		return -EINVAL;
 
-	count = iov_iter_count(from);
-	ret = generic_write_check_limits(file, iocb->ki_pos, &count);
+	return generic_write_check_limits(iocb->ki_filp, iocb->ki_pos, count);
+}
+
+/*
+ * Performs necessary checks before doing a write
+ *
+ * Can adjust writing position or amount of bytes to write.
+ * Returns a negative errno or the new number of bytes to write.
+ */
+inline ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
+{
+	loff_t count = iov_iter_count(from);
+	int ret;
+
+	ret = generic_write_checks_common(iocb, &count);
 	if (ret)
 		return ret;
 
@@ -2985,6 +2989,58 @@ inline ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
 }
 EXPORT_SYMBOL(generic_write_checks);
 
+int generic_encoded_write_checks(struct kiocb *iocb,
+				 struct encoded_iov *encoded)
+{
+	loff_t count = encoded->unencoded_len;
+	int ret;
+
+	ret = generic_write_checks_common(iocb, &count);
+	if (ret)
+		return ret;
+
+	if (count != encoded->unencoded_len) {
+		/*
+		 * The write got truncated by generic_write_checks_common(). We
+		 * can't do a partial encoded write.
+		 */
+		return -EFBIG;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(generic_encoded_write_checks);
+
+ssize_t check_encoded_read(struct kiocb *iocb, struct iov_iter *iter)
+{
+	if (!(iocb->ki_filp->f_flags & O_ENCODED))
+		return -EPERM;
+	if (iov_iter_single_seg_count(iter) != sizeof(struct encoded_iov))
+		return -EINVAL;
+	return iov_iter_count(iter) - sizeof(struct encoded_iov);
+}
+EXPORT_SYMBOL(check_encoded_read);
+
+int import_encoded_write(struct kiocb *iocb, struct encoded_iov *encoded,
+			 struct iov_iter *from)
+{
+	if (!(iocb->ki_filp->f_flags & O_ENCODED))
+		return -EPERM;
+	if (iov_iter_single_seg_count(from) != sizeof(*encoded))
+		return -EINVAL;
+	if (copy_from_iter(encoded, sizeof(*encoded), from) != sizeof(*encoded))
+		return -EFAULT;
+	if (encoded->compression == ENCODED_IOV_COMPRESSION_NONE &&
+	    encoded->encryption == ENCODED_IOV_ENCRYPTION_NONE)
+		return -EINVAL;
+	if (encoded->compression > ENCODED_IOV_COMPRESSION_TYPES ||
+	    encoded->encryption > ENCODED_IOV_ENCRYPTION_TYPES)
+		return -EINVAL;
+	if (encoded->unencoded_offset >= encoded->unencoded_len)
+		return -EINVAL;
+	return 0;
+}
+EXPORT_SYMBOL(import_encoded_write);
+
 /*
  * Performs necessary checks before doing a clone.
  *
-- 
2.23.0

