Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DD67BBF32
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 20:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjJFSyn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 14:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbjJFSyg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:54:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60046FA
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Oct 2023 11:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696618353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=U77XNGLnwWULayVswMfWLL1i4TVIjIjk+JqAucVdUWw=;
        b=Gci5YYw0T4D509LKJm1TvJows6OugrTSC3yqNXOose153iBjnelgN97c9c1DuZJiVWwhFN
        pgENTAixT+4mP2poWWUSjEf8th6DAFsCEd5QomvhFL1YC2LwYGOxKONtZCv1sFDsi/cYMC
        vgFN7Zi12a1nVzUAljrLkOulUYib56I=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-Rrr99Zi1OXWGocDuDr_4Bw-1; Fri, 06 Oct 2023 14:52:21 -0400
X-MC-Unique: Rrr99Zi1OXWGocDuDr_4Bw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9b99b6b8315so209599666b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Oct 2023 11:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696618339; x=1697223139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U77XNGLnwWULayVswMfWLL1i4TVIjIjk+JqAucVdUWw=;
        b=rlpYqxJohNm+sFJPKcZ4Wl+a3lW+9Mtp/D5PLvkULnrgPPuLdmnwD/4/bhdfJ27KZf
         Q2lpr1r1tWbcF/RLsw/1CGQUOysuDBoe7BGXs+FTMDqb2F5Ze0jJepVaCYIUryFLKcAW
         ivmN8EcMfPuyl9mnjGwJ+GBcCdq2eQveOZ+h2NOa6iSTLYRylaf/jX9K+zTsSB9Ec15k
         YZx89JbyhGYM0cN0B2VnrhHg4VoDyZeWB2D6Re3GZ+YNLRVY/TDUdit2XVJNpStxsv4t
         MbpvNqtAMurTI9SM8ZlDrlUXEOtMXyCxiRiTZ4MRZre5znZOzw3DvXoY/RpOaqJ9mO3p
         sG/w==
X-Gm-Message-State: AOJu0YyjnKa1lSGjDoScATaP5cuh6LSEYllG0xZcBNcWSOTc/FGx8y92
        9h0szcxBHI+etQtte9LiKKSsrttN0ePzTuWf0rXANtIiW8FhkbRa0NxfWCkehD24sMjR4eArZie
        V8s3zUDaFlYGjfWOIFd700KUR
X-Received: by 2002:a17:906:5390:b0:9a1:bd53:b23 with SMTP id g16-20020a170906539000b009a1bd530b23mr7607746ejo.14.1696618338847;
        Fri, 06 Oct 2023 11:52:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr+lyJbmFO9Qb1EBTA3K24arha6c82QRaS65GtE8tQEUkgnBiujkf/7vxyNkWZTLCPeJW9iQ==
X-Received: by 2002:a17:906:5390:b0:9a1:bd53:b23 with SMTP id g16-20020a170906539000b009a1bd530b23mr7607729ejo.14.1696618338427;
        Fri, 06 Oct 2023 11:52:18 -0700 (PDT)
Received: from localhost.localdomain ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id os5-20020a170906af6500b009b947f81c4asm3304741ejb.155.2023.10.06.11.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:52:18 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        fsverity@lists.linux.dev
Cc:     djwong@kernel.org, ebiggers@kernel.org, david@fromorbit.com,
        dchinner@redhat.com, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v3 00/28] fs-verity support for XFS
Date:   Fri,  6 Oct 2023 20:48:54 +0200
Message-Id: <20231006184922.252188-1-aalbersh@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

Quite a long time passed by from v2 but this is v3 of fs-verity
support in XFS.

This patchset introduces fs-verity [6] support in XFS. This
implementation uses extended attributes to store fs-verity
metadata. The Merkle tree blocks are stored in the remote extended
attributes. The names are offsets into the tree.

A few key points of this patchset:
- fs-verity works with Merkle tree blocks instead of PAGE references
  from filesystem
- Filesystem can supply bio_set and submit_io() to iomap for read
  path
