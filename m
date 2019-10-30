Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C223EA7BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2019 00:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfJ3XZr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 19:25:47 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:43730 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727071AbfJ3XZr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 19:25:47 -0400
Received: from dread.disaster.area (pa49-180-67-183.pa.nsw.optusnet.com.au [49.180.67.183])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 6EA8B43F1EC;
        Thu, 31 Oct 2019 10:25:40 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iPxLO-00074y-Sc; Thu, 31 Oct 2019 10:25:38 +1100
Date:   Thu, 31 Oct 2019 10:25:38 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 23/26] xfs: reclaim inodes from the LRU
Message-ID: <20191030232538.GR4614@dread.disaster.area>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-24-david@fromorbit.com>
 <20191011105618.GE12811@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011105618.GE12811@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=G6BsK5s5 c=1 sm=1 tr=0
        a=3wLbm4YUAFX2xaPZIabsgw==:117 a=3wLbm4YUAFX2xaPZIabsgw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=7-415B0cAAAA:8 a=VOnfzj_9Zz8vEk4kErUA:9 a=FrVAQx7mOBj6-zRg:21
        a=1aOJmfDagP4pJMOT:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 11, 2019 at 03:56:18AM -0700, Christoph Hellwig wrote:
> > +++ b/fs/xfs/xfs_icache.c
> > @@ -1193,7 +1193,7 @@ xfs_reclaim_inode(
> >   *
> >   * Return the number of inodes freed.
> >   */
> > -STATIC int
> > +int
> >  xfs_reclaim_inodes_ag(
> >  	struct xfs_mount	*mp,
> >  	int			flags,
> 
> This looks odd.  This function actually is unused now.  I think you
> want to fold in the patch that removes it instead of this little hack
> to make the compiler happy.

I think it might have been a stray.

> 
> > -	xfs_reclaim_inodes_ag(mp, SYNC_WAIT, INT_MAX);
> > +        struct xfs_ireclaim_args *ra = arg;
> > +        struct inode		*inode = container_of(item, struct inode, i_lru);
> > +        struct xfs_inode	*ip = XFS_I(inode);
> 
> Whitespace damage, and a line > 80 chars.

Fixed.
> 
> > +out_ifunlock:
> > +	xfs_ifunlock(ip);
> 
> This error path will instantly deadlock, given that xfs_ifunlock takes
> i_flags_lock through xfs_iflags_clear, and we already hold it here.

Good catch. Clearly it's hard to hit a flush locked inode here...

> > +	/*
> > +	 * Remove the inode from the per-AG radix tree.
> > +	 *
> > +	 * Because radix_tree_delete won't complain even if the item was never
> > +	 * added to the tree assert that it's been there before to catch
> > +	 * problems with the inode life time early on.
> > +	 */
> > +	pag = xfs_perag_get(mp, XFS_INO_TO_AGNO(mp, ino));
> > +	spin_lock(&pag->pag_ici_lock);
> > +	if (!radix_tree_delete(&pag->pag_ici_root, XFS_INO_TO_AGINO(mp, ino)))
> > +		ASSERT(0);
> 
> Well, it "complains" by returning NULL instead of the entry.  So I think
> that comment could use some updates or simply be removed.

Removed.

> 
> > +void
> > +xfs_dispose_inodes(
> > +	struct list_head	*freeable)
> > +{
> > +	while (!list_empty(freeable)) {
> > +		struct inode *inode;
> > +
> > +		inode = list_first_entry(freeable, struct inode, i_lru);
> 
> This could use list_first_entry_or_null in the while loop, or not.
> Or list_pop_entry if we had it, but Linus hates that :)

Changed to use list_first_entry_or_null().

> 
> > +xfs_reclaim_inodes(
> > +	struct xfs_mount	*mp)
> > +{
> > +	while (list_lru_count(&mp->m_inode_lru)) {
> > +		struct xfs_ireclaim_args ra;
> > +		long freed, to_free;
> > +
> > +		INIT_LIST_HEAD(&ra.freeable);
> > +		ra.lowest_lsn = NULLCOMMITLSN;
> > +		to_free = list_lru_count(&mp->m_inode_lru);
> 
> Do we want a helper to initialize the xfs_ireclaim_args?  That would
> solve the "issue" of not initializing dirty_skipped in a few users
> and make it a little easier to use.

Done.

> > +
> > +		freed = list_lru_walk(&mp->m_inode_lru, xfs_inode_reclaim_isolate,
> 
> Line > 80 chars.

Fixed.

> > +static inline int __xfs_iflock_nowait(struct xfs_inode *ip)
> > +{
> > +	if (ip->i_flags & XFS_IFLOCK)
> > +		return false;
> > +	ip->i_flags |= XFS_IFLOCK;
> > +	return true;
> > +}
> 
> I wonder if simply open coding this would be simpler, given how magic
> xfs_inode_reclaim_isolate already is, and given that we really shouldn't
> use this helper anywhere else.

Well, I kind of just added an __xfs_ifunlock() wrapper to pair with
it because of the deadlock you caught above. I've added
lockdep_assert_held() to both of them to indicate the context in
which they should be used. While it's special case, I really would
like to keep the internals of flush locking code together as much as
possible.

Longer term (i.e. a future patchset), I really want to clean up how
we use the i_flags_lock and the i_flags bits. At the time the iflags
wrappers made sense, but now we have as many open coded flags as we
do wrapped. And in many of these cases I think we'd be better off
using bitops for them (e.g. bitops for the flush lock bit make these
new helpers go away), and the i_flags_lock can be removed and
replaced by the VFS inode i_lock for operations that require an
internal spinlock to serialise...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
