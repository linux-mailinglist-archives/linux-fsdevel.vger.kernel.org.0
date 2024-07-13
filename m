Return-Path: <linux-fsdevel+bounces-23630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A604930332
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2024 04:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D35582837E4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2024 02:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23703171A7;
	Sat, 13 Jul 2024 02:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I13Twe6b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA63F29401;
	Sat, 13 Jul 2024 02:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720836819; cv=none; b=K5gEB5lOcyHGPyKyeO5I3qk+bVPEVMg8O17MHEwa1zW3EMQTQkWJa/QSR0VvC1zYBluCPsuu1Z4f5oQvTxreQB9VYWshCEigi9z9cs6/FfsSehRoUxgW7v7rpWWX8/2IPzEg5M7s6EbDkTo0nB8jXIa8d2qxA+NufgnZFKEvosM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720836819; c=relaxed/simple;
	bh=2Em9aXUK4hj994y2DrlM4htA/Mn72IIDxtASYHeCNb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJHHo7rHsfK7b7FEP+HfmPLiwlfcPY3hLXG5z8Nh+94tWFCHJsBwY+gW+TAhJvTL46DRRs4kX4uHo9MsDxV/mDUvBfxlnu9twGDT6cDVCAyr5rApXnjSkTfaSGebOT5jD5ONO/wJNTWXEGYKqW1HW7CBag04k74C3OIpyKCYpPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I13Twe6b; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720836818; x=1752372818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2Em9aXUK4hj994y2DrlM4htA/Mn72IIDxtASYHeCNb4=;
  b=I13Twe6bliP/N1tsoZmV0HhkwLJrismCYuvOWxzry+fmF1Q8GiDXLQHU
   3xBegFQoKDHwV86wdgc/t3X6Eoh4WhpOBmGw0omtj5LY9DttqxtiwjXSF
   Ho3aVeuYzInytoDRbrP2hijp3ruZbVFsdchMye+bIRMoo+Cwvky/loXVW
   iLtbLB/G18kRSwnttotXSWo5VHmqQBXscUGgK0aVmx5kDxBJJw9k5U78d
   4dS7xDDSI+CiHIUbml1TEmOlJve9mM8HohgeLFJASs0oBE+UEBbO+PiUt
   WzlUHEBiaxkIdokxU/bQQ9TsNVDGSKnAUtv0GY1YTesiup5i6L45F8rFm
   w==;
X-CSE-ConnectionGUID: mdm38AozTt2ruVqvQw6bgg==
X-CSE-MsgGUID: SavpnTgUTeiB3G46bIwxqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="12531282"
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="12531282"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 19:13:37 -0700
X-CSE-ConnectionGUID: eMkj99wjQe2+EhROswhplQ==
X-CSE-MsgGUID: RMdm8jjqShaZtcmnZ6/B0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="53449935"
Received: from linux-pnp-server-16.sh.intel.com ([10.239.177.152])
  by fmviesa005.fm.intel.com with ESMTP; 12 Jul 2024 19:13:35 -0700
From: Yu Ma <yu.ma@intel.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	mjguzik@gmail.com,
	edumazet@google.com
Cc: yu.ma@intel.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pan.deng@intel.com,
	tianyou.li@intel.com,
	tim.c.chen@intel.com,
	tim.c.chen@linux.intel.com
Subject: [PATCH v4 3/3] fs/file.c: add fast path in find_next_fd()
Date: Fri, 12 Jul 2024 22:39:17 -0400
Message-ID: <20240713023917.3967269-4-yu.ma@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240713023917.3967269-1-yu.ma@intel.com>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240713023917.3967269-1-yu.ma@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Skip 2-levels searching via find_next_zero_bit() when there is free slot in the
word contains next_fd, as:
(1) next_fd indicates the lower bound for the first free fd.
(2) There is fast path inside of find_next_zero_bit() when size<=64 to speed up
searching.
(3) After fdt is expanded (the bitmap size doubled for each time of expansion),
it would never be shrunk. The search size increases but there are few open fds
available here.

This fast path is proposed by Mateusz Guzik <mjguzik@gmail.com>, and agreed by
Jan Kara <jack@suse.cz>, which is more generic and scalable than previous
versions. And on top of patch 1 and 2, it improves pts/blogbench-1.1.0 read by
8% and write by 4% on Intel ICX 160 cores configuration with v6.10-rc7.

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Yu Ma <yu.ma@intel.com>
---
 fs/file.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/file.c b/fs/file.c
index 1be2a5bcc7c4..a3ce6ba30c8c 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -488,9 +488,20 @@ struct files_struct init_files = {
 
 static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
 {
+	unsigned int bitbit = start / BITS_PER_LONG;
+	unsigned int bit;
+
+	/*
+	 * Try to avoid looking at the second level bitmap
+	 */
+	bit = find_next_zero_bit(&fdt->open_fds[bitbit], BITS_PER_LONG,
+				 start & (BITS_PER_LONG -1));
+	if (bit < BITS_PER_LONG) {
+		return bit + bitbit * BITS_PER_LONG;
+	}
+
 	unsigned int maxfd = fdt->max_fds; /* always multiple of BITS_PER_LONG */
 	unsigned int maxbit = maxfd / BITS_PER_LONG;
-	unsigned int bitbit = start / BITS_PER_LONG;
 
 	bitbit = find_next_zero_bit(fdt->full_fds_bits, maxbit, bitbit) * BITS_PER_LONG;
 	if (bitbit >= maxfd)
-- 
2.43.0


