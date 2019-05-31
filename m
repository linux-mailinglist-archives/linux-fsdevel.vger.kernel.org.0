Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10FCE312C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 18:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfEaQrO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 12:47:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50705 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfEaQrN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 12:47:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id f204so2453641wme.0;
        Fri, 31 May 2019 09:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7z+URgKWKe9baBNXTRuiwAT8xxeo4lu6F54jeoU5vwA=;
        b=LFLr6fmpK1pv59BZ5pGUGCOjYzE4yp97eEuGDDRdFTBA5bMeUpACnEKw54TdDVG58q
         Gz2KSF+rmusjkhvqwlDCfYITVnz+L4I7qgTMmNnJYQwZmcsoXXGkedodYGm/b5vlsq7q
         QI1bnRvTW1AYYo4ucUYJQw6pDrPLEOGJLU+XGp1i1HeDDZiP5/zfDM/qX8/9MGwCYy07
         LnQ+x7BaBb32uenPLaHeXumiEacQ9shNbhdxfNEtV7eUhsVS4bD8uP17SuGbUrfyj/ej
         ea3QyVOYRKZJUEJWyDmsRCCC+lX/1AhYgSmhqz8thB8aj1sZL6dZ4d6VCCSqQXu5fHED
         j+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7z+URgKWKe9baBNXTRuiwAT8xxeo4lu6F54jeoU5vwA=;
        b=E5vNR6YikYgL+3bUQhTtTa6RsQ+rHjhg1GJEy+2WmFX+A/yaejGsCNIkmAeSUdm3rJ
         tX4fDg12SVi8aAymFCrIQhWl3iDvv4jD5RrnMSu4UU8vF59SKm01UR8OFNLSNoLPRd97
         NpjjQdQJ8MYmLKDuKHcGt+bgM+PCvyHau7ba4WEpsq/ah1AioTlUZrtGSJCnNwYHfSiI
         LzLAKAJ54jRqg3j5CYakMHy1TPJY4ZDrbyY+LSohZql9eZkY41YIPm71Ei5d3GSx3gUI
         Zo+G/pTUut0fMtOYdmm5cwqTmbnNvVPJbfieP5jpgAeN2jelpqjzXNbGmvPWK0R2xuU7
         Jj+g==
X-Gm-Message-State: APjAAAWvF6TFUggC1pr9XfuAeMf+c4WIQzEKSZmBSYQq3sX+TBh+MMGt
        BU+/SBNj1ec5kj8j7MIXdbA=
X-Google-Smtp-Source: APXvYqz3T4EEheFeEouY+WuKNMAIR95jioZXVsKQWFBS1fa+ziG4bTL0aCq8vUDOoku1rSk0AKcxlg==
X-Received: by 2002:a1c:f606:: with SMTP id w6mr6665229wmc.130.1559321230954;
        Fri, 31 May 2019 09:47:10 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id n5sm7669593wrj.27.2019.05.31.09.47.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 09:47:10 -0700 (PDT)
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
Subject: [PATCH v4 1/9] vfs: introduce generic_copy_file_range()
Date:   Fri, 31 May 2019 19:46:53 +0300
Message-Id: <20190531164701.15112-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531164701.15112-1-amir73il@gmail.com>
References: <20190531164701.15112-1-amir73il@gmail.com>
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

