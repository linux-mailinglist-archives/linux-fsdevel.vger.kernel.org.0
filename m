Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8772E3BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 19:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfE2Rnm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 13:43:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52228 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbfE2Rnk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 13:43:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id y3so2250518wmm.2;
        Wed, 29 May 2019 10:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2/CP2IvvJS5kHF334Ic9jdZBlmRYc6Ue8s+vgRNa/1Q=;
        b=upnAf8myIrx2pKteVhF2+kpe+Nin2P5mBATst2HHhtqTY7ITAXJxECpcP1rsy1A1qb
         4yHOqCcseIcjx00JRyTDaCJrR7tOa22IqD6U1us6DA5jRAfL6cpAFVwFMZA9WGLoJb9M
         +31KnfTQQZJ18UBBXuhMt3DRWUyfmsUx1m0ps05SPcUvrQqtMmMiv4CcGj4Cn+6U3IOR
         hOaDgCK9d4KUIBq6jrb35lwb1aZYr8T2+HN1xyvTkD1aAo5onz/HGLDUp9l8ytbcXzr0
         ubdvUyAtvEJs0Ky/vhGXKnYfok5g/mHlZfxX/nYLpQTyZfmvSXXW8vubw5XzO4+itBmu
         IwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2/CP2IvvJS5kHF334Ic9jdZBlmRYc6Ue8s+vgRNa/1Q=;
        b=KnIM3QRLBIFWbH2bHpXnJi+B9nK3n/p76H3RgQoQ51tFFsOyCO6WFODllls9gVqKGf
         xTLr3Q/mFj8Ugk8MF47H9XZEhjv0RDxTrvt7UlIMZzKaBnVLKBYElDjpaP8NGQoVO0/z
         RVgy7DqGdnG396ihqKnDZtBU8pFYIcz7YtJKuWWjeKBXgMIz1g6IqLJsrjNYPLDF9Myx
         gYmO4rrFC2um6hbbJO97vNV5oXx3tpUpmhT+xK1kLobJGoH8axAW2umMVxH3KqRy27bO
         LGa3paxhN/gYB5TvtvknWuyVZzaFxIGIM9FHS23RLiDo3VBGMqiSz8SKM9xpMBLhOsSw
         N/qg==
X-Gm-Message-State: APjAAAUNrBJeQ9SH/01ptoPQzbluW7MoRbORtD8kwB5PkR/CD7XS2qnh
        Eex8ArTxa+Xpvl3HEYVi3dRrCcurRU0=
X-Google-Smtp-Source: APXvYqyeRXP+ushjMp0sko4DG5SCcZdemIdjPmQZqrRvr76nJTW+ebE4dTcExW9j+EVS8IBrj5eQJw==
X-Received: by 2002:a1c:eb0c:: with SMTP id j12mr7503521wmh.55.1559151817888;
        Wed, 29 May 2019 10:43:37 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id k125sm31702wmb.34.2019.05.29.10.43.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 10:43:37 -0700 (PDT)
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
Subject: [PATCH v3 05/13] vfs: add missing checks to copy_file_range
Date:   Wed, 29 May 2019 20:43:09 +0300
Message-Id: <20190529174318.22424-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529174318.22424-1-amir73il@gmail.com>
References: <20190529174318.22424-1-amir73il@gmail.com>
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

