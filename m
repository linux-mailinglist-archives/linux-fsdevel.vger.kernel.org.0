Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 217DD5ADA3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jun 2019 00:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfF2WaR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jun 2019 18:30:17 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:33166 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfF2WaQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jun 2019 18:30:16 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hhLqr-0002yp-RA; Sat, 29 Jun 2019 22:29:45 +0000
Date:   Sat, 29 Jun 2019 23:29:45 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: shrink_dentry_list() logics change (was Re: [RFC PATCH v3 14/15]
 dcache: Implement partial shrink via Slab Movable Objects)
Message-ID: <20190629222945.GW17978@ZenIV.linux.org.uk>
References: <20190411013441.5415-1-tobin@kernel.org>
 <20190411013441.5415-15-tobin@kernel.org>
 <20190411023322.GD2217@ZenIV.linux.org.uk>
 <20190411024821.GB6941@eros.localdomain>
 <20190411044746.GE2217@ZenIV.linux.org.uk>
 <20190411210200.GH2217@ZenIV.linux.org.uk>
 <20190629040844.GS17978@ZenIV.linux.org.uk>
 <20190629043803.GT17978@ZenIV.linux.org.uk>
 <20190629190624.GU17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190629190624.GU17978@ZenIV.linux.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 29, 2019 at 08:06:24PM +0100, Al Viro wrote:
> I wonder if after the "no evictable candidates, but something
> on other's shrink lists" we ought to do something along the
> lines of
> 	rcu_read_lock
> 	walk it, doing
> 		if dentry has zero refcount
> 			if it's not on a shrink list,
> 				move it to ours
> 			else
> 				store its address in 'victim'
> 				end the walk
> 	if no victim found
> 		rcu_read_unlock
> 	else
> 		lock victim for __dentry_kill
> 		rcu_read_unlock
> 		if it's still alive
> 			if it's not IS_ROOT
> 				if parent is not on shrink list
> 					decrement parent's refcount
> 					put it on our list
> 				else
> 					decrement parent's refcount
> 			__dentry_kill(victim)
> 		else
> 			unlock
> 	if our list is non-empty
> 		shrink_dentry_list on it
> in there...

Like this (again, only build-tested):

Teach shrink_dcache_parent() to cope with mixed-filesystem shrink lists

Currently, running into a shrink list that contains dentries from different
filesystems can cause several unpleasant things for shrink_dcache_parent()
and for umount(2).

The first problem is that there's a window during shrink_dentry_list() between
__dentry_kill() takes a victim out and dropping reference to its parent.  During
that window the parent looks like a genuine busy dentry.  shrink_dcache_parent()
(or, worse yet, shrink_dcache_for_umount()) coming at that time will see no
eviction candidates and no indication that it needs to wait for some
shrink_dentry_list() to proceed further.

That applies for any shrink list that might intersect with the subtree we are
trying to shrink; the only reason it does not blow on umount(2) in the mainline
is that we unregister the memory shrinker before hitting shrink_dcache_for_umount().

Another problem happens if something in a mixed-filesystem shrink list gets
be stuck in e.g. iput(), getting umount of unrelated fs to spin waiting for
the stuck shrinker to get around to our dentries.

Solution:
	1) have shrink_dentry_list() decrement the parent's refcount and
make sure it's on a shrink list (ours unless it already had been on some
other) before calling __dentry_kill().  That eliminates the window when
shrink_dcache_parent() would've blown past the entire subtree without
noticing anything with zero refcount not on shrink lists.
	2) when shrink_dcache_parent() has found no eviction candidates,
but some dentries are still sitting on shrink lists, rather than
repeating the scan in hope that shrinkers have progressed, scan looking
for something on shrink lists with zero refcount.  If such a thing is
found, grab rcu_read_lock() and stop the scan, with caller locking
it for eviction, dropping out of RCU and doing __dentry_kill(), with
the same treatment for parent as shrink_dentry_list() would do.

Note that right now mixed-filesystem shrink lists do not occur, so this
is not a mainline bug.  Howevere, there's a bunch of uses for such
beasts (e.g. the "try and evict everything we can out of given page"
patches; there are potential uses in mount-related code, considerably
simplifying the life in fs/namespace.c, etc.)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

diff --git a/fs/dcache.c b/fs/dcache.c
index 8136bda27a1f..43480f516329 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -860,6 +860,32 @@ void dput(struct dentry *dentry)
 }
 EXPORT_SYMBOL(dput);
 
