Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575FD72E3C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 15:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241780AbjFMNJh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 09:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbjFMNJg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:09:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF36A10E4;
        Tue, 13 Jun 2023 06:09:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FFD5635FB;
        Tue, 13 Jun 2023 13:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07119C433D9;
        Tue, 13 Jun 2023 13:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686661773;
        bh=qrftKBs3i7D8ZGNlzf1fQKSMJm25AmjmFrSZlBDhScw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nhWdmiD+f3lTmkCY4u7x2sZQyNmY/i0uQjZjngjBeAQc/cZz4AbT/0GNqRQRwttXe
         l+dTGnkyPWartXH8Yc8Fl5zk9rX+CvYbmilx569mB9oi1CMboGUbNYB4Pin54O7rgx
         Vnz6dZCxjmiWTMct/0+qGsoJjcEYDxxD0mcCDeEj+dw92aR/SKq40BKET/eqLRMddw
         0HJh7Lni4O1QaCPklU2775AM1yCoJu2RXGsOg3q475QIjSh5266UNf0Zv2E5V7PVbS
         sgpNQ6yQVVRsy6aGzfrLQ0R3YXowb2mCCIeIqCa8jFNrA7e0ymfT28M34UcsZTQMSH
         EEa7/+T8NKNXQ==
Message-ID: <11dc42c327c243ea1def211f352cb4fc38094cc0.camel@kernel.org>
Subject: Re: [PATCH v4 2/9] fs: add infrastructure for multigrain inode
 i_m/ctime
From:   Jeff Layton <jlayton@kernel.org>
To:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>,
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
Date:   Tue, 13 Jun 2023 09:09:29 -0400
In-Reply-To: <20230523124606.bkkhwi6b67ieeygl@quack3>
References: <20230518114742.128950-1-jlayton@kernel.org>
         <20230518114742.128950-3-jlayton@kernel.org>
         <20230523100240.mgeu4y46friv7hau@quack3>
         <bf0065f2c9895edb66faeacc6cf77bd257088348.camel@kernel.org>
         <20230523124606.bkkhwi6b67ieeygl@quack3>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-05-23 at 14:46 +0200, Jan Kara wrote:
> On Tue 23-05-23 06:40:08, Jeff Layton wrote:
> > On Tue, 2023-05-23 at 12:02 +0200, Jan Kara wrote:
> > >=20
> > > So there are two things I dislike about this series because I think t=
hey
> > > are fragile:
> > >=20
> > > 1) If we have a filesystem supporting multigrain ts and someone
> > > accidentally directly uses the value of inode->i_ctime, he can get bo=
gus
> > > value (with QUERIED flag). This mistake is very easy to do. So I thin=
k we
> > > should rename i_ctime to something like __i_ctime and always use acce=
ssor
> > > function for it.
> > >=20
> >=20
> > We could do this, but it'll be quite invasive. We'd have to change any
> > place that touches i_ctime (and there are a lot of them), even on
> > filesystems that are not being converted.
>=20
> Yes, that's why I suggested Coccinelle to deal with this.


I've done the work to convert all of the accesses of i_ctime into
accessor functions in the kernel. The current state of it is here:

  =20
https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/commit/?h=
=3Dctime

As expected, it touches a lot of code, all over the place. So far I have
most of the conversion in one giant patch, and I need to split it up
(probably per-subsystem).

What's the best way to feed this change into mainline? Should I try to
get subsystem maintainers to pick these up, or are we better off feeding
this in via a separate branch?

