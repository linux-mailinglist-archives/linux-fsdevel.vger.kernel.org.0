Return-Path: <linux-fsdevel+bounces-73117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CE8D0CE95
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 05:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 529AF306C775
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 04:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6B428489B;
	Sat, 10 Jan 2026 04:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="A02pHIap"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB522475F7;
	Sat, 10 Jan 2026 04:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768017664; cv=none; b=kGp8zxluW1cp+rTERNNvukDAJ0JGxzhh6iT3Qn37BzWeo2wnDDUPjcTo5PaIfZp31WmccqpenySqAeJi3LKDegiw0fkEQyyahA+9GHZ8/O+rOARxZCIzo31haRyzDC4njFTo8sP85IDCmnZGOOAAWhJXaPwdW9Fprw6eb2shok4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768017664; c=relaxed/simple;
	bh=e1e6kOPFGoChN8QBCG4b3cerzmCBOm6lgCcFKkZMO4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dc8k3hmEGN5DmLOrCudwGy9JvC4+0hBN1Pa/ea315lnCufFdKHV8POmj5h49LMT/5GgB51wHlM9r0GkTwi9yMUZfXUns0IGokoYboxfdemUalyeyfYpouF+nOM5Vsr1Cayb7u5PwYu4bThtlhjnV7V2LflheTWtnr41UNNWLSuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=A02pHIap; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=SAMItpZq/8UWwpFL77MgX7nTOQ8V2DCdFRU+BfI9C6U=; b=A02pHIapz+/ZRHrStmehokVOoO
	VrM1ZLnvCP3Q2kmEX3nK3l1OP3VQ1WxkbQGHjtUPpyriiZ7wcoMt1lytyeKMIINPNAiwWGWoTmiWj
	dw4AL7A6B14n03dfwWtkawM8nT6XYOHGgEUfxDhyWg/xrhEpXMZqCsYsNgADDRGtUSKyd7BSm60JY
	Sfq2WNTWQ+il7s9LXlyLT/K5fh8/WDuC2tMPXoVIuO2lZCg6FgGy6FvGvNdPuOSsyLUq4NJM3sJg/
	BHX+G73hbNfZecrdNUSrjMu5/13gf0SPfH5JtUJ4Nbjh4pZ9oaOww9w1e0VzKCAyogDcK5GZPRyVz
	hlbGvAyA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1veQB7-000000085Yf-1opA;
	Sat, 10 Jan 2026 04:02:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-mm@kvack.org
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mguzik@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 00/15] kmem_cache instances with static storage duration
Date: Sat, 10 Jan 2026 04:02:02 +0000
Message-ID: <20260110040217.1927971-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

        kmem_cache_create() and friends create new instances of
struct kmem_cache and return pointers to those.  Quite a few things in
core kernel are allocated from such caches; each allocation involves
dereferencing an assign-once pointer and for sufficiently hot ones that
dereferencing does show in profiles.

        There had been patches floating around switching some of those
to runtime_const infrastructure.  Unfortunately, it's arch-specific
and most of the architectures lack it.

        There's an alternative approach applicable at least to the caches
that are never destroyed, which covers a lot of them.  No matter what,
runtime_const for pointers is not going to be faster than plain &,
so if we had struct kmem_cache instances with static storage duration, we
would be at least no worse off than we are with runtime_const variants.

        There are obstacles to doing that, but they turn out to be easy
to deal with.

