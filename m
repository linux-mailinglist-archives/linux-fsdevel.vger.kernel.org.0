Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B36A57DABD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 09:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiGVHOH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 03:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbiGVHOE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:14:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0D293C1E;
        Fri, 22 Jul 2022 00:14:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCD1862188;
        Fri, 22 Jul 2022 07:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F25C341C6;
        Fri, 22 Jul 2022 07:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658474042;
        bh=9mq8X3BGsuBzR6Ln4xciUKT8RQwcULSFGtUPi9jeosE=;
        h=From:To:Cc:Subject:Date:From;
        b=FLVRrpieLDHN39FkoGOUIAkHKLGpScI1ahdV3AgjGwfrcluvepuBzBT6F2984u3pe
         YxdD4BK8sy57CBvIm0XSdTFHQJcTcxNfBuwIZ22bE+QsqIcWOa3jZVywdVcsgMnYMl
         P8eZPra5KWYWA4zPs0rDJwnuri0qsYj5L/yrWJbb40slzWXWuRwOl/sdNhOL0RjjiZ
         t3hdZX2Thct6y6Piv8vzHp2E9U66v9l12USihLfnS30azOvbROyOeiNtaOmUZhk+ya
         QY9fg85OhHr4fbM1wBBORT+kBwT4kVrxB6luu3IFOzwg+6fTek78HFSblPNzVzfX+z
         MqEM0tbLisn/Q==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v4 0/9] make statx() return DIO alignment information
Date:   Fri, 22 Jul 2022 00:12:19 -0700
Message-Id: <20220722071228.146690-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset makes the statx() system call return direct I/O (DIO)
alignment information.  This allows userspace to easily determine
whether a file supports DIO, and if so with what alignment restrictions.

Patch 1 adds the basic VFS support for STATX_DIOALIGN.  Patch 2 wires it
up for all block device files.  The remaining patches wire it up for
regular files on ext4, f2fs, and xfs.  Support for regular files on
other filesystems can be added later.

I've also written a man-pages patch, which I'm sending separately.

Note, f2fs has one corner case where DIO reads are allowed but not DIO
writes.  The proposed statx fields can't represent this.  My proposal
(patch 6) is to just eliminate this case, as it seems much too weird.
But I'd appreciate any feedback on that part.

This patchset applies to v5.19-rc7.

Changed v3 => v4:
   - Added xfs support.

   - Moved the helper function for block devices into block/bdev.c.
   
   - Adjusted the ext4 patch to not introduce a bug where misaligned DIO
     starts being allowed on encrypted files when it gets combined with
     the patch "iomap: add support for dma aligned direct-io" that is
     queued in the block tree for 5.20.

   - Made a simplification in fscrypt_dio_supported().

Changed v2 => v3:
   - Dropped the stx_offset_align_optimal field, since its purpose
     wasn't clearly distinguished from the existing stx_blksize.

   - Renamed STATX_IOALIGN to STATX_DIOALIGN, to reflect the new focus
     on DIO only.

   - Similarly, renamed stx_{mem,offset}_align_dio to
     stx_dio_{mem,offset}_align, to reflect the new focus on DIO only.

   - Wired up STATX_DIOALIGN on block device files.

Changed v1 => v2:
   - No changes.

Eric Biggers (9):
  statx: add direct I/O alignment information
  vfs: support STATX_DIOALIGN on block devices
  fscrypt: change fscrypt_dio_supported() to prepare for STATX_DIOALIGN
  ext4: support STATX_DIOALIGN
  f2fs: move f2fs_force_buffered_io() into file.c
  f2fs: don't allow DIO reads but not DIO writes
  f2fs: simplify f2fs_force_buffered_io()
  f2fs: support STATX_DIOALIGN
  xfs: support STATX_DIOALIGN

 block/bdev.c              | 25 ++++++++++++++++++++
 fs/crypto/inline_crypt.c  | 49 +++++++++++++++++++--------------------
 fs/ext4/ext4.h            |  1 +
 fs/ext4/file.c            | 37 ++++++++++++++++++++---------
 fs/ext4/inode.c           | 36 ++++++++++++++++++++++++++++
 fs/f2fs/f2fs.h            | 45 -----------------------------------
 fs/f2fs/file.c            | 45 ++++++++++++++++++++++++++++++++++-
 fs/stat.c                 | 14 +++++++++++
 fs/xfs/xfs_iops.c         |  9 +++++++
 include/linux/blkdev.h    |  4 ++++
 include/linux/fscrypt.h   |  7 ++----
 include/linux/stat.h      |  2 ++
 include/uapi/linux/stat.h |  4 +++-
 13 files changed, 190 insertions(+), 88 deletions(-)

base-commit: ff6992735ade75aae3e35d16b17da1008d753d28
-- 
2.37.0

