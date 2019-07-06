Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5086B60E3E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jul 2019 02:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfGFAQO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jul 2019 20:16:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47642 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfGFAQO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jul 2019 20:16:14 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hjYNA-0006fz-9T; Sat, 06 Jul 2019 00:16:12 +0000
Date:   Sat, 6 Jul 2019 01:16:12 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCHES] (hopefully) saner refcounting for mountpoint dentries
Message-ID: <20190706001612.GM17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Currently, we handle mountpoint dentry lifetime in a very convoluted
way.
	* each struct mount attached to a mount tree contributes to ->d_count
of mountpoint dentry (pointed to by ->mnt_mountpoint).
	* permanently detaching a mount from a mount tree moves the reference
into ->mnt_ex_mountpoint.
	* that reference is dropped by drop_mountpoint(), which must happen
no later than the filesystem the mountpoint resides on gets shut down.

The last part makes for really unpleasant ordering logics; it works, but it's
bloody hard to follow and it's a lot more complex under the hood than anyone
would like.

The root cause of those complexities is that we can't do dput() while we
are detaching the thing, since the locking environment there doesn't tolerate
IO, blocking, etc., and dput() can trigger all of that.

Another complication (in analysis, not in the code) is that we also have
struct mountpoint in the picture.  Once upon a time it used to be a part
of struct dentry - the list of all mounts on given mountpoint.  Since
it doesn't make sense to bloat every dentry for the sake of a very small
fraction that will ever be anyone's mountpoints, that thing got separated.

What we have is
	* mark in dentry flags (DCACHE_MOUNTED) set for dentries that are
currently mountpoints
	* for each of those we have a struct mountpoint instance (exactly
one for each of those dentries).
	* struct mountpoint has a pointer to its dentry (->m_dentry); it
does not contribute to refcount.
	* struct mountpoint instances are hashed (all the time), using
->m_dentry as search key.
	* struct mount has reference to struct mountpoint (->mnt_mp),
for as long as it is attached to a parent.  When ->mnt_mp is non-NULL
we are guaranteed that m->mnt_mp->m_dentry == m->mnt_mountpoint.
	* struct mountpoint is refcounted, and ->mnt_mp contributes
to that refcount.  All other contributing references are transient -
pretty much dropped by the same function that has grabbed them.

The reasons why ->m_dentry can't become dangling (despite not contributing
to dentry refcount) or persist to the shutdown of filesystem dentry
belongs to are different for transient and presistent references to
struct mountpoint - holders of the former have dentry (and a struct
mount of the filesystem it's on) pinned until after they drop their
reference to struct mountpoint while the latter rely upon having the
(contributing) reference to the same dentry stay in struct mount
past dropping the reference to struct mountpoint.  It works, but
it's less than transparent and ultimately relies upon the mechanism
we use to order dropping dentry references from struct mount vs.
filesystem shutdowns. 

Note that once we have unmounted a struct mount, we don't really need
the reference to what used to be its mountpoint dentry - all we use
it for is eventually passing it to dput().  If we could drop it
immediately (i.e. if the locking environment allowed that), we
could do just that and forget about it as soon as mount is torn
from struct mountpoint.  IOW, we could make struct mountpoint
->m_dentry bear the contributing reference instead of struct mount
->mnt_mountpoint/->mnt_ex_mountpoint.

Locking environment really doesn't allow IO.  And ->d_count can
reach zero there.  However, while we can't kill such victim immediately,
we can put it (with zero refcount) on a shrink list of our own.  And
call shrink_dentry_list() once the locking allows.

That would almost work.  The problem is that until now all shrink
lists used to be homogeneous - all dentries on the same list belong
to the same filesystem.  And shrink_dcache_parent()/shrink_dcache_for_umount()
rely upon that.  If not for that, we could get rid of our ordering machinery.

There is another reason we want to cope with such mixed-origin shrink
lists - Slab Movable Objects patchset really needs that (well, either
that, or having a separate kmem_cache for each struct super_block).
Fortunately, that turns out be reasonably easy to do.  And that allows
to untangle the mess with mountpoints.  The series below does that;
it's in vfs.git #work.dcache and individual patches will be in followups
to this posting.

1) __detach_mounts(): lookup_mountpoint() can't return ERR_PTR() anymore
	Forgotten removal of dead check near the code affected by the
subsequent patches.
2) fs/namespace.c: shift put_mountpoint() to callers of unhash_mnt()
	A bit of preliminary massage - we want to be able to tell put_mountoint()
where to put the dropped dentry if its ->d_count reaches 0.
3) Teach shrink_dcache_parent() to cope with mixed-filesystem shrink lists
	The guts of that series.  We make shrink_dcache_parent() (and
shrink_dcache_for_umount()) to deal with mixed shrink lists sanely.
New primitive added: dput_to_list().  shrink_dentry_list() made non-static.
See the commit message of that one for details.
4) make struct mountpoint bear the dentry reference to mountpoint, not struct mount
	Using the above to shift the contributing reference from ->mnt_mountpoint
to ->mnt_mp->m_dentry.  Dentries are dropped (with dput_to_list()) as soon
as struct mountpoint is destroyed; in cases where we are under namespace_sem
we use the global list, shrinking it in namespace_unlock().  In case of
detaching stuck MNT_LOCKed children at final mntput_no_expire() we use a local
list and shrink it ourselves.  ->mnt_ex_mountpoint crap is gone.
5) get rid of detach_mnt()
	A bit of cleanup - expanding the calls of detach_mnt() (all 3 of
them) and shifting the acquisition of reference to parent mountpoint/dentry
up through attach_recursive_mnt() to do_move_mount() makes for simpler
logics in callers and allows for saner calling conventions for
attach_recursive_mnt().  Quite a bit of dances with various refcounts
in the callers go away - they had been working around the things
detach_mnt() used to do.
6) switch the remnants of releasing the mountpoint away from fs_pin
	Now that we don't need to provide ordering of dropping dentry
references to mountpoints, the use of fs_pin for that becomes pointless.
