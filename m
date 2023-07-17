Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4400A7568CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jul 2023 18:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjGQQOg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 12:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjGQQOP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:14:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6FA10E3;
        Mon, 17 Jul 2023 09:14:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C983661128;
        Mon, 17 Jul 2023 16:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32713C433C7;
        Mon, 17 Jul 2023 16:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689610452;
        bh=rLN1a6AgAx4gc3Ss335mxYugFtNLV4lT0gCdC3UBlpk=;
        h=Date:From:To:Cc:Subject:From;
        b=Jfvuzglc2RgHSEWuIpP7YrmPlvwMrHRhjUTLXV6QMdWaF4MUxfCdbiY1a08AKV+6R
         vg6aei3s2qZHy7bWVLBb7VVJyOfnpmVqlUCxM3fqlrzEBdJ5L0azpIO4jlGeeqi8H2
         Pk5a4EXc+lVNLBxL0tvQIk9q0z/UrF5Pmbo8jYjX6znLUmMDT1JzPDGinnt74cHtNO
         Dsvu5oTHQ0uR8jdUnqyS4yLP5IoqJ92k0Xe+r6katiMyo/CmcIhLGJvRaKmlH3ho6m
         eYaDx8d/SNpQ2vQLSh4pb8EYEklwm7WnPlQKRqKyxTEhffxLXd+qz+BAhgFzqK0z/M
         9w0Noepby/OZg==
Date:   Mon, 17 Jul 2023 09:14:11 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     dchinner@redhat.com, hch@infradead.org, hch@lst.de, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        mcgrof@kernel.org, ruansy.fnst@fujitsu.com
Subject: [ANNOUNCE] xfs-linux: vfs-for-next updated to 59ba4fdd2d1f
Message-ID: <168961008514.386829.4713520213666748279.stg-ugh@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The vfs-for-next branch of the xfs-linux repository at:

git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.

I decided to push this out as a work branch for wider testing in
for-next, though these patches may very well end up getting folded into
either (a) Luis Chamberlain's work to auto-freeze filesystems; (b) the
xfs tree for 6.6 if Shiyang Ruan's pmem failure notification work moves
ahead; or (c) the xfs tree if that part of online fsck gets merged for
6.6.  Either way, test early, test often.

The new head of the vfs-for-next branch is commit:

59ba4fdd2d1f fs: wait for partially frozen filesystems

2 new commits:

Darrick J. Wong (2):
[880b9577855e] fs: distinguish between user initiated freeze and kernel initiated freeze
[59ba4fdd2d1f] fs: wait for partially frozen filesystems

Code Diffstat:

Documentation/filesystems/vfs.rst |   6 +-
block/bdev.c                      |   8 +--
fs/f2fs/gc.c                      |   8 ++-
fs/gfs2/super.c                   |  12 ++--
fs/gfs2/sys.c                     |   4 +-
fs/ioctl.c                        |   8 +--
fs/super.c                        | 113 ++++++++++++++++++++++++++++++++++----
include/linux/fs.h                |  15 +++--
8 files changed, 138 insertions(+), 36 deletions(-)
