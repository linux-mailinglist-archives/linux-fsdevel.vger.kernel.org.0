Return-Path: <linux-fsdevel+bounces-7787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A27D82ABD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 11:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE271C21414
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 10:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FBE1428C;
	Thu, 11 Jan 2024 10:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MUVxDbeV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A311426A
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 10:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=NAqQa5bDu/Fq7pk/9fhK1uyR0L4P4pcUab+/VxS9hC4=; b=MUVxDbeVdKnz54agzZp4skmWtX
	l5WtWOcX2YGRfqirjakc2S7xnRErAe3UAFpTOqDucifKUXifqykUODQbHbWBbn0RvkekpSlmyTlTb
	dckn3WSLrnLV1Fpg0LF3Q1iMf26Xm+c3+A5H6CiAlA2Yt2Ml4we9Vb2e6MBqrdyGoZCVc+m8Pnwea
	Uqy3BoXp1d+K0b77rKpCnrD33gnZQ0uSCsAqlnT7sw0YHs8wWw1VvO6Ya2CrOiVepzJVjD4jNY+nq
	00lE2ckAO05Io5LtYz2iA5EKTOyICBUJtE4QdnztVJ6KnJq8/G68IrPXKXpYYcCoVpEegOt37kG14
	LqWeHQAQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rNsBT-00CARI-0b;
	Thu, 11 Jan 2024 10:21:11 +0000
Date: Thu, 11 Jan 2024 10:21:11 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [git pull] dcache stuff
Message-ID: <20240111102111.GX1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

The following changes since commit 4a0b33f771db2b82fdfad08b9f34def786162865:

  selinux: saner handling of policy reloads (2023-11-16 12:45:33 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-dcache

for you to fetch changes up to 1b6ae9f6e6c3e3c35aad0f11b116a81780b8aa03:

  dcache: remove unnecessary NULL check in dget_dlock() (2023-11-25 02:51:56 -0500)

Two conflicts - one is the usual append vs. append in D/f/porting.rst; a slightly
more interesting one in fs/tracefs/inode.c, where the switch of d_child/d_subdirs
to hlist runs into changes made in mainline by "eventfs: Fix file and directory
uid and gid ownership".  Pretty straightforward; I've pushed my resolution variant
into #resolution-candidate.  Note that subsequent changes in tracefs tree eliminate
the entire "walk the tree and flip ->i_gid" thing, so the entire clone of d_walk()
in set_gid() will be gone anyway...

----------------------------------------------------------------
dcache stuff for this cycle

change of locking rules for __dentry_kill(), regularized refcounting
rules in that area, assorted cleanups and removal of weird corner
cases (e.g. now ->d_iput() on child is always called before the parent
might hit __dentry_kill(), etc.)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (41):
      struct dentry: get rid of randomize_layout idiocy
      get rid of __dget()
      DCACHE_... ->d_flags bits: switch to BIT()
      DCACHE_COOKIE: RIP
      kill d_{is,set}_fallthru()
      dentry.h: trim externs
      [software coproarchaeology] dentry.h: kill a mysterious comment
      kill d_backing_dentry()
      Merge branch 'no-rebase-overlayfs' into work.dcache-misc
      switch nfsd_client_rmdir() to use of simple_recursive_removal()
      coda_flag_children(): cope with dentries turning negative
      dentry: switch the lists of children to hlist
      centralize killing dentry from shrink list
      shrink_dentry_list(): no need to check that dentry refcount is marked dead
      fast_dput(): having ->d_delete() is not reason to delay refcount decrement
      fast_dput(): handle underflows gracefully
      fast_dput(): new rules for refcount
      __dput_to_list(): do decrement of refcount in the callers
      make retain_dentry() neutral with respect to refcounting
      __dentry_kill(): get consistent rules for victim's refcount
      dentry_kill(): don't bother with retain_dentry() on slow path
      Call retain_dentry() with refcount 0
      fold the call of retain_dentry() into fast_dput()
      don't try to cut corners in shrink_lock_dentry()
      fold dentry_kill() into dput()
      to_shrink_list(): call only if refcount is 0
      switch select_collect{,2}() to use of to_shrink_list()
      d_prune_aliases(): use a shrink list
      __dentry_kill(): new locking scheme
      retain_dentry(): introduce a trimmed-down lockless variant
      kill d_instantate_anon(), fold __d_instantiate_anon() into remaining caller
      d_alloc_pseudo(): move setting ->d_op there from the (sole) caller
      nsfs: use d_make_root()
      Merge branch 'merged-selinux' into work.dcache-misc
      simple_fill_super(): don't bother with d_genocide() on failure
      d_genocide(): move the extern into fs/internal.h
      get rid of DCACHE_GENOCIDE
      d_alloc_parallel(): in-lookup hash insertion doesn't need an RCU variant
      __d_unalias() doesn't use inode argument
      Merge branches 'work.dcache-misc' and 'work.dcache2' into work.dcache
      kill DCACHE_MAY_FREE

Amir Goldstein (1):
      ovl: stop using d_alloc_anon()/d_instantiate_anon()

Vegard Nossum (1):
      dcache: remove unnecessary NULL check in dget_dlock()

 Documentation/filesystems/porting.rst     |  34 ++
 arch/powerpc/platforms/cell/spufs/inode.c |   5 +-
 fs/afs/dynroot.c                          |   5 +-
 fs/autofs/expire.c                        |   7 +-
 fs/ceph/dir.c                             |   2 +-
 fs/ceph/mds_client.c                      |   2 +-
 fs/coda/cache.c                           |   8 +-
 fs/dcache.c                               | 650 +++++++++++-------------------
 fs/file_table.c                           |   5 -
 fs/internal.h                             |   5 +
 fs/libfs.c                                |  62 ++-
 fs/nfsd/nfsctl.c                          |  70 +---
 fs/notify/fsnotify.c                      |   2 +-
 fs/nsfs.c                                 |   7 +-
 fs/overlayfs/export.c                     |  23 +-
 fs/tracefs/inode.c                        |  34 +-
 include/linux/dcache.h                    | 162 ++++----
 17 files changed, 425 insertions(+), 658 deletions(-)

