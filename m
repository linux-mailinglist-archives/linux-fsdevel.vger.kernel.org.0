Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519FA3EF45B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 23:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbhHQVHr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 17:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhHQVHq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 17:07:46 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77353C061764
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 14:07:12 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id n5so1190686pjt.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 14:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ifEyWOEWl5Nw2lfaWWMjDfhWjw1d7zOJ4aJ2plb67Sw=;
        b=n/sAVmuY9CIYVhjQ1u8YuEheUBxiDAT3Qq5KhqBh9pEWH1NIbUvHYCj82lGsB/m3oJ
         8xQaJNDHdtVaHqaXN7awyXGJ7tt8dNa2LUPtBQh93BkED8iDD28XaRW5lTNtlZ/1zfPU
         16xY9Z+0z3MSNZ0dB0EjUfBbRqHhdzKujD/lA9zfmZyZof/6r27SHtXTN14WTntTv4mM
         8J2InWbzw74K72hBkaPQgUC2lUcOVSptHdKickgE8ZuASeW3f4fb2t7w/VOdQ0HrZ2rd
         bxtguNPv7HcKbqzS2tCjPBObnWb/89afr1pyZOun3WBRyQzQ2jKAZQLeX5iPkun+8rvQ
         JznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ifEyWOEWl5Nw2lfaWWMjDfhWjw1d7zOJ4aJ2plb67Sw=;
        b=eOvdBZl38HoTK9kwLRiJYB+LtAAgydcUtsRSygguo6rdaDiVxnxL8QWVUpELflBU7W
         I0sL64XpAEV5kcoWpssRlztg3CD+pMN8iTdZuSvoieLt49TzqOnns5RMOgtp5K87mOPZ
         sco0wnkDyHvQPWB4MF9ZfXpYZYmQRlT2bpcicOHMBbcC9dpBPuOAcgdD3WhQe3EI4AJO
         UJs9YJeR2t/ptXQrvXQhjSife5yfR0yBvNDTHD7dG+2g+iFMqcNsmZ0LZm+CmgCXKZ0v
         XT1GS5IoqC+PfGgf0lVNJhEKOc2oabxxrJP7+DnHY2/GwbTRvhkS1lCmJBwo0z6msDy4
         XbHw==
X-Gm-Message-State: AOAM532NdiLITk4cqYn4Qg9iGGR7ipI1152aQhPvzUeCw9QSfpT36xxi
        8QtK9Ml+QgAYSqeGWKTTAKj9sA==
X-Google-Smtp-Source: ABdhPJz/IZROrp97aDIRUXdDu/LOy3ugJNxfLXXcCcN00ssDpDS72383ZPqnJkHn/I0sxXPz5dBB6A==
X-Received: by 2002:a17:90a:7283:: with SMTP id e3mr5556175pjg.65.1629234431937;
        Tue, 17 Aug 2021 14:07:11 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:df70])
        by smtp.gmail.com with ESMTPSA id c9sm4205194pgq.58.2021.08.17.14.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 14:07:07 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org
Subject: [PATCH v10 00/14] btrfs: add ioctls and send/receive support for reading/writing compressed data
Date:   Tue, 17 Aug 2021 14:06:32 -0700
Message-Id: <cover.1629234193.git.osandov@fb.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This series has three parts: new Btrfs ioctls for reading/writing
compressed data, support for sending compressed data via Btrfs send, and
btrfs-progs support for sending/receiving compressed data and writing it
with the new ioctl.

The Btrfs ioctls for reading compressed data from a file without
decompressing it and for writing compressed data directly to a file are
adapted from my previous attempt to do this as an extension to
preadv2/pwritev2 [1]. We weren't able to come up with a generic
interface that everyone was happy with, so we're going to do this
ourselves in Btrfs. If another user comes along, we can generalize it
then. Test cases are here [2]

Patches 1 and 2 are VFS changes exporting a couple of helpers for checks
needed by reads and writes. Patches 3-7 are preparatory Btrfs changes
for compressed reads and writes. Patch 8 adds the compressed read ioctl
and patch 9 adds the compressed write ioctl.

The main use-case for this interface is Btrfs send/receive. Currently,
when sending data from one compressed filesystem to another, the sending
side decompresses the data and the receiving side recompresses it before
writing it out. This is wasteful and can be avoided if we can just send
and write compressed extents.

