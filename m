Return-Path: <linux-fsdevel+bounces-2038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8987E19C2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 06:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7A671C208DC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 05:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DAE9479;
	Mon,  6 Nov 2023 05:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ix1If3MS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21F72F3D
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 05:54:02 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFE6FA
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 21:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4LFx2uJK3RreDExaN6D+O5qLkX+7hlfaAnN+8iUDFIk=; b=Ix1If3MStBllmBukiEkYvOR3vT
	00K0sDIS7JTDqXxPrVRKYCI1bGShIDCb8L3wUkCqEaLxYlmQQUdR8EysFchar7crvltU7cdMj9IHU
	CeuT1VlN00HKF7qr/wPb/0l2FHskEXVJ43OWY3Vvc6T8tIhBYzfr2FRyrO+PmNhbcZUeA6Iqmk7ZU
	fCa8sFm81OkIL0DRvWeF3EUvUb6gvrWx+PX05ByTZQBodr/hTlhpeKDcRtW1gzB5twqLO2X18QjjQ
	6+3yS3tEDauG0+tOhPEK98wJGaDfIGkia/ojQfJ7l2kQ6vFTksYWLLQuLx8Kl01uiq0CqRq04oukH
	EDzFlKsg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qzsYb-00BrlN-0g;
	Mon, 06 Nov 2023 05:53:53 +0000
Date: Mon, 6 Nov 2023 05:53:53 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [RFC] simplifying fast_dput(), dentry_kill() et.al.
Message-ID: <20231106055353.GT1957730@ZenIV>
References: <20231030003759.GW800259@ZenIV>
 <20231030215315.GA1941809@ZenIV>
 <CAHk-=wjGv_rgc8APiBRBAUpNsisPdUV3Jwco+hp3=M=-9awrjQ@mail.gmail.com>
 <20231031001848.GX800259@ZenIV>
 <20231105195416.GA2771969@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231105195416.GA2771969@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Nov 05, 2023 at 07:54:16PM +0000, Al Viro wrote:
> On Tue, Oct 31, 2023 at 12:18:48AM +0000, Al Viro wrote:
> > On Mon, Oct 30, 2023 at 12:18:28PM -1000, Linus Torvalds wrote:
> > > On Mon, 30 Oct 2023 at 11:53, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > >
> > > > After fixing a couple of brainos, it seems to work.
> > > 
> > > This all makes me unnaturally nervous, probably because it;s overly
> > > subtle, and I have lost the context for some of the rules.
> > 
> > A bit of context: I started to look at the possibility of refcount overflows.
> > Writing the current rules for dentry refcounting and lifetime down was the
> > obvious first step, and that immediately turned into an awful mess.
> > 
> > It is overly subtle.
> 
> 	Another piece of too subtle shite: ordering of ->d_iput() of child
> and __dentry_kill() of parent.  As it is, in some cases it is possible for
> the latter to happen before the former.  It is *not* possible in the cases
> when in-tree ->d_iput() instances actually look at the parent (all of those
> are due to sillyrename stuff), but the proof is convoluted and very brittle.
> 
> 	The origin of that mess is in the interaction of shrink_dcache_for_umount()
> with shrink_dentry_list().  What we want to avoid is a directory looking like
> it's busy since shrink_dcache_for_umount() doesn't see any children to account
> for positive refcount of parent.  The kinda-sorta solution we use is to decrement
> the parent's refcount *before* __dentry_kill() of child and put said parent
> into a shrink list.  That makes shrink_dcache_for_umount() do the right thing,
> but it's possible to end up with parent freed before the child is done with;
> scenario is non-obvious, and rather hard to hit, but it's not impossible.

D'oh...  We actually don't need to worry about eviction on memory pressure at that
point; unregister_shrinker() is done early enough to prevent that.

So shrink_dcache_for_umount() does not need to worry about shrink lists use
in prune_dcache_sb().

Use in namespace_unlock() is guaranteed that all dentries involved either
have a matching mount in the list of mounts to be dropped (and thus protected
from simultaneous fs shutdown) or have a matching mount pinned by the caller.

Use in mntput_no_expire() is guaranteed the same - all dentries involved are
on superblock of mount we are going to drop after the call of shrink_dentry_list().

