Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6382157F362
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Jul 2022 07:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbiGXFlf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Jul 2022 01:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGXFld (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Jul 2022 01:41:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A96120AB;
        Sat, 23 Jul 2022 22:41:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C4D360EC9;
        Sun, 24 Jul 2022 05:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBAEC3411E;
        Sun, 24 Jul 2022 05:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658641291;
        bh=pAPOHOUDMQ5lnhszrvOY2QbuODW8sHjPCT6GDncBpQg=;
        h=Date:From:To:Subject:From;
        b=GTg25/DdH4Q1tWUXWM928KveOFU3gvPvSaOJxpEjEoHJKTVStyG0pB1bcAw9DvXbH
         lrXAXGI4kMRcY/aiaczm/SYY/bqV5zCYz9F1FvSJvAp0HrHtn8h/09qBk6y09OZeBf
         E0YYO+qVskFZ+dFDnqApMilXnby3LJj5q6FmGap/E7ftVmYk1MjSlq4YpemLfNIOHb
         NUCXlU0dcuUgC3woqxpjaPBqmoBKST0Jpd+qFolYNiIr6tNYTIqjdpN8RSi6i0ViBJ
         FUXYrkY5NtMwzwgAaMVzVmEqGlHIqGaM2+F/2FVpO5vlGeMkh3uGdVFwZ/zMwK0U4N
         Js4z+fHGOQXuw==
Date:   Sat, 23 Jul 2022 22:41:31 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [ANNOUNCE] xfs-linux: iomap-for-next updated to 478af190cb6c
Message-ID: <Ytzbi5fw1lc+s/fN@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
the next update.  It's been conclusively shown that the three
filesystems using iomap for the page cache never get ->writepage called,
so I decided it wasn't a big risk to remove all that dead code.

The new head of the iomap-for-next branch is commit:

478af190cb6c iomap: remove iomap_writepage

7 new commits:

Chris Mason (1):
      [d58562ca6c99] iomap: skip pages past eof in iomap_do_writepage()

Christoph Hellwig (4):
      [b2b0a5e97855] gfs2: stop using generic_writepages in gfs2_ail1_start_one
      [d3d71901b1ea] gfs2: remove ->writepage
      [7b86e8a5ba86] zonefs: remove ->writepage
      [478af190cb6c] iomap: remove iomap_writepage

Kaixu Xia (2):
      [98eb8d95025b] iomap: set did_zero to true when zeroing successfully
      [f8189d5d5fbf] dax: set did_zero to true when zeroing successfully

Code Diffstat:

 fs/dax.c               |  4 ++--
 fs/gfs2/aops.c         | 26 --------------------------
 fs/gfs2/log.c          |  5 ++---
 fs/iomap/buffered-io.c | 30 ++++++++----------------------
 fs/zonefs/super.c      |  8 --------
 include/linux/iomap.h  |  3 ---
 6 files changed, 12 insertions(+), 64 deletions(-)
