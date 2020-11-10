Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE8C2AD547
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbgKJLdD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:33:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:39686 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbgKJLdC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:33:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6EF73ABD1;
        Tue, 10 Nov 2020 11:33:00 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3F5D61E130B; Tue, 10 Nov 2020 12:33:00 +0100 (CET)
Date:   Tue, 10 Nov 2020 12:33:00 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        david@fromorbit.com, fdmanana@kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] vfs: remove lockdep bogosity in __sb_start_write
Message-ID: <20201110113300.GC20780@quack2.suse.cz>
References: <160494580419.772573.9286165021627298770.stgit@magnolia>
 <160494581071.772573.10466314698408344068.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160494581071.772573.10466314698408344068.stgit@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 09-11-20 10:16:50, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> __sb_start_write has some weird looking lockdep code that claims to
> exist to handle nested freeze locking requests from xfs.  The code as
> written seems broken -- if we think we hold a read lock on any of the
> higher freeze levels (e.g. we hold SB_FREEZE_WRITE and are trying to
> lock SB_FREEZE_PAGEFAULT), it converts a blocking lock attempt into a
> trylock.
> 
> However, it's not correct to downgrade a blocking lock attempt to a
> trylock unless the downgrading code or the callers are prepared to deal
> with that situation.  Neither __sb_start_write nor its callers handle
> this at all.  For example:
> 
> sb_start_pagefault ignores the return value completely, with the result
> that if xfs_filemap_fault loses a race with a different thread trying to
> fsfreeze, it will proceed without pagefault freeze protection (thereby
> breaking locking rules) and then unlocks the pagefault freeze lock that
> it doesn't own on its way out (thereby corrupting the lock state), which
> leads to a system hang shortly afterwards.
> 
> Normally, this won't happen because our ownership of a read lock on a
> higher freeze protection level blocks fsfreeze from grabbing a write
> lock on that higher level.  *However*, if lockdep is offline,
> lock_is_held_type unconditionally returns 1, which means that
> percpu_rwsem_is_held returns 1, which means that __sb_start_write
> unconditionally converts blocking freeze lock attempts into trylocks,
> even when we *don't* hold anything that would block a fsfreeze.
> 
> Apparently this all held together until 5.10-rc1, when bugs in lockdep
> caused lockdep to shut itself off early in an fstests run, and once
> fstests gets to the "race writes with freezer" tests, kaboom.  This
> might explain the long trail of vanishingly infrequent livelocks in
> fstests after lockdep goes offline that I've never been able to
> diagnose.
> 
> We could fix it by spinning on the trylock if wait==true, but AFAICT the
> locking works fine if lockdep is not built at all (and I didn't see any
> complaints running fstests overnight), so remove this snippet entirely.
> 
> NOTE: Commit f4b554af9931 in 2015 created the current weird logic (which
> used to exist in a different form in commit 5accdf82ba25c from 2012) in
> __sb_start_write.  XFS solved this whole problem in the late 2.6 era by
> creating a variant of transactions (XFS_TRANS_NO_WRITECOUNT) that don't
> grab intwrite freeze protection, thus making lockdep's solution
> unnecessary.  The commit claims that Dave Chinner explained that the
> trylock hack + comment could be removed, but nobody ever did.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks for cleaning this up. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c |   33 ++++-----------------------------
>  1 file changed, 4 insertions(+), 29 deletions(-)
> 
> 
> diff --git a/fs/super.c b/fs/super.c
> index a51c2083cd6b..e1fd667454d4 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1647,36 +1647,11 @@ EXPORT_SYMBOL(__sb_end_write);
>   */
>  int __sb_start_write(struct super_block *sb, int level, bool wait)
>  {
> -	bool force_trylock = false;
> -	int ret = 1;
> +	if (!wait)
> +		return percpu_down_read_trylock(sb->s_writers.rw_sem + level-1);
>  
> -#ifdef CONFIG_LOCKDEP
> -	/*
> -	 * We want lockdep to tell us about possible deadlocks with freezing
> -	 * but it's it bit tricky to properly instrument it. Getting a freeze
> -	 * protection works as getting a read lock but there are subtle
> -	 * problems. XFS for example gets freeze protection on internal level
> -	 * twice in some cases, which is OK only because we already hold a
> -	 * freeze protection also on higher level. Due to these cases we have
> -	 * to use wait == F (trylock mode) which must not fail.
> -	 */
> -	if (wait) {
> -		int i;
> -
> -		for (i = 0; i < level - 1; i++)
> -			if (percpu_rwsem_is_held(sb->s_writers.rw_sem + i)) {
> -				force_trylock = true;
> -				break;
> -			}
> -	}
> -#endif
> -	if (wait && !force_trylock)
> -		percpu_down_read(sb->s_writers.rw_sem + level-1);
> -	else
> -		ret = percpu_down_read_trylock(sb->s_writers.rw_sem + level-1);
> -
> -	WARN_ON(force_trylock && !ret);
> -	return ret;
> +	percpu_down_read(sb->s_writers.rw_sem + level-1);
> +	return 1;
>  }
>  EXPORT_SYMBOL(__sb_start_write);
>  
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
