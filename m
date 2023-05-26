Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12A0712A14
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 17:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244177AbjEZP6X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 11:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244268AbjEZP6Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 11:58:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B08D13D;
        Fri, 26 May 2023 08:58:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED4F36511C;
        Fri, 26 May 2023 15:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD836C433EF;
        Fri, 26 May 2023 15:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685116694;
        bh=gvQZFNx4XS2KmvTv6kEkw3b4TW68Vp+DGN0cJs/f/d8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZpiPTT6Uyl0UVGrEUkODKtD5emNa+RiT889sfyclqfClYRPune8owX39t7hr3NpaE
         kJZmfjMmntqPmr4K9SjBOBd+ISOzqbxZrrU7Mbv7g6sObkv5tHecx+IWkjqedSJ+PK
         RYQJddgIw9UFpjyS64nY7D05HRNUnBVVp/oWmWTQQbSm76bSNCDbbvDdadff0+mjhz
         10ZxD7u/xVbrGeP9ZxAlxTiGrj84qTqtCGzxh9n75kOQkr5H69s5PKNk2mq1uew7DQ
         ff6NeUgcpd9HEwEq+zG0blr+9kgQAKqTynM4RfSeixhg1O+u0juyH0g+d9DjQWGzXs
         Zno018bMTs6+w==
Date:   Fri, 26 May 2023 17:58:08 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>, Ted Tso <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 0/6] fs: Fix directory corruption when moving directories
Message-ID: <20230526-schrebergarten-vortag-9cd89694517e@brauner>
References: <20230525100654.15069-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230525100654.15069-1-jack@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 25, 2023 at 12:16:06PM +0200, Jan Kara wrote:
> Hello,
> 
> this patch set fixes a problem with cross directory renames originally reported
> in [1]. To quickly sum it up some filesystems (so far we know at least about
> ext4, udf, f2fs, ocfs2, likely also reiserfs, gfs2 and others) need to lock the
> directory when it is being renamed into another directory. This is because we
> need to update the parent pointer in the directory in that case and if that
> races with other operation on the directory (in particular a conversion from
> one directory format into another), bad things can happen.
> 
> So far we've done the locking in the filesystem code but recently Darrick
> pointed out [2] that we've missed the RENAME_EXCHANGE case in our ext4 fix.
> That one is particularly nasty because RENAME_EXCHANGE can arbitrarily mix
> regular files and directories and proper lock ordering is not achievable in the
> filesystems alone.
> 
> This patch set adds locking into vfs_rename() so that not only parent
> directories but also moved inodes (regardless whether they are directories or
> not) are locked when calling into the filesystem.

This locking is trauma inducing.

So I was staring at this for a long time and the thing that bothered me
big time was that I couldn't easily figure out how we ended up with the
locking scheme that we have. So I went digging. Corrections and
additions very welcome...

Before 914a6e0ea12 ("Import 2.3.51pre1") locking for rename was based on
s_vfs_rename_sem and i_sem. For both within- and across-directory
renames s_vfs_rename_sem was acquired and the i_sem on the parent
directories was acquired but the target wasn't locked.

Then 914a6e0ea12 ("Import 2.3.51pre1") introduced an additional i_zombie
semaphore to protect against create, link, mknod, mkdir, unlink, and
rmdir on the target. So i_zombie had to be acquired during
vfs_rename_dir() on both parent and the victim but only if the source
was a directory. Back then RENAME_EXCHANGE didn't exist so if source was
a directory then target if it existed must've been a directory as well.

The original reasoning behind only locking the target if the source was
a directory was based on some filesystems not being able to deal with
opened but unlinked directories.

The i_zombie finally died in 1b3d7c93c6d ("[PATCH] (2.5.4) death of
->i_zombie") and a new locking scheme was introduced. The
s_vfs_rename_sem was now only used for across-directory renames. Instead
of having i_zombie and i_sem only i_sem was left. Now, both
vfs_rename_dir(/* if renaming directory */) and vfs_rename_other()
grabbed i_sem on both parents and on the target. So now the target was
always explicitly protected against a concurrent unlink or rmdir
as that would be done as part of the rename operation and that race
would just been awkward to allow afaict. Probably always was.

The locking of source however is a different story. This was introduced
in 6cedba8962f4 ("vfs: take i_mutex on renamed file") to prevent new
delegations from being acquired during rename, link, or unlink. So now
both source and target were locked. The target seemingly because it
would be unlinked in the filesystem's rename method and the source to
prevent new delegations from being acquired. So, since leases can only
be taken on regular files vfs_setlease()/generic_setlease() directories
were never considered for locking. So the lock never had to be acquired
for source directories.

So in any case, under the assumption that the broad strokes are correct
there seems to be no inherent reason why locking source and target if
they're directories couldn't be done if the ordering is well-defined.
Which is what originally made me hesitate. IOW, given my current
knowledge this seems ok.

Frankly, if we end up unconditionally locking source and target we're in
a better place from a pure maintainability perspective as far as I'm
concerned. Even if we end up taking the lock pointlessly for e.g., NFS
with RENAME_EXCHANGE. The last thing we need is more conditions on when
things are locked and why.

/me goes off into the weekend
