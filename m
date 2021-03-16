Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16E733DDC1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 20:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240556AbhCPTnv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 15:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240525AbhCPTnZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:43:25 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F7EC06175F
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 12:43:25 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id o16so6329346pgu.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 12:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sVJsM+Gl67VwVBKkXBGqvTHNWKKznbPf3akr+SSNrps=;
        b=TYnR2E2za3Y3x/uH72LmIyMZmQBQBp5SeWVE9Cbex8i3e3VWilIxZenbNV8wB+mUk1
         UbzKf6APk5kT5URbLN/qm5tYQcycKp5TUrCYzoP4JkLNtqPgzMz8pWVgFXfRe57rhXxE
         tels/4rcgcUErUXjQud50sMt8vPr3m/WH1s0rOxp5fOmBbdzrvRC544qOOWJUlMW5RWf
         PMuXejvwXtrMT3VDPT/xKy9kjSi8gh420Ywv3DpzoyT+YZE5z4gTGtM+qnkyHjncOryP
         7SwKHh73RnxrX4wQgIEsYerFBe97IaYGOMy7vXZAe7PCnxVAmbDICRkiy7tMBz+PP3sB
         u2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sVJsM+Gl67VwVBKkXBGqvTHNWKKznbPf3akr+SSNrps=;
        b=B/5UjHG3pmOqMMzjvGGFxgTNx6xiGP3G4/PZAwl5yB0ax4hPsJOpTg8x5i2WfJN7si
         28NiAOC6Y42d/fsjpI2dvU5gZK9OVjs/mQi3xpuBTMR3YtV5acFXr7Hce4nHJP3ek/mw
         giZA7sagww8zldVzw8S8Tro6uvXbY7xHdhinO7E8PTBlnlxMMtjmGK+ijrZm0RY4Cqv7
         kWOdqu3g7/fw1rxyFjNyHwyAO8RiJiu7wrnyhmR0x4FhCjO9EYkOoTFjkdJAR6LgypQx
         LUMxKgQpjeHv3/0xJn+zXqrBVQYjJ9g2Hc8NsO50z9o3s1g4ZRJhU/kzmEZtglPwl0jD
         QmHg==
X-Gm-Message-State: AOAM532NEHE/aqrw4toex0/IX4j3Bicioq9K52rMySfqExoE1bh92/CT
        PftAXy2mlXHyiPsSEFOt5Mpzen8H571mSA==
X-Google-Smtp-Source: ABdhPJxApnRDl1NIu9E52/otSkzoKgzsLkVlo2U9LejBoMfDpKkzLHrNxCzKrdCuU+KNbMEfsoffMg==
X-Received: by 2002:a63:d704:: with SMTP id d4mr1094500pgg.221.1615923803957;
        Tue, 16 Mar 2021 12:43:23 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:532])
        by smtp.gmail.com with ESMTPSA id gm10sm217264pjb.4.2021.03.16.12.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 12:43:22 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v8 00/10] fs: interface for directly reading/writing compressed data
Date:   Tue, 16 Mar 2021 12:42:55 -0700
Message-Id: <cover.1615922644.git.osandov@fb.com>
X-Mailer: git-send-email 2.30.2
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
which is in turn currently based on v5.12-rc3.

Changes since v7 [3]:

- Rebased on current kdave/misc-next (v5.12-rc3).

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

1: https://github.com/osandov/xfstests/tree/rwf-encoded
2: https://github.com/kdave/btrfs-devel/tree/misc-next
3: https://lore.kernel.org/linux-btrfs/cover.1611346706.git.osandov@fb.com/

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
2.30.2

