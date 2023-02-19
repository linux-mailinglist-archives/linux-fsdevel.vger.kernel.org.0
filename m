Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D22B69C28A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Feb 2023 21:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjBSUsh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Feb 2023 15:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjBSUsg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Feb 2023 15:48:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C26CDE3;
        Sun, 19 Feb 2023 12:48:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8779A60C5F;
        Sun, 19 Feb 2023 20:48:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A891DC433D2;
        Sun, 19 Feb 2023 20:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676839711;
        bh=pPKAZ01/fvm24mHTwEi4mThE8LjTnMIHE3uOq5HgJ2A=;
        h=Date:From:To:Cc:Subject:From;
        b=oSlao0JM5OYo6ACCVQAkZY5Q93HpYAmJpHW43ds1Q+OotpwLMAC3C9/0HAr7TFg3j
         6iIScv4Z4TH0wEmaVQkCJdPjTX6g/FquCqjZVYcGvxDH07+RM8m6LDrUySsLDBPuqi
         kx6b261+A/6sLtqlXctM6FSJAAIPJJv77aUq42aj0pCr5WDIc1kyWj5lhvOVYLkn0r
         cUh/UmZQFRoSM6xwvOh9KAflYXuOznidceBSBU+f2ggZiirn5X6fhwfMXGWTtNFT8S
         6TdKb8FV8xBjDKCf2hVWu6N3Wia/s6Wev2JmhPmVMgbPD47DmxWaULT29NvK4TcFeJ
         G9byS+5xJ9d0A==
Date:   Sun, 19 Feb 2023 12:48:29 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: [GIT PULL] fsverity updates for 6.3
Message-ID: <Y/KLHT3zaA0QFhVJ@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 88603b6dc419445847923fcb7fe5080067a30f98:

  Linux 6.2-rc2 (2023-01-01 13:53:16 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus

for you to fetch changes up to 51e4e3153ebc32d3280d5d17418ae6f1a44f1ec1:

  fscrypt: support decrypting data from large folios (2023-01-28 15:10:12 -0800)

----------------------------------------------------------------

Fix the longstanding implementation limitation that fsverity was only
supported when the Merkle tree block size, filesystem block size, and
PAGE_SIZE were all equal.  Specifically, add support for Merkle tree
block sizes less than PAGE_SIZE, and make ext4 support fsverity on
filesystems where the filesystem block size is less than PAGE_SIZE.

Effectively, this means that fsverity can now be used on systems with
non-4K pages, at least on ext4.  These changes have been tested using
the verity group of xfstests, newly updated to cover the new code paths.

Also update fs/verity/ to support verifying data from large folios.
There's also a similar patch for fs/crypto/, to support decrypting data
from large folios, which I'm including in this pull request to avoid a
merge conflict between the fscrypt and fsverity branches.

There will be a merge conflict in fs/buffer.c with some of the foliation
work in the mm tree.  Please use the merge resolution from linux-next.

----------------------------------------------------------------
Eric Biggers (19):
      fsverity: optimize fsverity_file_open() on non-verity files
      fsverity: optimize fsverity_prepare_setattr() on non-verity files
      fsverity: optimize fsverity_cleanup_inode() on non-verity files
      fsverity: pass pos and size to ->write_merkle_tree_block
      fsverity: remove debug messages and CONFIG_FS_VERITY_DEBUG
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
      fsverity.rst: update git repo URL for fsverity-utils
      fsverity: support verifying data from large folios
      fscrypt: support decrypting data from large folios

 Documentation/filesystems/fscrypt.rst  |   4 +-
 Documentation/filesystems/fsverity.rst |  96 +++++----
 fs/btrfs/verity.c                      |  19 +-
 fs/buffer.c                            |  72 +++++--
 fs/crypto/bio.c                        |  10 +-
 fs/crypto/crypto.c                     |  28 +--
 fs/ext4/inode.c                        |   6 +-
 fs/ext4/readpage.c                     |   3 +-
 fs/ext4/super.c                        |   5 -
 fs/ext4/verity.c                       |   6 +-
 fs/f2fs/data.c                         |   3 +-
 fs/f2fs/verity.c                       |   6 +-
 fs/verity/Kconfig                      |   8 -
 fs/verity/enable.c                     | 271 ++++++++++++--------------
 fs/verity/fsverity_private.h           |  24 +--
 fs/verity/hash_algs.c                  |  24 ++-
 fs/verity/init.c                       |   1 -
 fs/verity/open.c                       | 163 +++++++++-------
 fs/verity/signature.c                  |   2 -
 fs/verity/verify.c                     | 346 ++++++++++++++++++++++-----------
 include/linux/fscrypt.h                |   9 +-
 include/linux/fsverity.h               |  93 +++++++--
 22 files changed, 699 insertions(+), 500 deletions(-)