All other users also either have an active reference to superblock or are done
by ->kill_sb() synchronously (and thus can't race with shrink_dcache_for_umount())
or are done async, but flushed and/or waited for by foofs_kill_sb() before
they get to shrink_dcache_for_umount().

IOW, I'd been too paranoid in "Teach shrink_dcache_parent() to cope with
mixed-filesystem shrink lists" - the real requirements are milder; in-tree
users didn't need these games with parent.  Dcache side of Tobin's Slab
Movable Objects patches needed those, though...

AFAICS, there are 3 options:
	1) leave the current weirdness with ->d_iput() on child vs __dentry_kill()
on parent.  Document the requirement to ->d_iput() (and ->d_release()) to cope
with that, promise that in case of sillyrename the ordering will be there and
write down the proof of that.  No code changes, rather revolting docs to
write, trouble waiting to happen in ->d_iput().
	2) require that shrink_dentry_list() should never overlap with
shrink_dcache_for_umount() on any of the filesystems represented in the
shrink list, guarantee that parent won't get to __dentry_kill() before
the child gets through __dentry_kill() completely and accept that resurrecting
SMO stuff will require more work.  Smallish patch, tolerable docs, probably
the best option at the moment.
	3) bite the bullet and get shrink_dentry_list() to coexist with
shrink_dcache_for_umount(), with sane ordering of ->d_iput() vs. parent's
__dentry_kill().  Doable, but AFAICS it will take a counter of children
currently being killed in the parent dentry.  shrink_dentry_list() would
bump that on parent, __dentry_kill() the victim, then relock the parent
and decrement that counter along with the main refcount.  That would allow
the shrink_dcache_for_umount() to cope with that crap.  No requirements
for shrink_dentry_kill() callers that way, sane environment for ->d_iput(),
no obstacles for SMO stuff.  OTOH, we need to get space for additional
counter in struct dentry; again, doable (->d_subdirs/->d_child can be
converted to hlist, saving us a pointer in each dentry), but... I'd
leave that option alone until something that needs it would show up
(e.g. if/when Tobin resurrects his patchset).

	My preference would be (2) for the coming cycle + prototype of
a patch doing (3) on top of that for the future.

Completely untested diff for (2) (on top of #work.dcache, sans the
documentation update) below:

diff --git a/fs/dcache.c b/fs/dcache.c
index ccf41c5ee804..c978207f3fc4 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1086,10 +1086,27 @@ void d_prune_aliases(struct inode *inode)
 }
 EXPORT_SYMBOL(d_prune_aliases);
 
+static inline void shrink_kill(struct dentry *victim, struct list_head *list)
+{
+	struct dentry *parent = victim->d_parent;
+
+	__dentry_kill(victim);
+
+	if (parent == victim || lockref_put_or_lock(&parent->d_lockref))
+		return;
+
+	if (!WARN_ON_ONCE(parent->d_lockref.count != 1)) {
+		parent->d_lockref.count = 0;
+		to_shrink_list(parent, list);
+	}
+	spin_unlock(&parent->d_lock);
+}
+
+
 void shrink_dentry_list(struct list_head *list)
 {
 	while (!list_empty(list)) {
-		struct dentry *dentry, *parent;
+		struct dentry *dentry;
 
 		dentry = list_entry(list->prev, struct dentry, d_lru);
 		spin_lock(&dentry->d_lock);
@@ -1106,10 +1123,7 @@ void shrink_dentry_list(struct list_head *list)
 		}
 		rcu_read_unlock();
 		d_shrink_del(dentry);
-		parent = dentry->d_parent;
-		if (parent != dentry && !--parent->d_lockref.count)
-			to_shrink_list(parent, list);
-		__dentry_kill(dentry);
+		shrink_kill(dentry, list);
 	}
 }
 
@@ -1537,19 +1551,14 @@ void shrink_dcache_parent(struct dentry *parent)
 			break;
 		data.victim = NULL;
 		d_walk(parent, &data, select_collect2);
-		if (data.victim) {
-			struct dentry *parent;
+		if (data.victim) { // rcu_read_lock held - see select_collect2()
 			spin_lock(&data.victim->d_lock);
 			if (!lock_for_kill(data.victim)) {
 				spin_unlock(&data.victim->d_lock);
 				rcu_read_unlock();
 			} else {
 				rcu_read_unlock();
-				parent = data.victim->d_parent;
-				if (parent != data.victim &&
-				    !--parent->d_lockref.count)
-					to_shrink_list(parent, &data.dispose);
-				__dentry_kill(data.victim);
+				shrink_kill(data.victim, &data.dispose);
 			}
 		}
 		if (!list_empty(&data.dispose))

