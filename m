Return-Path: <linux-fsdevel+bounces-1600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9513F7DC37C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 01:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D01161C20B54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 00:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0918636F;
	Tue, 31 Oct 2023 00:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ledlpEYJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50955360
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 00:18:58 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA28E124
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 17:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SGYdgWIAUhubBiG2KCPTYUN9+oS+weD66PchvtC9e6o=; b=ledlpEYJbTFmNa37KTYGH+9/Du
	ZRCnpjnuDTfCFeQaHwyFSLH4kGtVZiWYNW2Hvp3dYfZbnZS7MEX1kM7025Bemnf+7IdGkmpbJ/ySS
	i4/RUuBX+PrAOrdbl8p/EySfy2kIKHkIzyy4obq317V6qcHN29FA28ShnqghVXBKULu/nbpg4kCge
	fMbY4qIrvSfNuLhW5bpFsZzfLnIY65m/SWn0hF2NwQASzAfsKA7d75aKCoh7crztdeNc/avhlCJkx
	QPaLlRpvz3U1y7j41nvJ/DcoFjBFDJMB6vDV3ToR0uogISG/AkN46h02Mwnx7eyRpQyGtsiiUbfGy
	LqWBa84w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qxcT2-008D66-2Q;
	Tue, 31 Oct 2023 00:18:48 +0000
Date: Tue, 31 Oct 2023 00:18:48 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] simplifying fast_dput(), dentry_kill() et.al.
Message-ID: <20231031001848.GX800259@ZenIV>
References: <20231030003759.GW800259@ZenIV>
 <20231030215315.GA1941809@ZenIV>
 <CAHk-=wjGv_rgc8APiBRBAUpNsisPdUV3Jwco+hp3=M=-9awrjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjGv_rgc8APiBRBAUpNsisPdUV3Jwco+hp3=M=-9awrjQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Oct 30, 2023 at 12:18:28PM -1000, Linus Torvalds wrote:
> On Mon, 30 Oct 2023 at 11:53, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > After fixing a couple of brainos, it seems to work.
> 
> This all makes me unnaturally nervous, probably because it;s overly
> subtle, and I have lost the context for some of the rules.

A bit of context: I started to look at the possibility of refcount overflows.
Writing the current rules for dentry refcounting and lifetime down was the
obvious first step, and that immediately turned into an awful mess.

It is overly subtle.  Even more so when you throw the shrink lists into
the mix - shrink_lock_dentry() got too smart for its own good, and that
leads to really awful correctness proofs.  The next thing in the series
is getting rid of the "it had been moved around, so somebody had clearly
been taking/dropping references and we can just evict it from the
shrink list and be done with that" crap - the things get much simpler
if the rules become
	* call it under rcu_read_lock, with dentry locked
	* if returned true
		dentry, parent, inode locked, refcount is zero.
	* if returned false
		dentry locked, refcount is non-zero.
It used to be that way, but removal of trylock loops had turned that
into something much more subtle.  Restoring the old semantics without
trylocks on the slow path is doable and it makes analysis much simpler.

BTW, where how aggressive do we want to be with d_lru_del()?

We obviously do not do that on non-final dput, even if we have
a dentry with positive refcount in LRU list.  But when we hit e.g.
shrink_dcache_parent(), all dentries in the subtree get d_lru_del(),
whether they are busy or not.  I'm not sure it's a good idea...

Sure, we want __dentry_kill() to remove the victim from LRU and
we want the same done to anything moved to a shrink list.
Having LRU scanners ({prune,shrink}_dcache_sb() do that to
dentries with positive refcount also makes sense.  Do we really need
the other cases?

