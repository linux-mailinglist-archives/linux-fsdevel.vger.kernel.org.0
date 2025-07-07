Return-Path: <linux-fsdevel+bounces-54152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC43AFB9E9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 19:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06BDA423CE0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 17:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E242E8899;
	Mon,  7 Jul 2025 17:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wj0UWvEs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9411E225A4F;
	Mon,  7 Jul 2025 17:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751909400; cv=none; b=jXYLmm//ZfXwnPZJZJQMP4qqByEn+SMOeAVnGqgnJKsO3YClHC7t0wmOIdF7fOpFXcYWn6Y9859J5i4s4z1OImPUm/o4+p9a5qL+0mzlmHyLeOfTxAAiBfihITXmUn6INHeEGGd3k6KcFs8sYmvqNS6yW4/gMvNOz9UKOP+o0+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751909400; c=relaxed/simple;
	bh=FtEowuhfcOOOiyQ2PpjNd7M6UE+oxTocEUXgfpzwX3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkLWkNA+qnnJVmOzkobHbMt0+g0OkklGDDuxLjBFTmqTs16jvQ07p/KXvHjCKjlbNBOXia7gNPFc9HFQj3MVpVqEBSSzdQlhQu1lAOHndWA8WJDCFex6lpIF4wTyyly+JLgXMLU7zKrNcJ2rt2aUhlnkeE04vhvUysLaN3JKSaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wj0UWvEs; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=uNhAo0VdHWafj0mRAFVLgPlLt5WpNlZt/Ie1pR7a2e0=; b=wj0UWvEscNxPp0Skd0APC+bCEU
	VG8vGj+abQxkTwiTKwm57VGkGNtp3CDrQp/EG5XZ80Y673qWov29PxuqdRtAvmLgkb0MLHTrcLCsv
	6mePdFGSdv3KhbhkDQsuGP7bpev5RVx6+ncRIh84YWiLVHTsFY27xxIVkgyfPa7RZqWTAIMSuYXRR
	B8VFYxUMNeTXqr0UTJYtLbAp8mV0B8G9rIH0rR7mQKFPa8xEDSagmlVZMj2Upb688Piz/+h/r81gS
	0f7Uqjt7BIanwcvDTNzfdvl+a/z0iPwe5R5go1Db2cbpphLgfmjETkkTnvN4iFkSF2tStyjgRh8PJ
	Y+4DuSaw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYpfB-00000002RhA-0495;
	Mon, 07 Jul 2025 17:29:57 +0000
Date: Mon, 7 Jul 2025 18:29:56 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 20/21] __dentry_kill(): new locking scheme
Message-ID: <20250707172956.GF1880847@ZenIV>
References: <20231124060200.GR38156@ZenIV>
 <20231124060422.576198-1-viro@zeniv.linux.org.uk>
 <20231124060422.576198-20-viro@zeniv.linux.org.uk>
 <CAKPOu+_Ktbp5OMZv77UfLRyRaqmK1kUpNHNd1C=J9ihvjWLDZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+_Ktbp5OMZv77UfLRyRaqmK1kUpNHNd1C=J9ihvjWLDZg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jul 07, 2025 at 07:20:28PM +0200, Max Kellermann wrote:

> On Mon, Jul 7, 2025 at 7:04 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > @@ -1478,6 +1444,8 @@ static enum d_walk_ret select_collect(void *_data, struct dentry *dentry)
> >         } else if (!dentry->d_lockref.count) {
> >                 to_shrink_list(dentry, &data->dispose);
> >                 data->found++;
> > +       } else if (dentry->d_lockref.count < 0) {
> > +               data->found++;
> >         }
> >         /*
> >          * We can return to the caller if we have found some (this
> 
> I have doubts about this part of your patch. (Warning: I don't really
> know what your patch is about.)
> 
> Why does this new check exist?
> (It checks for "dead" or "killed" entries, but why aren't you using
> __lockref_is_dead() here?)

What's the difference?  It checks for dentries currently still going through
->d_prune()/->d_iput()/->d_release().

> Actual problem why I found this: while debugging (yet another) Ceph
> bug, I found that a kworker is busy-looping inside
> shrink_dcache_parent(). Each iteration finds a dead/killed dentry,
> thus "found=true" and the loop keeps on looping forever, yet nothing
> ever gets done.
> It does this because a userspace process is trying to write to Ceph
> file, that write() system call invokes the shrinker (via
> filmap_add_folio() / memcg). The shrinker calls shrink_dentry_list(),
> __dentry_kill() - now that dentry is dead/killed, but it remains
> listed in the parent because the thread is stuck in ceph_evict_inode()
> / netfs_wait_for_outstanding_io().
> 
> I am seeing this because Ceph doesn't finish I/O on the inode, which
> causes the kworker to busy-loop forever without making any progress.
> But even if Ceph weren't as buggy as it is, there may still be some
> time waiting for the Ceph server, and that will always cause brief
> periods of busy-looping in the kworker, won't it?
> 
> I don't know how to solve this (I have no idea about the dcache,
> having opened its source for the first time today), but I wonder why
> select_collect() ever cares about dead/killed dentries. Removing that
> check seems like the obvious solution, but there must be a reason why
> you added it.

shrink_dcache_parent() is "evict everything that can be evicted in the
subtree"; no idea whether it's the right primitive for your usecase.

Note that these suckers *do* keep their ancestors pinned; as the result
we are, e.g., guaranteed sane ordering on RCU grace periods for their
freeing, etc.  One thing we definitely do not want is eviction of parent
started before its child is done with __dentry_kill()...

What are you using shrink_dcache_parent() for?

