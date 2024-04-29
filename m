Return-Path: <linux-fsdevel+bounces-18131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 942168B5F9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B75F51C215A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C370B86269;
	Mon, 29 Apr 2024 17:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="didp0iEx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F67C86AFC;
	Mon, 29 Apr 2024 17:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410330; cv=none; b=jsXAe87opXa4zBDlEe/7MV/pzYCRmZQ8xoQW6yZkNeyNJ1dmvfwQIFXEUNjdhjwXzAZwAKB43Gpum1qHVqOGQeCrlO5TE2upjLhTIplpyLOv40DC9H4TtoJXBwn8Lr1EqgJEHtJf9mOe5iGZ6aWeWlUTM2QnUxe0WUvvQG/7MIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410330; c=relaxed/simple;
	bh=f7nr9BHgMNY07SuBb7AMIuKL8EhAF6Lae/DCFaA0XMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B6ZiHLulbMcyAZ/AxtYumUs9YWLbaSSfzZSKfH9/fU355WtJ2snui9YZ3aiFMZ41NlHhgL6isGaZPTQpwhP4AvUnYTQhDqIZOji1Va0FP0GyG65kL5b4oPM/CA0YCsyfIolQC233qHwfdMczlUup0C6tDj7RXh2niMRhd+ZnlTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=didp0iEx; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6ea1a55b0c0so2432798a34.3;
        Mon, 29 Apr 2024 10:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714410328; x=1715015128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvRMVdHLhDXhOx55ypqAZ1Z/pDm9XYtxQRRB/JnE99c=;
        b=didp0iExgM+JMPqPE0C7wqUFsDhroOnu9Jq6rSGAb95JxHl7gS7yRmHU9d/gwgBmGd
         d9swxdm12Z9NXbMLHcT1eVh2VG5qENmVwx4+r2wEzbwS0qdmhkXUjlNJXHHLbfZSkY0j
         7lX1gpRNLMPow90jad9pRI42orAvXjOIobfiBsVgCeTkYrqTyr3FQJW46ZqGHvCDvDUB
         fYZrFLsUZ+HR1W4n+tck2Ro3mP4nVhNTGmcR0wwfW20hIw/KUGc4BodLGuBJ5GpnKf7L
         Kl14vZ/Q44zdfvz7LTEZzM9c5yJ8jQuZfYkDNu66vrqLByRdYFv0VpQE7pot5MXR/9fh
         omHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714410328; x=1715015128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MvRMVdHLhDXhOx55ypqAZ1Z/pDm9XYtxQRRB/JnE99c=;
        b=jBnx+ZBhlxSMCrgV9tbbhuVq4AEtzTB3bl+9oEtI8gz3jv05P2yd6Tuurq3SGLKnNZ
         Fs1MaOE64nVZHfYrqt9T7FmnTdAaMHnPQDPJESMoLb67zPhfZ1MJKX/TbS2ZUi2/2pfn
         vBVwO+46SGzkppt5a/gi9WcGzDhKDYNLdKZ3dtiNwPppMHPRZwDKLfj9LyuhcjE05ZgF
         K34U8Ow9ZKZvog2MrFhr1VOfOYSd+6hrT7cselA7U92oKzlm0wdwyE1V2eVVMbqGKDP4
         XUWm6Ff7guvnuenL0aBZ4ne5xXmOC4o/p9VmV3+APR/thiMwdruLPu2nK2nuXaW+bAOz
         0irQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGkEGMTGgV4JUS94CLONTOxvScWJee0YFErsjIHX+1ZVZbnZJ20LKBK0p8yAS0JPzKlBiBJ9CVlkf6P8G6429ZcrRk24gUx3Q4XwAAI23A9Bhg8H6qDhanfCAXkcBDZN5kq9DNDT6/xQ==
X-Gm-Message-State: AOJu0YyoW5MvFMW+IGwkqcTKfv9iK9qjI6+tet8Xx47ItQkiJMPbVXus
	P5Vzro38sainp1DN+xs5I1WFFpMP7dh4YAY2Q5oz80brbyNRl2zc
