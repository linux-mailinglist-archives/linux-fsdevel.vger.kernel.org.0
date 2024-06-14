Return-Path: <linux-fsdevel+bounces-21716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACB7908FB1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 18:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19161F22AD7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 16:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B8917FAA4;
	Fri, 14 Jun 2024 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KJemTTI4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76299181323;
	Fri, 14 Jun 2024 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718381336; cv=none; b=FqCXoUSiBf9M+Q0wrEXYS2sfpG50GhDTa4W48DTurcBDPuyKcsURQMIG6Wo7czRw6//YebHkK/ycuN+J9LCzN6LGiHBFktep4B1eiVCSoju+hLgyuuvpGGI1nWUeGCf+ctLI0mANWawOA6Z75GluYu95BHEg986U0xfHLAS6www=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718381336; c=relaxed/simple;
	bh=PW1CwgwF4DEJPAtCw5E8u2zb9VKV5pgVkPiDLQwmwMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kRDwojqr4km8qBGEjgG6gCgKqhQN/rgsgqGe3tnwaD/ISLh9XVZinIoQJfcosNyY9Tgj7ZVWW0bUYYMmmLwFS9/mKu/fgBvfiosl9bMorBQ0Kt2epL0qZFhD3BT4LntvVc1sVXKBuM6bvjw2kBjhwgSJasBtGIFB7QdNPW8o8Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KJemTTI4; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718381334; x=1749917334;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PW1CwgwF4DEJPAtCw5E8u2zb9VKV5pgVkPiDLQwmwMg=;
  b=KJemTTI48iVgiG+z1cqTsCyZOSKwMmF+owKz8g7Lp7FxJjfr7PUwsgYY
   Vs6gFTXhIjtjuPqRzgSZYldKayrG4d8KbX7dSTvp8a9xonaVqU1lyy+OC
   R1Oez9MMFLsVnLZOLNO+dkudMILQwfAsGV1NVuX1DArzuSqAPx3LCjvaM
   rGBQiE/P8Y+a6YXX7p1Et4cF0Hb7b/Ou51A15ADxlUnaqXdkkkwSmRgoG
   cN6FW+PTVgbUtRLx+15HT3GZuQhMu7SMZ241Wy21x5Ue/pXUIQFhV4+s5
   J/hhxElhvjbVAAnhODvvvNYUBVU7ef9iQ+UeJfJOrJCxKYjvbu3IEewU9
   w==;
X-CSE-ConnectionGUID: ipZD0eH/RSCv9qktbPlTlQ==
X-CSE-MsgGUID: uf3cEddyQHyZOPtJS2A3lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="15399385"
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="15399385"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 09:08:54 -0700
X-CSE-ConnectionGUID: yBxsODLRSlK45G+x8PXgMA==
X-CSE-MsgGUID: ygVkJ34WQKyUBeRivbolNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="71741074"
Received: from linux-pnp-server-16.sh.intel.com ([10.239.177.152])
  by fmviesa001.fm.intel.com with ESMTP; 14 Jun 2024 09:08:51 -0700
From: Yu Ma <yu.ma@intel.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tim.c.chen@linux.intel.com,
	tim.c.chen@intel.com,
	pan.deng@intel.com,
	tianyou.li@intel.com,
	yu.ma@intel.com
Subject: [PATCH 1/3] fs/file.c: add fast path in alloc_fd()
Date: Fri, 14 Jun 2024 12:34:14 -0400
Message-ID: <20240614163416.728752-2-yu.ma@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240614163416.728752-1-yu.ma@intel.com>
References: <20240614163416.728752-1-yu.ma@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is available fd in the lower 64 bits of open_fds bitmap for most cases
when we look for an available fd slot. Skip 2-levels searching via
find_next_zero_bit() for this common fast path.

Look directly for an open bit in the lower 64 bits of open_fds bitmap when a
free slot is available there, as:
(1) The fd allocation algorithm would always allocate fd from small to large.
Lower bits in open_fds bitmap would be used much more frequently than higher
bits.
(2) After fdt is expanded (the bitmap size doubled for each time of expansion),
it would never be shrunk. The search size increases but there are few open fds
available here.
(3) There is fast path inside of find_next_zero_bit() when size<=64 to speed up
searching.

With the fast path added in alloc_fd() through one-time bitmap searching,
pts/blogbench-1.1.0 read is improved by 20% and write by 10% on Intel ICX 160
cores configuration with v6.8-rc6.

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Yu Ma <yu.ma@intel.com>
---
 fs/file.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 3b683b9101d8..e8d2f9ef7fd1 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -510,8 +510,13 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
 	if (fd < files->next_fd)
 		fd = files->next_fd;
 
-	if (fd < fdt->max_fds)
+	if (fd < fdt->max_fds) {
+		if (~fdt->open_fds[0]) {
+			fd = find_next_zero_bit(fdt->open_fds, BITS_PER_LONG, fd);
+			goto success;
+		}
 		fd = find_next_fd(fdt, fd);
+	}
 
 	/*
 	 * N.B. For clone tasks sharing a files structure, this test
@@ -531,7 +536,7 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
 	 */
 	if (error)
 		goto repeat;
-
+success:
 	if (start <= files->next_fd)
 		files->next_fd = fd + 1;
 
-- 
2.43.0


