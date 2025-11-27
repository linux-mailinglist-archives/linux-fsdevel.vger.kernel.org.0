Return-Path: <linux-fsdevel+bounces-69964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EB2C8CD22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 06:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4755E3AEA01
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 05:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E977D30F7EF;
	Thu, 27 Nov 2025 05:00:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D692030F53C
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 05:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764219604; cv=none; b=OwMtHX6cckiDDkPwxtqVAKphHUmn9xY4S/1HNwkK53NNCoAnvANTms61GW2Y9xBDnNZkmpmMBxL8On2goU/lSfp6evQZxORYpDzNgvRYraG+7GEGN/JnrKon69tpQq8bcGSLsNLxl6f52/hdQ0CZNXOnM1u9WBPFwQR5tQQ0Aeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764219604; c=relaxed/simple;
	bh=nWSIqg5X4LGeGzycH9gfcqd2DZzE84pdVf76E+Jmi2k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XOF1s6H3yKLF8KXR9CufFw8vdv/TuHz0KFLCL+TGuPk2XLV45fEL0WYh0uIozj1lu8gk2kTQaBkp772svwv9vDkfGVNV3E4Y+kK4exjMBhpi0ctKltxgSEAC+6M8ohnh+OYibaoBqxv4iw01xOs/0OMS8kM76xd3oBO/ueKhBX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2984dfae0acso7419405ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 21:00:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764219601; x=1764824401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5/bo6ifLEqt8kven0U54JheFeMDGDXyYWEuxiiYsYI=;
        b=WmcVIuEwqk2Ujm3O8jo+XPRV2cCYzIKh6XtbJvDmahsWESNLKWZZmoZAvv4XaTueS/
         K/Jf6yKRp5auaU7d7zD9LfQlXPzgildzZJtHrHb/0npFROLnw/KPcdbBD6oKW16Xttv5
         5qbdnN9NaFoj2DukNFApbUr4wJPxyPnB2NW4wdj+NjnaGEPKJ8QddN8lzALjHIFRVBC2
         Z86cYdCognjmvGuLM4SytCR5WElFnpCs7yuAo1rJyBSjoT6xLhd7Cw1MWCH3DU0+9AZe
         DUKl2kdAjgL9YDpnK7/NTFybFPuPSoHD803ma+8qfIFJfLVjuDapegBorvJtnGetEL2G
         86IQ==
X-Gm-Message-State: AOJu0Yzrgx/5p6urqmBR2hRxuL+ZRIEhTY5eJkQP2WhYA6jhPSlp3dHO
	st8wlUwWKksE1HZF9cp1AV2EEfgTnEPTdFMVbKEJq/5jakESpYIJn3r8
X-Gm-Gg: ASbGncu8eyEEYQL/GSfEM5XTt0Wh1xbHA7q779lGluXNJqePk46d0tGiWtRETuRd3w+
	E9xyBM4/29xqvUeJf6FsIxkoBTtpQ+Opmq5FtZwQfpKWLYSqvgvMw8jk/RHTi5csKMvQwEJi0jS
	3Beu1Fnh5dW13WLY0Jg7NOj5nqF0Wu8sL+dN8qPO/1ZTnWWQHOLhx5g6EAsoQNv4W3r+hykVC29
	R1JKPp+0VgvgS3g+bBU5UPFVhLs4BPV6AN/6z4v73UjcpckyRDMs9sImJxxHlX7zh3TpyF+zkeG
	cbI1+xdmVJ9FF4pe8iyWJEseXkMR1vOcxYJXfDR+ScLWDIesqIhVerg01V9nO0EJDbsfNsGbHjP
	w1nSW4Pr9tuYwhhZQD/ogXJ8HVgp4056aoG6NyzmrfBwsGjTNYsvZ0mrlmgkfjTYmGBn1CjZi3d
	bkNLO/SvJLBsVqcIg36MENGHdN4g==
X-Google-Smtp-Source: AGHT+IGQhF3qzIldMeMoD7oFCvWLyKwW6+0v4RS+Uim+uMbN9FHdvPNlD4qZi948RKTllE+hxvZoCw==
X-Received: by 2002:a17:903:3b86:b0:297:e59c:63cc with SMTP id d9443c01a7336-29bab148c59mr111051815ad.35.1764219601059;
        Wed, 26 Nov 2025 21:00:01 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb54454sm2719825ad.84.2025.11.26.20.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 20:59:59 -0800 (PST)
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
Subject: [PATCH v2 00/11] ntfsplus: ntfs filesystem remake
Date: Thu, 27 Nov 2025 13:59:33 +0900
Message-Id: <20251127045944.26009-1-linkinjeon@kernel.org>
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


