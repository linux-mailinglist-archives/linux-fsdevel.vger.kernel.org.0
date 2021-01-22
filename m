Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6EE1300E15
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 21:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbhAVUti (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 15:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730111AbhAVUsD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:48:03 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F56C06178B
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:47:16 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id c132so4621796pga.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SbGUA0qvIztEUivipPk+uMPWbkIun+CS9rfwLtftEGA=;
        b=VNTaJQyzqgMUf2bykgCnP/0Smb9RZ3fUkY1bEEk0/v6X4HX6oU3NemRHThtrG/kbcX
         X3w5dDAAhHOK5QHszpgqjOM9XEgwqx5MIf92WdRwsZguEkhOLh9s5uTpvJSJ3F9O74cP
         0G93EHMthoPDEY/0FZWvccvTreM7iKLv/ykz5mVpaDk4+snLs0gJNLNYiB9TLxbyj5aN
         dGduN1uYnike/yE+BktozbvjaYaGjENqSNaEo/abdjPidhrWi5goDiSz7SPPfk3KfCz1
         VPZYmI1mxOix4FZV5zs0VXMv2i8iJhAMnprc4RxaQEx076n4+22aJ0SCBacBCTq9yJEM
         iHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SbGUA0qvIztEUivipPk+uMPWbkIun+CS9rfwLtftEGA=;
        b=b3Wn+irnKvDiZI+b0KhzAd6e6hRTH6enEu4qwg6lffTZSLng1bpBO8OgREy2b/UNr+
         EZupyiXWh/vN/4RmsRWOIyvTrIgBmrbTPKkvJPH5nZx74nGgdOrNJpzgilLdx9z/z885
         Mad1hvr6AaNeSfL+r87LxUgv0E0KYcva/1bbqWMJ3VS8laSZOWwF8D31gFrCxgxzPsgC
         uN/VAKsiTwLc7wMWc/S74VA3+Pzoa7IK0jIOXOogU6B/tZWIVNxgisqyaSPUQ48KHqBH
         FFxRs7UhtAasCChtfdSekXaW6Np++7hAtDqJbnIQZRMJ6az7Dbh4PKF7jmSHdN1N/VeN
         COAQ==
X-Gm-Message-State: AOAM531gXtyUwTNTMYuj/jNyFrRP9HTl9OWkttnjnBeDkUwpovbRu7gd
        VQXvSG+9kTjnnZSPpEvqrz7wivZav2vE+Q==
X-Google-Smtp-Source: ABdhPJy9fUypKEpbuM+Oepmztp98ZRomAQTyUsNmVY9Wx7Vnjv2cdEOp/sBHsDoiGH/+F+d3tCWHMQ==
X-Received: by 2002:a62:aa06:0:b029:19d:f4d3:335e with SMTP id e6-20020a62aa060000b029019df4d3335emr1611187pff.60.1611348435252;
        Fri, 22 Jan 2021 12:47:15 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:ea88])
        by smtp.gmail.com with ESMTPSA id j18sm4092900pfc.99.2021.01.22.12.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 12:47:14 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v7 00/10] fs: interface for directly reading/writing compressed data
Date:   Fri, 22 Jan 2021 12:46:46 -0800
Message-Id: <cover.1611346706.git.osandov@fb.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This series adds an API for reading compressed data on a filesystem
without decompressing it as well as support for writing compressed data
directly to the filesystem. As with the previous submissions, I've
included a man page patch describing the API. I have test cases
(including fsstress support) and example programs which I'll send up
[1].

The main use-case is Btrfs send/receive: currently, when sending data
from one compressed filesystem to another, the sending side decompresses
the data and the receiving side recompresses it before writing it out.
This is wasteful and can be avoided if we can just send and write
compressed extents. The patches implementing the send/receive support
will be sent shortly.

Patches 1-3 add the VFS support and UAPI. Patch 4 is a fix that this
series depends on; it can be merged independently. Patches 5-8 are Btrfs
prep patches. Patch 9 adds Btrfs encoded read support and patch 10 adds
Btrfs encoded write support.

These patches are based on Dave Sterba's Btrfs misc-next branch [2],
which is in turn currently based on v5.11-rc4.

Changes since v6 [3]:

- Dropped O_CLOEXEC requirement for O_ALLOW_ENCODED.
- Readded lost FMODE_ENCODED_IO check.
- Used macros instead of enum for ENCODED_IOV_COMPRESSION_* and
  ENCODED_IOV_ENCRYPTION_*.
- Moved encoded I/O definitions to their own UAPI header file.
- Fixed style nits.
- Added reviewed-bys.
- Addressed man page nits.

1: https://github.com/osandov/xfstests/tree/rwf-encoded
2: https://github.com/kdave/btrfs-devel/tree/misc-next
3: https://lore.kernel.org/linux-btrfs/cover.1605723568.git.osandov@fb.com/

Omar Sandoval (10):
  iov_iter: add copy_struct_from_iter()
  fs: add O_ALLOW_ENCODED open flag
  fs: add RWF_ENCODED for reading/writing compressed data
  btrfs: fix check_data_csum() error message for direct I/O
  btrfs: don't advance offset for compressed bios in
    btrfs_csum_one_bio()
  btrfs: add ram_bytes and offset to btrfs_ordered_extent
  btrfs: support different disk extent size for delalloc
  btrfs: optionally extend i_size in cow_file_range_inline()
  btrfs: implement RWF_ENCODED reads
  btrfs: implement RWF_ENCODED writes

 Documentation/filesystems/encoded_io.rst |  74 ++
 Documentation/filesystems/index.rst      |   1 +
 arch/alpha/include/uapi/asm/fcntl.h      |   1 +
 arch/parisc/include/uapi/asm/fcntl.h     |   1 +
 arch/sparc/include/uapi/asm/fcntl.h      |   1 +
 fs/btrfs/compression.c                   |  12 +-
 fs/btrfs/compression.h                   |   6 +-
 fs/btrfs/ctree.h                         |   9 +-
 fs/btrfs/delalloc-space.c                |  18 +-
 fs/btrfs/file-item.c                     |  35 +-
 fs/btrfs/file.c                          |  46 +-
 fs/btrfs/inode.c                         | 936 ++++++++++++++++++++---
 fs/btrfs/ordered-data.c                  |  80 +-
 fs/btrfs/ordered-data.h                  |  18 +-
 fs/btrfs/relocation.c                    |   4 +-
 fs/fcntl.c                               |  10 +-
 fs/namei.c                               |   4 +
 fs/read_write.c                          | 168 +++-
 include/linux/encoded_io.h               |  17 +
 include/linux/fcntl.h                    |   2 +-
 include/linux/fs.h                       |  13 +
 include/linux/uio.h                      |   2 +
 include/uapi/asm-generic/fcntl.h         |   4 +
 include/uapi/linux/encoded_io.h          |  30 +
 include/uapi/linux/fs.h                  |   5 +-
 lib/iov_iter.c                           |  82 ++
 26 files changed, 1378 insertions(+), 201 deletions(-)
 create mode 100644 Documentation/filesystems/encoded_io.rst
 create mode 100644 include/linux/encoded_io.h
 create mode 100644 include/uapi/linux/encoded_io.h

-- 
2.30.0

