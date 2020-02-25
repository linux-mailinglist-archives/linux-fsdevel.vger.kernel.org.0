Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3D716B77F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2020 03:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgBYCDJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 21:03:09 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:54840 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbgBYCDJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 21:03:09 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6PYx-000diw-1R; Tue, 25 Feb 2020 02:03:07 +0000
Date:   Tue, 25 Feb 2020 02:03:07 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [RFC][PATCHSET] sanitized pathwalk machinery (v2)
Message-ID: <20200225020307.GC23230@ZenIV.linux.org.uk>
References: <20200223011154.GY23230@ZenIV.linux.org.uk>
 <20200225012457.GA138294@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225012457.GA138294@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 25, 2020 at 01:24:57AM +0000, Al Viro wrote:

> Incidentally, another inconsistency is LOOKUP_BENEATH treatment in case
> when we have walked out of the subtree by way of e.g. procfs symlink and
> then ran into .. in the absolute root (that's
>                 if (!follow_up(&nd->path))
>                         break;
> in follow_dotdot()).  Shouldn't that give the same reaction as ..
> in root (EXDEV on LOOKUP_BENEATH, that is)?  It doesn't...
> 
> Another one is about LOOKUP_NO_XDEV again: suppose you have process'
> root directly overmounted and cwd in the root of whatever's overmounting
> it.  Resolution of .. will stay in cwd - we have no parent within the
> chroot jail we are in, so we move to whatever's overmounting that root.
> Which is the original location.  Should we fail on LOOKUP_NO_XDEV here?
> Plain .. in the root of chroot jail (not overmounted by anything) does
> *not*...

FWIW, my preference would be the following (for non-RCU case; RCU
one is similar)

get_parent(nd)
{
	if (path_equal(&nd->path, &nd->root))
		return NULL;
	if (nd->path.dentry != nd->path.mnt->mnt_root)
		return dget_parent(nd->path.dentry);
	m = real_mount(nd->path.mnt);
        read_seqlock_excl(&mount_lock);
	while (mnt_has_parent(m)) {
		d = m->mnt_mountpoint;
		m = m->mnt_parent;
		if (&m->mnt == nd->root.mnt && d == nd->root.path) // root
			break;
		if (m->mnt_root != d) {
			if (unlikely(nd->flags & LOOKUP_NO_XDEV)) {
				read_sequnlock_excl(&mount_lock);
				return ERR_PTR(-EXDEV);
			}
			mntget(&m->mnt);
			dget(d);
			read_sequnlock_excl(&mount_lock);
			path_put(&nd->path);
			nd->path.mnt = &m->mnt;
			nd->path.dentry = d;
			nd->inode = d->d_inode;
			return dget_parent(d);
		}
	}
	read_sequnlock_excl(&mount_lock);
	return NULL;
}

with follow_dotdot() doing
	parent = get_parent(nd);
	if (unlikely(IS_ERR(parent)))
		return PTR_ERR(parent);
	if (unlikely(!parent)) {	.. in root is a rare case
		bugger off if LOOKUP_BENEATH
		parent = dget(nd->path.dentry);
	} else if (unlikely(!path_connected(nd->path.mnt, parent))) {
		dput(parent);
		return -ENOENT;
	}
	dput(nd->path.dentry);
	nd->path.dentry = parent;
	follow_mount(&nd->path);

... with the last part replaced with
	step_into(nd, WALK_NOFOLLOW, dentry, NULL, 0);
later in this series, with similar in RCU case (only there we would want
inode and seq supplied, as usual, so it would be get_parent_rcu(nd, &inode,
&seq)).
