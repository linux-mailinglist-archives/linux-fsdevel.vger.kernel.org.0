Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF55B2E37F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 19:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfE2Rne (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 13:43:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33882 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfE2Rnc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 13:43:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id f8so2421338wrt.1;
        Wed, 29 May 2019 10:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7z+URgKWKe9baBNXTRuiwAT8xxeo4lu6F54jeoU5vwA=;
        b=KirtEW/OGmn/qiY+9wme5Gh5KIVAoljOuFx+nMJamoVSeYIrxdiMzYn5QLUjJMNJI6
         uozf24MrBZM0dh6RM6ilar+ioPNQplygnIYbQIwa/ooqLWPqBuBrhlnV2e3V9HQ4h/U9
         XehykFGHiUsLCVmkzhfm/g2TAxLfNksM6q/YBky875wc79vfxcR/woBE98CUs3G1oZJD
         YwkLoRKuk/Piz4QruovX3eZYqXkGG8szNks90JbPDg8zJiAYTUAqJ/4w4TO0qDTuFFAn
         jrtwm0R+s8pM5yemqSKfFpK++gJfbK3DIbyxZfQfY74slW/PepSLQZFSEs5z6x0xMAoU
         +5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7z+URgKWKe9baBNXTRuiwAT8xxeo4lu6F54jeoU5vwA=;
        b=ddMImk2vUJtWqV1qabtcdIqysuUbwayZ5EOFZHOAlumZ4lzec7wM03HWvnIPIAuN5Y
         xT+QLeu1KJ21CZOu04ElVQxkpYtITOR1VMwBWBzb5Ow3kw9e7DYa3uUefljVwr+nHODU
         1Q8NqsdPCr2UlFtVzgRNODb9zn1xXOjUdTTW6ivfR/S6D7BuWbrORrSYz8wYxvlXvYKr
         pAzrVjuc84GWH0vPiF8dAtIGi9F0BnCay0cReA6sIDBs+TkY86d9jDgLahun0OkLJpF5
         n6NR3Cu2SgefkAO8NPieQpO6Baq0NS+b/0T+Boc5WBgYcQwz0sopHnQ2zbdqQrYfmJqD
         KXDA==
X-Gm-Message-State: APjAAAUQ8O8/W7qf6gvnsogKDFVx6LjS4qXdHha4UlNruS68uWBXEriY
        o1OcyO9vQ1l5ponwQ/iZH64=
X-Google-Smtp-Source: APXvYqyjgzK5zYt1nLkJV1PTASxLCO9v2WEdLQlqLK3u4kKgGoubOcok7hkiDoMtwj/6Q0nO7aqF6A==
X-Received: by 2002:adf:8bc5:: with SMTP id w5mr41103202wra.132.1559151809932;
        Wed, 29 May 2019 10:43:29 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id k125sm31702wmb.34.2019.05.29.10.43.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 10:43:29 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        linux-xfs@vger.kernel.org,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: [PATCH v3 01/13] vfs: introduce generic_copy_file_range()
Date:   Wed, 29 May 2019 20:43:05 +0300
Message-Id: <20190529174318.22424-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529174318.22424-1-amir73il@gmail.com>
References: <20190529174318.22424-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Right now if vfs_copy_file_range() does not use any offload
mechanism, it falls back to calling do_splice_direct(). This fails
to do basic sanity checks on the files being copied. Before we
start adding this necessarily functionality to the fallback path,
separate it out into generic_copy_file_range().

generic_copy_file_range() has the same prototype as
->copy_file_range() so that filesystems can use it in their custom
->copy_file_range() method if they so choose.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/read_write.c    | 35 ++++++++++++++++++++++++++++++++---
 include/linux/fs.h |  3 +++
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index c543d965e288..676b02fae589 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1565,6 +1565,36 @@ COMPAT_SYSCALL_DEFINE4(sendfile64, int, out_fd, int, in_fd,
 }
 #endif
 
+/**
+ * generic_copy_file_range - copy data between two files
+ * @file_in:	file structure to read from
+ * @pos_in:	file offset to read from
+ * @file_out:	file structure to write data to
+ * @pos_out:	file offset to write data to
+ * @len:	amount of data to copy
+ * @flags:	copy flags
+ *
+ * This is a generic filesystem helper to copy data from one file to another.
+ * It has no constraints on the source or destination file owners - the files
+ * can belong to different superblocks and different filesystem types. Short
+ * copies are allowed.
+ *
+ * This should be called from the @file_out filesystem, as per the
+ * ->copy_file_range() method.
+ *
+ * Returns the number of bytes copied or a negative error indicating the
+ * failure.
+ */
+
+ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
+				struct file *file_out, loff_t pos_out,
+				size_t len, unsigned int flags)
+{
+	return do_splice_direct(file_in, &pos_in, file_out, &pos_out,
+				len > MAX_RW_COUNT ? MAX_RW_COUNT : len, 0);
+}
+EXPORT_SYMBOL(generic_copy_file_range);
+
 /*
  * copy_file_range() differs from regular file read and write in that it
  * specifically allows return partial success.  When it does so is up to
@@ -1632,9 +1662,8 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 			goto done;
 	}
 
-	ret = do_splice_direct(file_in, &pos_in, file_out, &pos_out,
-			len > MAX_RW_COUNT ? MAX_RW_COUNT : len, 0);
-
+	ret = generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
+				      flags);
 done:
 	if (ret > 0) {
 		fsnotify_access(file_in);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f7fdfe93e25d..ea17858310ff 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1889,6 +1889,9 @@ extern ssize_t vfs_readv(struct file *, const struct iovec __user *,
 		unsigned long, loff_t *, rwf_t);
 extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
 				   loff_t, size_t, unsigned int);
+extern ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
+				       struct file *file_out, loff_t pos_out,
+				       size_t len, unsigned int flags);
 extern int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 					 struct file *file_out, loff_t pos_out,
 					 loff_t *count,
-- 
2.17.1

