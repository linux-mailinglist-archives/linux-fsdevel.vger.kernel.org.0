Return-Path: <linux-fsdevel+bounces-40326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428FBA223C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 19:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9803168575
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 18:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717471E9B01;
	Wed, 29 Jan 2025 18:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jCVekLBU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549211E9B06;
	Wed, 29 Jan 2025 18:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738174682; cv=none; b=luHg/v1PpCtESBH/cAfEGzR1EKBEidSeKesWgpq+ES4ohy+qxMGV+I0GzdvSQZq90yE6QAol5tJEKc9cZb8M2CU2XZ+aQc/g+we04o2F4NuIBEhoqKaWX5WehaUed17JrNeSChiDPrdf6KBqT0K9h72lFq/1fO6m6AL3JrE0s0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738174682; c=relaxed/simple;
	bh=ukQZNAO8hWvIF2SoL2m9NYJM3TAt2Q5qsnN0OoflgdY=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=HBf1Jazk05yHuSJT0o7DStTqGYa3z2aA5BJRMKjS2nIV6iI9tu89VE9zq5eMDmC2QEDKV2qMI4buWhWAeAkXrIFup7bmAyLOGLtXGxztv8oKuzD3XPOLB3ttR5q9CSS5p8x2ecnvqeDsqwObCxxg243TCAEcnuiPU2G9VmDgGYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jCVekLBU; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738174682; x=1769710682;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=ukQZNAO8hWvIF2SoL2m9NYJM3TAt2Q5qsnN0OoflgdY=;
  b=jCVekLBUyXn9BgRQ3mhCo7Vzvpoy1E8/IRZfEEM9z6bZkZBrZX4NnNr2
   WnIfR+FsI5Onojb3x6d4oaLUMRBDc6cF6EPMgbK8YMzaEweUFbQsQcr4/
   t41HFUW5yzTG+bcIdh2JAa77L+brrZ04mG70YYjyqVk/NWH0VGbOHEr/L
   HSxkWFyjSqJmsbJrPXk0XSvE7VyiCSxERDkkvN79VPiIABPKyUCrlCM5Z
   xbkoiV+ytnHDqYGH9v7QsgmRSHqMr6WE5Q4S+IvhKIAV30DBS5rOqZqW4
   W90L8R+z66Ijyb814BVYtcMzp8Ofxv8Zi3jNNX2cyE6qr+zrhfGw5akrp
   w==;
X-CSE-ConnectionGUID: AkHdJNWRSKqUb2BIttlBiA==
X-CSE-MsgGUID: gxBI1l+MRfqx+6kogdwpgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="38963301"
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="38963301"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 10:18:01 -0800
X-CSE-ConnectionGUID: sF2snHVmRsS0zc8iAi9uMw==
X-CSE-MsgGUID: qBudLyCSRzexcU+0aByGXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="109660711"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa010.fm.intel.com with ESMTP; 29 Jan 2025 10:18:00 -0800
Subject: [PATCH 6/7] btrfs: Move prefaulting out of hot write path
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,Ted Ts'o <tytso@mit.edu>,Christian Brauner <brauner@kernel.org>,Darrick J. Wong <djwong@kernel.org>,Matthew Wilcox (Oracle) <willy@infradead.org>,Al Viro <viro@zeniv.linux.org.uk>,linux-fsdevel@vger.kernel.org,Dave Hansen <dave.hansen@linux.intel.com>,clm@fb.com,josef@toxicpanda.com,dsterba@suse.com,linux-btrfs@vger.kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 29 Jan 2025 10:18:00 -0800
References: <20250129181749.C229F6F3@davehans-spike.ostc.intel.com>
In-Reply-To: <20250129181749.C229F6F3@davehans-spike.ostc.intel.com>
Message-Id: <20250129181800.ADD26AB5@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

Prefaulting the write source buffer incurs an extra userspace access
in the common fast path. Make btrfs_buffered_write() consistent with
generic_perform_write(): only touch userspace an extra time when
copy_folio_from_iter_atomic() has failed to make progress.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
---

 b/fs/btrfs/file.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff -puN fs/btrfs/file.c~btrfs-postfault fs/btrfs/file.c
--- a/fs/btrfs/file.c~btrfs-postfault	2025-01-29 09:03:36.927756510 -0800
+++ b/fs/btrfs/file.c	2025-01-29 09:03:36.935757176 -0800
@@ -1164,15 +1164,6 @@ ssize_t btrfs_buffered_write(struct kioc
 		int extents_locked;
 		bool force_page_uptodate = false;
 
-		/*
-		 * Fault pages before locking them in prepare_one_folio()
-		 * to avoid recursive lock
-		 */
-		if (unlikely(fault_in_iov_iter_readable(i, write_bytes))) {
-			ret = -EFAULT;
-			break;
-		}
-
 		only_release_metadata = false;
 		sector_offset = pos & (fs_info->sectorsize - 1);
 
@@ -1314,6 +1305,17 @@ again:
 
 		cond_resched();
 
+		/*
+		 * Fault pages in a slow path after dropping folio
+		 * lock. This avoids the chance of deadlocking in
+		 * the fault handler.
+		 */
+		if (unlikely(copied == 0) &&
+		    (fault_in_iov_iter_readable(i, write_bytes) == write_bytes)) {
+			ret = -EFAULT;
+			break;
+		}
+
 		pos += copied;
 		num_written += copied;
 	}
_