Patches 10-14 add the Btrfs send support. See the previous posting for
more details and benchmarks [3]. Patches 10-12 prepare some protocol
changes for send stream v2. Patch 13 implements compressed send. Patch
14 enables send stream v2 and compressed send in the send ioctl when
requested.

These patches are based on Dave Sterba's Btrfs misc-next branch [4],
which is in turn currently based on v5.14-rc6.

1: https://lore.kernel.org/linux-fsdevel/cover.1623972518.git.osandov@fb.com/
2: https://github.com/osandov/xfstests/tree/btrfs-encoded-io
3: https://lore.kernel.org/linux-btrfs/cover.1615922753.git.osandov@fb.com/
4: https://github.com/kdave/btrfs-devel/tree/misc-next

Omar Sandoval (14):
  fs: export rw_verify_area()
  fs: export variant of generic_write_checks without iov_iter
  btrfs: don't advance offset for compressed bios in
    btrfs_csum_one_bio()
  btrfs: add ram_bytes and offset to btrfs_ordered_extent
  btrfs: support different disk extent size for delalloc
  btrfs: optionally extend i_size in cow_file_range_inline()
  btrfs: add definitions + documentation for encoded I/O ioctls
  btrfs: add BTRFS_IOC_ENCODED_READ
  btrfs: add BTRFS_IOC_ENCODED_WRITE
  btrfs: add send stream v2 definitions
  btrfs: send: write larger chunks when using stream v2
  btrfs: send: allocate send buffer with alloc_page() and vmap() for v2
  btrfs: send: send compressed extents with encoded writes
  btrfs: send: enable support for stream v2 and compressed writes

 fs/btrfs/compression.c     |  12 +-
 fs/btrfs/compression.h     |   6 +-
 fs/btrfs/ctree.h           |  17 +-
 fs/btrfs/delalloc-space.c  |  18 +-
 fs/btrfs/file-item.c       |  35 +-
 fs/btrfs/file.c            |  68 ++-
 fs/btrfs/inode.c           | 911 +++++++++++++++++++++++++++++++++----
 fs/btrfs/ioctl.c           | 213 +++++++++
 fs/btrfs/ordered-data.c    | 124 ++---
 fs/btrfs/ordered-data.h    |  25 +-
 fs/btrfs/relocation.c      |   2 +-
 fs/btrfs/send.c            | 307 +++++++++++--
 fs/btrfs/send.h            |  32 +-
 fs/internal.h              |   5 -
 fs/read_write.c            |  41 +-
 include/linux/fs.h         |   2 +
 include/uapi/linux/btrfs.h | 149 +++++-
 17 files changed, 1690 insertions(+), 277 deletions(-)

The btrfs-progs patches were written by Boris Burkov with some updates
from me. Patches 1-4 are preparation. Patch 5 implements encoded writes.
Patch 6 implements the fallback to decompressing. Patches 7 and 8
implement the other commands. Patch 9 adds the new `btrfs send` options.
Patch 10 adds a test case.

Boris Burkov (10):
  btrfs-progs: receive: support v2 send stream larger tlv_len
  btrfs-progs: receive: dynamically allocate sctx->read_buf
  btrfs-progs: receive: support v2 send stream DATA tlv format
  btrfs-progs: receive: add send stream v2 cmds and attrs to send.h
  btrfs-progs: receive: process encoded_write commands
  btrfs-progs: receive: encoded_write fallback to explicit decode and
    write
  btrfs-progs: receive: process fallocate commands
  btrfs-progs: receive: process setflags ioctl commands
  btrfs-progs: send: stream v2 ioctl flags
  btrfs-progs: receive: add tests for basic encoded_write send/receive

 Documentation/btrfs-receive.asciidoc          |   4 +
 Documentation/btrfs-send.asciidoc             |  16 +-
 cmds/receive-dump.c                           |  31 +-
 cmds/receive.c                                | 347 +++++++++++++++++-
 cmds/send.c                                   |  54 ++-
 common/send-stream.c                          | 157 ++++++--
 common/send-stream.h                          |   7 +
 ioctl.h                                       | 149 +++++++-
 libbtrfsutil/btrfs.h                          |  17 +-
 send.h                                        |  19 +-
 .../049-receive-write-encoded/test.sh         | 114 ++++++
 11 files changed, 871 insertions(+), 44 deletions(-)
 create mode 100755 tests/misc-tests/049-receive-write-encoded/test.sh

-- 
2.32.0

