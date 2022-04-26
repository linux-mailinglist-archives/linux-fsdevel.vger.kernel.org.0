Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C669950F532
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 10:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239433AbiDZIsX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 04:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346584AbiDZIpL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:45:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6153C1CB4;
        Tue, 26 Apr 2022 01:35:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEA22618A2;
        Tue, 26 Apr 2022 08:35:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A369C385A0;
        Tue, 26 Apr 2022 08:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650962104;
        bh=urtvNtYomLJK+ODI94zb12amwUYrTkkYSm3BkVlaLhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mQ8OIqJHcmwrRUBiGTnsraZpOlIE8kg46TiSgw3a1sNNadZY1rVd8ciAW/t4VTafw
         fGWnlqDg8iLG9yG/YQDy27L6KFOn9pRoLEK1xbpaADEsMKm0uWMVbeOYK+b9yP1fCZ
         BICm9e7VJYZPn2pM86FbT3hSH35edWOXdbUKuRh3ll1EB+2moy/VogGu4WGYErygDO
         F0SLg42OG4qtZ2Xlrd9IJdfkTKusKjLGR8trOVWBMbmAjCc0r7SiJBUAEyhPGZEq1O
         2EiEsfaQIlHzRBoDeznYHFWvK85DROF80vFlOXrQCBell4jXh4yHSKtn/8vRoeQueW
         xHH12bDtg5NHQ==
Date:   Tue, 26 Apr 2022 10:34:58 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Yang Xu <xuyang2018.jy@fujitsu.com>, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, viro@zeniv.linux.org.uk,
        david@fromorbit.com, willy@infradead.org, jlayton@kernel.org
Subject: Re: [PATCH v7 3/4] fs: strip file's S_ISGID mode on vfs instead of
 on underlying filesystem
