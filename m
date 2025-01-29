Return-Path: <linux-fsdevel+bounces-40321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E7CA223C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 19:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FEC03A81B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 18:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FC91E3785;
	Wed, 29 Jan 2025 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eb9Pd4iJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CD21E102D;
	Wed, 29 Jan 2025 18:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738174675; cv=none; b=UKaX6uGEdlCcLBoIx5fBoKi336gXX4HdhfBO+JdxYYXTnV3NMQ59XnGSRz2W84CylcMPGZwCui2gzCa3pfjCmlPhNuiKErC2b0HfSmjT3d3ISJc21y7BGmYXXBoGZe6v1AV70qy98UuQILKDAMkK4b7PBtCcy026v8494CsR8Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738174675; c=relaxed/simple;
	bh=4ZsGt+mSqlSAqYZrfKA4JnU6As4w0ZGKCAyoOMuu+Ww=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=tcoGbZCfV4XF7VFwu12BPZ8ue0+xHxslXFB8oszHLpWwr+Kwon21Buy1nZ7c6zc0pqv/unZWMMIbir6RWacsdDK2d794nzxhknt4PaFKyn+CTebfzfxNzT+ZUQ3fxMXlSLOSAbugEeQrlagDc0Q+XDktzCSMYmApg+E4aiKnc2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eb9Pd4iJ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738174674; x=1769710674;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=4ZsGt+mSqlSAqYZrfKA4JnU6As4w0ZGKCAyoOMuu+Ww=;
  b=Eb9Pd4iJ/vVxYIQhpj4pQt4cOqCg7dGcuhyUeF1n2kagOJvvN4fuTg6U
   EH82A5O7YjHQ5oXIwD1xYEjhZtY2V+lX1a56KptFEDemBaA3IxVMa2Fd/
   oit31t6ELj5TZfZOnsuW9E+jL6huhb8/b7uPlDcklxUd4+e/lnJiZCjUy
   HHoEbsWPwzzrhNoPcbJFJ3QVBgSvPjCU5xld1ZU4cacOud9n9RJMv32iJ
   MshAu9Ps3FiTpgxonCt4iKBeA2DplIv8Y/wZXwiZBAnOr7DsSX0obCNnB
   HQtKqutCiI0VR9atkitEkzUGrQsTOC9HQF6ezuAIdeFwRlqxqHg43Z71s
   A==;
X-CSE-ConnectionGUID: 8HK/aiFtQBa3edxR7MKKGQ==
X-CSE-MsgGUID: oZaCnLbXTiGN/YPs+Us+SQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="38963252"
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="38963252"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 10:17:52 -0800
X-CSE-ConnectionGUID: AfMh9vWrQWWq1Ktri4LMmw==
X-CSE-MsgGUID: QEjHVrpySoGlcpXG0wmaTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="109660680"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa010.fm.intel.com with ESMTP; 29 Jan 2025 10:17:51 -0800
Subject: [PATCH 1/7] filemap: Move prefaulting out of hot write path
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,Ted Ts'o <tytso@mit.edu>,Christian Brauner <brauner@kernel.org>,Darrick J. Wong <djwong@kernel.org>,Matthew Wilcox (Oracle) <willy@infradead.org>,Al Viro <viro@zeniv.linux.org.uk>,linux-fsdevel@vger.kernel.org,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 29 Jan 2025 10:17:51 -0800
References: <20250129181749.C229F6F3@davehans-spike.ostc.intel.com>
In-Reply-To: <20250129181749.C229F6F3@davehans-spike.ostc.intel.com>
Message-Id: <20250129181751.5527308F@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>


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
userspace once instead of twice. That should speed things up.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/yxyuijjfd6yknryji2q64j3keq2ygw6ca6fs5jwyolklzvo45s@4u63qqqyosy2/
Cc: Ted Ts'o <tytso@mit.edu>

---

 b/mm/filemap.c |   26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff -puN mm/filemap.c~generic_perform_write-1 mm/filemap.c
--- a/mm/filemap.c~generic_perform_write-1	2025-01-29 09:03:30.963260106 -0800
+++ b/mm/filemap.c	2025-01-29 09:03:30.971260772 -0800
@@ -4027,17 +4027,6 @@ retry:
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
@@ -4055,6 +4044,11 @@ retry:
 		if (mapping_writably_mapped(mapping))
 			flush_dcache_folio(folio);
 
+		/*
+		 * This needs to be atomic because actually handling page
+		 * faults on 'i' can deadlock if the copy targets a
+		 * userspace mapping of 'folio'.
+		 */
 		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
 		flush_dcache_folio(folio);
 
@@ -4080,6 +4074,16 @@ retry:
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

