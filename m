Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875E4708018
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 13:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjERLrt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 07:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjERLrs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 07:47:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD5ABD;
        Thu, 18 May 2023 04:47:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F05764EC3;
        Thu, 18 May 2023 11:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0B5C433D2;
        Thu, 18 May 2023 11:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684410466;
        bh=UoOYGsMGyMMEKJ1qkzNYsll/wCyWl/nZo9olULeimuI=;
        h=From:To:Cc:Subject:Date:From;
        b=MgJKr48az7m1maC+5bU+MGI4uP+7mBT3hWl30A7YcL+cgivlPF30VKLMqw7WSucXZ
         Ox9YMRyo7ZdDxP0wMLf5ic9Dzysu1/jc1NSpvMypEt5ctlHRJv0rQo7srSyKqF/gS7
         SaGZkN5cJEev21H/T+NTGT9p7pZ3pT6aU3i8xlVw862fXe0G3SWCffI7T1I0/FddIn
         sdlL3ODMdHT5CY29cN6680mfspWWgnBAbIX/einbTQ6ldWOceymtiXAab0t9lVjCZM
         kJE4+R+7Xsu78Bg3MzPZG9hXx5zqPodwwI7h4m2fWSA4FBWsMxwj3GMWc45mudUi/c
         F1gHaCzCQQNrg==
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
        David Sterba <dsterba@suse.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: [PATCH v4 0/9] fs: implement multigrain timestamps
Date:   Thu, 18 May 2023 07:47:33 -0400
Message-Id: <20230518114742.128950-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.40.1
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

v4:
- add request_mask argument to generic_fillattr
- Drop current_ctime helper and just code functionality into current_time
- rework i_ctime accessor functions

A few weeks ago, during one of the discussions around i_version, Dave
Chinner wrote this:

"You've missed the part where I suggested lifting the "nfsd sampled
i_version" state into an inode state flag rather than hiding it in
the i_version field. At that point, we could optimise away the
secondary ctime updates just like you are proposing we do with the
i_version updates.  Further, we could also use that state it to
decide whether we need to use high resolution timestamps when
recording ctime updates - if the nfsd has not sampled the
ctime/i_version, we don't need high res timestamps to be recorded
for ctime...."

While I don't think we can practically optimize away ctime updates
like we do with i_version, I do like the idea of using this scheme to
indicate when we need to use a high-res timestamp.

The basic idea here is to use an unused bit in the timespec64.tv_nsec
field to act as a flag to indicate that the value was queried since
the last time we updated it. If that flag is set when we go to update
the timestamp, we'll clear it and grab a fine-grained ktime value for
the update.

The first couple of patches add the necessary infrastructure, and the
last several patches update various filesystems to use it. For now, I'm
focusing on widely-used, exportable filesystems, but this scheme is
probably suitable for most filesystems in the kernel.

Note that this does cause at least one test failure with LTP's statx06
test. I have submitted a patch to fix the issue (by changing how it
fetches the "after" timestamp in that test).

Jeff Layton (9):
  fs: pass the request_mask to generic_fillattr
  fs: add infrastructure for multigrain inode i_m/ctime
  overlayfs: allow it to handle multigrain timestamps
  nfsd: ensure we use ctime_peek to grab the inode->i_ctime
  ksmbd: use ctime_peek to grab the ctime out of the inode
  tmpfs: add support for multigrain timestamps
  xfs: switch to multigrain timestamps
  ext4: convert to multigrain timestamps
  btrfs: convert to multigrain timestamps

 fs/9p/vfs_inode.c             |  4 +--
 fs/9p/vfs_inode_dotl.c        |  4 +--
 fs/afs/inode.c                |  2 +-
 fs/btrfs/delayed-inode.c      |  2 +-
 fs/btrfs/inode.c              |  4 +--
 fs/btrfs/super.c              |  5 +--
 fs/btrfs/tree-log.c           |  2 +-
 fs/ceph/inode.c               |  2 +-
 fs/cifs/inode.c               |  2 +-
 fs/coda/inode.c               |  3 +-
 fs/ecryptfs/inode.c           |  5 +--
 fs/erofs/inode.c              |  2 +-
 fs/exfat/file.c               |  2 +-
 fs/ext2/inode.c               |  2 +-
 fs/ext4/inode.c               | 19 ++++++++--
 fs/ext4/super.c               |  2 +-
 fs/f2fs/file.c                |  2 +-
 fs/fat/file.c                 |  2 +-
 fs/fuse/dir.c                 |  2 +-
 fs/gfs2/inode.c               |  2 +-
 fs/hfsplus/inode.c            |  2 +-
 fs/inode.c                    | 48 +++++++++++++++++++++----
 fs/kernfs/inode.c             |  2 +-
 fs/ksmbd/smb2pdu.c            | 28 +++++++--------
 fs/ksmbd/vfs.c                |  3 +-
 fs/libfs.c                    |  4 +--
 fs/minix/inode.c              |  2 +-
 fs/nfs/inode.c                |  2 +-
 fs/nfs/namespace.c            |  3 +-
 fs/nfsd/nfsfh.c               | 11 ++++--
 fs/ntfs3/file.c               |  2 +-
 fs/ocfs2/file.c               |  2 +-
 fs/orangefs/inode.c           |  2 +-
 fs/overlayfs/file.c           |  7 ++--
 fs/overlayfs/util.c           |  2 +-
 fs/proc/base.c                |  4 +--
 fs/proc/fd.c                  |  2 +-
 fs/proc/generic.c             |  2 +-
 fs/proc/proc_net.c            |  2 +-
 fs/proc/proc_sysctl.c         |  2 +-
 fs/proc/root.c                |  3 +-
 fs/stat.c                     | 59 ++++++++++++++++++++++++------
 fs/sysv/itree.c               |  3 +-
 fs/ubifs/dir.c                |  2 +-
 fs/udf/symlink.c              |  2 +-
 fs/vboxsf/utils.c             |  2 +-
 fs/xfs/libxfs/xfs_inode_buf.c |  2 +-
 fs/xfs/xfs_inode_item.c       |  2 +-
 fs/xfs/xfs_iops.c             |  4 +--
 fs/xfs/xfs_super.c            |  2 +-
 include/linux/fs.h            | 68 +++++++++++++++++++++++++++++++++--
 mm/shmem.c                    |  4 +--
 52 files changed, 260 insertions(+), 95 deletions(-)

-- 
2.40.1

