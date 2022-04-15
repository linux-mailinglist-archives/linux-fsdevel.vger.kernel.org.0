Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E12502B68
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 16:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354228AbiDOOEp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 10:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353501AbiDOOEp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 10:04:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11AFB714B;
        Fri, 15 Apr 2022 07:02:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 958E062090;
        Fri, 15 Apr 2022 14:02:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9C7C385A6;
        Fri, 15 Apr 2022 14:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650031335;
        bh=wJSxaokhZlkrlnlGPf4LZXJyTMf3UmLgWFQYkt+d2s8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H3D2AZovkkFm96bkc+W1tIlrJUbkHAuUPFs7gS9JW4KaUFhpLpf5S+ShcNb9ISbaA
         MfE/jKdv4Q8pzR05pbfWom+p5C5lOnPGNE5dmLWk7U66CeEOB+C5Gl+JqWXgYEZDmH
         UhWxA1oOGltMGyTbVclMZqiipTh7If25pvJU+kHUfU41oXN6Lz1fuWOsYKnRPzFfJw
         nKuYCbS/cdMku5ZwLX9Nr31j2/nhZx6t6wzH3yJogbJ3PldwgSqQtxWFOagM3AGjhD
         /Ym1Lhf+6QLht3oBYc0wNzuy/SJpDLBtYblqBHC0rNduyH3Bt5JN9BznqMqOWKzhh0
         P06Q31q5hY2SQ==
Date:   Fri, 15 Apr 2022 16:02:09 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Cc:     "djwong@kernel.org" <djwong@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH v2 2/3] vfs: strip file's S_ISGID mode on vfs instead of
 on underlying filesystem
Message-ID: <20220415140209.a56t6wuyjper2a3z@wittgenstein>
References: <1649923039-2273-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1649923039-2273-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220414124552.4uf3hpopqa4xlwrd@wittgenstein>
 <6258F17C.7010705@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6258F17C.7010705@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 15, 2022 at 03:14:53AM +0000, xuyang2018.jy@fujitsu.com wrote:
> on 2022/4/14 20:45, Christian Brauner wrote:
> > On Thu, Apr 14, 2022 at 03:57:18PM +0800, Yang Xu wrote:
> >> Currently, vfs only passes mode argument to filesystem, then use inode_init_owner()
> >> to strip S_ISGID. Some filesystem(ie ext4/btrfs) will call inode_init_owner
> >> firstly, then posxi acl setup, but xfs uses the contrary order. It will affect
> >> S_ISGID clear especially we filter S_IXGRP by umask or acl.
> >>
> >> Regardless of which filesystem is in use, failure to strip the SGID correctly is
> >> considered a security failure that needs to be fixed. The current VFS infrastructure
> >> requires the filesystem to do everything right and not step on any landmines to
> >> strip the SGID bit, when in fact it can easily be done at the VFS and the filesystems
> >> then don't even need to be aware that the SGID needs to be (or has been stripped) by
> >> the operation the user asked to be done.
> >>
> >> Vfs has all the info it needs - it doesn't need the filesystems to do everything
> >> correctly with the mode and ensuring that they order things like posix acl setup
> >> functions correctly with inode_init_owner() to strip the SGID bit.
> >>
> >> Just strip the SGID bit at the VFS, and then the filesystems can't get it wrong.
> >>
> >> Also, the inode_sgid_strip() api should be used before IS_POSIXACL() because
> >> this api may change mode.
> >>
> >> Only the following places use inode_init_owner
> >> "hugetlbfs/inode.c:846:          inode_init_owner(&init_user_ns, inode, dir, mode);
> >>   nilfs2/inode.c:354:     inode_init_owner(&init_user_ns, inode, dir, mode);
> >>   zonefs/super.c:1289:    inode_init_owner(&init_user_ns, inode, parent, S_IFDIR | 0555);
> >>   reiserfs/namei.c:619:   inode_init_owner(&init_user_ns, inode, dir, mode);
> >>   jfs/jfs_inode.c:67:     inode_init_owner(&init_user_ns, inode, parent, mode);
> >>   f2fs/namei.c:50:        inode_init_owner(mnt_userns, inode, dir, mode);
> >>   ext2/ialloc.c:549:              inode_init_owner(&init_user_ns, inode, dir, mode);
> >>   overlayfs/dir.c:643:    inode_init_owner(&init_user_ns, inode, dentry->d_parent->d_inode, mode);
> >>   ufs/ialloc.c:292:       inode_init_owner(&init_user_ns, inode, dir, mode);
> >>   ntfs3/inode.c:1283:     inode_init_owner(mnt_userns, inode, dir, mode);
> >>   ramfs/inode.c:64:               inode_init_owner(&init_user_ns, inode, dir, mode);
> >>   9p/vfs_inode.c:263:     inode_init_owner(&init_user_ns, inode, NULL, mode);
> >>   btrfs/tests/btrfs-tests.c:65:   inode_init_owner(&init_user_ns, inode, NULL, S_IFREG);
> >>   btrfs/inode.c:6215:     inode_init_owner(mnt_userns, inode, dir, mode);
> >>   sysv/ialloc.c:166:      inode_init_owner(&init_user_ns, inode, dir, mode);
> >>   omfs/inode.c:51:        inode_init_owner(&init_user_ns, inode, NULL, mode);
> >>   ubifs/dir.c:97: inode_init_owner(&init_user_ns, inode, dir, mode);
> >>   udf/ialloc.c:108:       inode_init_owner(&init_user_ns, inode, dir, mode);
> >>   ext4/ialloc.c:979:              inode_init_owner(mnt_userns, inode, dir, mode);
> >>   hfsplus/inode.c:393:    inode_init_owner(&init_user_ns, inode, dir, mode);
> >>   xfs/xfs_inode.c:840:            inode_init_owner(mnt_userns, inode, dir, mode);
> >>   ocfs2/dlmfs/dlmfs.c:331:                inode_init_owner(&init_user_ns, inode, NULL, mode);
> >>   ocfs2/dlmfs/dlmfs.c:354:        inode_init_owner(&init_user_ns, inode, parent, mode);
> >>   ocfs2/namei.c:200:      inode_init_owner(&init_user_ns, inode, dir, mode);
> >>   minix/bitmap.c:255:     inode_init_owner(&init_user_ns, inode, dir, mode);
> >>   bfs/dir.c:99:   inode_init_owner(&init_user_ns, inode, dir, mode);
> >> "
> >
> > For completeness sake, there's also spufs which doesn't really go
> > through the regular VFS callpath because it has separate system calls
> > like:
> >
> > SYSCALL_DEFINE4(spu_create, const char __user *, name, unsigned int, flags,
> > 	umode_t, mode, int, neighbor_fd)
> >
> > but looking through the code it only allows the creation of directories and only
> > allows bits in 0777.
> IMO, this fs also doesn't use inode_init_owner, so it should be not 
> affected. We add indo_sgid_strip into vfs, IMO, it only happen new sgid 
> strip situation and doesn't happen to remove old sgid strip situation.
> So I think it is "safe".

It does. The callchain spu_create() with SP_CREATE_GANG ends up in
spufs_mkgang() which calls inode_init_owner(). But as I said it's not a
problem since this only creates directories anyway.

