Return-Path: <linux-fsdevel+bounces-23829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91973933E59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 16:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C3F3B22EBA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 14:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187C9181BAD;
	Wed, 17 Jul 2024 14:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fy6SN/er"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08223181B9D;
	Wed, 17 Jul 2024 14:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721226267; cv=none; b=oRmeDFzCuN9D8kIS6qZloCP1nre5GuM4wWvcXjQmrWMyGWoqYS29AdZHpZRtODMJLHniNVzUIyF5HgmqQ33nimCBAHYgp2zY801p4a+N3Cfykk+2cTPwTxgEfJI9r6oSNhoedqzKWtoCXsxxhneWzdRMF+C+EYpEmSHe02ZK08w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721226267; c=relaxed/simple;
	bh=Kh4pfuxGLBxgdiaqyNTwfQleD37uUT2ITDpzkzR/xrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1dMhZsS6sBlltJkyjAR9SOrZQuRGat1sHtehykpHHG0l3JDhfL1c4wEkyKYjuZHYNxnHJjBJq8hQM4oBvxb6/0n1IFO/9qNeT1nnwWm/tNaXLLmB2GHx5ribVIZmCjfHgzfS54IT7VV6VFfg+DzNdV8WkcvxaDBiZr8JpQYgTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fy6SN/er; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721226266; x=1752762266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kh4pfuxGLBxgdiaqyNTwfQleD37uUT2ITDpzkzR/xrE=;
  b=fy6SN/erViQY/T9aZP5o/Tz+BPx1AUlPTzS//1Zc6fl/RJvEgLX5dR47
   VVomtFxbR59tfGEFukvP7yrSL+VI/PuCuCYzQNIg71aNxc9HTDBKSS3+o
   rMRkeiHy+XUYWpWZoHgwSaT88QgHB/7LTRgAdbhZG+EWVd8C76PVqqAz7
   ZTEf8I55hH9d1W48iuCMTXZVpa7wjXfjgNe2C9AIehzyciZs3/j1R6f6Y
   aKfR+yKTcFBjmzdAcgn4M4Q7TF6iXQeYkdVN1tkZD2fSKqW9pX7u9Psu5
   CeOAWeBmtXu8rscaeWyOrdLR4IDZa38beqZbxaLB3xUoKItvK/RCwBuUa
   Q==;
X-CSE-ConnectionGUID: lngoh8SWQFqXmqJO7wZTIQ==
X-CSE-MsgGUID: QBMAo62mSaiOLNipgAt4vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="29313612"
X-IronPort-AV: E=Sophos;i="6.09,214,1716274800"; 
   d="scan'208";a="29313612"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 07:24:26 -0700
X-CSE-ConnectionGUID: CEkVs3P5Tbq1F6EAmHUYJA==
X-CSE-MsgGUID: goXXb7AdRq+15HZ9J1hM0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,214,1716274800"; 
   d="scan'208";a="54596632"
Received: from linux-pnp-server-16.sh.intel.com ([10.239.177.152])
  by fmviesa003.fm.intel.com with ESMTP; 17 Jul 2024 07:24:24 -0700
From: Yu Ma <yu.ma@intel.com>
To: brauner@kernel.org,
	jack@suse.cz,
	mjguzik@gmail.com,
	edumazet@google.com
Cc: yu.ma@intel.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pan.deng@intel.com,
	tianyou.li@intel.com,
	tim.c.chen@intel.com,
	tim.c.chen@linux.intel.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH v5 2/3] fs/file.c: conditionally clear full_fds
Date: Wed, 17 Jul 2024 10:50:17 -0400
Message-ID: <20240717145018.3972922-3-yu.ma@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717145018.3972922-1-yu.ma@intel.com>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240717145018.3972922-1-yu.ma@intel.com>
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
take stock kernel with patch 1 as baseline, it improves pts/blogbench-1.1.0
read for 13%, and write for 5% on Intel ICX 160 cores configuration with
v6.10-rc7.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Yu Ma <yu.ma@intel.com>
---
 fs/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/file.c b/fs/file.c
index e1b9d6df7941..1be2a5bcc7c4 100644
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


