Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4B49161716
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbgBQQMj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:12:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47280 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbgBQQMf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=1KFmEKTTdS2fmZ0fD7fcJLsUxO/bYA23wrQJz6uNIM8=; b=Qm1qjo5ZP0I83tOkK04IAclxwo
        kDswq7PZ/5Zhqse//4vyKG88jyw6wBwHFt+JMEEk2yQnrrwTV+Gib6FgQrhjtJL1R144WwIzWMLmH
        G664ARZI+er13OOvESbuT/wQPPYz4W1F937FjD+prG6NLELHYRZc/Re8SDzBl/VXmKRgLbI2HjH0F
        Nlpp3j820FKHfedphMrg+16dYeLlQkE7da/rxYlkUOyz40waAisZ53vhCbWckjHtgITTsqGYsEOFS
        Q9NQYgcSuW9I9TzhybdQAAOlkqWVscystNHyzkZ5Vk9xNOw8TuasY0Jayb9SrH5nUX5owe0kaYAnV
        ilpmfE5g==;
Received: from ip-109-41-129-189.web.vodafone.de ([109.41.129.189] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0c-0006us-Sy; Mon, 17 Feb 2020 16:12:35 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0a-000fbL-UX; Mon, 17 Feb 2020 17:12:32 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org, Bob Copeland <me@bobcopeland.com>,
        linux-karma-devel@lists.sourceforge.net
Subject: [PATCH 30/44] docs: filesystems: convert omfs.txt to ReST
Date:   Mon, 17 Feb 2020 17:12:16 +0100
Message-Id: <0c125c7c971d81a557ca954992b8d770a9d1e3e8.1581955849.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581955849.git.mchehab+huawei@kernel.org>
References: <cover.1581955849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

- Add a SPDX header;
- Adjust document title;
- Mark literal blocks as such;
- Add table markups;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/index.rst |   1 +
 Documentation/filesystems/omfs.rst  | 112 ++++++++++++++++++++++++++++
 Documentation/filesystems/omfs.txt  | 106 --------------------------
 3 files changed, 113 insertions(+), 106 deletions(-)
 create mode 100644 Documentation/filesystems/omfs.rst
 delete mode 100644 Documentation/filesystems/omfs.txt

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 3b2b07491c98..fbee77175840 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -78,6 +78,7 @@ Documentation for filesystem implementations.
    ntfs
    ocfs2
    ocfs2-online-filecheck
+   omfs
    overlayfs
    virtiofs
    vfat
diff --git a/Documentation/filesystems/omfs.rst b/Documentation/filesystems/omfs.rst
new file mode 100644
index 000000000000..4c8bb3074169
--- /dev/null
+++ b/Documentation/filesystems/omfs.rst
@@ -0,0 +1,112 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================================
+Optimized MPEG Filesystem (OMFS)
+================================
+
+Overview
+========
+
+OMFS is a filesystem created by SonicBlue for use in the ReplayTV DVR
+and Rio Karma MP3 player.  The filesystem is extent-based, utilizing
+block sizes from 2k to 8k, with hash-based directories.  This
+filesystem driver may be used to read and write disks from these
+devices.
+
+Note, it is not recommended that this FS be used in place of a general
+filesystem for your own streaming media device.  Native Linux filesystems
+will likely perform better.
+
+More information is available at:
+
+    http://linux-karma.sf.net/
+
+Various utilities, including mkomfs and omfsck, are included with
+omfsprogs, available at:
+
+    http://bobcopeland.com/karma/
+
+Instructions are included in its README.
+
+Options
+=======
+
+OMFS supports the following mount-time options:
+
+    ============   ========================================
+    uid=n          make all files owned by specified user
+    gid=n          make all files owned by specified group
+    umask=xxx      set permission umask to xxx
+    fmask=xxx      set umask to xxx for files
+    dmask=xxx      set umask to xxx for directories
+    ============   ========================================
+
+Disk format
+===========
+
+OMFS discriminates between "sysblocks" and normal data blocks.  The sysblock
+group consists of super block information, file metadata, directory structures,
+and extents.  Each sysblock has a header containing CRCs of the entire
+sysblock, and may be mirrored in successive blocks on the disk.  A sysblock may
+have a smaller size than a data block, but since they are both addressed by the
+same 64-bit block number, any remaining space in the smaller sysblock is
+unused.
+
+Sysblock header information::
+
+    struct omfs_header {
+	    __be64 h_self;                  /* FS block where this is located */
+	    __be32 h_body_size;             /* size of useful data after header */
+	    __be16 h_crc;                   /* crc-ccitt of body_size bytes */
+	    char h_fill1[2];
+	    u8 h_version;                   /* version, always 1 */
+	    char h_type;                    /* OMFS_INODE_X */
+	    u8 h_magic;                     /* OMFS_IMAGIC */
+	    u8 h_check_xor;                 /* XOR of header bytes before this */
+	    __be32 h_fill2;
+    };
+
+Files and directories are both represented by omfs_inode::
+
+    struct omfs_inode {
+	    struct omfs_header i_head;      /* header */
+	    __be64 i_parent;                /* parent containing this inode */
+	    __be64 i_sibling;               /* next inode in hash bucket */
+	    __be64 i_ctime;                 /* ctime, in milliseconds */
+	    char i_fill1[35];
+	    char i_type;                    /* OMFS_[DIR,FILE] */
+	    __be32 i_fill2;
+	    char i_fill3[64];
+	    char i_name[OMFS_NAMELEN];      /* filename */
+	    __be64 i_size;                  /* size of file, in bytes */
+    };
+
+Directories in OMFS are implemented as a large hash table.  Filenames are
+hashed then prepended into the bucket list beginning at OMFS_DIR_START.
+Lookup requires hashing the filename, then seeking across i_sibling pointers
+until a match is found on i_name.  Empty buckets are represented by block
+pointers with all-1s (~0).
+
+A file is an omfs_inode structure followed by an extent table beginning at
+OMFS_EXTENT_START::
+
+    struct omfs_extent_entry {
+	    __be64 e_cluster;               /* start location of a set of blocks */
+	    __be64 e_blocks;                /* number of blocks after e_cluster */
+    };
+
+    struct omfs_extent {
+	    __be64 e_next;                  /* next extent table location */
+	    __be32 e_extent_count;          /* total # extents in this table */
+	    __be32 e_fill;
+	    struct omfs_extent_entry e_entry;       /* start of extent entries */
+    };
+
+Each extent holds the block offset followed by number of blocks allocated to
+the extent.  The final extent in each table is a terminator with e_cluster
+being ~0 and e_blocks being ones'-complement of the total number of blocks
+in the table.
+
+If this table overflows, a continuation inode is written and pointed to by
+e_next.  These have a header but lack the rest of the inode structure.
+
diff --git a/Documentation/filesystems/omfs.txt b/Documentation/filesystems/omfs.txt
deleted file mode 100644
index 1d0d41ff5c65..000000000000
--- a/Documentation/filesystems/omfs.txt
+++ /dev/null
@@ -1,106 +0,0 @@
-Optimized MPEG Filesystem (OMFS)
-
-Overview
-========
-
-OMFS is a filesystem created by SonicBlue for use in the ReplayTV DVR
-and Rio Karma MP3 player.  The filesystem is extent-based, utilizing
-block sizes from 2k to 8k, with hash-based directories.  This
-filesystem driver may be used to read and write disks from these
-devices.
-
-Note, it is not recommended that this FS be used in place of a general
-filesystem for your own streaming media device.  Native Linux filesystems
-will likely perform better.
-
-More information is available at:
-
-    http://linux-karma.sf.net/
-
-Various utilities, including mkomfs and omfsck, are included with
-omfsprogs, available at:
-
-    http://bobcopeland.com/karma/
-
-Instructions are included in its README.
-
-Options
-=======
-
-OMFS supports the following mount-time options:
-
-    uid=n        - make all files owned by specified user
-    gid=n        - make all files owned by specified group
-    umask=xxx    - set permission umask to xxx
-    fmask=xxx    - set umask to xxx for files
-    dmask=xxx    - set umask to xxx for directories
-
-Disk format
-===========
-
-OMFS discriminates between "sysblocks" and normal data blocks.  The sysblock
-group consists of super block information, file metadata, directory structures,
-and extents.  Each sysblock has a header containing CRCs of the entire
-sysblock, and may be mirrored in successive blocks on the disk.  A sysblock may
-have a smaller size than a data block, but since they are both addressed by the
-same 64-bit block number, any remaining space in the smaller sysblock is
-unused.
-
-Sysblock header information:
-
-struct omfs_header {
-        __be64 h_self;                  /* FS block where this is located */
-        __be32 h_body_size;             /* size of useful data after header */
-        __be16 h_crc;                   /* crc-ccitt of body_size bytes */
-        char h_fill1[2];
-        u8 h_version;                   /* version, always 1 */
-        char h_type;                    /* OMFS_INODE_X */
-        u8 h_magic;                     /* OMFS_IMAGIC */
-        u8 h_check_xor;                 /* XOR of header bytes before this */
-        __be32 h_fill2;
-};
-
-Files and directories are both represented by omfs_inode:
-
-struct omfs_inode {
-        struct omfs_header i_head;      /* header */
-        __be64 i_parent;                /* parent containing this inode */
-        __be64 i_sibling;               /* next inode in hash bucket */
-        __be64 i_ctime;                 /* ctime, in milliseconds */
-        char i_fill1[35];
-        char i_type;                    /* OMFS_[DIR,FILE] */
-        __be32 i_fill2;
-        char i_fill3[64];
-        char i_name[OMFS_NAMELEN];      /* filename */
-        __be64 i_size;                  /* size of file, in bytes */
-};
-
-Directories in OMFS are implemented as a large hash table.  Filenames are
-hashed then prepended into the bucket list beginning at OMFS_DIR_START.
-Lookup requires hashing the filename, then seeking across i_sibling pointers
-until a match is found on i_name.  Empty buckets are represented by block
-pointers with all-1s (~0).
-
-A file is an omfs_inode structure followed by an extent table beginning at
-OMFS_EXTENT_START:
-
-struct omfs_extent_entry {
-        __be64 e_cluster;               /* start location of a set of blocks */
-        __be64 e_blocks;                /* number of blocks after e_cluster */
-};
-
-struct omfs_extent {
-        __be64 e_next;                  /* next extent table location */
-        __be32 e_extent_count;          /* total # extents in this table */
-        __be32 e_fill;
-        struct omfs_extent_entry e_entry;       /* start of extent entries */
-};
-
-Each extent holds the block offset followed by number of blocks allocated to
-the extent.  The final extent in each table is a terminator with e_cluster
-being ~0 and e_blocks being ones'-complement of the total number of blocks
-in the table.
-
-If this table overflows, a continuation inode is written and pointed to by
-e_next.  These have a header but lack the rest of the inode structure.
-
-- 
2.24.1

