Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9DA348F4B4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jan 2022 05:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbiAOETG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jan 2022 23:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiAOETF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jan 2022 23:19:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EA9C061574;
        Fri, 14 Jan 2022 20:19:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6AA1B82A41;
        Sat, 15 Jan 2022 04:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDF9C36AE7;
        Sat, 15 Jan 2022 04:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642220342;
        bh=L9jZwPl+ulM1n91M5X+pPqPaIs8EmocblrHHoBwI/NU=;
        h=Date:From:To:Cc:Subject:From;
        b=mC7KUJ0WI0h1o6Nvx2jO2cpeYvQp9kXPiY2nfdkJYyUvJIrn9R7dqkllqC5Cw4PAJ
         0eqkcl5xvR1KKYI+gfO5wUXczedEm1nz7e+7Gud1N+kK95evtZVPqU2X5Ymj+SYNsk
         xgsbhY2v4IU/5X2ZRHj7HDxb3q8SiS/5XKqDKxrFvap8zIRUKez36i+JKZnjxzHTwM
         mqxpI+1I/B6G4JtZ2YBwc3PYR4Wy87jchgGA2Z/wiIsACzU+8K8rDPJxAFRmC+y2pT
         zQB1Rr0pZxcfE0blfDD71Jv8wgoc8kCoh1yWRoslt/6hjRG6CI3lOfWtXUNfcZ/7Uj
         YVse1suXj1zgg==
Date:   Fri, 14 Jan 2022 20:19:02 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: new bug fixes for 5.17
Message-ID: <20220115041902.GF90423@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull these bug fixes for Linux 5.17.  These are the last few
obvious fixes that I found while stress testing online fsck for XFS
prior to initiating a design review of the whole giant machinery.

The branch merges cleanly against upstream as of a few minutes ago.
Please let me know if anything else strange happens during the merge
process.  There will definitely be a third pull request coming with a
removal of the recently troublesome ALLOCSP/FREESP ioctl family and the
long dead SGI XFS HSM ioctls.

--D

The following changes since commit 7e937bb3cbe1f6b9840a43f879aa6e3f1a5e6537:

  xfs: warn about inodes with project id of -1 (2022-01-06 10:43:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.17-merge-3

for you to fetch changes up to 4a9bca86806fa6fc4fbccf050c1bd36a4778948a:

  xfs: fix online fsck handling of v5 feature bits on secondary supers (2022-01-12 09:45:21 -0800)

----------------------------------------------------------------
New code for 5.17:

 - Fix a minor locking inconsistency in readdir
 - Fix incorrect fs feature bit validation for secondary superblocks

----------------------------------------------------------------
Darrick J. Wong (2):
      xfs: take the ILOCK when readdir inspects directory mapping data
      xfs: fix online fsck handling of v5 feature bits on secondary supers

 fs/xfs/scrub/agheader.c        | 53 ++++++++++++++++++++--------------------
 fs/xfs/scrub/agheader_repair.c | 12 +++++++++
 fs/xfs/xfs_dir2_readdir.c      | 55 +++++++++++++++++++++++++++---------------
 3 files changed, 73 insertions(+), 47 deletions(-)
