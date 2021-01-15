Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C502F8433
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 19:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388645AbhAOSV0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 13:21:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:43474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388076AbhAOSUy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:20:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 851D523A6C;
        Fri, 15 Jan 2021 18:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610734774;
        bh=DBm5POVqThVqB6dR0uFKTktVEXLstitiHg1DG/aF4QM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S+zoOQ/fI9iHtksm84CuXz1loVV1PH1en9rM/bpCSgerSJhppwjg5/JABqS/Q/5MN
         YmeKczMMxKNkLgO3M7tG1m2t4LcJ0iyoLF7dq8JrL/dSouRxvEmWmh2S3KxJ2GkWz0
         kyDALixxhhcVKKmePXO6AGp6523+Cyhwhb+IlT5TKnnUqf8FoszDmmecHTSLey6Xk2
         UKF40HtqlrfFyYUhgFcChzqtRb0e3HyystLXBkB9/ijX/ZMXf73iV1RyQM1Timzr/D
         uZdJjKdLF2/tFlMXM28HHK6z1pRLPMlCDuj5wECLquhkZ7pQNWID7kyiykpYEmP1X1
         J9zA0rCEu6/OA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-api@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>
Subject: [PATCH 6/6] fs-verity: support reading signature with ioctl
Date:   Fri, 15 Jan 2021 10:18:19 -0800
Message-Id: <20210115181819.34732-7-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210115181819.34732-1-ebiggers@kernel.org>
References: <20210115181819.34732-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add support for FS_VERITY_METADATA_TYPE_SIGNATURE to
FS_IOC_READ_VERITY_METADATA.  This allows a userspace server program to
retrieve the built-in signature (if present) of a verity file for
serving to a client which implements fs-verity compatible verification.
See the patch which introduced FS_IOC_READ_VERITY_METADATA for more
details.

The ability for userspace to read the built-in signatures is also useful
because it allows a system that is using the in-kernel signature
verification to migrate to userspace signature verification.

This has been tested using a new xfstest which calls this ioctl via a
new subcommand for the 'fsverity' program from fsverity-utils.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/filesystems/fsverity.rst |  9 +++++++-
 fs/verity/read_metadata.c              | 30 ++++++++++++++++++++++++++
 include/uapi/linux/fsverity.h          |  1 +
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
index 6dc5772037ef9..1d831e3cbcb33 100644
--- a/Documentation/filesystems/fsverity.rst
+++ b/Documentation/filesystems/fsverity.rst
@@ -236,6 +236,7 @@ This ioctl takes in a pointer to the following structure::
 
    #define FS_VERITY_METADATA_TYPE_MERKLE_TREE     1
    #define FS_VERITY_METADATA_TYPE_DESCRIPTOR      2
+   #define FS_VERITY_METADATA_TYPE_SIGNATURE       3
 
    struct fsverity_read_metadata_arg {
            __u64 metadata_type;
@@ -256,6 +257,10 @@ This ioctl takes in a pointer to the following structure::
 - ``FS_VERITY_METADATA_TYPE_DESCRIPTOR`` reads the fs-verity
   descriptor.  See `fs-verity descriptor`_.
 
+- ``FS_VERITY_METADATA_TYPE_SIGNATURE`` reads the signature which was
+  passed to FS_IOC_ENABLE_VERITY, if any.  See `Built-in signature
+  verification`_.
+
 The semantics are similar to those of ``pread()``.  ``offset``
 specifies the offset in bytes into the metadata item to read from, and
 ``length`` specifies the maximum number of bytes to read from the
@@ -279,7 +284,9 @@ FS_IOC_READ_VERITY_METADATA can fail with the following errors:
 - ``EINTR``: the ioctl was interrupted before any data was read
 - ``EINVAL``: reserved fields were set, or ``offset + length``
   overflowed
-- ``ENODATA``: the file is not a verity file
+- ``ENODATA``: the file is not a verity file, or
+  FS_VERITY_METADATA_TYPE_SIGNATURE was requested but the file doesn't
+  have a built-in signature
 - ``ENOTTY``: this type of filesystem does not implement fs-verity, or
   this ioctl is not yet implemented on it
 - ``EOPNOTSUPP``: the kernel was not configured with fs-verity
diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
index 2dea6dd3bb05a..7e2d0c7bdf0de 100644
--- a/fs/verity/read_metadata.c
+++ b/fs/verity/read_metadata.c
@@ -114,6 +114,34 @@ static int fsverity_read_descriptor(struct inode *inode,
 	kfree(desc);
 	return res;
 }
+
+static int fsverity_read_signature(struct inode *inode,
+				   void __user *buf, u64 offset, int length)
+{
+	struct fsverity_descriptor *desc;
+	size_t desc_size;
+	int res;
+
+	res = fsverity_get_descriptor(inode, &desc, &desc_size);
+	if (res)
+		return res;
+
+	if (desc->sig_size == 0) {
+		res = -ENODATA;
+		goto out;
+	}
+
+	/*
+	 * Include only the signature.  Note that fsverity_get_descriptor()
+	 * already verified that sig_size is in-bounds.
+	 */
+	res = fsverity_read_buffer(buf, offset, length, desc->signature,
+				   le32_to_cpu(desc->sig_size));
+out:
+	kfree(desc);
+	return res;
+}
+
 /**
  * fsverity_ioctl_read_metadata() - read verity metadata from a file
  * @filp: file to read the metadata from
@@ -158,6 +186,8 @@ int fsverity_ioctl_read_metadata(struct file *filp, const void __user *uarg)
 						 length);
 	case FS_VERITY_METADATA_TYPE_DESCRIPTOR:
 		return fsverity_read_descriptor(inode, buf, arg.offset, length);
+	case FS_VERITY_METADATA_TYPE_SIGNATURE:
+		return fsverity_read_signature(inode, buf, arg.offset, length);
 	default:
 		return -EINVAL;
 	}
diff --git a/include/uapi/linux/fsverity.h b/include/uapi/linux/fsverity.h
index 41abc283dbccb..15384e22e331e 100644
--- a/include/uapi/linux/fsverity.h
+++ b/include/uapi/linux/fsverity.h
@@ -85,6 +85,7 @@ struct fsverity_formatted_digest {
 
 #define FS_VERITY_METADATA_TYPE_MERKLE_TREE	1
 #define FS_VERITY_METADATA_TYPE_DESCRIPTOR	2
+#define FS_VERITY_METADATA_TYPE_SIGNATURE	3
 
 struct fsverity_read_metadata_arg {
 	__u64 metadata_type;
-- 
2.30.0