For reference, the diffstat for the big conversion patch is below:

 arch/powerpc/platforms/cell/spufs/inode.c |  2 +-
 arch/s390/hypfs/inode.c                   |  4 +-
 drivers/android/binderfs.c                |  8 ++--
 drivers/infiniband/hw/qib/qib_fs.c        |  4 +-
 drivers/misc/ibmasm/ibmasmfs.c            |  2 +-
 drivers/misc/ibmvmc.c                     |  2 +-
 drivers/usb/core/devio.c                  | 16 ++++----
 drivers/usb/gadget/function/f_fs.c        |  6 +--
 drivers/usb/gadget/legacy/inode.c         |  3 +-
 fs/9p/vfs_inode.c                         |  6 ++-
 fs/9p/vfs_inode_dotl.c                    | 11 +++---
 fs/adfs/inode.c                           |  4 +-
 fs/affs/amigaffs.c                        |  6 +--
 fs/affs/inode.c                           | 17 ++++----
 fs/afs/dynroot.c                          |  2 +-
 fs/afs/inode.c                            |  6 +--
 fs/attr.c                                 |  2 +-
 fs/autofs/inode.c                         |  2 +-
 fs/autofs/root.c                          |  6 +--
 fs/bad_inode.c                            |  3 +-
 fs/befs/linuxvfs.c                        |  2 +-
 fs/bfs/dir.c                              | 16 ++++----
 fs/bfs/inode.c                            |  6 +--
 fs/binfmt_misc.c                          |  3 +-
 fs/btrfs/delayed-inode.c                  | 10 +++--
 fs/btrfs/file.c                           | 24 ++++-------
 fs/btrfs/inode.c                          | 66 ++++++++++++------------
