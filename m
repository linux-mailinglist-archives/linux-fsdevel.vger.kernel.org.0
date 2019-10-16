Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89BC5D8C62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 11:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbfJPJTz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 05:19:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:46304 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726480AbfJPJTz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:19:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 53F5BB213;
        Wed, 16 Oct 2019 09:18:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 181F31E3BDE; Wed, 16 Oct 2019 11:18:40 +0200 (CEST)
Date:   Wed, 16 Oct 2019 11:18:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Roman Gushchin <guro@fb.com>
Cc:     Jan Kara <jack@suse.cz>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "tj@kernel.org" <tj@kernel.org>, Dennis Zhou <dennis@kernel.org>
Subject: Re: [PATCH v2] cgroup, blkcg: prevent dirty inodes to pin dying
 memory cgroups
Message-ID: <20191016091840.GC30337@quack2.suse.cz>
References: <20191010234036.2860655-1-guro@fb.com>
 <20191015090933.GA21104@quack2.suse.cz>
 <20191015214041.GA24736@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015214041.GA24736@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 15-10-19 21:40:45, Roman Gushchin wrote:
> On Tue, Oct 15, 2019 at 11:09:33AM +0200, Jan Kara wrote:
> > On Thu 10-10-19 16:40:36, Roman Gushchin wrote:
> > 
> > > @@ -426,7 +431,7 @@ static void inode_switch_wbs_work_fn(struct work_struct *work)
> > >  	if (!list_empty(&inode->i_io_list)) {
> > >  		struct inode *pos;
> > >  
> > > -		inode_io_list_del_locked(inode, old_wb);
> > > +		inode_io_list_del_locked(inode, old_wb, false);
> > >  		inode->i_wb = new_wb;
> > >  		list_for_each_entry(pos, &new_wb->b_dirty, i_io_list)
> > >  			if (time_after_eq(inode->dirtied_when,
> > 
> > This bit looks wrong. Not the change you made as such but the fact that you
> > can now move inode from b_attached list of old wb to the dirty list of new
> > wb.
> 
> Hm, can you, please, elaborate a bit more why it's wrong?
> The reference to the old_wb will be dropped by the switching code.

My point is that the code in full looks like:

        if (!list_empty(&inode->i_io_list)) {
                struct inode *pos;

                inode_io_list_del_locked(inode, old_wb);
                inode->i_wb = new_wb;
                list_for_each_entry(pos, &new_wb->b_dirty, i_io_list)
                        if (time_after_eq(inode->dirtied_when,
                                          pos->dirtied_when))
                                break;
                inode_io_list_move_locked(inode, new_wb, pos->i_io_list.prev);
        } else {

So inode is always moved from some io list in old_wb to b_dirty list of
new_wb. This is fine when it could be only on b_dirty, b_io, b_more_io lists
of old_wb. But once you add b_attached list to the game, it is not correct
anymore. You should not add clean inode to b_dirty list of new_wb.

> > > +
> > > +	list_for_each_entry_safe(inode, tmp, &wb->b_attached, i_io_list) {
> > > +		if (!spin_trylock(&inode->i_lock))
> > > +			continue;
> > > +		xa_lock_irq(&inode->i_mapping->i_pages);
> > > +		if (!(inode->i_state &
> > > +		      (I_FREEING | I_CLEAR | I_SYNC | I_DIRTY | I_WB_SWITCH))) {
> > > +			WARN_ON_ONCE(inode->i_wb != wb);
> > > +			inode->i_wb = NULL;
> > > +			wb_put(wb);
> > 
> > Hum, currently the code assumes that once i_wb is set, it never becomes
> > NULL again. In particular the inode e.g. in
> > fs/fs-writeback.c:inode_congested() or generally unlocked_inode_to_wb_begin()
> > users could get broken by this. The i_wb switching code is so complex
> > exactly because of these interactions.
> > 
> > Maybe you thought through the interactions and things are actually fine but
> > if nothing else you'd need a big fat comment here explaining why this is
> > fine and update inode_congested() comments etc.
> 
> Yeah, I thought that once inode is clean and not switching it's safe to clear
> the i_wb pointer, but seems that it's not completely true.
>
> One idea I have is to always release wbs using rcu delayed work, so that
> it will be save to dereference i_wb pointer under rcu, if only it's not NULL
> (the check has to be added). I'll try to implement this scheme, but if you
> know in advance that it's not gonna work, please, let me know.

I think I'd just drop inode_to_wb_is_valid() because once i_wb can change
to NULL, that function is just pointless in that single callsite. Also we
have to count with the fact that unlocked_inode_to_wb_begin() can return
NULL and gracefully do as much as possible in that case for all the
callers. And I agree that those occurences in mm/page-writeback.c should be
blocked by inode being clean and you holding all those locks so you can
warn if that happens I guess.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
