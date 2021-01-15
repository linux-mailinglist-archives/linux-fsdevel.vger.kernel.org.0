Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A55F2F842D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 19:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388633AbhAOSUz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 13:20:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:43468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387793AbhAOSUy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:20:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 283E923A9C;
        Fri, 15 Jan 2021 18:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610734774;
        bh=3tf17MDWrGIlvy8SI+oes67sgJXnVSJsC3e5U1cikIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VfR8z95ZOmifI/nt1Ul75/gFtn3/rXrThfnWJPtXyqIfpUq513T+uuan3RXnnyo2A
         2UZ32crGW4PhR2kgdr3O6J/kwXPA3YgtTo7R7ZIvG9JMn9a0ppiQDkwZJAtK9GjvDS
         f6Qfx90EVmIvpy57svhDWbbWkHq+4cd68DxdDy9a8mRz+5vDt7U06QmfXQ8MJsqV4G
         yKYvO7Y5MLy2olMSMYkM725mCK1+WLHeJ+dRRy0X3jqY5K2W0H4JqS7GKfMkySGaok
         CVDZLQurZCdzDKZRK7pYeeQPY7rDttg5Dx96Q7+8mOtcHJX4j8xvLLmDU5WYBogX+O
         QCKkgpkmuwuFw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-api@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>
Subject: [PATCH 5/6] fs-verity: support reading descriptor with ioctl
Date:   Fri, 15 Jan 2021 10:18:18 -0800
Message-Id: <20210115181819.34732-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210115181819.34732-1-ebiggers@kernel.org>
References: <20210115181819.34732-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add support for FS_VERITY_METADATA_TYPE_DESCRIPTOR to
FS_IOC_READ_VERITY_METADATA.  This allows a userspace server program to
retrieve the fs-verity descriptor of a file for serving to a client
which implements fs-verity compatible verification.  See the patch which
introduced FS_IOC_READ_VERITY_METADATA for more details.

"fs-verity descriptor" here means only the part that userspace cares
about because it is hashed to produce the file digest.  It doesn't
include the signature which ext4 and f2fs append to the
fsverity_descriptor struct when storing it on-disk, since that way of
storing the signature is an implementation detail.  The next patch adds
a separate metadata_type value for retrieving the signature separately.

This has been tested using a new xfstest which calls this ioctl via a
new subcommand for the 'fsverity' program from fsverity-utils.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/filesystems/fsverity.rst |  4 +++
 fs/verity/read_metadata.c              | 40 ++++++++++++++++++++++++++
 include/uapi/linux/fsverity.h          |  1 +
 3 files changed, 45 insertions(+)

diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
index 50b47a6d9ea11..6dc5772037ef9 100644
--- a/Documentation/filesystems/fsverity.rst
+++ b/Documentation/filesystems/fsverity.rst
@@ -235,6 +235,7 @@ need this ioctl.
 This ioctl takes in a pointer to the following structure::
 
    #define FS_VERITY_METADATA_TYPE_MERKLE_TREE     1
+   #define FS_VERITY_METADATA_TYPE_DESCRIPTOR      2
 
    struct fsverity_read_metadata_arg {
            __u64 metadata_type;
@@ -252,6 +253,9 @@ This ioctl takes in a pointer to the following structure::
   the same order that their hashes are themselves hashed.
   See `Merkle tree`_ for more information.
 
+- ``FS_VERITY_METADATA_TYPE_DESCRIPTOR`` reads the fs-verity
+  descriptor.  See `fs-verity descriptor`_.
+
 The semantics are similar to those of ``pread()``.  ``offset``
 specifies the offset in bytes into the metadata item to read from, and
 ``length`` specifies the maximum number of bytes to read from the
diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
index 0f8ad2991cf90..2dea6dd3bb05a 100644
--- a/fs/verity/read_metadata.c
+++ b/fs/verity/read_metadata.c
@@ -76,6 +76,44 @@ static int fsverity_read_merkle_tree(struct inode *inode,
 	}
 	return retval ? retval : err;
 }
+
+/* Copy the requested portion of the buffer to userspace. */
+static int fsverity_read_buffer(void __user *dst, u64 offset, int length,
+				const void *src, size_t src_length)
+{
+	if (offset >= src_length)
+		return 0;
+	src += offset;
+	src_length -= offset;
+
+	length = min_t(size_t, length, src_length);
+
+	if (copy_to_user(dst, src, length))
+		return -EFAULT;
+
+	return length;
+}
+
+static int fsverity_read_descriptor(struct inode *inode,
+				    void __user *buf, u64 offset, int length)
+{
+	struct fsverity_descriptor *desc;
+	size_t desc_size;
+	int res;
+
+	res = fsverity_get_descriptor(inode, &desc, &desc_size);
+	if (res)
+		return res;
+
+	/* don't include the signature */
+	desc_size = offsetof(struct fsverity_descriptor, signature);
+	desc->sig_size = 0;
+
+	res = fsverity_read_buffer(buf, offset, length, desc, desc_size);
+
+	kfree(desc);
+	return res;
+}
 /**
  * fsverity_ioctl_read_metadata() - read verity metadata from a file
  * @filp: file to read the metadata from
@@ -118,6 +156,8 @@ int fsverity_ioctl_read_metadata(struct file *filp, const void __user *uarg)
 	case FS_VERITY_METADATA_TYPE_MERKLE_TREE:
 		return fsverity_read_merkle_tree(inode, vi, buf, arg.offset,
 						 length);
+	case FS_VERITY_METADATA_TYPE_DESCRIPTOR:
+		return fsverity_read_descriptor(inode, buf, arg.offset, length);
 	default:
 		return -EINVAL;
 	}
diff --git a/include/uapi/linux/fsverity.h b/include/uapi/linux/fsverity.h
index 94003b153cb3d..41abc283dbccb 100644
--- a/include/uapi/linux/fsverity.h
+++ b/include/uapi/linux/fsverity.h
@@ -84,6 +84,7 @@ struct fsverity_formatted_digest {
 };
 
 #define FS_VERITY_METADATA_TYPE_MERKLE_TREE	1
+#define FS_VERITY_METADATA_TYPE_DESCRIPTOR	2
 
 struct fsverity_read_metadata_arg {
 	__u64 metadata_type;
-- 
2.30.0

