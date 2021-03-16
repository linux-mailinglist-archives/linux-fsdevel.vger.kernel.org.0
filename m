Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B87333DDE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 20:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240607AbhCPToz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 15:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240536AbhCPToU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:44:20 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82C1C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 12:44:19 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id x7so9536803pfi.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 12:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RgW7hnF9c6s7+FBn7LV2hshi72WY217NOlobehQ4kg4=;
        b=WOEVOSgJD4QOUP/QNqCNAshTtWBzZG01noojI+C0tHFKCg+zgNSXdQGNRL0ycEg0sx
         hwNrQt+GoNhV8i+8x6cX9n1Ct54rgbsg2maJ2Nr8rSU1QBNRXLy4G5efwjMshQ1zDShs
         fcjOjCbq4KzOgoR6SExBevxTCgDeFPL7EVswviy7VX+sM1bcZ+X7aJCFMvpzVJVOhY5e
         ZkCd6SmHBgHl9vQW+1eEbDmhicUQ9frHi7ZbiIqe119G1hNYkNB38h0PGx+qCN265XnO
         pej8b6GgeJ7wy+bPndynmfGfABaxj6YiyX54zTSB5VEBhEKG6blBHKbIAnlW7hsfuqBd
         ChoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RgW7hnF9c6s7+FBn7LV2hshi72WY217NOlobehQ4kg4=;
        b=aqt2lml+VDMkLu1TefC3E9A6mu8XGz5242XOQG1GaIrT4/z2dSv3UfzbO8CTpDUaLL
         RxAOxPpO55REyT85dUPrSvHKb7VWlHZsWL/IrsXFFUsAjOStBe3+Qs8c+Ip6drEtGSUk
         jhhhWSf8QJlIU4NbsGwsPWg3Koya4XvAYG3rKKH1TOK6jNl30TtY2vAMwjCc7tK6KBL7
         KaZ8+UufvSWKi1D0v2KIz5OjmcCK3yA5k6X50alSZFNHOxh8TYL2C/h8BmQKohu7lJVk
         5C0ESAI5bRHbk1BiAOiwypF7u9YXeQ8lFyjYQPOxA4nPSr0DMSxCVdBU8JEVQl/C/T/P
         ukZQ==
X-Gm-Message-State: AOAM5314Gp0wuD0MH/3oBF7KduXe2u64NJkMBoBAR89tmUTifaMljhkI
        PIJCB/smyIjr7lTzux1GsK4w0Q==
X-Google-Smtp-Source: ABdhPJxoyOXBNQxVQITG19pAR+jhh8gYRUcxImzPsYJsJmWTmrnIwgEC2CmfVFetLibJu7qmPNnVCA==
X-Received: by 2002:a63:d1c:: with SMTP id c28mr1096053pgl.113.1615923859139;
        Tue, 16 Mar 2021 12:44:19 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:532])
        by smtp.gmail.com with ESMTPSA id w22sm16919104pfi.133.2021.03.16.12.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 12:44:17 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 0/5] btrfs: implement send/receive of compressed extents without decompressing
Date:   Tue, 16 Mar 2021 12:43:49 -0700
Message-Id: <cover.1615922753.git.osandov@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

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
was the least bad of the options I considered.

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
`--compressed-data` option; the latter implies `--stream-version 2`.

`btrfs receive` also accepts a `--force-decompress` option that forces
the fallback to decompressing and writing the decompressed data.

These options are provided to give the user flexibility in case they
don't want their receiving filesytem to be compressed.

Patches
=======

The kernel patches are based on kdave/misc-next plus v8 of my "fs:
interface for directly reading/writing compressed data" series. Patches
1-3 do some preparation for stream v2 and compressed send. Patch 4
implements compressed send. Patch 5 modifies the ioctl to accept the new
flags and enable the new feature.

Changes since v3 [1]:

- Rebased on current kdave/misc-next (v5.12-rc3).

Omar Sandoval (5):
  btrfs: add send stream v2 definitions
  btrfs: send: write larger chunks when using stream v2
  btrfs: send: allocate send buffer with alloc_page() and vmap() for v2
  btrfs: send: send compressed extents with encoded writes
  btrfs: send: enable support for stream v2 and compressed writes

 fs/btrfs/ctree.h           |   4 +
 fs/btrfs/inode.c           |   6 +-
 fs/btrfs/send.c            | 307 +++++++++++++++++++++++++++++++++----
 fs/btrfs/send.h            |  32 +++-
 include/uapi/linux/btrfs.h |  17 +-
 5 files changed, 332 insertions(+), 34 deletions(-)

The btrfs-progs patches were written by Boris Burkov with some updates
from me. Patches 1-5 are preparation. Patch 6 implements encoded writes.
Patch 7 implements the fallback to decompressing. Patches 9 and 10
implement the other commands. Patch 10 adds the new `btrfs send`
options. Patch 11 adds a test case.

Changes since v3 [1]:

- Rebased on latest devel branch.

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

 Documentation/btrfs-receive.asciidoc          |   4 +
 Documentation/btrfs-send.asciidoc             |  16 +-
 Makefile                                      |   4 +-
 cmds/receive-dump.c                           |  31 +-
 cmds/receive.c                                | 403 +++++++++++++++++-
 cmds/send.c                                   |  54 ++-
 common/send-stream.c                          | 157 +++++--
 common/send-stream.h                          |   7 +
 configure.ac                                  |   1 +
 ioctl.h                                       |  17 +-
 libbtrfsutil/btrfs.h                          |  17 +-
 send.h                                        |  19 +-
 stubs.c                                       |  24 ++
 stubs.h                                       |  57 +++
 .../043-receive-write-encoded/test.sh         | 114 +++++
 15 files changed, 874 insertions(+), 51 deletions(-)
 create mode 100644 stubs.c
 create mode 100644 stubs.h
 create mode 100755 tests/misc-tests/043-receive-write-encoded/test.sh

-- 
2.30.2

