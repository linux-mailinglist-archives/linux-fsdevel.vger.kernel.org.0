Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96AC9312D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 18:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfEaQrX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 12:47:23 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40685 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbfEaQrW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 12:47:22 -0400
Received: by mail-wm1-f67.google.com with SMTP id u16so1107745wmc.5;
        Fri, 31 May 2019 09:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GmLRwLyr1TL2SZV/3Hd0cBEDiPM6bKDbyVa4EFRX9Nw=;
        b=tRhizwQUhrX+aMyNwadDebnZmz5EGLojFJbg/LvY+WEbk+XlLXHoxRHmmGytYm/NUW
         73hrgn+WmYuXQAYRnzb/NzC9Pf259gT8xVUdkLXr2kcSAV5kJl19PcV0UZlYD75/EwZk
         JPEIvN9Iq238lc82xLRf/Pc6f/Hi4motCGr4x3pjXjsVAyyIA/Cv7jyjLz29LVFVzddk
         q2/i1cxnMNlKAHSOcoBJwgOjcVdGOspDEZEHYUjejVmDj9Dvg7nMqDEqWsw3tWdMIvXi
         SpGFGR3YL5mFmR2smqs8Q/i6pc7y6H3cXrLg86KDGMmf/svdQEjREPMxR93PdcVH63uv
         IdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GmLRwLyr1TL2SZV/3Hd0cBEDiPM6bKDbyVa4EFRX9Nw=;
        b=EQqaQJEsR1/Gbdp/cnz3KV9VtEit8U0jx9nOR/r6f4xCmWLQ14MIntPF2stzVcMnAA
         X12tIm6pw9haaFXjfsXz8eJcRKN5FAxYpKIYKDixPeG3+LsAmtXRLW0t5KGtakqGMaqW
         YxxtxdRwoROCb4wGuJV9yYFokNbrfVBTwG5OiN6lGXAeAmLgYPX/mARm6+l7bxSg4k4k
         NDCWQHSgYSjZoEiH33zUzlCEtvzZvDOwOby77b5i3yGvXzflmA+m6BnFfFMJed6KbkSR
         FDJdCipVHPyHEMuQHe9u+MhDjsUC3Mq9rnw1dqKD5hluyYzBGKxk3Jvr9TYTiIAIWl4W
         vLtA==
X-Gm-Message-State: APjAAAXg1GaxCflGpNB6Fmdt2t1fMIvgeZSQMzvXFs/b2354ksysuGpd
        v2naoEwD0K6dsZH3Ldp0n5w=
X-Google-Smtp-Source: APXvYqx4DhdAGt74ECyqU8faH377pazZGlGYfEzIKGE6g7bwR6OOr+jqfTSunXQ0eDP/29u+PaCTPQ==
X-Received: by 2002:a7b:c043:: with SMTP id u3mr5757205wmc.56.1559321238387;
        Fri, 31 May 2019 09:47:18 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id n5sm7669593wrj.27.2019.05.31.09.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 09:47:17 -0700 (PDT)
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
Subject: [PATCH v4 5/9] vfs: add missing checks to copy_file_range
Date:   Fri, 31 May 2019 19:46:57 +0300
Message-Id: <20190531164701.15112-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531164701.15112-1-amir73il@gmail.com>
References: <20190531164701.15112-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Like the clone and dedupe interfaces we've recently fixed, the
copy_file_range() implementation is missing basic sanity, limits and
boundary condition tests on the parameters that are passed to it
from userspace. Create a new "generic_copy_file_checks()" function
modelled on the generic_remap_checks() function to provide this
missing functionality.

[Amir] Shorten copy length instead of checking pos_in limits
because input file size already abides by the limits.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/read_write.c    |  3 ++-
 include/linux/fs.h |  3 +++
 mm/filemap.c       | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index f1900bdb3127..b0fb1176b628 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1626,7 +1626,8 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 	if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
 		return -EXDEV;
 
-	ret = generic_file_rw_checks(file_in, file_out);
+	ret = generic_copy_file_checks(file_in, pos_in, file_out, pos_out, &len,
+				       flags);
 	if (unlikely(ret))
 		return ret;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 89b9b73eb581..e4d382c4342a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3050,6 +3050,9 @@ extern int generic_remap_checks(struct file *file_in, loff_t pos_in,
 				struct file *file_out, loff_t pos_out,
 				loff_t *count, unsigned int remap_flags);
 extern int generic_file_rw_checks(struct file *file_in, struct file *file_out);
+extern int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
+				    struct file *file_out, loff_t pos_out,
+				    size_t *count, unsigned int flags);
 extern ssize_t generic_file_read_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t __generic_file_write_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t generic_file_write_iter(struct kiocb *, struct iov_iter *);
diff --git a/mm/filemap.c b/mm/filemap.c
index 44361928bbb0..aac71aef4c61 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3056,6 +3056,59 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
 	return 0;
 }
 
+/*
+ * Performs necessary checks before doing a file copy
+ *
+ * Can adjust amount of bytes to copy via @req_count argument.
+ * Returns appropriate error code that caller should return or
+ * zero in case the copy should be allowed.
+ */
+int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
+			     struct file *file_out, loff_t pos_out,
+			     size_t *req_count, unsigned int flags)
+{
+	struct inode *inode_in = file_inode(file_in);
+	struct inode *inode_out = file_inode(file_out);
+	uint64_t count = *req_count;
+	loff_t size_in;
+	int ret;
+
+	ret = generic_file_rw_checks(file_in, file_out);
+	if (ret)
+		return ret;
+
+	/* Don't touch certain kinds of inodes */
+	if (IS_IMMUTABLE(inode_out))
+		return -EPERM;
+
+	if (IS_SWAPFILE(inode_in) || IS_SWAPFILE(inode_out))
+		return -ETXTBSY;
+
+	/* Ensure offsets don't wrap. */
+	if (pos_in + count < pos_in || pos_out + count < pos_out)
+		return -EOVERFLOW;
+
+	/* Shorten the copy to EOF */
+	size_in = i_size_read(inode_in);
+	if (pos_in >= size_in)
+		count = 0;
+	else
+		count = min(count, size_in - (uint64_t)pos_in);
+
+	ret = generic_write_check_limits(file_out, pos_out, &count);
+	if (ret)
+		return ret;
+
+	/* Don't allow overlapped copying within the same file. */
+	if (inode_in == inode_out &&
+	    pos_out + count > pos_in &&
+	    pos_out < pos_in + count)
+		return -EINVAL;
+
+	*req_count = count;
+	return 0;
+}
+
 int pagecache_write_begin(struct file *file, struct address_space *mapping,
 				loff_t pos, unsigned len, unsigned flags,
 				struct page **pagep, void **fsdata)
-- 
2.17.1

