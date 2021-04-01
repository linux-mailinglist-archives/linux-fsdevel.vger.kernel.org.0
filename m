Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD06350F5C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 08:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbhDAGvj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 02:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbhDAGv2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 02:51:28 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C77FC06178A
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Mar 2021 23:51:28 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id y2so533179plg.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Mar 2021 23:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q+eBXF4UpkxH1troRhu2jm8vxXsGdka+ag1Br0jPZ30=;
        b=YUD8aiySztkmmHvnvo4DGQ3AGaz6HDxe533EzJg8zG0ft0tStlCRsU9kCc+KZAeOoq
         m5BFVHlo/+2PuARox8aePR6lLZe3My74BvjhbPIodJkasltyDnM1TlwWsZYFn0aOyHKU
         dfGYastzuOW/2stRMFA0ZciZ8IwLpF29JkoUVUOa+fEDzgTb51MeW07qYUrtVI2+x3Sj
         FM18E+o0CbI3HzeEfSA0vVVxDEG95+/70lil0jD/t5vw7yd0tD6kTZgjLeEixYEGADvE
         OsyzfhC0F/soYGhpIvTkN5RhvF7z2IvgXjGaWSCyXZzI2+I2T2DFDiwT7cMZlvSN6Ohu
         SDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q+eBXF4UpkxH1troRhu2jm8vxXsGdka+ag1Br0jPZ30=;
        b=QcF9GFLeyYAPDoKAhmDQYENvWNmYrfpIo2heyYcPaY1clMzxN/XYatRgOjfqhm37PI
         ggMBJyE8gbY7wXSlEgGASOFl+Mc8Ol/5zPSlFbw9V1NcTTmBiaz1IhwVvumGPJJcFRwU
         5a6BLHtXOl/IK4U5kuWFdWiLbSSj+N8guXt3M5s4KVa3dF0hDV0G5TLd9ktiCB+5T9ZG
         z5DXwYuUzw9M4Abb0bC1WSabCHKzgnjjjp90p1mHhNGANoZbhygXLQKZnnT8eV2zpPtn
         LkuFuLbx9UezFhQQAnuVLBwWKX54DHxiHc6gwEE57/OSTrIFJ9k/je49ZTwS3xg6AOGr
         JL6Q==
X-Gm-Message-State: AOAM533MSNkjart9UE78P2yKDwm3BKgKeO1MzYhbEUboqz7q5VYP6f5n
        PFkGjgkJUof1K6wq/o45tVgJWmZJZ+oShA==
X-Google-Smtp-Source: ABdhPJx0q+5a6ISbEcH6bs0ZPTCRqx81j3htCq0THXemy4Hk6tnDlPF/UUcfkomaH26E3FTvjePd2Q==
X-Received: by 2002:a17:90a:a103:: with SMTP id s3mr7537031pjp.158.1617259887450;
        Wed, 31 Mar 2021 23:51:27 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:3734])
        by smtp.gmail.com with ESMTPSA id kk6sm4158345pjb.51.2021.03.31.23.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 23:51:26 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v9 0/9] fs: interface for directly reading/writing compressed data
Date:   Wed, 31 Mar 2021 23:51:05 -0700
Message-Id: <cover.1617258892.git.osandov@fb.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This series adds an API for reading compressed data on a filesystem
without decompressing it as well as support for writing compressed data
directly to the filesystem. I have test cases (including fsstress
support) and example programs which I'll send up once the dust settles
[1].

The main use-case is Btrfs send/receive: currently, when sending data
from one compressed filesystem to another, the sending side decompresses
the data and the receiving side recompresses it before writing it out.
This is wasteful and can be avoided if we can just send and write
compressed extents. The patches implementing the send/receive support
were sent with the last submission of this series [2].

Patches 1-3 add the VFS support, UAPI, and documentation. Patches 4-7
are Btrfs prep patches. Patch 8 adds Btrfs encoded read support and
patch 9 adds Btrfs encoded write support.

These patches are based on Dave Sterba's Btrfs misc-next branch [3],
which is in turn currently based on v5.12-rc5.

Changes since v8 [4]:

- Simplified copy_struct_from_iter() to only handle one segment rather
  than iterating.
- Added UAPI documentation as rst adapted from the man page I previously
  sent.
- Fixed definition of O_ALLOW_ENCODED for parisc.
- Dropped "btrfs: fix check_data_csum() error message for direct I/O",
  which has been merged into kdave/misc-next.

Omar Sandoval (9):
  iov_iter: add copy_struct_from_iter()
  fs: add O_ALLOW_ENCODED open flag
  fs: add RWF_ENCODED for reading/writing compressed data
  btrfs: don't advance offset for compressed bios in
    btrfs_csum_one_bio()
  btrfs: add ram_bytes and offset to btrfs_ordered_extent
  btrfs: support different disk extent size for delalloc
  btrfs: optionally extend i_size in cow_file_range_inline()
  btrfs: implement RWF_ENCODED reads
  btrfs: implement RWF_ENCODED writes

1: https://github.com/osandov/xfstests/tree/rwf-encoded
2: https://lore.kernel.org/linux-btrfs/cover.1615922753.git.osandov@fb.com/
3: https://github.com/kdave/btrfs-devel/tree/misc-next
4: https://lore.kernel.org/linux-btrfs/cover.1615922644.git.osandov@fb.com/

 Documentation/filesystems/encoded_io.rst | 240 ++++++
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
 fs/btrfs/inode.c                         | 929 +++++++++++++++++++++--
 fs/btrfs/ordered-data.c                  | 124 +--
 fs/btrfs/ordered-data.h                  |  25 +-
 fs/btrfs/relocation.c                    |   4 +-
 fs/fcntl.c                               |  10 +-
 fs/namei.c                               |   4 +
 fs/read_write.c                          | 168 +++-
 include/linux/encoded_io.h               |  17 +
 include/linux/fcntl.h                    |   2 +-
 include/linux/fs.h                       |  13 +
 include/linux/uio.h                      |   1 +
 include/uapi/asm-generic/fcntl.h         |   4 +
 include/uapi/linux/encoded_io.h          |  30 +
 include/uapi/linux/fs.h                  |   5 +-
 lib/iov_iter.c                           |  91 +++
 26 files changed, 1563 insertions(+), 234 deletions(-)
 create mode 100644 Documentation/filesystems/encoded_io.rst
 create mode 100644 include/linux/encoded_io.h
 create mode 100644 include/uapi/linux/encoded_io.h

-- 
2.31.1

