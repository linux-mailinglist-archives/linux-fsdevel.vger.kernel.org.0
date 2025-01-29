Return-Path: <linux-fsdevel+bounces-40322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5424A223BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 19:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37FA1168043
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 18:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56AF1E3DED;
	Wed, 29 Jan 2025 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QXa+/qWQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAF71E231D;
	Wed, 29 Jan 2025 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738174676; cv=none; b=KjZv1lDFjiP2dkj5eBn+oC8wlmy7S9vCDhryMw2XjtWz0VEp3xM2nxWk4a1G+MLsE6Is1GXjEbgNfF1Iul9MxIRwdAifQe5Ilk255DCntStiKr7jbTSwQd75WYgEBX8sGSp0K1n/0z5yOdA+SwiAkj5qQ1tRe+V73FTUG8dlbdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738174676; c=relaxed/simple;
	bh=Hk50vFeQpYvObpB97CiiwSn4PpFmEbUPkBXYfgNIvTs=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=s7PSnmzwXtSJyl/sMu5frmcTScrIhqvQrHKeh1FXQviQNuxvZMbTmKnUOdBXsryMhrjSA1shJ9hS2FJsp+wTKTJUW9x7LpKZbZYVQ8wS89qXeySlwvs9t5F8xk7V34zao1xOSaNutupoeW0IQvXYJ+j9AI70t+yEBGRxKcMuWqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QXa+/qWQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738174675; x=1769710675;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=Hk50vFeQpYvObpB97CiiwSn4PpFmEbUPkBXYfgNIvTs=;
  b=QXa+/qWQYsn4rZ/tA8KKdVtuSJc9Yq8BxC+kUt3Hf5ct9s/658Y8Rlig
   cSILHzBP9PsfIhzrYiyDdKcfUBjZaEI9VFYb84FZauXpw4/mpLXih7uOR
   9Yp5X73I8AlIQa3SfRkmeArx2zuNP3Zou3WmjwK+qTNZREm9vcm+Uumgp
   V79YdOpMp2QQ/GBt2IQ5UN5amxz9R9rTfS/tv63KD41CLy8cTVr66bVnt
   eoo84ry3deDN7RyItmcg+jkzs/AT+d7z8xC1DaulS4mfu6oRLUezj8w7N
   8RB6z7lUfFrh3smCKvRUzEDNqXuYMKt3HB9P0bYHovlAL7DX3INfvBKOs
   Q==;
X-CSE-ConnectionGUID: h2GXtnxBRZy1IxIlRUc1uQ==
X-CSE-MsgGUID: nrfLazYMRiCkcmVEt/Wuxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="38963260"
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="38963260"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 10:17:54 -0800
X-CSE-ConnectionGUID: HC18c4gKT0mRme/zoCGBCw==
X-CSE-MsgGUID: XSURPr9BTAOZvctmvN1GRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="109660686"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa010.fm.intel.com with ESMTP; 29 Jan 2025 10:17:53 -0800
Subject: [PATCH 2/7] iomap: Move prefaulting out of hot write path
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,Ted Ts'o <tytso@mit.edu>,Christian Brauner <brauner@kernel.org>,Darrick J. Wong <djwong@kernel.org>,Matthew Wilcox (Oracle) <willy@infradead.org>,Al Viro <viro@zeniv.linux.org.uk>,linux-fsdevel@vger.kernel.org,Dave Hansen <dave.hansen@linux.intel.com>,linux-xfs@vger.kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 29 Jan 2025 10:17:53 -0800
References: <20250129181749.C229F6F3@davehans-spike.ostc.intel.com>
In-Reply-To: <20250129181749.C229F6F3@davehans-spike.ostc.intel.com>
Message-Id: <20250129181753.3927F212@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

Prefaulting the write source buffer incurs an extra userspace access
in the common fast path. Make iomap_write_iter() consistent with
generic_perform_write(): only touch userspace an extra time when
copy_folio_from_iter_atomic() has failed to make progress.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org
---

 b/fs/iomap/buffered-io.c |   24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff -puN fs/iomap/buffered-io.c~iomap-postfault fs/iomap/buffered-io.c
--- a/fs/iomap/buffered-io.c~iomap-postfault	2025-01-29 09:03:32.179361299 -0800
+++ b/fs/iomap/buffered-io.c	2025-01-29 09:03:32.187361965 -0800
@@ -937,21 +937,6 @@ retry:
 		if (bytes > length)
 			bytes = length;
 
-		/*
-		 * Bring in the user page that we'll copy from _first_.
-		 * Otherwise there's a nasty deadlock on copying from the
-		 * same page as we're writing to, without it being marked
-		 * up-to-date.
-		 *
-		 * For async buffered writes the assumption is that the user
-		 * page has already been faulted in. This can be optimized by
-		 * faulting the user page.
-		 */
-		if (unlikely(fault_in_iov_iter_readable(i, bytes) == bytes)) {
-			status = -EFAULT;
-			break;
-		}
-
 		status = iomap_write_begin(iter, pos, bytes, &folio);
 		if (unlikely(status)) {
 			iomap_write_failed(iter->inode, pos, bytes);
@@ -1005,6 +990,15 @@ retry:
 				bytes = copied;
 				goto retry;
 			}
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
 			pos += written;
 			total_written += written;
_

