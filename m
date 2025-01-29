Return-Path: <linux-fsdevel+bounces-40320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B49A223B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 19:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9E3164414
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 18:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597951E1C3A;
	Wed, 29 Jan 2025 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XhgSWf2R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91881917D9;
	Wed, 29 Jan 2025 18:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738174673; cv=none; b=FW5MCg4tginJnKAcYuaM3V9LjTJMtHLDljDjK5E8uWoDt4QEDjsDlfp+WWQT8dUrNQOC2OvZso5FumJnu5dUZ9bx6yL765EpqmijKdURyBqOwrrZefonDf76bIJiRoHi6VYLMVIOnoXaQKCYegq/Wi9LSOk/sjWfeCdsXB8gOy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738174673; c=relaxed/simple;
	bh=/XvFYnnOViFH3OGSlL8qyvNFJbMFSdz5+hQNIUYyXgc=;
	h=Subject:To:Cc:From:Date:Message-Id; b=siwKy5lGUTi156Zt1vb5GQ2+oaZWFFku45u1v48C9xSLqaNuG1AUdr4X3UcYvTuqMZr6OBeE9c6Nr2zHvoZsia6HCrJvQusu9e11xlpPiQ6OdzctwVxetU1x7MFT1XKUXYmQyZy9OP6u9rbSGQu7qXLeDF9Kd1ET70DcfACe0ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XhgSWf2R; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738174672; x=1769710672;
  h=subject:to:cc:from:date:message-id;
  bh=/XvFYnnOViFH3OGSlL8qyvNFJbMFSdz5+hQNIUYyXgc=;
  b=XhgSWf2RYjmkTBt8lnhf67z9Qy62jlQeXCNursWCPy0M77gvUkLToaec
   SyzhIC50aCCkvLdmW74B0eqMGRDsxjkN431Kx+AF3XWOuxQiASlsD0bPk
   vfe88NqK0ULAR6LI9i7huQE+oAppINxduEd/PLiNEWzKdjQjsaYoCIeUK
   jQkUy7T8hG21KN+zok7p3cfHkulID1bD5cSoAhuf/rwmIR4DEez8Ptlah
   aTTGlDYsufIu82jwFseuw/H6zOSayjfalkqmPX+9Tf+3pfryumLztPy1N
   aQndpeLCfeMZR9D0Xw17OFEUzd77ORXsoiLwlszHerjY+odoAsP+RiA6G
   A==;
X-CSE-ConnectionGUID: 8ORp0KlhRqGL+qgMDURCOQ==
X-CSE-MsgGUID: 3o3vEdc2TwevYOutv9R0oA==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="38963239"
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="38963239"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 10:17:50 -0800
X-CSE-ConnectionGUID: w4WrpUeqRruo5DQNnArK+g==
X-CSE-MsgGUID: WzaeOTwdRtquOnIPieU5dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="109660676"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa010.fm.intel.com with ESMTP; 29 Jan 2025 10:17:49 -0800
Subject: [PATCH 0/7] Move prefaulting into write slow paths
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,Ted Ts'o <tytso@mit.edu>,Christian Brauner <brauner@kernel.org>,Darrick J. Wong <djwong@kernel.org>,Matthew Wilcox (Oracle) <willy@infradead.org>,Al Viro <viro@zeniv.linux.org.uk>,linux-fsdevel@vger.kernel.org,Dave Hansen <dave.hansen@linux.intel.com>,almaz.alexandrovich@paragon-software.com,ntfs3@lists.linux.dev,miklos@szeredi.hu,kent.overstreet@linux.dev,linux-bcachefs@vger.kernel.org,clm@fb.com,josef@toxicpanda.com,dsterba@suse.com,linux-btrfs@vger.kernel.org,dhowells@redhat.com,jlayton@kernel.org,netfs@lists.linux.dev
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 29 Jan 2025 10:17:49 -0800
Message-Id: <20250129181749.C229F6F3@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

tl;dr: The VFS and several filesystems have some suspect prefaulting
code. It is unnecessarily slow for the common case where a write's
source buffer is resident and does not need to be faulted in.

Move these "prefaulting" operations to slow paths where they ensure
forward progress but they do not slow down the fast paths. This
optimizes the fast path to touch userspace once instead of twice.

Also update somewhat dubious comments about the need for prefaulting.

This has been very lightly tested. I have not tested any of the fs/
code explicitly.

I started by just trying to deal with generic_perform_write() and
looked at a few more cases after Dave Chinner mentioned there was
some apparent proliferation of its pattern across the tree.

I think the first patch is probably OK for 6.14. If folks are OK
with other ones, perhaps they can just them up individually for
their trees.

--

More detailed cover letter below.

There are logically two pieces of data involved in a write operation:
a source that is read from and a target which is written to, like:

	sys_write(target_fd, &source, len);

This is implemented in generic VFS code and several filesystems
with loops that look something like this:

	do {
		fault_in_iov_iter_readable(source)
		// lock target folios
		copy_folio_from_iter_atomic()
		// unlock target folios
	} while(iov_iter_count(iter))

They fault in the source first and then proceed to do the write.  This
fault is ostensibly done for a few reasons:

 1. Deadlock avoidance if the source and target are the same
    folios.
 2. To check the user address that copy_folio_from_iter_atomic()
    will touch because atomic user copies do not check the address.
 3. "Optimization"

I'm not sure any of these are actually valid reasons.

The "atomic" user copy functions disable page fault handling because
page faults are not very atomic. This makes them naturally resistant
to deadlocking in page fault handling. They take the page fault
itself but short-circuit any handling.

copy_folio_from_iter_atomic() also *does* have user address checking.
I get a little lost in the iov_iter code, but it does know when it's
dealing with userspace versus kernel addresses and does seem to know
when to do things like copy_from_user_iter() (which does access_ok())
versus memcpy_from_iter().[1]

The "optimization" is for the case where 'source' is not faulted in.
It can avoid the cost of a "failed" page fault (it will fail to be
handled because of the atomic copy) and then needing to drop locks and
repeat the fault.

But the common case is surely one where 'source' *is* faulted in.
Usually, a program will put some data in a buffer and then write it to
a file in very short order. Think of something as simple as:

	sprintf(buf, "Hello world");
	write(fd, buf, len);

In this common case, the fault_in_iov_iter_readable() incurs the cost
of touching 'buf' in userspace twice.  On x86, that means at least an
extra STAC/CLAC pair.

Optimize for the case where the source buffer has already been faulted
in. Ensure forward progress by doing the fault in slow paths when the
atomic copies are not making progress.

That logically changes the above loop to something more akin to:

	do {
		// lock target folios
		copied = copy_folio_from_iter_atomic()
		// unlock target folios

		if (unlikely(!copied))
			fault_in_iov_iter_readable(source)
	} while(iov_iter_count(iter))

1. The comment about atomic user copies not checking addresses seems
   to have originated in 08291429cfa6 ("mm: fix pagecache write
   deadlocks") circa 2007. It was true then, but is no longer true.

 fs/bcachefs/fs-io-buffered.c |   30 ++++++++++--------------------
 fs/btrfs/file.c              |   20 +++++++++++---------
 fs/fuse/file.c               |   14 ++++++++++----
 fs/iomap/buffered-io.c       |   24 +++++++++---------------
 fs/netfs/buffered_write.c    |   13 +++----------
 fs/ntfs3/file.c              |   17 ++++++++++++-----
 mm/filemap.c                 |   26 +++++++++++++++-----------
 7 files changed, 70 insertions(+), 74 deletions(-)

Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: netfs@lists.linux.dev

