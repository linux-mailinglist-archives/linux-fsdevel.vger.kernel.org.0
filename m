Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8182161726
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbgBQQMq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:12:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48214 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729757AbgBQQMq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=YFRLOUE+jiSmwVl2wEKEB4vppV5/HRhWAOW9oNk9QFQ=; b=afdhXQ4kZDzPIoOYO/Wztn7TDY
        A6QE7NpkQoVFUicZS4TZzpV2+aWOJAD7SSQ/OsEeX1/m6OsJvUodtEJAjj4F8A3DPXg5wa6EFQVio
        pyQPvC/0bRCk+m8Y/kqv4AcM7p2UzfzYz3kWI9q6qLLKhhZpF7FWfOtR3nEWRyNq8w06015undTv+
        79JyPHbZZ1fbCazb4esRoSEgUTERjwIWLhsjYQHEuAeFjJZVCePqgXuDZfluY6NfGsIMrg6zFKosr
        dgYXIbiLmclJyWANGE/Ep5u0iFRB57tjwSPH7X5JENdpb9TKLkmC9QYzEZWijlRz3fIYieugWyJyc
        bv6v7bBw==;
Received: from x2f7f83d.dyn.telefonica.de ([2.247.248.61] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0i-0006v1-Qd; Mon, 17 Feb 2020 16:12:44 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0b-000fc4-AV; Mon, 17 Feb 2020 17:12:33 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 39/44] docs: filesystems: convert sysv-fs.txt to ReST
Date:   Mon, 17 Feb 2020 17:12:25 +0100
Message-Id: <5b96a6efba95773af439ab25a7dbe4d0edf8c867.1581955849.git.mchehab+huawei@kernel.org>
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
- Add a document title;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add table markups;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/index.rst           |   1 +
 .../filesystems/{sysv-fs.txt => sysv-fs.rst}  | 155 +++++++++++++-----
 2 files changed, 112 insertions(+), 44 deletions(-)
 rename Documentation/filesystems/{sysv-fs.txt => sysv-fs.rst} (73%)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index bafe92c72433..d583b8b35196 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -88,5 +88,6 @@ Documentation for filesystem implementations.
    romfs
    squashfs
    sysfs
+   sysv-fs
    virtiofs
    vfat
diff --git a/Documentation/filesystems/sysv-fs.txt b/Documentation/filesystems/sysv-fs.rst
similarity index 73%
rename from Documentation/filesystems/sysv-fs.txt
rename to Documentation/filesystems/sysv-fs.rst
index 253b50d1328e..89e40911ad7c 100644
--- a/Documentation/filesystems/sysv-fs.txt
+++ b/Documentation/filesystems/sysv-fs.rst
@@ -1,25 +1,40 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================
+SystemV Filesystem
+==================
+
 It implements all of
   - Xenix FS,
   - SystemV/386 FS,
   - Coherent FS.
 
 To install:
+
 * Answer the 'System V and Coherent filesystem support' question with 'y'
   when configuring the kernel.
-* To mount a disk or a partition, use
+* To mount a disk or a partition, use::
+
     mount [-r] -t sysv device mountpoint
-  The file system type names
+
+  The file system type names::
+
                -t sysv
                -t xenix
                -t coherent
+
   may be used interchangeably, but the last two will eventually disappear.
 
 Bugs in the present implementation:
+
 - Coherent FS:
+
   - The "free list interleave" n:m is currently ignored.
   - Only file systems with no filesystem name and no pack name are recognized.
-  (See Coherent "man mkfs" for a description of these features.)
+    (See Coherent "man mkfs" for a description of these features.)
+
 - SystemV Release 2 FS:
+
   The superblock is only searched in the blocks 9, 15, 18, which
   corresponds to the beginning of track 1 on floppy disks. No support
   for this FS on hard disk yet.
@@ -28,12 +43,14 @@ Bugs in the present implementation:
 These filesystems are rather similar. Here is a comparison with Minix FS:
 
 * Linux fdisk reports on partitions
