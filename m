Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8199C7B489B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Oct 2023 18:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbjJAQ0U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Oct 2023 12:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbjJAQ0T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Oct 2023 12:26:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A70DA;
        Sun,  1 Oct 2023 09:26:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D21C433C7;
        Sun,  1 Oct 2023 16:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696177576;
        bh=tpF9oW6uXrI1uQ/czlwOjgaOwA8x2HCHKzxIse4EjMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UdLTnws8mSnvTDwVGT280xwupoG0AfxZLH1pa0DojU8fkfwyXSjkJI59OK4p78/xo
         XCFYOwVO6r3subXaNWimsQp7wrsapQsnoofKymQQ2N/Eo4Ucj6VXZx7N6nMj62QZDR
         PRA3c5vwIoLLqeWjqzx9df19gwomul0ZdboQtObtbtlefx5b1lbq1qhxDD/nwoM9iu
         9k5ScDN9Id7hxp/mYN2sue7teYGtIBvXUF/oSaiOmJkn+fEm3s2KKqZpyciP8InW2s
         cQZhXPGXEFKCYa6BRl4Q4VYob5KeHRYKQsqUJGpjiThS0C492zKUmn2Wv42cl2iq85
         tBbuhFR8+3PGg==
Date:   Sun, 1 Oct 2023 09:26:15 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: Removal of KM_NOFS
Message-ID: <20231001162615.GC21298@frogsfrogsfrogs>
References: <ZRdNK39vc4TuR7g8@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZRdNK39vc4TuR7g8@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 29, 2023 at 11:18:19PM +0100, Matthew Wilcox wrote:
> I had a long plane ride yesterday, and I started on "Removing GFP_NOFS".
> TLDR: I don't know enough about XFS to do this first step.  There are
> various options and none of them are "obviously" the right thing to do.
> 
> The overall intent is to get rid of the __GFP_FS flag entirely; make
> GFP_NOFS the same as GFP_KERNEL (and a later patch could rename all
> the uses of GFP_NOFS to GFP_KERNEL).  That is, the only way to prevent
> the memory allocator from entering fs reclaim would be by calling
> memalloc_nofs_save().
> 
> XFS already calls memalloc_nofs_save() when starting a transaction.
> This is almost certainly the right thing to do; many things which
> could be freed through fs reclaim would need to start a transaction,
> and we don't want to do a nested transaction.  But it turns out there
> are several places that can't enter fs reclaim for other reasons.
> 
> Having boldly just removed __GFP_FS, I encountered problems (ie
> lockdep got chatty) in XFS and now I don't think I know enough to
> take on the prerequisite project of removing KM_NOFS.  While this is
> obviously _possible_ (simply add calls to memalloc_nofs_save() and
> memalloc_nofs_restore() around calls currently marked as KM_NOFS),
> that's not really how the scoped API is supposed to be used.  Instead,
> one is supposed to improve the understandability of the code by marking
> the sections where, say, a lock is taken as now being unsafe to enter
> fs reclaim because that lock is held.
> 
> The first one I got a bug report from was generic/270.  We take
> dqp->q_qlock in fs reclaim, and there are code paths which take
> dqp->q_qlock, then allocate memory.  There's a rather nasty extra
> step where we take the dqp->q_qlock, then wait on a workqueue which is
> going to call xlog_cil_push_work() which does the memory allocation.
> Lockdep spots this transitive dependency, but we don't know to transfer
> the nofs setting from the caller to the workqueue.
> 
> OK, fine, just add the memalloc_nofs_save() at the beginning of
> xlog_cil_push_work() and restore it at the three exits; problem solved
> in a moderately hacky way; but it's better than before since the KM_NOFS
> calls are now safe to remove from the CIL machinery.  There are two ways
> to solve this properly; one is to transfer the nofs setting from caller
> to work queue, and also set the nofs setting whenever we take the dqlock.
> The other would be to trylock (and back out properly if held) if we're
> called in the reclaim path.  I don't know how hard that would be.
> 
> Skipping the second and third ones, the fourth one I've encountered
> looks like this: xfs_buf_get_map() is allocating memory.  call path:
> 
> kmem_alloc+0x6f/0x170
> xfs_buf_get_map+0x761/0x1140
> xfs_buf_read_map+0x38/0x250
> xfs_trans_read_buf_map+0x19c/0x520
> xfs_btree_read_buf_block.constprop.0+0x7a/0xb0
> xfs_btree_lookup_get_block+0x82/0x140
> xfs_btree_lookup+0xaf/0x490
> xfs_refcount_lookup_le+0x6a/0xd0
> xfs_refcount_find_shared+0x6c/0x420

