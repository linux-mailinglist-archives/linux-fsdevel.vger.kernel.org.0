Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92F9383C5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 May 2021 20:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237250AbhEQShC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 14:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237141AbhEQShB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 14:37:01 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CBEC061573
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 May 2021 11:35:44 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id g18so3908767pfr.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 May 2021 11:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kb+bSgN9yADabRHy63xxJUT7vh6UiCpcnBuE5iUxb9U=;
        b=A4+ttFLlksWJIAhRvNzfBmQreUOPvW4WKqg/aCHCHRD/zTX4gNX9pu1DaCFvsKmwoM
         m4wzD8y1zi3O50Gvv8EafBRBHZf3lyyYfci0AJOqd7/FgDGc4FIE67g5V2oXmYKEYmND
         d4rNLJy1Al/I/BcYXZ82sIbvZV0FBUczjxDUhQIyQRWoOwaUhqXky9qbrf+TDquuWtHP
         tXaZy3S1o6ENteuq8RBr9hwN3XJplq37knNH/duxM4mFI/tPWqsmDJspMfCYj/YW2sfG
         QI3MQT+eZuD/6S6Kw4WqqsavDQFcJ2JpFmMsv/UMElxOADdszoNQbH5Ih2vDTceiKkgI
         3rZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kb+bSgN9yADabRHy63xxJUT7vh6UiCpcnBuE5iUxb9U=;
        b=eyYkzRcpIuLb5EVKC6i6mBveEKUDkmtO11/x2PMDbisWa4P8I/8zPalF0B/sbbw3g1
         7DZVbgb50j+DTf6Kr33IhDW+PX7dR1PfzikufKRsCphryQ7cxSIrFcX7F3xKnfGzSjHU
         M12UkB74p9xlvQNQKyBkKXdybOREHj7zuTFZ1CIiABV8vLpkpOdbN2E5gExL9jWPm2jC
         LcZJJHB74/JK3XJ5b52VMGZe2qNfMJct3ZgpJbFm/XXnUgK0TUUr0CrgZURP+6fQmAtJ
         fBEuJh6MhNfwlKn8hr0iGenccpj2cVFq962aON5z8vfpAnWFOSTu88uqGcKAUdZdkTq/
         gSww==
X-Gm-Message-State: AOAM5337EmerkLHMv2VvvkyhrbU1nTqFkyM5RzDOwtUc2+NzFRqih76O
        oyu0UsZlO4BzWT+SkjyUJu/nk+lK14FNvg==
X-Google-Smtp-Source: ABdhPJz7C30B/YfGxIxPqigr5aagx53G9Qf93HwHNPZcdzRmG3OlezZVduDX0QNQ2ktJhjZkoo7TWg==
X-Received: by 2002:a63:610b:: with SMTP id v11mr853482pgb.291.1621276543611;
        Mon, 17 May 2021 11:35:43 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:19a9])
        by smtp.gmail.com with ESMTPSA id v15sm5498763pfm.187.2021.05.17.11.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 11:35:42 -0700 (PDT)
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
Subject: [PATCH RERESEND v9 0/9] fs: interface for directly reading/writing compressed data
Date:   Mon, 17 May 2021 11:35:18 -0700
Message-Id: <cover.1621276134.git.osandov@fb.com>
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
which is in turn currently based on v5.13-rc2.

This is a _resend of a resend_ of v9 [4], rebased on the latest
kdave/misc-next branch.

1: https://github.com/osandov/xfstests/tree/rwf-encoded
2: https://lore.kernel.org/linux-btrfs/cover.1615922753.git.osandov@fb.com/
3: https://github.com/kdave/btrfs-devel/tree/misc-next
4: https://lore.kernel.org/linux-fsdevel/cover.1619463858.git.osandov@fb.com/

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