-------
 fs/btrfs/ioctl.c                          |  2 +-
 fs/btrfs/reflink.c                        |  7 ++--
 fs/btrfs/transaction.c                    |  3 +-
 fs/btrfs/tree-log.c                       |  4 +-
 fs/btrfs/xattr.c                          |  4 +-
 fs/ceph/acl.c                             |  2 +-
 fs/ceph/caps.c                            |  2 +-
 fs/ceph/inode.c                           | 17 ++++----
 fs/ceph/snap.c                            |  2 +-
 fs/ceph/xattr.c                           |  2 +-
 fs/coda/coda_linux.c                      |  2 +-
 fs/coda/dir.c                             |  2 +-
 fs/coda/file.c                            |  2 +-
 fs/coda/inode.c                           |  2 +-
 fs/configfs/inode.c                       |  6 +--
 fs/cramfs/inode.c                         |  2 +-
 fs/debugfs/inode.c                        |  2 +-
 fs/devpts/inode.c                         |  6 +--
 fs/ecryptfs/inode.c                       |  2 +-
 fs/efivarfs/file.c                        |  2 +-
 fs/efivarfs/inode.c                       |  2 +-
 fs/efs/inode.c                            |  5 ++-
 fs/erofs/inode.c                          | 16 ++++----
 fs/exfat/file.c                           |  4 +-
 fs/exfat/inode.c                          |  6 +--
 fs/exfat/namei.c                          | 29 +++++++-------
 fs/exfat/super.c                          |  4 +-
 fs/ext2/acl.c                             |  2 +-
 fs/ext2/dir.c                             |  6 +--
 fs/ext2/ialloc.c                          |  2 +-
 fs/ext2/inode.c                           | 11 +++---
 fs/ext2/ioctl.c                           |  4 +-
 fs/ext2/namei.c                           |  8 ++--
 fs/ext2/super.c                           |  2 +-
 fs/ext2/xattr.c                           |  2 +-
 fs/ext4/acl.c                             |  2 +-
 fs/ext4/ext4.h                            | 20 ++++++++++
 fs/ext4/extents.c                         | 12 +++---
 fs/ext4/ialloc.c                          |  2 +-
 fs/ext4/inline.c                          |  4 +-
 fs/ext4/inode.c                           | 16 ++++----
 fs/ext4/ioctl.c                           |  9 +++--
 fs/ext4/namei.c                           | 26 ++++++------
 fs/ext4/super.c                           |  2 +-
 fs/ext4/xattr.c                           |  6 +--
 fs/f2fs/dir.c                             |  8 ++--
 fs/f2fs/f2fs.h                            |  5 ++-
 fs/f2fs/file.c                            | 16 ++++----
 fs/f2fs/inline.c                          |  2 +-
 fs/f2fs/inode.c                           | 10 ++---
 fs/f2fs/namei.c                           | 12 +++---
 fs/f2fs/recovery.c                        |  4 +-
 fs/f2fs/super.c                           |  2 +-
 fs/f2fs/xattr.c                           |  2 +-
 fs/fat/inode.c                            |  8 ++--
 fs/fat/misc.c                             |  7 +++-
 fs/freevxfs/vxfs_inode.c                  |  4 +-
 fs/fuse/control.c                         |  2 +-
 fs/fuse/dir.c                             |  8 ++--
 fs/fuse/inode.c                           | 18 +++++----
 fs/gfs2/acl.c                             |  2 +-
 fs/gfs2/bmap.c                            | 11 +++---
 fs/gfs2/dir.c                             | 15 +++----
 fs/gfs2/file.c                            |  2 +-
 fs/gfs2/glops.c                           |  4 +-
 fs/gfs2/inode.c                           |  8 ++--
 fs/gfs2/super.c                           |  4 +-
 fs/gfs2/xattr.c                           |  8 ++--
 fs/hfs/catalog.c                          |  8 ++--
 fs/hfs/dir.c                              |  2 +-
 fs/hfs/inode.c                            | 13 +++---
 fs/hfs/sysdep.c                           |  2 +-
 fs/hfsplus/catalog.c                      |  8 ++--
 fs/hfsplus/dir.c                          |  6 +--
 fs/hfsplus/inode.c                        | 14 +++----
 fs/hostfs/hostfs_kern.c                   |  5 ++-
 fs/hpfs/dir.c                             |  8 ++--
 fs/hpfs/inode.c                           |  6 +--
 fs/hpfs/namei.c                           | 26 ++++++------
 fs/hpfs/super.c                           |  5 ++-
 fs/hugetlbfs/inode.c                      | 12 +++---
 fs/inode.c                                | 12 ++++--
 fs/isofs/inode.c                          |  4 +-
 fs/isofs/rock.c                           | 16 ++++----
 fs/jffs2/dir.c                            | 19 ++++-----
 fs/jffs2/file.c                           |  3 +-
 fs/jffs2/fs.c                             | 10 ++---
 fs/jffs2/os-linux.h                       |  2 +-
 fs/jfs/acl.c                              |  2 +-
 fs/jfs/inode.c                            |  2 +-
 fs/jfs/ioctl.c                            |  2 +-
 fs/jfs/jfs_imap.c                         |  8 ++--
 fs/jfs/jfs_inode.c                        |  4 +-
 fs/jfs/namei.c                            | 25 ++++++------
 fs/jfs/super.c                            |  2 +-
 fs/jfs/xattr.c                            |  2 +-
 fs/kernfs/inode.c                         |  4 +-
 fs/libfs.c                                | 32 ++++++++-------
 fs/minix/bitmap.c                         |  2 +-
 fs/minix/dir.c                            |  6 +--
 fs/minix/inode.c                          | 11 +++---
 fs/minix/itree_common.c                   |  4 +-
 fs/minix/namei.c                          |  6 +--
 fs/nfs/callback_proc.c                    |  2 +-
 fs/nfs/fscache.h                          |  4 +-
 fs/nfs/inode.c                            | 21 +++++-----
 fs/nfsd/nfsctl.c                          |  2 +-
 fs/nfsd/nfsfh.c                           |  4 +-
 fs/nfsd/vfs.c                             |  2 +-
 fs/nilfs2/dir.c                           |  6 +--
 fs/nilfs2/inode.c                         | 12 +++---
 fs/nilfs2/ioctl.c                         |  2 +-
 fs/nilfs2/namei.c                         |  8 ++--
 fs/nsfs.c                                 |  2 +-
 fs/ntfs/inode.c                           | 15 +++----
 fs/ntfs/mft.c                             |  3 +-
 fs/ntfs3/file.c                           |  6 +--
 fs/ntfs3/frecord.c                        |  4 +-
 fs/ntfs3/inode.c                          | 14 ++++---
 fs/ntfs3/namei.c                          | 10 ++---
 fs/ntfs3/xattr.c                          |  4 +-
 fs/ocfs2/acl.c                            |  6 +--
 fs/ocfs2/alloc.c                          |  6 +--
 fs/ocfs2/aops.c                           |  2 +-
 fs/ocfs2/dir.c                            |  8 ++--
 fs/ocfs2/dlmfs/dlmfs.c                    |  4 +-
 fs/ocfs2/dlmglue.c                        | 10 +++--
 fs/ocfs2/file.c                           | 16 ++++----
 fs/ocfs2/inode.c                          | 14 ++++---
 fs/ocfs2/move_extents.c                   |  6 +--
 fs/ocfs2/namei.c                          | 22 ++++++-----
 fs/ocfs2/refcounttree.c                   | 14 +++----
 fs/ocfs2/xattr.c                          |  6 +--
 fs/omfs/dir.c                             |  4 +-
 fs/omfs/inode.c                           | 10 ++---
 fs/openpromfs/inode.c                     |  4 +-
 fs/orangefs/namei.c                       |  2 +-
 fs/orangefs/orangefs-utils.c              |  6 +--
 fs/overlayfs/file.c                       |  7 +++-
 fs/overlayfs/util.c                       |  2 +-
 fs/pipe.c                                 |  2 +-
 fs/posix_acl.c                            |  2 +-
 fs/proc/base.c                            |  2 +-
 fs/proc/inode.c                           |  2 +-
 fs/proc/proc_sysctl.c                     |  2 +-
 fs/proc/self.c                            |  2 +-
 fs/proc/thread_self.c                     |  2 +-
 fs/pstore/inode.c                         |  4 +-
 fs/qnx4/inode.c                           |  4 +-
 fs/qnx6/inode.c                           |  4 +-
 fs/ramfs/inode.c                          |  6 +--
 fs/reiserfs/inode.c                       | 14 +++----
 fs/reiserfs/ioctl.c                       |  4 +-
 fs/reiserfs/namei.c                       | 21 +++++-----
 fs/reiserfs/stree.c                       |  4 +-
 fs/reiserfs/super.c                       |  2 +-
 fs/reiserfs/xattr.c                       |  5 ++-
 fs/reiserfs/xattr_acl.c                   |  2 +-
 fs/romfs/super.c                          |  4 +-
 fs/smb/client/file.c                      |  4 +-
 fs/smb/client/fscache.h                   |  5 ++-
 fs/smb/client/inode.c                     | 15 ++++---
 fs/smb/client/smb2ops.c                   |  2 +-
 fs/smb/server/smb2pdu.c                   |  8 ++--
 fs/squashfs/inode.c                       |  2 +-
 fs/stack.c                                |  2 +-
 fs/stat.c                                 |  2 +-
 fs/sysv/dir.c                             |  6 +--
 fs/sysv/ialloc.c                          |  2 +-
 fs/sysv/inode.c                           |  6 +--
 fs/sysv/itree.c                           |  4 +-
 fs/sysv/namei.c                           |  6 +--
 fs/tracefs/inode.c                        |  2 +-
 fs/ubifs/debug.c                          |  4 +-
 fs/ubifs/dir.c                            | 39 +++++++++---------
 fs/ubifs/file.c                           | 16 ++++----
 fs/ubifs/ioctl.c                          |  2 +-
 fs/ubifs/journal.c                        |  4 +-
 fs/ubifs/super.c                          |  4 +-
 fs/ubifs/xattr.c                          |  6 +--
 fs/udf/ialloc.c                           |  2 +-
 fs/udf/inode.c                            | 17 ++++----
 fs/udf/namei.c                            | 24 +++++------
 fs/ufs/dir.c                              |  6 +--
 fs/ufs/ialloc.c                           |  2 +-
 fs/ufs/inode.c                            | 23 ++++++-----
 fs/ufs/namei.c                            |  8 ++--
 fs/vboxsf/utils.c                         |  4 +-
 fs/xfs/libxfs/xfs_inode_buf.c             |  4 +-
 fs/xfs/libxfs/xfs_trans_inode.c           |  2 +-
 fs/xfs/xfs_acl.c                          |  2 +-
 fs/xfs/xfs_bmap_util.c                    |  6 ++-
 fs/xfs/xfs_inode.c                        |  2 +-
 fs/xfs/xfs_inode_item.c                   |  2 +-
 fs/xfs/xfs_iops.c                         |  4 +-
 fs/xfs/xfs_itable.c                       |  4 +-
 fs/zonefs/super.c                         |  8 ++--
 include/linux/fs.h                        |  1 +
 include/linux/fs_stack.h                  |  2 +-
 ipc/mqueue.c                              | 20 +++++-----
 kernel/bpf/inode.c                        |  4 +-
 mm/shmem.c                                | 28 +++++++------
 net/sunrpc/rpc_pipe.c                     |  2 +-
 security/apparmor/apparmorfs.c            |  6 +--
 security/apparmor/policy_unpack.c         |  4 +-
 security/inode.c                          |  2 +-
 security/selinux/selinuxfs.c              |  2 +-
 234 files changed, 851 insertions(+), 808 deletions(-)

--=20
Jeff Layton <jlayton@kernel.org>
