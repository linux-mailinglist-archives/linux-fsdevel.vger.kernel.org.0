Return-Path: <linux-fsdevel+bounces-2204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 404D07E32CB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 03:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BACC6B20B81
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 02:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7EB1FA6;
	Tue,  7 Nov 2023 02:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QWes4iKf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD34617F4
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 02:08:13 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2948109
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 18:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lmTUbJ7E9Zwce85ZvLlrLrmV8PFns5jlXkuzMtRzMTY=; b=QWes4iKfLlHSum4O9fSNz85+pZ
	BdZUXzVa1m+EWCuVYOzDCjqv1cOWPW8dH2OrRzIPRjhu85AUfw2vAAW+FNICqTOgI9JYNspEhh2TT
	H09hzR2t0bRRWo4Ww1PG3wl7LAxqZrBMbuAzMNBmvdUmFAxalNeTyICXlqBmovb5va/WwReOqbAjs
	u3ZUKh5IZE+u3ysg0V6ju0duEmgwrMAFIfREZhUP1EdeMDaXffD43hxxysIkhpk/iJ9THqVjLFEfl
	w64lqhnXMvO/FyUXLUtKBbEs00twMPbaURYWyQcsU/8p1aGbx2ewLXrxihFzKo+FkWykCOirhWHCg
	Qyz1B8eg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0BVd-00CLW9-0x;
	Tue, 07 Nov 2023 02:08:05 +0000
Date: Tue, 7 Nov 2023 02:08:05 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [RFC] simplifying fast_dput(), dentry_kill() et.al.
Message-ID: <20231107020805.GA2940624@ZenIV>
References: <20231030003759.GW800259@ZenIV>
 <20231030215315.GA1941809@ZenIV>
 <CAHk-=wjGv_rgc8APiBRBAUpNsisPdUV3Jwco+hp3=M=-9awrjQ@mail.gmail.com>
 <20231031001848.GX800259@ZenIV>
 <20231105195416.GA2771969@ZenIV>
 <20231106055353.GT1957730@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106055353.GT1957730@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Nov 06, 2023 at 05:53:53AM +0000, Al Viro wrote:

> AFAICS, there are 3 options:
> 	1) leave the current weirdness with ->d_iput() on child vs __dentry_kill()
> on parent.  Document the requirement to ->d_iput() (and ->d_release()) to cope
> with that, promise that in case of sillyrename the ordering will be there and
> write down the proof of that.  No code changes, rather revolting docs to
> write, trouble waiting to happen in ->d_iput().
> 	2) require that shrink_dentry_list() should never overlap with
> shrink_dcache_for_umount() on any of the filesystems represented in the
> shrink list, guarantee that parent won't get to __dentry_kill() before
> the child gets through __dentry_kill() completely and accept that resurrecting
> SMO stuff will require more work.  Smallish patch, tolerable docs, probably
> the best option at the moment.
> 	3) bite the bullet and get shrink_dentry_list() to coexist with
> shrink_dcache_for_umount(), with sane ordering of ->d_iput() vs. parent's
> __dentry_kill().  Doable, but AFAICS it will take a counter of children
> currently being killed in the parent dentry.  shrink_dentry_list() would
> bump that on parent, __dentry_kill() the victim, then relock the parent
> and decrement that counter along with the main refcount.  That would allow
> the shrink_dcache_for_umount() to cope with that crap.  No requirements
> for shrink_dentry_kill() callers that way, sane environment for ->d_iput(),
> no obstacles for SMO stuff.  OTOH, we need to get space for additional
> counter in struct dentry; again, doable (->d_subdirs/->d_child can be
> converted to hlist, saving us a pointer in each dentry), but... I'd
> leave that option alone until something that needs it would show up
> (e.g. if/when Tobin resurrects his patchset).

	4) instead of having __dentry_kill() called with dentry, parent
and inode locked and doing
	->d_prune
	unhash
	remove from list of children
	unlock parent
	detach from inode
	unlock dentry and inode
	drop inode
	->d_release
	relock dentry
	if on shrink list, mark as ready to free 
	unlock dentry
	if was not on shrink list, free it
go for calling it with just dentry and inode locked and do
	->d_prune
	unhash
	detach from inode
	unlock dentry and inode
	drop inode
	->d_release
	lock parent (if any, as usual)
	lock dentry
	remove from list of children
	if on shrink list, mark as ready to free
	unlock dentry
	if was on shrink list, free it
	decrement parent's refcount (again, if there was a parent)
	if refcount is still positive - unlock parent and return NULL
	otherwise return parent

What changes:
	* caller needs milder locking environment; lock_for_kill() gets simpler.
	  Note that only positive dentries can be moved, so inside __dentry_kill()
	  we need no retry loops, etc. - ->d_parent is stable by the point we decide
	  to remove from the list of children.
	* code that iterates through the list of children (not much of it)
	  needs to cope with seeing negative unhashed dentries with
	  refcount marked dead.  Most of it will need no changes at all.
	* ->d_prune() instances are called without parent's ->d_lock; just
	  the victim's one.  Might require changes to out-of-tree filesystems.
	* dput() turns into
	if (!dentry)
		return;
	rcu_read_lock()
	if (fast_dput(dentry)) {
		rcu_read_unlock();
		return;
	}
	while (lock_for_kill(dentry)) { // not bothering with the parent
		rcu_read_unlock();
		dentry = __dentry_kill(dentry);
		if (!dentry)
			return;
		if (retain_dentry(dentry)) {
			spin_unlock(&dentry->d_lock);
			return;
		}
		rcu_read_lock();
	}
	spin_unlock(&dentry->d_lock);
	rcu_read_unlock();
since there's no point trying to avoid locking the parents - we need
to grab those locks at some point anyway, just to remove a child from
the list of children, and that way we return from __dentry_kill() with
that lock held.
	* shrink_dentry_list() eviction of parents happens thus:
	do {
		rcu_read_unlock();
		victim = __dentry_kill(victim);
		rcu_read_lock();
	while (victim && lock_for_kill(victim));
	rcu_read_unlock();
	if (victim)
		spin_unlock(&victim->d_lock);
	* sane order of ->d_iput() on child vs. __dentry_kill() on parent.
	* shrink_dcache_for_umount() does the right thing even if it
overlaps shrink_dentry_list().

	If that works, it's probably the best variant...

