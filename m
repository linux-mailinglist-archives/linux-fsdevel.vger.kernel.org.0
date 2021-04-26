Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD4336BBA9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 00:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbhDZW3i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 18:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbhDZW3f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 18:29:35 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8813CC061574;
        Mon, 26 Apr 2021 15:28:53 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lb9ik-008W5S-Rm; Mon, 26 Apr 2021 22:28:50 +0000
Date:   Mon, 26 Apr 2021 22:28:50 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git inode type handling fixes
Message-ID: <YIc+orIAyfwUHGFo@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	We should never change the type bits of ->i_mode or the method tables
(->i_op and ->i_fop) of a live inode.  Unfortunately, not all filesystems
took care to prevent that.

	rc2-based, one trivial conflict in fs/cifs/file.c on merge with mainline

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.inode-type-fixes

for you to fetch changes up to c4ab036a2f41184ba969f86dda73be361c9ab39d:

  spufs: fix bogosity in S_ISGID handling (2021-03-12 23:13:52 -0500)

----------------------------------------------------------------
Al Viro (12):
      new helper: inode_wrong_type()
      vboxsf: don't allow to change the inode type
      orangefs_inode_is_stale(): i_mode type bits do *not* form a bitmap...
      ocfs2_inode_lock_update(): make sure we don't change the type bits of i_mode
      gfs2: be careful with inode refresh
      do_cifs_create(): don't set ->i_mode of something we had not created
      cifs: have ->mkdir() handle race with another client sanely
      cifs: have cifs_fattr_to_inode() refuse to change type on live inode
      hostfs_mknod(): don't bother with init_special_inode()
      openpromfs: don't do unlock_new_inode() until the new inode is set up
      9p: missing chunk of "fs/9p: Don't update file type when updating file attributes"
      spufs: fix bogosity in S_ISGID handling

David Howells (1):
      afs: Fix updating of i_mode due to 3rd party change

Jeff Layton (2):
      ceph: fix up error handling with snapdirs
      ceph: don't allow type or device number to change on non-I_NEW inodes

 arch/powerpc/platforms/cell/spufs/inode.c | 10 +----
 fs/9p/vfs_inode.c                         |  4 +-
 fs/9p/vfs_inode_dotl.c                    | 14 +++----
 fs/afs/inode.c                            |  6 +--
 fs/ceph/caps.c                            |  8 +++-
 fs/ceph/dir.c                             |  2 +
 fs/ceph/export.c                          |  9 ++--
 fs/ceph/inode.c                           | 41 ++++++++++++++++---
 fs/cifs/cifsproto.h                       |  2 +-
 fs/cifs/dir.c                             | 19 +++++----
 fs/cifs/file.c                            |  2 +-
 fs/cifs/inode.c                           | 57 ++++++++++++--------------
 fs/cifs/readdir.c                         |  4 +-
 fs/fuse/dir.c                             |  6 +--
 fs/fuse/inode.c                           |  2 +-
 fs/fuse/readdir.c                         |  2 +-
 fs/gfs2/glops.c                           | 22 ++++++----
 fs/hostfs/hostfs_kern.c                   |  1 -
 fs/nfs/inode.c                            |  6 +--
 fs/nfsd/nfsproc.c                         |  2 +-
 fs/ocfs2/dlmglue.c                        | 12 +++++-
 fs/openpromfs/inode.c                     | 67 +++++++++++++++---------------
 fs/orangefs/orangefs-utils.c              |  2 +-
 fs/overlayfs/namei.c                      |  4 +-
 fs/vboxsf/dir.c                           |  4 +-
 fs/vboxsf/super.c                         |  4 +-
 fs/vboxsf/utils.c                         | 68 +++++++++++++++++++------------
 fs/vboxsf/vfsmod.h                        |  4 +-
 include/linux/fs.h                        |  5 +++
 29 files changed, 225 insertions(+), 164 deletions(-)
