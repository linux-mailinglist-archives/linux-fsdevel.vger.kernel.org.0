Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A137E76043E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 02:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjGYApc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 20:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjGYApb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 20:45:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82A410F9;
        Mon, 24 Jul 2023 17:45:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7099861486;
        Tue, 25 Jul 2023 00:45:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953B7C433C7;
        Tue, 25 Jul 2023 00:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690245928;
        bh=hBv3qa2DL7bn7fw8RIoZNx51Zbvz7PAHljshT2Ia2qI=;
        h=Date:From:To:Cc:Subject:From;
        b=ViSZd/cg0zEDO5+Sjl/rAVAYl4SwV9Gb87ELJLZnjLD0ZnIly8Am8lgUvuDuWdv6H
         BKK4TeZIQjHniiGJFSg8N5/0b2zvWSUSqzJfpThkqXWG0KdhvJPpRsd/7nL6a85R5s
         Yavi1jv2M922rvAlwQvi8y2IrMYstu2g5P7UgOAqrZygXCu75aTuQSQxp4JDx/KCNe
         +rk4TDlPvQn7O0VYNRi1eEx33zwer2/YC34qko8TN/VJA67qnZL2G/GYXJorZ7m6eO
         UOqeZ/MeV7yxum2iGd8UENjEE+D5zuxL4roh7D6EUAfQZ8lJto4lc6bvSUFHSX5YdE
         ggkZfCl699k6g==
Date:   Mon, 24 Jul 2023 17:45:28 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Cc:     djwong@kernel.org, hch@lst.de, kent.overstreet@linux.dev,
        willy@infradead.org,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfs-linux: iomap-for-next updated to d42bd17c6a20
Message-ID: <20230725004528.GB11336@frogsfrogsfrogs>
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
the next update.

So.  I've merged willy's large folio writes series into the branch, and
next I'd like to merge Ritesh's dirty block tracking changes.  Ritesh,
could you rebase your changes against this branch and send me a pull
request?

(Next in line could be the dio completions thing that Jens is working
on, though iirc Dave still had some questions about that...)

The new head of the iomap-for-next branch is commit:

d42bd17c6a20 Merge tag 'large-folio-writes' of git://git.infradead.org/users/willy/pagecache into iomap-6.6-merge

11 new commits:

Darrick J. Wong (1):
      [d42bd17c6a20] Merge tag 'large-folio-writes' of git://git.infradead.org/users/willy/pagecache into iomap-6.6-merge

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

Code Diffstat:

 Documentation/filesystems/locking.rst | 15 +++++--
 fs/btrfs/file.c                       |  6 +--
 fs/f2fs/compress.c                    |  2 +-
 fs/f2fs/f2fs.h                        |  2 +-
 fs/gfs2/bmap.c                        |  2 +-
 fs/iomap/buffered-io.c                | 54 +++++++++++------------
 include/linux/iomap.h                 |  2 +-
 include/linux/pagemap.h               | 82 ++++++++++++++++++++++++++++++-----
 include/linux/uio.h                   |  9 +++-
 lib/iov_iter.c                        | 43 +++++++++++-------
 mm/filemap.c                          | 65 ++++++++++++++-------------
 mm/folio-compat.c                     |  2 +-
 mm/readahead.c                        | 13 ------
 13 files changed, 187 insertions(+), 110 deletions(-)
