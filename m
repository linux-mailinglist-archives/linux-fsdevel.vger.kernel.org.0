Return-Path: <linux-fsdevel+bounces-22179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 125809134C8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2024 17:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B270E1F23894
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2024 15:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8163516F8F5;
	Sat, 22 Jun 2024 15:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S0VCrHOz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2F3170831;
	Sat, 22 Jun 2024 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719069796; cv=none; b=JsSDLPwV8PwM/6LrktvjY55bBdCNSO6UJG94guqzyVTcQIjAj0KuevxucEbbulw9+CD0XYwdKk2oUAUas9Gmd83k594ndZGy0lezJ+DINgPzEGCRYBsjL2Cr+UTpWGSuiZAgEvScaS2DsogZD+eKmopaIfEYq+4RL8nXpMxjaYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719069796; c=relaxed/simple;
	bh=g9kJGRRRbLpi96eXV/nMIG4vmmZQtau79XbMSAyQ/oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KaPS11TodLmBcLKCJfyroHiJ1E3R+eUSKNBUuNuw6YCVlL4zAPoX8IVKpLwvu9E8FB0mre/79Fba37qfwMc/CT0hOaGt08eSalddDKfktfH49MVxpbDXhZKFO+z2MXluHHrfHJNzumLaPj7fghxNbW8LaLcVr66jMZaj9v7PtLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S0VCrHOz; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719069794; x=1750605794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g9kJGRRRbLpi96eXV/nMIG4vmmZQtau79XbMSAyQ/oM=;
  b=S0VCrHOzbciFLCEkpS2gFgnxtbBKaS3nRCKWUvIOOXVmBukg+zvrLHzF
   O6SiEZAoiPlkak4gS6wD1tDfzSWveXhKAhZx4IPfe59K0yawhZRgEyfN9
   Sdk01QplOEnfahJTa6JayBooI5KjWCap6XlF0AHSdEwh7WdH07xHYTMs9
   RWRfPagiAxgl9pHRh8k1WIwuBVogdsLByLCmmu613JEC0+e1T7LZrc8pu
   J95CLzpXH1R/g36X7EBgdZmMX7lYkZcWC6T0qBO+35sVUmTR7ATSZvgK1
   MxoOFQ+TkMYNnp6RvCXO1FSpQC/Z9LnwRh7rbWQAXCUfG2cWpArolfNQs
   w==;
X-CSE-ConnectionGUID: bW3lbH/QTpKTApcFr2HTbQ==
X-CSE-MsgGUID: pKuo/2foTE+IvcDqdS0wTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11111"; a="41495813"
X-IronPort-AV: E=Sophos;i="6.08,258,1712646000"; 
   d="scan'208";a="41495813"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2024 08:23:14 -0700
X-CSE-ConnectionGUID: +3omq9eXQair3IC0x4AoTg==
X-CSE-MsgGUID: w2ieawAzQOaGiuF/JBgQow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,258,1712646000"; 
   d="scan'208";a="42680522"
Received: from linux-pnp-server-16.sh.intel.com ([10.239.177.152])
  by fmviesa006.fm.intel.com with ESMTP; 22 Jun 2024 08:23:12 -0700
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
Subject: [PATCH v2 2/3] fs/file.c: conditionally clear full_fds
Date: Sat, 22 Jun 2024 11:49:03 -0400
Message-ID: <20240622154904.3774273-3-yu.ma@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240622154904.3774273-1-yu.ma@intel.com>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240622154904.3774273-1-yu.ma@intel.com>
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
Together with patch 1, they improves pts/blogbench-1.1.0 read for 27%, and write
for 14% on Intel ICX 160 cores configuration with v6.10-rc4.

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Yu Ma <yu.ma@intel.com>
---
 fs/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/file.c b/fs/file.c
index 50e900a47107..b4d25f6d4c19 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -268,7 +268,9 @@ static inline void __set_open_fd(unsigned int fd, struct fdtable *fdt)
 static inline void __clear_open_fd(unsigned int fd, struct fdtable *fdt)
 {
 	__clear_bit(fd, fdt->open_fds);
-	__clear_bit(fd / BITS_PER_LONG, fdt->full_fds_bits);
+	fd /= BITS_PER_LONG;
+	if (test_bit(fd, fdt->full_fds_bits))
+	    __clear_bit(fd, fdt->full_fds_bits);
 }
 
 static inline bool fd_is_open(unsigned int fd, const struct fdtable *fdt)
-- 
2.43.0


