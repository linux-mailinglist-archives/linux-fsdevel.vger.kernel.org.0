Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8589F5C002
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 17:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbfGAPeM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 11:34:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729475AbfGAPeL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 11:34:11 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CBEF21851;
        Mon,  1 Jul 2019 15:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561995250;
        bh=A41vt4jGxIjxms6taEMGdqC+r7hlRcG0OlJSTNYg6+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iD3SKZ4NuFdVsvtTwHp67q1eLCgKv2yQih/QpjUim8OmpZnbzQ7oZYjMXY6u0gEAF
         k4Z4Btr2h50/1QSnvfvHDqxAUosnpP3S4X9u6kVl1RL7GZnMGJX6lq/nnHFBQ2r4Rl
         TN6KX7sDkc7P2+SgJ6zcV67wWlDIRxUtX3jf9tyo=
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
Subject: [PATCH v6 16/17] ext4: update on-disk format documentation for fs-verity
Date:   Mon,  1 Jul 2019 08:32:36 -0700
Message-Id: <20190701153237.1777-17-ebiggers@kernel.org>
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

Document the format of verity files on ext4, and the corresponding inode
and superblock flags.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/filesystems/ext4/inodes.rst   |  6 ++-
 Documentation/filesystems/ext4/overview.rst |  1 +
 Documentation/filesystems/ext4/super.rst    |  2 +
 Documentation/filesystems/ext4/verity.rst   | 41 +++++++++++++++++++++
 4 files changed, 48 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/filesystems/ext4/verity.rst

diff --git a/Documentation/filesystems/ext4/inodes.rst b/Documentation/filesystems/ext4/inodes.rst
index 6bd35e506b6f..e851e6ca31fa 100644
--- a/Documentation/filesystems/ext4/inodes.rst
+++ b/Documentation/filesystems/ext4/inodes.rst
@@ -277,6 +277,8 @@ The ``i_flags`` field is a combination of these values:
      - This is a huge file (EXT4\_HUGE\_FILE\_FL).
    * - 0x80000
      - Inode uses extents (EXT4\_EXTENTS\_FL).
+   * - 0x100000
+     - Verity protected file (EXT4\_VERITY\_FL).
    * - 0x200000
      - Inode stores a large extended attribute value in its data blocks
        (EXT4\_EA\_INODE\_FL).
@@ -299,9 +301,9 @@ The ``i_flags`` field is a combination of these values:
      - Reserved for ext4 library (EXT4\_RESERVED\_FL).
    * -
      - Aggregate flags:
-   * - 0x4BDFFF
+   * - 0x705BDFFF
      - User-visible flags.
-   * - 0x4B80FF
+   * - 0x604BC0FF
      - User-modifiable flags. Note that while EXT4\_JOURNAL\_DATA\_FL and
        EXT4\_EXTENTS\_FL can be set with setattr, they are not in the kernel's
        EXT4\_FL\_USER\_MODIFIABLE mask, since it needs to handle the setting of
diff --git a/Documentation/filesystems/ext4/overview.rst b/Documentation/filesystems/ext4/overview.rst
index cbab18baba12..123ebfde47ee 100644
--- a/Documentation/filesystems/ext4/overview.rst
+++ b/Documentation/filesystems/ext4/overview.rst
@@ -24,3 +24,4 @@ order.
 .. include:: bigalloc.rst
 .. include:: inlinedata.rst
 .. include:: eainode.rst
+.. include:: verity.rst
diff --git a/Documentation/filesystems/ext4/super.rst b/Documentation/filesystems/ext4/super.rst
index 04ff079a2acf..6eae92054827 100644
--- a/Documentation/filesystems/ext4/super.rst
+++ b/Documentation/filesystems/ext4/super.rst
@@ -696,6 +696,8 @@ the following:
        (RO\_COMPAT\_READONLY)
    * - 0x2000
      - Filesystem tracks project quotas. (RO\_COMPAT\_PROJECT)
+   * - 0x8000
+     - Verity inodes may be present on the filesystem. (RO\_COMPAT\_VERITY)
 
 .. _super_def_hash:
 
diff --git a/Documentation/filesystems/ext4/verity.rst b/Documentation/filesystems/ext4/verity.rst
new file mode 100644
index 000000000000..3e4c0ee0e068
--- /dev/null
+++ b/Documentation/filesystems/ext4/verity.rst
@@ -0,0 +1,41 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Verity files
+------------
+
+ext4 supports fs-verity, which is a filesystem feature that provides
+Merkle tree based hashing for individual readonly files.  Most of
+fs-verity is common to all filesystems that support it; see
+:ref:`Documentation/filesystems/fsverity.rst <fsverity>` for the
+fs-verity documentation.  However, the on-disk layout of the verity
+metadata is filesystem-specific.  On ext4, the verity metadata is
+stored after the end of the file data itself, in the following format:
+
+- Zero-padding to the next 65536-byte boundary.  This padding need not
+  actually be allocated on-disk, i.e. it may be a hole.
+
+- The Merkle tree, as documented in
+  :ref:`Documentation/filesystems/fsverity.rst
+  <fsverity_merkle_tree>`, with the tree levels stored in order from
+  root to leaf, and the tree blocks within each level stored in their
+  natural order.
+
+- Zero-padding to the next filesystem block boundary.
+
+- The verity descriptor, as documented in
+  :ref:`Documentation/filesystems/fsverity.rst <fsverity_descriptor>`,
+  with optionally appended signature blob.
+
+- Zero-padding to the next offset that is 4 bytes before a filesystem
+  block boundary.
+
+- The size of the verity descriptor in bytes, as a 4-byte little
+  endian integer.
+
+Verity inodes have EXT4_VERITY_FL set, and they must use extents, i.e.
+EXT4_EXTENTS_FL must be set and EXT4_INLINE_DATA_FL must be clear.
+They can have EXT4_ENCRYPT_FL set, in which case the verity metadata
+is encrypted as well as the data itself.
+
+Verity files cannot have blocks allocated past the end of the verity
+metadata.
-- 
2.22.0

