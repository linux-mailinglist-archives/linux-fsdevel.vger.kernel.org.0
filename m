Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCCCB2D7C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2019 02:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfIOAvJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Sep 2019 20:51:09 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34680 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfIOAvI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Sep 2019 20:51:08 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i9IkY-0004gl-7T; Sun, 15 Sep 2019 00:50:51 +0000
Date:   Sun, 15 Sep 2019 01:50:46 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "zhengbin (A)" <zhengbin13@huawei.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, renxudong1@huawei.com,
        Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCH] Re: Possible FS race condition between iterate_dir and
 d_alloc_parallel
Message-ID: <20190915005046.GV1131@ZenIV.linux.org.uk>
References: <20190909145910.GG1131@ZenIV.linux.org.uk>
 <14888449-3300-756c-2029-8e494b59348b@huawei.com>
 <7e32cda5-dc89-719d-9651-cf2bd06ae728@huawei.com>
 <20190910215357.GH1131@ZenIV.linux.org.uk>
 <20190914161622.GS1131@ZenIV.linux.org.uk>
 <CAHk-=whpKgNTxjrenAed2sNkegrpCCPkV77_pWKbqo+c7apCOw@mail.gmail.com>
 <20190914170146.GT1131@ZenIV.linux.org.uk>
 <CAHk-=wiPv+yo86GpA+Gd_et0KS2Cydk4gSbEj3p4S4tEb1roKw@mail.gmail.com>
 <20190914200412.GU1131@ZenIV.linux.org.uk>
 <CAHk-=whpoQ_hX2KeqjQs3DeX6Wb4Tmb8BkHa5zr-Xu=S55+ORg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whpoQ_hX2KeqjQs3DeX6Wb4Tmb8BkHa5zr-Xu=S55+ORg@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 14, 2019 at 03:57:15PM -0700, Linus Torvalds wrote:

> But it is also possible that we could avoid some of that O(n**2)
> behavior by simply not adding the corsor to the end of the dentry
> child list at all. Right now your patch *always* sets the cursor at a
> valid point - even if it's at the end of the directory. But we could
> skip the "end of the directory" case entirely and just set a flag in
> the file for "at eof" instead.

Yeah.

> That way the cursor at least wouldn't exist for the common cases when
> we return to user space (at the beginning of the readdir and at the
> end). Which might make the cursors simply not be quite as common, even
> when you have a _lot_ of concurrent readdir() users.
> 
> There may be other similar things we could do to minimize the pressure
> on the parent dentry lock. For example, maybe we could insert a cursor
> only _between_ readdir() calls, but then in the readdir() loop itself,
> we know we hold the inode lock shared for the directory, so during
> _that_ loop we can use the existing positive dentries that we keep a
> refcount to as cursors.
> 
> Because if the only reason to not use existing dentry pointers as
> cursors is the concurrent rename() issue, then _that_ is certainly
> something that the parent inode shared lock should protect against,
> even if the child dentry list can change in other ways).
> 
> So if the main 'reaim' problem was that the dentry child list itself
> grew due to the cursor pressure (and that is likely) and that in turn
> then caused the O(n**2) bad locking behavior due to having to walk
> much longer dentry child chains, then I suspect that we can do a few
> tweaks to simply not make that happen in practice.
> 
> Yes, I realize that I'm handwaving a bit on the two above suggestions,
> but don't you think that sounds doable?

I think I have a stronger solution.  It includes the "cursors past
the EOF are marked", but that's not all.

Look: the obvious problem with adding an hlist of cursors anchored in
dentry is that we don't want to blow dentry size.  OK, but... we have
d_subdirs/d_child.  And the same crawl through the tree has shown
exactly one place where we do anything to the end of the list - right
in dcache_readdir().  So we could bloody well turn that thing into
hlist.  Voila - a pointer saved.

So, fuck using struct dentry for cursors.  What we need in there
is
	* pointer to struct dentry we would be about to read
	* hlist_node linking them together
	* indicator of pointing before / after the entire directory
contents.
	* some way to get to dentry of directory and/or struct file.
Which can be done in much smaller space than struct dentry; details
of representation really don't matter.

d_subdirs/d_child become an hlist_head/hlist_node list; no cursors
in there at any time.

d_cursors is a new hlist_head, anchoring the set of cursor that
point to this sucker.  The list is protected by ->d_lock of
that dentry.

d_cursors being non-empty contributes 1 to d_count.

dcache_readdir()/dcache_dir_lseek() have exclusion with simple_rename()
on parent's inode.  On per-cursor basis they have exclusion with
each other (already; ->f_lock_pos).

dcache_dir_close() locks directory shared, giving it exclusion with
simple_rename(); per-cursor exclusion is, of course, already there.
Under that rwsem it removes the cursor from the hlist it's on (if
any), using ->d_lock of whatever it's point on for protection.
If that was the last cursor in hlist, drop the target after removal.
In any case, cursor gets freed.

In simple_rename():
	if there are cursors
		grab the next sibling (if any)
		take ->d_lock on source
		rip the list out of it
		drop ->d_lock on source
		if there's no sibling
			go through the list
				point cursors post-EOF, dissolving hlist
		else
			go through the list
				point cursors to the sibling
				find the last element of the list, while we are at it
			if the sibling's list hadn't been empty to start with
				drop our reference to sibling
			take ->d_lock on the sibling
			splice the list in
			drop ->d_lock on sibling
		drop the reference to source (from now-empty ->d_cursors)
Note that it's O(1) under any ->d_lock and O(cursors moved) without
holding any ->d_lock.

walk_cursor(cursor, count):
	while count && cursor is not post-EOF
		drop_old = NULL
		if cursor points to anything
			take ->d_lock on the target
			remove cursor from hlist
			if target's ->d_cursor is now empty
				drop_old = target
			drop ->d_lock on the target
			p = target's ->d_child
		else
			p = parent's ->d_subdirs
		take ->d_lock on directory
		drop_new = NULL
		eof = true
		for d in list, starting after p
			if d is positive && !--count || need_resched
				eof = false
				drop_new = dget(d)
				point cursor to d
				take ->d_lock on d
				if its ->d_cursors is empty
					drop_new = NULL
				insert cursor into its ->d_cursors
				drop ->d_lock on d
				break
		drop ->d_lock on directory
		dput(drop_new)
		dput(drop_old)
		if eof
			mark cursor post-EOF
		else if count
			cond_resched()

dcache_dir_lseek(), "changing position" case:
	walk_cursor(cursor, where)

dcache_readdir() loop:
	while cursor not post-EOF
		if dir_emit the cursor's target fails
			break
		walk_cursor(cursor, 1)
		ctx->pos++

dentry_unlink(): none of the cursor shit in the list, TYVM, and we can't
be called with cursors attached - d_count would've been positive.


What it should, AFAICS, give:
	* no loops under ->d_lock in dentry_unlist()
	* no cursors polluting the lists
	* dentry size unchanged
	* cursors considerably smaller than now
	* no looping for hell knows how long under ->d_lock
And it might be possible to be clever enough to get lockless walk_cursor()
(lockless in terms of directory ->d_lock, that is), but even without that
this scheme looks interesting, IMO.

I haven't even started trying to implement that, so I might very well have
missed obvious problems.  Comments?
