Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D9B611D9D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Oct 2022 00:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiJ1Wry (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 18:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiJ1Wrt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:47:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31142199F45;
        Fri, 28 Oct 2022 15:47:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 37582CE2E9F;
        Fri, 28 Oct 2022 22:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8C6C433D6;
        Fri, 28 Oct 2022 22:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666997265;
        bh=4Gis4J6FInfcpasgqe1VktNVUDifHwCLxkhJxJDfYg8=;
        h=From:To:Cc:Subject:Date:From;
        b=Tw4NUWnK6m8OaUTrRHH905TS9LfG6I9nYNG0Jz3Uwr35Q4LdLMKMs0hb76xKH7hUw
         iArYiH+CVoeUAmZthSWPhlWnJUbHrZchEbvc9FmGtPQPMGTgMKvqmGvnLVSLhShpBx
         cD08RgkjZqPlkfrUwHJ+XK5wBpnsqJnjS/97vyQQwn8z/ucBccm12lX2mOWcQRfBXu
         WpIB/tX9t5N9/KpVA3U8usMiE7H60bhctbfQ2tsHguU9frpYL8hZlu/P7jo0qnvOH/
         w0yqFmOfrREE0MYc95OfB4zZfV10TbZbgNcGKqIjAe9XMbgmcIj2dWNipIvi0tBMbP
         u51kmtmDq6UUg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-btrfs@vger.kernel.org
Subject: [PATCH 0/6] fsverity: support for non-4K pages
Date:   Fri, 28 Oct 2022 15:45:33 -0700
Message-Id: <20221028224539.171818-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[This patchset applies to v6.1-rc2 + my other patch
 https://lore.kernel.org/r/20221028175807.55495-1-ebiggers@kernel.org.
 You can get everything from tag "fsverity-non4k-v1" of
 https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git]

Currently, filesystems (ext4, f2fs, and btrfs) only support fsverity
when the Merkle tree block size, filesystem block size, and page size
are all the same.  In practice that means 4K, since increasing the page
size, e.g. to 16K, forces the Merkle tree block size and filesystem
block size to be increased accordingly.  That can be impractical; for
one, users want the same file signatures to work on all systems.

Therefore, this patchset reduces the coupling between these sizes.

First, patches 1-4 allow the Merkle tree block size to be less than the
page size or filesystem block size, provided that it's not larger than
either one.  This involves, among other things, changing the way that
fs/verity/verify.c tracks which hash blocks have been verified.

Second, patches 5-6 makes ext4 support fsverity when the filesystem
block size is less than the page size.  Note, f2fs doesn't need similar
changes because f2fs always assumes that the filesystem block size and
page size are the same anyway.  I haven't looked into btrfs yet.

I've tested this patchset with changes to the verity tests in xfstests.
I'll be sending out these xfstests changes separately.

Eric Biggers (6):
  fsverity: support verification with tree block size < PAGE_SIZE
  fsverity: support enabling with tree block size < PAGE_SIZE
  ext4: simplify ext4_readpage_limit()
  f2fs: simplify f2fs_readpage_limit()
  fs/buffer.c: support fsverity in block_read_full_folio()
  ext4: allow verity with fs block size < PAGE_SIZE

 Documentation/filesystems/fsverity.rst |  76 +++---
 fs/buffer.c                            |  66 ++++-
 fs/ext4/readpage.c                     |   3 +-
 fs/ext4/super.c                        |   5 -
 fs/f2fs/data.c                         |   3 +-
 fs/verity/enable.c                     | 268 ++++++++++----------
 fs/verity/fsverity_private.h           |  17 +-
 fs/verity/hash_algs.c                  |  48 ++--
 fs/verity/open.c                       | 101 ++++++--
 fs/verity/verify.c                     | 325 +++++++++++++++++--------
 include/linux/fsverity.h               |  14 +-
 11 files changed, 575 insertions(+), 351 deletions(-)

-- 
2.38.0

