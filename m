Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6D64CF4E0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 10:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbfJHIUm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 04:20:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:60520 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730440AbfJHIUm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 04:20:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AA896AEA1;
        Tue,  8 Oct 2019 08:20:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 25BBF1E4801; Tue,  8 Oct 2019 10:20:39 +0200 (CEST)
Date:   Tue, 8 Oct 2019 10:20:39 +0200
From:   Jan Kara <jack@suse.cz>
To:     Roman Gushchin <guro@fb.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "tj@kernel.org" <tj@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] cgroup, blkcg: prevent dirty inodes to pin dying memory
 cgroups
Message-ID: <20191008082039.GA5078@quack2.suse.cz>
References: <20191004221104.646711-1-guro@fb.com>
 <20191008040630.GA15134@dread.disaster.area>
 <20191008053854.GA14951@castle.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008053854.GA14951@castle.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 08-10-19 05:38:59, Roman Gushchin wrote:
> On Tue, Oct 08, 2019 at 03:06:31PM +1100, Dave Chinner wrote:
> > On Fri, Oct 04, 2019 at 03:11:04PM -0700, Roman Gushchin wrote:
> > > This is a RFC patch, which is not intended to be merged as is,
> > > but hopefully will start a discussion which can result in a good
> > > solution for the described problem.
> > > 
> > > --
> > > 
> > > We've noticed that the number of dying cgroups on our production hosts
> > > tends to grow with the uptime. This time it's caused by the writeback
> > > code.
> > > 
> > > An inode which is getting dirty for the first time is associated
> > > with the wb structure (look at __inode_attach_wb()). It can later
> > > be switched to another wb under some conditions (e.g. some other
> > > cgroup is writing a lot of data to the same inode), but generally
> > > stays associated up to the end of life of the inode structure.
> > > 
> > > The problem is that the wb structure holds a reference to the original
> > > memory cgroup. So if the inode was dirty once, it has a good chance
> > > to pin down the original memory cgroup.
> > > 
> > > An example from the real life: some service runs periodically and
> > > updates rpm packages. Each time in a new memory cgroup. Installed
> > > .so files are heavily used by other cgroups, so corresponding inodes
> > > tend to stay alive for a long. So do pinned memory cgroups.
> > > In production I've seen many hosts with 1-2 thousands of dying
> > > cgroups.
> > > 
> > > This is not the first problem with the dying memory cgroups. As
> > > always, the problem is with their relative size: memory cgroups
> > > are large objects, easily 100x-1000x larger that inodes. So keeping
> > > a couple of thousands of dying cgroups in memory without a good reason
> > > (what we easily do with inodes) is quite costly (and is measured
> > > in tens and hundreds of Mb).
> > > 
> > > One possible approach to this problem is to switch inodes associated
> > > with dying wbs to the root wb. Switching is a best effort operation
> > > which can fail silently, so unfortunately we can't run once over a
> > > list of associated inodes (even if we'd have such a list). So we
> > > really have to scan all inodes.
> > > 
> > > In the proposed patch I schedule a work on each memory cgroup
> > > deletion, which is probably too often. Alternatively, we can do it
> > > periodically under some conditions (e.g. the number of dying memory
> > > cgroups is larger than X). So it's basically a gc run.
> > > 
> > > I wonder if there are any better ideas?
> > > 
> > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > ---
> > >  fs/fs-writeback.c | 29 +++++++++++++++++++++++++++++
> > >  mm/memcontrol.c   |  5 +++++
> > >  2 files changed, 34 insertions(+)
> > > 
> > > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > > index 542b02d170f8..4bbc9a200b2c 100644
> > > --- a/fs/fs-writeback.c
> > > +++ b/fs/fs-writeback.c
> > > @@ -545,6 +545,35 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
> > >  	up_read(&bdi->wb_switch_rwsem);
> > >  }
> > >  
> > > +static void reparent_dirty_inodes_one_sb(struct super_block *sb, void *arg)
> > > +{
> > > +	struct inode *inode, *next;
> > > +
> > > +	spin_lock(&sb->s_inode_list_lock);
> > > +	list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list) {
> > > +		spin_lock(&inode->i_lock);
> > > +		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
> > > +			spin_unlock(&inode->i_lock);
> > > +			continue;
> > > +		}
> > > +
> > > +		if (inode->i_wb && wb_dying(inode->i_wb)) {
> > > +			spin_unlock(&inode->i_lock);
> > > +			inode_switch_wbs(inode, root_mem_cgroup->css.id);
> > > +			continue;
> > > +		}
> > > +
> > > +		spin_unlock(&inode->i_lock);
> > > +	}
> > > +	spin_unlock(&sb->s_inode_list_lock);
> > 
> > No idea what the best solution is, but I think this is fundamentally
> > unworkable. It's not uncommon to have a hundred million cached
> > inodes these days, often on a single filesystem. Anything that
> > requires a brute-force system wide inode scan, especially without
> > conditional reschedule points, is largely a non-starter.
> > 
> > Also, inode_switch_wbs() is not guaranteed to move the inode to the
> > destination wb.  There can only be WB_FRN_MAX_IN_FLIGHT (1024)
> > switches in flight at once and switches are run via RCU callbacks,
> > so I suspect that using inode_switch_wbs() for bulk re-assignment is
> > going to be a lot more complex than just finding inodes to call
> > inode_switch_wbs() on....
> 
> We can schedule it only if the number of dying cgroups exceeds a certain
> number (like 100), which will make it relatively rare event. Maybe we can
> add some other conditions, e.g. count the number of inodes associated with
> a wb and skip scanning if it's zero.
> 
> Alternatively the wb structure can keep the list of associated inodes,
> and scan only them, but then it's not trivial to implement without
> additional complication of already quite complex locking scheme.
> And because inode_switch_wbs() can fail, we can't guarantee that a single
> pass over such a list will be enough. That means the we need to schedule
> scans periodically until all inodes will be switched.
> 
> So I really don't know which option is better, but at the same time
> doing nothing isn't the option too. Somehow the problem should be solved.

I agree with Dave that scanning all inodes in the system can get really
expensive quickly. So what I rather think we could do is create another 'IO
list' (linked by inode->i_io_list) where we would put inodes that reference
the wb but are not in any other IO list of the wb. And then we would
switch inodes on this list when the wb is dying... One would have to be
somewhat careful with properly draining this list since new inodes can be
added to it while we work on it but otherwise I don't see any complication
with this.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
