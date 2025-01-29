Return-Path: <linux-fsdevel+bounces-40324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CBEA223C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 19:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5CEE168508
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 18:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678A81E990A;
	Wed, 29 Jan 2025 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rh0mfakG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAAF1E5714;
	Wed, 29 Jan 2025 18:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738174679; cv=none; b=IzHGZXrH5kZfczSLzWZdgcHmBay4KaEtB288EIzGjlAbKvV6QVsieSXj1RvGkRWY2gHIzhSpUao153FpTW6kC6IMXi3bxK86qFwxM5xHX71SSfOlFJCNv5QaBQbwX6+nrIeuMh1VpB7k2zr2GZ8NEnGCwqI97iBY7b8VNbTNHxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738174679; c=relaxed/simple;
	bh=ZB1S1SiyH/U7od1QypPsMdpBO9FAAMDntVuVsY0yEUA=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=HvS7HSnLbLPsf99XNe6DYkqFEh/qppcprCrkM1Pg/lEM0suys1DAQNZfLtJfOjHIfsaNV7hEix7zpFw8pZKPrF5ueWmA8fp+vXo8/P2KaXPsQuVkOAqGzoclZ14netOptHQm5SOuiNVU7Y73S3M2guerqo3/Xic8Y/cXWmQQ04Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rh0mfakG; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738174678; x=1769710678;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=ZB1S1SiyH/U7od1QypPsMdpBO9FAAMDntVuVsY0yEUA=;
  b=Rh0mfakGvpilO828H34QeflaT849kchi/bQLR49cGOy5KuuaOzMrI8G7
   95X1+/y4WuJGkTrxTkarr8onvW56Ot8PmyzeLooNZWwTOCGjTXrDiKPfD
   s80piaF2xj63PZuAV7tdVbiaDvF3oflsouK3xIqPXTlAR+b0uAxCcRFnk
   WxVwjdWpdXcIWKPfxvI5Fk4iZlHIEAwPLVy1Vg96vhnRcvMT734S4O3+n
   /pG9A6hPYA1mA2FAbmBKqhLUCE6SPWSD5Fqy23/3qI0pNcZTO5FCUrMSJ
   yrv98cn4k1vUynm9/wqXIcFTh7FdhEVC/+kHBP9xyrSC35raxTa63DblM
   w==;
X-CSE-ConnectionGUID: ck3zQTxsSrOww0uQpsj29g==
X-CSE-MsgGUID: ILF4TMggRYGsNSWgKtB4Fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="38963280"
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="38963280"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 10:17:58 -0800
X-CSE-ConnectionGUID: yOkUViQpTzuW2zKP0RUutg==
X-CSE-MsgGUID: /MDk59v4REuZdJJqDwVRNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="109660696"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa010.fm.intel.com with ESMTP; 29 Jan 2025 10:17:57 -0800
Subject: [PATCH 4/7] fuse: Move prefaulting out of hot write path
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,Ted Ts'o <tytso@mit.edu>,Christian Brauner <brauner@kernel.org>,Darrick J. Wong <djwong@kernel.org>,Matthew Wilcox (Oracle) <willy@infradead.org>,Al Viro <viro@zeniv.linux.org.uk>,linux-fsdevel@vger.kernel.org,Dave Hansen <dave.hansen@linux.intel.com>,miklos@szeredi.hu
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 29 Jan 2025 10:17:56 -0800
References: <20250129181749.C229F6F3@davehans-spike.ostc.intel.com>
In-Reply-To: <20250129181749.C229F6F3@davehans-spike.ostc.intel.com>
Message-Id: <20250129181756.44C9597C@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

Prefaulting the write source buffer incurs an extra userspace access
in the common fast path. Make fuse_fill_write_pages() consistent with
generic_perform_write(): only touch userspace an extra time when
copy_folio_from_iter_atomic() has failed to make progress.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
---

 b/fs/fuse/file.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff -puN fs/fuse/file.c~fuse-postfault fs/fuse/file.c
--- a/fs/fuse/file.c~fuse-postfault	2025-01-29 09:03:34.515555724 -0800
+++ b/fs/fuse/file.c	2025-01-29 09:03:34.523556390 -0800
@@ -1234,10 +1234,6 @@ static ssize_t fuse_fill_write_pages(str
 		bytes = min_t(size_t, bytes, fc->max_write - count);
 
  again:
-		err = -EFAULT;
-		if (fault_in_iov_iter_readable(ii, bytes))
-			break;
-
 		folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
 					    mapping_gfp_mask(mapping));
 		if (IS_ERR(folio)) {
@@ -1254,6 +1250,16 @@ static ssize_t fuse_fill_write_pages(str
 		if (!tmp) {
 			folio_unlock(folio);
 			folio_put(folio);
+
+			/*
+			 * Ensure forward progress by faulting in
+			 * while not holding the folio lock:
+			 */
+			if (fault_in_iov_iter_readable(ii, bytes)) {
+				err = -EFAULT;
+				break;
+			}
+
 			goto again;
 		}
 
_

