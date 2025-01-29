Return-Path: <linux-fsdevel+bounces-40325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEABBA223D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 19:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 395303A88C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 18:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F951E9B1E;
	Wed, 29 Jan 2025 18:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jUhLux2X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA171E8855;
	Wed, 29 Jan 2025 18:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738174681; cv=none; b=DGWaAETRcapvrAelzq92afPQj+9a6BuLJuEj6zY8IbSlCFhLlENxBUGNH8kYCAzyO81UIq/tnUocPS2s55GHnm/6AYFUT4bIVeSfKbyol7zWkk3UQUcZ2FIYXtzoY1Qgsns5T0Q2DjHvphP7wZ9wN8Ij/H5TlKXhTO4PnytcTGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738174681; c=relaxed/simple;
	bh=nLgUtcYlqdDJ5L2EieCeuBPNfu+z4xGNGz6lMKw+vhI=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=HPOhkZp/qxhzFuZdwN0RFeIX7aVTp6VL2HpxGum0S8rP9IVmnP2ZWDA4uSdaTbXyKVnDSoQWOzCgAbIIQ00UvWG67tjDGco6RhIifoEMX66TGA7iwDxdaAv+ORNgpey0ysNSUt1ktmTniBYlmjogMlkEO3IBiULDEluq8M9T9Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jUhLux2X; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738174680; x=1769710680;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=nLgUtcYlqdDJ5L2EieCeuBPNfu+z4xGNGz6lMKw+vhI=;
  b=jUhLux2XfWhfo90mEciO9N4dggPL8lpinS7Zt0jl2zBZVkdtvLM8QzXH
   v7F/6fxuQGUJoSSDxdloyF+mc6wOe8Px9pEWeZ++idKBh94cKjiTUFxfI
   a4smpDovqZdrp05lEP7Y851QsflY1W6WLVpyrBXfLAZSIQj1XxtoJIfCb
   4BL+3iuMXy6PzyITloDvKJs+ZMvmEmDc5doBSGoRnQylan/4rHY75fTSe
   NQeQ7mAXjXPn3NpISRkm5LnSBpwLpuEdSWtnVtnvC8vsFZJOunX8RYhbZ
   TBNiCUXmD5eevrYrvlgksRsY/OIBUXmtGN+/CSISJhwl3z6qOAgnaBfjg
   w==;
X-CSE-ConnectionGUID: RmREMfmEQFyzjvg7REueAA==
X-CSE-MsgGUID: 2l0b5Ba6SQmVsbqznEP+RQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="38963290"
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="38963290"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 10:17:59 -0800
X-CSE-ConnectionGUID: ww5Xh3pdR/irjie2ZpJdIw==
X-CSE-MsgGUID: PdOV2w8hTjaNsIKdStEJNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="109660700"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa010.fm.intel.com with ESMTP; 29 Jan 2025 10:17:58 -0800
Subject: [PATCH 5/7] bcachefs: Move prefaulting out of hot write path
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,Ted Ts'o <tytso@mit.edu>,Christian Brauner <brauner@kernel.org>,Darrick J. Wong <djwong@kernel.org>,Matthew Wilcox (Oracle) <willy@infradead.org>,Al Viro <viro@zeniv.linux.org.uk>,linux-fsdevel@vger.kernel.org,Dave Hansen <dave.hansen@linux.intel.com>,kent.overstreet@linux.dev,linux-bcachefs@vger.kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 29 Jan 2025 10:17:58 -0800
References: <20250129181749.C229F6F3@davehans-spike.ostc.intel.com>
In-Reply-To: <20250129181749.C229F6F3@davehans-spike.ostc.intel.com>
Message-Id: <20250129181758.ACB89DF8@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

Prefaulting the write source buffer incurs an extra userspace access
in the common fast path. Make bch2_buffered_write() consistent with
generic_perform_write(): only touch userspace an extra time when
copy_page_from_iter_atomic() has failed to make progress.

This also zaps a comment. It referred to a possible deadlock and to
userspace address checks. Neither of those things are a concern when
using copy_folio_from_iter_atomic() for atomic usercopies. It
prevents deadlocks by disabling page faults and it leverages user
copy functions that have their own access_ok() checks.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org

---

 b/fs/bcachefs/fs-io-buffered.c |   30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff -puN fs/bcachefs/fs-io-buffered.c~bcachefs-postfault fs/bcachefs/fs-io-buffered.c
--- a/fs/bcachefs/fs-io-buffered.c~bcachefs-postfault	2025-01-29 09:03:35.727656612 -0800
+++ b/fs/bcachefs/fs-io-buffered.c	2025-01-29 09:03:35.731656945 -0800
@@ -970,26 +970,6 @@ static ssize_t bch2_buffered_write(struc
 		unsigned offset = pos & (PAGE_SIZE - 1);
 		unsigned bytes = iov_iter_count(iter);
 again:
-		/*
-		 * Bring in the user page that we will copy from _first_.
-		 * Otherwise there's a nasty deadlock on copying from the
-		 * same page as we're writing to, without it being marked
-		 * up-to-date.
-		 *
-		 * Not only is this an optimisation, but it is also required
-		 * to check that the address is actually valid, when atomic
-		 * usercopies are used, below.
-		 */
-		if (unlikely(fault_in_iov_iter_readable(iter, bytes))) {
-			bytes = min_t(unsigned long, iov_iter_count(iter),
-				      PAGE_SIZE - offset);
-
-			if (unlikely(fault_in_iov_iter_readable(iter, bytes))) {
-				ret = -EFAULT;
-				break;
-			}
-		}
-
 		if (unlikely(fatal_signal_pending(current))) {
 			ret = -EINTR;
 			break;
@@ -1012,6 +992,16 @@ again:
 			 */
 			bytes = min_t(unsigned long, PAGE_SIZE - offset,
 				      iov_iter_single_seg_count(iter));
+
+			/*
+			 * Faulting in 'iter' may be required for forward
+			 * progress. Do it here, out outside the fast path
+			 * and when not holding any folio locks.
+			 */
+			if (fault_in_iov_iter_readable(iter, bytes) == bytes) {
+				ret = -EFAULT;
+				break;
+			}
 			goto again;
 		}
 		pos += ret;
_

