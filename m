Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B6B506FD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 16:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353038AbiDSOL6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 10:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbiDSOL4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:11:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2601939150;
        Tue, 19 Apr 2022 07:09:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9581B819B9;
        Tue, 19 Apr 2022 14:09:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F82C385A8;
        Tue, 19 Apr 2022 14:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650377350;
        bh=ehE0f+n6BW1o04+JVmVR3SUS0NOx6+AaaAJridegsTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qXsCj/Cs8DmBGHQyYiSqiVEAbepBjzRlZKZxNVmvrexWE4j6UVGOtBZDdJofYPojk
         B2gV83VdxCaYw4/qFM8pUYmZ6eZNG/odJZrNTzmweGf+gUJIo3NQEWQUZeyJskvFZ7
         6hmQLgHiJDNOWj5TzIYaJyRd+JJA7ujd6/PjDarlreo+FG/OFBumMH4yLVEqI9gxTR
         iJDrVdj1K5i8U7PfJ1BgpGkFNzgG+xvGOOHR+8qjt9MICSDq3VhKmBK031lDqaxIaR
         YcWG6xx26MmBeHCd0Ul7MLG18QGbQd/yuau267Hg9YEim6zcCcTHcx5qLPJqgOcQuc
         hlB8ZSrq6QsNw==
Date:   Tue, 19 Apr 2022 16:09:05 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        viro@zeniv.linux.org.uk, david@fromorbit.com, djwong@kernel.org,
        jlayton@kernel.org, ntfs3@lists.linux.dev, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v4 7/8] fs: strip file's S_ISGID mode on vfs instead of
 on underlying filesystem
