Return-Path: <linux-fsdevel+bounces-42869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3CBA4A44E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 21:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084053B0652
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 20:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53738192B6D;
	Fri, 28 Feb 2025 20:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qqg3pjYy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B579B23F36A;
	Fri, 28 Feb 2025 20:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740775045; cv=none; b=gmLLrtaUcTFEapabMr+7urJ5fTlEp12sidwmjZtjW2JB9tll4H0nukm66BVWzX2Si8axGZMvtlxiWsJIUWLHk2jcU4K2zcYhyzeFl30A4q42cCaTIvenN9+Xncwi/vrFXI3DcF7jcbbnU0o0u4wlxD8tZfyyPkDwI+AQfKIdxjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740775045; c=relaxed/simple;
	bh=LU6nLh2usNHKmkKlFSqRf+GcH1uMNDVm77IaYsplmyk=;
	h=Subject:To:Cc:From:Date:Message-Id; b=OonF1VtgprYQFiLDxNkmiBlApFcqFj1FycKGY0Npn9pzSEceVjZLIW2U3IM2ep6g9GWEivqrJ+Rb3wbAOflt0U3UmTQHjpLGTkANCJ0I5kdZYne0LX1o1Y4x/avi+SCbPLmApWZlvYWAR+d+oupFs+GeUhJbOc1H6bo1SWOTdgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qqg3pjYy; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740775044; x=1772311044;
  h=subject:to:cc:from:date:message-id;
  bh=LU6nLh2usNHKmkKlFSqRf+GcH1uMNDVm77IaYsplmyk=;
  b=Qqg3pjYyRDkjNkVX4O8E6NA4qmkIcNM8aa8oJlfJqAVmd6Jbad+3ZkW7
   W53Qzpkh9KcLZXbcuum7D8yJ5pV6RNQvx7NSjUrHZBu/BmkXOd0JBqm36
   t/cF3a8av3IngcR0XJqizAWACiriUF0TPszQyRISbleipvn59RV7kNNJo
   Cq7YH0Al3NLsbn/H+hsaguIgyqUY+jo8knKKdN7vj0yL3laWpOXwQeNS8
   64VIl4HR8tfqIcFu/44dIDYnFiRCxFFZTwoYC3IUIzw+SuPT3OCTNVCmt
   7Pl2m3bOrr9yFTrLG+GrkavCk4nIV3b2QlRO8wn+ZlqSzACMFqfirLhuZ
   g==;
X-CSE-ConnectionGUID: VeSKilD7Qx+NRN+PAUFUSg==
X-CSE-MsgGUID: 778lG40JRiC6NwBffS+Uvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="45367465"
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="45367465"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 12:37:23 -0800
X-CSE-ConnectionGUID: ZGrelpB5SC2QF9vxwxb42g==
X-CSE-MsgGUID: SPSF5J2lSVKySLWgCerUYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="122393832"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa003.jf.intel.com with ESMTP; 28 Feb 2025 12:37:23 -0800
Subject: [PATCH] [v2] filemap: Move prefaulting out of hot write path
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,Dave Hansen <dave.hansen@linux.intel.com>,tytso@mit.edu,willy@infradead.org,akpm@linux-foundation.org,mjguzik@gmail.com,david@fromorbit.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 28 Feb 2025 12:37:22 -0800
Message-Id: <20250228203722.CAEB63AC@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>


There is a generic anti-pattern that shows up in the VFS and several
filesystems where the hot write paths touch userspace twice when they
could get away with doing it once.

Dave Chinner suggested that they should all be fixed up[1]. I agree[2].
But, the series to do that fixup spans a bunch of filesystems and a lot
of people. This patch fixes common code that absolutely everyone uses.
It has measurable performance benefits[3].

I think this patch can go in and not be held up by the others.

I will post them separately to their separate maintainers for
consideration. But, honestly, I'm not going to lose any sleep if
the maintainers don't pick those up.

1. https://lore.kernel.org/all/Z5f-x278Z3wTIugL@dread.disaster.area/
2. https://lore.kernel.org/all/20250129181749.C229F6F3@davehans-spike.ostc.intel.com/
3. https://lore.kernel.org/all/202502121529.d62a409e-lkp@intel.com/

--

Changesfrom v1:
 * Update comment to talk more about how filesystem locking and
   atomic usercopies avoid deadlocks.

--

From: Dave Hansen <dave.hansen@linux.intel.com>

There is a bit of a sordid history here. I originally wrote
998ef75ddb57 ("fs: do not prefault sys_write() user buffer pages")
to fix a performance issue that showed up on early SMAP hardware.
But that was reverted with 00a3d660cbac because it exposed an
underlying filesystem bug.

This is a reimplementation of the original commit along with some
simplification and comment improvements.

The basic problem is that the generic write path has two userspace
accesses: one to prefault the write source buffer and then another to
perform the actual write. On x86, this means an extra STAC/CLAC pair.
These are relatively expensive instructions because they function as
barriers.

Keep the prefaulting behavior but move it into the slow path that gets
run when the write did not make any progress. This avoids livelocks
that can happen when the write's source and destination target the
same folio. Contrary to the existing comments, the fault-in does not
prevent deadlocks. That's accomplished by using an "atomic" usercopy
that disables page faults.

The end result is that the generic write fast path now touches
userspace once instead of twice.

0day has shown some improvements on a couple of microbenchmarks:

	https://lore.kernel.org/all/202502121529.d62a409e-lkp@intel.com/

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/yxyuijjfd6yknryji2q64j3keq2ygw6ca6fs5jwyolklzvo45s@4u63qqqyosy2/
Cc: Ted Ts'o <tytso@mit.edu>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>
---

 b/mm/filemap.c |   27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff -puN mm/filemap.c~generic_perform_write-1 mm/filemap.c
--- a/mm/filemap.c~generic_perform_write-1	2025-02-28 11:58:36.499615962 -0800
+++ b/mm/filemap.c	2025-02-28 12:13:27.845549365 -0800
@@ -4170,17 +4170,6 @@ retry:
 		bytes = min(chunk - offset, bytes);
 		balance_dirty_pages_ratelimited(mapping);
 
-		/*
-		 * Bring in the user page that we will copy from _first_.
-		 * Otherwise there's a nasty deadlock on copying from the
-		 * same page as we're writing to, without it being marked
-		 * up-to-date.
-		 */
-		if (unlikely(fault_in_iov_iter_readable(i, bytes) == bytes)) {
-			status = -EFAULT;
-			break;
-		}
-
 		if (fatal_signal_pending(current)) {
 			status = -EINTR;
 			break;
@@ -4198,6 +4187,12 @@ retry:
 		if (mapping_writably_mapped(mapping))
 			flush_dcache_folio(folio);
 
+		/*
+		 * Faults here on mmap()s can recurse into arbitrary
+		 * filesystem code. Lots of locks are held that can
+		 * deadlock. Use an atomic copy to avoid deadlocking
+		 * in page fault handling.
+		 */
 		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
 		flush_dcache_folio(folio);
 
@@ -4223,6 +4218,16 @@ retry:
 				bytes = copied;
 				goto retry;
 			}
+
+			/*
+			 * 'folio' is now unlocked and faults on it can be
+			 * handled. Ensure forward progress by trying to
+			 * fault it in now.
+			 */
+			if (fault_in_iov_iter_readable(i, bytes) == bytes) {
+				status = -EFAULT;
+				break;
+			}
 		} else {
 			pos += status;
 			written += status;
_

