Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBB4D5A912
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2019 06:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfF2Ei0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jun 2019 00:38:26 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50240 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfF2Ei0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jun 2019 00:38:26 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hh57j-0003uX-CH; Sat, 29 Jun 2019 04:38:03 +0000
Date:   Sat, 29 Jun 2019 05:38:03 +0100
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
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: shrink_dentry_list() logics change (was Re: [RFC PATCH v3 14/15]
 dcache: Implement partial shrink via Slab Movable Objects)
Message-ID: <20190629043803.GT17978@ZenIV.linux.org.uk>
References: <20190411013441.5415-1-tobin@kernel.org>
 <20190411013441.5415-15-tobin@kernel.org>
 <20190411023322.GD2217@ZenIV.linux.org.uk>
 <20190411024821.GB6941@eros.localdomain>
 <20190411044746.GE2217@ZenIV.linux.org.uk>
 <20190411210200.GH2217@ZenIV.linux.org.uk>
 <20190629040844.GS17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190629040844.GS17978@ZenIV.linux.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 29, 2019 at 05:08:44AM +0100, Al Viro wrote:
> > The reason we don't hit that problem with regular memory shrinker is
> > this:
> >                 unregister_shrinker(&s->s_shrink);
> >                 fs->kill_sb(s);
> > in deactivate_locked_super().  IOW, shrinker for this fs is gone
> > before we get around to shutdown.  And so are all normal sources
> > of dentry eviction for that fs.
> > 
> > Your earlier variants all suffer the same problem - picking a page
> > shared by dentries from several superblocks can run into trouble
> > if it overlaps with umount of one of those.

PS: the problem is not gone in the next iteration of the patchset in
question.  The patch I'm proposing (including dput_to_list() and _ONLY_
compile-tested) follows.  Comments?

diff --git a/fs/dcache.c b/fs/dcache.c
index 8136bda27a1f..dfe21a649c96 100644
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
 
