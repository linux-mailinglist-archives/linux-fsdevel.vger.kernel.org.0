Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1421070FE47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 21:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjEXTKn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 15:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjEXTKh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 15:10:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B963112B;
        Wed, 24 May 2023 12:10:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C274636F7;
        Wed, 24 May 2023 19:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99225C433EF;
        Wed, 24 May 2023 19:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684955435;
        bh=fTe90SBB1Dp6tpx8x5Iius6PN2gYrB9jIEHyvHJNqnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RrA80m0BkDIuSGz9TeGt0G8cK5qIMKRWR7+N9PsOjAOCcC+h6M22Xc/ie1ExjQCPu
         J3ZDIcsMp3QfV2x1NYt2T/ADxnpZiy/gzpQQ4aBGeCoiGlbXuwIA+cL+sOq5NzrMg+
         1HDwbBinE8Meqoc7Dj3uj/Fr0U2b6xcsf128zLhwgF1JLWC08kPZZ88BpqLCcabKIg
         6jPuoatYoY0COiDCXMky7FXgfIhgHNvxYWcVH4ZjDW2wmrhQYfBFle1OIkeVfCT4w7
         g+8ZbqhPME3lwXAUf/zOngoorulwA57DTM35XWRJ4gU9LzprNVo0J+/vjK7c1s908t
         AYsbHD2TbxbBQ==
Date:   Wed, 24 May 2023 12:10:34 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, Ted Tso <tytso@mit.edu>,
        Amir Goldstein <amir73il@gmail.com>,
        'David Laight <David.Laight@aculab.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: Locking for RENAME_EXCHANGE
Message-ID: <20230524191034.GI11620@frogsfrogsfrogs>
References: <20230524163504.lugqgz2ibe5vdom2@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524163504.lugqgz2ibe5vdom2@quack3>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 24, 2023 at 06:35:04PM +0200, Jan Kara wrote:
> Hello!
> 
> This is again about the problem with directory renames I've already
> reported in [1]. To quickly sum it up some filesystems (so far we know at
> least about xfs, ext4, udf, reiserfs) need to lock the directory when it is
> being renamed into another directory. This is because we need to update the
> parent pointer in the directory in that case and if that races with other
> operation on the directory, bad things can happen.
> 
> So far we've done the locking in the filesystem code but recently Darrick
> pointed out [2] that we've missed the RENAME_EXCHANGE case in our ext4 fix.
> That one is particularly nasty because RENAME_EXCHANGE can arbitrarily mix
> regular files and directories. Couple nasty arising cases:
> 
> 1) We need to additionally lock two exchanged directories. Suppose a
> situation like:
> 
> mkdir P; mkdir P/A; mkdir P/B; touch P/B/F
> 
> CPU1						CPU2
> renameat2("P/A", "P/B", RENAME_EXCHANGE);	renameat2("P/B/F", "P/A", 0);
> 
> Both operations need to lock A and B directories which are unrelated in the
> tree. This means we must establish stable lock ordering on directory locks
> even for the case when they are not in ancestor relationship.
> 
> 2) We may need to lock a directory and a non-directory and they can be in
> parent-child relationship when hardlinks are involved:
> 
> mkdir A; mkdir B; touch A/F; ln A/F B/F
> renameat2("A/F", "B");
> 
> And this is really nasty because we don't have a way to find out whether
> "A/F" and "B" are in any relationship - in particular whether B happens to
> be another parent of A/F or not.
> 
> What I've decided to do is to make sure we always lock directory first in
> this mixed case and that *should* avoid all the deadlocks but I'm spelling
> this out here just in case people can think of some even more wicked case
> before I'll send patches.

I can think of a few things:

Not taking i_rwsem when updating the dotdot entry as part of moving
child directories means that readdir can race with a dotdot update to a
shortformat XFS directory.  That currently doesn't get too ugly because
we reserve a full 8 bytes for the shortform dotdot entry's inode (which
means we are not at risk of changing the format).  As Dave has
previously noted, xfs synchronizes on the ILOCK for metadata updates.

This also makes online directory fsck harder because any time we have to
cycle the directory's ILOCK means we have to revalidate the directory
contents afterwards or hook the directory update code so that we can
learn about changes that happened while the ILOCK was dropped.

(I'm sure the rest of you are thinking "that's some crazy xfs thing").

Things get weirder with the new xfs parent pointers feature -- rename
doesn't take i_rwsem of the children, which means that the only
synchronization point is with the ILOCK held.  Parent pointers are
stored in a special xattr namespace.  This makes me nervous about
collisions with a getxattr call, since those can be done with or without
i_rwsem held at all.  I think the ILOCK saves us in this case, since
I've been testing it for a few months now without any corruption
problems.

Obviously, online fsck of parent pointers has to employ the same
revalidate/hook to deal with ILOCK cycling.  But again, that's "some
crazy xfs thing".

I wouldn't mind the VFS taking i_rwsem on the children to simplify
online fsck, but I've got a reasonable enough workaround.

--D

> Also I wanted to ask (Miklos in particular as RENAME_EXCHANGE author): Why
> do we lock non-directories in RENAME_EXCHANGE case? If we didn't have to do
> that things would be somewhat simpler...
> 
> 								Honza
> 
> [1] https://lore.kernel.org/all/20230117123735.un7wbamlbdihninm@quack3
> [2] https://lore.kernel.org/all/20230517045836.GA11594@frogsfrogsfrogs
> 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
