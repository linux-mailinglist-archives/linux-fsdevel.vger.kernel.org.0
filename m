Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53F17FE509
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 19:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfKOSms (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 13:42:48 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:37926 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfKOSms (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:42:48 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVgXp-0001lF-OQ; Fri, 15 Nov 2019 18:42:09 +0000
Date:   Fri, 15 Nov 2019 18:42:09 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, yu kuai <yukuai3@huawei.com>,
        rafael@kernel.org, oleg@redhat.com, mchehab+samsung@kernel.org,
        corbet@lwn.net, tytso@mit.edu, jmorris@namei.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        zhengbin13@huawei.com, yi.zhang@huawei.com,
        chenxiang66@hisilicon.com, xiexiuqi@huawei.com
Subject: [RFC] simple_recursive_removal()
Message-ID: <20191115184209.GT26530@ZenIV.linux.org.uk>
References: <1573788472-87426-2-git-send-email-yukuai3@huawei.com>
 <20191115032759.GA795729@kroah.com>
 <20191115041243.GN26530@ZenIV.linux.org.uk>
 <20191115072011.GA1203354@kroah.com>
 <20191115131625.GO26530@ZenIV.linux.org.uk>
 <20191115083813.65f5523c@gandalf.local.home>
 <20191115134823.GQ26530@ZenIV.linux.org.uk>
 <20191115085805.008870cb@gandalf.local.home>
 <20191115141754.GR26530@ZenIV.linux.org.uk>
 <20191115175423.GS26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115175423.GS26530@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 15, 2019 at 05:54:23PM +0000, Al Viro wrote:
> Anyway, AFAICS removal could be done this way:
> 
> // parent is held exclusive, after is NULL or a child of parent
> find_next_child(parent, prev)
> 	child = NULL
> 	node = prev ? &prev->d_child : &parent->d_subdirs;
> 	grab parent->d_lock
> 	for each entry in the list starting at node->next
> 		d = container_of(entry, struct dentry, d_child)
> 		grab d->d_lock
> 		if simple_positive(d)
> 			bump d->d_count
> 			child = d
> 		drop d->d_lock
> 		if child
> 			break
> 	drop parent->d_lock
> 	dput(prev);
> 	return child
> 
> kill_it(victim, parent)
> 	if simple_positive(victim)
> 		d_invalidate(victim);	// needed to avoid lost mounts
> 		if victim is a directory
> 			fsnotify_rmdir
> 		else
> 			fsnotify_unlink
> 		if victim is regular
> 			__debugfs_file_removed(victim)
> 		dput(victim)		// unpin it
> 
> recursive_removal(dentry)
> 	this = dentry;
> 	while (true) {
> 		victim = NULL;
> 		inode = this->d_inode;
> 		inode_lock(inode);
> 		if (d_is_dir(this))
> 			mark this doomed
> 		while ((child = find_next_child(this, victim)) == NULL) {
> 			// no children (left); kill and ascend
> 			// update metadata while it's still locked
> 			inode->i_ctime = current_time(inode);
> 			clear_nlink(inode);
> 			inode_unlock(inode);
> 			victim = this;
> 			this = this->d_parent;
> 			inode = this->d_inode;
> 			inode_lock(inode);
> 			kill_it(victim, this);
> 			if (victim == dentry) {
> 				inode->i_ctime = inode->i_mtime = current_time(inode);
> 				if (d_is_dir(dentry))
> 					drop_nlink(inode);
> 				inode_unlock(inode);
> 				dput(dentry);
> 				return;
> 			}
> 		}
> 		inode_unlock(inode);
> 		this = child;
> 	}

Come to think of that, if we use IS_DEADDIR as "no more additions" marking,
that looks like a good candidate for all in-kernel rm -rf on ramfs-style
filesystems without cross-directory renames.  This bit in kill_it() above
 		if victim is regular
 			__debugfs_file_removed(victim)
would be an fs-specific callback passed by the caller, turning the whole
thing into this:

void simple_recursive_removal(struct dentry *dentry,
			      void (*callback)(struct dentry *))
{
	struct dentry *this = dentry;
	while (true) {
		struct dentry *victim = NULL, *child;
		struct inode *inode = this->d_inode;

		inode_lock(inode);
		if (d_is_dir(this))
			inode->i_flags |= S_DEAD;
		while ((child = find_next_child(this, victim)) == NULL) {
			// kill and ascend
			// update metadata while it's still locked
			inode->i_ctime = current_time(inode);
			clear_nlink(inode);
			inode_unlock(inode);
			victim = this;
			this = this->d_parent;
			inode = this->d_inode;
			inode_lock(inode);
			if (simple_positive(victim)) {
		 		d_invalidate(victim);	// avoid lost mounts
				if (is_dir(victim))
					fsnotify_rmdir(inode, victim);
				else
					fsnotify_unlink(inode, victim);
				if (callback)
					callback(victim);
				dput(victim)		// unpin it
			}
			if (victim == dentry) {
				inode->i_ctime = inode->i_mtime =
					current_time(inode);
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
}

with find_next_child() easily implemented via scan_positives() already
in libfs.c...  Objections?  The above is obviously completely untested,
and I've got nowhere near enough sleep, so there may be any number of
brown paperbag bugs in it.  Review would be very welcome...
