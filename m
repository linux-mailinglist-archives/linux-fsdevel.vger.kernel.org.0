Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8926F59AE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 16:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjECOUn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 10:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjECOUm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 10:20:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A0D59F7;
        Wed,  3 May 2023 07:20:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B4FA62DDC;
        Wed,  3 May 2023 14:20:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D86C433D2;
        Wed,  3 May 2023 14:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683123640;
        bh=B/byiGRb2kElHzhLs8i3vMpx6Eq2eV1GQaupQ5p6W14=;
        h=From:To:Cc:Subject:Date:From;
        b=Hf1xqOynP8r+xdYeg5iDsOp1QXAPWNX+EeWOtmAT0vfdre7GtfqfDnvWfMT4VbgTi
         W4k2ThDGKEe03SK+/E281k29evFeM8QWXvxynMvFg4W/6FHrB2qh8/yTd3cu6w9cZ5
         iodu4EhjBC75RZXcxSk1a5179MjmEzeJHrMcII/Hk16buPuReZjkQ1sQRwGTD5oX1P
         mOawJte++byKiiGdeBj3mChUv555myDwv6MXgoatDm5O/zabgVu2jTJvDrijdS4VBB
         ofZX6rr7heInptz16aMXa0ad2VkgaW4h6f5kkV70L1QPjCPmuGDju5mFCp2uaq99Uq
         9hwrCzOKpwCzw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Neil Brown <neilb@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Theodore T'so <tytso@mit.edu>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org
Subject: [PATCH v3 0/6] fs: implement multigrain timestamps
Date:   Wed,  3 May 2023 10:20:31 -0400
Message-Id: <20230503142037.153531-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Major changes in v3:
- move flag to use bit 31 instead of 0 since the upper bits in the
  tv_nsec field aren't used for timestamps. This means we don't need to
  set s_time_gran to a value higher than 1.

- use an fstype flag instead of a superblock flag

...plus a lot of smaller cleanups and documentation.

The basic idea with multigrain timestamps is to keep track of when an
inode's mtime or ctime has been queried and to force a fine-grained
timestamp the next time the mtime or ctime is updated.

This is a follow-up of the patches I posted last week [1]. The main
change in this set is that it no longer uses the lowest-order bit in the
tv_nsec field, and instead uses one of the higher-order bits (#31,
specifically) since they are otherwise unused. This change makes things
much simpler, and we no longer need to twiddle s_time_gran for it.

Note that with these changes, the statx06 LTP test will intermittently
fail on most filesystems, usually with errors like this:

    statx06.c:138: TFAIL: Birth time > after_time
    statx06.c:138: TFAIL: Modified time > after_time

The test does this:

        SAFE_CLOCK_GETTIME(CLOCK_REALTIME_COARSE, &before_time);
        clock_wait_tick();
        tc->operation();
        clock_wait_tick();
        SAFE_CLOCK_GETTIME(CLOCK_REALTIME_COARSE, &after_time);

Converting the second SAFE_CLOCK_GETTIME to use CLOCK_REALTIME instead
gets things working again.

For now, I've only converted/tested a few filesystems, focusing on the
most popular ones exported via NFS.  If this approach looks acceptable
though, I'll plan to convert more filesystems to it.

Another thing we could consider is enabling this unilaterally
kernel-wide. I decided not to do that for now, but it's something we
could consider for lately.

[1]: https://lore.kernel.org/linux-fsdevel/20230424151104.175456-1-jlayton@kernel.org/

Jeff Layton (6):
  fs: add infrastructure for multigrain inode i_m/ctime
  overlayfs: allow it handle multigrain timestamps
  shmem: convert to multigrain timestamps
  xfs: convert to multigrain timestamps
  ext4: convert to multigrain timestamps
  btrfs: convert to multigrain timestamps

 fs/btrfs/delayed-inode.c        |  2 +-
 fs/btrfs/file.c                 | 10 +++---
 fs/btrfs/inode.c                | 25 +++++++-------
 fs/btrfs/ioctl.c                |  6 ++--
 fs/btrfs/reflink.c              |  2 +-
 fs/btrfs/super.c                |  5 +--
 fs/btrfs/transaction.c          |  2 +-
 fs/btrfs/tree-log.c             |  2 +-
 fs/btrfs/volumes.c              |  2 +-
 fs/btrfs/xattr.c                |  4 +--
 fs/ext4/acl.c                   |  2 +-
 fs/ext4/extents.c               | 10 +++---
 fs/ext4/ialloc.c                |  2 +-
 fs/ext4/inline.c                |  4 +--
 fs/ext4/inode.c                 | 24 ++++++++++---
 fs/ext4/ioctl.c                 |  8 ++---
 fs/ext4/namei.c                 | 20 +++++------
 fs/ext4/super.c                 |  4 +--
 fs/ext4/xattr.c                 |  2 +-
 fs/inode.c                      | 52 ++++++++++++++++++++++++++--
 fs/overlayfs/file.c             |  7 ++--
 fs/overlayfs/util.c             |  2 +-
 fs/stat.c                       | 32 +++++++++++++++++
 fs/xfs/libxfs/xfs_inode_buf.c   |  2 +-
 fs/xfs/libxfs/xfs_trans_inode.c |  2 +-
 fs/xfs/xfs_acl.c                |  2 +-
 fs/xfs/xfs_bmap_util.c          |  2 +-
 fs/xfs/xfs_inode.c              |  2 +-
 fs/xfs/xfs_inode_item.c         |  2 +-
 fs/xfs/xfs_iops.c               | 15 ++++++--
 fs/xfs/xfs_super.c              |  2 +-
 include/linux/fs.h              | 61 ++++++++++++++++++++++++++++++++-
 mm/shmem.c                      | 25 +++++++-------
 33 files changed, 255 insertions(+), 89 deletions(-)

-- 
2.40.1

