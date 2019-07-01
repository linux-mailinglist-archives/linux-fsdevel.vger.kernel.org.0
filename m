Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA6DB5C036
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 17:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbfGAPeZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 11:34:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729443AbfGAPeI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 11:34:08 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A361D2184C;
        Mon,  1 Jul 2019 15:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561995248;
        bh=0hPtZ5ATLcwZg69TymZau8/2PrUXxseXmNOiyD/GVSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QrdQcOz8heVitF8EJx6T3cP/4SyZN7WNpyQs1YGrgMIKt5b3i72pAfBJHgxOiAI3c
         na1QpNm0KiKl5PMfhjsxCubUMo7KIumvu5UB4BysRXMv+uf5b8r8ia492qNvx9V2nA
         L6fCkNhvaww6kMR7eRZvriVTIYaEPld9c99mvV3w=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v6 11/17] fs-verity: implement FS_IOC_MEASURE_VERITY ioctl
Date:   Mon,  1 Jul 2019 08:32:31 -0700
Message-Id: <20190701153237.1777-12-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190701153237.1777-1-ebiggers@kernel.org>
References: <20190701153237.1777-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add a function for filesystems to call to implement the
FS_IOC_MEASURE_VERITY ioctl.  This ioctl retrieves the file measurement
that fs-verity calculated for the given file and is enforcing for reads;
i.e., reads that don't match this hash will fail.  This ioctl can be
used for authentication or logging of file measurements in userspace.

See the "FS_IOC_MEASURE_VERITY" section of
Documentation/filesystems/fsverity.rst for the documentation.

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/verity/Makefile       |  1 +
 fs/verity/measure.c      | 57 ++++++++++++++++++++++++++++++++++++++++
 include/linux/fsverity.h | 11 ++++++++
 3 files changed, 69 insertions(+)
 create mode 100644 fs/verity/measure.c

diff --git a/fs/verity/Makefile b/fs/verity/Makefile
index 04b37475fd28..6f7675ae0a31 100644
--- a/fs/verity/Makefile
+++ b/fs/verity/Makefile
@@ -3,5 +3,6 @@
 obj-$(CONFIG_FS_VERITY) += enable.o \
 			   hash_algs.o \
 			   init.o \
+			   measure.o \
 			   open.o \
 			   verify.o
diff --git a/fs/verity/measure.c b/fs/verity/measure.c
new file mode 100644
index 000000000000..05049b68c745
--- /dev/null
+++ b/fs/verity/measure.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * fs/verity/measure.c: ioctl to get a verity file's measurement
+ *
+ * Copyright 2019 Google LLC
+ */
+
+#include "fsverity_private.h"
+
+#include <linux/uaccess.h>
+
+/**
+ * fsverity_ioctl_measure() - get a verity file's measurement
+ *
+ * Retrieve the file measurement that the kernel is enforcing for reads from a
+ * verity file.  See the "FS_IOC_MEASURE_VERITY" section of
+ * Documentation/filesystems/fsverity.rst for the documentation.
+ *
+ * Return: 0 on success, -errno on failure
+ */
+int fsverity_ioctl_measure(struct file *filp, void __user *_uarg)
+{
+	const struct inode *inode = file_inode(filp);
+	struct fsverity_digest __user *uarg = _uarg;
+	const struct fsverity_info *vi;
+	const struct fsverity_hash_alg *hash_alg;
+	struct fsverity_digest arg;
+
+	vi = fsverity_get_info(inode);
+	if (!vi)
+		return -ENODATA; /* not a verity file */
+	hash_alg = vi->tree_params.hash_alg;
+
+	/*
+	 * The user specifies the digest_size their buffer has space for; we can
+	 * return the digest if it fits in the available space.  We write back
+	 * the actual size, which may be shorter than the user-specified size.
+	 */
+
+	if (get_user(arg.digest_size, &uarg->digest_size))
+		return -EFAULT;
+	if (arg.digest_size < hash_alg->digest_size)
+		return -EOVERFLOW;
+
+	memset(&arg, 0, sizeof(arg));
+	arg.digest_algorithm = hash_alg - fsverity_hash_algs;
+	arg.digest_size = hash_alg->digest_size;
+
+	if (copy_to_user(uarg, &arg, sizeof(arg)))
+		return -EFAULT;
+
+	if (copy_to_user(uarg->digest, vi->measurement, hash_alg->digest_size))
+		return -EFAULT;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fsverity_ioctl_measure);
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index b0b1854a9450..9ebb97c174c7 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -116,6 +116,10 @@ static inline struct fsverity_info *fsverity_get_info(const struct inode *inode)
 
 extern int fsverity_ioctl_enable(struct file *filp, const void __user *arg);
 
+/* measure.c */
+
+extern int fsverity_ioctl_measure(struct file *filp, void __user *arg);
+
 /* open.c */
 
 extern int fsverity_file_open(struct inode *inode, struct file *filp);
@@ -143,6 +147,13 @@ static inline int fsverity_ioctl_enable(struct file *filp,
 	return -EOPNOTSUPP;
 }
 
+/* measure.c */
+
+static inline int fsverity_ioctl_measure(struct file *filp, void __user *arg)
+{
+	return -EOPNOTSUPP;
+}
+
 /* open.c */
 
 static inline int fsverity_file_open(struct inode *inode, struct file *filp)
-- 
2.22.0

