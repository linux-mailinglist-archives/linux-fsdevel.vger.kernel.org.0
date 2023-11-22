Return-Path: <linux-fsdevel+bounces-3461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 991967F5090
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 20:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7631C20B3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 19:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35D55E0BE;
	Wed, 22 Nov 2023 19:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VRmy3WrW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E742D18E;
	Wed, 22 Nov 2023 11:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=p1irU5/sMV7m/y1pOMYTaih3tLiq5FQfX+AGXmsO5cU=; b=VRmy3WrW8+pNBsWOfDxL2s3pUK
	4ILG+s+rBsn3aSTA4U1blwa1fJXQ+ZpkggvOqaLfnADIYbA87Qo4cFraQgYStoZ/lRSxvQ56/ViFA
	tCJ0VsCWD8U6HO/zCG6BoGOHVXXg7UfUZFLw1KHk1lOY6q38c1bk0bhWCJJCVxCocMYr/ZeVL9CvP
	/hblKokHWEGibFcKO3nYnnYX4HTr3SYdR2YSu+lx46CO/muf7KYlc+2lEjIC+Vz0uTEWod/bUGBhm
	g5JXG1aR/Z+kMTRenMZ29fJzTDZvhrnci4xFcCfnc+DvsmjoE74Ts5m8XPsCiiTBDtIgYaqbHw6CM
	i1ZsnxGA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5svc-001ksS-1G;
	Wed, 22 Nov 2023 19:30:28 +0000
Date: Wed, 22 Nov 2023 19:30:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mo Zou <lostzoumo@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org
Subject: [PATCHES][CFT] rename deadlock fixes
Message-ID: <20231122193028.GE38156@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	Directory locking used to provide the following warranties:
1.  Any read operations (lookup, readdir) are done with directory locked at
least shared.
2.  Any link creation or removal is done with directory locked exclusive.
3.  Any link count changes are done with the object locked exclusive.
4.  Any emptiness checks (for rmdir() or overwriting rename()) are done with
the victim locked exclusive.
5.  Any rename of a non-directory is done with the object locked exclusive
(the last part is needed by nfsd).

	As far as directory contents is concerned, it very nearly amounted
to "all reads are done with directory locked shared, all modifications
- exclusive".  There had been one gap in that, though - rename() can change
the parent of subdirectory and strictly speaking that does modify
the contents - ".." entry might need to be altered to match the new parent.
For almost all filesystems it posed no problem - location and representation
of ".." entry is fs-dependent, but it tends to be unaffected by any other
directory modifications.

	However, in some cases it's not true - for example, a filesystem
might have the contents of small directories kept directly in the
inode, switched to separate allocation when enough entries are added.
For such beasts we need an exclusion between modifying ".." and (at least)
switchover from small to large directory format.

	One solution would be an fs-private locking inside the method,
another - having cross-directory ->rename() take the normal lock on
directory being moved.

	Or one could make vfs_rename() itself lock that directory instead,
sparing the ->rename() instances all that headache.  That had been done in
6.5; unfortunately, locking the moved subdirectory had been done in *all*
cases, cross-directory or not.	And that turns out to be more than a bit
of harmless overlocking - deadlock prevention relies upon the fact that
we never lock two directories that are not descendents of each other
without holding ->s_vfs_rename_mutex.  Kudos to Mo Zou for pointing to
the holes in proof of correctness - that's what uncovered the problem...

	We could revert to pre-6.5 locking scheme, but there's a less
painful solution; the cause of problem is same-directory case and in those
there's no reason for ->rename() to touch the ".." entry at all - the
parent does not change, so the modification of ".." would be tautological.

	Let's keep locking moved subdirectory in cross-directory move;
that spares ->rename() instances the need to do home-grown exclusion.
They need to be careful in one respect - if they do rely upon the exclusion
between the change of ".." and other directory modifications, they should
only touch ".." if the parent does get changed.  Exclusion is still provided
by the caller for such (cross-directory) renames.

	The series lives in 
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.rename;
individual patches in followups.  It does surivive local beating, but
it needs more - additional review and testing would be very welcome.

	It starts with making sure that ->rename() instances are
careful.  Then the locking rules for rename get changed, so that we don't
lock moved subdirectory in same-directory case.  The proof of correctness
gets updated^Wfixed - the current one had several holes.

1/9..6/9) (me and Jan) don't do tautological ".." changes in instances.
      reiserfs: Avoid touching renamed directory if parent does not change
      ocfs2: Avoid touching renamed directory if parent does not change
      udf_rename(): only access the child content on cross-directory rename
      ext2: Avoid reading renamed directory if parent does not change
      ext4: don't access the source subdirectory content on same-directory rename
      f2fs: Avoid reading renamed directory if parent does not change

7/9) rename(): fix the locking of subdirectories

	We should never lock two subdirectories without having taken
->s_vfs_rename_mutex; inode pointer order or not, the "order" proposed
in 28eceeda130f "fs: Lock moved directories" is not transitive, with
the usual consequences.

	The rationale for locking renamed subdirectory in all cases was
the possibility of race between rename modifying .. in a subdirectory to
reflect the new parent and another thread modifying the same subdirectory.
For a lot of filesystems that's not a problem, but for some it can lead
to trouble (e.g. the case when short directory contents is kept in the
inode, but creating a file in it might push it across the size limit
and copy its contents into separate data block(s)).

	However, we need that only in case when the parent does change -
otherwise ->rename() doesn't need to do anything with .. entry in the
first place.  Some instances are lazy and do a tautological update anyway,
but it's really not hard to avoid.

Amended locking rules for rename():
	find the parent(s) of source and target
	if source and target have the same parent
		lock the common parent
	else
		lock ->s_vfs_rename_mutex
		lock both parents, in ancestor-first order; if neither
		is an ancestor of another, lock the parent of source
		first.
	find the source and target.
	if source and target have the same parent
		if operation is an overwriting rename of a subdirectory
			lock the target subdirectory
	else
		if source is a subdirectory
			lock the source
		if target is a subdirectory
			lock the target
	lock non-directories involved, in inode pointer order if both
	source and target are such.

That way we are guaranteed that parents are locked (for obvious reasons),
that any renamed non-directory is locked (nfsd relies upon that),
that any victim is locked (emptiness check needs that, among other things)
and subdirectory that changes parent is locked (needed to protect the update
of .. entries).  We are also guaranteed that any operation locking more
than one directory either takes ->s_vfs_rename_mutex or locks a parent
followed by its child.

8/9) kill lock_two_inodes()
	Folded into the sole caller and simplified - it doesn't
need to deal with the mix of directories and non-directories anymore.

9/9) rename(): avoid a deadlock in the case of parents having no common ancestor

... and fix the directory locking documentation and proof of correctness.
Holding ->s_vfs_rename_mutex *almost* prevents ->d_parent changes; the
case where we really don't want it is splicing the root of disconnected
tree to somewhere.

In other words, ->s_vfs_rename_mutex is sufficient to stabilize "X is an
ancestor of Y" only if X and Y are already in the same tree.  Otherwise
it can go from false to true, and one can construct a deadlock on that.

Make lock_two_directories() report an error in such case and update the
callers of lock_rename()/lock_rename_child() to handle such errors.
The ones that could get an error, that is - e.g. debugfs_rename() is
never asked to change the parent and shouldn't be using lock_rename()
in the first place; that's a separate series, though.