5¢ reply: eventually we're going to have to wrap all of these
non-updating btree block accesses with an empty transaction to avoid
livelocking on cycles (intentional or otherwise).  That'll wrap
/everything/ in NOFS context, which will solve this problem at a cost of
more NOFS allocations...

> xfs_reflink_find_shared+0x67/0xa0
> xfs_reflink_trim_around_shared+0xd7/0x1a0
> xfs_bmap_trim_cow+0x3a/0x40
> xfs_buffered_write_iomap_begin+0x2ce/0xbf0
> 
> That potentially deadlocks against
> 
> -> #0 (&xfs_nondir_ilock_class#3){++++}-{3:3}:
>        __lock_acquire+0x148e/0x26d0
>        lock_acquire+0xb8/0x280
>        down_write_nested+0x3f/0xe0
>        xfs_ilock+0xe3/0x260
>        xfs_icwalk_ag+0x68c/0xa50
>        xfs_icwalk+0x3e/0xa0
>        xfs_reclaim_inodes_nr+0x7c/0xa0
>        xfs_fs_free_cached_objects+0x14/0x20
>        super_cache_scan+0x17d/0x1c0
>        do_shrink_slab+0x16a/0x680
>        shrink_slab+0x52a/0x8a0
>        shrink_node+0x308/0x7a0
>        balance_pgdat+0x28d/0x710
> 
> Annoyingly, lockdep doesn't tell me which acquisition of
> fs_nondir_ilock_class#3 the first backtrace did.
> 
> We could pop the nofs setting anywhere in this call chain, but _really_
> what we should be doing is calling memalloc_nofs_save() when we take
> the xfs_nondir_ilock_class#3.  But ... there are a lot of places we

...and since the ILOCK is taken after allocating a transaction, the
thread will already be in NOFS context.  No need to make the lock
debugging even more complicated...

> take the ilock, and it's kind of a big deal to add memalloc_nofs_save()
> calls to all of them.  And then I looked at _why_ we take the lock, and
> it's kind of stupid; we're just waiting for other callers to free it.
> ie xfs_reclaim_inode() does:
> 
>        if (!xfs_ilock_nowait(ip, XFS_ILOCK_EXCL))
>                 goto out;
> ...
>         xfs_iunlock(ip, XFS_ILOCK_EXCL);
> ...
>         if (!radix_tree_delete(&pag->pag_ici_root,
>                                 XFS_INO_TO_AGINO(ip->i_mount, ino)))
> ...
>         xfs_ilock(ip, XFS_ILOCK_EXCL);
> 
> ie we did the trylock, and it succeeded.  We know we don't have the
> lock in process context.  It feels like we could legitimately use
> xfs_lock_inumorder() to use a different locking class to do this wait.
> 
> 
> But all of this has shown me how complex this project is.  I have

...and wrapping everything in transactions isn't a simple project
either.  Every btree cursor allocation would now require the caller to
supply a transaction.  Worse are are things like xfs_bmapi_read that
lack the tp argument but can call xfs_iread_extents, and whatever mess
is going on in the dquot alloc paths.

I tried prototyping this and realized that it's more work than I thought
it would be. :/

--D

> no desire to send patches for review that are "obviously wrong" (to
> someone with more extensive knowledge of XFS) and just suck up reviewer
> bandwidth for a cleanup that is, perhaps, of limited value.  If someone
> more junior wants to take this on as a project to learn more about XFS,
> I'll happily help where I can, but I think my time is perhaps better
> spent on other projects for now.
