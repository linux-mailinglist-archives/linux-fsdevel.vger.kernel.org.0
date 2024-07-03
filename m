Return-Path: <linux-fsdevel+bounces-23034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CCC9262F0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 16:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F02E4B2A3DE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 14:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11DB17DA35;
	Wed,  3 Jul 2024 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MSFFQ4Ba"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24CD17B501;
	Wed,  3 Jul 2024 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015642; cv=none; b=LwKH+B5sUqu031iRUVT/SCc/eiwg1S6HADRL8DBupPffecj+o2ZWmwUj1KNVRgBoi4Yskw4QqApFoBeYcHlCBBnax0yOJi7aB/sX/+nl8ojm7AVPbf5pYk+AliHeBYwJj2N2tIhCeLsGnUDhUNliuK5JO1SA3eDuCQfPYcYc/qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015642; c=relaxed/simple;
	bh=tkmY9I0q+40NyjPrxluCu/UB2+hGM/Hp1Gj0qiZNw8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nR4CpYEYWhx9w3m1FbkZqut5cxE+okSuxbUBPAev3ZG7zOsGY8jvIrjqay7zvh909NZw6gp6NeN+51rIsoh+KdzWzVRTMBx0q/IsK9f+eo6dJDJ8gxr3e3NW8Bm+ULkhM16GXG3T/husu+4lcK22lFwnzshsvFCDmxWHcKkdPPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MSFFQ4Ba; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720015641; x=1751551641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tkmY9I0q+40NyjPrxluCu/UB2+hGM/Hp1Gj0qiZNw8w=;
  b=MSFFQ4BaB+zkOX8uA8n/WkaUubX4vbu7K/911VCgOO4Z6yeqp3o9mfvE
   +F7E/voqwpp5aUkpPhWWc+wB1rnaTJAftKwypaPr63bl5u40tzCx3O/cy
   y3mnl+kwc2trF6KfuECfeiFGH6MJTMr+ZqPnEqmLDEXAIClSWHLz2ypJV
   jwH0ZXS/kuVkFEBoBeE4hMY7la+7PYkkAy1cocL6TuZjcLzogCOMaP7zN
   I7BAK+WfoJdSh8VNAOXibwctqiDbN1NIpG51jzzaiQuW5G1l7g2W3XRTP
   PzcY0T5b/dRdwMDfLLv7iTt61GqoDqpkBWaybbj6SFbMau+IBR1Dam8Ts
   g==;
X-CSE-ConnectionGUID: 2U7NZC/DQ0C77zbLdLLVng==
X-CSE-MsgGUID: QaHpGd+ISsWGa8LXoSHpYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="16900716"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="16900716"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 07:07:21 -0700
X-CSE-ConnectionGUID: jbiKvuIdSmq3Psj50HB5bQ==
X-CSE-MsgGUID: 4YFiFHXHRMGFRybRNZopDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="46693488"
Received: from linux-pnp-server-16.sh.intel.com ([10.239.177.152])
  by orviesa006.jf.intel.com with ESMTP; 03 Jul 2024 07:07:17 -0700
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
Subject: [PATCH v3 2/3] fs/file.c: conditionally clear full_fds
Date: Wed,  3 Jul 2024 10:33:10 -0400
Message-ID: <20240703143311.2184454-3-yu.ma@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240703143311.2184454-1-yu.ma@intel.com>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240703143311.2184454-1-yu.ma@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

64 bits in open_fds are mapped to a common bit in full_fds_bits. It is very
likely that a bit in full_fds_bits has been cleared before in
__clear_open_fds()'s operation. Check the clear bit in full_fds_bits before
clearing to avoid unnecessary write and cache bouncing. See commit fc90888d07b8
("vfs: conditionally clear close-on-exec flag") for a similar optimization.
Take stock kernel with patch 1 as baseline, it improves pts/blogbench-1.1.0
read for 13%, and write for 5% on Intel ICX 160 cores configuration with
v6.10-rc6.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Yu Ma <yu.ma@intel.com>
---
 fs/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/file.c b/fs/file.c
index 5178b246e54b..a15317db3119 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -268,7 +268,9 @@ static inline void __set_open_fd(unsigned int fd, struct fdtable *fdt)
 static inline void __clear_open_fd(unsigned int fd, struct fdtable *fdt)
 {
 	__clear_bit(fd, fdt->open_fds);
-	__clear_bit(fd / BITS_PER_LONG, fdt->full_fds_bits);
+	fd /= BITS_PER_LONG;
+	if (test_bit(fd, fdt->full_fds_bits))
+		__clear_bit(fd, fdt->full_fds_bits);
 }
 
 static inline bool fd_is_open(unsigned int fd, const struct fdtable *fdt)
-- 
2.43.0


