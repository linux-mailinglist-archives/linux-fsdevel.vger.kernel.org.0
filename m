Return-Path: <linux-fsdevel+bounces-10197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29047848A63
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 03:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D703F28509A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 02:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489821869;
	Sun,  4 Feb 2024 02:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gY2nsqug"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB3B10E9;
	Sun,  4 Feb 2024 02:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707012882; cv=none; b=pJoM1gPcN8cgvvzcrtvu8gKPcUHf6XPZwEHejHBj4vVhvN5mSxfsDa3zoSnp1ad9A3LQ0Ju+799yS91ByTeAD90GaDvjnGHADHZCI7BWoKKi6IbRl/6rI3wH0BMEBoVlJZ6BKbEC2odKKK5xAd9xY7k6S+iO5AG/Ubc3zs5FKcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707012882; c=relaxed/simple;
	bh=iw2JbmP3n4xThPeqMrHzCJB0Mvrs4t2jpGYi+wwN+WU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MULp5ma9UId3+J6aq9H2mhuISdFei9xDR8AtyQWqCQMn7kgaXopkeLcib3f2U/pwCcboOMT+Fk1i+ECwAiGcrLMWKaSoqh+epXK3i8cWygk09DoneXKfI0A6YzQjpjIkLnEBH6G2Ux73hWYIrdpDhBYqXxeUq7C4MEiMhFOWgdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gY2nsqug; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ZuR11fBjLGQWXEZ1T0kl/SRe7MKQ+YGDCG8pAWsXzfw=; b=gY2nsqug5SELFzl+lMzL51GyNX
	CKCAQzK7tt8Z3+31QSKXylEuMKQZBOhYIAY9afAwnrNXEZefdhyrFAh8YcfQmMayiSKIRBlDjL55v
	xCUQCjLoEC+K552+nMqZwnuGPLufR0mEZdrOhsv6fI05+aYlncxBFYJvsObOR82PBTEKQC/ihp3O2
	8cEE5yCXkB9MYNvTRP/GSLbuRHN6ew5t2q2j6QeEOrZ0TsorjHYLF5Snkt+uFITta4oTdSfEAvo1Z
	kmmIMlB7Al17Rnis5j9qs85bBKC4XJ+SJFSze1pRd3a9idtph/UMSkEDLCYJVguhRSQgMR66VtlHG
	iER0Iy5w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rWS1k-004r7D-1R;
	Sun, 04 Feb 2024 02:14:36 +0000
Date: Sun, 4 Feb 2024 02:14:36 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org,
	linux-nfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	linux-cifs@vger.kernel.org
Subject: [PATCHES] RCU pathwalk race fixes
Message-ID: <20240204021436.GH2087318@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	We still have some races in filesystem methods when exposed
to RCU pathwalk.  The series below is a result of code audit (the
second round of it) and it should deal with most of that stuff.
Exceptions: ntfs3 ->d_hash()/->d_compare() and ceph_d_revalidate().
Up to maintainers (a note for NTFS folks - when documentation says
that a method may not block, it *does* imply that blocking allocations
are to be avoided.  Really).

	Branch is 6.8-rc1-based; it lives in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes.pathwalk-rcu

Individual patches are in followups; ditto for code audit notes.  Beginning
of the latter should probably be converted into docs; if anyone is willing
to help with such conversion, please say so - I'll be glad to answer any
questions, etc.

If somebody wants to grab bits and pieces of that series into individual
filesystem git trees, please say so.  Same for any problems spotted in
the patches, obviously.  If nothing shows up, that goes into #fixes and
into mainline.

Shortlog:
      fs/super.c: don't drop ->s_user_ns until we free struct super_block itself
      rcu pathwalk: prevent bogus hard errors from may_lookup()
      affs: free affs_sb_info with kfree_rcu()
      exfat: move freeing sbi, upcase table and dropping nls into rcu-delayed helper
      hfsplus: switch to rcu-delayed unloading of nls and freeing ->s_fs_info
      afs: fix __afs_break_callback() / afs_drop_open_mmap() race
      nfs: make nfs_set_verifier() safe for use in RCU pathwalk
      nfs: fix UAF on pathwalk running into umount
      procfs: move dropping pde and pid from ->evict_inode() to ->free_inode()
      procfs: make freeing proc_fs_info rcu-delayed
      fuse: fix UAF in rcu pathwalks
      cifs_get_link(): bail out in unsafe case
      ext4_get_link(): fix breakage in RCU mode

Diffstat:
 fs/affs/affs.h            |  1 +
 fs/affs/super.c           |  2 +-
 fs/afs/file.c             |  8 ++++++--
 fs/exfat/exfat_fs.h       |  1 +
 fs/exfat/nls.c            | 14 ++++----------
 fs/exfat/super.c          | 20 +++++++++++---------
 fs/ext4/symlink.c         |  8 +++++---
 fs/fuse/cuse.c            |  3 +--
 fs/fuse/fuse_i.h          |  1 +
 fs/fuse/inode.c           | 15 +++++++++++----
 fs/hfsplus/hfsplus_fs.h   |  1 +
 fs/hfsplus/super.c        | 12 +++++++++---
 fs/namei.c                |  6 +++++-
 fs/nfs/client.c           | 13 ++++++++++---
 fs/nfs/dir.c              |  4 ++--
 fs/proc/base.c            |  2 --
 fs/proc/inode.c           | 19 ++++++++-----------
 fs/proc/root.c            |  2 +-
 fs/smb/client/cifsfs.c    |  3 +++
 fs/super.c                | 13 ++++---------
 include/linux/nfs_fs_sb.h |  2 ++
 include/linux/proc_fs.h   |  1 +
 22 files changed, 88 insertions(+), 63 deletions(-)

