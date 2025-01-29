Return-Path: <linux-fsdevel+bounces-40323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FFAA223C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 19:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 770761681E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 18:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA98D1E503C;
	Wed, 29 Jan 2025 18:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KdSHKhWm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4261E3769;
	Wed, 29 Jan 2025 18:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738174677; cv=none; b=RFa0WvxFX1YWqW3Ud1i0YvsCm73wvLp7xIxhdWJp+qZGGr/uwesMDNTuTUwcJv0x/vY4TFAd8XPnRaWTPYoypoNvdtqCbfc1n2O/aAuhQdMwPaYZweuHFDDcJZyq+gPhl9/1vvnygAFDNVgx+ohhjM82p1MVswf1Z4fsyJwL6OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738174677; c=relaxed/simple;
	bh=Paf3+ijHUFNtyyN6KcdjzOxLl545G89WBoHPMc/pbAs=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=sEsrWdemXg2HIknHRW9dEsTUmeBJDDBvgGIuESIZx6eCL77ZMkS7KPO6Cqt+aKU978OlT74tNx2fWj86mKox8q6nkqyn/z0coM195VHezI1GDMt3Sn+sYw/7qxtAHN7fv/iatcMLYavjCedcOfrNYLQ/Krg+hhgD3O15x0v+0R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KdSHKhWm; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738174676; x=1769710676;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=Paf3+ijHUFNtyyN6KcdjzOxLl545G89WBoHPMc/pbAs=;
  b=KdSHKhWm2sVi24l0cEuXjMJZyZvpi6lTA8n+a6RNtlfqgRcNEEyGbpPh
   YRowIxhMjKCNpyJ8ra6ZDZ/D7wd/bslQpE9jwYGFOkavbhbR9MKTUbX43
   KcQqqJJ3a3SJUhIUZLTeCEeoPQf4hz6sh+NUNhADsCYwLuVBObzPsCZx9
   Ksgjx5G1kn46jDW7fQycPrfpN7T+u0JRSs+aRl3tR9l1OXlT778Lw8WsQ
   8vCmVlx0CWJUOO3tmfX+sULSKqYnTRKiRtYsP+BDJOj3WHE3UbUs5KNFB
   ZKJUeDOXQWGt3UU/GtF8/+FA8ijhEY5S9YXiQcRka/6/P7HuSPRRkJpLB
   A==;
X-CSE-ConnectionGUID: IG9ODW5ORSGqepnpkwk8/Q==
X-CSE-MsgGUID: 8KtEdrwwS2WgPXHljg4kUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="38963271"
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="38963271"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 10:17:56 -0800
X-CSE-ConnectionGUID: SdZhgKGNSWS0IVbLVlNSDA==
X-CSE-MsgGUID: u1NfJiPzS/eThxPMpekFDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="109660692"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa010.fm.intel.com with ESMTP; 29 Jan 2025 10:17:55 -0800
Subject: [PATCH 3/7] ntfs3: Move prefaulting out of hot write path
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,Ted Ts'o <tytso@mit.edu>,Christian Brauner <brauner@kernel.org>,Darrick J. Wong <djwong@kernel.org>,Matthew Wilcox (Oracle) <willy@infradead.org>,Al Viro <viro@zeniv.linux.org.uk>,linux-fsdevel@vger.kernel.org,Dave Hansen <dave.hansen@linux.intel.com>,almaz.alexandrovich@paragon-software.com,ntfs3@lists.linux.dev
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 29 Jan 2025 10:17:55 -0800
References: <20250129181749.C229F6F3@davehans-spike.ostc.intel.com>
In-Reply-To: <20250129181749.C229F6F3@davehans-spike.ostc.intel.com>
Message-Id: <20250129181755.D845753B@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

Prefaulting the write source buffer incurs an extra userspace access
in the common fast path. Make ntfs_compress_write() consistent with
generic_perform_write(): only touch userspace an extra time when
copy_page_from_iter_atomic() has failed to make progress.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev
---

 b/fs/ntfs3/file.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff -puN fs/ntfs3/file.c~ntfs-postfault fs/ntfs3/file.c
--- a/fs/ntfs3/file.c~ntfs-postfault	2025-01-29 09:03:33.371460504 -0800
+++ b/fs/ntfs3/file.c	2025-01-29 09:03:33.375460837 -0800
@@ -1092,11 +1092,6 @@ static ssize_t ntfs_compress_write(struc
 		frame_vbo = pos & ~(frame_size - 1);
 		index = frame_vbo >> PAGE_SHIFT;
 
-		if (unlikely(fault_in_iov_iter_readable(from, bytes))) {
-			err = -EFAULT;
-			goto out;
-		}
-
 		/* Load full frame. */
 		err = ntfs_get_frame_pages(mapping, index, pages,
 					   pages_per_frame, &frame_uptodate);
@@ -1172,6 +1167,18 @@ static ssize_t ntfs_compress_write(struc
 		 */
 		cond_resched();
 
+		if (unlikely(!copied)) {
+			/*
+			 * folios are now unlocked and faults on them can be
+			 * handled. Ensure forward progress by trying to
+			 * fault in 'from' in case it maps one of the folios.
+			 */
+			if (fault_in_iov_iter_readable(from, bytes)) {
+				err = -EFAULT;
+				goto out;
+			}
+		}
+
 		pos += copied;
 		written += copied;
 
_

