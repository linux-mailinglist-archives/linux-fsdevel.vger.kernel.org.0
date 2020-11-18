Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF432B8489
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 20:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgKRTSb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 14:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgKRTSb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 14:18:31 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056C0C0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:18:30 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id 18so1513027pli.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UMP6vaMazUfCes0eWbbXu3NxgXRmMREALRLT0KaHDAo=;
        b=fZQ2pIO8bW4rUqc4/TEBZ4pW42Xy5eZxGNNTCUekiUuJiT8ivx/m9rjcaCwP10cAFO
         ljYoBTHtFjj3H5RESJMVQ9UhGyLMRLwVncclqgClDWHh/Q6RxaLSOXISbBJcFAwbloKr
         uu5GQV6xsSgWaQaCjpesTweIwn2SFwt2guKZ0FtkrXnxTN2em616DNQ+zYZecI/2B89m
         SF7x9rseivOUMYMZ0cHWxXzfidbdfFvbqqkIXtxOYMpi0Jtc73WpNZJvO5ce6nU0Fq3+
         62Fktp0yPqq6/7mZ0fvRI+pGvr95YgywShm1SeuWTVkyoszvRGhOgepb2irxN5UJgbOw
         zieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UMP6vaMazUfCes0eWbbXu3NxgXRmMREALRLT0KaHDAo=;
        b=HZQTZGP0JM1tnemy0jrz3j7O5oRlsEe6AlUmO9qVkfPLsTAoq06mMweq+PMYyJirVm
         kGlnV48UeXDnmv+1vygjWST8KuAdWXPJlotIs3cOsuruogk3d6BcAff3J14COGRxTOJn
         NIpA3Yhlh9FsETcg5ict8w8cxTxV/Uf7ffAPEcLQQFhUaNTCjtpIAIkHDc8PFdtcxJXO
         W0Bxi/P0Gqsut3hBSpU9jo1SRO8tAKKVtkzw+bLxJzOEiBtekDgtEBSIyeTqw3EZKQMv
         0/QO7bS6O5ex1vsNqtGegBSfkgIaQvdiU7qZvE8L3Fc1WsjfU/Oc7eLTLsovKtoC3YAw
         87aA==
X-Gm-Message-State: AOAM533c/W9Ag/M2+Kd5JCwUitHGBKPFLxozuQMuWRQSHaBnCBNBNJAh
        WQphQ0QjFtX6pAEdAjPPSVcGezC/Sl/cgQ==
X-Google-Smtp-Source: ABdhPJwlL4XjUyLwqdvKx/dlSQtCHghAr8YKwnwxLlBkiM05M9ATgcH8t+ayuWR8I/6OQUbi8bOuUw==
X-Received: by 2002:a17:902:10e:b029:d8:d11d:9613 with SMTP id 14-20020a170902010eb02900d8d11d9613mr5303361plb.26.1605727108823;
        Wed, 18 Nov 2020 11:18:28 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:8b43])
        by smtp.gmail.com with ESMTPSA id c22sm19491863pfo.211.2020.11.18.11.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 11:18:27 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v6 00/11] fs: interface for directly reading/writing compressed data
Date:   Wed, 18 Nov 2020 11:18:06 -0800
Message-Id: <cover.1605723568.git.osandov@fb.com>
X-Mailer: git-send-email 2.29.2
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

Patches 1-3 add the VFS support and UAPI. Patches 4 and 5 are fixes for
patches in the Btrfs misc-next branch that conflicted with this series;
they can go into misc-next or be folded into the original patches
independently. Patches 6-9 are Btrfs prep patches. Patch 10 adds Btrfs
encoded read support and patch 11 adds Btrfs encoded write support.

These patches are based on Dave Sterba's Btrfs misc-next branch [2],
which is in turn currently based on v5.10-rc4.

Changes since v5 [3]:

- Made O_CLOEXEC mandatory in conjuction with O_ALLOW_ENCODED.
- Added _BTRFS to the ENCODED_IOV_COMPRESSION names (e.g.,
  ENCODED_IOV_COMPRESSION_ZSTD -> ENCODED_IOV_COMPRESSION_BTRFS_ZSTD).
- Split ENCODED_IOV_COMPRESSION_LZO compression mode into separate modes
  per page size. I missed that the ill-conceived Btrfs LZO format
  depends on PAGE_SIZE. Having a separate compression mode for each
  supported page size at least lets us detect mismatches.
- Fixed up other minor comments from v5.
- Added reviewed-bys.

1: https://github.com/osandov/xfstests/tree/rwf-encoded
2: https://github.com/kdave/btrfs-devel/tree/misc-next
3: https://lore.kernel.org/linux-btrfs/cover.1597993855.git.osandov@osandov.com/

Omar Sandoval (11):
  iov_iter: add copy_struct_from_iter()
  fs: add O_ALLOW_ENCODED open flag
  fs: add RWF_ENCODED for reading/writing compressed data
  btrfs: fix btrfs_write_check()
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
 fs/btrfs/file.c                          |  73 +-
 fs/btrfs/inode.c                         | 933 ++++++++++++++++++++---
 fs/btrfs/ordered-data.c                  |  80 +-
 fs/btrfs/ordered-data.h                  |  18 +-
 fs/btrfs/relocation.c                    |   4 +-
 fs/fcntl.c                               |  10 +-
 fs/namei.c                               |   4 +
 fs/open.c                                |   7 +
 fs/read_write.c                          | 167 +++-
 include/linux/fcntl.h                    |   2 +-
 include/linux/fs.h                       |  11 +
 include/linux/uio.h                      |   2 +
 include/uapi/asm-generic/fcntl.h         |   4 +
 include/uapi/linux/fs.h                  |  41 +-
 lib/iov_iter.c                           |  82 ++
 25 files changed, 1384 insertions(+), 212 deletions(-)
 create mode 100644 Documentation/filesystems/encoded_io.rst

-- 
2.29.2

