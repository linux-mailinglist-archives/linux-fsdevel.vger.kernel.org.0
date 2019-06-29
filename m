Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53E085A8D9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2019 06:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfF2EJ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jun 2019 00:09:27 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49938 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfF2EJ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jun 2019 00:09:27 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hh4fM-0003FG-Bu; Sat, 29 Jun 2019 04:08:44 +0000
Date:   Sat, 29 Jun 2019 05:08:44 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@ftp.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christopher Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Waiman Long <longman@redhat.com>,
        Tycho Andersen <tycho@tycho.ws>, Theodore Ts'o <tytso@mit.edu>,
        Andi Kleen <ak@linux.intel.com>,
        David Chinner <david@fromorbit.com>,
        Nick Piggin <npiggin@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH v3 14/15] dcache: Implement partial shrink via Slab
 Movable Objects
Message-ID: <20190629040844.GS17978@ZenIV.linux.org.uk>
References: <20190411013441.5415-1-tobin@kernel.org>
 <20190411013441.5415-15-tobin@kernel.org>
 <20190411023322.GD2217@ZenIV.linux.org.uk>
 <20190411024821.GB6941@eros.localdomain>
 <20190411044746.GE2217@ZenIV.linux.org.uk>
 <20190411210200.GH2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411210200.GH2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 11, 2019 at 10:02:00PM +0100, Al Viro wrote:

> Aaaarrgghhh...  No, we can't.  Look: we get one candidate dentry in isolate
> phase.  We put it into shrink list.  umount(2) comes and calls
> shrink_dcache_for_umount(), which calls shrink_dcache_parent(root).
> In the meanwhile, shrink_dentry_list() is run and does __dentry_kill() on
> that one dentry.  Fine, it's gone - before shrink_dcache_parent() even
> sees it.  Now shrink_dentry_list() holds a reference to its parent and
> is about to drop it in
>                 dentry = parent;
>                 while (dentry && !lockref_put_or_lock(&dentry->d_lockref))
>                         dentry = dentry_kill(dentry);
> And dropped it will be, but... shrink_dcache_parent() has finished the
> scan, without finding *anything* with zero refcount - the thing that used
> to be on the shrink list was already gone before shrink_dcache_parent()
> has gotten there and the reference to parent was not dropped yet.  So
> shrink_dcache_for_umount() plows past shrink_dcache_parent(), walks the
> tree and complains loudly about "busy" dentries (that parent we hadn't
> finished dropping), and then we proceed with filesystem shutdown.
> In the meanwhile, dentry_kill() finally gets to killing dentry and
> triggers an unexpected late call of ->d_iput() on a filesystem that
> has already been far enough into shutdown - far enough to destroy the
> data structures needed for that sucker.
> 
> The reason we don't hit that problem with regular memory shrinker is
> this:
>                 unregister_shrinker(&s->s_shrink);
>                 fs->kill_sb(s);
> in deactivate_locked_super().  IOW, shrinker for this fs is gone
> before we get around to shutdown.  And so are all normal sources
> of dentry eviction for that fs.
> 
> Your earlier variants all suffer the same problem - picking a page
> shared by dentries from several superblocks can run into trouble
> if it overlaps with umount of one of those.

FWIW, I think I see a kinda-sorta sane solution.  Namely, add

static void __dput_to_list(struct dentry *dentry, struct list_head *list)
{
	if (dentry->d_flags & DCACHE_SHRINK_LIST) {
		/* let the owner of the list it's on deal with it */
		--dentry->d_lockref.count;
	} else {
		if (dentry->d_flags & DCACHE_LRU_LIST)
			d_lru_del(dentry);
		if (!--dentry->d_lockref.count)
			d_shrink_add(parent, list);
	}
}

and have
shrink_dentry_list() do this in the end of loop:
                d_shrink_del(dentry);
                parent = dentry->d_parent;
		/* both dentry and parent are locked at that point */
		if (parent != dentry) {
			/*
			 * We need to prune ancestors too. This is necessary to
			 * prevent quadratic behavior of shrink_dcache_parent(),
			 * but is also expected to be beneficial in reducing
			 * dentry cache fragmentation.
			 */
			__dput_to_list(parent, list);
		}
		__dentry_kill(dentry);
        }

instead of
                d_shrink_del(dentry);
                parent = dentry->d_parent;
                __dentry_kill(dentry);
                if (parent == dentry)
                        continue;
                /*
                 * We need to prune ancestors too. This is necessary to prevent
                 * quadratic behavior of shrink_dcache_parent(), but is also
                 * expected to be beneficial in reducing dentry cache
                 * fragmentation.
                 */
                dentry = parent;
                while (dentry && !lockref_put_or_lock(&dentry->d_lockref))
                        dentry = dentry_kill(dentry);
        }
we have there now.  Linus, do you see any problems with that change?  AFAICS,
that should avoid the problem described above.  Moreover, it seems to allow
a fun API addition:

void dput_to_list(struct dentry *dentry, struct list_head *list)
{
	rcu_read_lock();
	if (likely(fast_dput(dentry))) {
		rcu_read_unlock();
		return;
	}
	rcu_read_unlock();
	if (!retain_dentry(dentry))
		__dput_to_list(dentry, list);
	spin_unlock(&dentry->d_lock);
}

allowing to take an empty list, do a bunch of dput_to_list() (under spinlocks,
etc.), then, once we are in better locking conditions, shrink_dentry_list()
to take them all out.  I can see applications for that in e.g. fs/namespace.c -
quite a bit of kludges with ->mnt_ex_mountpoint would be killable that way,
and there would be a chance to transfer the contribution to ->d_count of
mountpoint from struct mount to struct mountpoint (i.e. make any number of
mounts on the same mountpoint dentry contribute only 1 to its ->d_count,
not the number of such mounts).