What is ntfsplus?
=================

The remade ntfs called ntfsplus is an implementation that supports write
and the essential requirements(iomap, no buffer-head, utilities, xfstests
test result) based on read-only classic NTFS.
The old read-only ntfs code is much cleaner, with extensive comments,
offers readability that makes understanding NTFS easier. This is why
ntfsplus was developed on old read-only NTFS base.
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

   - ntfsplus vs. ntfs3:

     * Performance was benchmarked using iozone with various chunk size.
        - In single-thread(1T) write tests, ntfsplus show approximately
          3~5% better performance.
        - In multi-thread(4T) write tests, ntfsplus show approximately
          35~110% better performance.
        - Read throughput is identical for both ntfs implementations.

     1GB file      size:4096           size:16384           size:65536
     MB/sec   ntfsplus | ntfs3    ntfsplus | ntfs3    ntfsplus | ntfs3
     ─────────────────────────────────────────────────────────────────
     read          399 | 399           426 | 424           429 | 430
     ─────────────────────────────────────────────────────────────────
     write(1T)     291 | 276           325 | 305           333 | 317
     write(4T)     105 | 50            113 | 78            114 | 99.6


     * File list browsing performance. (about 12~14% faster)

                  files:100000        files:200000        files:400000
     Sec      ntfsplus | ntfs3    ntfsplus | ntfs3    ntfsplus | ntfs3
     ─────────────────────────────────────────────────────────────────
     ls -lR       7.07 | 8.10        14.03 | 16.35       28.27 | 32.86


     * mount time.

             parti_size:1TB      parti_size:2TB      parti_size:4TB
     Sec      ntfsplus | ntfs3    ntfsplus | ntfs3    ntfsplus | ntfs3
     ─────────────────────────────────────────────────────────────────
     mount        0.38 | 2.03         0.39 | 2.25         0.70 | 4.51

   The following are the reasons why ntfsplus performance is higher
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
      ntfsplus passed 287 tests, significantly higher than ntfs3's 218.
      ntfsplus implement fallocate, idmapped mount and permission, etc,
      resulting in a significantly high number of xfstests passing compared
      to ntfs3.
   b. Bonnie++ issue[3]:
      The Bonnie++ benchmark fails on ntfs3 with a "Directory not empty"
      error during file deletion. ntfs3 currently iterates directory
      entries by reading index blocks one by one. When entries are deleted
      concurrently, index block merging or entry relocation can cause
      readdir() to skip some entries, leaving files undeleted in
      workloads(bonnie++) that mix unlink and directory scans.
      ntfsplus implement leaf chain traversal in readdir to avoid entry skip
      on deletion.

- Journaling support:
   ntfs3 does not provide full journaling support. It only implement journal
   replay[4], which in our testing did not function correctly. My next task
   after upstreaming will be to add full journal support to ntfsplus.


The feature comparison summary
==============================

Feature                               ntfsplus   ntfs3
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

