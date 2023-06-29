Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C0D742AC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 18:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjF2QpL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 12:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbjF2Qo7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:44:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0476230E4;
        Thu, 29 Jun 2023 09:44:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9490761500;
        Thu, 29 Jun 2023 16:44:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FC9C433C0;
        Thu, 29 Jun 2023 16:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688057092;
        bh=4xUZYknJhxrD+sW/JG0rkLJ62ce9R6eTrfLU0+NOLw4=;
        h=Date:From:To:Cc:Subject:From;
        b=HRqf93MkTwaoutsWpMoOl4gCwT+vnPQ8rVgJJhT7XaBXU4xF7XczodhADjdSeEstj
         OyiTqXfAFA8llCKJN3yu2iwZH/r1zow2TMe4gyFdzn3xFioG4iUTpnqYUf9hjc8jb9
         QpqODaBQa8/sszCg99U05aO8xmnFxjdWWmHTL8Gdmm5WPVc7AtFVxA1zMrb78aHFy4
         rgtmF1alML7oR+Y4jjvFf1AHte3rPE6NjdSG3+tClt4U8LBYXh8F6J3wHF0BSSPENy
         DtbvYMPezq3tuC3AYToJxCATVmr61JHHcZkmjg3oyqgtGXwUX08L2vbMwudzzJD7Lo
         4/n0p4dwbEMWA==
Date:   Thu, 29 Jun 2023 09:44:51 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     chandan.babu@oracle.com, chandanrlinux@gmail.com,
        colin.i.king@gmail.com, dchinner@redhat.com, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        wen.gang.wang@oracle.com
Subject: [ANNOUNCE] xfs-linux: for-next updated to 2bed0d82c2f7
Message-ID: <168805704657.2192805.4168814726942490159.stg-ugh@frogsfrogsfrogs>
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

Hi folks,

The for-next branch of the xfs-linux repository at:

git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.

The new head of the for-next branch is commit:

2bed0d82c2f7 xfs: fix bounds check in xfs_defer_agfl_block()

9 new commits:

Colin Ian King (1):
[347eb95b27eb] xfs: remove redundant initializations of pointers drop_leaf and save_leaf

Dave Chinner (8):
[939bd50dfbe7] xfs: don't reverse order of items in bulk AIL insertion
[b742d7b4f0e0] xfs: use deferred frees for btree block freeing
[6a2a9d776c4a] xfs: pass alloc flags through to xfs_extent_busy_flush()
[0853b5de42b4] xfs: allow extent free intents to be retried
[8ebbf262d468] xfs: don't block in busy flushing when freeing extents
[f1e1765aad7d] xfs: journal geometry is not properly bounds checked
[edd8276dd702] xfs: AGF length has never been bounds checked
[2bed0d82c2f7] xfs: fix bounds check in xfs_defer_agfl_block()

Code Diffstat:

fs/xfs/libxfs/xfs_ag.c             |   2 +-
fs/xfs/libxfs/xfs_alloc.c          | 261 +++++++++++++++++++++++--------------
fs/xfs/libxfs/xfs_alloc.h          |  21 +--
fs/xfs/libxfs/xfs_attr_leaf.c      |   2 -
fs/xfs/libxfs/xfs_bmap.c           |   8 +-
fs/xfs/libxfs/xfs_bmap_btree.c     |   3 +-
fs/xfs/libxfs/xfs_ialloc.c         |   8 +-
fs/xfs/libxfs/xfs_ialloc_btree.c   |   3 +-
fs/xfs/libxfs/xfs_refcount.c       |   9 +-
fs/xfs/libxfs/xfs_refcount_btree.c |   8 +-
fs/xfs/libxfs/xfs_sb.c             |  56 +++++++-
fs/xfs/xfs_extent_busy.c           |  36 ++++-
fs/xfs/xfs_extent_busy.h           |   6 +-
fs/xfs/xfs_extfree_item.c          |  75 ++++++++++-
fs/xfs/xfs_log.c                   |  47 +++----
fs/xfs/xfs_reflink.c               |   3 +-
fs/xfs/xfs_trans_ail.c             |   2 +-
17 files changed, 374 insertions(+), 176 deletions(-)
