Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D745B2493
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 19:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbiIHRZH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 13:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiIHRY6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:24:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A014EE0A;
        Thu,  8 Sep 2022 10:24:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35065B821DC;
        Thu,  8 Sep 2022 17:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AEBC433C1;
        Thu,  8 Sep 2022 17:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662657891;
        bh=jJcFm13hVF9RY9y/OKHnwztBV1qiy0LTPkPTC1q0taw=;
        h=From:To:Cc:Subject:Date:From;
        b=qSgcME4dLdsxXrisJmoKXG1TUhRdr502APJkM8P+y8mGawxcYHF4Vbsp6U+AbzBcN
         2buc6MAuMnTh+7N+Zpg6yFn/WaXGA6OZeTSMbmmloXPaBHpK3tX9gMenyJaauoirRT
         GglAlnFZPmkcgd4XpkjLJ+wEDCDT3b+RCMkjTC6iI5SQm3ebRnpc+L4rAQP5Iwbyeq
         T5LjD0nOG5UK51pJV09uUXidU/U9g4V4gSUW1DyZEK+fnTgpWjFTpH8OwmZeEuI6js
         Gp5bMJkFa9Th3p+zoQ/smtzzIKb6VlglHE1eqz3KAV3NAUc0wwO6okbNxPvMjZjyls
         D/lja4aKOv+0Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [PATCH v5 0/8] vfs/nfsd: clean up handling of the i_version counter
Date:   Thu,  8 Sep 2022 13:24:40 -0400
Message-Id: <20220908172448.208585-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

v5: don't try to expose i_version to userland (yet)
    use getattr to get i_version in nfsd
    take inode lock when getting i_version

This set is a bit different from the earlier ones. In particular, it
does not try to expose i_version to userland. STATX_INO_VERSION is added
as a kernel-only symbol (for now), and the infrastructure is changed
around to use it.

This allows us to fetch the i_version during the getattr operation, and
eliminate the fetch_iversion export operation. This is a much more
natual way to handle the i_version counter in nfsd and, as a bonus, this
should allow nfsd to use ceph's i_version counter too. Huzzah!

The first two patches fix up ext4's i_version handling and enable it
unconditionally. Those can go in independently of the rest, IMO. Ted, if
you're ok with those and want to pick them up then that would be great.

The rest of the patches clean up the i_version handling, but should not
change the userland API at all.  This should make it very simple to
expose i_version to userland in the future if we decide to do so. Maybe
we should take these in via the nfsd tree? I'm not sure here.

The last patch should be considered an RFC. I think that that approach
should prevent the potential race, without adding new work in the
write codepath.

Jeff Layton (8):
  iversion: clarify when the i_version counter must be updated
  ext4: fix i_version handling in ext4
  ext4: unconditionally enable the i_version counter
  vfs: plumb i_version handling into struct kstat
  nfs: report the inode version in getattr if requested
  ceph: report the inode version in getattr if requested
  nfsd: use the getattr operation to fetch i_version
  nfsd: take inode_lock when querying for NFSv4 GETATTR

 fs/ceph/inode.c          | 14 +++++++++-----
 fs/ext4/inode.c          | 15 +++++----------
 fs/ext4/ioctl.c          |  4 ++++
 fs/ext4/move_extent.c    |  6 ++++++
 fs/ext4/super.c          | 13 ++++---------
 fs/ext4/xattr.c          |  1 +
 fs/nfs/export.c          |  7 -------
 fs/nfs/inode.c           |  7 +++++--
 fs/nfsd/nfs4xdr.c        | 17 ++++++++++++++++-
 fs/nfsd/nfsfh.c          |  6 ++++++
 fs/nfsd/nfsfh.h          |  9 ++++-----
 fs/nfsd/vfs.h            |  7 ++++++-
 fs/stat.c                | 14 +++++++++++++-
 include/linux/exportfs.h |  1 -
 include/linux/iversion.h | 10 ++++++++--
 include/linux/stat.h     |  4 ++++
 16 files changed, 91 insertions(+), 44 deletions(-)

-- 
2.37.3