- In XFS, fs-verity metadata is stored in extended attributes
- Verification happens in iomap's read IO path (offloaded to
  workqueue)
- New global XFS workqueue for verification processing
- Direct path and DAX are disabled for inodes with fs-verity
- Inodes with fs-verity have new on-disk diflag
- xfs_attr_get() can return a buffer with an extended attribute
- Each extended attribute has exactly one Merkle tree block
- xfs_buf with Merkle tree block allocates double memory and has
  duplicate of the extended attribute data with leaf headers and
  without
- xfs_buf tracks verified status of merkle tree block

The patchset consist of five parts:
- [1..4]: Patches from Parent Pointer patchset which add binary
          xattr names with a few deps
- [5]: Patch which adds FS_XFLAG_VERITY to make verity exposed as
  extended attribute flag
- [9..10]: Improvements to core fs-verity - mainly switch to blocks
  management instead of pages
- [11..12]: Allow filesystem to provide submit_io() and bio_set in
  read path
- [12..28]: Integration of fs-verity to xfs

Testing:
The patchset is tested with xfstests -g all (with exceptions) on
xfs_1k, xfs_4k, xfs_1k_quota, xfs_4k_quota, ext4_4k, and
ext4_4k_quota. With KMEMLEAK and KASAN enabled. Also, xfs_1k and
xfs_4k on a 64k pages.

Changes from V2:
- FS_XFLAG_VERITY extended attribute flag
- Change fs-verity to use Merkle tree blocks instead of expecting
  PAGE references from filesystem
- Change approach in iomap to filesystem provided bio_set and
  submit_io instead of just callouts to filesystem
- Add possibility for xfs_buf allocate more space for fs-verity
  extended attributes
- Make xfs_attr module to copy fs-verity blocks inside the xfs_buf,
  so XFS can get data without leaf headers
- Add Merkle tree removal for error path
- Makae scrub aware of new dinode flag
Changes from V1:
- Added parent pointer patches for easier testing
- Many issues and refactoring points fixed from the V1 review
- Adjusted for recent changes in fs-verity core (folios, non-4k)
- Dropped disabling of large folios
- Completely new fsverity patches (fix, callout, log_blocksize)
- Change approach to verification in iomap to the same one as in
  write path. Callouts to fs instead of direct fs-verity use.
- New XFS workqueue for post read folio verification
- xfs_attr_get() can return underlying xfs_buf
- xfs_bufs are marked with XBF_VERITY_CHECKED to track verified
  blocks

kernel:
[1]: https://github.com/alberand/linux/tree/fsverity-v3

xfsprogs:
[2]: https://github.com/alberand/xfsprogs/tree/fsverity-v3

xfstests:
[3]: https://github.com/alberand/xfstests/tree/fsverity-v3

v1:
[4]: https://lore.kernel.org/linux-xfs/20221213172935.680971-1-aalbersh@redhat.com/

v2:
[5]: https://lore.kernel.org/linux-xfs/20230404145319.2057051-1-aalbersh@redhat.com/

fs-verity:
[6]: https://www.kernel.org/doc/html/latest/filesystems/fsverity.html

Thanks,
Andrey

Allison Henderson (4):
  xfs: Add new name to attri/d
  xfs: add parent pointer support to attribute code
  xfs: define parent pointer xattr format
  xfs: Add xfs_verify_pptr

