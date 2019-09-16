Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9F3B3F7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2019 19:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbfIPRPA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 13:15:00 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37750 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729297AbfIPRO7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 13:14:59 -0400
Received: by mail-qk1-f194.google.com with SMTP id u184so763705qkd.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2019 10:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0kf4fFVtpG3pdsPgRPKkv3cXroCV+LcK3Ms5KentfGM=;
        b=erLH0JWGBop8QyioPDzly5dvY9r9cAPPSLzOIm79TPrjd99d/zYisIgS5UisbO3p7J
         8VbsDFA1R+wia15Hon3vQbeX006WTSol45rNeIwFJtYlvCrxd0808sGQvrIyuRzsRqG2
         sNuXxQewceOlp9dfkRVWUyPeNFJkf036Of0Vn7rqgJtTYiYO11NvvXy2RpYzv16nib0j
         Fs7utymAWmozOFB8vpL/08NbTdgPTJ7APqHR2adotsZV3IVQJbiOhLrLQsgtoghhuBS1
         PsnryQ5P/zAs/NWis1VZBakO5LvBkZxbnZMVx28LRNdXYJuzpoS1zInoNHLYf0w9B0mo
         oWKA==
X-Gm-Message-State: APjAAAVDYYhhspigLfV4gZ75KmI9L3lQm44ZaEAFcRg997mIoxhCCVhu
        qyu78amzLchAo6XHnBJGcyCIo5rRK7wZXr4TUi0=
X-Google-Smtp-Source: APXvYqwsX+KWUZccih0zYmTEfY6HUr9udRs9LTnZOswIEf+yyNxL/oRpvLrLKB2in3sJBnwIJZeLIgINIuesVBKPNzI=
X-Received: by 2002:ae9:f503:: with SMTP id o3mr1051598qkg.3.1568654098531;
 Mon, 16 Sep 2019 10:14:58 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 16 Sep 2019 19:14:42 +0200
Message-ID: <CAK8P3a1-rHJ0u5iJMZFNefYzhMUqSJVBXGLh2Cg4DBO5VZbi0g@mail.gmail.com>
Subject: [GIT PULL] y2038: add inode timestamp clamping
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit a55aa89aab90fae7c815b0551b07be37db359d76:

  Linux 5.3-rc6 (2019-08-25 12:01:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
tags/y2038-vfs

for you to fetch changes up to cba465b4f9820b0d929822a70341dde14909fc18:

  ext4: Reduce ext4 timestamp warnings (2019-09-04 22:54:53 +0200)

----------------------------------------------------------------
y2038: add inode timestamp clamping

This series from Deepa Dinamani adds a per-superblock minimum/maximum
timestamp limit for a file system, and clamps timestamps as they are
written, to avoid random behavior from integer overflow as well as having
different time stamps on disk vs in memory.

At mount time, a warning is now printed for any file system that can
represent current timestamps but not future timestamps more than 30
years into the future, similar to the arbitrary 30 year limit that was
added to settimeofday().

This was picked as a compromise to warn users to migrate to other file
systems (e.g. ext4 instead of ext3) when they need the file system to
survive beyond 2038 (or similar limits in other file systems), but not
get in the way of normal usage.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Arnd Bergmann (1):
      Merge branch 'limits' of https://github.com/deepa-hub/vfs into y2038

Deepa Dinamani (19):
      vfs: Add file timestamp range support
      vfs: Add timestamp_truncate() api
      timestamp_truncate: Replace users of timespec64_trunc
      mount: Add mount warning for impending timestamp expiry
      utimes: Clamp the timestamps before update
      fs: Fill in max and min timestamps in superblock
      9p: Fill min and max timestamps in sb
      ext4: Initialize timestamps limits
      fs: nfs: Initialize filesystem timestamp ranges
      fs: cifs: Initialize filesystem timestamp ranges
      fs: fat: Initialize filesystem timestamp ranges
      fs: affs: Initialize filesystem timestamp ranges
      fs: sysv: Initialize filesystem timestamp ranges
      fs: ceph: Initialize filesystem timestamp ranges
      fs: hpfs: Initialize filesystem timestamp ranges
      fs: omfs: Initialize filesystem timestamp ranges
      pstore: fs superblock limits
      isofs: Initialize filesystem timestamp ranges
      ext4: Reduce ext4 timestamp warnings

 fs/9p/vfs_super.c        |  6 +++++-
 fs/affs/amigaffs.c       |  2 +-
 fs/affs/amigaffs.h       |  3 +++
 fs/affs/inode.c          |  4 ++--
 fs/affs/super.c          |  4 ++++
 fs/attr.c                | 21 ++++++++++++---------
 fs/befs/linuxvfs.c       |  2 ++
 fs/bfs/inode.c           |  2 ++
 fs/ceph/super.c          |  2 ++
 fs/cifs/cifsfs.c         | 22 ++++++++++++++++++++++
 fs/cifs/netmisc.c        | 14 +++++++-------
 fs/coda/inode.c          |  3 +++
 fs/configfs/inode.c      | 12 ++++++------
 fs/cramfs/inode.c        |  2 ++
 fs/efs/super.c           |  2 ++
 fs/ext2/super.c          |  2 ++
 fs/ext4/ext4.h           |  8 +++++++-
 fs/ext4/super.c          | 17 +++++++++++++++--
 fs/f2fs/file.c           | 21 ++++++++++++---------
 fs/fat/inode.c           | 12 ++++++++++++
 fs/freevxfs/vxfs_super.c |  2 ++
 fs/hpfs/hpfs_fn.h        |  6 ++----
 fs/hpfs/super.c          |  2 ++
 fs/inode.c               | 33 ++++++++++++++++++++++++++++++++-
 fs/isofs/inode.c         |  7 +++++++
 fs/jffs2/fs.c            |  3 +++
 fs/jfs/super.c           |  2 ++
 fs/kernfs/inode.c        |  7 +++----
 fs/minix/inode.c         |  2 ++
 fs/namespace.c           | 33 ++++++++++++++++++++++++++++++++-
 fs/nfs/super.c           | 20 +++++++++++++++++++-
 fs/ntfs/inode.c          | 21 ++++++++++++---------
 fs/omfs/inode.c          |  4 ++++
 fs/pstore/ram.c          |  2 ++
 fs/qnx4/inode.c          |  2 ++
 fs/qnx6/inode.c          |  2 ++
 fs/reiserfs/super.c      |  3 +++
 fs/romfs/super.c         |  2 ++
 fs/squashfs/super.c      |  2 ++
 fs/super.c               |  2 ++
 fs/sysv/super.c          |  5 ++++-
 fs/ubifs/file.c          | 21 ++++++++++++---------
 fs/ufs/super.c           |  7 +++++++
 fs/utimes.c              |  6 ++----
 fs/xfs/xfs_super.c       |  2 ++
 include/linux/fs.h       |  5 +++++
 include/linux/time64.h   |  2 ++
 47 files changed, 294 insertions(+), 72 deletions(-)
