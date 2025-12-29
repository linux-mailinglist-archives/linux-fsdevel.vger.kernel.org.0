Return-Path: <linux-fsdevel+bounces-72171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B47BCCE6B9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 13:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B27523009483
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 12:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6262531076B;
	Mon, 29 Dec 2025 12:39:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE053101CD
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767011975; cv=none; b=HkL228RTrvbru0/I6bDrh5fsmZqrGJ/kQtCNEfI5Aed2OP+5ZdW/SoFG6izYDK4/r6wbvkfJbrXS+6Qu+qC1yj8hJMk67EZ9JxFNBKAHP/aF8bjU8pq10nML5QfNJS5HR4dptO7iK6J12l/RsRtHtTJkosbCR+VY6QIx+KhTfEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767011975; c=relaxed/simple;
	bh=/BMw9SfeaG4lZecTY+wJqCI4GnHR4YekFkxyp2RQe1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rKbVG3iS6k5hwoLPoy1USN2EMBlM3uu56uTY2y1SE53HSy8WuvO25EBwmHL31t2Paml781LEa1VNXqVLXbi80WERh+sF+KSG5Aw2Rip2ySD/XgN9sYroeffclrjlv7YENmFGHD5xbWh0cFXVQAO9+qZHmZW7fWMh/WFExPm9Y2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5598b58d816so6597210e0c.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 04:39:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767011973; x=1767616773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeJZCsiJu0hg4WCg5w3/1QTEd+MZfY5RusaamVAsNjQ=;
        b=IfTwSaLOstx/BuYvsBsq9ulXk9iByW3uI+/tpbxkpGOWXwicvNCws5+7OG/HNcjd/W
         8Wn6pKOldWVpdtURux2Lo8Mc1Jo/WymyFWErmNZ3ULwKW/OtqKdYg3l1HjxcftvnynXi
         Pf73isO5IvRN8McNsCoVAmVYGKiOGtVD0I3tcfP9D9RYmZ20WFgCWTXBbqpgA/hfHbrD
         r2bC5sRuRLsFfOITpE2/1M+jTsVSyeK0/pMk3iSMonIiInS8CfkREuxcoPLvRi0SX3zy
         TNKpUW4EVC1F+ZdHtPFFnysEr97kN8gUQ8m+Ja0LI97tRnGUFUrzm9qL460vtuBP7FPE
         DLww==
X-Gm-Message-State: AOJu0Yy6+Rp2yiLdrn0Vafej02pkJcZ2oVsB6nvMZRxC4Q9zvsrdjajs
	Dv3LWZgbrTx5qNKrd2RrN9k3DyODC+G/1CzY8bJ39neCEJCbxRkg7D8gqthMMw==
X-Gm-Gg: AY/fxX6FxWNN4LNV9fUr033FgtwQS3z2mZ7kKdJMoepH9eCflpNySP7Az4ZTH0yATz5
	kG+nJroSrYHR1zYGe36nRR7njY6ffHhNsBXJONnMAeq54iE4HXvVQX0zU4Ukg5+Ofr9R2jqZuQx
	PvcxOvycN1dRyvY7zeOKkkxA6xUVo//F890WywUQZem4VAVoGWNhAMWzMwzCktego9uTv8PxO+f
	o3QL6ckM3X/3G/Gg/9weIKy37W8+JlMvyGSVN+A0D0sw2B6y1dbTNA3Qbl31ZY6jBa4KzWAw7hI
	UWhj98J+DXgNyyc/gqeDFeul+S6XlfCV+nbt0OBxWv8lPuXooH2Cimr1Q0XPOsW123IJFUZSsGL
	XFDmA5N6EPSKJN5yiW50bLJkU07chy8+3HZOTetUVV5GFfvhrAaF3vxZ5Ra9S0cwyt0I9U8v5yV
	zupX2/VLIK0ZtHJt9IVEIslfI8OA==
