Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B9024CF95
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 09:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgHUHka (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 03:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728125AbgHUHkP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:40:15 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29432C061388
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:40:15 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 2so460040pjx.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5MNlZObT7jcgW6tC8+NzWzUSmO6qwJk2prO6plIBCTo=;
        b=gEU+vJuhBeWUmJJLlLg8Cx0XlNmI/DEkBK6kAVMUHSPL1y5KhW/tGDlridhqsVqlpu
         auQTzWOLgysQzp+NE9D7ag5Z6mdbKGVp5p/euq4dQzK7lGh31IVqDtWgBu63r9eyOU/p
         jNGX1lCRdLApkgbZV5HrCl0gPE2kOQnpuzzkXJPQ1pthemUFDD9yDdTKqYz0y2B5Fzsq
         3koGIwxLAo3wRX15Zf09Y+zmWiQHtYytl46NSqZHhvIVomoiziX2cBgQnJpqkJ8bqkPj
         Bz5fhdzwaawYwDq/vM1Rz8Drn1LvTEnBEJqZ+2Xa+gncsJJtG8QsyniQuVGlEO7LuAhL
         k1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5MNlZObT7jcgW6tC8+NzWzUSmO6qwJk2prO6plIBCTo=;
        b=JiT+ob2jw9CjfM+QzIeII3I49Svzsb0jYaBwXm2TS3iilRoNBth/Yd4cY04sCDLVJa
         TSBJ+I48SmMd1BgHhK9l0HZX2imq/vft/8BurhOJsodp/julqekBBEIQI19CW/nlq1vu
         EtZ3mluBLb5dyp+QSUKRqJMiYdAsMD8averDJyL8W6mdJyRST6/26nI8Ff3BZj/CKzdm
         +QRTGTgAr5Mp6AnmRiDNZdu23i9WZE+3sywu3sRCPnI50BLgxg70YiPNhHrn+RPWGgnN
         XBgh6kyHuZvDsLRalOm/dEfQTbWVOkSkjRuoWbi68ahzHLlqpu5zTKj66CwNBsUkSnCO
         2qXA==
X-Gm-Message-State: AOAM531yAD5QmE7G7fpwDi4UAeocSICX2aBZjuR2Yh2F667SruvDTxiI
        9D13+m9G+rDVS6sgjGCwqtwRT6n03bbCOg==
X-Google-Smtp-Source: ABdhPJzjJQ7FMYVOH+NhMGidYDRzT02iy/PVolA9lJnQk0fAJdtWP31Cwat8eJqLAlAwr+9htsa9JQ==
X-Received: by 2002:a17:902:c181:: with SMTP id d1mr1337129pld.296.1597995614177;
        Fri, 21 Aug 2020 00:40:14 -0700 (PDT)
Received: from exodia.tfbnw.net ([2620:10d:c090:400::5:f2a4])
        by smtp.gmail.com with ESMTPSA id jb1sm1080875pjb.9.2020.08.21.00.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:40:13 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/9] btrfs: implement send/receive of compressed extents without decompressing
Date:   Fri, 21 Aug 2020 00:39:50 -0700
Message-Id: <cover.1597994106.git.osandov@osandov.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series uses the interface added in "fs: interface for directly
reading/writing compressed data" to send and receive compressed data
without wastefully decompressing and recompressing it. It does so by

1. Bumping the send stream protocol version to 2.
2. Adding a new command, BTRFS_SEND_C_ENCODED_WRITE, and its associated
   attributes that indicates a write using the new encoded I/O
   interface.
3. Sending compressed extents with BTRFS_SEND_C_ENCODED_WRITE when
   requested by the user.
4. Falling back to decompressing and writing the decompressed data if
   encoded I/O fails.

Benchmarks
==========

I ran some benchmarks on send and receive of a zstd (level 3) compressed
snapshot of a server's root filesystem which is about 23GB when
compressed and 50GB when decompressed.

Send v1:
0.41user 81.97system 2:21.71elapsed 58%CPU (0avgtext+0avgdata 2900maxresident)k
47182656inputs+0outputs (10major+119minor)pagefaults 0swaps

Send compressed:
0.43user 60.53system 2:20.62elapsed 43%CPU (0avgtext+0avgdata 2836maxresident)k
47778864inputs+0outputs (8major+117minor)pagefaults 0swaps

In this case, the bottleneck for send is reading the metadata trees and
data from disk, so there's not much of a wall time improvement, but
since the kernel doesn't have to decompress the data in the compressed
case, it uses significantly less CPU and system time.

Receive v1 into a filesystem with compress=none:
15.58user 62.36system 7:34.44elapsed 17%CPU (0avgtext+0avgdata 3028maxresident)k
104719648inputs+105333248outputs (1major+140minor)pagefaults 0swaps

Receive v1 into a filesystem with compress-force=zstd:
15.45user 63.99system 5:11.57elapsed 25%CPU (0avgtext+0avgdata 3100maxresident)k
104587240inputs+105379328outputs (1major+143minor)pagefaults 0swaps

Receive compressed into a filesystem with compress-force=zstd:
7.95user 44.53system 3:42.79elapsed 23%CPU (0avgtext+0avgdata 2992maxresident)k
46909600inputs+21603216outputs (2major+176minor)pagefaults 0swaps