Namjae Jeon (11):
  ntfsplus: in-memory, on-disk structures and headers
  ntfsplus: add super block operations
  ntfsplus: add inode operations
  ntfsplus: add directory operations
  ntfsplus: add file operations
  ntfsplus: add iomap and address space operations
  ntfsplus: add attrib operatrions
  ntfsplus: add runlist handling and cluster allocator
  ntfsplus: add reparse and ea operations
  ntfsplus: add misc operations
  ntfsplus: add Kconfig and Makefile

 Documentation/filesystems/index.rst    |    1 +
 Documentation/filesystems/ntfsplus.rst |  199 +
 fs/Kconfig                             |    1 +
 fs/Makefile                            |    1 +
 fs/ntfsplus/Kconfig                    |   45 +
 fs/ntfsplus/Makefile                   |   18 +
 fs/ntfsplus/aops.c                     |  617 +++
 fs/ntfsplus/aops.h                     |   92 +
 fs/ntfsplus/attrib.c                   | 5377 ++++++++++++++++++++++++
 fs/ntfsplus/attrib.h                   |  159 +
 fs/ntfsplus/attrlist.c                 |  285 ++
 fs/ntfsplus/attrlist.h                 |   21 +
 fs/ntfsplus/bitmap.c                   |  290 ++
 fs/ntfsplus/bitmap.h                   |   93 +
 fs/ntfsplus/collate.c                  |  178 +
 fs/ntfsplus/collate.h                  |   37 +
 fs/ntfsplus/compress.c                 | 1564 +++++++
 fs/ntfsplus/dir.c                      | 1230 ++++++
 fs/ntfsplus/dir.h                      |   33 +
 fs/ntfsplus/ea.c                       |  931 ++++
 fs/ntfsplus/ea.h                       |   25 +
 fs/ntfsplus/file.c                     | 1142 +++++
 fs/ntfsplus/index.c                    | 2112 ++++++++++
 fs/ntfsplus/index.h                    |  127 +
 fs/ntfsplus/inode.c                    | 3729 ++++++++++++++++
 fs/ntfsplus/inode.h                    |  353 ++
 fs/ntfsplus/layout.h                   | 2288 ++++++++++
 fs/ntfsplus/lcnalloc.c                 | 1012 +++++
 fs/ntfsplus/lcnalloc.h                 |  127 +
 fs/ntfsplus/logfile.c                  |  770 ++++
 fs/ntfsplus/logfile.h                  |  316 ++
 fs/ntfsplus/mft.c                      | 2698 ++++++++++++
 fs/ntfsplus/mft.h                      |   92 +
 fs/ntfsplus/misc.c                     |  213 +
 fs/ntfsplus/misc.h                     |  218 +
 fs/ntfsplus/mst.c                      |  195 +
 fs/ntfsplus/namei.c                    | 1677 ++++++++
 fs/ntfsplus/ntfs.h                     |  180 +
 fs/ntfsplus/ntfs_iomap.c               |  700 +++
 fs/ntfsplus/ntfs_iomap.h               |   22 +
 fs/ntfsplus/reparse.c                  |  550 +++
 fs/ntfsplus/reparse.h                  |   15 +
 fs/ntfsplus/runlist.c                  | 1983 +++++++++
 fs/ntfsplus/runlist.h                  |   91 +
 fs/ntfsplus/super.c                    | 2865 +++++++++++++
 fs/ntfsplus/unistr.c                   |  473 +++
 fs/ntfsplus/upcase.c                   |   73 +
 fs/ntfsplus/volume.h                   |  254 ++
 include/uapi/linux/ntfs.h              |   23 +
 49 files changed, 35495 insertions(+)
 create mode 100644 Documentation/filesystems/ntfsplus.rst
 create mode 100644 fs/ntfsplus/Kconfig
 create mode 100644 fs/ntfsplus/Makefile
 create mode 100644 fs/ntfsplus/aops.c
 create mode 100644 fs/ntfsplus/aops.h
 create mode 100644 fs/ntfsplus/attrib.c
 create mode 100644 fs/ntfsplus/attrib.h
 create mode 100644 fs/ntfsplus/attrlist.c
 create mode 100644 fs/ntfsplus/attrlist.h
 create mode 100644 fs/ntfsplus/bitmap.c
 create mode 100644 fs/ntfsplus/bitmap.h
 create mode 100644 fs/ntfsplus/collate.c
 create mode 100644 fs/ntfsplus/collate.h
 create mode 100644 fs/ntfsplus/compress.c
 create mode 100644 fs/ntfsplus/dir.c
 create mode 100644 fs/ntfsplus/dir.h
 create mode 100644 fs/ntfsplus/ea.c
 create mode 100644 fs/ntfsplus/ea.h
 create mode 100644 fs/ntfsplus/file.c
 create mode 100644 fs/ntfsplus/index.c
 create mode 100644 fs/ntfsplus/index.h
 create mode 100644 fs/ntfsplus/inode.c
 create mode 100644 fs/ntfsplus/inode.h
 create mode 100644 fs/ntfsplus/layout.h
 create mode 100644 fs/ntfsplus/lcnalloc.c
 create mode 100644 fs/ntfsplus/lcnalloc.h
 create mode 100644 fs/ntfsplus/logfile.c
 create mode 100644 fs/ntfsplus/logfile.h
 create mode 100644 fs/ntfsplus/mft.c
 create mode 100644 fs/ntfsplus/mft.h
 create mode 100644 fs/ntfsplus/misc.c
 create mode 100644 fs/ntfsplus/misc.h
 create mode 100644 fs/ntfsplus/mst.c
 create mode 100644 fs/ntfsplus/namei.c
 create mode 100644 fs/ntfsplus/ntfs.h
 create mode 100644 fs/ntfsplus/ntfs_iomap.c
 create mode 100644 fs/ntfsplus/ntfs_iomap.h
 create mode 100644 fs/ntfsplus/reparse.c
 create mode 100644 fs/ntfsplus/reparse.h
 create mode 100644 fs/ntfsplus/runlist.c
 create mode 100644 fs/ntfsplus/runlist.h
 create mode 100644 fs/ntfsplus/super.c
 create mode 100644 fs/ntfsplus/unistr.c
 create mode 100644 fs/ntfsplus/upcase.c
 create mode 100644 fs/ntfsplus/volume.h
 create mode 100644 include/uapi/linux/ntfs.h

-- 
2.25.1


