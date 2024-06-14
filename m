Return-Path: <linux-fsdevel+bounces-21717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFF0908FB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 18:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638871C20E93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 16:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C2116E888;
	Fri, 14 Jun 2024 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Il5nuDff"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EC819AD6E;
	Fri, 14 Jun 2024 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718381339; cv=none; b=lEp3rb6cOKV8KrkFCaWj/OhBn4XDJ8xdRnQXsoJLyS+tQBVM3RQREW+J+nHpxH/o4SQRg87+qE8yxf6KkXNwdTebU2LaCjSDuJeuiKwaldSjogcm8hpyELBDPi+cgQQXyqD5/hWj1V8c9s3IJVJWjK1tj5zzHNywQroEXIZVt90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718381339; c=relaxed/simple;
	bh=XaUtWTN7akwimeRKOM+4b5jvaenMH+iXA0eNBgjkAJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TH7WvgUpMaFD2zowYVNGknQGageRt2i75rvjdj0UUpcV9XvLHZkj+ZeCmLuYx50O1vGeVbDZzP1B+nQ/Cjhar7peJC2D9C6LR8vPDKOafSI1mxOc3sOhsNXy442zCczrN3uznf9SQvDBLpotJUKRyvwMaCz69ej6lFS0wn2zMSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Il5nuDff; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718381338; x=1749917338;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XaUtWTN7akwimeRKOM+4b5jvaenMH+iXA0eNBgjkAJY=;
  b=Il5nuDffywf1zmXUqc97i3BH98Sz2p21XhFEgtWWtifNVtiVTHU0sVJf
   tAg4FhK76rOsgKpecTB8qC+0DbMmWWPDMzUkZrVh5bZQ0zaSUojxRdWJ4
   GZoMuj+nzNG39GYrNT3YdidoxoCmQv/nfLEC3sBJgkWwyPN0VyPB9AvMw
   6DByBWWfkt2rS1dbyDjI8iU5zK09/BtGkvQ3qa4DDim8j7mA+WJnYMKbf
   ZTq89O/wVVqbeBholrdtib2JtOLFfzR+XT/DoKeSaNMY1l5v609fHUQhm
   omtItsIV8/hlE/4pH8pAI78BdG6B2M34jw5hJUFQoQ3crwdHBkyNGDmp0
   A==;
X-CSE-ConnectionGUID: znlBW63ET6qbgtpN1RE4mQ==
X-CSE-MsgGUID: 06Lb98oZSOeM4xpccqAzlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="15399411"
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="15399411"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 09:08:57 -0700
X-CSE-ConnectionGUID: P7B4ZEOATw64b2ByqlQHlw==
X-CSE-MsgGUID: VuUBpHm/SE2pOap1LEEH3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="71741079"
Received: from linux-pnp-server-16.sh.intel.com ([10.239.177.152])
  by fmviesa001.fm.intel.com with ESMTP; 14 Jun 2024 09:08:55 -0700
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
Subject: [PATCH 2/3] fs/file.c: conditionally clear full_fds
Date: Fri, 14 Jun 2024 12:34:15 -0400
Message-ID: <20240614163416.728752-3-yu.ma@intel.com>
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

64 bits in open_fds are mapped to a common bit in full_fds_bits. It is very
likely that a bit in full_fds_bits has been cleared before in
__clear_open_fds()'s operation. Check the clear bit in full_fds_bits before
clearing to avoid unnecessary write and cache bouncing. See commit fc90888d07b8
("vfs: conditionally clear close-on-exec flag") for a similar optimization.
Together with patch 1, they improves pts/blogbench-1.1.0 read for 28%, and write
for 14% on Intel ICX 160 cores configuration with v6.8-rc6.

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Yu Ma <yu.ma@intel.com>
---
 fs/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/file.c b/fs/file.c
index e8d2f9ef7fd1..a0e94a178c0b 100644
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
 
 static unsigned int count_open_files(struct fdtable *fdt)
-- 
2.43.0