X-Google-Smtp-Source: AGHT+IG/ZcwB0huKygPBvFdcgDmjShYrcDklwOFhU2UIhkvvjhkEis6/aiEjDF1au3eTMnKT4Qud0g==
X-Received: by 2002:a05:6830:59:b0:6ee:3232:160a with SMTP id d25-20020a056830005900b006ee3232160amr328210otp.38.1714410326944;
        Mon, 29 Apr 2024 10:05:26 -0700 (PDT)
Received: from localhost.localdomain ([70.114.203.196])
        by smtp.gmail.com with ESMTPSA id g1-20020a9d6201000000b006ea20712e66sm4074448otj.17.2024.04.29.10.05.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Apr 2024 10:05:26 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev
Cc: John Groves <jgroves@micron.com>,
	john@jagalactic.com,
	Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>,
	dave.hansen@linux.intel.com,
	gregory.price@memverge.com,
	Randy Dunlap <rdunlap@infradead.org>,
	Jerome Glisse <jglisse@google.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	Eishan Mirakhur <emirakhur@micron.com>,
	Ravi Shankar <venkataravis@micron.com>,
	Srinivasulu Thanneeru <sthanneeru@micron.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Steve French <stfrench@microsoft.com>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Julien Panis <jpanis@baylibre.com>,
	Stanislav Fomichev <sdf@google.com>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	John Groves <john@groves.net>
Subject: [RFC PATCH v2 10/12] famfs: Introduce file_operations read/write
Date: Mon, 29 Apr 2024 12:04:26 -0500
Message-Id: <4584f1e26802af540a60eadb70f42c6ac5fe4679.1714409084.git.john@groves.net>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1714409084.git.john@groves.net>
References: <cover.1714409084.git.john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit introduces fs/famfs/famfs_file.c and the famfs
file_operations for read/write.

This is not usable yet because:

* It calls dax_iomap_rw() with NULL iomap_ops (which will be
  introduced in a subsequent commit).
* famfs_ioctl() is coming in a later commit, and it is necessary
  to map a file to a memory allocation.

Signed-off-by: John Groves <john@groves.net>
---
 fs/famfs/Makefile         |   2 +-
 fs/famfs/famfs_file.c     | 122 ++++++++++++++++++++++++++++++++++++++
 fs/famfs/famfs_inode.c    |   2 +-
 fs/famfs/famfs_internal.h |   2 +
 4 files changed, 126 insertions(+), 2 deletions(-)
 create mode 100644 fs/famfs/famfs_file.c

diff --git a/fs/famfs/Makefile b/fs/famfs/Makefile
index 62230bcd6793..8cac90c090a4 100644
--- a/fs/famfs/Makefile
+++ b/fs/famfs/Makefile
@@ -2,4 +2,4 @@
 
 obj-$(CONFIG_FAMFS) += famfs.o
 
