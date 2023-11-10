Return-Path: <linux-fsdevel+bounces-2724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2097E7C95
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 14:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D1971F20D49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 13:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61FF1A26B;
	Fri, 10 Nov 2023 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8DVG5/i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED58D19BB9
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 13:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888C0C433C8;
	Fri, 10 Nov 2023 13:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699623265;
	bh=gJqEphiET27uGvfKKvZmJWhA0bIKvWTPRoTa13fmqq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T8DVG5/ibnfj8VvI8VAfWT9RgKp3aexq5WF72RFdxI8buzYBgMzVmy7xEFe/Rrhar
	 Duf2QfoixxRtp4C3zKJ6ZiOlmMrQiE7+W5a13mPVoiLwQoqC0ZEHo79k5DgPGUldWo
	 BVsmNwB3vg3rFBYlJDrJ6JYHudHE5AACns8ljC8PRbLNaAbibZQfNzOzC15JsJ/yLs
	 zZpgk8SOBnDQwybkKdkc4lAuikugZDjxjP6uVCF749bXozygsJzQ90Ujjy5+b4zydm
	 5U/eont3R1UsK2AYVmw109ZP2y/bWvNCaAoi8jffbke5FHlVAPIc+pj3QbInosv1DF
	 X+1imKvuh7+vA==
Date: Fri, 10 Nov 2023 14:34:21 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 22/22] __dentry_kill(): new locking scheme
Message-ID: <20231110-elstern-gehalt-1c4e3642ebf2@brauner>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
 <20231109062056.3181775-22-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109062056.3181775-22-viro@zeniv.linux.org.uk>

On Thu, Nov 09, 2023 at 06:20:56AM +0000, Al Viro wrote:
> Currently we enter __dentry_kill() with parent (along with the victim
> dentry and victim's inode) held locked.  Then we
> 	mark dentry refcount as dead
> 	call ->d_prune()
> 	remove dentry from hash
> 	remove it from the parent's list of children
> 	unlock the parent, don't need it from that point on
> 	detach dentry from inode, unlock dentry and drop the inode
> (via ->d_iput())
> 	call ->d_release()
> 	regain the lock on dentry
> 	check if it's on a shrink list (in which case freeing its empty husk
> has to be left to shrink_dentry_list()) or not (in which case we can free it
> ourselves).  In the former case, mark it as an empty husk, so that
> shrink_dentry_list() would know it can free the sucker.
> 	drop the lock on dentry
> ... and usually the caller proceeds to drop a reference on the parent,
> possibly retaking the lock on it.
> 
> That is painful for a bunch of reasons, starting with the need to take locks
> out of order, but not limited to that - the parent of positive dentry can
> change if we drop its ->d_lock, so getting these locks has to be done with
> care.  Moreover, as soon as dentry is out of the parent's list of children,
> shrink_dcache_for_umount() won't see it anymore, making it appear as if
> the parent is inexplicably busy.  We do work around that by having
> shrink_dentry_list() decrement the parent's refcount first and put it on
> shrink list to be evicted once we are done with __dentry_kill() of child,
> but that may in some cases lead to ->d_iput() on child called after the
> parent got killed.  That doesn't happen in cases where in-tree ->d_iput()
> instances might want to look at the parent, but that's brittle as hell.
> 
> Solution: do removal from the parent's list of children in the very
> end of __dentry_kill().  As the result, the callers do not need to
> lock the parent and by the time we really need the parent locked,
> dentry is negative and is guaranteed not to be moved around.
> 
> It does mean that ->d_prune() will be called with parent not locked.
> It also means that we might see dentries in process of being torn
> down while going through the parent's list of children; those dentries
> will be unhashed, negative and with refcount marked dead.  In practice,
> that's enough for in-tree code that looks through the list of children
> to do the right thing as-is.  Out-of-tree code might need to be adjusted.
> 
> Calling conventions: __dentry_kill(dentry) is called with dentry->d_lock
> held, along with ->i_lock of its inode (if any).  It either returns
> the parent (locked, with refcount decremented to 0) or NULL (if there'd
> been no parent or if refcount decrement for parent hadn't reached 0).
> 
> lock_for_kill() is adjusted for new requirements - it doesn't touch
> the parent's ->d_lock at all.
> 
> Callers adjusted.  Note that for dput() we don't need to bother with
> fast_dput() for the parent - we just need to check retain_dentry()
> for it, since its ->d_lock is still held since the moment when
> __dentry_kill() had taken it to remove the victim from the list of
> children.
> 
> The kludge with early decrement of parent's refcount in
> shrink_dentry_list() is no longer needed - shrink_dcache_for_umount()
> sees the half-killed dentries in the list of children for as long
> as they are pinning the parent.  They are easily recognized and
> accounted for by select_collect(), so we know we are not done yet.
> 
> As the result, we always have the expected ordering for ->d_iput()/->d_release()
> vs. __dentry_kill() of the parent, no exceptions.  Moreover, the current
> rules for shrink lists (one must make sure that shrink_dcache_for_umount()
> won't happen while any dentries from the superblock in question are on
> any shrink lists) are gone - shrink_dcache_for_umount() will do the
> right thing in all cases, taking such dentries out.  Their empty
> husks (memory occupied by struct dentry itself + its external name,
> if any) will remain on the shrink lists, but they are no obstacles
> to filesystem shutdown.  And such husks will get freed as soon as
> shrink_dentry_list() of the list they are on gets to them.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

