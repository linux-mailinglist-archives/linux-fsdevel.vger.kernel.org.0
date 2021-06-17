Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34C33ABFC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 01:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhFQXx6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 19:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbhFQXx5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 19:53:57 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54300C061760
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jun 2021 16:51:48 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id o21so3758169pll.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jun 2021 16:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kLtan7ZgJ39lAhTwAEL8BRZtTwp/aIezL/TyKBUefV8=;
        b=CMbZvSZFdRziY2qn+EzuEJyFpb5KZc/g7cglf106+oa8PYPkBH90Vjzm8GS/NgOeJ+
         yxc+cnRixg44tkVtPCwP7Nj1QHoAx2PgTqvkZl83ye7hBhxdXyjRzcXQN+i9arLDTVlZ
         u5ZcQbdYqYB2r0tmcEo4NfOxV1zLYTz6NKqZRkeiG4b+Mgm6ORrx2FXBsUT32s5iW5Li
         3/K1IZmDw76onWKA2uUKE6pX3ig2sp5K7/A8sN9aGSBSWSvLF7m8EDg0Idgy35bNHxnb
         SpczVRDx7uvMVuM1Dps9nCh3R6B0UsfPp/PiNdu0OpTvIRgLanXcpOJk+tR1Gf5SHFyj
         hosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kLtan7ZgJ39lAhTwAEL8BRZtTwp/aIezL/TyKBUefV8=;
        b=RxSdTYtJHPvaeyVd47y909hupro6Be+PueITkIOIxhKjZz5p15RV/TmKHifUg2S30o
         pFKkonXfD/eCtJlsxe0bSb8v82vXT91CrehqIxPrG4A7EVa76fyojvNddweTD1FYrxJi
         xqi4sKL5pGylQ/Mo1KLhQYp7hASKr4P4xd0hPQPqQ+upqp3s1YSkhyChMK8Ez1/qNZYe
         YdaWr5bq0qTz8nDc5vD7f/1iGtLqD9SWcmS16dMpff3ek1lrOwainyKlK0d9YoCMsqQs
         BcwRr2DWu5ebl2leVzT8/mf9K5ogtuozbCFN/sf74HzoUJEHFb4BNtdS0vw/Fkb56t0D
         VCrA==
X-Gm-Message-State: AOAM530dTPJX6UVERoFinpOXCpKResUFrTEe8ZFlSFtRd8ZGjWCCRLBv
        4SnnMZJRQLbhqMYtCYf32YwBuVYjAhHpTQ==
X-Google-Smtp-Source: ABdhPJyA6tXbsmmkly8bTrUXZH/0/TjlUm3khtAowkRsCAeYUZKTslgJojSVEnGBaGDHmX3h6GCLlA==
X-Received: by 2002:a17:90a:8502:: with SMTP id l2mr7943043pjn.215.1623973907360;
        Thu, 17 Jun 2021 16:51:47 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:2f0e])
        by smtp.gmail.com with ESMTPSA id a187sm6087517pfb.66.2021.06.17.16.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 16:51:46 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH RESEND x3 v9 0/9] fs: interface for directly reading/writing compressed data
Date:   Thu, 17 Jun 2021 16:51:23 -0700
Message-Id: <cover.1623972518.git.osandov@fb.com>
X-Mailer: git-send-email 2.32.0
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
which is in turn currently based on v5.13-rc6.

This is a _resend of a resend of a resend_ of v9 [4], rebased on the
latest kdave/misc-next branch.

In the last resend, there was some good discussion around how to support
encryption with this interface in the future. The conclusion was that
this interface should suffice for file data, and we would need separate
interface(s) for working with encrypted file names. So, this really just
needs review on the VFS side.

1: https://github.com/osandov/xfstests/tree/rwf-encoded
2: https://lore.kernel.org/linux-btrfs/cover.1615922753.git.osandov@fb.com/
3: https://github.com/kdave/btrfs-devel/tree/misc-next
4: https://lore.kernel.org/linux-fsdevel/cover.1621276134.git.osandov@fb.com/

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
 fs/btrfs/inode.c                         | 925 +++++++++++++++++++++--
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
 26 files changed, 1559 insertions(+), 234 deletions(-)
 create mode 100644 Documentation/filesystems/encoded_io.rst
 create mode 100644 include/linux/encoded_io.h
 create mode 100644 include/uapi/linux/encoded_io.h

-- 
2.32.0

