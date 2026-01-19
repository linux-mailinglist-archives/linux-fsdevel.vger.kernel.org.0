Return-Path: <linux-fsdevel+bounces-74531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A91D3B8BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 21:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2B57304C2AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 20:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869D12F6931;
	Mon, 19 Jan 2026 20:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bTNqI2DA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910E4296BAF;
	Mon, 19 Jan 2026 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768855320; cv=none; b=pSbK3cCun7W1i3iNpiXFzJDL2skQaIkXYvx1qUfA8Sp3h42GA1+Y4U1riyaMezV7iNDyR9lT/Lk2UJAx4UO2Ll65orFy7DaAB+yPs9sA8ucEpEEJ7Hu9zfyuJeZojqA/EUczz4sZjErQqPQJjMSRJxjP67qASEtlG6mY6oLHm4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768855320; c=relaxed/simple;
	bh=5Q6XCjEsARYIYUYKlBepTkKJq5PGeWKS2tjnPAaYDOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fBqi/NTzSuSyKLoZRrCa2ypwnEmPVu+8nsdoe82I4Oe1WY+hPgSWOqq2EhGQmxC7DpHkRNwlk9TcLZH8t4CryPrIHsXR0SoaSyWp/DGqaI0g2eQtdodPVxLSFM1JcObRlORiGPja4V875VLCLT9QFzUTyCxtQiJVEW2t9ZBOi+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bTNqI2DA; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768855319; x=1800391319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5Q6XCjEsARYIYUYKlBepTkKJq5PGeWKS2tjnPAaYDOo=;
  b=bTNqI2DAvoLKLDzlWKDzmk5YlsxoEVSylcTbpbiX027CmBw/bTxfvLWs
   PbW+uWRkIXXjI88KEeen1vnIOlLQbwxpjPVra5YdVbHgflvdrDMFzHTwB
   DxrS7fA2qNNP3nAWSK0jWCQ9vEDWzzs0PzoAHuwcbHq2mDsuv8WHawQ/3
   cmBhW5MqwizJdYzqhEVqLx3MDOMO6ysqFdWQ87gKngBp6j7UqNl0SpH5Y
   9JFRlVM5kQKX8eAUxFtzaeqYuzoBrZ2MoFFtQ8jYtl3nqBD5bWuX5h3nv
   +8vRpr/1sm88//eOiLV/wAVukODCBUGjYQESlnWIsPeLnVYMD36uHEU8S
   w==;
X-CSE-ConnectionGUID: 1Wbd7JuaSceXLZp1x2d4Qg==
X-CSE-MsgGUID: Ryu2CYzPTQSzh4SdX8Bi6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="73695304"
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="73695304"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 12:41:58 -0800
X-CSE-ConnectionGUID: CNxJ7ThpSvWV//vb1F/JQQ==
X-CSE-MsgGUID: Hu0VLnLBRp2QdDBaHrQzRw==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 19 Jan 2026 12:41:55 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 30A699B; Mon, 19 Jan 2026 21:41:54 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christian Brauner <brauner@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v1 2/4] initramfs: Refactor to use hex2bin() instead of custom approach
Date: Mon, 19 Jan 2026 21:38:39 +0100
Message-ID: <20260119204151.1447503-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260119204151.1447503-1-andriy.shevchenko@linux.intel.com>
References: <20260119204151.1447503-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a simple_strntoul() function used solely as a shortcut
for hex2bin() with proper endianess conversions. Replace that
and drop the unneeded function in the next changes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 init/initramfs.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 750f126e19a0..8d931ad4d239 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -6,6 +6,7 @@
 #include <linux/fcntl.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/hex.h>
 #include <linux/init.h>
 #include <linux/init_syscalls.h>
 #include <linux/kstrtox.h>
@@ -21,6 +22,8 @@
 #include <linux/umh.h>
 #include <linux/utime.h>
 
+#include <asm/byteorder.h>
+
 #include "do_mounts.h"
 #include "initramfs_internal.h"
 
@@ -192,24 +195,25 @@ static __initdata u32 hdr_csum;
 
 static void __init parse_header(char *s)
 {
-	unsigned long parsed[13];
-	int i;
+	__be32 header[13];
+	int ret;
 
-	for (i = 0, s += 6; i < 13; i++, s += 8)
-		parsed[i] = simple_strntoul(s, NULL, 16, 8);
+	ret = hex2bin((u8 *)header, s + 6, sizeof(header));
+	if (ret)
+		error("damaged header");
 
-	ino = parsed[0];
-	mode = parsed[1];
-	uid = parsed[2];
-	gid = parsed[3];
-	nlink = parsed[4];
-	mtime = parsed[5]; /* breaks in y2106 */
-	body_len = parsed[6];
-	major = parsed[7];
-	minor = parsed[8];
-	rdev = new_encode_dev(MKDEV(parsed[9], parsed[10]));
-	name_len = parsed[11];
-	hdr_csum = parsed[12];
+	ino = be32_to_cpu(header[0]);
+	mode = be32_to_cpu(header[1]);
+	uid = be32_to_cpu(header[2]);
+	gid = be32_to_cpu(header[3]);
+	nlink = be32_to_cpu(header[4]);
+	mtime = be32_to_cpu(header[5]); /* breaks in y2106 */
+	body_len = be32_to_cpu(header[6]);
+	major = be32_to_cpu(header[7]);
+	minor = be32_to_cpu(header[8]);
+	rdev = new_encode_dev(MKDEV(be32_to_cpu(header[9]), be32_to_cpu(header[10])));
+	name_len = be32_to_cpu(header[11]);
+	hdr_csum = be32_to_cpu(header[12]);
 }
 
 /* FSM */
-- 
2.50.1


