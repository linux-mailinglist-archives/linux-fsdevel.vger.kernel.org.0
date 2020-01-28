Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D12E14C37A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 00:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgA1XTP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 18:19:15 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40857 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgA1XTO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 18:19:14 -0500
Received: by mail-pg1-f195.google.com with SMTP id k25so7821270pgt.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2020 15:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I2nRYBuJd5X0Wj9vaCm9Jl5NSf3Vb/go1Vc/PX3Gwso=;
        b=QgImJeoAe0THCnIltSZmTcCtWqcgxk0GsNj2UIuM0Z8WkoR4ABSFhpXIlkQv55UdIu
         GncAwfvLINAfw0R2Rdor/UtRB4eIxYn32ZoLt0/NM75T75iPjx/9BMMAOw3Uu9IYMP4T
         gwFXtQes4uJ+ZGclAU9ILaWxzLyabiuV6pndhJSB7QEK1Z7GXAYRkhAprUMLuKF4YLWF
         Fy+vtD2Q49LL0jDVEZQDr14RJEpGZEhVzcXr/Zmj/6pts3P539FQCHPFF1AM8yTMxeL7
         vS/epB8yoWWh1md++lrWBk6uC1qXzeeHIDo++GBpiABk67DeAjWkkxa7CfuLZs7S+xRI
         lKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I2nRYBuJd5X0Wj9vaCm9Jl5NSf3Vb/go1Vc/PX3Gwso=;
        b=leAwIlJk5pnf84t/5fBC8h6Cw7qyVBg8Xj5ZIlVFTaONmc86qm3cAhN/20OinG+Br5
         gk7XQofPPBbLBdn+lm4pYSeLO90RrP9DcnHNrdmyXw5Ofp0YRT82J2/V5y6GVb7SAkFy
         rItROu6nngdcPrYTufbKVmBx4xEACN8MSYq5nlcHUbBV5fdk65yY8uC2mVDbBhdw+eRb
         DrqE7DaxqU5UKf0J0WSg+0dcYU9HDAf4/xdA7iz2do2/V5P2KOkhEPfBXRCDRBOFXfdl
         hvMNuT+a+e9hofp2ykbGq7W5/50x1ZI7KEQkPR/Zaq07DtEfyW8r5BxsCynUY5UdK9fE
         7tIw==
X-Gm-Message-State: APjAAAWWZ9zFO8+HOS8oknFXgQvsVYvAPO+CwIyyjyJ+G8gCL4nbs/IX
        2+kd6UaK3twSDPYqhCETkDQmYHu6OxE=
X-Google-Smtp-Source: APXvYqymTw6OzjmEJB7fY2HzGkfsRT+B9zrTls7MWhShARoHkhjsMU/Pa9ALE71WuWnnVZn3nmYlRg==
X-Received: by 2002:a63:dc0d:: with SMTP id s13mr26354909pgg.129.1580253553270;
        Tue, 28 Jan 2020 15:19:13 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:200::43a7])
        by smtp.gmail.com with ESMTPSA id p24sm156353pgk.19.2020.01.28.15.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 15:19:12 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Cc:     kernel-team@fb.com, David Howells <dhowells@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Xi Wang <xi@cs.washington.edu>
Subject: [RFC PATCH v4 0/4] fs: add flag to linkat() for replacing destination
Date:   Tue, 28 Jan 2020 15:18:59 -0800
Message-Id: <cover.1580251857.git.osandov@fb.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580251857.git.osandov@fb.com>
References: <cover.1580251857.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Hello,

This series adds an AT_LINK_REPLACE flag to linkat() which allows
atomically replacing the destination if it exists. This is a respin of
an old series [1] that I was convinced to resend due to some recent
interest [2][3].

Patch 1 adds a flags argument to i_ops->link() in preparation. Patch 2
adds the VFS support. Patch 3 fixes an inode leak in btrfs_link(),
included in this series because it conflicts with patch 4. Patch 4 adds
support for AT_LINK_REPLACE to Btrfs.

