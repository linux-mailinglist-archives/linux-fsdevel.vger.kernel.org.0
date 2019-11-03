Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE79ED427
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Nov 2019 19:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfKCSVB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Nov 2019 13:21:01 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:40442 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfKCSVB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Nov 2019 13:21:01 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iRKUk-0002oj-47; Sun, 03 Nov 2019 18:20:58 +0000
Date:   Sun, 3 Nov 2019 18:20:58 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-kernel@vger.kernel.org, wugyuan@cn.ibm.com,
        jlayton@kernel.org, hsiangkao@aol.com, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ecryptfs@vger.kernel.org
Subject: Re: [RFC] lookup_one_len_unlocked() lousy calling conventions
Message-ID: <20191103182058.GQ26530@ZenIV.linux.org.uk>
References: <20190927044243.18856-1-riteshh@linux.ibm.com>
 <20191015040730.6A84742047@d06av24.portsmouth.uk.ibm.com>
 <20191022133855.B1B4752050@d06av21.portsmouth.uk.ibm.com>
 <20191022143736.GX26530@ZenIV.linux.org.uk>
 <20191022201131.GZ26530@ZenIV.linux.org.uk>
 <20191023110551.D04AE4C044@d06av22.portsmouth.uk.ibm.com>
 <20191101234622.GM26530@ZenIV.linux.org.uk>
 <20191102172229.GT20975@paulmck-ThinkPad-P72>
 <20191102180842.GN26530@ZenIV.linux.org.uk>
 <20191103163524.GO26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191103163524.GO26530@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 03, 2019 at 04:35:24PM +0000, Al Viro wrote:

> lookup_one_len_unlocked() calling conventions are wrong for its callers.
> Namely, 11 out of 12 callers really want ERR_PTR(-ENOENT) on negatives.
> Most of them take care to check, some rely upon that being impossible in
> their case.  Interactions with dentry turning positive right after
> lookup_one_len_unlocked() has returned it are of varying bugginess...
> 
> The only exception is ecryptfs, where we do lookup in the underlying fs
> on ecryptfs_lookup() and want to retain a negative dentry if we get one.

Looking at that code... the thing that deals with the result of lookup in
underlying fs is ecryptfs_lookup_interpose(), and there we have this:
        struct inode *inode, *lower_inode = d_inode(lower_dentry);
...
        dentry_info = kmem_cache_alloc(ecryptfs_dentry_info_cache, GFP_KERNEL);
...
        if (d_really_is_negative(lower_dentry)) {
                /* We want to add because we couldn't find in lower */
                d_add(dentry, NULL);
                return NULL;
        }
        inode = __ecryptfs_get_inode(lower_inode, dentry->d_sb);

If lower dentry used to be negative, but went positive while we'd
been doing allocation, we'll get d_really_is_negative() (i.e.
!lower_dentry->d_inode) false, but lower_inode (fetched earlier)
still NULL.  __ecryptfs_get_inode() starts with
        if (lower_inode->i_sb != ecryptfs_superblock_to_lower(sb))
                return ERR_PTR(-EXDEV);
which won't be happy in that situation...  That has nothing to do
with barriers, ->d_flags, etc. - the window is rather wide here.
GFP_KERNEL allocation can block just fine.

IOW, the only caller of lookup_one_len_unlocked() that does not
reject negative dentries doesn't manage to handle them correctly ;-/

And then in the same ecryptfs_lookup_interpose() we have e.g.
        fsstack_copy_attr_atime(d_inode(dentry->d_parent),
                                d_inode(lower_dentry->d_parent));
Now, dentry->d_parent is stable; dentry is guaranteed to be new
and not yet visible to anybody else, besides it's negative and
the parent is held shared, so it couldn't have been moved around
even if it had been seen by somebody else.

However, lower_dentry->d_parent is a different story.  We are not holding
the lock on its parent anymore; it could've been moved around by somebody
mounting the underlying layer elsewhere and accessing it directly.
Moreover, there's nothing to guarantee that the pointer we fetch from
lower_dentry->d_parent won't be pointing to freed memory by the
time we get around to looking at its inode - lose the timeslice to
preemption just after fetching ->d_parent, have another process move
the damn thing around and there's nothing to keep the ex-parent
around by the time you regain CPU.

The problem goes all way back to addd65ad8d19 "eCryptfs: Filename Encryption:
filldir, lookup, and readlink" from 2009.  That turned
	lower_dir_dentry = ecryptfs_dentry_to_lower(dentry->d_parent);
into
	lower_dir_dentry = lower_dentry->d_parent;
and it had hit the fan...

Sure, "somebody mounted the underlying fs elsewhere and is actively
trying to screw us over" is not how ecryptfs is supposed to be used
and it can demonstrate unexpected behavior - odd errors, etc.
But that behaviour should not include oopsen and access to freed
kernel memory...