X-Google-Smtp-Source: AGHT+IGcZZJvMTOMQGL+sMZ6iiQpNfr+dtbpIGUEOTq1ey5o7h/YHBmf4pQMurGkoFfDv1ycFMl0YQ==
X-Received: by 2002:a05:6a21:3086:b0:366:187c:55 with SMTP id adf61e73a8af0-376a4c66ccamr28371557637.0.1767006026507;
        Mon, 29 Dec 2025 03:00:26 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7aa328basm29320722b3a.11.2025.12.29.03.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 03:00:25 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hch@infradead.org,
	hch@lst.de,
	tytso@mit.edu,
	willy@infradead.org,
	jack@suse.cz,
	djwong@kernel.org,
	josef@toxicpanda.com,
	sandeen@sandeen.net,
	rgoldwyn@suse.com,
	xiang@kernel.org,
	dsterba@suse.com,
	pali@kernel.org,
	ebiggers@kernel.org,
	neil@brown.name,
	amir73il@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com,
	jay.sim@lge.com,
	gunho.lee@lge.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v3 00/12] ntfs filesystem remake
Date: Mon, 29 Dec 2025 19:59:18 +0900
Message-Id: <20251229105932.11360-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduction
============

The NTFS filesystem[1] still remains the default filesystem for Windows
and The well-maintained NTFS driver in the Linux kernel enhances
interoperability with Windows devices, making it easier for Linux users
to work with NTFS-formatted drives. Currently, ntfs support in Linux was
the long-neglected NTFS Classic (read-only), which has been removed from
the Linux kernel, leaving the poorly maintained ntfs3. ntfs3 still has
many problems and is poorly maintained, so users and distributions are
still using the old legacy ntfs-3g.

The remade ntfs is an implementation that supports write and the essential
requirements(iomap, no buffer-head, utilities, xfstests test result) based
on read-only classic NTFS.
The old read-only ntfs code is much cleaner, with extensive comments,
offers readability that makes understanding NTFS easier. This is why
new ntfs was developed on old read-only NTFS base.
The target is to provide current trends(iomap, no buffer head, folio),
enhanced performance, stable maintenance, utility support including fsck.


Key Features
============

- Write support:
   Implement write support on classic read-only NTFS. Additionally,
   integrate delayed allocation to enhance write performance through
   multi-cluster allocation and minimized fragmentation of cluster bitmap.

- Switch to using iomap:
   Use iomap for buffered IO writes, reads, direct IO, file extent mapping,
   readpages, writepages operations.

- Stop using the buffer head:
   The use of buffer head in old ntfs and switched to use folio instead.
   As a result, CONFIG_BUFFER_HEAD option enable is removed in Kconfig also.

- Public utilities include fsck[2]:
   While ntfs-3g includes ntfsprogs as a component, it notably lacks
   the fsck implementation. So we have launched a new ntfs utilitiies
   project called ntfsprogs-plus by forking from ntfs-3g after removing
   unnecessary ntfs fuse implementation. fsck.ntfs can be used for ntfs
   testing with xfstests as well as for recovering corrupted NTFS device.

- Performance Enhancements:

   - ntfs vs. ntfs3:

     * Performance was benchmarked using iozone with various chunk size.
        - In single-thread(1T) write tests, ntfs show approximately
          3~5% better performance.
        - In multi-thread(4T) write tests, ntfs show approximately
          35~110% better performance.
        - Read throughput is identical for both ntfs implementations.

     1GB file      size:4096           size:16384           size:65536
     MB/sec       ntfs | ntfs3        ntfs | ntfs3        ntfs | ntfs3
     ─────────────────────────────────────────────────────────────────
     read          399 | 399           426 | 424           429 | 430
     ─────────────────────────────────────────────────────────────────
     write(1T)     291 | 276           325 | 305           333 | 317
     write(4T)     105 | 50            113 | 78            114 | 99.6


     * File list browsing performance. (about 12~14% faster)

                  files:100000        files:200000        files:400000
     Sec          ntfs | ntfs3        ntfs | ntfs3        ntfs | ntfs3
     ─────────────────────────────────────────────────────────────────
     ls -lR       7.07 | 8.10        14.03 | 16.35       28.27 | 32.86


     * mount time.

             parti_size:1TB      parti_size:2TB      parti_size:4TB
     Sec          ntfs | ntfs3        ntfs | ntfs3        ntfs | ntfs3
     ─────────────────────────────────────────────────────────────────
     mount        0.38 | 2.03         0.39 | 2.25         0.70 | 4.51

   The following are the reasons why ntfs performance is higher
    compared to ntfs3:
     - Use iomap aops.
     - Delayed allocation support.
     - Optimize zero out for newly allocated clusters.
     - Optimize runlist merge overhead with small chunck size.
     - pre-load mft(inode) blocks and index(dentry) blocks to improve
       readdir + stat performance.
     - Load lcn bitmap on background.

