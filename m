Return-Path: <linux-fsdevel+bounces-40327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAC9A223CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 19:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E077F188916D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 18:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B405E1EE00B;
	Wed, 29 Jan 2025 18:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TnMaWOHx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7531EBA05;
	Wed, 29 Jan 2025 18:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738174685; cv=none; b=lWRSvmIFXQMz8N1ggJbWoseAOonJu6rYSO3MEQ9O4EVpkXv0msX4UUXf1AHGdH4bfp56Fo74d4ZCcB9VFzkFBZDYTWbm18FG7zAs6od+34S2Yg3U7yZe0lymgajlgGLvLehLR/11Lj08b9O5TfcyOKO2lDxOJLO5vUnp9nbhX6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738174685; c=relaxed/simple;
	bh=9HMpAKh/G4dXrhwsbs3yhGRxyGR4nQmn1BXXS8DWYsE=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=MlSIpcmmcmwFAzAstpcDH0rnczEIC2bStu4J2jKKOHZSjlbrIPxkZbg2b4rANamZBzA2J0BS0YAQ6j5LGhkKE36OWtYrsWFcLizitnYtGlk5Iz9lIhme7NZ5niKKypIpuoZlECKXH52IQPTluAcqhjQEaSi3oyj0q/LT4d1HAjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TnMaWOHx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738174684; x=1769710684;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=9HMpAKh/G4dXrhwsbs3yhGRxyGR4nQmn1BXXS8DWYsE=;
  b=TnMaWOHxyAe4ENoSZvC+i6KPCsti1e1nS6DP5xZE9Oe0ymbqcBIubzFY
   9x6TFS8Tvf6pe/2NJmpMkrGjeWPsjn0UsFvHyehdLU73MF5xdThHLX4D9
   sybgieatb4S+JJ126pc6LGc/G/z6wMCL3vyhBhIKs0CZeJBk4rCrQUlty
   gYMNkAncfxShlqYDIlAZj9HwGLrFv2f+EoZ+BX24iCwEbH3fHoLMoNsXB
   dWayiqLmJRFs/vdAHlfCrTJjtYWEz1NhCxTbaW9+jkXNG9op4qKP+tluV
   xVq3lNfXBnQznhif6OXGqGH79MvVbCNAxOGyCEI1h43rxXcwQesY7sWkw
   Q==;
X-CSE-ConnectionGUID: YIYHpa4gQPm94xF5loQhjg==
X-CSE-MsgGUID: fw1m8w2nSAeiAaJ6CZ/WXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="38963322"
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="38963322"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 10:18:03 -0800
X-CSE-ConnectionGUID: hsjZ6/uvRziZN2sfKstoGg==
X-CSE-MsgGUID: l/QrJ4vaTxCyPyjoeQ16lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="109660718"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa010.fm.intel.com with ESMTP; 29 Jan 2025 10:18:02 -0800
Subject: [PATCH 7/7] netfs: Remove outdated comments about prefaulting
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,Ted Ts'o <tytso@mit.edu>,Christian Brauner <brauner@kernel.org>,Darrick J. Wong <djwong@kernel.org>,Matthew Wilcox (Oracle) <willy@infradead.org>,Al Viro <viro@zeniv.linux.org.uk>,linux-fsdevel@vger.kernel.org,Dave Hansen <dave.hansen@linux.intel.com>,dhowells@redhat.com,jlayton@kernel.org,netfs@lists.linux.dev
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 29 Jan 2025 10:18:02 -0800
References: <20250129181749.C229F6F3@davehans-spike.ostc.intel.com>
In-Reply-To: <20250129181749.C229F6F3@davehans-spike.ostc.intel.com>
Message-Id: <20250129181802.6E1E4149@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

I originally set out to make netfs_perform_write() behavior more
consistent with generic_perform_write(). However, netfs currently
treats a failure to make forward progress as a hard error and does not
retry where the generic code will loop around and retry.

Instead of a major code restructuring, just focus on improving the
comments.

The comment refers to a possible deadlock and to userspace address
checks. Neither of those things are a concern when using
copy_folio_from_iter_atomic() for atomic usercopies. It prevents
deadlocks by disabling page faults and it leverages user copy
functions that have their own access_ok() checks.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: netfs@lists.linux.dev
---

 b/fs/netfs/buffered_write.c |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff -puN fs/netfs/buffered_write.c~netfs-postfault fs/netfs/buffered_write.c
--- a/fs/netfs/buffered_write.c~netfs-postfault	2025-01-29 09:03:38.167859749 -0800
+++ b/fs/netfs/buffered_write.c	2025-01-29 09:03:38.171860082 -0800
@@ -152,16 +152,9 @@ ssize_t netfs_perform_write(struct kiocb
 		offset = pos & (max_chunk - 1);
 		part = min(max_chunk - offset, iov_iter_count(iter));
 
-		/* Bring in the user pages that we will copy from _first_ lest
-		 * we hit a nasty deadlock on copying from the same page as
-		 * we're writing to, without it being marked uptodate.
-		 *
-		 * Not only is this an optimisation, but it is also required to
-		 * check that the address is actually valid, when atomic
-		 * usercopies are used below.
-		 *
-		 * We rely on the page being held onto long enough by the LRU
-		 * that we can grab it below if this causes it to be read.
+		/* Bring in the user folios that are copied from before taking
+		 * locks on the mapping folios. This helps ensure forward
+		 * progress if they are the same folios.
 		 */
 		ret = -EFAULT;
 		if (unlikely(fault_in_iov_iter_readable(iter, part) == part))
_