Andrey Albershteyn (24):
  fs: add FS_XFLAG_VERITY for fs-verity sealed inodes
  fsverity: add drop_page() callout
  fsverity: always use bitmap to track verified status
  fsverity: pass Merkle tree block size to ->read_merkle_tree_page()
  fsverity: pass log_blocksize to end_enable_verity()
  fsverity: operate with Merkle tree blocks instead of pages
  iomap: pass readpage operation to read path
  iomap: allow filesystem to implement read path verification
  xfs: add XBF_VERITY_CHECKED xfs_buf flag
  xfs: add XFS_DA_OP_BUFFER to make xfs_attr_get() return buffer
  xfs: introduce workqueue for post read IO work
  xfs: add bio_set and submit_io for ioend post-processing
  xfs: add attribute type for fs-verity
  xfs: make xfs_buf_get() to take XBF_* flags
  xfs: add XBF_DOUBLE_ALLOC to increase size of the buffer
  xfs: add fs-verity ro-compat flag
  xfs: add inode on-disk VERITY flag
  xfs: initialize fs-verity on file open and cleanup on inode
    destruction
  xfs: don't allow to enable DAX on fs-verity sealsed inode
  xfs: disable direct read path for fs-verity sealed files
  xfs: add fs-verity support
  xfs: make scrub aware of verity dinode flag
  xfs: add fs-verity ioctls
  xfs: enable ro-compat fs-verity flag

 Documentation/filesystems/fsverity.rst |   9 +
 fs/btrfs/verity.c                      |   7 +-
 fs/erofs/data.c                        |   4 +-
 fs/ext4/verity.c                       |   6 +-
 fs/f2fs/verity.c                       |   6 +-
 fs/gfs2/aops.c                         |   4 +-
 fs/ioctl.c                             |   4 +
 fs/iomap/buffered-io.c                 |  53 ++++-
 fs/verity/enable.c                     |   6 +-
 fs/verity/fsverity_private.h           |   1 -
 fs/verity/open.c                       |  64 +++---
 fs/verity/read_metadata.c              |  40 ++--
 fs/verity/verify.c                     | 126 +++---------
 fs/xfs/Makefile                        |   1 +
 fs/xfs/libxfs/xfs_attr.c               |  81 +++++++-
 fs/xfs/libxfs/xfs_attr.h               |   7 +-
 fs/xfs/libxfs/xfs_attr_leaf.c          |  24 ++-
 fs/xfs/libxfs/xfs_attr_remote.c        |  40 +++-
 fs/xfs/libxfs/xfs_da_btree.h           |   7 +-
 fs/xfs/libxfs/xfs_da_format.h          |  62 +++++-
 fs/xfs/libxfs/xfs_format.h             |  14 +-
 fs/xfs/libxfs/xfs_log_format.h         |   8 +-
 fs/xfs/libxfs/xfs_sb.c                 |   4 +-
 fs/xfs/scrub/attr.c                    |   4 +-
 fs/xfs/xfs_aops.c                      |  84 +++++++-
 fs/xfs/xfs_aops.h                      |   2 +
 fs/xfs/xfs_attr_item.c                 | 142 +++++++++++---
 fs/xfs/xfs_attr_item.h                 |   1 +
 fs/xfs/xfs_attr_list.c                 |  17 +-
 fs/xfs/xfs_buf.c                       |   7 +-
 fs/xfs/xfs_buf.h                       |  21 +-
 fs/xfs/xfs_file.c                      |  22 ++-
 fs/xfs/xfs_inode.c                     |   2 +
 fs/xfs/xfs_inode.h                     |   3 +-
 fs/xfs/xfs_ioctl.c                     |  22 +++
 fs/xfs/xfs_iomap.c                     |   3 +
 fs/xfs/xfs_iops.c                      |   4 +
 fs/xfs/xfs_linux.h                     |   1 +
 fs/xfs/xfs_mount.h                     |   3 +
 fs/xfs/xfs_ondisk.h                    |   4 +
 fs/xfs/xfs_super.c                     |  28 ++-
 fs/xfs/xfs_trace.h                     |   1 +
 fs/xfs/xfs_verity.c                    | 257 +++++++++++++++++++++++++
 fs/xfs/xfs_verity.h                    |  37 ++++
 fs/xfs/xfs_xattr.c                     |   9 +
 fs/zonefs/file.c                       |   4 +-
 include/linux/fsverity.h               | 129 ++++++++++++-
 include/linux/iomap.h                  |  36 +++-
 include/uapi/linux/fs.h                |   1 +
 49 files changed, 1170 insertions(+), 252 deletions(-)
 create mode 100644 fs/xfs/xfs_verity.c
 create mode 100644 fs/xfs/xfs_verity.h

-- 
2.40.1

