Return-Path: <linux-fsdevel+bounces-50236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA06AC94C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 19:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 292DBA25276
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 17:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572DD21ADD3;
	Fri, 30 May 2025 17:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mFm1tSwh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDE22111;
	Fri, 30 May 2025 17:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748626332; cv=none; b=ONPaXzbbUgUxSSFEiix4zo82HI5BSIEjn+A0Er8u226ifV29ujhkKrrbaqTxyxK+PAupiBI88B0tE0vtIAq8wRZX77rM6yN6+4/GALE5kCVMkNfdVsYjcLBUHKnTBzDc8mj1uoTmiImZlR4jy6lNMJBxQCuQe2e7MdKk+8LAqJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748626332; c=relaxed/simple;
	bh=+dzq1tWFhWN/5Dpr/bbLGrMKUUlWqcB6yMLs2SeAdrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TEv4M81sg/Y3NAxmlciFx9Spq7G448a4aUxYl5oTEvA43HVr9mCuVryK8r26nGsZYZtyofYLkAL1C+DCXzTKjJI+4PB+BCuoOJr2pOMoLutLCcDCAj+tRQ4k+nVk6NPWBCwwJgzlBUlJm+3Uwk5sfZn2AHODulWKbEhEP7Ghxxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mFm1tSwh; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748626331; x=1780162331;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+dzq1tWFhWN/5Dpr/bbLGrMKUUlWqcB6yMLs2SeAdrM=;
  b=mFm1tSwhBQIT1pEx4u1VnBnMO38VBSHTzs6MzuEbM0K+tT6eTnF/CtTf
   slxyumD0TkYj/gaoTXYqKS/Ulb2QNgiK67MqyMAr0beqKTz/t3GCPRS5R
   E8ygZeLjKvgzJ0aW2DilriRfm3cSj13BBYIp7Ajtl2m4JijKYgcboLCvE
   lcDUpLCWTMNZ/VXJAKbI0aXdlf1+quYQg0C5oncTxIQ8nnx/Hq5oRuWpv
   zw3MhUx8BcmTN9WyJz+QQOM4Q2MHIKXJs86xyTU9r+UuplGIu4SCaRN5K
   SgjEg7jmzeOJirV/mK1mL+MY5kaxRjBJ4BKhkxDwgAF0c6JCs2gTsDEBV
   g==;
X-CSE-ConnectionGUID: vRReEu+1SZeV/eXJ7Hd7CA==
X-CSE-MsgGUID: zuWUIS9gTrKeg5MLRpwAFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="61351589"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="61351589"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 10:32:09 -0700
X-CSE-ConnectionGUID: l8nE+4L3R/SQCtSFJypn+Q==
X-CSE-MsgGUID: ACXnB3JIRbuh74IEa18qVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="144271264"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 30 May 2025 10:32:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9112114B; Fri, 30 May 2025 20:32:06 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] fs/read_write: Fix spelling typo
Date: Fri, 30 May 2025 20:32:04 +0300
Message-ID: <20250530173204.3611576-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'implemenation' --> 'implementation'.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 fs/read_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 0ef70e128c4a..81a9474dc396 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -237,7 +237,7 @@ EXPORT_SYMBOL(generic_llseek_cookie);
  * @offset:	file offset to seek to
  * @whence:	type of seek
  *
- * This is a generic implemenation of ->llseek useable for all normal local
+ * This is a generic implementation of ->llseek useable for all normal local
  * filesystems.  It just updates the file offset to the value specified by
  * @offset and @whence.
  */
-- 
2.47.2