I've also included a man-page patch (with an example program), an xfs_io
patch, and an fstest.

Some outstanding issues:

- The Btrfs implementation does a d_drop() on the replaced dentry. We
  probably want a d_replace() helper for filesystems to use.
- Should AT_LINK_REPLACE be limited to O_TMPFILE? In my opinion, the
  answer is no. After all, `ln -f` is not that exotic.
- Should AT_LINK_REPLACE guarantee data integrity? Again, I think the
  answer is no. That's more suited to something like Amir's AT_ATOMIC
  proposal [4].

Changes since v3:

- Rebased on v5.5.
- Added patches 1 and 3.
- Incorporated Al's feedback on various error cases in patch 2.
- Renamed the flag to AT_LINK_REPLACE.

Thanks!

1: https://lore.kernel.org/linux-fsdevel/cover.1524549513.git.osandov@fb.com/
2: https://lore.kernel.org/linux-fsdevel/3326.1579019665@warthog.procyon.org.uk/
3: https://lore.kernel.org/linux-fsdevel/364531.1579265357@warthog.procyon.org.uk/
4: https://lore.kernel.org/linux-fsdevel/20190527172655.9287-1-amir73il@gmail.com/

Cc: David Howells <dhowells@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Xi Wang <xi@cs.washington.edu>

Omar Sandoval (4):
  fs: add flags argument to i_op->link()
  fs: add AT_LINK_REPLACE flag for linkat() which replaces the target
  Btrfs: fix inode reference count leak in btrfs_link() error path
  Btrfs: add support for linkat() AT_REPLACE

 fs/9p/vfs_inode.c          |   5 +-
 fs/9p/vfs_inode_dotl.c     |   5 +-
 fs/affs/affs.h             |   2 +-
 fs/affs/namei.c            |   6 +-
 fs/afs/dir.c               |   7 +-
 fs/bad_inode.c             |   2 +-
 fs/bfs/dir.c               |   7 +-
 fs/btrfs/inode.c           |  70 ++++++++++++++--
 fs/ceph/dir.c              |   5 +-
 fs/cifs/cifsfs.h           |   2 +-
 fs/cifs/link.c             |   5 +-
 fs/coda/dir.c              |   5 +-
 fs/ecryptfs/inode.c        |   7 +-
 fs/ext2/namei.c            |   5 +-
 fs/ext4/namei.c            |   7 +-
 fs/f2fs/namei.c            |   5 +-
 fs/fuse/dir.c              |   5 +-
 fs/gfs2/inode.c            |   5 +-
 fs/hfsplus/dir.c           |   5 +-
 fs/hostfs/hostfs_kern.c    |   5 +-
 fs/jffs2/dir.c             |   8 +-
 fs/jfs/namei.c             |   7 +-
 fs/libfs.c                 |   6 +-
 fs/minix/namei.c           |   5 +-
 fs/namei.c                 | 166 +++++++++++++++++++++++++++++--------
 fs/nfs/dir.c               |   6 +-
 fs/nfs/internal.h          |   2 +-
 fs/nfsd/vfs.c              |   2 +-
 fs/nilfs2/namei.c          |   5 +-
 fs/ocfs2/namei.c           |   6 +-
 fs/overlayfs/dir.c         |   5 +-
 fs/overlayfs/overlayfs.h   |   2 +-
 fs/reiserfs/namei.c        |   5 +-
 fs/sysv/namei.c            |   7 +-
 fs/ubifs/dir.c             |   5 +-
 fs/udf/namei.c             |   5 +-
 fs/ufs/namei.c             |   5 +-
 fs/xfs/xfs_iops.c          |   6 +-
 include/linux/fs.h         |   6 +-
 include/uapi/linux/fcntl.h |   1 +
 mm/shmem.c                 |   6 +-
 41 files changed, 341 insertions(+), 90 deletions(-)

-- 
2.25.0

