Return-Path: <linux-fsdevel+bounces-2029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CFD7E1621
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 20:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDBB81C20AAE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 19:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DA118057;
	Sun,  5 Nov 2023 19:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="s+7QQrJ0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FA01642B
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 19:54:25 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D568C0
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 11:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Nsz/cUr5WmQh9J+XkjCu3Ca4uTEE9F9La13x1fHr3fg=; b=s+7QQrJ0IZoJz6EINf1Ggx0Ue7
	JPB4B9lxXA+LSzjRAtGLYtUo+KKMtMdrTo/8lPz3tjrc/EiZWGkGrAEFkDJTbuSaW+oBnCVgxfOtL
	ho99VVr5mzFzz1i0YgZib+d578GlJZnU04wvuacdrsQ88fTuRamUgvL8PwalYJtFuqCIrdr1G+vPJ
	gvkVztQTl3Ez7B86LbApd/7W05euwjEnomS2+YwJjhLNluWQ76T+46Qn0v5dEwkh+B9URGMOhMG7Q
	cuvA7pe+OTMBtzb6sz568Z0Il4KtSKBkZUzHdiPe+dugVnwuLjAESOQFNdSPs6tyKPyHCa8GKk0Sa
	ZApwdM3w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qzjCK-00BeHF-0R;
	Sun, 05 Nov 2023 19:54:16 +0000
Date: Sun, 5 Nov 2023 19:54:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] simplifying fast_dput(), dentry_kill() et.al.
Message-ID: <20231105195416.GA2771969@ZenIV>
References: <20231030003759.GW800259@ZenIV>
 <20231030215315.GA1941809@ZenIV>
 <CAHk-=wjGv_rgc8APiBRBAUpNsisPdUV3Jwco+hp3=M=-9awrjQ@mail.gmail.com>
 <20231031001848.GX800259@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031001848.GX800259@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Oct 31, 2023 at 12:18:48AM +0000, Al Viro wrote:
> On Mon, Oct 30, 2023 at 12:18:28PM -1000, Linus Torvalds wrote:
> > On Mon, 30 Oct 2023 at 11:53, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > After fixing a couple of brainos, it seems to work.
> > 
> > This all makes me unnaturally nervous, probably because it;s overly
> > subtle, and I have lost the context for some of the rules.
> 
> A bit of context: I started to look at the possibility of refcount overflows.
> Writing the current rules for dentry refcounting and lifetime down was the
> obvious first step, and that immediately turned into an awful mess.
> 
> It is overly subtle.

	Another piece of too subtle shite: ordering of ->d_iput() of child
and __dentry_kill() of parent.  As it is, in some cases it is possible for
the latter to happen before the former.  It is *not* possible in the cases
when in-tree ->d_iput() instances actually look at the parent (all of those
are due to sillyrename stuff), but the proof is convoluted and very brittle.

	The origin of that mess is in the interaction of shrink_dcache_for_umount()
with shrink_dentry_list().  What we want to avoid is a directory looking like
it's busy since shrink_dcache_for_umount() doesn't see any children to account
for positive refcount of parent.  The kinda-sorta solution we use is to decrement
the parent's refcount *before* __dentry_kill() of child and put said parent
into a shrink list.  That makes shrink_dcache_for_umount() do the right thing,
but it's possible to end up with parent freed before the child is done with;
scenario is non-obvious, and rather hard to hit, but it's not impossible.

	dput() does no such thing - it does not decrement the parent's
refcount until the child had been taken care of.  That's fine, as far
as shrink_dcache_for_umount() is concerned - this is not a false positive;
with slightly different timing shrink_dcache_for_umount() would've reported
the child as being busy.  IOW, there should be no overlap between dput()
in one thread and shrink_dcache_for_umount() in another.  Unfortunately,
memory eviction *can* come in the middle of shrink_dcache_for_umount().

	Life would be much simpler if shrink_dentry_list() would not have
to pull that kind of tricks and used the same ordering as dput() does.
IMO there's a reasonably cheap way to achieve that:

	* have shrink_dcache_for_umount() mark the superblock (either in
->s_flags or inside the ->s_dentry_lru itself) and have the logics
in retain_dentry() that does insertion into LRU list check ->d_sb for that
mark, treating its presence as "do not retain".
	* after marking the superblock shrink_dentry_for_umount() is guaranteed
that nothing new will be added to shrink list in question.  Have it call
shrink_dcache_sb() to drain LRU.
	* Now shrink_dentry_list() in one thread hitting a dentry on
a superblock going throug shrink_dcache_for_umount() in another thread is
always a bug and reporting busy dentries is the right thing to do.
So we can switch shrink_dentry_list() to the same "drop reference to parent
only after the child had been killed" ordering as we have in dput().

	IMO that removes a fairly nasty trap for ->d_iput() and ->d_delete()
instances.  As for the overhead, the relevant fragment of retain_dentry() is
	if (unlikely(!(dentry->d_flags & DCACHE_LRU_LIST)))
		d_lru_add(dentry);
	else if (unlikely(!(dentry->d_flags & DCACHE_REFERENCED)))
		dentry->d_flags |= DCACHE_REFERENCED;
	return true;
That would become
	if (unlikely(!(dentry->d_flags & DCACHE_LRU_LIST))) {
		if (unlikely(dentry->d_sb is marked))
			return false;
		d_lru_add(dentry);
	} else if (unlikely(!(dentry->d_flags & DCACHE_REFERENCED)))
		dentry->d_flags |= DCACHE_REFERENCED;
	return true;
Note that d_lru_add() will hit ->d_sb->s_dentry_lru, so we are not
adding memory traffic here; the else if part doesn't need to be
touched - we only need to prevent insertions into LRU.

	Comments?

