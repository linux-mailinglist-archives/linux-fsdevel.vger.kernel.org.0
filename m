Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D626A2713
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 04:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjBYDrB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 22:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBYDq7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 22:46:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E8112BD6;
        Fri, 24 Feb 2023 19:46:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73EFE619D0;
        Sat, 25 Feb 2023 03:46:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33A4C433EF;
        Sat, 25 Feb 2023 03:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677296817;
        bh=CUHOybQU38pk0lNS1OZNmiGplH+lI7kqezGUA4FWD44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aUnd0xkcZ4zE/zSa1D2LrQsj1v0rqfUOJcyLeDyW6L4WLOep84Fi0/am3pRPOCp2D
         Bn6+RNVHOFt/hqOI1CZijtGewRSzOopWFr1PY6tU40p09CpEawyLczZmlfm9vNBH8p
         O7iDcX4bRXZbHgIat80L51Z7UaAKLf3z8fFbfZ7wnNmJdljJzbpqy1UznLGMFzaWA2
         cAgowGRQgbn7FN7LB5lF4boFR58Ss+21FkqcBvK8wYY+pA5j0LRu7QvBaIt9/m0dzN
         tVhd3+Q2k4MnWVcUv8aGv2wNoTyGTP3dRC2QaYndUFhUl3Fj9ysXWRwu/vDQRxJNuB
         +LmLQ58smySAg==
Date:   Fri, 24 Feb 2023 19:46:57 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Ted Tso <tytso@mit.edu>, linux-xfs@vger.kernel.org
Subject: Re: Locking issue with directory renames
Message-ID: <Y/mEsfyhNCs8orCY@magnolia>
References: <20230117123735.un7wbamlbdihninm@quack3>
 <20230117214457.GG360264@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117214457.GG360264@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 18, 2023 at 08:44:57AM +1100, Dave Chinner wrote:
> On Tue, Jan 17, 2023 at 01:37:35PM +0100, Jan Kara wrote:
> > Hello!
> > 
> > I've some across an interesting issue that was spotted by syzbot [1]. The
> > report is against UDF but AFAICS the problem exists for ext4 as well and
> > possibly other filesystems. The problem is the following: When we are
> > renaming directory 'dir' say rename("foo/dir", "bar/") we lock 'foo' and
> > 'bar' but 'dir' is unlocked because the locking done by vfs_rename() is
> > 
> >         if (!is_dir || (flags & RENAME_EXCHANGE))
> >                 lock_two_nondirectories(source, target);
> >         else if (target)
> >                 inode_lock(target);
> > 
> > However some filesystems (e.g. UDF but ext4 as well, I suspect XFS may be
> > hurt by this as well because it converts among multiple dir formats) need
> > to update parent pointer in 'dir' and nothing protects this update against
> > a race with someone else modifying 'dir'. Now this is mostly harmless
> > because the parent pointer (".." directory entry) is at the beginning of
> > the directory and stable however if for example the directory is converted
> > from packed "in-inode" format to "expanded" format as a result of
> > concurrent operation on 'dir', the filesystem gets corrupted (or crashes as
> > in case of UDF).
> 
> No, xfs_rename() does not have this problem - we pass four inodes to
> the function - the source directory, source inode, destination
> directory and destination inode.

Um, I think it does have this problem.  xfs_readdir thinks it can parse
a shortform inode without taking the ILOCK:

	if (dp->i_df.if_format == XFS_DINODE_FMT_LOCAL)
		return xfs_dir2_sf_getdents(&args, ctx);

	lock_mode = xfs_ilock_data_map_shared(dp);
	error = xfs_dir2_isblock(&args, &isblock);

So xfs_dir2_sf_replace can rewrite the shortform structure (or even
convert it to block format!) while readdir is accessing it.  Or am I
mising something?

--D

> In the above case, "dir/" is passed to XFs as the source inode - the
> src_dir is "foo/", the target dir is "bar/" and the target inode is
> null. src_dir != target_dir, so we set the "new_parent" flag. the
> srouce inode is a directory, so we set the src_is_directory flag,
> too.
> 
> We lock all three inodes that are passed. We do various things, then
> run:
> 
>         if (new_parent && src_is_directory) {
>                 /*
>                  * Rewrite the ".." entry to point to the new
>                  * directory.
>                  */
>                 error = xfs_dir_replace(tp, src_ip, &xfs_name_dotdot,
>                                         target_dp->i_ino, spaceres);
>                 ASSERT(error != -EEXIST);
>                 if (error)
>                         goto out_trans_cancel;
>         }
> 
> which replaces the ".." entry in source inode atomically whilst it
> is locked.  Any directory format changes that occur during the
> rename are done while the ILOCK is held, so they appear atomic to
> outside observers that are trying to parse the directory structure
> (e.g. readdir).
> 
> > So we'd need to lock 'source' if it is a directory.
> 
> Yup, and XFS goes further by always locking the source inode in a
> rename, even if it is not a directory. This ensures the inode being
> moved cannot have it's metadata otherwise modified whilst the rename
> is in progress, even if that modification would have no impact on
> the rename. It's a pretty strict interpretation of "rename is an
> atomic operation", but it avoids accidentally missing nasty corner
> cases like the one described above...
> 
> > Ideally this would
> > happen in VFS as otherwise I bet a lot of filesystems will get this wrong
> > so could vfs_rename() lock 'source' if it is a dir as well? Essentially
> > this would amount to calling lock_two_nondirectories(source, target)
> > unconditionally but that would become a serious misnomer ;). Al, any
> > thought?
> 
> XFS just has a function that allows for an arbitrary number of
> inodes to be locked in the given order: xfs_lock_inodes(). For
> rename, the lock order is determined by xfs_sort_for_rename().
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
