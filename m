Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67CC1FE464
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 18:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfKORyv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 12:54:51 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:36942 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfKORyv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 12:54:51 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVfnb-0008R8-21; Fri, 15 Nov 2019 17:54:23 +0000
Date:   Fri, 15 Nov 2019 17:54:23 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, yu kuai <yukuai3@huawei.com>,
        rafael@kernel.org, oleg@redhat.com, mchehab+samsung@kernel.org,
        corbet@lwn.net, tytso@mit.edu, jmorris@namei.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        zhengbin13@huawei.com, yi.zhang@huawei.com,
        chenxiang66@hisilicon.com, xiexiuqi@huawei.com
Subject: Re: [PATCH 1/3] dcache: add a new enum type for 'dentry_d_lock_class'
Message-ID: <20191115175423.GS26530@ZenIV.linux.org.uk>
References: <1573788472-87426-1-git-send-email-yukuai3@huawei.com>
 <1573788472-87426-2-git-send-email-yukuai3@huawei.com>
 <20191115032759.GA795729@kroah.com>
 <20191115041243.GN26530@ZenIV.linux.org.uk>
 <20191115072011.GA1203354@kroah.com>
 <20191115131625.GO26530@ZenIV.linux.org.uk>
 <20191115083813.65f5523c@gandalf.local.home>
 <20191115134823.GQ26530@ZenIV.linux.org.uk>
 <20191115085805.008870cb@gandalf.local.home>
 <20191115141754.GR26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115141754.GR26530@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 15, 2019 at 02:17:54PM +0000, Al Viro wrote:
> On Fri, Nov 15, 2019 at 08:58:05AM -0500, Steven Rostedt wrote:
> > On Fri, 15 Nov 2019 13:48:23 +0000
> > Al Viro <viro@zeniv.linux.org.uk> wrote:
> > 
> > > > BTW, what do you mean by "can debugfs_remove_recursive() rely upon the
> > > > lack of attempts to create new entries inside the subtree it's trying
> > > > to kill?"  
> > > 
> > > Is it possible for something to call e.g. debugfs_create_dir() (or any
> > > similar primitive) with parent inside the subtree that has been
> > > passed to debugfs_remove_recursive() call that is still in progress?
> > > 
> > > If debugfs needs to cope with that, debugfs_remove_recursive() needs
> > > considerably heavier locking, to start with.
> > 
> > I don't know about debugfs, but at least tracefs (which cut and pasted
> > from debugfs) does not allow that. At least in theory it doesn't allow
> > that (and if it does, it's a bug in the locking at the higher levels).
> > 
> > And perhaps debugfs shouldn't allow that either. As it is only suppose
> > to be a light weight way to interact with the kernel, hence the name
> > "debugfs".
> > 
> > Yu, do you have a test case for the "infinite loop" case?
> 
> Infinite loop, AFAICS, is reasonably easy to trigger - just open
> a non-empty subdirectory and lseek to e.g. next-to-last element
> in it.  Again, list_empty() use in there is quite wrong - it can
> give false negatives just on the cursors.  No arguments about
> that part...

FWIW, given that debugfs_remove_recursive() has no way to report an error
*and* that we have a single chokepoint for all entry creations (start_creating())
we could make sure nothing gets added pretty easily - just mark the victim
dentry as "don't allow any creations here" when we first reach it and
have start_creating check that, using e.g. inode_lock() for serialization.
Marking could be done e.g. by setting ->d_fsdata to
(void *)DEBUGFS_FSDATA_IS_REAL_FOPS_BIT, so that ->d_release() doesn't
need any changes.

BTW, this
                if (!ret)
                        d_delete(dentry);
                if (d_is_reg(dentry))
                        __debugfs_file_removed(dentry);
                dput(dentry);
in __debugfs_remove() is both subtle and bogus.  If we get here
with refcount > 1, d_delete() is just a d_drop() - dentry can't
be made negative, so it gets unhashed instead.  If we *do* get
here with refcount 1, it will be made negative, all right.
Only to be killed off by immediately following dput(), since
debugfs doesn't retain unpinned dentries.

Why immediate?  Because d_is_reg() is obviously false on
negative dentries, so __debugfs_file_removed() is not called.
That's where the subtle part begins: there should've been
nobody for __debugfs_file_removed() to wait for, since they
would've had to hold additional references to dentry and
refcount wouldn't have been 1.  So that's actually not
a bug.  However, it's too subtle to introduce without
having bothered to even comment the damn thing.

As for the "bogus" part - that d_delete() is bollocks.
First of all, it is fully equivalent to d_drop().  Always
had been.  What's more, that sucker should've been
d_invalidate() instead.

Anyway, AFAICS removal could be done this way:

// parent is held exclusive, after is NULL or a child of parent
find_next_child(parent, prev)
	child = NULL
	node = prev ? &prev->d_child : &parent->d_subdirs;
	grab parent->d_lock
	for each entry in the list starting at node->next
		d = container_of(entry, struct dentry, d_child)
		grab d->d_lock
		if simple_positive(d)
			bump d->d_count
			child = d
		drop d->d_lock
		if child
			break
	drop parent->d_lock
	dput(prev);
	return child

kill_it(victim, parent)
	if simple_positive(victim)
		d_invalidate(victim);	// needed to avoid lost mounts
		if victim is a directory
			fsnotify_rmdir
		else
			fsnotify_unlink
		if victim is regular
			__debugfs_file_removed(victim)
		dput(victim)		// unpin it

recursive_removal(dentry)
	this = dentry;
	while (true) {
		victim = NULL;
		inode = this->d_inode;
		inode_lock(inode);
		if (d_is_dir(this))
			mark this doomed
		while ((child = find_next_child(this, victim)) == NULL) {
			// no children (left); kill and ascend
			// update metadata while it's still locked
			inode->i_ctime = current_time(inode);
			clear_nlink(inode);
			inode_unlock(inode);
			victim = this;
			this = this->d_parent;
			inode = this->d_inode;
			inode_lock(inode);
			kill_it(victim, this);
			if (victim == dentry) {
				inode->i_ctime = inode->i_mtime = current_time(inode);
				if (d_is_dir(dentry))
					drop_nlink(inode);
				inode_unlock(inode);
				dput(dentry);
				return;
			}
		}
		inode_unlock(inode);
		this = child;
	}
