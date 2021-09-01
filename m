Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF90A3FE08F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 19:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344665AbhIARCZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 13:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245229AbhIARCY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:02:24 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9514FC061575
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Sep 2021 10:01:27 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id gp20-20020a17090adf1400b00196b761920aso160707pjb.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Sep 2021 10:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7z/2dlf0grWEDBYN4uBpH9eN+dQign0MVAnQPoL4FCI=;
        b=SGmKIf7tlBfPr0guxBZYwXYtkwbjtmVtlw9BMNNqkPuJhTMnou2pWpE4TpZmX0S3To
         XUU3YH5kDpAJ+xm2pyr9HgCcURxQOVRD50zql7kLN0CWkR4+udpILV4r1RN8lPet/Ex0
         uY24+XJmgclryg30uZ8aFnDfa7dN2YI6oT3AfXrGHYxULPBDLZSKaHyHBmm/o3NYVcim
         Zb1sDtKxrboGjedha9wrONqzvumRG74Cdven23JFKXblkKXizJAPrhasp5qn5l90V5i3
         ggUrYsBLDskiK0jp8Dotk4/SObvW/TdcsYIFYdBaIYPO8UfoVtQKhar2hSivP1cApQzX
         /bww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7z/2dlf0grWEDBYN4uBpH9eN+dQign0MVAnQPoL4FCI=;
        b=NKPn/XSwzQw8/mT8TTRb9K4eNoHMNu6uqNPk1WohFc1ALgdqnpKhkIyTpJ2a8jm9Ao
         elOmgXmdOUQmFRo3vVheEaudRqu23ymbYgoAmZYPi9+b7lM8WYdyfScnUYLrbxzLmbBN
         cUAv3K/OVGGYRooFN2y445rHObgLTRn0NuQcqunq5EqkZwFOuhZuHzqYGxfCleEgk4Kt
         +bFrfDPkOkfGWSlZbZl7WDKTS2gFyOOabJkZiY/c60I+smX95MrNuT0DvSj8aPxvoXN+
         r4Vbg34+NsaTT2UjDFrht450ZIV5VzmrpGfNYuCVnRDxlNZe+8Wm/up9l2kkWmDiKq92
         oIJg==
X-Gm-Message-State: AOAM532hsujxxjlV6UFSTunD2K4jb5a2nscJwD7Rn0FYJJqMrh3oez27
        u3vnrPdj+Mt+04icpsDgh8fwVUpWrORVgw==
X-Google-Smtp-Source: ABdhPJytGmKyXo5rkmIO4tgwrK5+2+MBFj7bC+6lm3wyFfgwR0hVBdgwITuwmiJeZ8yyGgOFeDGTCA==
X-Received: by 2002:a17:90a:1991:: with SMTP id 17mr342058pji.149.1630515686879;
        Wed, 01 Sep 2021 10:01:26 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:a2b2])
        by smtp.gmail.com with ESMTPSA id y7sm58642pff.206.2021.09.01.10.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 10:01:26 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH v11 00/14] btrfs: add ioctls and send/receive support for reading/writing compressed data
Date:   Wed,  1 Sep 2021 10:00:55 -0700
Message-Id: <cover.1630514529.git.osandov@fb.com>
X-Mailer: git-send-email 2.33.0
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
more details and benchmarks [1]. Patches 10-12 prepare some protocol
changes for send stream v2. Patch 13 implements compressed send. Patch
14 enables send stream v2 and compressed send in the send ioctl when
requested.

These patches are based on Dave Sterba's Btrfs misc-next branch [2],
which is in turn currently based on v5.14-rc7. Test cases are here [3].

Changes since v10 [4]:

Addressed Dave's and Nikolay's comments, mostly stylistic.

- Renamed __generic_write_checks() to generic_write_checks_count().
- Add missing count == 0 check to generic_write_checks_count().
- Used in_range() macro in btrfs_csum_one_bio().
- Renamed page_offsets variable to use_page_offsets in
  btrfs_csum_one_bio().
- Removed conditional on offset increment in btrfs_csum_one_bio().
- Fixed stale reference to RWF_ENCODED in comment.

1: https://lore.kernel.org/linux-btrfs/cover.1615922753.git.osandov@fb.com/
2: https://github.com/kdave/btrfs-devel/tree/misc-next
3: https://github.com/osandov/xfstests/tree/btrfs-encoded-io
4: https://lore.kernel.org/linux-btrfs/cover.1629234193.git.osandov@fb.com/

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
 fs/btrfs/file-item.c       |  32 +-
 fs/btrfs/file.c            |  68 ++-
 fs/btrfs/inode.c           | 911 +++++++++++++++++++++++++++++++++----
 fs/btrfs/ioctl.c           | 213 +++++++++
 fs/btrfs/ordered-data.c    | 124 ++---
 fs/btrfs/ordered-data.h    |  25 +-
 fs/btrfs/relocation.c      |   2 +-
 fs/btrfs/send.c            | 307 +++++++++++--
 fs/btrfs/send.h            |  32 +-
 fs/internal.h              |   5 -
 fs/read_write.c            |  34 +-
 include/linux/fs.h         |   2 +
 include/uapi/linux/btrfs.h | 149 +++++-
 17 files changed, 1686 insertions(+), 271 deletions(-)

The btrfs-progs patches were written by Boris Burkov with some updates
from me. Patches 1-4 are preparation. Patch 5 implements encoded writes.
Patch 6 implements the fallback to decompressing. Patches 7 and 8
implement the other commands. Patch 9 adds the new `btrfs send` options.
Patch 10 adds a test case.

Changes from v10:

- Fixed feature fallback to check for ENOTTY instead of EOPNOTSUPP.

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
2.33.0

