Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB262B84B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 20:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbgKRTTI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 14:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbgKRTTI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 14:19:08 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EFEC0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:19:07 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id m9so1869500pgb.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/M0BdTT3xiFytMNNHoE02k3W1SSL3kUy/oUu2qOw9to=;
        b=mbYF5NQG2RMxtyPn7hyRTGT9W6pfZ2oQqpuHPhlSjaNmb71BbnhfVOjQVSkwp+7mr9
         KRclfiYa3AXlk0We29wfAP3mTyNNagLCD+cR0xhWv8PqL+OIgCVt7ywIlqU3U7qBWxiU
         1zQ2zRi7l6bJPJ54MzQHuqEzQ3l6+aLit1LIcx8FTNwWTWN3JKtbO4ImkjCVyeME35gQ
         9pZCO/u58ZLKCBQoUQkou3Uf5VBqB8vdfIFgGd4yJQfth+iQz39yhTeqQScqES5X7Cs+
         uLcwCtU0hMbHncdPcoV3aoFlW44NXwO64EmbyjJe1crPaaFk6mCQ0vjktHtvvMS8XoAk
         Mb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/M0BdTT3xiFytMNNHoE02k3W1SSL3kUy/oUu2qOw9to=;
        b=RG9X9HEzuffDeewP12helJZcXTBj8l82HC+kv3jo93MBEqDZAXOgsmhLuv01vuRtlq
         Au1phFhVuwR3YRQCjVn1ieUpuZDmH5dOv5pWBlrILdH//8kvHNWCeBiogvA6ZrVlNrhy
         432cYpCPWAFBVfR5mgrHseNeIpEtL5EFC7gBNZVXwiCeBCzF4v1eKjxeHpLIIS1QoFti
         3Kne3oJ5XqAgNIkqJlm/yRKwn7hOEP7XQwHodhFVqkmDCU/9Khqxs60KKEsDQUZmNbd3
         rUEYMEnxfDvuQy7JzmBm8TcqeSwSP2pKB8hBG0zTZ8rDcXYrnIWX/ftM0NImElL+k8U/
         oe5Q==
X-Gm-Message-State: AOAM531qxeY8svRJfiz9GV2zBTtW+fWIt3MSpCsD8oOpOpJ78Ap4AmBf
        Go+TdmCxP0Go+XUbu8YBxfegxQ==
X-Google-Smtp-Source: ABdhPJwWUzetlAOquLGRT/RY044KJu92nrhT2IcU4yaR+Kw99a5FG6tH3L1fffjPycAJysnjwlf6sg==
X-Received: by 2002:a05:6a00:1389:b029:18b:2d21:2f1a with SMTP id t9-20020a056a001389b029018b2d212f1amr6117083pfg.1.1605727146290;
        Wed, 18 Nov 2020 11:19:06 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:8b43])
        by smtp.gmail.com with ESMTPSA id l9sm3197221pjy.10.2020.11.18.11.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 11:19:05 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 0/5] btrfs: implement send/receive of compressed extents without decompressing
Date:   Wed, 18 Nov 2020 11:18:42 -0800
Message-Id: <cover.1605723600.git.osandov@fb.com>
X-Mailer: git-send-email 2.29.2
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

The kernel patches are based on kdave/misc-next plus v6 of my "fs:
interface for directly reading/writing compressed data" series. Patches
1-3 do some preparation for stream v2 and compressed send. Patch 4
implements compressed send. Patch 5 modifies the ioctl to accept the new
flags and enable the new feature.

Changes since v1 [1]:

- Added reviewed-bys and fixed up minor comments.

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
from me. Patch 1 is a trivial fix for a crash in option parsing. Patches
2-7 are preparation. Patch 8 implements encoded writes. Patch 9
implements the fallback to decompressing. Patches 10 and 11 implement
the other commands. Patch 12 adds the new `btrfs send` options. Patch 13
adds a test case.

Changes since v1 [1]:

- Added patch to fix option parsing crash.
- Added documentation for new options.
- Added O_CLOEXEC to match new kernel requirement for O_ALLOW_ENCODED.
- Fixed writing at incorrect offset for decompression fallback.
- Fixed handling of padding in LZO decompression fallback (using new
  per-page size LZO compression modes returned by the kernel).
- Fixed stub definition of O_ALLOW_ENCODED on Alpha, PA-RISC, and SPARC.
- Renamed send --compressed to --compressed-data to avoid
  misunderstandings that this would compress the whole send stream.

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

Omar Sandoval (2):
  btrfs-progs: send: fix crash on unknown option
  btrfs-progs: receive: open files with O_CLOEXEC

 Documentation/btrfs-receive.asciidoc          |   4 +
 Documentation/btrfs-send.asciidoc             |  16 +-
 Makefile                                      |   4 +-
 cmds/receive-dump.c                           |  31 +-
 cmds/receive.c                                | 407 +++++++++++++++++-
 cmds/send.c                                   |  57 ++-
 common/send-stream.c                          | 157 +++++--
 common/send-stream.h                          |   7 +
 configure.ac                                  |   1 +
 ioctl.h                                       |  17 +-
 libbtrfsutil/btrfs.h                          |  17 +-
 send.h                                        |  19 +-
 stubs.c                                       |  24 ++
 stubs.h                                       |  67 +++
 .../042-receive-write-encoded/test.sh         | 114 +++++
 15 files changed, 890 insertions(+), 52 deletions(-)
 create mode 100644 stubs.c
 create mode 100644 stubs.h
 create mode 100755 tests/misc-tests/042-receive-write-encoded/test.sh

1: https://lore.kernel.org/linux-btrfs/cover.1597994106.git.osandov@osandov.com/

-- 
2.29.2

