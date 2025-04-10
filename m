Return-Path: <linux-fsdevel+bounces-46191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87175A8412F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 12:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63B9B1B64E9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 10:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994C2280CFF;
	Thu, 10 Apr 2025 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUApE152"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB88D1BE251;
	Thu, 10 Apr 2025 10:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744282142; cv=none; b=VlHA2u4AW7H5ODANmA337J3+U6F9uqQyiQqxvkSF05P3E8VVG+03WFiXr9wTSFoG25CW6gYWJj8NmEMlKW6X9TzJkoeWsTNtBzyER8fqkCQkCkCbIR4jxeSvIFn1RfBx9TRcYqac8sNEjgQG4fiSxM2dG7Sfy/VnNJZ/aFI2g/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744282142; c=relaxed/simple;
	bh=/NhiV3gottCOgyGQcBZLvsI/ykcFkatAj4iNJ48uWS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcPHgAKJQnEaTsBAG+TlWM5vA/KCrptNBVo+ZfvzKSkdrH2cKLCGMLVULOBJSMksMUD/SKrFNMUuSxf+nj0HJluTz1QwOOJX+Z0xP6DND2v4Bc8d0lKhLAXOheZe2weulSWt4oVO0iHZdpdaK0RA2rkBnNgS6pv5KtYAHGwxgXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUApE152; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5BDC4CEDD;
	Thu, 10 Apr 2025 10:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744282140;
	bh=/NhiV3gottCOgyGQcBZLvsI/ykcFkatAj4iNJ48uWS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rUApE1528EJh++UiYMicKHN0V88lzBBQWYtB4eRJcarSAaz2ewnlCqIa8pQHt2xls
	 MCbj4KwqywHXDPy4ooLvW2QuiLC8TEci/pqVdfsd3QkJ13plYyP9ICAghAMBB3Xlr6
	 pLh5hjVTTj0Ol7lW+5oeZjehPg5fKvHtungljaY/1wN0HdjGqRcrk9GAayk0MbpWMR
	 1sokIHRmtdYQmZ2I4wJEt265bQSi2CtB0MVXWT70LYejRHBADOjPzuSH0N+eMzH5BT
	 lMP9SiGxwk53SUBfQ+OcjWqwhLcMcYV7Fh9SZkGVqv4JnfbrCtUMP4+G+wNl8qlST2
	 JPoGVesJIOBtQ==
Date: Thu, 10 Apr 2025 12:48:54 +0200
From: Christian Brauner <brauner@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Eric Chanudet <echanude@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Alexander Larsson <alexl@redhat.com>, Lucas Karpinski <lkarpins@redhat.com>
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <20250410-infostand-faktor-3bb06919209e@brauner>
References: <20250408210350.749901-12-echanude@redhat.com>
 <20250409-egalisieren-halbbitter-23bc252d3a38@brauner>
 <20250409131444.9K2lwziT@linutronix.de>
 <4qyflnhrml2gvnvtguj5ee7ewrz3ejhgdb2lfihifzjscc5orh@6ah6qxppgk5n>
 <20250409142510.PIlMaZhX@linutronix.de>
 <20250409-beulen-pumpwerk-43fd29a6801e@brauner>
 <20250410082833.pjvaYuCM@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250410082833.pjvaYuCM@linutronix.de>

On Thu, Apr 10, 2025 at 10:28:33AM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-04-09 18:04:21 [+0200], Christian Brauner wrote:
> > On Wed, Apr 09, 2025 at 04:25:10PM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2025-04-09 16:02:29 [+0200], Mateusz Guzik wrote:
> > > > On Wed, Apr 09, 2025 at 03:14:44PM +0200, Sebastian Andrzej Siewior wrote:
> > > > > One question: Do we need this lazy/ MNT_DETACH case? Couldn't we handle
> > > > > them all via queue_rcu_work()?
> > > > > If so, couldn't we have make deferred_free_mounts global and have two
> > > > > release_list, say release_list and release_list_next_gp? The first one
> > > > > will be used if queue_rcu_work() returns true, otherwise the second.
> > > > > Then once defer_free_mounts() is done and release_list_next_gp not
> > > > > empty, it would move release_list_next_gp -> release_list and invoke
> > > > > queue_rcu_work().
> > > > > This would avoid the kmalloc, synchronize_rcu_expedited() and the
> > > > > special-sauce.
> > > > > 
> > > > 
> > > > To my understanding it was preferred for non-lazy unmount consumers to
> > > > wait until the mntput before returning.
> > > > 
> > > > That aside if I understood your approach it would de facto serialize all
> > > > of these?
> > > > 
> > > > As in with the posted patches you can have different worker threads
> > > > progress in parallel as they all get a private list to iterate.
> > > > 
> > > > With your proposal only one can do any work.
> > > > 
> > > > One has to assume with sufficient mount/unmount traffic this can
> > > > eventually get into trouble.
> > > 
> > > Right, it would serialize them within the same worker thread. With one
> > > worker for each put you would schedule multiple worker from the RCU
> > > callback. Given the system_wq you will schedule them all on the CPU
> > > which invokes the RCU callback. This kind of serializes it, too.
> > > 
> > > The mntput() callback uses spinlock_t for locking and then it frees
> > > resources. It does not look like it waits for something nor takes ages.
> > > So it might not be needed to split each put into its own worker on a
> > > different CPU… One busy bee might be enough ;)
> > 
> > Unmounting can trigger very large number of mounts to be unmounted. If
> > you're on a container heavy system or services that all propagate to
> > each other in different mount namespaces mount propagation will generate
> > a ton of umounts. So this cannot be underestimated.
> 
> So you want to have two of these unmounts in two worker so you can split
> them on two CPUs in best case. As of today, in order to get through with
> umounts asap you accelerate the grace period. And after the wake up may
> utilize more than one CPU.
> 
> > If a mount tree is wasted without MNT_DETACH it will pass UMOUNT_SYNC to
> > umount_tree(). That'll cause MNT_SYNC_UMOUNT to be raised on all mounts
> > during the unmount.
> > 
> > If a concurrent path lookup calls legitimize_mnt() on such a mount and
> > sees that MNT_SYNC_UMOUNT is set it will discount as it know that the
> > concurrent unmounter hold the last reference and it __legitimize_mnt()
> > can thus simply drop the reference count. The final mntput() will be
> > done by the umounter.
> > 
> > The synchronize_rcu() call in namespace_unlock() takes care that the
> > last mntput() doesn't happen until path walking has dropped out of RCU
> > mode.
> > 
> > Without it it's possible that a non-MNT_DETACH umounter gets a spurious
> > EBUSY error because a concurrent lazy path walk will suddenly put the
> > last reference via mntput().
> > 
> > I'm unclear how that's handled in whatever it is you're proposing.
> 
> Okay. So we can't do this for UMOUNT_SYNC callers, thank you for the
> explanation. We could avoid the memory allocation and have one worker to
> take care of them all but you are afraid what this would mean to huge
> container. Understandable. The s/system_wq/system_unbound_wq/ would make
> sense.

Don't get me wrong if you have a clever idea here I'm all ears.

