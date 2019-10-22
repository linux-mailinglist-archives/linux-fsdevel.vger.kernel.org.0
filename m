Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C790DFF57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 10:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388170AbfJVIZZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 04:25:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:38430 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388061AbfJVIZZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:25:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6F466B314;
        Tue, 22 Oct 2019 08:25:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9B09F1E4812; Tue, 22 Oct 2019 10:15:51 +0200 (CEST)
Date:   Tue, 22 Oct 2019 10:15:51 +0200
From:   Jan Kara <jack@suse.cz>
To:     Roman Gushchin <guro@fb.com>
Cc:     Jan Kara <jack@suse.cz>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "tj@kernel.org" <tj@kernel.org>, Dennis Zhou <dennis@kernel.org>
Subject: Re: [PATCH v2] cgroup, blkcg: prevent dirty inodes to pin dying
 memory cgroups
Message-ID: <20191022081551.GD2436@quack2.suse.cz>
References: <20191010234036.2860655-1-guro@fb.com>
 <20191015090933.GA21104@quack2.suse.cz>
 <20191015214041.GA24736@tower.DHCP.thefacebook.com>
 <20191016091840.GC30337@quack2.suse.cz>
 <20191021234858.GA16251@castle>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021234858.GA16251@castle>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 21-10-19 23:49:04, Roman Gushchin wrote:
> On Wed, Oct 16, 2019 at 11:18:40AM +0200, Jan Kara wrote:
> > On Tue 15-10-19 21:40:45, Roman Gushchin wrote:
> > > On Tue, Oct 15, 2019 at 11:09:33AM +0200, Jan Kara wrote:
> > > > On Thu 10-10-19 16:40:36, Roman Gushchin wrote:
> > > > 
> > > > > @@ -426,7 +431,7 @@ static void inode_switch_wbs_work_fn(struct work_struct *work)
> > > > >  	if (!list_empty(&inode->i_io_list)) {
> > > > >  		struct inode *pos;
> > > > >  
> > > > > -		inode_io_list_del_locked(inode, old_wb);
> > > > > +		inode_io_list_del_locked(inode, old_wb, false);
> > > > >  		inode->i_wb = new_wb;
> > > > >  		list_for_each_entry(pos, &new_wb->b_dirty, i_io_list)
> > > > >  			if (time_after_eq(inode->dirtied_when,
> > > > 
> > > > This bit looks wrong. Not the change you made as such but the fact that you
> > > > can now move inode from b_attached list of old wb to the dirty list of new
> > > > wb.
> > > 
> > > Hm, can you, please, elaborate a bit more why it's wrong?
> > > The reference to the old_wb will be dropped by the switching code.
> > 
> > My point is that the code in full looks like:
> > 
> >         if (!list_empty(&inode->i_io_list)) {
> >                 struct inode *pos;
> > 
> >                 inode_io_list_del_locked(inode, old_wb);
> >                 inode->i_wb = new_wb;
> >                 list_for_each_entry(pos, &new_wb->b_dirty, i_io_list)
> >                         if (time_after_eq(inode->dirtied_when,
> >                                           pos->dirtied_when))
> >                                 break;
> >                 inode_io_list_move_locked(inode, new_wb, pos->i_io_list.prev);
> >         } else {
> > 
> > So inode is always moved from some io list in old_wb to b_dirty list of
> > new_wb. This is fine when it could be only on b_dirty, b_io, b_more_io lists
> > of old_wb. But once you add b_attached list to the game, it is not correct
> > anymore. You should not add clean inode to b_dirty list of new_wb.
> 
> I see...
> 
> Hm, will checking of i_state for not containing I_DIRTY_ALL bits be enough here?
> Alternatively, I can introduce a new bit which will explicitly point at the
> inode being on the b_attached list, but I'd prefer not to do it.

Yeah, keying of i_state should work. And while we are at it, we could also
correctly handle I_DIRTY_TIME case and move inode only to b_dirty_time
list. That seems to be (mostly harmless) preexisting issue.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