Message-ID: <20220426083458.fdpiyfik3mxitzju@wittgenstein>
References: <1650946792-9545-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1650946792-9545-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220426052157.GJ17059@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220426052157.GJ17059@magnolia>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 25, 2022 at 10:21:57PM -0700, Darrick J. Wong wrote:
> On Tue, Apr 26, 2022 at 12:19:51PM +0800, Yang Xu wrote:
> > Currently, vfs only passes mode parameter to filesystem, then use inode_init_owner()
> > to strip S_ISGID. Some filesystem(ie ext4/btrfs) will call inode_init_owner
> > firstly, then posxi acl setup, but xfs uses the contrary order. It will
> > affect S_ISGID clear especially we filter S_IXGRP by umask or acl.
> > 
> > Regardless of which filesystem is in use, failure to strip the SGID correctly
> > is considered a security failure that needs to be fixed. The current VFS
> > infrastructure requires the filesystem to do everything right and not step on
> > any landmines to strip the SGID bit, when in fact it can easily be done at the
> > VFS and the filesystems then don't even need to be aware that the SGID needs
> > to be (or has been stripped) by the operation the user asked to be done.
> > 
> > Vfs has all the info it needs - it doesn't need the filesystems to do everything
> > correctly with the mode and ensuring that they order things like posix acl setup
> > functions correctly with inode_init_owner() to strip the SGID bit.
> > 
> > Just strip the SGID bit at the VFS, and then the filesystem can't get it wrong.
> > 
> > Also, the mode_strip_sgid() api should be used before IS_POSIXACL() because
> > this api may change mode.
> > 
> > Only the following places use inode_init_owner
> > "
> > arch/powerpc/platforms/cell/spufs/inode.c:      inode_init_owner(&init_user_ns, inode, dir, mode | S_IFDIR);
> > arch/powerpc/platforms/cell/spufs/inode.c:      inode_init_owner(&init_user_ns, inode, dir, mode | S_IFDIR);
> > fs/9p/vfs_inode.c:      inode_init_owner(&init_user_ns, inode, NULL, mode);
> > fs/bfs/dir.c:   inode_init_owner(&init_user_ns, inode, dir, mode);
> > fs/btrfs/inode.c:       inode_init_owner(mnt_userns, inode, dir, mode);
> > fs/btrfs/tests/btrfs-tests.c:   inode_init_owner(&init_user_ns, inode, NULL, S_IFREG);
> > fs/ext2/ialloc.c:               inode_init_owner(&init_user_ns, inode, dir, mode);
> > fs/ext4/ialloc.c:               inode_init_owner(mnt_userns, inode, dir, mode);
> > fs/f2fs/namei.c:        inode_init_owner(mnt_userns, inode, dir, mode);
> > fs/hfsplus/inode.c:     inode_init_owner(&init_user_ns, inode, dir, mode);
> > fs/hugetlbfs/inode.c:           inode_init_owner(&init_user_ns, inode, dir, mode);
> > fs/jfs/jfs_inode.c:     inode_init_owner(&init_user_ns, inode, parent, mode);
> > fs/minix/bitmap.c:      inode_init_owner(&init_user_ns, inode, dir, mode);
> > fs/nilfs2/inode.c:      inode_init_owner(&init_user_ns, inode, dir, mode);
> > fs/ntfs3/inode.c:       inode_init_owner(mnt_userns, inode, dir, mode);
> > fs/ocfs2/dlmfs/dlmfs.c:         inode_init_owner(&init_user_ns, inode, NULL, mode);
> > fs/ocfs2/dlmfs/dlmfs.c: inode_init_owner(&init_user_ns, inode, parent, mode);
> > fs/ocfs2/namei.c:       inode_init_owner(&init_user_ns, inode, dir, mode);
> > fs/omfs/inode.c:        inode_init_owner(&init_user_ns, inode, NULL, mode);
> > fs/overlayfs/dir.c:     inode_init_owner(&init_user_ns, inode, dentry->d_parent->d_inode, mode);
> > fs/ramfs/inode.c:               inode_init_owner(&init_user_ns, inode, dir, mode);
> > fs/reiserfs/namei.c:    inode_init_owner(&init_user_ns, inode, dir, mode);
> > fs/sysv/ialloc.c:       inode_init_owner(&init_user_ns, inode, dir, mode);
> > fs/ubifs/dir.c: inode_init_owner(&init_user_ns, inode, dir, mode);
> > fs/udf/ialloc.c:        inode_init_owner(&init_user_ns, inode, dir, mode);
> > fs/ufs/ialloc.c:        inode_init_owner(&init_user_ns, inode, dir, mode);
> > fs/xfs/xfs_inode.c:             inode_init_owner(mnt_userns, inode, dir, mode);
> > fs/zonefs/super.c:      inode_init_owner(&init_user_ns, inode, parent, S_IFDIR | 0555);
> > kernel/bpf/inode.c:     inode_init_owner(&init_user_ns, inode, dir, mode);
> > mm/shmem.c:             inode_init_owner(&init_user_ns, inode, dir, mode);
> > "
> > 
> > They are used in filesystem to init new inode function and these init inode
> > functions are used by following operations:
> > mkdir
> > symlink
> > mknod
> > create
> > tmpfile
> > rename
> > 
> > We don't care about mkdir because we don't strip SGID bit for directory except
> > fs.xfs.irix_sgid_inherit. But we even call vfs_prepare_mode() in do_mkdirat() since
> > mode_strip_sgid() will skip directories anyway. This will enforce the same
> > ordering for all relevant operations and it will make the code more uniform and
> > easier to understand by using new helper vfs_prepare_mode().
> > 
> > symlink and rename only use valid mode that doesn't have SGID bit.
> > 
> > We have added mode_strip_sgid() api for the remaining operations.
> > 
> > In addition to the above six operations, four filesystems has a little difference
> > 1) btrfs has btrfs_create_subvol_root to create new inode but used non SGID bit
> >    mode and can ignore
> > 2) ocfs2 reflink function should add mode_strip_sgid api manually because this ioctl
> >    is unique and not added into vfs. It may use S_ISGID modd.
> > 3) spufs which doesn't really go hrough the regular VFS callpath because it has
> >    separate system call spu_create, but it t only allows the creation of
> >    directories and only allows bits in 0777 and can ignore
> > 4) bpf use vfs_mkobj in bpf_obj_do_pin with
> >    "S_IFREG | ((S_IRUSR | S_IWUSR) & ~current_umask()) mode and
> >    use bpf_mkobj_ops in bpf_iter_link_pin_kernel with S_IFREG | S_IRUSR mode,
> >    so bpf is also not affected
> > 
> > This patch also changed grpid behaviour for ext4/xfs because the mode passed to
> > them may been changed by vfs_prepare_mode.
> > 
> > Also as Christian Brauner said"
> > The patch itself is useful as it would move a security sensitive operation that is
> > currently burried in individual filesystems into the vfs layer. But it has a decent
> > regression potential since it might strip filesystems that have so far relied on
> > getting the S_ISGID bit with a mode argument. So this needs a lot of testing and
> > long exposure in -next for at least one full kernel cycle."
> > 
> > Suggested-by: Dave Chinner <david@fromorbit.com>
> > Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> 
> Looks good!  Thank you for taking care of this! :)
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Agreed, thank you for taking care of this and sticking around through
all the reviews.