+
   - Minix FS     0x81 Linux/Minix
   - Xenix FS     ??
   - SystemV FS   ??
   - Coherent FS  0x08 AIX bootable
 
 * Size of a block or zone (data allocation unit on disk)
+
   - Minix FS     1024
   - Xenix FS     1024 (also 512 ??)
   - SystemV FS   1024 (also 512 and 2048)
@@ -45,37 +62,51 @@ These filesystems are rather similar. Here is a comparison with Minix FS:
   all the block numbers (including the super block) are offset by one track.
 
 * Byte ordering of "short" (16 bit entities) on disk:
+
   - Minix FS     little endian  0 1
   - Xenix FS     little endian  0 1
   - SystemV FS   little endian  0 1
   - Coherent FS  little endian  0 1
+
   Of course, this affects only the file system, not the data of files on it!
 
 * Byte ordering of "long" (32 bit entities) on disk:
+
   - Minix FS     little endian  0 1 2 3
   - Xenix FS     little endian  0 1 2 3
   - SystemV FS   little endian  0 1 2 3
   - Coherent FS  PDP-11         2 3 0 1
+
   Of course, this affects only the file system, not the data of files on it!
 
 * Inode on disk: "short", 0 means non-existent, the root dir ino is:
-  - Minix FS                            1
-  - Xenix FS, SystemV FS, Coherent FS   2
+
+  =================================  ==
+  Minix FS                            1
+  Xenix FS, SystemV FS, Coherent FS   2
+  =================================  ==
 
 * Maximum number of hard links to a file:
-  - Minix FS     250
-  - Xenix FS     ??
-  - SystemV FS   ??
-  - Coherent FS  >=10000
+
+  ===========  =========
+  Minix FS     250
+  Xenix FS     ??
+  SystemV FS   ??
+  Coherent FS  >=10000
+  ===========  =========
 
 * Free inode management:
-  - Minix FS                             a bitmap
+
+  - Minix FS
+      a bitmap
   - Xenix FS, SystemV FS, Coherent FS
       There is a cache of a certain number of free inodes in the super-block.
       When it is exhausted, new free inodes are found using a linear search.
 
 * Free block management:
-  - Minix FS                             a bitmap
+
+  - Minix FS
+      a bitmap
   - Xenix FS, SystemV FS, Coherent FS
       Free blocks are organized in a "free list". Maybe a misleading term,
       since it is not true that every free block contains a pointer to
@@ -86,13 +117,18 @@ These filesystems are rather similar. Here is a comparison with Minix FS:
       0 on Xenix FS and SystemV FS, with a block zeroed out on Coherent FS.
 
 * Super-block location:
-  - Minix FS     block 1 = bytes 1024..2047
-  - Xenix FS     block 1 = bytes 1024..2047
-  - SystemV FS   bytes 512..1023
-  - Coherent FS  block 1 = bytes 512..1023
+
+  ===========  ==========================
+  Minix FS     block 1 = bytes 1024..2047
+  Xenix FS     block 1 = bytes 1024..2047
+  SystemV FS   bytes 512..1023
+  Coherent FS  block 1 = bytes 512..1023
+  ===========  ==========================
 
 * Super-block layout:
-  - Minix FS
+
+  - Minix FS::
+
                     unsigned short s_ninodes;
                     unsigned short s_nzones;
                     unsigned short s_imap_blocks;
@@ -101,7 +137,9 @@ These filesystems are rather similar. Here is a comparison with Minix FS:
                     unsigned short s_log_zone_size;
                     unsigned long s_max_size;
                     unsigned short s_magic;
-  - Xenix FS, SystemV FS, Coherent FS
+
+  - Xenix FS, SystemV FS, Coherent FS::
+
                     unsigned short s_firstdatazone;
                     unsigned long  s_nzones;
                     unsigned short s_fzone_count;