- Stability improvement:
   a. Pass more xfstests tests:
      ntfs passed 287 tests, significantly higher than ntfs3's 218.
      ntfs implement fallocate, idmapped mount and permission, etc,
      resulting in a significantly high number of xfstests passing compared
      to ntfs3.
   b. Bonnie++ issue[3]:
      The Bonnie++ benchmark fails on ntfs3 with a "Directory not empty"
      error during file deletion. ntfs3 currently iterates directory
      entries by reading index blocks one by one. When entries are deleted
      concurrently, index block merging or entry relocation can cause
      readdir() to skip some entries, leaving files undeleted in
      workloads(bonnie++) that mix unlink and directory scans.
      ntfs implement leaf chain traversal in readdir to avoid entry skip
      on deletion.

- Journaling support:
   ntfs3 does not provide full journaling support. It only implement journal
   replay[4], which in our testing did not function correctly. My next task
   after upstreaming will be to add full journal support to ntfs.


The feature comparison summary
==============================

Feature                               ntfs       ntfs3
===================================   ========   ===========
Write support                         Yes        Yes
iomap support                         Yes        No
No buffer head                        Yes        No
Public utilities(mkfs, fsck, etc.)    Yes        No
xfstests passed                       287        218
Idmapped mount                        Yes        No
Delayed allocation                    Yes        No
Bonnie++                              Pass       Fail
Journaling                            Planned    Inoperative
===================================   ========   ===========


References
==========
[1] https://en.wikipedia.org/wiki/NTFS
[2] https://github.com/ntfsprogs-plus/ntfsprogs-plus
[3] https://lore.kernel.org/ntfs3/CAOZgwEd7NDkGEpdF6UQTcbYuupDavaHBoj4WwTy3Qe4Bqm6V0g@mail.gmail.com/
[4] https://marc.info/?l=linux-fsdevel&m=161738417018673&q=mbox


Available in the Git repository at:
===================================
git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/ntfs.git ntfs-next

v3:
 - Add generic helpers to convert cluster to folio index, cluster to
   byte, byte to sector, etc.
 - Remove bio null check and ntfs_setup_bio().
 - Remove unneeded extra handling from old ntfs leftover.
 - Allow readahead for $MFT file.
 - Change memcpy to memcpy_from_folio or memcpy_to_folio.
 - Never switche between compressed and non-compressed for live inodes.
 - Add the comments for iomap_valid and iomap_put_folio.
 - Split the resident and non-resident cases into separate helpers.
 - Use kmalloc instead of page allocation for iomap inline data.
 - Use iomap_zero_range instead of ntfs_buffered_zero_clusters.
 - Use blkdev_issue_zeroout instead of ntfs_zero_clusters.
 - Remove 2TB limitation on 32-bit system.
 - Rename ntfsplus to ntfs.
 - Remove -EINTR handing for read_mapping_folio.
 - Rename ntfs_iomap.c to iomap.c
 - Revert alias for the legacy ntfs driver in ntfs3.
 - Restrict built-in NTFS seclection to one driver, allow both as
   modules.
 - Use static_assert() instead of the sizeof comments.
 - Update the wrong iocharset comments in ntfs.rst.