Since this is a very sensitive patch series I think we need to be
annoyingly pedantic about the commit messages. This is really only
necessary because of the nature of these changes so you'll forgive me
for being really annoying about this. Here's what I'd change the commit
messages to:

It'd be great to get some more reviews and a thorough read of the commit
message. We should aim to approriately express the advantages in
relation to the associated regression risks:

fs: move S_ISGID stripping into the vfs

Creating files that have both the S_IXGRP and S_ISGID bit raised in
directories that themselves have the S_ISGID bit set requires additional
privileges to avoid security issues.

When a filesystem creates a new inode it needs to take care that the
caller is either in the group of the newly created inode or they have
CAP_FSETID in their current user namespace and are privileged over the
parent directory of the new inode. If any of these two conditions is
true then the S_ISGID bit can be raised for an S_IXGRP file and if not
it needs to be stripped.

However, there are several key issues with the current state of things:

* The S_ISGID stripping logic is entangled with umask stripping.

  If a filesystem doesn't support or enable POSIX ACLs then umask
  stripping is done directly in the vfs before calling into the
  filesystem.
  If the filesystem does support POSIX ACLs then unmask stripping may be
  done in the filesystem itself when calling posix_acl_create().

* Filesystems that don't rely on inode_init_owner() don't get S_ISGID
  stripping logic.

  While that may be intentional (e.g. network filesystems might just
  defer setgid stripping to a server) it is often just a security issue.

* The first two points taken together mean that there's a
  non-standardized ordering between setgid stripping in
  inode_init_owner() and posix_acl_create() both on the vfs level and
  the filesystem level. The latter part is especially problematic since
  each filesystem is technically free to order inode_init_owner() and
  posix_acl_create() however it sees fit meaning that S_ISGID
  inheritance might or might not be applied.

* We do still have bugs in this areas years after the initial round of
  setgid bugfixes.

So the current state is quite messy and while we won't be able to make
it completely clean as posix_acl_create() is still a filesystem specific
call we can improve the S_SIGD stripping situation quite a bit by
hoisting it out of inode_init_owner() and into the vfs creation
operations. This means we alleviate the burden for filesystems to handle
S_ISGID stripping correctly and can standardize the ordering between
S_ISGID and umask stripping in the vfs.

The S_ISGID bit is stripped before any umask is applied. This has the
advantage that the ordering is unaffected by whether umask stripping is
done by the vfs itself (if no POSIX ACLs are supported or enabled) or in
the filesystem in posix_acl_create() (if POSIX ACLs are supported).

To this end a new helper vfs_prepare_mode() is added which calls the
previously added mode_strip_setgid() helper and strips the umask
afterwards.

All inode operations that create new filesystem objects have been
updated to call vfs_prepare_mode() before passing the mode into the
relevant inode operation of the filesystems. Care has been taken to
ensure that the mode passed to the security hooks is the mode that is
seen by the filesystem.

Following is an overview of the filesystem specific and inode operations
specific implications:

