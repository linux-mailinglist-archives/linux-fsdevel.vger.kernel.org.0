Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1A8761E1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 18:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjGYQMC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 12:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjGYQMB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:12:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE8410CC;
        Tue, 25 Jul 2023 09:12:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF569617D5;
        Tue, 25 Jul 2023 16:11:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F22BC433C7;
        Tue, 25 Jul 2023 16:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690301519;
        bh=6/SNhPKHabrmGeQMxzzLZYV2pEvSBrp2/eHwg/WAXHI=;
        h=Date:From:To:Cc:Subject:From;
        b=R4SQCYQKBl6u95L5DEP14RcRLvYUzgmzuP7pCNmY3HjtPfWCeadMqprX/Scf1CY7J
         jTCZIfqB2H2DsxFCXaEgrBwnQgXX2bOh3CRrgTvFhE80bOCU8dIB2r4kyFEdWevYAu
         qFoDKvHqb2tfbKXwDHA6yRZyQf+Ne/9Vfv+zIvFokC95RzuJ7OXzAzmw1dFw7Nsg6l
         rmoKBtQR41uVfx89MMeyYBL1QWZY+RVsnmtXGgeQhkc5oKYBHO5XG7t89q09Zs0j1K
         rr+hWF5xuJxbaQkrRPkAUVA3xgoKaGfHVhvEOIoziiefZtUW+qyfuWyLDkVC6IltkI
         KTHVcOf7wtWoA==
Date:   Tue, 25 Jul 2023 09:11:58 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Cc:     araherle@in.ibm.com, bfoster@redhat.com, djwong@kernel.org,
        hch@lst.de, kent.overstreet@linux.dev, ritesh.list@gmail.com,
        willy@infradead.org, Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfs-linux: iomap-for-next updated to a67371b7aee9
Message-ID: <20230725161158.GZ11352@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The iomap-for-next branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.  This push completes our ability to perform large
writes to large folios and have it not suck for writeback.

Next up is probably the switch to handling of directio completions in
the caller's task context instead of a workqueue, but I think this
should soak in for-next for a few days to see what the bots think. :P

The new head of the iomap-for-next branch is commit:

a67371b7aee9 Merge tag 'iomap-per-block-dirty-tracking' of https://github.com/riteshharjani/linux into iomap-6.6-merge

20 new commits:

Darrick J. Wong (2):
      [d42bd17c6a20] Merge tag 'large-folio-writes' of git://git.infradead.org/users/willy/pagecache into iomap-6.6-merge
      [a67371b7aee9] Merge tag 'iomap-per-block-dirty-tracking' of https://github.com/riteshharjani/linux into iomap-6.6-merge

Matthew Wilcox (Oracle) (10):
      [f7f9a0c8736d] iov_iter: Map the page later in copy_page_from_iter_atomic()
      [908a1ad89466] iov_iter: Handle compound highmem pages in copy_page_from_iter_atomic()
      [1b0306981e0f] iov_iter: Add copy_folio_from_iter_atomic()
      [a221ab717c43] iomap: Remove large folio handling in iomap_invalidate_folio()
      [32b29cc9db45] doc: Correct the description of ->release_folio
      [7a8eb01b078f] iomap: Remove unnecessary test from iomap_release_folio()
      [ffc143db63ee] filemap: Add fgf_t typedef
      [4f6617011910] filemap: Allow __filemap_get_folio to allocate large folios
      [d6bb59a9444d] iomap: Create large folios in the buffered write path
      [5d8edfb900d5] iomap: Copy larger chunks from userspace

Ritesh Harjani (IBM) (8):
      [04f52c4e6f80] iomap: Rename iomap_page to iomap_folio_state and others
      [3ea5c76cadee] iomap: Drop ifs argument from iomap_set_range_uptodate()
      [cc86181a3b76] iomap: Add some uptodate state handling helpers for ifs state bitmap
      [eee2d2e6ea55] iomap: Fix possible overflow condition in iomap_write_delalloc_scan
      [0af2b37d8e7a] iomap: Use iomap_punch_t typedef
      [7f79d85b525b] iomap: Refactor iomap_write_delalloc_punch() function out
      [a01b8f225248] iomap: Allocate ifs in ->write_begin() early
      [4ce02c679722] iomap: Add per-block dirty state tracking to improve performance

Code Diffstat:

 Documentation/filesystems/locking.rst |  15 +-
 fs/btrfs/file.c                       |   6 +-
 fs/f2fs/compress.c                    |   2 +-
 fs/f2fs/f2fs.h                        |   2 +-
 fs/gfs2/aops.c                        |   2 +-
 fs/gfs2/bmap.c                        |   2 +-
 fs/iomap/buffered-io.c                | 469 +++++++++++++++++++++++-----------
 fs/xfs/xfs_aops.c                     |   2 +-
 fs/zonefs/file.c                      |   2 +-
 include/linux/iomap.h                 |   3 +-
 include/linux/pagemap.h               |  82 +++++-
 include/linux/uio.h                   |   9 +-
 lib/iov_iter.c                        |  43 ++--
 mm/filemap.c                          |  65 ++---
 mm/folio-compat.c                     |   2 +-
 mm/readahead.c                        |  13 -
 16 files changed, 481 insertions(+), 238 deletions(-)
