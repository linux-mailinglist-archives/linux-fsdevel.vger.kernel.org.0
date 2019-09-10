Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77D7EAF2B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2019 23:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfIJVyE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Sep 2019 17:54:04 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52972 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfIJVyE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Sep 2019 17:54:04 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i7o5F-0005wK-Vs; Tue, 10 Sep 2019 21:53:58 +0000
Date:   Tue, 10 Sep 2019 22:53:57 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "zhengbin (A)" <zhengbin13@huawei.com>
Cc:     jack@suse.cz, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, "zhangyi (F)" <yi.zhang@huawei.com>,
        renxudong1@huawei.com, Hou Tao <houtao1@huawei.com>
Subject: Re: Possible FS race condition between iterate_dir and
 d_alloc_parallel
Message-ID: <20190910215357.GH1131@ZenIV.linux.org.uk>
References: <fd00be2c-257a-8e1f-eb1e-943a40c71c9a@huawei.com>
 <20190903154007.GJ1131@ZenIV.linux.org.uk>
 <20190903154114.GK1131@ZenIV.linux.org.uk>
 <b5876e84-853c-e1f6-4fef-83d3d45e1767@huawei.com>
 <afdfa1f4-c954-486b-1eb2-efea6fcc2e65@huawei.com>
 <20190909145910.GG1131@ZenIV.linux.org.uk>
 <14888449-3300-756c-2029-8e494b59348b@huawei.com>
 <7e32cda5-dc89-719d-9651-cf2bd06ae728@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e32cda5-dc89-719d-9651-cf2bd06ae728@huawei.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 10, 2019 at 11:05:16PM +0800, zhengbin (A) wrote:

> Now we can reproduce it about every 10 minutes, just use the following script:
> 
> (./go.sh, if can not reproduce this,  killall go.sh open.bin, and ./go.sh)
> 
> (If we set a negative value for dentry->d_child.next in __d_free, we can reproduce it in 30 seconds
> 
> @@ -254,6 +255,8 @@ static void __d_free(struct rcu_head *head)
>  {
>         struct dentry *dentry = container_of(head, struct dentry, d_u.d_rcu);
> 
> +       dentry->d_child.next = 0x1234567812345678;
> +
>         kmem_cache_free(dentry_cache, dentry);
>  }
> )
 
OK, that pretty much demonstrates that what's happening there is next_positive()
observing uninitialized ->next after INIT_LIST_HEAD + list_add.

*grumble*

First of all, reverting that commit would close _that_ race; no questions
about that.  However, I would rather try to avoid that - users generally do
have write access to dcache_dir_lseek()-using filesystem (tmpfs, that is)
and it's not hard to create a bunch of empty files/links to the same file
in the same directory.  Ability to have ->d_lock held for a long time (just
open it and lseek for a huge offset) is not a good thing.

Said that, the bug is real and certainly does need to be fixed.  Looking at
the users of those lists, we have

Individual filesystems:

	* spufs_prune_dir(): exclusive lock on directory, attempt to do rm -rf,
list_for_each_entry_safe() used to iterate.  Removals are actually done by
shrink_dcache_parent(), after we unpin the children.

	* tcpm_debugfs_exit(): bogus check for the list being empty.  Bogus
locking, wrong semantics.

	* afs_dynroot_depopulate(): exclusive lock on directory, manually
