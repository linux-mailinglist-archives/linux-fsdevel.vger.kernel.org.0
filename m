Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E094F3FEEFF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 15:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239869AbhIBNxB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 09:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbhIBNw5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 09:52:57 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1B6C061760
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Sep 2021 06:51:58 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id q17so3030116edv.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Sep 2021 06:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=sV4cn+GEhcdtXg9aDRpPOIs8C7SJiwcSKge0piQkjHM=;
        b=EfagH3rYTV78jcOA+jKJRrfxGtJfTrD4gRkYsK39UuD/CK2U1q4NzepLyjJqvWVgzc
         7uUGypz51kA5RvlsQK56veBhTSCTJnlntAV/znbUk8vQJTb+oBWLzEBHDLW7z7ugh0jN
         P/YQBqGqfgsYbhuCwHEhVWhtncUZPZ+rEdzRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=sV4cn+GEhcdtXg9aDRpPOIs8C7SJiwcSKge0piQkjHM=;
        b=Hxc+IPJCmBg4Lot8GQXbzTqc4nsBILsb3iyJpy21roR8IuVmgjARlNx+1nomSshnK2
         ppp1CSvUlT286O8FXRRAekAEEGy1U9FDaIUk7QpnoiAhnoob3A9D/ImnAJDdXzoi73wX
         +1EAk8Uxppb9uaUs+42ByvXKXpJiBTGiLJkM+TVXUHBQar8SLZhDK+00OZENzI+q/KpM
         AN8uIQ053oLl3qeEOfFSk56gSCoHeBcSyS78PciQEfW0lTexuAxCvDB+9gk4xRo5+CSu
         8/7AXS7kcRVPWIWb+KB6xiWJJ5oAJLJoiptV0908Kdf0sxd2hTP8PhgIeXQuGbGRqXbX
         5eog==
X-Gm-Message-State: AOAM533jVdEK2/I6IHD/aUMf/J7JrZZENue9WEW4QvGJKpW0BT5ROXFY
        /k+NQmVgjyb8R7xcQadrptOJzA==
X-Google-Smtp-Source: ABdhPJxRZEJvrX7u1muEOVAnKrmtJF6P0eWg8Xv+oR/FRc2y4+mj4YRRWZW0OCrHeE6T170yTIVubg==
X-Received: by 2002:aa7:dace:: with SMTP id x14mr3627185eds.169.1630590716605;
        Thu, 02 Sep 2021 06:51:56 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-16.catv.broadband.hu. [86.101.169.16])
        by smtp.gmail.com with ESMTPSA id d22sm1202634ejj.47.2021.09.02.06.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:51:56 -0700 (PDT)
Date:   Thu, 2 Sep 2021 15:51:53 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs update for 5.15
Message-ID: <YTDW+b3x+5yMYVK0@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-5.15

- Copy up immutable/append/sync/noatime attributes (Amir Goldstein)

- Improve performance by enabling RCU lookup.

- Misc fixes and improvements

The reason this touches so many files is that the ->get_acl() method now
gets a "bool rcu" argument.  The ->get_acl() API was updated based on
comments from Al and Linus:

  https://lore.kernel.org/linux-fsdevel/CAJfpeguQxpd6Wgc0Jd3ks77zcsAv_bn0q17L3VNnnmPKu11t8A@mail.gmail.com/

Thanks,
Miklos

---
Amir Goldstein (5):
      fs: add generic helper for filling statx attribute flags
      ovl: pass ovl_fs to ovl_check_setxattr()
      ovl: copy up sync/noatime fileattr flags
      ovl: consistent behavior for immutable/append-only inodes
      ovl: relax lookup error on mismatch origin ftype

Chengguang Xu (2):
      ovl: skip checking lower file's i_writecount on truncate
      ovl: update ctime when changing fileattr

Miklos Szeredi (3):
      ovl: use kvalloc in xattr copy-up
      vfs: add rcu argument to ->get_acl() callback
      ovl: enable RCU'd ->get_acl()

Vyacheslav Yurkov (3):
      ovl: disable decoding null uuid with redirect_dir
      ovl: add ovl_allow_offline_changes() helper
      ovl: do not set overlay.opaque for new directories

chenying (1):
      ovl: fix BUG_ON() in may_delete() when called from ovl_cleanup()

---
 Documentation/filesystems/locking.rst   |   2 +-
 Documentation/filesystems/overlayfs.rst |   3 +
 Documentation/filesystems/vfs.rst       |   2 +-
 fs/9p/acl.c                             |   5 +-
 fs/9p/acl.h                             |   2 +-
 fs/bad_inode.c                          |   2 +-
 fs/btrfs/acl.c                          |   5 +-
 fs/btrfs/ctree.h                        |   2 +-
 fs/ceph/acl.c                           |   5 +-
 fs/ceph/super.h                         |   2 +-
 fs/erofs/xattr.c                        |   5 +-
 fs/erofs/xattr.h                        |   2 +-
 fs/ext2/acl.c                           |   5 +-
 fs/ext2/acl.h                           |   2 +-
 fs/ext4/acl.c                           |   5 +-
 fs/ext4/acl.h                           |   2 +-
 fs/f2fs/acl.c                           |   5 +-
 fs/f2fs/acl.h                           |   2 +-
 fs/fuse/acl.c                           |   5 +-
 fs/fuse/fuse_i.h                        |   2 +-
 fs/gfs2/acl.c                           |   5 +-
 fs/gfs2/acl.h                           |   2 +-
 fs/jffs2/acl.c                          |   5 +-
 fs/jffs2/acl.h                          |   2 +-
 fs/jfs/acl.c                            |   5 +-
 fs/jfs/jfs_acl.h                        |   2 +-
 fs/nfs/nfs3_fs.h                        |   2 +-
 fs/nfs/nfs3acl.c                        |   5 +-
 fs/ocfs2/acl.c                          |   5 +-
 fs/ocfs2/acl.h                          |   2 +-
 fs/orangefs/acl.c                       |   5 +-
 fs/orangefs/inode.c                     |   7 +--
 fs/orangefs/orangefs-kernel.h           |   2 +-
 fs/overlayfs/copy_up.c                  |  83 ++++++++++++++++++++-----
 fs/overlayfs/dir.c                      |  16 +++--
 fs/overlayfs/inode.c                    | 105 +++++++++++++++++++++++++-------
 fs/overlayfs/namei.c                    |   4 +-
 fs/overlayfs/overlayfs.h                |  44 +++++++++++--
 fs/overlayfs/super.c                    |   4 +-
 fs/overlayfs/util.c                     |  92 ++++++++++++++++++++++++++--
 fs/posix_acl.c                          |  15 ++++-
 fs/reiserfs/acl.h                       |   2 +-
 fs/reiserfs/xattr_acl.c                 |   5 +-
 fs/stat.c                               |  18 ++++++
 fs/xfs/xfs_acl.c                        |   5 +-
 fs/xfs/xfs_acl.h                        |   4 +-
 include/linux/fs.h                      |   8 ++-
 include/linux/posix_acl.h               |   3 +-
 include/linux/stat.h                    |   4 ++
 49 files changed, 424 insertions(+), 102 deletions(-)
