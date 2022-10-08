Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B39B5F81D9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 03:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiJHBXk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 21:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiJHBXj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 21:23:39 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1606DFB55;
        Fri,  7 Oct 2022 18:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Y2nuvT1SusSJLf5P+1xv1WfU6FMIn4UEVGCUCquUqYg=; b=kJZggz7IpxAyoitHxy9W/0dEB5
        p+C+reiSSvxNPkdNkad1ZH1paDHabh1Ap9VVg1kB0ibWWBodVNkNh8ySQoGXPki4itLDCEHIcmhGe
        ePSBKrMQ1CzjYAgRsbfR0CDTMT8R3Bm6EJa/GkEYf1MNfYDAf93vFTcoeOcR2KCJaHfcglj6XEB4g
        /QJmyRUOgPqjOwD8j03jSZlyY7S4x24F7vHpuUYsCoUEQ2nHlPTJpSgigfNlVuCugaOoivUNRrJ2U
        HEzjLR9oUroNJsroQrNcIvexvwgxZf2VPte6bFoXO0tEM+OVds6l51UBSOtAPXcSOV9ffB/BCnS9M
        7oazb8KA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ogyYw-008PoT-21;
        Sat, 08 Oct 2022 01:23:34 +0000
Date:   Sat, 8 Oct 2022 02:23:34 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git pile 7 (tmpfile)
Message-ID: <Y0DRFtPcQ2jeZfXa@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Miklos' ->tmpfile() signature change; pass an unopened struct file
to it, let it open the damn thing.  Allows to add tmpfile support to FUSE.

	A couple of conflicts - one in overlayfs (use the lines from this
branch), another in Documentation/filesystems/porting.rst (file is essentially
append-only, so just add the chunk to the EOF).

The following changes since commit 521a547ced6477c54b4b0cc206000406c221b4d6:

  Linux 6.0-rc6 (2022-09-18 13:44:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-tmpfile

for you to fetch changes up to 7d37539037c2fca70346fbedc219f655253d5cff:

  fuse: implement ->tmpfile() (2022-09-24 07:00:00 +0200)

----------------------------------------------------------------
tmpfile API change

----------------------------------------------------------------
Al Viro (1):
      hugetlbfs: cleanup mknod and tmpfile

Miklos Szeredi (9):
      vfs: add vfs_tmpfile_open() helper
      cachefiles: tmpfile error handling cleanup
      cachefiles: only pass inode to *mark_inode_inuse() helpers
      cachefiles: use vfs_tmpfile_open() helper
      ovl: use vfs_tmpfile_open() helper
      vfs: make vfs_tmpfile() static
      vfs: move open right after ->tmpfile()
      vfs: open inside ->tmpfile()
      fuse: implement ->tmpfile()

 Documentation/filesystems/locking.rst |   3 +-
 Documentation/filesystems/porting.rst |  10 +++
 Documentation/filesystems/vfs.rst     |   6 +-
 fs/bad_inode.c                        |   2 +-
 fs/btrfs/inode.c                      |   8 +--
 fs/cachefiles/namei.c                 | 122 +++++++++++++++-------------------
 fs/dcache.c                           |   4 +-
 fs/ext2/namei.c                       |   6 +-
 fs/ext4/namei.c                       |   6 +-
 fs/f2fs/namei.c                       |  13 ++--
 fs/fuse/dir.c                         |  24 ++++++-
 fs/fuse/fuse_i.h                      |   3 +
 fs/hugetlbfs/inode.c                  |  42 +++++-------
 fs/minix/namei.c                      |   6 +-
 fs/namei.c                            |  88 +++++++++++++++---------
 fs/overlayfs/copy_up.c                | 108 ++++++++++++++++--------------
 fs/overlayfs/overlayfs.h              |  14 ++--
 fs/overlayfs/super.c                  |  10 +--
 fs/overlayfs/util.c                   |   2 +-
 fs/ramfs/inode.c                      |   6 +-
 fs/ubifs/dir.c                        |   7 +-
 fs/udf/namei.c                        |   6 +-
 fs/xfs/xfs_iops.c                     |  16 +++--
 include/linux/dcache.h                |   3 +-
 include/linux/fs.h                    |  16 ++++-
 include/uapi/linux/fuse.h             |   6 +-
 mm/shmem.c                            |   6 +-
 27 files changed, 303 insertions(+), 240 deletions(-)
