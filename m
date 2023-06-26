Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E385773D5A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 03:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjFZByT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Jun 2023 21:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFZByS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Jun 2023 21:54:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4ED5196;
        Sun, 25 Jun 2023 18:54:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71D1A60C28;
        Mon, 26 Jun 2023 01:54:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93038C433C0;
        Mon, 26 Jun 2023 01:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687744456;
        bh=5oeqP+MWXjh5TRebKQMUswKua+sGjBsaB33i76j0bxo=;
        h=Date:From:To:Cc:Subject:From;
        b=f6LGIex6z5K0RASvaouow8y8XMHsFXoUr7TZ2cVN0jTQhZ5CbZsJSJjkPCK82EaXb
         WHfnKAp5TSnsepIqO1p3s1SAmJiku6aewaNrrd87VPbThmmT/S4Ga01IoS9OjHJE20
         B09EP3Cz4HjqEmXElkhJYpdF4Jqe8u7PXQ1pMvxTa/05AdzLs4jvhT8Rb1yFzGsq2U
         7mBc9xEZTHIDlv+nXA0qT+x/WEWAnFQiD+5AzmtJ9OX4B/+/eox2gxUj/O0jY3Ga6u
         9g7sm5ShVE5ovqJDmng6IGODDnQIWY567sJ5ydCm5DMuhMP0bA131SUwh4MGJNFNTU
         FuhaSQE4Vft2Q==
Date:   Sun, 25 Jun 2023 18:54:15 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Larsson <alexl@redhat.com>
Subject: [GIT PULL] fsverity updates for 6.5
Message-ID: <20230626015415.GB1024@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus

for you to fetch changes up to 672d6ef4c775cfcd2e00172e23df34e77e495e85:

  fsverity: improve documentation for builtin signature support (2023-06-20 22:47:55 -0700)

----------------------------------------------------------------

Several updates for fs/verity/:

- Do all hashing with the shash API instead of with the ahash API.  This
  simplifies the code and reduces API overhead.  It should also make
  things slightly easier for XFS's upcoming support for fsverity.  It
  does drop fsverity's support for off-CPU hash accelerators, but that
  support was incomplete and not known to be used.

- Update and export fsverity_get_digest() so that it's ready for
  overlayfs's upcoming support for fsverity checking of lowerdata.

- Improve the documentation for builtin signature support.

- Fix a bug in the large folio support.

----------------------------------------------------------------
Eric Biggers (6):
      fsverity: use shash API instead of ahash API
      fsverity: constify fsverity_hash_alg
      fsverity: don't use bio_first_page_all() in fsverity_verify_bio()
      fsverity: simplify error handling in verify_data_block()
      fsverity: rework fsverity_get_digest() again
      fsverity: improve documentation for builtin signature support

 Documentation/filesystems/fsverity.rst | 192 +++++++++++++++++++++------------
 fs/verity/Kconfig                      |  16 +--
 fs/verity/enable.c                     |  21 ++--
 fs/verity/fsverity_private.h           |  23 ++--
 fs/verity/hash_algs.c                  | 139 +++++-------------------
 fs/verity/measure.c                    |  37 +++++--
 fs/verity/open.c                       |  12 +--
 fs/verity/read_metadata.c              |   4 +-
 fs/verity/signature.c                  |   8 ++
 fs/verity/verify.c                     | 164 +++++++++++-----------------
 include/linux/fsverity.h               |  14 ++-
 security/integrity/ima/ima_api.c       |  31 +++---
 12 files changed, 299 insertions(+), 362 deletions(-)
