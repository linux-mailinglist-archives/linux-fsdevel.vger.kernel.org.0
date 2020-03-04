Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84CA5179903
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 20:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbgCDT2U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 14:28:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:46770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727137AbgCDT2S (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 14:28:18 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D31C20870;
        Wed,  4 Mar 2020 19:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583350097;
        bh=3kUFhngdkgPo1mLB/7CvxoPNY3EycqERwiCrHnTotGI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=v87BY5q/t+rk7EbCGexZZiADp/yZ0DBWMRhEs37SJ+jwgkzKPOZ8MrLk+ZMvZNuWF
         87NNy23qXdqmIvwdeWPvVvrRYJodf34QDNowZE5dYJV3VbOnok3byYOb9o7qKX1/k+
         Zx2wAtKUTO3bj/DfJLQOAYVYBLQLI8fkhyrZWPQo=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F1CFD3522731; Wed,  4 Mar 2020 11:28:16 -0800 (PST)
Date:   Wed, 4 Mar 2020 11:28:16 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, mszeredi@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: How to abuse RCU to scan the children of a mount?
Message-ID: <20200304192816.GI2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <3173159.1583343916@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3173159.1583343916@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 04, 2020 at 05:45:16PM +0000, David Howells wrote:
> Hi Paul,
> 
> As part of trying to implement a filesystem information querying system call,
> I need to be able to return a list of child mounts of a mount.  Children,
> however, may be moved with "mount --move", which means that the list can't be
> accessed with normal RCU practices.
> 
> For reference, I'm dealing with struct mount and mnt_mounts and mnt_child and
> struct mount is released via call_rcu().
> 
> What does rcu_dereference() guarantee, exactly?  It's just that the next hop
> is set up when you follow the pointer, right?
> 
> Can I do something like the attached?  The mount 'm' is pinned, but I need to
> trawl m->mnt_mounts.  mount_lock is a seqlock that ticks when mount topology
> is rearranged.  I *think* it covers ->mnt_mounts.

I took a quick but non-exhaustive look, and didn't find any exceptions.
However, a stress test with lockdep enabled and with the addition of
appropriate lockdep assertions might be helpful here.  I trust lockdep
quite a bit more than I trust my quick looks.  ;-)

>                                                    Whilst trawling in
> non-locked mode, I keep an eye on the seq counter and if it changes, the list
> may have been altered and I need to get the real lock and restart.
> 
> The objects shouldn't disappear or be destroyed, so I think I'm safe.

Famous last words!  ;-)

Huh.  The mount structure isn't suffering from a shortage of list_head
structures, is it?

So the following can happen, then?

o	The __attach_mnt() function adds a struct mount to its parent
	list, but in a non-RCU manner.	Unless there is some other
	safeguard, the list_add_tail() in this function needs to be
	list_add_tail_rcu().

o	I am assuming that the various non-RCU traversals that I see,
	for example, next_mnt(), are protected by lock_mount_hash().
	Especially skip_mnt_tree(), which uses mnt_mounts.prev.  (I didn't
	find any exceptions, but I don't claim an exhaustive search.)

o	The umount_tree() function's use of list_del_init() looks like
	it could trap an RCU reader in the newly singular list formed
	by the removal.  It appears that there are other functions that
	use list_del_init() on this list, though I cannot claim any sort
	of familiarity with this code.

	So, do you need to add a check for child->mnt_child being in this
	self-referential state within fsinfo_generic_mount_children()?

	Plus list_del_init() doesn't mark its stores, though
	some would argue that unmarked stores are OK in this situation.

o	There might be other operations in need of RCU-ification.

	Maybe the list_add_tail() in umount_tree(), but it is not
	immediately clear that this is adding a new element instead of
	re-inserting an element already exposed to readers.

> Thanks,
> David
> ---
> 
> int fsinfo_generic_mount_children(struct path *path, struct fsinfo_context *ctx)
> {
> 	struct fsinfo_mount_child record = {};
> 	struct mount *m, *child;
> 	int seq = 0;
> 
> 	m = real_mount(path->mnt);

What keeps the thing referenced by "m" from going away?  Presumably the
caller has nailed it down somehow, but I have to ask...

> 	rcu_read_lock();
> 	do {
> 		ctx->usage = 0;
> 		read_seqbegin_or_lock(&mount_lock, &seq);

Aside: If there was an updater holding the lock along with a flood of
readers, everyone would hereafter acquire the lock.  Or am I missing
a trick here?  (I would have expected it to try a few times, and only
then acquire the lock.  Yeah, I know, more state would be required.)

> 		list_for_each_entry_rcu(child, &m->mnt_mounts, mnt_child) {
> 			if (need_seqretry(&mount_lock, seq))
> 				break;
> 			if (child->mnt_parent != m)
> 				continue;
> 			record.mnt_unique_id = child->mnt_unique_id;
> 			record.mnt_id = child->mnt_id;
> 			record.notify_sum = 0;
> #ifdef CONFIG_SB_NOTIFICATIONS
> 			record.notify_sum +=
> 				atomic_read(&child->mnt.mnt_sb->s_change_counter) +
> 				atomic_read(&child->mnt.mnt_sb->s_notify_counter);
> #endif
> #ifdef CONFIG_MOUNT_NOTIFICATIONS
> 			record.notify_sum +=
> 				atomic_read(&child->mnt_attr_changes) +
> 				atomic_read(&child->mnt_topology_changes) +
> 				atomic_read(&child->mnt_subtree_notifications);
> #endif
> 			store_mount_fsinfo(ctx, &record);
> 		}
> 	} while (need_seqretry(&mount_lock, seq));
> 	done_seqretry(&mount_lock, seq);
> 
> 	rcu_read_unlock();
> 
> 	/* End the list with a copy of the parameter mount's details so that
> 	 * userspace can quickly check for changes.
> 	 */
> 	record.mnt_unique_id = m->mnt_unique_id;
> 	record.mnt_id = m->mnt_id;
> 	record.notify_sum = 0;
> #ifdef CONFIG_SB_NOTIFICATIONS
> 	record.notify_sum +=
> 		atomic_read(&m->mnt.mnt_sb->s_change_counter) +
> 		atomic_read(&m->mnt.mnt_sb->s_notify_counter);
> #endif
> #ifdef CONFIG_MOUNT_NOTIFICATIONS
> 	record.notify_sum +=
> 		atomic_read(&m->mnt_attr_changes) +
> 		atomic_read(&m->mnt_topology_changes) +
> 		atomic_read(&m->mnt_subtree_notifications);
> #endif
> 	store_mount_fsinfo(ctx, &record);
> 	return ctx->usage;
> }

Other than that, looks legit!  ;-)

							Thanx, Paul
