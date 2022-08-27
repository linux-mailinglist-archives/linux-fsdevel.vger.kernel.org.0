Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAA25A352D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 09:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbiH0HBj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 03:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiH0HBe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 03:01:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C788E9A5;
        Sat, 27 Aug 2022 00:01:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78011B80EB0;
        Sat, 27 Aug 2022 07:01:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEACEC433C1;
        Sat, 27 Aug 2022 07:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661583690;
        bh=TD/VF5KHXD4wRG8Pr+H+EfaARgN73usGJgQBXXdf6qM=;
        h=From:To:Cc:Subject:Date:From;
        b=LWAceR3fhWYIDpnV9qqfOwOsgBjiLxafwZdx0ifwtHygtEzCeOTClFwZD/Q2YfBW7
         YPwl6lS4PhtvirZ8wp8caBSWY+mMIrSihflRr5bozhXZ5FK/PrU5FrIybPCGIXMjdH
         NLO2WO7PqCl+GYNxdjD0iXQmDmLF+2mMX0U/9Gz/r5eeXGdC6GxSbYNWyQaePi90hO
         J/qqblaICEwrvm0aWoDR+ropylNWmjuUSB4cM6fYqQS9BM1W0FRXtkr145+AZIC0uO
         VGSXaLiZabc1a9wD+g1cJ5gA5UmWKC6cQh9TW50atN2cCEtx/FUHMyWbtRid75dM6H
         aO8BLnX612WYQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v5 0/8] make statx() return DIO alignment information
Date:   Fri, 26 Aug 2022 23:58:43 -0700
Message-Id: <20220827065851.135710-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

I've also written a man-pages patch, which I sent separately:
https://lore.kernel.org/r/20220722074229.148925-1-ebiggers@kernel.org

Note, f2fs has a corner case where DIO reads are allowed but not DIO
writes.  The proposed statx fields can't represent this.  The current
proposal just reports that DIO is unsupported in this case.

This patchset applies to v6.0-rc2.

Changed in v5:
   - Accounted for the DIO changes in 6.0 by setting dio_mem_align to
     the DMA alignment instead of the logical block size where needed.

   - Dropped the patch "f2fs: don't allow DIO reads but not DIO writes".

   - Added some Reviewed-by and Acked-by tags.

Changed in v4:
   - Added xfs support.

   - Moved the helper function for block devices into block/bdev.c.
   
   - Adjusted the ext4 patch to not introduce a bug where misaligned DIO
     starts being allowed on encrypted files when it gets combined with
     the patch "iomap: add support for dma aligned direct-io" that is
     queued in the block tree for 5.20.

   - Made a simplification in fscrypt_dio_supported().

Changed in v3:
   - Dropped the stx_offset_align_optimal field, since its purpose
     wasn't clearly distinguished from the existing stx_blksize.

   - Renamed STATX_IOALIGN to STATX_DIOALIGN, to reflect the new focus
     on DIO only.

   - Similarly, renamed stx_{mem,offset}_align_dio to
     stx_dio_{mem,offset}_align, to reflect the new focus on DIO only.

   - Wired up STATX_DIOALIGN on block device files.

Changed in v2:
   - No changes.

Eric Biggers (8):
  statx: add direct I/O alignment information
  vfs: support STATX_DIOALIGN on block devices
  fscrypt: change fscrypt_dio_supported() to prepare for STATX_DIOALIGN
  ext4: support STATX_DIOALIGN
  f2fs: move f2fs_force_buffered_io() into file.c
  f2fs: simplify f2fs_force_buffered_io()
  f2fs: support STATX_DIOALIGN
  xfs: support STATX_DIOALIGN

 block/bdev.c              | 23 ++++++++++++++++++
 fs/crypto/inline_crypt.c  | 49 +++++++++++++++++++--------------------
 fs/ext4/ext4.h            |  1 +
 fs/ext4/file.c            | 37 ++++++++++++++++++++---------
 fs/ext4/inode.c           | 37 +++++++++++++++++++++++++++++
 fs/f2fs/f2fs.h            | 40 --------------------------------
 fs/f2fs/file.c            | 43 +++++++++++++++++++++++++++++++++-
 fs/stat.c                 | 14 +++++++++++
 fs/xfs/xfs_iops.c         | 10 ++++++++
 include/linux/blkdev.h    |  4 ++++
 include/linux/fscrypt.h   |  7 ++----
 include/linux/stat.h      |  2 ++
 include/uapi/linux/stat.h |  4 +++-
 13 files changed, 188 insertions(+), 83 deletions(-)


base-commit: 1c23f9e627a7b412978b4e852793c5e3c3efc555
-- 
2.37.2

