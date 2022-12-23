Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D20F655443
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Dec 2022 21:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbiLWUhA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Dec 2022 15:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbiLWUg6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Dec 2022 15:36:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F581D307;
        Fri, 23 Dec 2022 12:36:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95C8861D28;
        Fri, 23 Dec 2022 20:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1111C433D2;
        Fri, 23 Dec 2022 20:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671827816;
        bh=kuHoLDiwzIWt/yosaiuNbL76iPgmKQeB3oMrh4p5xhg=;
        h=From:To:Cc:Subject:Date:From;
        b=B7Cu5MHwFXyHpkWZYORJe5npw6Jrf1ax1VKcHSg3IFIcJDzGR9a97Ncit2dNZPAIn
         zchceSAsxgUW9LWZwY+Qs21W42THfLhyb73HWKYCQMD6C3nyrNmv03p6rEqIKff2vX
         rGocAZ5zYfyRKsGNeRx5kmBn6OpsxJaxvfI0pqee3hx1HNdZXebmxhO1m0ANxY9Osp
         w/RSqDNgQw3oGnoM8VKaM1pEOZnyb0VQUtFSgmrbPXZ4DFlh6cLeHnmzpgqJ0IJS7e
         oHfsWT1U3jch+XCx3vCHk3VC1pQueY3KEUpgWxfGU6DxWmkttz2NYAqCwQeIyJzmL0
         RCxP/GM9U3Qmg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v2 00/11] fsverity: support for non-4K pages
Date:   Fri, 23 Dec 2022 12:36:27 -0800
Message-Id: <20221223203638.41293-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[This patchset applies to mainline + some fsverity cleanups I sent out
 recently.  You can get everything from tag "fsverity-non4k-v2" of
 https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git ]

Currently, filesystems (ext4, f2fs, and btrfs) only support fsverity
when the Merkle tree block size, filesystem block size, and page size
are all the same.  In practice that means 4K, since increasing the page
size, e.g. to 16K, forces the Merkle tree block size and filesystem
block size to be increased accordingly.  That can be impractical; for
one, users want the same file signatures to work on all systems.

Therefore, this patchset reduces the coupling between these sizes.

First, patches 1-4 are cleanups.

Second, patches 5-9 allow the Merkle tree block size to be less than the
page size or filesystem block size, provided that it's not larger than
either one.  This involves, among other things, changing the way that
fs/verity/verify.c tracks which hash blocks have been verified.

Finally, patches 10-11 make ext4 support fsverity when the filesystem
block size is less than the page size.  Note, f2fs doesn't need similar
changes because f2fs always assumes that the filesystem block size and
page size are the same anyway.  I haven't looked into btrfs yet.

I've tested this patchset using the "verity" group of tests in xfstests
with the following xfstests patchset applied:
"[PATCH v2 00/10] xfstests: update verity tests for non-4K block and page size"
(https://lore.kernel.org/fstests/20221223010554.281679-1-ebiggers@kernel.org/T/#u)

Note: on the thread "[RFC PATCH 00/11] fs-verity support for XFS"
(https://lore.kernel.org/linux-xfs/20221213172935.680971-1-aalbersh@redhat.com/T/#u)
there have been many requests for other things to support, including:

  * folios in the pagecache
  * alternative Merkle tree caching methods
  * direct I/O
  * merkle_tree_block_size > page_size
  * extremely large files, using a reclaimable bitmap

We shouldn't try to boil the ocean, though, so to keep the scope of this
patchset manageable I haven't changed it significantly from v1.  This
patchset does bring us closer to many of the above, just not all the way
there.  I'd like to follow up this patchset with a change to support
folios, which should be straightforward.  Next, we can do a change to
generalize the Merkle tree interface to allow XFS to use an alternative
caching method, as that sounds like the highest priority item for XFS.

Anyway, the changelog is:

Changed in v2:
   - Rebased onto the recent fsverity cleanups.
   - Split some parts of the big "support verification" patch into
     separate patches.
   - Passed the data_pos to verify_data_block() instead of computing it
     using page->index, to make it ready for folio and DIO support.
   - Eliminated some unnecessary arithmetic in verify_data_block().
   - Changed the log_* fields in merkle_tree_params to u8.
   - Restored PageLocked and !PageUptodate checks for pagecache pages.
   - Eliminated the change to fsverity_hash_buffer().
   - Other small cleanups

Eric Biggers (11):
  fsverity: use unsigned long for level_start
  fsverity: simplify Merkle tree readahead size calculation
  fsverity: store log2(digest_size) precomputed
  fsverity: use EFBIG for file too large to enable verity
  fsverity: replace fsverity_hash_page() with fsverity_hash_block()
  fsverity: support verification with tree block size < PAGE_SIZE
  fsverity: support enabling with tree block size < PAGE_SIZE
  ext4: simplify ext4_readpage_limit()
  f2fs: simplify f2fs_readpage_limit()
  fs/buffer.c: support fsverity in block_read_full_folio()
  ext4: allow verity with fs block size < PAGE_SIZE

 Documentation/filesystems/fsverity.rst |  76 +++---
 fs/buffer.c                            |  67 ++++-
 fs/ext4/readpage.c                     |   3 +-
 fs/ext4/super.c                        |   5 -
 fs/f2fs/data.c                         |   3 +-
 fs/verity/enable.c                     | 260 ++++++++++----------
 fs/verity/fsverity_private.h           |  20 +-
 fs/verity/hash_algs.c                  |  24 +-
 fs/verity/open.c                       |  98 ++++++--
 fs/verity/verify.c                     | 325 +++++++++++++++++--------
 include/linux/fsverity.h               |  14 +-
 11 files changed, 565 insertions(+), 330 deletions(-)

-- 
2.39.0