arch/powerpc/platforms/cell/spufs/inode.c:      inode_init_owner(&init_user_ns, inode, dir, mode | S_IFDIR);
arch/powerpc/platforms/cell/spufs/inode.c:      inode_init_owner(&init_user_ns, inode, dir, mode | S_IFDIR);
fs/9p/vfs_inode.c:      inode_init_owner(&init_user_ns, inode, NULL, mode);
fs/bfs/dir.c:   inode_init_owner(&init_user_ns, inode, dir, mode);
fs/btrfs/inode.c:       inode_init_owner(mnt_userns, inode, dir, mode);
fs/btrfs/tests/btrfs-tests.c:   inode_init_owner(&init_user_ns, inode, NULL, S_IFREG);
fs/ext2/ialloc.c:               inode_init_owner(&init_user_ns, inode, dir, mode);
fs/ext4/ialloc.c:               inode_init_owner(mnt_userns, inode, dir, mode);
fs/f2fs/namei.c:        inode_init_owner(mnt_userns, inode, dir, mode);
fs/hfsplus/inode.c:     inode_init_owner(&init_user_ns, inode, dir, mode);
fs/hugetlbfs/inode.c:           inode_init_owner(&init_user_ns, inode, dir, mode);
fs/jfs/jfs_inode.c:     inode_init_owner(&init_user_ns, inode, parent, mode);
fs/minix/bitmap.c:      inode_init_owner(&init_user_ns, inode, dir, mode);
fs/nilfs2/inode.c:      inode_init_owner(&init_user_ns, inode, dir, mode);
fs/ntfs3/inode.c:       inode_init_owner(mnt_userns, inode, dir, mode);
fs/ocfs2/dlmfs/dlmfs.c:         inode_init_owner(&init_user_ns, inode, NULL, mode);
fs/ocfs2/dlmfs/dlmfs.c: inode_init_owner(&init_user_ns, inode, parent, mode);
fs/ocfs2/namei.c:       inode_init_owner(&init_user_ns, inode, dir, mode);
fs/omfs/inode.c:        inode_init_owner(&init_user_ns, inode, NULL, mode);
fs/overlayfs/dir.c:     inode_init_owner(&init_user_ns, inode, dentry->d_parent->d_inode, mode);
fs/ramfs/inode.c:               inode_init_owner(&init_user_ns, inode, dir, mode);
fs/reiserfs/namei.c:    inode_init_owner(&init_user_ns, inode, dir, mode);
fs/sysv/ialloc.c:       inode_init_owner(&init_user_ns, inode, dir, mode);
fs/ubifs/dir.c: inode_init_owner(&init_user_ns, inode, dir, mode);
fs/udf/ialloc.c:        inode_init_owner(&init_user_ns, inode, dir, mode);
fs/ufs/ialloc.c:        inode_init_owner(&init_user_ns, inode, dir, mode);
fs/xfs/xfs_inode.c:             inode_init_owner(mnt_userns, inode, dir, mode);
fs/zonefs/super.c:      inode_init_owner(&init_user_ns, inode, parent, S_IFDIR | 0555);
kernel/bpf/inode.c:     inode_init_owner(&init_user_ns, inode, dir, mode);
mm/shmem.c:             inode_init_owner(&init_user_ns, inode, dir, mode);

All of the above filesystems end up calling inode_init_owner() when new
filesystem objects are created through the following ->mkdir(),
->symlink(), ->mknod(), ->create(), ->tmpfile(), ->rename() inode
operations.

Since directories always inherit the S_ISGID bit with the exception of
xfs when irix_sgid_inherit mode is turned on S_ISGID stripping doesn't
apply. The ->symlink() inode operation trivially inherit the mode from
the target and the ->rename() inode operation inherits the mode from the
source inode.

All other inode operations will have the S_ISGID bit stripped once in
vfs_prepare_mode() before.

In addition to this there are filesystems which allow the creation of
filesystem objects through ioctl()s or - in the case of spufs -
circumventing the vfs in other ways. If filesystem objects are created
through ioctl()s the vfs doesn't know about it and can't apply regular
permission checking including S_ISGID logic. Therfore, a filesystem
relying on S_ISGID stripping in inode_init_owner() in their ioctl()
callpath will be affected by moving this logic into the vfs.

So we did our best to audit all filesystems in this regard:

* btrfs allows the creation of filesystem objects through various
  ioctls(). Snapshot creation literally takes a snapshot and so the mode
  is fully preserved and S_ISGID stripping doesn't apply.

  Creating a new subvolum relies on inode_init_owner() in
  btrfs_new_inode() but only creates directories and doesn't raise
  S_ISGID.

* ocfs2 has a peculiar implementation of reflinks. In contrast to e.g.
  xfs and btrfs FICLONE/FICLONERANGE ioctl() that is only concerned with
  the actual extents ocfs2 uses a separate ioctl() that also creates the
  target file.

  Iow, ocfs2 circumvents the vfs entirely here and did indeed rely on
  inode_init_owner() to strip the S_ISGID bit. This is the only place
  where a filesystem needs to call mode_strip_sgid() directly but this
  is self-inflicted pain tbh.

* spufs doesn't go through the vfs at all and doesn't use ioctl()s
  either. Instead it has a dedicated system call spufs_create() which
  allows the creation of filesystem objects. But spufs only creates
  directories and doesn't allo S_SIGID bits, i.e. it specifically only
  allows 0777 bits.

* bpf uses vfs_mkobj() but also doesn't allow S_ISGID bits to be created.

While we did our best to audit everything there's a risk of regressions
in here. However, for the sake of maintenance and given that we've seen
a range of bugs years after S_ISGID inheritance issues were fixed (see
[1]-[3]) the risk seems worth taking. In the worst case we will have to
revert.

Associated with this change is a new set of fstests to enforce the
semantics for all new filesystems. 