Message-ID: <20220419140905.7pbfqrzmyczyhneh@wittgenstein>
References: <1650368834-2420-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1650368834-2420-7-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1650368834-2420-7-git-send-email-xuyang2018.jy@fujitsu.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 19, 2022 at 07:47:13PM +0800, Yang Xu wrote:
> Currently, vfs only passes mode argument to filesystem, then use inode_init_owner()
> to strip S_ISGID. Some filesystem(ie ext4/btrfs) will call inode_init_owner
> firstly, then posxi acl setup, but xfs uses the contrary order. It will affect
> S_ISGID clear especially we filter S_IXGRP by umask or acl.
> 
> Regardless of which filesystem is in use, failure to strip the SGID correctly is
> considered a security failure that needs to be fixed. The current VFS infrastructure
> requires the filesystem to do everything right and not step on any landmines to
> strip the SGID bit, when in fact it can easily be done at the VFS and the filesystems
> then don't even need to be aware that the SGID needs to be (or has been stripped) by
> the operation the user asked to be done.
> 
> Vfs has all the info it needs - it doesn't need the filesystems to do everything
> correctly with the mode and ensuring that they order things like posix acl setup
> functions correctly with inode_init_owner() to strip the SGID bit.
> 
> Just strip the SGID bit at the VFS, and then the filesystems can't get it wrong.
> 
> Also, the inode_sgid_strip() api should be used before IS_POSIXACL() because
> this api may change mode.
> 
> Only the following places use inode_init_owner
> "
> arch/powerpc/platforms/cell/spufs/inode.c:      inode_init_owner(&init_user_ns, inode, dir, mode | S_IFDIR);
> arch/powerpc/platforms/cell/spufs/inode.c:      inode_init_owner(&init_user_ns, inode, dir, mode | S_IFDIR);
> fs/9p/vfs_inode.c:      inode_init_owner(&init_user_ns, inode, NULL, mode);
> fs/bfs/dir.c:   inode_init_owner(&init_user_ns, inode, dir, mode);
> fs/btrfs/inode.c:       inode_init_owner(mnt_userns, inode, dir, mode);
> fs/btrfs/tests/btrfs-tests.c:   inode_init_owner(&init_user_ns, inode, NULL, S_IFREG);
> fs/ext2/ialloc.c:               inode_init_owner(&init_user_ns, inode, dir, mode);
> fs/ext4/ialloc.c:               inode_init_owner(mnt_userns, inode, dir, mode);
> fs/f2fs/namei.c:        inode_init_owner(mnt_userns, inode, dir, mode);
> fs/hfsplus/inode.c:     inode_init_owner(&init_user_ns, inode, dir, mode);
> fs/hugetlbfs/inode.c:           inode_init_owner(&init_user_ns, inode, dir, mode);
> fs/jfs/jfs_inode.c:     inode_init_owner(&init_user_ns, inode, parent, mode);
> fs/minix/bitmap.c:      inode_init_owner(&init_user_ns, inode, dir, mode);
> fs/nilfs2/inode.c:      inode_init_owner(&init_user_ns, inode, dir, mode);
> fs/ntfs3/inode.c:       inode_init_owner(mnt_userns, inode, dir, mode);
> fs/ocfs2/dlmfs/dlmfs.c:         inode_init_owner(&init_user_ns, inode, NULL, mode);
> fs/ocfs2/dlmfs/dlmfs.c: inode_init_owner(&init_user_ns, inode, parent, mode);
> fs/ocfs2/namei.c:       inode_init_owner(&init_user_ns, inode, dir, mode);
> fs/omfs/inode.c:        inode_init_owner(&init_user_ns, inode, NULL, mode);
> fs/overlayfs/dir.c:     inode_init_owner(&init_user_ns, inode, dentry->d_parent->d_inode, mode);
> fs/ramfs/inode.c:               inode_init_owner(&init_user_ns, inode, dir, mode);
> fs/reiserfs/namei.c:    inode_init_owner(&init_user_ns, inode, dir, mode);
> fs/sysv/ialloc.c:       inode_init_owner(&init_user_ns, inode, dir, mode);
> fs/ubifs/dir.c: inode_init_owner(&init_user_ns, inode, dir, mode);
> fs/udf/ialloc.c:        inode_init_owner(&init_user_ns, inode, dir, mode);
> fs/ufs/ialloc.c:        inode_init_owner(&init_user_ns, inode, dir, mode);
> fs/xfs/xfs_inode.c:             inode_init_owner(mnt_userns, inode, dir, mode);
> fs/zonefs/super.c:      inode_init_owner(&init_user_ns, inode, parent, S_IFDIR | 0555);
> kernel/bpf/inode.c:     inode_init_owner(&init_user_ns, inode, dir, mode);
> mm/shmem.c:             inode_init_owner(&init_user_ns, inode, dir, mode);
> "
> 
> They are used in filesystem init new inode function and these init inode functions are used
> by following operations:
> mkdir
> symlink
> mknod
> create
> tmpfile
> rename
> 
> We don't care about mkdir because we don't strip SGID bit for directory except fs.xfs.irix_sgid_inherit.
> But we even call it in do_mkdirat() since inode_sgid_strip() will skip directories anyway. This will
> enforce the same ordering for all relevant operations and it will make the code more uniform and
> easier to understand by using new helper prepare_mode().
> 
> symlink and rename only use valid mode that doesn't have SGID bit.
> 
> We have added inode_sgid_strip api for the remaining operations.
> 
> In addition to the above six operations, four filesystems has a little difference
> 1) btrfs has btrfs_create_subvol_root to create new inode but used non SGID bit mode and can ignore
> 2) ocfs2 reflink function should add inode_sgid_strip api manually because we don't add it in vfs
> 3) spufs which doesn't really go hrough the regular VFS callpath because it has separate system call
> spu_create, but it t only allows the creation of directories and only allows bits in 0777 and can ignore
> 4)bpf use vfs_mkobj in bpf_obj_do_pin with "S_IFREG | ((S_IRUSR | S_IWUSR) & ~current_umask()) mode and
> use bpf_mkobj_ops in bpf_iter_link_pin_kernel with S_IFREG | S_IRUSR; , so bpf is also not affected
> 
> This patch also changed grpid behaviour for ext4/xfs because the mode passed to them may been
> changed by inode_sgid_strip.
> 
> Also as Christian Brauner said"
> The patch itself is useful as it would move a security sensitive operation that is currently burried in
> individual filesystems into the vfs layer. But it has a decent regression  potential since it might strip
> filesystems that have so far relied on getting the S_ISGID bit with a mode argument. So this needs a lot
> of testing and long exposure in -next for at least one full kernel cycle."
> 
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

I think we're getting closer but please focus the patch series. This has
morphed into an 8 patch series where 4 or 5 of these patches are fixes
that a) I'm not sure are worth it or fix anything b) they are filesystem
specific and can be independently upstreamed and c) have nothing to do
with the core of this patch series.

So I'd suggest you'd just make this about sgid stripping and then this
doesn't have to be more than 3 maybe 4 patches, imho.
