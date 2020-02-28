Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 261571742B3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Feb 2020 00:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgB1XOL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 18:14:11 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40903 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgB1XOL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 18:14:11 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so1808165plp.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2020 15:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qYRCFe+0MRQNS4OgeJSALRbvhoDISvltVMM/A8keomE=;
        b=ZVpx4u+bpNYlQ8XxZ+f5VbCuEBlDevQRfeh/RZjzaQwKmjHUSK4YhdjsexT3HOwCQr
         J/IEdHl33g1zaJelduV2oMPjTZ0FCQhNps8zU4K7DUyE4MXDFPbPHelmCdY5OkB6U+ww
         R0vCPzPB+FWSBIKtc+vZgUmX+xHhWvxIcNj62oFdg9rHcWm5mYYkBW2OHpBqkhfh+dG9
         GI32ASERUQrIM8CnMpvJ+hysNcYv+DsydD3y/HvUCoj037OaLGgJ3cJG7I6EW5H3EG4N
         b8z3wV5BWGptgho1DbdR5C/p0d5qoUb56TA5jcN3fidIwB4j4r4PnOZmO5Fw850aOIfF
         V1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qYRCFe+0MRQNS4OgeJSALRbvhoDISvltVMM/A8keomE=;
        b=PV8e80h045Suo/f77xgddCNAGfc1ln4T1lq23wNrK4KlV89ZkC/jjRqLnK766hhBF0
         CFwbLBJem8TzqAdth8UGnKt7Bs+bVprJPWp9uKckBW4iKUCnEGJxvovlJanSCiRE0vpT
         FD2DgPQB7CG2mqlcoxPXl89rAO+ZXpHGyHpV0ksk+F3D2YYP002Uig3yxuhhqI4QNF+c
         j4s9ml5vNf0/puejxlnaSc+QGXMYvIf75CdPGiYW9lHF76wD95qLf8ZuQi2OMan1LlzU
         QLwq+3iIniTkWQ3vr7N/+IlFK2zz7yLMUJhZ5s5IwF5t8s6I4be6aDK6SRUIooRIfgkz
         l0Gw==
X-Gm-Message-State: APjAAAVL15tor/Spibqsfn2g32YjpyXL4GzTy1Ff9APBNnPjQJpId2f0
        i+msBX/tA7qXnFQ2qNPLvXjzGLg1PZc=
X-Google-Smtp-Source: APXvYqx0CySVh5fXc2TgOxWs832q5LpZeX0rkAWsq8FVK+WvnC1Q6Lj3ciwIS0BP//UODtlU0SLMtQ==
X-Received: by 2002:a17:902:a608:: with SMTP id u8mr6010424plq.76.1582931649409;
        Fri, 28 Feb 2020 15:14:09 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:500::6:1714])
        by smtp.gmail.com with ESMTPSA id q7sm11421878pgk.62.2020.02.28.15.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 15:14:08 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v4 0/9] fs: interface for directly reading/writing compressed data
Date:   Fri, 28 Feb 2020 15:13:51 -0800
Message-Id: <cover.1582930832.git.osandov@fb.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Hello,

This series adds an API for reading compressed data on a filesystem
without decompressing it as well as support for writing compressed data
directly to the filesystem. As with the previous submissions, I've
included a man page patch describing the API. I have test cases
(including fsstress support) and example programs which I'll send up
once the interface is more or less settled [1].

The main use-case is Btrfs send/receive: currently, when sending data
from one compressed filesystem to another, the sending side decompresses
the data and the receiving side recompresses it before writing it out.
This is wasteful and can be avoided if we can just send and write
compressed extents. The send part will be implemented in a separate
series, as this API can stand alone.

I'm fairly happy with the UAPI and VFS interface now. I'd love for Al
and/or Christoph to take a look at that part. The Btrfs side is mostly
there, just missing read repair.

Patches 1-3 add the VFS support. Patches 4-7 are Btrfs prep patches.
Patch 8 adds Btrfs encoded read support and patch 9 adds Btrfs encoded
write support.

Changes from v3:

- Rebase on v5.6-rc3.
- Disallow extents with a file length greater than the unencoded
  length.
- Drop Btrfs cleanups and fixes that have already been merged.
- Add Nikolay's reviewed-bys.

Please share any comments on the API or implementation. Thanks!

1: https://github.com/osandov/xfstests/tree/rwf-encoded
2: https://lore.kernel.org/linux-btrfs/cover.1574273658.git.osandov@fb.com/

Omar Sandoval (9):
  iov_iter: add copy_struct_from_iter()
  fs: add O_ALLOW_ENCODED open flag
  fs: add RWF_ENCODED for reading/writing compressed data
  btrfs: don't advance offset for compressed bios in btrfs_csum_one_bio()
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
 fs/btrfs/delalloc-space.c                |  38 +-
 fs/btrfs/delalloc-space.h                |   4 +-
 fs/btrfs/file-item.c                     |  35 +-
 fs/btrfs/file.c                          |  55 +-
 fs/btrfs/inode.c                         | 873 ++++++++++++++++++++---
 fs/btrfs/ordered-data.c                  |  77 +-
 fs/btrfs/ordered-data.h                  |  18 +-
 fs/btrfs/relocation.c                    |   4 +-
 fs/fcntl.c                               |  10 +-
 fs/namei.c                               |   4 +
 include/linux/fcntl.h                    |   2 +-
 include/linux/fs.h                       |  16 +
 include/linux/uio.h                      |   2 +
 include/uapi/asm-generic/fcntl.h         |   4 +
 include/uapi/linux/fs.h                  |  33 +-
 lib/iov_iter.c                           |  82 +++
 mm/filemap.c                             | 166 ++++-
 25 files changed, 1306 insertions(+), 222 deletions(-)
 create mode 100644 Documentation/filesystems/encoded_io.rst

-- 
2.25.1

