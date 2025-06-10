Return-Path: <linux-fsdevel+bounces-51208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FA7AD4688
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 01:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B840189C46B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 23:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D67C26057E;
	Tue, 10 Jun 2025 23:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="lH4CqOW4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9154F260569
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 23:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749597257; cv=none; b=joqpqLpjckk78srPyleGJiIerOukjPH3cDViSjKhm7FU80Xjv9J6gij+TCO3fVQb5M3ECpI5zTtl+RBONh3UxY8pQFJ5EFpaxLCvbn0cAHHZ1DzeswxPvxtbjZn/FEmD2IA5418tsdLp4ctrZX37ReT5xk7sNYAbWFcDTjOH/8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749597257; c=relaxed/simple;
	bh=J0zZOHSnZsmv1gzVrydeclrkWQjm5yscjIZjLq6zE70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCIq71vLGIQstKtnWsx14QzZtKAnUqs5OaZ0unpD27ye2+uvMQEWkuI3GP0nLpseak7BIHIsVDyZc8Ogpaz+Uii5jflGGIZcZQisaz7FI/OQ1ADtTegllFIGpavZJVz0MeZpk8RRCA0d1L8iGe+HFKFkTEza4qVlCLXI/6qn3lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=lH4CqOW4; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qtG3Q+N90ZCZzV8fADHEBcWyV6Sjq165QPS6v3Z2LxA=; b=lH4CqOW4xeCxUwsOgpfJ+6mwD4
	WR63RoPD46XbhNhZu0wvnn4VKTxiaQXiDmxRw3m0nnR9H0KKSjR9GOvxfA0ph7t3VVwYbBijxFvuH
	fr32lVdFAQ/fq5W5iosY4QT0rse3KisMbP5MHysG0M8Jyqgx1LW9D4n6KVw+hdxLCWmz28VlX7I+p
	Gm3/xjm5SatHkmg6bh5jNYf1JeIvaZ4Ee43bMSv+RgFVjKHZZsRY58nty8va24/HhJcwDWoYcaasb
	FOHog5KL22NjPf2O2p1xYTpGaXLR+F+kisa4iXT3T92hQkhEnOylPbkFTy/lM84ywW869jQ3Qiy0T
	Pff/yqHA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP8AW-0000000Cly2-0hhJ;
	Tue, 10 Jun 2025 23:14:12 +0000
Date: Wed, 11 Jun 2025 00:14:12 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 01/26] copy_tree(): don't set ->mnt_mountpoint on the
 root of copy
Message-ID: <20250610231412.GH299672@ZenIV>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
 <87bjqvfcwc.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bjqvfcwc.fsf@email.froward.int.ebiederm.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jun 10, 2025 at 05:30:11PM -0500, Eric W. Biederman wrote:
> Al Viro <viro@zeniv.linux.org.uk> writes:
> 
> > It never made any sense - neither when copy_tree() had been introduced
> > (2.4.11-pre5), nor at any point afterwards.  Mountpoint is meaningless
> > without parent mount and the root of copied tree has no parent until we get
> > around to attaching it somewhere.  At that time we'll have mountpoint set;
> > before that we have no idea which dentry will be used as mountpoint.
> > IOW, copy_tree() should just leave the default value.
> 
> I will just note that does not result in dst_mnt->mnt_mountpoint
> being left as NULL.
> 
> Rather dst_mnt->mnt_mountpoint retains the value that clone_mnt
> sets it to which is dst_mnt->mnt.mnt_root.
> 
> It would be nice to have a note that says something like leaving
> dst_mnt->mnt_parent and dst_mnt->mnt_mountpoint alone indicates that the
> mount is not mounted anywhere, and that the current situation of just
> setting one of them completely confusing.

s/default value/& for a parentless mount/, perhaps?

<digs through the half-finished documentation>
----------------------------------------------------------------------------
                Rootwards linkage.

        Once a mount has been attached to a subtree of some filesystem,
it becomes a part of forest.  Past that stage each mount is either
parentless or has a parent mount and a mountpoint - some dentry on
the filesystem associated with the parent.

        The linkage is protected by mount_lock.

        Checking if mount is parentless is done by mnt_has_parent(mount);
it returns true for mounts that have a parent and false for parentless
ones.   

        Four fields of struct mount are involved in storing that linkage.
1) struct mount *mnt_parent
        Never NULL, points to self for parentless, to parent mount otherwise.
2) struct dentry *mnt_mountpoint
        Never NULL, points to root dentry of mount itself for parentless
and to mountpoint dentry otherwise.
3) struct mountpoint *mnt_mp.
        NULL for parentless, points to struct mountpoint associated with
mountpoint dentry otherwise.
4) struct hlist_node mnt_mp_list - linkage for the list all mounts sharing
the mountpoint.

        These fields are always updated together.  They make sense only
after mount has been attached to a filesystem - prior to that they happen
to contain NULL (and empty hlist_node), but they are visible only to whoever
had allocated the mount, so nobody else should care.[1]

        The values in these fields are not independent.  If mount m is not
parentless, m->mnt_parent->mnt.mnt_sb == m->mnt_mountpoint->d_sb,
m->mnt_mp->m_dentry == m->mnt_mountpoint and m->mnt_mp_list belongs to
the list anchored in m->mnt_mp->m_list.

        All accesses to ->mnt_mp_list and ->mnt_mp are under mount_lock.
        Access to ->mnt_parent and ->mnt_mountpoint under mount_lock is safe.
        Access to ->mnt_parent and ->mnt_mountpoint under rcu_read_lock() is
memory-safe; it needs to be validated with mount_lock seqcount component
afterwards.
        Access to ->mnt_parent and ->mnt_mountpoint under namespace_sem is
safe for anything crownwards of a pinned mount.  In particular, it is safe
for anything in a mount tree of any namespace, including its rbtree.  It
is also safe for anything reachable via the propagation graph. [XXX: probably
worth an explicit name for that state of a mount]

[1] it might be tempting to change the representation, so that parentless would
have NULL ->mnt_mountpoint; doing that would be a serious headache, though,
especially for RCU traversals towards parent mount.  We really depend upon never
seeing NULL in that field once mount has been attached to filesystem.
----------------------------------------------------------------------------

