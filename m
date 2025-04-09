Return-Path: <linux-fsdevel+bounces-46114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87655A82BF8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 18:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6FCF189DA03
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 16:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8767226563C;
	Wed,  9 Apr 2025 16:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1GMKOb+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2DA1C8637;
	Wed,  9 Apr 2025 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744214668; cv=none; b=CzpR0Y8dYpQv/Eiz5ZzaNi0sSV+WrW3gAUhWeqloW3GnmiZE+qJBazojZCg32UtOIcJnwMzgJmROx6R2h/x7gyV2iK2cwQ2WVcbeg8wrdWyP/Q1RaOtXmrnpafViKADW4gU91yepp9PLDUE6PQO3ryG5Y/qwlBTNnQHh7FTO1ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744214668; c=relaxed/simple;
	bh=LJXw6GutdFoxofjTVjlPgY30HIfUTEXl7NS2iangMwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4O/qGQFv67wDG0VpcS1cZ3Dg4Plip3DElrUAjWeKlF2NgYdlg8pThPPoiOxUDXysgpykq5c/dl35MuKzjT8rUpBqXU8g0/Mx84VqIpn4a6+JEt9Wl52RQwTjhrZlbqMsRVsBPGVTtjyFxuSmqLI5nUaz3+TvRefm9ABaeFPiZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1GMKOb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E429C4CEE3;
	Wed,  9 Apr 2025 16:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744214667;
	bh=LJXw6GutdFoxofjTVjlPgY30HIfUTEXl7NS2iangMwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A1GMKOb+0dSrSYgHkPDIrPOsYmVEDdhJ2SLl54wXFlmZrAC0vgWfZQIl4d/R6U0OI
	 aATXTc06MIx8duU4c3YCY4OLKnVNdx+cdFgfuDlN7BJTcgZusjkEZLawhelsbuYqd0
	 2jNknQlXWPX6ktdWMgXXXi/Mq94fQEycyxignXsmofzBS6Lq065bQS6kuQUaGWY/p5
	 MQGD52v8hg6uuE44c0jdbcBe1jt1glXcj5k10cwlgxS4bGCM/JXrlyagV08vy7IKoQ
	 X7bBIahmszlhjCgPWP5fbHKiIFjsgcoHd2g3us61l4Gd1QXRs4EUjoLTrg6iGHcLE1
	 AcYywKQjZa60w==
Date: Wed, 9 Apr 2025 18:04:21 +0200
From: Christian Brauner <brauner@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Eric Chanudet <echanude@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Alexander Larsson <alexl@redhat.com>, Lucas Karpinski <lkarpins@redhat.com>
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <20250409-beulen-pumpwerk-43fd29a6801e@brauner>
References: <20250408210350.749901-12-echanude@redhat.com>
 <20250409-egalisieren-halbbitter-23bc252d3a38@brauner>
 <20250409131444.9K2lwziT@linutronix.de>
 <4qyflnhrml2gvnvtguj5ee7ewrz3ejhgdb2lfihifzjscc5orh@6ah6qxppgk5n>
 <20250409142510.PIlMaZhX@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250409142510.PIlMaZhX@linutronix.de>

On Wed, Apr 09, 2025 at 04:25:10PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-04-09 16:02:29 [+0200], Mateusz Guzik wrote:
> > On Wed, Apr 09, 2025 at 03:14:44PM +0200, Sebastian Andrzej Siewior wrote:
> > > One question: Do we need this lazy/ MNT_DETACH case? Couldn't we handle
> > > them all via queue_rcu_work()?
> > > If so, couldn't we have make deferred_free_mounts global and have two
> > > release_list, say release_list and release_list_next_gp? The first one
> > > will be used if queue_rcu_work() returns true, otherwise the second.
> > > Then once defer_free_mounts() is done and release_list_next_gp not
> > > empty, it would move release_list_next_gp -> release_list and invoke
> > > queue_rcu_work().
> > > This would avoid the kmalloc, synchronize_rcu_expedited() and the
> > > special-sauce.
> > > 
> > 
> > To my understanding it was preferred for non-lazy unmount consumers to
> > wait until the mntput before returning.
> > 
> > That aside if I understood your approach it would de facto serialize all
> > of these?
> > 
> > As in with the posted patches you can have different worker threads
> > progress in parallel as they all get a private list to iterate.
> > 
> > With your proposal only one can do any work.
> > 
> > One has to assume with sufficient mount/unmount traffic this can
> > eventually get into trouble.
> 
> Right, it would serialize them within the same worker thread. With one
> worker for each put you would schedule multiple worker from the RCU
> callback. Given the system_wq you will schedule them all on the CPU
> which invokes the RCU callback. This kind of serializes it, too.
> 
> The mntput() callback uses spinlock_t for locking and then it frees
> resources. It does not look like it waits for something nor takes ages.
> So it might not be needed to split each put into its own worker on a
> different CPU… One busy bee might be enough ;)

Unmounting can trigger very large number of mounts to be unmounted. If
you're on a container heavy system or services that all propagate to
each other in different mount namespaces mount propagation will generate
a ton of umounts. So this cannot be underestimated.

If a mount tree is wasted without MNT_DETACH it will pass UMOUNT_SYNC to
umount_tree(). That'll cause MNT_SYNC_UMOUNT to be raised on all mounts
during the unmount.

If a concurrent path lookup calls legitimize_mnt() on such a mount and
sees that MNT_SYNC_UMOUNT is set it will discount as it know that the
concurrent unmounter hold the last reference and it __legitimize_mnt()
can thus simply drop the reference count. The final mntput() will be
done by the umounter.

The synchronize_rcu() call in namespace_unlock() takes care that the
last mntput() doesn't happen until path walking has dropped out of RCU
mode.

Without it it's possible that a non-MNT_DETACH umounter gets a spurious
EBUSY error because a concurrent lazy path walk will suddenly put the
last reference via mntput().

I'm unclear how that's handled in whatever it is you're proposing.

