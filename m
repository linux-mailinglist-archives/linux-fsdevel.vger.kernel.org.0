Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F911748864
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 17:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbjGEPvc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 11:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbjGEPv3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:51:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24D91998;
        Wed,  5 Jul 2023 08:51:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 479D4615DA;
        Wed,  5 Jul 2023 15:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DC4C433C7;
        Wed,  5 Jul 2023 15:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688572278;
        bh=/+gukm9092XPOmNSgfpDynEVvTB7M8InrJsJ9kK+m7E=;
        h=Date:From:To:Cc:Subject:From;
        b=RjtL9uVscWM0V5TNlClunYX+wSLPl+zZU+SDwGx/e1lj565rAPM0I5WoYMnD6Oa44
         VKndPZCAFDoLo+z3TcilhHCA7UK8r6aHkWZci6uo/gMKryVq/YgJzgIPbTd+TYQ7h3
         y6/GOA0B0LiZWa0HK+woXtDmGQi1f0ASNedOkXGceywOtHHjzqsI5bTvOW9yIZ7qlO
         +ve7gGPhFoCl5al0sE074UZQDTdyOvooq3VX2Bdh2Iw314aOAsRPnpabCwZ+naRJgL
         aYBv4UNJ1phQlBuKcUfhU9nMvk/NjahvH/9UCHeC+LmJGgHxBQw4EGMBvVk3zryoZa
         3/aaWjfcCEczg==
Date:   Wed, 5 Jul 2023 08:51:17 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org, torvalds@linux-foundation.org
Cc:     abaci@linux.alibaba.com, chandan.babu@oracle.com,
        chandanrlinux@gmail.com, colin.i.king@gmail.com,
        dchinner@redhat.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, ruansy.fnst@fujitsu.com,
        wen.gang.wang@oracle.com, yang.lee@linux.alibaba.com
Subject: [GIT PULL] xfs: more new code for 6.5
Message-ID: <168857207832.2801401.3108975452748877163.stg-ugh@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch with changes for xfs for 6.5-rc1.

As usual, I did a test-merge with the main upstream branch as of a few
minutes ago, and didn't see any conflicts.  Please let me know if you
encounter any problems.  We're well into the bugfixing weeds now...

--D

The following changes since commit c3b880acadc95d6e019eae5d669e072afda24f1b:

xfs: fix ag count overflow during growfs (2023-06-13 08:49:20 -0700)

are available in the Git repository at:

git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.5-merge-5

for you to fetch changes up to 34acceaa8818a0ff4943ec5f2f8831cfa9d3fe7e:

xfs: Remove unneeded semicolon (2023-07-03 09:48:18 -0700)

----------------------------------------------------------------
More new code for 6.5:

* Fix some ordering problems with log items during log recovery.
* Don't deadlock the system by trying to flush busy freed extents while
holding on to busy freed extents.
* Improve validation of log geometry parameters when reading the
primary superblock.
* Validate the length field in the AGF header.
* Fix recordset filtering bugs when re-calling GETFSMAP to return more
results when the resultset didn't previously fit in the caller's buffer.
* Fix integer overflows in GETFSMAP when working with rt volumes larger
than 2^32 fsblocks.
* Fix GETFSMAP reporting the undefined space beyond the last rtextent.
* Fix filtering bugs in GETFSMAP's log device backend if the log ever
becomes longer than 2^32 fsblocks.
* Improve validation of file offsets in the GETFSMAP range parameters.
* Fix an off by one bug in the pmem media failure notification
computation.
* Validate the length field in the AGI header too.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>

----------------------------------------------------------------
Colin Ian King (1):
xfs: remove redundant initializations of pointers drop_leaf and save_leaf

Darrick J. Wong (8):
xfs: fix interval filtering in multi-step fsmap queries
xfs: fix integer overflows in the fsmap rtbitmap and logdev backends
xfs: fix getfsmap reporting past the last rt extent
xfs: clean up the rtbitmap fsmap backend
xfs: fix logdev fsmap query result filtering
xfs: validate fsmap offsets specified in the query keys
xfs: fix xfs_btree_query_range callers to initialize btree rec fully
xfs: AGI length should be bounds checked

Dave Chinner (8):
xfs: don't reverse order of items in bulk AIL insertion
xfs: use deferred frees for btree block freeing
xfs: pass alloc flags through to xfs_extent_busy_flush()
xfs: allow extent free intents to be retried
xfs: don't block in busy flushing when freeing extents
xfs: journal geometry is not properly bounds checked
xfs: AGF length has never been bounds checked
xfs: fix bounds check in xfs_defer_agfl_block()

Shiyang Ruan (1):
xfs: fix the calculation for "end" and "length"

Yang Li (1):
xfs: Remove unneeded semicolon

fs/xfs/libxfs/xfs_ag.c             |   2 +-
fs/xfs/libxfs/xfs_alloc.c          | 291 ++++++++++++++++++++++++-------------
fs/xfs/libxfs/xfs_alloc.h          |  24 +--
fs/xfs/libxfs/xfs_attr_leaf.c      |   2 -
fs/xfs/libxfs/xfs_bmap.c           |   8 +-
fs/xfs/libxfs/xfs_bmap_btree.c     |   3 +-
fs/xfs/libxfs/xfs_ialloc.c         |  32 ++--
fs/xfs/libxfs/xfs_ialloc_btree.c   |   3 +-
fs/xfs/libxfs/xfs_refcount.c       |  22 +--
fs/xfs/libxfs/xfs_refcount_btree.c |   8 +-
fs/xfs/libxfs/xfs_rmap.c           |  10 +-
fs/xfs/libxfs/xfs_sb.c             |  56 ++++++-
fs/xfs/xfs_extent_busy.c           |  36 ++++-
fs/xfs/xfs_extent_busy.h           |   6 +-
fs/xfs/xfs_extfree_item.c          |  75 +++++++++-
fs/xfs/xfs_fsmap.c                 | 261 +++++++++++++++++----------------
fs/xfs/xfs_log.c                   |  47 ++----
fs/xfs/xfs_notify_failure.c        |   9 +-
fs/xfs/xfs_reflink.c               |   3 +-
fs/xfs/xfs_trace.h                 |  25 ++++
fs/xfs/xfs_trans_ail.c             |   2 +-
21 files changed, 590 insertions(+), 335 deletions(-)
