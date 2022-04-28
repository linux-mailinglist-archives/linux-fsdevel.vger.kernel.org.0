Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D600E512EEA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 10:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344368AbiD1Ium (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Apr 2022 04:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344201AbiD1Iti (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:49:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D017C62;
        Thu, 28 Apr 2022 01:45:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8F0661FD6;
        Thu, 28 Apr 2022 08:45:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C045C385A9;
        Thu, 28 Apr 2022 08:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651135500;
        bh=yyDp8urVCOgVB+2vQLLKEIro9zJW8bpD/9wO44nvgwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t0Y+aswgN6GwdwquieLWXEAmULewfTsycmmeUMMjUNW+8tagdBalS4bDr7wBB1nr6
         ihxFG6GUHOilmGLyOR5V75WGJs+3OLodZGTgEAYSjL3N8xwxPvWMlY3SETjmvOyPm4
         LDl1utMHpcj+LIfZAVEdpMoUDZf2tH5mE9vyZ5NaZcSxLoicsVMoABo5zvzmzZcCut
         8XsD3zzO1NQ5o2I0fhk2R1LqspbuhQFdpWJxOhIKDLrR0PQtBczgdNlkBTCGAx8TQz
         KB2djhnCe9OcddXowB7NsdLwZLpT7vyNbo4PBfAsLgZKmpm7I7G9rrn0ON7E6n8DYW
         V9sL5kPmmKPYg==
Date:   Thu, 28 Apr 2022 10:44:54 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v8 1/4] fs: add mode_strip_sgid() helper
Message-ID: <20220428084454.il3gooakfnnsq2di@wittgenstein>
References: <1650971490-4532-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <Ymn05eNgOnaYy36R@zeniv-ca.linux.org.uk>
 <Ymn4xPXXWe4LFhPZ@zeniv-ca.linux.org.uk>
 <626A08DA.3060802@fujitsu.com>
 <YmoAp+yWBpH5T8rt@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YmoAp+yWBpH5T8rt@zeniv-ca.linux.org.uk>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 28, 2022 at 02:49:11AM +0000, Al Viro wrote:
> On Thu, Apr 28, 2022 at 02:23:25AM +0000, xuyang2018.jy@fujitsu.com wrote:
> 
> > > BTW, xfs has grpid option as well:
> > > 	if (dir&&  !(dir->i_mode&  S_ISGID)&&  xfs_has_grpid(mp)) {
> > > 		inode_fsuid_set(inode, mnt_userns);
> > > 		inode->i_gid = dir->i_gid;
> > > 		inode->i_mode = mode;
> > > 	} else {
> > > 		inode_init_owner(mnt_userns, inode, dir, mode);
> > > 	}
> > >
> > > We could lift that stuff into VFS, but it would require lifting that flag
> > > (BSD vs. SysV behaviour wrt GID - BSD *always* inherits GID from parent
> > > and ignores SGID on directories) into generic superblock.  Otherwise we'd
> > > be breaking existing behaviour for ext* and xfs...
> > 
> > I also mentioned it in my previous version(in the 3/4 patch)
> > "This patch also changed grpid behaviour for ext4/xfs because the mode 
> > passed to them may been changed by vfs_prepare_mode.
> > "
> > 
> > I guess we can add a  grpid option check in vfs_prepare_mode or in 
> > mode_strip_sgid, then it should not break the existing behaviour for 
> > ext* and xfs.
> 
> I don't like it, TBH.  That way we have
> 	1) caller mangles mode (after having looked at grpid, etc.)
> 	2) filesystem checks grpid and either calls inode_init_owner(),
> which might (or might not) modify the gid to be used or skips the
> call and assigns gid directly.
> 
> It's asking for trouble.  We have two places where the predicate is
> checked; the first mangles mode (and I'm still not convinced that we
> need to bother with that at all), the second affects gid (and for
> mkdir in sgid directory on non-grpid ones inherits sgid).
> 
> That kind of structure is asking for trouble.  *IF* we make inode_init_owner()
> aware of grpid (and make that predicate usable from generic helper), we might
> as well just make inode_init_owner() mandatory (for the first time ever) and
> get rid of grpid checks in filesystems themselves.  But then there's no point
> doing it in method callers.

This has ordering issues. In the vfs the umask is stripped and then we
call into the filesystem and inode_init_owner() is called. So if
S_IXGRP is removed by the umask then we inherit the S_ISGID bit.

But if the filesystem uses POSIX ACLs then the umask isn't stripped in
the vfs and instead may be done (I say "may" because it depends on
whether or not applicable POSIX ACLs are found) in posix_acl_create().

But in order to call posix_acl_create() the filesystem will have often
ran through inode_init_owner() first. For example, ext4 does
inode_init_owner() and afterwards calls ext4_init_acl() which in turn
ends up calling posix_acl_create() which _may_ strip the umask.

Iow, you end up with two possible setgid removal paths:
* strip setgid first, apply umask (no POSIX ACLs supported)
* apply umask, strip setgid (POSIX ACLs supported)
with possibly different results.

Mandating inode_init_owner() being used doesn't solve that and I think
it's still brittle overall.

If we can hoist all of this into vfs_*() before we call into the
filesystem we're better off in the long run. It's worth the imho
negible regression risk. 

> 
> Note, BTW, that while XFS has inode_fsuid_set() on the non-inode_init_owner()
> path, it doesn't have inode_fsgid_set() there.  Same goes for ext4, while
> ext2 doesn't bother with either in such case...

Using inode_fs*id_set() is only relevant when the inode is initialized
based on the caller's fs*id. If you request to inherit the parent
directories gid then the caller's gid doesn't matter.

ext2 doesn't need to care at all about this because it doesn't raise
FS_ALLOW_IDMAP.

> 
> Let's try to separate the issues here.  Jann, could you explain what makes
> empty sgid files dangerous?

I see that's answered in a later mail.