unpins some children, uses list_for_each_entry_safe() to iterate through them.
Actual removal from the list comes later, when the caller gets around to
shrinking dentry tree (it's a part of ->kill_sb()).  Actually, that area
(esp. afs_dynroot_rmdir()) looks fishy in terms of races with fs shutdown.
May be correct, may be not - needs to be looked into.

	* autofs get_next_positive_subdir()/get_next_positive_dentry().
Tree-walkers, traverse these lists under ->d_lock on parent.  Pure readers.
[note: they are somewhat simplified in vfs.git#work.autofs, but for our
purposes it just takes the duplicate logics from these two functions into
a new helper; locking conditions are unchanged]

	* autofs_d_manage(), RCU case: quick check for list emptiness before
even bothering with simple_empty().  Lockless, false negatives are fine,
since simple_empty() will grab ->d_lock and do proper checks.  This is just
the fast case.

	* autofs_clear_leaf_automount_flags(): tries to check if rmdir
victim's removal will make the parent empty.  Exclusive lock on directory,
but the check itself is bogus - have it (the parent) opened and the cursor
will result in false negative.  Real bug.

	* ceph drop_negative_children(): checks if all children are negative,
->d_lock held, list_for_each_entry for iteration through the list.  Pure reader.

	* coda_flag_children(): loop through all children, call
coda_flag_inode() for inodes of positive ones.  ->d_lock held,
list_for_each_entry as iterator, pure reader.

	* debugfs_remove_recursive(): looks for the first positive hashed
child, looping under ->d_lock on parent.  Pure reader until that point.
Exclusive lock on directory.  It also checks the child's list for emptiness -
lockless, false negatives being OK.

	* tracefs_remove_recursive(): same as debugfs analogue (a copy of it,
actually).

	* tracevents remove_event_file_dir(): goes through positive children
of directory, zeroes ->i_private for their inodes.  ->d_lock on directory,
list_for_each_entry for iterator, pure reader.  Further exclusion needs to be
looked into to tell if parent dentry can get freed under it.  _VERY_ likely
to be fishy in terms of the effect on opened files in that directory.
ftrace_event_release() will oops if inode->i_private has been zeroed while
the file had been opened.

	* __fsnotify_update_child_dentry_flags(): iterate through positive
children, modifying their ->d_flags.  ->d_lock held, list_for_each_entry for
iterator, pure reader.

	* nfsdfs_remove_files(): exclusive lock on directory, iterate through
children, calling nfsdfs_remove_file() on positive ones.  And screaming on
negatives, including the cursors.  User-triggerable WARN_ON(), how nice...
list_for_each_entry_safe for iterator.  IOW, yet another rm -rf from the kernel.

Core dcache logics:

	* __d_move(): moves from one parent to another or inserts
a previously parentless one into a new parent's list.  rename_lock is held,
so's ->s_vfs_rename_mutex.  Parent(s) are locked at least shared; ->d_lock
is held on their dentries.  Insertion into the list is always at the head.
Note that "at least shared" part is actually "exclusive except for the case
of d_splice_alias() from ->lookup() finding a preexisting alias of subdir's
inode".

	* d_alloc(): inserts new child into the parent's list.  ->d_lock on
parent held, child is negative at that point.  NOTE: most of the callers
are either with parent locked at least shared, or in situation when
the entire tree is not accessible to anyone else (mount-time, basically).
HOWEVER, there are exceptions and these are potential headache.  The easiest
one to hit is probably devpts_pty_new().  IOW, assuming that directory
locked exclusive will be enough to exclude d_alloc() is not safe on
an arbitrary filesystem.  What's more, the same devpts has file *removals*
done without such exclusion, which can get even uglier - dcache_readdir()
(and it is a dcache_readdir() user) does not expect dentry to get freed
under it.  On devpts it can happen.

	* __d_alloc(): constructor, sets the list empty.

	* dentry_unlist(): called by __dentry_kill(), after dentry is doomed
to get killed.  Parent's ->d_lock is held.  Removed from the list, ->next
is left pointing to the next non-cursor (if any).  Note that ->next is set
either to parent's ->d_subdirs *OR* to something that still hadn't been
passed to __dentry_kill().

	* d_walk(): walks the tree; accesses to the lists are under parent's
->d_lock.  As a side note, when we ascend into the parent we might end up with
locked parent and looking at the already doomed child.  In the case we skip
forward by ->d_child.next until we find a non-doomed one.  That's paired with
dentry_unlist() and AFAICS the flag used to mark the doomed ones is redundant -
__dentry_kill() starts with marking ->d_lockref dead, then, still holding
parent's ->d_lock, gets around to dentry_unlist() which marks it with
DCACHE_DENTRY_KILLED and sets ->d_child.next.  All before dropping parent's
->d_lock and lockref remains marked dead ever after.
IOW, d_walk() might as well have used __lockref_is_dead(&child->d_lockref)
(or open-coded it as child->d_count < 0).  If we do that, DCACHE_DENTRY_KILLED
could be killed off.  Anyway, that's a side story.
	FWIW, the main consideration for d_walk() analysis is the following:
if we have grabbed ->d_lock on a live dentry, we are guaranteed that everything
in its ->d_parent chain will have positive refcount and won't get physically
freed until an RCU delay starting after we drop ->d_lock.  That's what makes
the 'ascend' loop in there safe.

	A large part of headache in dcache.c lifetime rules (and they are
rather subtle) is in that area; it needs to be documented, and I've got some
bits and pieces of that, but it really needs to be turned into a coherent
text.

Assorted helpers in VFS:

	* simple_empty(): checks (under ->d_lock) whether ther are any
positive hashed children.  Pure readers.

	* move_cursor(): directory locked at least shared.  Moves the cursor
(with directory's ->d_lock held).  Position where we take the cursor comes
from a positive hashed child, which shouldn't be able to go away in such
conditions.  The reasons why it (mostly) works are somewhat brittle:
	+ shared lock on the directory excludes most of the __d_move()
callers.  The only exception would be d_splice_alias() from ->lookup()
picking an existing alias for directory inode, and none of the dcache_readdir()
users do that.
	+ the same lock excludes all directory-modifying syscalls
	+ in-kernel file removals are mostly excluded by the same lock.
However, there are exceptions, devpts being the most obvious one.

	* next_positive(): the problematic one.  It walks the list
with only shared lock guaranteed on directory.  No ->d_lock, retries
on ->i_dir_seq bumps.  Relies upon the lack of moves to/from directory.
Unfortunately, the lack of ->d_lock means lacking a barrier ;-/

	* dcache_readdir(): directory locked at least shared.  Iterates
through the directory using next_positive() starting at cursor position
or beginning of directory, moves cursor to wherever it stops with
move_cursor().  Note that the cursor is inserted into the list of children
only if we ever move past the beginning.  We have a problem with
in-kernel file removals without directory locked exclusive - both for
move_cursor() and for dir_emit(); the latter is much worse, since we
can't hold any spinlocks over that (it might very well call copy_to_user()).

	* dcache_dir_lseek(): calls next_positive() and move_cursor()
under shared lock on directory.

	* umount_check(): somewhat fishy; it tries to check for presence of
(busy) children, so that warnings about something being busy on umount would
be produced only for leaves.  The check is not quite right - for a busy empty
directory with cursors in it we get no warnings.  Not critical - that thing
should never trigger in the first place.  And arguably we might want to drop
that logics entirely - warn about all ancestors of something busy.  Check is
done under ->d_lock.

	So...

* all modifications of the lists happen under parent's ->d_lock (thankfully).
* all readers that walk those under ->d_lock are safe.
* modifying under both ->d_lock and exclusive lock on directory is safe.

* walking the list with just the exclusive lock on directory is *NOT*
safe without something like rcu_read_lock().  Something like stat(2) on
inexistent file done just as we hit spufs_prune_dir() will end up with
dentry allocated and then dropped.  Have the final dput() there come
while spufs_prune_dir() is walking the list, have spufs_prune_dir() lose
the timeslice at just the right moment and we are screwed.  That has
nothing to do with readdir and lseek, BTW - those are excluded.
The same goes for nfsdfs_remove_files().  In both cases I'd prefer to
grab ->d_lock - directories are not large.  And nfsdfs_remove_files()
needs to get a clue - simple_positive() being false is trivially possible
there.

* we might need to grab dentry reference around dir_emit() in dcache_readdir().
As it is, devpts makes it very easy to fuck that one up.

* it might make sense to turn next_positive() into "try to walk that much,
return a pinned dentry, drop the original one, report how much we'd walked".
That would allow to bring ->d_lock back and short-term it might be the best
solution.  IOW,
int next_positive(parent, from, count, dentry)
	grab ->d_lock
	walk the list, decrementing count on hashed positive ones
		 if we see need_resched
			 break
	if we hadn't reached the end, grab whatever we'd reached
	drop ->d_lock
	dput(*dentry)
	if need_resched
		schedule
	*dentry = whatever we'd grabbed or NULL
	return count;

The callers would use that sucker in a loop - readdir would just need to
initialize next to NULL and do
        while (next_positive(dentry, p, 1, &next), next != NULL) {
in the loop, with dput(next) in the very end.  And lseek would do
				to = NULL;
				p = &dentry->d_subdirs;
				do {
					n = next_positive(dentry, p, n, &to);
					if (!to)
						break;
					p = &to->d_child;
				} while (n);
				move_cursor(cursor, to ? p : NULL);
				dput(to);
instead of
				to = next_positive(dentry, &dentry->d_subdirs, n);
				move_cursor(cursor, to ? &to->d_child : NULL);

Longer term I would really like to get rid of ->d_lock in that thing,
but it's much too late in this cycle for that.