1) as it is, struct kmem_cache is opaque for anything outside of a few
files in mm/*; that avoids serious headache with header dependencies,
etc., and it's not something we want to lose.  Solution: struct
kmem_cache_opaque, with the size and alignment identical to struct
kmem_cache.  Calculation of size and alignment can be done via the same
mechanism we use for asm-offsets.h and rq-offsets.h, with build-time
check for mismatches.  With that done, we get an opaque type defined in
linux/slab-static.h that can be used for declaring those caches.
In linux/slab.h we add a forward declaration of kmem_cache_opaque +
helper (to_kmem_cache()) converting a pointer to kmem_cache_opaque
into pointer to kmem_cache.

2) real constructor of kmem_cache needs to be taught to deal with
preallocated instances.  That turns out to be easy - we already pass an
obscene amount of optional arguments via struct kmem_cache_args, so we
can stash the pointer to preallocated instance in there.  Changes in
mm/slab_common.c are very minor - we should treat preallocated caches
as unmergable, use the instance passed to us instead of allocating a
new one and we should not free them.  That's it.

	A set of helpers parallel to kmem_cache_create() and friends
(kmem_cache_setup(), etc.) is provided in the same linux/slab-static.h;
generally, conversion affects only a few lines.

	Note that slab-static.h is needed only in places that create
such instances; all users need only slab.h (and they can be modular,
unlike runtime_const-based approach).


	That covers the instances that never get destroyed.  Quite a few
fall into that category, but there's a major exception - anything in
modules must be destroyed before the module gets removed.  Note that
unlike runtime_constant-based approach, cache _uses_ in a module are
fine - if kmem_cache_opaque instance is exported, its address is available
to modules without any problems.  It's caches _created_ in a module
that offer an extra twist.

	Teaching kmem_cache_destroy() to skip actual freeing of given
kmem_cache instance is trivial; the problem is that kmem_cache_destroy()
may overlap with sysfs access to attributes of that cache.  In that
case kmem_cache_destroy() may return before the instance gets freed -
freeing (from slab_kmem_cache_release()) happens when the refcount of
embedded kobject drops to zero.  That's fine, since all references
to data structures in module's memory are already gone by the time
kmem_cache_destroy() returns.  That, however, relies upon the struct
kmem_cache itself not being in module's memory; getting it unmapped
before slab_kmem_cache_release() has run needs to be avoided.

	It's not hard to deal with, though.  We need to make sure that
instance in a module will get to slab_kmem_cache_release() before the
module data gets freed.  That's only a problem on sysfs setups -
otherwise it'll definitely be finished before kmem_cache_destroy()
returns.

	Note that modules themselves have sysfs-exposed attributes,
so a similar problem already exists there.  That's dealt with by
having mod_sysfs_teardown() wait for refcount of module->mkobj.kobj
reaching zero.  Let's make use of that - have static-duration-in-module
kmem_cache instances grab a reference to that kobject upon setup and
drop it in the end of slab_kmem_cache_release().

	Let setup helpers store the kobjetct to be pinned in
kmem_cache_args->owner (for preallocated; if somebody manually sets it
for non-preallocated case, it'll be ignored).  That would be
&THIS_MODULE->mkobj.kobj for a module and NULL in built-in.

	If sysfs is enabled and we are dealing with preallocated instance,
let create_cache() grab and stash that reference in kmem_cache->owner
and let slab_kmem_cache_release() drop it instead of freeing kmem_cache
instance.


	Costs:
* a bit (SLAB_PREALLOCATED) is stolen from slab_flags_t
* such caches can't be merged.  If you want them mergable, don't use that
technics.
* you can't do kmem_cache_setup()/kmem_cache_destroy()/kmem_cache_setup()
on the same instance.  Just don't do that.

Al Viro (15):
  static kmem_cache instances for core caches
  allow static-duration kmem_cache in modules
  make mnt_cache static-duration
  turn thread_cache static-duration
  turn signal_cache static-duration
  turn bh_cachep static-duration
  turn dentry_cache static-duration
  turn files_cachep static-duration
  make filp and bfilp caches static-duration
  turn sighand_cache static-duration
  turn mm_cachep static-duration
  turn task_struct_cachep static-duration
  turn fs_cachep static-duration
  turn inode_cachep static-duration
  turn ufs_inode_cache static-duration

 Kbuild                            | 13 +++++-
 fs/buffer.c                       |  6 ++-
 fs/dcache.c                       |  8 ++--
 fs/file_table.c                   | 32 +++++++-------
 fs/inode.c                        |  6 ++-
 fs/namespace.c                    |  6 ++-
 fs/ufs/super.c                    |  9 ++--
 include/asm-generic/vmlinux.lds.h |  3 +-
 include/linux/fdtable.h           |  3 +-
 include/linux/fs_struct.h         |  3 +-
 include/linux/signal.h            |  3 +-
 include/linux/slab-static.h       | 69 +++++++++++++++++++++++++++++++
 include/linux/slab.h              | 11 +++++
 kernel/fork.c                     | 37 ++++++++++-------
 mm/kmem_cache_size.c              | 20 +++++++++
 mm/slab.h                         |  1 +
 mm/slab_common.c                  | 44 +++++++++++++-------
 mm/slub.c                         |  7 ++++
 18 files changed, 214 insertions(+), 67 deletions(-)
 create mode 100644 include/linux/slab-static.h
 create mode 100644 mm/kmem_cache_size.c

-- 
2.47.3


