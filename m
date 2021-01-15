Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E0E2F841C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 19:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388418AbhAOSUy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 13:20:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:43466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732055AbhAOSUx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:20:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC9D823B03;
        Fri, 15 Jan 2021 18:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610734774;
        bh=gsd3qneQDJcEAWvK+26tVqknLPQ+kerh+7FxEp9mAvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ChoMe9ho9PcGemgjTm2q12Bj6EiXXCXdgfNIY+rHRqA2eBl8pv5YGPzLH11U8uEPJ
         OVkenwHQw+fuoDIPVVZNU+2lQrYyiNpBkW7rLCxqwVzIHOoYoFRCVHL8aNS4+z1CB5
         znTDLZehtUNRd6hUeqedT7eTp+XFuTC2m2VXmxUUBSruXBOzN8evT9crnLa2WhWbBd
         481fhP5zXOwBby4Zs1ap2AsJDJJ3DB3SffV+wBcIssdTGz1LJ7aEyu2vjOMbFhxlkt
         tRt5FlgHNmQASBoSX82i8xkbTOzc0ndw/uIQp6f9p85nnPd74rc2Fp/6WOkHjWmbuE
         OratH61jn8whg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-api@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>
Subject: [PATCH 4/6] fs-verity: support reading Merkle tree with ioctl
Date:   Fri, 15 Jan 2021 10:18:17 -0800
Message-Id: <20210115181819.34732-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210115181819.34732-1-ebiggers@kernel.org>
References: <20210115181819.34732-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add support for FS_VERITY_METADATA_TYPE_MERKLE_TREE to
FS_IOC_READ_VERITY_METADATA.  This allows a userspace server program to
retrieve the Merkle tree of a verity file for serving to a client which
implements fs-verity compatible verification.  See the patch which
introduced FS_IOC_READ_VERITY_METADATA for more details.

This has been tested using a new xfstest which calls this ioctl via a
new subcommand for the 'fsverity' program from fsverity-utils.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/filesystems/fsverity.rst | 10 +++-
 fs/verity/read_metadata.c              | 70 ++++++++++++++++++++++++++
 include/uapi/linux/fsverity.h          |  2 +
 3 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
index 9ef7a7de60085..50b47a6d9ea11 100644
--- a/Documentation/filesystems/fsverity.rst
+++ b/Documentation/filesystems/fsverity.rst
@@ -234,6 +234,8 @@ need this ioctl.
 
 This ioctl takes in a pointer to the following structure::
 
+   #define FS_VERITY_METADATA_TYPE_MERKLE_TREE     1
+
    struct fsverity_read_metadata_arg {
            __u64 metadata_type;
            __u64 offset;
@@ -242,7 +244,13 @@ This ioctl takes in a pointer to the following structure::
            __u64 __reserved;
    };
 
-``metadata_type`` specifies the type of metadata to read.
+``metadata_type`` specifies the type of metadata to read:
+
+- ``FS_VERITY_METADATA_TYPE_MERKLE_TREE`` reads the blocks of the
+  Merkle tree.  The blocks are returned in order from the root level
+  to the leaf level.  Within each level, the blocks are returned in
+  the same order that their hashes are themselves hashed.
+  See `Merkle tree`_ for more information.
 
 The semantics are similar to those of ``pread()``.  ``offset``
 specifies the offset in bytes into the metadata item to read from, and
diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
index 43be990fd53e4..0f8ad2991cf90 100644
--- a/fs/verity/read_metadata.c
+++ b/fs/verity/read_metadata.c
@@ -7,8 +7,75 @@
 
 #include "fsverity_private.h"
 
+#include <linux/backing-dev.h>
+#include <linux/highmem.h>
+#include <linux/sched/signal.h>
 #include <linux/uaccess.h>
 
+static int fsverity_read_merkle_tree(struct inode *inode,
+				     const struct fsverity_info *vi,
+				     void __user *buf, u64 offset, int length)
+{
+	const struct fsverity_operations *vops = inode->i_sb->s_vop;
+	u64 end_offset;
+	unsigned int offs_in_page;
+	pgoff_t index, last_index;
+	int retval = 0;
+	int err = 0;
+
+	end_offset = min(offset + length, vi->tree_params.tree_size);
+	if (offset >= end_offset)
+		return 0;
+	offs_in_page = offset_in_page(offset);
+	last_index = (end_offset - 1) >> PAGE_SHIFT;
+
+	/*
+	 * Iterate through each Merkle tree page in the requested range and copy
+	 * the requested portion to userspace.  Note that the Merkle tree block
+	 * size isn't important here, as we are returning a byte stream; i.e.,
+	 * we can just work with pages even if the tree block size != PAGE_SIZE.
+	 */
+	for (index = offset >> PAGE_SHIFT; index <= last_index; index++) {
+		unsigned long num_ra_pages =
+			min_t(unsigned long, last_index - index + 1,
+			      inode->i_sb->s_bdi->io_pages);
+		unsigned int bytes_to_copy = min_t(u64, end_offset - offset,
+						   PAGE_SIZE - offs_in_page);
+		struct page *page;
+		const void *virt;
+
+		page = vops->read_merkle_tree_page(inode, index, num_ra_pages);
+		if (IS_ERR(page)) {
+			err = PTR_ERR(page);
+			fsverity_err(inode,
+				     "Error %d reading Merkle tree page %lu",
+				     err, index);
+			break;
+		}
+
+		virt = kmap(page);
+		if (copy_to_user(buf, virt + offs_in_page, bytes_to_copy)) {
+			kunmap(page);
+			put_page(page);
+			err = -EFAULT;
+			break;
+		}
+		kunmap(page);
+		put_page(page);
+
+		retval += bytes_to_copy;
+		buf += bytes_to_copy;
+		offset += bytes_to_copy;
+
+		if (fatal_signal_pending(current))  {
+			err = -EINTR;
+			break;
+		}
+		cond_resched();
+		offs_in_page = 0;
+	}
+	return retval ? retval : err;
+}
 /**
  * fsverity_ioctl_read_metadata() - read verity metadata from a file
  * @filp: file to read the metadata from
@@ -48,6 +115,9 @@ int fsverity_ioctl_read_metadata(struct file *filp, const void __user *uarg)
 	buf = u64_to_user_ptr(arg.buf_ptr);
 
 	switch (arg.metadata_type) {
+	case FS_VERITY_METADATA_TYPE_MERKLE_TREE:
+		return fsverity_read_merkle_tree(inode, vi, buf, arg.offset,
+						 length);
 	default:
 		return -EINVAL;
 	}
diff --git a/include/uapi/linux/fsverity.h b/include/uapi/linux/fsverity.h
index e062751294d01..94003b153cb3d 100644
--- a/include/uapi/linux/fsverity.h
+++ b/include/uapi/linux/fsverity.h
@@ -83,6 +83,8 @@ struct fsverity_formatted_digest {
 	__u8 digest[];
 };
 
+#define FS_VERITY_METADATA_TYPE_MERKLE_TREE	1
+
 struct fsverity_read_metadata_arg {
 	__u64 metadata_type;
 	__u64 offset;
-- 
2.30.0