v2:
 - Add ntfs3-compatible mount options(sys_immutable, nohidden,
   hide_dot_files, nocase, acl, windows_names, disable_sparse, discard).
 - Add iocharset mount option.
 - Add ntfs3-compatible dos attribute and ntfs attribute load/store
   in setxattr/getattr().
 - Add support for FS_IOC_{GET,SET}FSLABEL ioctl.
 - Add support for FITRIM ioctl.
 - Fix the warnings(duplicate symbol, __divdi3, etc) from kernel test robot.
 - Prefix pr_xxx() with ntfsplus.
 - Add support for $MFT File extension.
 - Add Documentation/filesystems/ntfsplus.rst.
 - Mark experimental.
 - Remove BUG traps warnings from checkpatch.pl.

Namjae Jeon (14):
  Revert "fs: Remove NTFS classic"
  ntfs: update in-memory, on-disk structures and headers
  ntfs: update super block operations
  ntfs: update inode operations
  ntfs: update directory operations
  ntfs: update file operations
  ntfs: update iomap and address space operations
  ntfs: update attrib operations
  ntfs: update runlist handling and cluster allocator
  ntfs: add reparse and ea operations
  ntfs: update misc operations
  Revert: ntfs3: serve as alias for the legacy ntfs driver
  ntfs: add Kconfig and Makefile
  MAINTAINERS: add ntfs filesystem

 Documentation/filesystems/index.rst |    1 +
 Documentation/filesystems/ntfs.rst  |  203 +
 MAINTAINERS                         |    9 +
 fs/Kconfig                          |   18 +
 fs/Makefile                         |    1 +
 fs/ntfs/Kconfig                     |   46 +
 fs/ntfs/Makefile                    |   18 +
 fs/ntfs/aops.c                      |  543 +++
 fs/ntfs/aops.h                      |   24 +
 fs/ntfs/attrib.c                    | 5384 +++++++++++++++++++++++++++
 fs/ntfs/attrib.h                    |  159 +
 fs/ntfs/attrlist.c                  |  285 ++
 fs/ntfs/attrlist.h                  |   21 +
 fs/ntfs/bitmap.c                    |  292 ++
 fs/ntfs/bitmap.h                    |   93 +
 fs/ntfs/collate.c                   |  178 +
 fs/ntfs/collate.h                   |   37 +
 fs/ntfs/compress.c                  | 1559 ++++++++
 fs/ntfs/debug.c                     |  171 +
 fs/ntfs/debug.h                     |   63 +
 fs/ntfs/dir.c                       | 1229 ++++++
 fs/ntfs/dir.h                       |   33 +
 fs/ntfs/ea.c                        |  933 +++++
 fs/ntfs/ea.h                        |   25 +
 fs/ntfs/endian.h                    |   79 +
 fs/ntfs/file.c                      | 1142 ++++++
 fs/ntfs/index.c                     | 2115 +++++++++++
 fs/ntfs/index.h                     |  127 +
 fs/ntfs/inode.c                     | 3793 +++++++++++++++++++
 fs/ntfs/inode.h                     |  354 ++
 fs/ntfs/iomap.c                     |  755 ++++
 fs/ntfs/iomap.h                     |   22 +
 fs/ntfs/layout.h                    | 2291 ++++++++++++
 fs/ntfs/lcnalloc.c                  | 1014 +++++
 fs/ntfs/lcnalloc.h                  |  127 +
 fs/ntfs/logfile.c                   |  775 ++++
 fs/ntfs/logfile.h                   |  316 ++
 fs/ntfs/malloc.h                    |  100 +
 fs/ntfs/mft.c                       | 2691 +++++++++++++
 fs/ntfs/mft.h                       |   92 +
 fs/ntfs/mst.c                       |  195 +
 fs/ntfs/namei.c                     | 1678 +++++++++
 fs/ntfs/ntfs.h                      |  200 +
 fs/ntfs/quota.c                     |   97 +
 fs/ntfs/quota.h                     |   16 +
 fs/ntfs/reparse.c                   |  550 +++
 fs/ntfs/reparse.h                   |   15 +
 fs/ntfs/runlist.c                   | 1983 ++++++++++
 fs/ntfs/runlist.h                   |   93 +
 fs/ntfs/super.c                     | 2777 ++++++++++++++
 fs/ntfs/sysctl.c                    |   56 +
 fs/ntfs/sysctl.h                    |   27 +
 fs/ntfs/time.h                      |   87 +
 fs/ntfs/types.h                     |   55 +
 fs/ntfs/unistr.c                    |  473 +++
 fs/ntfs/upcase.c                    |   73 +
 fs/ntfs/volume.h                    |  254 ++
 fs/ntfs3/Kconfig                    |    9 -
 fs/ntfs3/dir.c                      |    9 -
 fs/ntfs3/file.c                     |   10 -
 fs/ntfs3/inode.c                    |   16 +-
 fs/ntfs3/ntfs_fs.h                  |   11 -
 fs/ntfs3/super.c                    |   52 -
 include/uapi/linux/ntfs.h           |   23 +
 64 files changed, 35774 insertions(+), 103 deletions(-)
 create mode 100644 Documentation/filesystems/ntfs.rst
 create mode 100644 fs/ntfs/Kconfig
 create mode 100644 fs/ntfs/Makefile
 create mode 100644 fs/ntfs/aops.c
 create mode 100644 fs/ntfs/aops.h
 create mode 100644 fs/ntfs/attrib.c
 create mode 100644 fs/ntfs/attrib.h
 create mode 100644 fs/ntfs/attrlist.c
 create mode 100644 fs/ntfs/attrlist.h
 create mode 100644 fs/ntfs/bitmap.c
 create mode 100644 fs/ntfs/bitmap.h
 create mode 100644 fs/ntfs/collate.c
 create mode 100644 fs/ntfs/collate.h
 create mode 100644 fs/ntfs/compress.c
 create mode 100644 fs/ntfs/debug.c
 create mode 100644 fs/ntfs/debug.h
 create mode 100644 fs/ntfs/dir.c
 create mode 100644 fs/ntfs/dir.h
 create mode 100644 fs/ntfs/ea.c
 create mode 100644 fs/ntfs/ea.h
 create mode 100644 fs/ntfs/endian.h
 create mode 100644 fs/ntfs/file.c
 create mode 100644 fs/ntfs/index.c
 create mode 100644 fs/ntfs/index.h
 create mode 100644 fs/ntfs/inode.c
 create mode 100644 fs/ntfs/inode.h
 create mode 100644 fs/ntfs/iomap.c
 create mode 100644 fs/ntfs/iomap.h
 create mode 100644 fs/ntfs/layout.h
 create mode 100644 fs/ntfs/lcnalloc.c
 create mode 100644 fs/ntfs/lcnalloc.h
 create mode 100644 fs/ntfs/logfile.c
 create mode 100644 fs/ntfs/logfile.h
 create mode 100644 fs/ntfs/malloc.h
 create mode 100644 fs/ntfs/mft.c
 create mode 100644 fs/ntfs/mft.h
 create mode 100644 fs/ntfs/mst.c
 create mode 100644 fs/ntfs/namei.c
 create mode 100644 fs/ntfs/ntfs.h
 create mode 100644 fs/ntfs/quota.c
 create mode 100644 fs/ntfs/quota.h
 create mode 100644 fs/ntfs/reparse.c
 create mode 100644 fs/ntfs/reparse.h
 create mode 100644 fs/ntfs/runlist.c
 create mode 100644 fs/ntfs/runlist.h
 create mode 100644 fs/ntfs/super.c
 create mode 100644 fs/ntfs/sysctl.c
 create mode 100644 fs/ntfs/sysctl.h
 create mode 100644 fs/ntfs/time.h
 create mode 100644 fs/ntfs/types.h
 create mode 100644 fs/ntfs/unistr.c
 create mode 100644 fs/ntfs/upcase.c
 create mode 100644 fs/ntfs/volume.h
 create mode 100644 include/uapi/linux/ntfs.h

-- 
2.25.1


