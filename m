Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F004F380866
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 13:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhENLYe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 07:24:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:51298 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229516AbhENLYd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 07:24:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 99D82AFF5;
        Fri, 14 May 2021 11:23:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 689631F2B4A; Fri, 14 May 2021 13:23:20 +0200 (CEST)
Date:   Fri, 14 May 2021 13:23:20 +0200
From:   Jan Kara <jack@suse.cz>
To:     Roman Gushchin <guro@fb.com>
Cc:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v4] cgroup, blkcg: prevent dirty inodes to pin dying
 memory cgroups
Message-ID: <20210514112320.GB27655@quack2.suse.cz>
References: <20210513004258.1610273-1-guro@fb.com>
 <20210513101239.GE2734@quack2.suse.cz>
 <YJ1sALo2KaP813Dy@carbon.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ1sALo2KaP813Dy@carbon.DHCP.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 13-05-21 11:12:16, Roman Gushchin wrote:
> On Thu, May 13, 2021 at 12:12:39PM +0200, Jan Kara wrote:
> > On Wed 12-05-21 17:42:58, Roman Gushchin wrote:
> > > +			WARN_ON_ONCE(inode->i_wb != wb);
> > > +			inode->i_wb = NULL;
> > > +			wb_put(wb);
> > > +			list_del_init(&inode->i_io_list);
> > 
> > So I was thinking about this and I'm still a bit nervous that setting i_wb
> > to NULL is going to cause subtle crashes somewhere. Granted you are very
> > careful when not to touch the inode but still, even stuff like
> > inode_to_bdi() is not safe to call with inode->i_wb is NULL. So I'm afraid
> > that some place in the writeback code will be looking at i_wb without
> > having any of those bits set and boom. E.g. inode_to_wb() call in
> > test_clear_page_writeback() - what protects that one?
> 
> I assume that if the page is dirty/under the writeback, the inode must be
> dirty too, so we can't zero inode->i_wb.

If page is under writeback, the inode can be already clean. You could check
  !mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK)
but see how fragile it is... For every place using inode_to_wb() you have
to come up with a test excluding it...

> > I forgot what possibilities did we already discuss in the past but cannot
> > we just switch inode->i_wb to inode_to_bdi(inode)->wb (i.e., root cgroup
> > writeback structure)? That would be certainly safer...
> 
> I am/was nervous too. I had several BUG_ON()'s in all such places and ran
> the test kernel for about a day on my dev desktop (even updated to Fedora
> 34 lol), and haven't seen any panics. And certainly I can give it a
> comprehensive test in a more production environment.

I appreciate the testing but it is also about how likely this is to break
sometime in future because someone unaware of this corner-case will add new
inode_to_wb() call not excluded by one of your conditions.

> Re switching to the root wb: it's certainly a possibility too, however
> zeroing has an advantage: the next potential writeback will be accounted
> to the right cgroup without a need in an additional switch.
> I'd try to go with zeroing if it's possible, and keep the switching to the
> root wb as plab B.

Yes, there will be the cost of an additional switch. But inodes attached to
dying cgroups shouldn't be the fast path anyway so does it matter?

> > > @@ -633,6 +647,48 @@ static void cgwb_bdi_unregister(struct backing_dev_info *bdi)
> > >  	mutex_unlock(&bdi->cgwb_release_mutex);
> > >  }
> > >  
> > > +/**
> > > + * cleanup_offline_cgwbs - try to release dying cgwbs
> > > + *
> > > + * Try to release dying cgwbs by switching attached inodes to the wb
> > > + * belonging to the root memory cgroup. Processed wbs are placed at the
> > > + * end of the list to guarantee the forward progress.
> > > + *
> > > + * Should be called with the acquired cgwb_lock lock, which might
> > > + * be released and re-acquired in the process.
> > > + */
> > > +static void cleanup_offline_cgwbs_workfn(struct work_struct *work)
> > > +{
> > > +	struct bdi_writeback *wb;
> > > +	LIST_HEAD(processed);
> > > +
> > > +	spin_lock_irq(&cgwb_lock);
> > > +
> > > +	while (!list_empty(&offline_cgwbs)) {
> > > +		wb = list_first_entry(&offline_cgwbs, struct bdi_writeback,
> > > +				      offline_node);
> > > +
> > > +		list_move(&wb->offline_node, &processed);
> > > +
> > > +		if (wb_has_dirty_io(wb))
> > > +			continue;
> > > +
> > > +		if (!percpu_ref_tryget(&wb->refcnt))
> > > +			continue;
> > > +
> > > +		spin_unlock_irq(&cgwb_lock);
> > > +		cleanup_offline_wb(wb);
> > > +		spin_lock_irq(&cgwb_lock);
> > > +
> > > +		wb_put(wb);
> > > +	}
> > > +
> > > +	if (!list_empty(&processed))
> > > +		list_splice_tail(&processed, &offline_cgwbs);
> > > +
> > > +	spin_unlock_irq(&cgwb_lock);
> > 
> > Shouldn't we reschedule this work with some delay if offline_cgwbs is
> > non-empty? Otherwise we can end up with non-empty &offline_cgwbs and no
> > cleaning scheduled...
> 
> I'm not sure. In general it's not a big problem to have few outstanding
> wb structures, we just need to make sure we don't pile them.
> I'm scheduling the cleanup from the memcg offlining path, so if new cgroups
> are regularly created and destroyed, some pressure will be applied.
> 
> To reschedule based on time we need to come up with some heuristic how to
> calculate the required delay and I don't have any specific ideas. If you do,
> I'm totally fine to incorporate them.

Well, I'd pick e.g. dirty_expire_interval (30s by default) as a time after
which we try again. Because after that time writeback has likely already
happened. But I don't insist here. If you think leaving inodes attached to
dead cgroups for potentially long time in some cases isn't a problem, then
we can leave this as is. If we find it's a problem in the future, we can
always add the time-based retry.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
