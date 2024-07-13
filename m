Return-Path: <linux-fsdevel+bounces-23629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A83930330
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2024 04:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28B041C21471
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2024 02:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FF11BDC8;
	Sat, 13 Jul 2024 02:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hC4OsMzE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E251B59A;
	Sat, 13 Jul 2024 02:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720836807; cv=none; b=hxEkbaQgu6UfyYA3HqN10/nvwrqpluZDbRFFUMgqv69A503XTX2WOs9EMwTY/NfCEbcNCzZjQBn40v45S7B+gPQf/qqkSf/qLvWzwo7Nn1zfCz00WNLDnQFCljAyhI1kV1htgweU51Z6eKfZ8SDf0r6lgBsWRPekuy9wl7cX9x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720836807; c=relaxed/simple;
	bh=Kh4pfuxGLBxgdiaqyNTwfQleD37uUT2ITDpzkzR/xrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oba5kbVkegvVzbTJaE4YpWKqNOtTqx2AM348mqcj9ZBvkhLZRL7vj/6JegwPkOd7r5H/rUcHw9bBLY+e5/+qzIfED1RySp4qeGKrZixP+svZvyufwWdDPUMU0S3SyXmHm3KGKti0UKHY+TynHaJwJOetuSCYrnB3ziTuTUdnwAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hC4OsMzE; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720836805; x=1752372805;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kh4pfuxGLBxgdiaqyNTwfQleD37uUT2ITDpzkzR/xrE=;
  b=hC4OsMzEfVG3arH4E70Q1XJmaZkUo1emcNz1QCFkVNTA7H3CejMakhXY
   RBADPdstOlcQEV3+Oe4Bw5U77u0n2tJE0ffc+NHebwFLVxRoPubIvQzfi
   1chapfMNes2O80csGIPlWFqZ6Yw+LNwbB2z8woqBv2nFQIFn2aBfVYK1F
   YiaPew57QlOLm5OIVK3LcY6GY51U5g2k8eDvNvTHnqvId5gnKOiR6AML6
   Lhkxg++e4QMjAnBAoKdN6/64sDkVRslmKHlfKv/BekACLkUDZQjvOKCG6
   mOSAuaRI8QHgJ9MNsb7E4LJAfK0jMgQJfev41p5eGBJzeRsWGYlDcd0yN
   A==;
X-CSE-ConnectionGUID: GRPMHdH2RjC8rkFNTerYgw==
X-CSE-MsgGUID: D/YVpXdmTJqC0NpbaHVP8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="12531275"
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="12531275"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 19:13:25 -0700
X-CSE-ConnectionGUID: qaXw09J2RMml9GYf4aC60w==
X-CSE-MsgGUID: rxMb0jNBT6Gvdt0jcUujNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="53449901"
Received: from linux-pnp-server-16.sh.intel.com ([10.239.177.152])
  by fmviesa005.fm.intel.com with ESMTP; 12 Jul 2024 19:13:23 -0700
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
Subject: [PATCH v4 2/3] fs/file.c: conditionally clear full_fds
Date: Fri, 12 Jul 2024 22:39:16 -0400
Message-ID: <20240713023917.3967269-3-yu.ma@intel.com>
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


