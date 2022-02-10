Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9184B0521
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 06:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbiBJFd0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 00:33:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbiBJFdZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 00:33:25 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B02410C0;
        Wed,  9 Feb 2022 21:33:25 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nI255-000qlO-OE; Thu, 10 Feb 2022 05:33:23 +0000
Date:   Thu, 10 Feb 2022 05:33:23 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v2 1/4] dcache: sweep cached negative dentries to the end
 of list of siblings
Message-ID: <YgSjo5wascR9mfnA@zeniv-ca.linux.org.uk>
References: <20220209231406.187668-1-stephen.s.brennan@oracle.com>
 <20220209231406.187668-2-stephen.s.brennan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209231406.187668-2-stephen.s.brennan@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 09, 2022 at 03:14:03PM -0800, Stephen Brennan wrote:

> +static void sweep_negative(struct dentry *dentry)
> +{
> +	struct dentry *parent;
> +
> +	rcu_read_lock();
> +	parent = lock_parent(dentry);
> +	if (!parent) {
> +		rcu_read_unlock();
> +		return;
> +	}
> +
> +	/*
> +	 * If we did not hold a reference to dentry (as in the case of dput),
> +	 * and dentry->d_lock was dropped in lock_parent(), then we could now be
> +	 * holding onto a dead dentry. Be careful to check d_count and unlock
> +	 * before dropping RCU lock, otherwise we could corrupt freed memory.
> +	 */
> +	if (!d_count(dentry) && d_is_negative(dentry) &&
> +		!d_is_tail_negative(dentry)) {
> +		dentry->d_flags |= DCACHE_TAIL_NEGATIVE;
> +		list_move_tail(&dentry->d_child, &parent->d_subdirs);
> +	}
> +
> +	spin_unlock(&parent->d_lock);
> +	spin_unlock(&dentry->d_lock);
> +	rcu_read_unlock();
> +}

	I'm not sure if it came up the last time you'd posted this series
(and I apologize if it had and I forgot the explanation), but... consider
the comment in dentry_unlist().  What's to prevent the race described there
making d_walk() skip a part of tree, by replacing the "lseek moving cursor
in just the wrong moment" with "dput moving the negative dentry right next
to the one being killed to the tail of the list"?

	The race in question:
d_walk() is leaving a subdirectory.  We are here:
        rcu_read_lock();
ascend:
        if (this_parent != parent) {

It isn't - we are not back to the root of tree being walked.
At this point this_parent is the directory we'd just finished looking into.

                struct dentry *child = this_parent;
                this_parent = child->d_parent;

... and now child points to it, and this_parent points to its parent.

                spin_unlock(&child->d_lock);

No locks held.  Another CPU gets through successful rmdir().  child gets
unhashed and dropped.  It's off the ->d_subdirs of this_parent; its
->d_child.next is still pointing where it used to, and whatever it points
to won't be physically freed until rcu_read_unlock().

Moreover, in the meanwhile this next sibling (negative, pinned) got dput().
And had been moved to the tail of the this_parent->d_subdirs.  Since
its ->d_child.prev does *NOT* point to child (which is off-list, about to
be freed shortly, etc.), child->d_dchild.next is not modified - it still
points to that (now moved) sibling.

                spin_lock(&this_parent->d_lock);
Got it.

                /* might go back up the wrong parent if we have had a rename. */
                if (need_seqretry(&rename_lock, seq))
                        goto rename_retry;

Nope, hadn't happened.

                /* go into the first sibling still alive */
                do {
                        next = child->d_child.next;
... and this is the moved sibling, now in the end of the ->d_subdirs.

                        if (next == &this_parent->d_subdirs)
                                goto ascend;

No, it is not - it's the last element of the list, not its anchor.

                        child = list_entry(next, struct dentry, d_child);

Our moved negative dentry.

                } while (unlikely(child->d_flags & DCACHE_DENTRY_KILLED));

Not killed, that one.
                rcu_read_unlock();
                goto resume;

... and since that sucker has no children, we proceed to look at it,
ascend and now we are at the end of this_parent->d_subdirs.  And we
ascend out of it, having entirely skipped all branches that used to
be between the rmdir victim and the end of the parent's ->d_subdirs.

What am I missing here?  Unlike the trick we used with cursors (see
dentry_unlist()) we can't predict who won't get moved in this case...

Note that treating "child is has DCACHE_DENTRY_KILLED" same as we do
for rename_lock mismatches would not work unless you grab the spinlock
component of rename_lock every time dentry becomes positive.  Which
is obviously not feasible (it's a system-wide lock and cacheline
pingpong alone would hurt us very badly, not to mention the contention
issues due to the frequency of grabbing it going up by several orders
of magnitude).
