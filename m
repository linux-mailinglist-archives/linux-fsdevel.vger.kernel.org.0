Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B911E082A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 May 2020 09:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389176AbgEYHpO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 May 2020 03:45:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:38182 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389105AbgEYHpO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 May 2020 03:45:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A4B95ABEC;
        Mon, 25 May 2020 07:45:14 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E45311E1270; Mon, 25 May 2020 09:38:35 +0200 (CEST)
Date:   Mon, 25 May 2020 09:38:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Martijn Coenen <maco@android.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, miklos@szeredi.hu, tj@kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        android-storage-core@google.com, kernel-team@android.com
Subject: Re: Writeback bug causing writeback stalls
Message-ID: <20200525073835.GJ14199@quack2.suse.cz>
References: <CAB0TPYGCOZmixbzrV80132X=V5TcyQwD6V7x-8PKg_BqCva8Og@mail.gmail.com>
 <20200524140522.14196-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524140522.14196-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 24-05-20 22:05:22, Hillf Danton wrote:
> 
> On Fri, 22 May 2020 11:57:42 +0200 Martijn Coenen wrote:
> > 
> > So, the sequence of events is something like this. Let's assume the inode is
> > already on b_dirty_time for valid reasons. Then:
> > 
> > CPU1                                          CPU2
> > fuse_flush()
> >   write_inode_now()
> >     writeback_single_inode()
> >       sets I_SYNC
> >         __writeback_single_inode()
> >           writes back data
> >           clears inode dirty flags
> >           unlocks inode
> >           calls mark_inode_dirty_sync()
> >             sets I_DIRTY_SYNC, but doesn't
> >             update wb list because I_SYNC is
> >             still set
> >                                               write() // somebody else writes
> >                                               mark_inode_dirty(I_DIRTY_PAGES)
> >                                               sets I_DIRTY_PAGES on i_state
> >                                               doesn't update wb list,
> >                                               because I_SYNC set
> >       locks inode again
> >       sees inode is still dirty,
> >       doesn't touch WB list
> >       clears I_SYNC
> > 
> > So now we have an inode on b_dirty_time with I_DIRTY_PAGES | I_DIRTY_SYNC set,
> > and subsequent calls to mark_inode_dirty() with either I_DIRTY_PAGES or
> > I_DIRTY_SYNC will do nothing to change that. The flusher won't touch
> > the inode either, because it's not on a b_dirty or b_io list.

Hi Hillf,

> Based on the above analysis, check of I_DIRTY_TIME is added before and
> after calling __writeback_single_inode() to detect the case you reported.
> 
> If a dirty inode is not on the right io list after writeback, we can
> move it to a new one; and we can do that as we are the I_SYNC owner.
> 
> While changing its io list, the inode's dirty timestamp is also updated
> to the current tick as does in __mark_inode_dirty().

Apparently you didn't read my reply to Martinj because what you did in this
patch is exactly what I described that we cannot do because that can cause
sync(2) to miss inodes and thus break its data integrity guarantees. So we
have to come up with a different solution.

								Honza

> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1528,6 +1528,7 @@ static int writeback_single_inode(struct
>  				  struct writeback_control *wbc)
>  {
>  	struct bdi_writeback *wb;
> +	bool dt;
>  	int ret = 0;
>  
>  	spin_lock(&inode->i_lock);
> @@ -1560,6 +1561,7 @@ static int writeback_single_inode(struct
>  	     !mapping_tagged(inode->i_mapping, PAGECACHE_TAG_WRITEBACK)))
>  		goto out;
>  	inode->i_state |= I_SYNC;
> +	dt = inode->i_state & I_DIRTY_TIME;
>  	wbc_attach_and_unlock_inode(wbc, inode);
>  
>  	ret = __writeback_single_inode(inode, wbc);
> @@ -1574,6 +1576,14 @@ static int writeback_single_inode(struct
>  	 */
>  	if (!(inode->i_state & I_DIRTY_ALL))
>  		inode_io_list_del_locked(inode, wb);
> +	else if (!(inode->i_state & I_DIRTY_TIME) && dt) {
> +		/*
> +		 * We can correct inode's io list, however, by moving it to
> +		 * b_dirty from b_dirty_time as we are the I_SYNC owner
> +		 */
> +		inode->dirtied_when = jiffies;
> +		inode_io_list_move_locked(inode, wb, &wb->b_dirty);
> +	}
>  	spin_unlock(&wb->list_lock);
>  	inode_sync_complete(inode);
>  out:
> --
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
