Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEF83CC9E1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jul 2021 18:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhGRQfd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Jul 2021 12:35:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229462AbhGRQfc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Jul 2021 12:35:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21174611AC;
        Sun, 18 Jul 2021 16:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626625954;
        bh=KteUkFc6Ts0P9sNfnFkgGFiQ+Apd+SmR1vU6xCb9vbY=;
        h=Date:From:To:Cc:Subject:From;
        b=FKNmS1gASBscktUlWw3KTBIwM7d4DCjtYpSeEr7tfZV2fYWNKfmVk9okcwstFsg7w
         CHDf6/ysD7Ao06NDsdvQRTPtQIK53Llg9TkbTSOsUbuVsqahYlcalk8ZJRubtiJlbA
         B1R6yeoKxzXd9fA+eI29ev3yxSHxm6fxEoj89QOLCggstcKzvxvWljcsxyvKdb+50Z
         K8zBpTaAdAEvFkLpweZ7bQf7SOPi6yqQrPnSDblixD2OxdZpCsAYucRrScADmaq3Sy
         yoduXesRWFKZxsaQgF5DqtUPkzZXR1E8VaXt5Kq31afxr0wQxV3/9ffBoTTYCZJkhh
         xgsfawOXfKxFg==
Date:   Sun, 18 Jul 2021 09:32:32 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de
Subject: [GIT PULL] iomap: fixes for 5.14-rc2
Message-ID: <20210718163232.GA22402@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch containing a handful of bugfixes for the iomap
code.  There's nothing especially exciting here, just fixes for UBSAN
(not KASAN as I erroneously wrote in the tag message) warnings about
undefined behavior in the SEEK_DATA/SEEK_HOLE code, and some reshuffling
of per-page block state info to fix some problems with gfs2.

The branch merges cleanly against upstream as of a few minutes ago.
Please let me know if anything else strange happens during the merge
process.

--D

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.14-fixes-1

for you to fetch changes up to 229adf3c64dbeae4e2f45fb561907ada9fcc0d0c:

  iomap: Don't create iomap_page objects in iomap_page_mkwrite_actor (2021-07-15 09:58:06 -0700)

----------------------------------------------------------------
Fixes for 5.14-rc:
 * Fix KASAN warnings due to integer overflow in SEEK_DATA/SEEK_HOLE.
 * Fix assertion errors when using inlinedata files on gfs2.

----------------------------------------------------------------
Andreas Gruenbacher (3):
      iomap: Permit pages without an iop to enter writeback
      iomap: Don't create iomap_page objects for inline files
      iomap: Don't create iomap_page objects in iomap_page_mkwrite_actor

Christoph Hellwig (2):
      iomap: remove the length variable in iomap_seek_data
      iomap: remove the length variable in iomap_seek_hole

 fs/iomap/buffered-io.c |  8 ++++----
 fs/iomap/seek.c        | 25 +++++++++----------------
 2 files changed, 13 insertions(+), 20 deletions(-)