@@ -120,23 +158,33 @@ These filesystems are rather similar. Here is a comparison with Minix FS:
                     unsigned short s_interleave_m,s_interleave_n; -- Coherent FS only
                     char           s_fname[6];
                     char           s_fpack[6];
+
     then they differ considerably:
-        Xenix FS
+
+        Xenix FS::
+
                     char           s_clean;
                     char           s_fill[371];
                     long           s_magic;
                     long           s_type;
-        SystemV FS
+
+        SystemV FS::
+
                     long           s_fill[12 or 14];
                     long           s_state;
                     long           s_magic;
                     long           s_type;
-        Coherent FS
+
+        Coherent FS::
+
                     unsigned long  s_unique;
+
     Note that Coherent FS has no magic.
 
 * Inode layout:
-  - Minix FS
+
+  - Minix FS::
+
                     unsigned short i_mode;
                     unsigned short i_uid;
                     unsigned long  i_size;
@@ -144,7 +192,9 @@ These filesystems are rather similar. Here is a comparison with Minix FS:
                     unsigned char  i_gid;
                     unsigned char  i_nlinks;
                     unsigned short i_zone[7+1+1];
-  - Xenix FS, SystemV FS, Coherent FS
+
+  - Xenix FS, SystemV FS, Coherent FS::
+
                     unsigned short i_mode;
                     unsigned short i_nlink;
                     unsigned short i_uid;
@@ -155,38 +205,55 @@ These filesystems are rather similar. Here is a comparison with Minix FS:
                     unsigned long  i_mtime;
                     unsigned long  i_ctime;
 
+
 * Regular file data blocks are organized as
-  - Minix FS
-               7 direct blocks
-               1 indirect block (pointers to blocks)
-               1 double-indirect block (pointer to pointers to blocks)
-  - Xenix FS, SystemV FS, Coherent FS
-              10 direct blocks
-               1 indirect block (pointers to blocks)
-               1 double-indirect block (pointer to pointers to blocks)
-               1 triple-indirect block (pointer to pointers to pointers to blocks)
-
-* Inode size, inodes per block
-  - Minix FS        32   32
-  - Xenix FS        64   16
-  - SystemV FS      64   16
-  - Coherent FS     64    8
+
+  - Minix FS:
+
+             - 7 direct blocks
+	     - 1 indirect block (pointers to blocks)
+             - 1 double-indirect block (pointer to pointers to blocks)
+
+  - Xenix FS, SystemV FS, Coherent FS:
+
+             - 10 direct blocks
+             -  1 indirect block (pointers to blocks)
+             -  1 double-indirect block (pointer to pointers to blocks)
+             -  1 triple-indirect block (pointer to pointers to pointers to blocks)
+
+
+  ===========  ==========   ================
+               Inode size   inodes per block
+  ===========  ==========   ================
+  Minix FS        32        32
+  Xenix FS        64        16
+  SystemV FS      64        16
+  Coherent FS     64        8
+  ===========  ==========   ================
 
 * Directory entry on disk
-  - Minix FS
+
+  - Minix FS::
+
                     unsigned short inode;
                     char name[14/30];
-  - Xenix FS, SystemV FS, Coherent FS
+
+  - Xenix FS, SystemV FS, Coherent FS::
+
                     unsigned short inode;
                     char name[14];
 
-* Dir entry size, dir entries per block
-  - Minix FS     16/32    64/32
-  - Xenix FS     16       64
-  - SystemV FS   16       64
-  - Coherent FS  16       32
+  ===========    ==============    =====================
+                 Dir entry size    dir entries per block
+  ===========    ==============    =====================
+  Minix FS       16/32             64/32
+  Xenix FS       16                64
+  SystemV FS     16                64
+  Coherent FS    16                32
+  ===========    ==============    =====================
 
 * How to implement symbolic links such that the host fsck doesn't scream:
+
   - Minix FS     normal
   - Xenix FS     kludge: as regular files with  chmod 1000
   - SystemV FS   ??
-- 
2.24.1