Without compressed receive, recompressing the data is still a wall time
win because it requires much less I/O. However, compressed receive
reduces the wall time even further.

The v1 send stream is 50GB, and the v2 send stream is 23 GB. The v1 send
stream compresses down to 17GB with zstd (level 3), so compressed send
gets pretty close with no extra CPU overhead (the reason that compressed
send is still larger is of course that we compress extents individually,
which does not compress as efficiently as compressing the entire
filesystem representation in one go).

# ls -lh v1.send v1.send.zst compressed.send
-rw-r--r-- 1 root root 23G Aug 17 12:34 compressed.send                 
-rw-r--r-- 1 root root 50G Aug 17 12:13 v1.send                           
-rw-r--r-- 1 root root 17G Aug 17 12:28 v1.send.zst               

Protocol Updates
================

This series makes some changes to the send stream protocol beyond adding
the encoded write command/attributes and bumping the version. Namely, v1
has a 64k limit on the size of a write due to the 16-bit attribute
length. This is not enough for encoded writes, as compressed extents may
be up to 128k and cannot be split up. To address this, the
BTRFS_SEND_A_DATA is treated specially in v2: its length is implicitly
the remaining length of the command (which has a 32-bit length). This
was the last bad of the options I considered.

There are other commands that we've been wanting to add to the protocol:
fallocate and FS_IOC_SETFLAGS. This series reserves their command and
attribute numbers but does not implement kernel support for emitting
them. However, it does implement support in receive for them, so the
kernel can start emitting those whenever we get around to implementing
them.

Interface
=========

For the send ioctl, stream version 2 is opt-in, and compressed writes
are opt-in separately (but dependent on) stream version 2.

Accordingly, `btrfs send` now accepts a `--stream-version` option and a
`--compressed` option; the latter implies `--stream-version 2`.

`btrfs receive` also accepts a `--force-decompress` option that forces
the fallback to decompressing and writing the decompressed data.

These options are provided to give the user flexibility in case they
don't want their receiving filesytem to be compressed.

Patches
=======

The kernel patches are based on kdave/misc-next plus my "fs: interface
for directly reading/writing compressed data" series. Patches 1-3 are
improvements to the generic send code.  Patches 4-7 do some preparation
for stream v2 and compressed send. Patch 8 implements compressed send.
Patch 9 modified the ioctl to accept the new flags and enable the new
feature.

Omar Sandoval (9):
  btrfs: send: get rid of i_size logic in send_write()
  btrfs: send: avoid copying file data
  btrfs: send: use btrfs_file_extent_end() in send_write_or_clone()
  btrfs: add send_stream_version attribute to sysfs
  btrfs: add send stream v2 definitions
  btrfs: send: write larger chunks when using stream v2
  btrfs: send: allocate send buffer with alloc_page() and vmap() for v2
  btrfs: send: send compressed extents with encoded writes
  btrfs: send: enable support for stream v2 and compressed writes

 fs/btrfs/ctree.h           |   4 +
 fs/btrfs/inode.c           |   6 +-
 fs/btrfs/send.c            | 419 ++++++++++++++++++++++++++++---------
 fs/btrfs/send.h            |  33 ++-
 fs/btrfs/sysfs.c           |   9 +
 include/uapi/linux/btrfs.h |  17 +-
 6 files changed, 384 insertions(+), 104 deletions(-)

The btrfs-progs patches were written by Boris Burkov. Patches 1-5 are
preparation. Patch 6 implements encoded writes. Patch 7 implements the
fallback to decompressing. Patch 8-9 implement the other commands. Patch
10 adds the new `btrfs send` options. Patch 11 adds a test case.

Boris Burkov (11):
  btrfs-progs: receive: support v2 send stream larger tlv_len
  btrfs-progs: receive: dynamically allocate sctx->read_buf
  btrfs-progs: receive: support v2 send stream DATA tlv format
  btrfs-progs: receive: add send stream v2 cmds and attrs to send.h
  btrfs-progs: receive: add stub implementation for pwritev2
  btrfs-progs: receive: process encoded_write commands
  btrfs-progs: receive: encoded_write fallback to explicit decode and
    write
  btrfs-progs: receive: process fallocate commands
  btrfs-progs: receive: process setflags ioctl commands
  btrfs-progs: send: stream v2 ioctl flags
  btrfs-progs: receive: add tests for basic encoded_write send/receive

 Makefile                                      |   4 +-
 cmds/receive-dump.c                           |  31 +-
 cmds/receive.c                                | 402 +++++++++++++++++-
 cmds/send.c                                   |  39 +-
 common/send-stream.c                          | 159 +++++--
 common/send-stream.h                          |   7 +
 configure.ac                                  |   1 +
 ioctl.h                                       |  17 +-
 libbtrfsutil/btrfs.h                          |  17 +-
 send.h                                        |  19 +-
 stubs.c                                       |  24 ++
 stubs.h                                       |  50 +++
 .../040-receive-write-encoded/test.sh         | 114 +++++
 13 files changed, 832 insertions(+), 52 deletions(-)
 create mode 100644 stubs.c
 create mode 100644 stubs.h
 create mode 100755 tests/misc-tests/040-receive-write-encoded/test.sh

Thanks!

-- 
2.28.0

