Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6FF1BA0BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 12:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgD0KF1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 06:05:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:54008 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgD0KF1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 06:05:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 656DFABCE;
        Mon, 27 Apr 2020 10:05:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7B3241E129C; Mon, 27 Apr 2020 12:05:24 +0200 (CEST)
Date:   Mon, 27 Apr 2020 12:05:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Eric Sandeen <sandeen@sandeen.net>
Subject: Re: [PATCH 1/3] fs: Avoid leaving freed inode on dirty list
Message-ID: <20200427100524.GB15107@quack2.suse.cz>
References: <20200421085445.5731-1-jack@suse.cz>
 <20200421085445.5731-2-jack@suse.cz>
 <7ffc64ad-4741-27ca-ba9d-3d23af0a9216@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ffc64ad-4741-27ca-ba9d-3d23af0a9216@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 25-04-20 14:42:03, Xiaoguang Wang wrote:
> hi,
> 
> > evict() can race with writeback_sb_inodes() and so
> > list_empty(&inode->i_io_list) check can race with list_move() from
> > redirty_tail() possibly resulting in list_empty() returning false and
>                                                     ^^^^^^^^^^^^^^^
>                                                     returning true?
> if (!list_empty(&inode->i_io_list))
>     inode_io_list_del(inode);
> so "!list_empty(&inode->i_io_list)" returns false, and will not remove
> inode for wb->b_dirty list.

Yeah, right. I'll fix the mistake in the changelog. Thanks for noticing.

> > thus we end up leaving freed inode in wb->b_dirty list leading to
> > use-after-free issues.
> > 
> > Fix the problem by using list_empty_careful() check and add assert that
> > inode's i_io_list is empty in clear_inode() to catch the problem earlier
> > in the future.
> From list_empty_careful()'s comments, using list_empty_careful() without
> synchronization can only be safe if the only activity that can happen to the
> list entry is list_del_init(), but list_move() does not use list_del_init().
> 
> static inline void list_move(struct list_head *list, struct list_head *head)
> {
> 	__list_del_entry(list);
> 	list_add(list, head);
> }
> 
> So I wonder whether list_empty(&inode->i_io_list) check in evict() can
> race with list_move() from redirty_tail()?

list_empty() check can race with list_move() but I don't think the outcome
of the racy check can ever be that the list is empty... Thinking about it
again, I'm not sure how even the list_empty() check could give false
positive because during the list_move() sequence, I don't think head->next
== head is ever true. So maybe this patch isn't needed at all (except for
the added BUG_ON() which is useful).

								Honza

> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >   fs/inode.c | 9 ++++++++-
> >   1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 93d9252a00ab..a73c8a7aa71a 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -534,6 +534,7 @@ void clear_inode(struct inode *inode)
> >   	BUG_ON(!(inode->i_state & I_FREEING));
> >   	BUG_ON(inode->i_state & I_CLEAR);
> >   	BUG_ON(!list_empty(&inode->i_wb_list));
> > +	BUG_ON(!list_empty(&inode->i_io_list));
> >   	/* don't need i_lock here, no concurrent mods to i_state */
> >   	inode->i_state = I_FREEING | I_CLEAR;
> >   }
> > @@ -559,7 +560,13 @@ static void evict(struct inode *inode)
> >   	BUG_ON(!(inode->i_state & I_FREEING));
> >   	BUG_ON(!list_empty(&inode->i_lru));
> > -	if (!list_empty(&inode->i_io_list))
> > +	/*
> > +	 * We are the only holder of the inode so it cannot be marked dirty.
> > +	 * Flusher thread won't start new writeback but there can be still e.g.
> > +	 * redirty_tail() running from writeback_sb_inodes(). So we have to be
> > +	 * careful to remove inode from dirty/io list in all the cases.
> > +	 */
> > +	if (!list_empty_careful(&inode->i_io_list))
> >   		inode_io_list_del(inode);
> >   	inode_sb_list_del(inode);
> > 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