-famfs-y := famfs_inode.o
+famfs-y := famfs_inode.o famfs_file.o
diff --git a/fs/famfs/famfs_file.c b/fs/famfs/famfs_file.c
new file mode 100644
index 000000000000..48036c71d4ed
--- /dev/null
+++ b/fs/famfs/famfs_file.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * famfs - dax file system for shared fabric-attached memory
+ *
+ * Copyright 2023-2024 Micron Technology, Inc.
+ *
+ * This file system, originally based on ramfs the dax support from xfs,
+ * is intended to allow multiple host systems to mount a common file system
+ * view of dax files that map to shared memory.
+ */
+
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/dax.h>
+#include <linux/iomap.h>
+
+#include "famfs_internal.h"
+
+/*********************************************************************
+ * file_operations
+ */
+
+/* Reject I/O to files that aren't in a valid state */
+static ssize_t
+famfs_file_invalid(struct inode *inode)
+{
+	if (!IS_DAX(inode)) {
+		pr_debug("%s: inode %llx IS_DAX is false\n", __func__, (u64)inode);
+		return -ENXIO;
+	}
+	return 0;
+}
+
+static ssize_t
+famfs_rw_prep(struct kiocb *iocb, struct iov_iter *ubuf)
+{
+	struct inode *inode = iocb->ki_filp->f_mapping->host;
+	struct super_block *sb = inode->i_sb;
+	struct famfs_fs_info *fsi = sb->s_fs_info;
+	size_t i_size = i_size_read(inode);
+	size_t count = iov_iter_count(ubuf);
+	size_t max_count;
+	ssize_t rc;
+
+	if (fsi->deverror)
+		return -ENODEV;
+
+	rc = famfs_file_invalid(inode);
+	if (rc)
+		return rc;
+
+	max_count = max_t(size_t, 0, i_size - iocb->ki_pos);
+
+	if (count > max_count)
+		iov_iter_truncate(ubuf, max_count);
+
+	if (!iov_iter_count(ubuf))
+		return 0;
+
+	return rc;
+}
+
+static ssize_t
+famfs_dax_read_iter(struct kiocb *iocb, struct iov_iter	*to)
+{
+	ssize_t rc;
+
+	rc = famfs_rw_prep(iocb, to);
+	if (rc)
+		return rc;
+
+	if (!iov_iter_count(to))
+		return 0;
+
+	rc = dax_iomap_rw(iocb, to, NULL /*&famfs_iomap_ops */);
+
+	file_accessed(iocb->ki_filp);
+	return rc;
+}
+
+/**
+ * famfs_dax_write_iter()
+ *
+ * We need our own write-iter in order to prevent append
+ *
+ * @iocb:
+ * @from: iterator describing the user memory source for the write
+ */
+static ssize_t
+famfs_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	ssize_t rc;
+
+	rc = famfs_rw_prep(iocb, from);
+	if (rc)
+		return rc;
+
+	if (!iov_iter_count(from))
+		return 0;
+
+	return dax_iomap_rw(iocb, from, NULL /*&famfs_iomap_ops*/);
+}
+
+const struct file_operations famfs_file_operations = {
+	.owner             = THIS_MODULE,
+
+	/* Custom famfs operations */
+	.write_iter	   = famfs_dax_write_iter,
+	.read_iter	   = famfs_dax_read_iter,
+	.unlocked_ioctl    = NULL /*famfs_file_ioctl*/,
+	.mmap		   = NULL /* famfs_file_mmap */,
+
+	/* Force PMD alignment for mmap */
+	.get_unmapped_area = thp_get_unmapped_area,
+
+	/* Generic Operations */
+	.fsync		   = noop_fsync,
+	.splice_read	   = filemap_splice_read,
+	.splice_write	   = iter_file_splice_write,
+	.llseek		   = generic_file_llseek,
+};
+
diff --git a/fs/famfs/famfs_inode.c b/fs/famfs/famfs_inode.c
index e00e9cdecadf..490a2c0fd326 100644
--- a/fs/famfs/famfs_inode.c
+++ b/fs/famfs/famfs_inode.c
@@ -56,7 +56,7 @@ static struct inode *famfs_get_inode(struct super_block *sb,
 		break;
 	case S_IFREG:
 		inode->i_op = &famfs_file_inode_operations;
-		inode->i_fop = NULL /* &famfs_file_operations */;
+		inode->i_fop = &famfs_file_operations;
 		break;
 	case S_IFDIR:
 		inode->i_op = &famfs_dir_inode_operations;
diff --git a/fs/famfs/famfs_internal.h b/fs/famfs/famfs_internal.h
index 951b32ec4fbd..36efaef425e7 100644
--- a/fs/famfs/famfs_internal.h
+++ b/fs/famfs/famfs_internal.h
@@ -11,6 +11,8 @@
 #ifndef FAMFS_INTERNAL_H
 #define FAMFS_INTERNAL_H
 
+extern const struct file_operations famfs_file_operations;
+
 struct famfs_mount_opts {
 	umode_t mode;
 };
-- 
2.43.0


