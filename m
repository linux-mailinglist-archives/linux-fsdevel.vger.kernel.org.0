Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB30824CF67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 09:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgHUHiv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 03:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbgHUHiu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:38:50 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C94C061387
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:38:50 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k18so662090pfp.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wcDRP+WCOPCj6Degs2chS4VStEaQTh3fcwKqn7f0az4=;
        b=TFJngdubEFW1q6xJ8Hs432SVKJ033AYjBsWA/rwphrbAXlJ7UZwq/5tf/4LJTgR4iO
         hxScuql3h8QbeeCRY/bm1IiBg/aPTgHy32e+QUIf0GrTjQvxIz+KjMFSbApewrZwfZwd
         AvEQ3D6yMwqTinaPDhc0Rx5wPNrBwn59F9KcukGe670wvuH+ksv+OyVvoyM8EkPd9j5k
         IDFgtBSdIRk98U/Bjb7o6zSqkWxKIdkRnCYosQ7k5t8X88tLPUvCjkPXPLnp4S/laRFJ
         aGNRnSQzFkExLOouxV1/tgp+yuCanb8MiWXh9FqJONmesqua0DlpHHqG7L/CqBMqBMMK
         2Lug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wcDRP+WCOPCj6Degs2chS4VStEaQTh3fcwKqn7f0az4=;
        b=QQmlfH9ZXdSl8V75GMft4A76wRdcD7ZDs2dyS/YwNStpsfVFq/KqZDjqX0+3VdQM1T
         K+fc3guTbFEmgfY9sEYzXpZpGZwOx5KPNPhZn5HLkCLEQJ9+pUnyktfmPRJMxY8/1q1M
         9gLepXXxLKTllkxqmG9NdcjnlWI37xXXP3X0uI6ZoeT6GT676v2s/FWpKESNyPMz9DXs
         hefSs2lwNtBacIqLh5TDhiUTE/MGZDBqAA/kkaISVGfa3fXQXf7ReTqeUZxi7FIxshpX
         kxScUIKS5ShFnscrACzdErliYYUrCHGAZyM3LiucgXrPUSoF19dIIlG4McZCV7wi7ow6
         tkSg==
X-Gm-Message-State: AOAM531CmO7ch76WUWQPTV5tQwdN2CBufz+w51wrjobTKd7PP9xp/QWS
        dZYpgsDLgt43R+pwH4pKznh0c862OZ/lZQ==
X-Google-Smtp-Source: ABdhPJy1FifXjxBF2SnhlbYE9jP9ikmv9eAdWUIhfo5qS4hsXgMEUS5dF0mFeuJw2p1pNXkMHxNMrw==
X-Received: by 2002:aa7:8c55:: with SMTP id e21mr1432852pfd.304.1597995528846;
        Fri, 21 Aug 2020 00:38:48 -0700 (PDT)
Received: from exodia.tfbnw.net ([2620:10d:c090:400::5:f2a4])
        by smtp.gmail.com with ESMTPSA id t10sm1220867pgp.15.2020.08.21.00.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:38:47 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v5 0/9] fs: interface for directly reading/writing compressed data
Date:   Fri, 21 Aug 2020 00:38:30 -0700
Message-Id: <cover.1597993855.git.osandov@osandov.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series adds an API for reading compressed data on a filesystem
without decompressing it as well as support for writing compressed data
directly to the filesystem. As with the previous submissions, I've
included a man page patch describing the API. I have test cases
(including fsstress support) and example programs which I'll send up
soon [1].

The main use-case is Btrfs send/receive: currently, when sending data
from one compressed filesystem to another, the sending side decompresses
the data and the receiving side recompresses it before writing it out.
This is wasteful and can be avoided if we can just send and write
compressed extents. Since the last posting of this series, I've
implemented the send support and Boris Burkov has implemented the
receive support using this interface; the speedup is significant. Those
patches will be sent shortly.

Patches 1-3 add the VFS support and UAPI. Patches 4-7 are Btrfs prep
patches. Patch 8 adds Btrfs encoded read support and patch 9 adds Btrfs
encoded write support.

These patches are based on Dave Sterba's Btrfs misc-next branch [2],
which is in turn based on v5.9-rc1.

Changes since v4 [3]:

- Rebased on kdave/misc-next.
- Clarified the man pages in several places.

1: https://github.com/osandov/xfstests/tree/rwf-encoded
2: https://github.com/kdave/btrfs-devel/tree/misc-next
3: https://lore.kernel.org/linux-fsdevel/cover.1582930832.git.osandov@fb.com/

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
 fs/btrfs/file.c                          |  55 +-
 fs/btrfs/inode.c                         | 904 ++++++++++++++++++++---
 fs/btrfs/ordered-data.c                  |  80 +-
 fs/btrfs/ordered-data.h                  |  18 +-
 fs/btrfs/relocation.c                    |   4 +-
 fs/fcntl.c                               |  10 +-
 fs/namei.c                               |   4 +
 include/linux/fcntl.h                    |   2 +-
 include/linux/fs.h                       |  16 +
 include/linux/uio.h                      |   2 +
 include/uapi/asm-generic/fcntl.h         |   4 +
 include/uapi/linux/fs.h                  |  33 +-
 lib/iov_iter.c                           |  82 ++
 mm/filemap.c                             | 166 ++++-
 24 files changed, 1336 insertions(+), 202 deletions(-)
 create mode 100644 Documentation/filesystems/encoded_io.rst

-- 
2.28.0