+static void __dput_to_list(struct dentry *dentry, struct list_head *list)
+__must_hold(&dentry->d_lock)
+{
+	if (dentry->d_flags & DCACHE_SHRINK_LIST) {
+		/* let the owner of the list it's on deal with it */
+		--dentry->d_lockref.count;
+	} else {
+		if (dentry->d_flags & DCACHE_LRU_LIST)
+			d_lru_del(dentry);
+		if (!--dentry->d_lockref.count)
+			d_shrink_add(dentry, list);
+	}
+}
+
+void dput_to_list(struct dentry *dentry, struct list_head *list)
+{
+	rcu_read_lock();
+	if (likely(fast_dput(dentry))) {
+		rcu_read_unlock();
+		return;
+	}
+	rcu_read_unlock();
+	if (!retain_dentry(dentry))
+		__dput_to_list(dentry, list);
+	spin_unlock(&dentry->d_lock);
+}
 
 /* This must be called with d_lock held */
 static inline void __dget_dlock(struct dentry *dentry)
@@ -1088,18 +1114,9 @@ static void shrink_dentry_list(struct list_head *list)
 		rcu_read_unlock();
 		d_shrink_del(dentry);
 		parent = dentry->d_parent;
+		if (parent != dentry)
+			__dput_to_list(parent, list);
 		__dentry_kill(dentry);
-		if (parent == dentry)
-			continue;
-		/*
-		 * We need to prune ancestors too. This is necessary to prevent
-		 * quadratic behavior of shrink_dcache_parent(), but is also
-		 * expected to be beneficial in reducing dentry cache
-		 * fragmentation.
-		 */
-		dentry = parent;
-		while (dentry && !lockref_put_or_lock(&dentry->d_lockref))
-			dentry = dentry_kill(dentry);
 	}
 }
 
@@ -1444,8 +1461,11 @@ int d_set_mounted(struct dentry *dentry)
 
 struct select_data {
 	struct dentry *start;
+	union {
+		long found;
+		struct dentry *victim;
+	};
 	struct list_head dispose;
-	int found;
 };
 
 static enum d_walk_ret select_collect(void *_data, struct dentry *dentry)
@@ -1477,6 +1497,37 @@ static enum d_walk_ret select_collect(void *_data, struct dentry *dentry)
 	return ret;
 }
 
+static enum d_walk_ret select_collect2(void *_data, struct dentry *dentry)
+{
+	struct select_data *data = _data;
+	enum d_walk_ret ret = D_WALK_CONTINUE;
+
+	if (data->start == dentry)
+		goto out;
+
+	if (dentry->d_flags & DCACHE_SHRINK_LIST) {
+		if (!dentry->d_lockref.count) {
+			rcu_read_lock();
+			data->victim = dentry;
+			return D_WALK_QUIT;
+		}
+	} else {
+		if (dentry->d_flags & DCACHE_LRU_LIST)
+			d_lru_del(dentry);
+		if (!dentry->d_lockref.count)
+			d_shrink_add(dentry, &data->dispose);
+	}
+	/*
+	 * We can return to the caller if we have found some (this
+	 * ensures forward progress). We'll be coming back to find
+	 * the rest.
+	 */
+	if (!list_empty(&data->dispose))
+		ret = need_resched() ? D_WALK_QUIT : D_WALK_NORETRY;
+out:
+	return ret;
+}
+
 /**
  * shrink_dcache_parent - prune dcache
  * @parent: parent of entries to prune
@@ -1486,12 +1537,9 @@ static enum d_walk_ret select_collect(void *_data, struct dentry *dentry)
 void shrink_dcache_parent(struct dentry *parent)
 {
 	for (;;) {
-		struct select_data data;
+		struct select_data data = {.start = parent};
 
 		INIT_LIST_HEAD(&data.dispose);
-		data.start = parent;
-		data.found = 0;
-
 		d_walk(parent, &data, select_collect);
 
 		if (!list_empty(&data.dispose)) {
@@ -1502,6 +1550,21 @@ void shrink_dcache_parent(struct dentry *parent)
 		cond_resched();
 		if (!data.found)
 			break;
+		d_walk(parent, &data, select_collect2);
+		if (data.victim) {
+			struct dentry *parent;
+			if (!shrink_lock_dentry(data.victim)) {
+				rcu_read_unlock();
+			} else {
+				rcu_read_unlock();
+				parent = data.victim->d_parent;
+				if (parent != data.victim)
+					__dput_to_list(parent, &data.dispose);
+				__dentry_kill(data.victim);
+			}
+		}
+		if (!list_empty(&data.dispose))
+			shrink_dentry_list(&data.dispose);
 	}
 }
 EXPORT_SYMBOL(shrink_dcache_parent);
