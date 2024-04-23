Return-Path: <linux-fsdevel+bounces-17516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CE08AE952
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 16:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F801C22592
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 14:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4206013B5A4;
	Tue, 23 Apr 2024 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z2g2qmlH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27357139D1B;
	Tue, 23 Apr 2024 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713882132; cv=none; b=Kw/WjGVRXjxOcWKXw66pKQHgqbOSQ5N9XVgNS7oowTn3nyIl5gVn9fcv8SFNyOfMumVhgMGX9QL9CRHTqUXvLpFCn07BQbqZE4uXYwqh0a4OUP8I0OPN5h+CboN7vP//5fhbFOCIfSs44c+Sq9he7RelfrPdnMyHtQ7oSNcPIbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713882132; c=relaxed/simple;
	bh=h0MwcUHxXAEj+nVIJL59IQ1CJfo9yrZ784pC1Kz9e88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rnq7T4aDJTYkF5cFA66crRW+MQzgn+fXAfutIUWmC88IJpE7Zwk5ISsj6zhYdSjDdFseVFTFFNmsV6bIj9QeQPJGbMrQNwp+Sz9vAXUUkwxqBLY32Cfj1uYzZMZo/t26xNdf9CORjSRjG3QGdx51+WmJ49oKbtHSsXTV0hpsIVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z2g2qmlH; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713882131; x=1745418131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h0MwcUHxXAEj+nVIJL59IQ1CJfo9yrZ784pC1Kz9e88=;
  b=Z2g2qmlHc3+S+i3ZBqPdyBYk3RVrjegHrq75QLP02rtGgpIYR2VKmjZp
   j8um0NVvaOxHWrWsgfoB4dSOsOWmhSS2XX2zA3DvnVNliGJDeEiia8nRr
   YLkzbonJMVwlM+DvO9c0enBNnOlUjYAPDOzc185CScmHqzRCyVUz//3FF
   S8Yn1uVTyzNeAZii7quvbv3EEQbHc5qm+y2A8N3DKZ+iVtZC1AAh2LIgl
   8Qy3HeQ/hmVSxzOS75fN8UsmAY6cIdslN/IZRY/Di7YW2CsnDUuqAUZR3
   d7ToO9bJ1RWBptrNvLi5VMiPsPJ6JnsiZ2PpxMeryr188Uz4kb27N9uTQ
   Q==;
X-CSE-ConnectionGUID: sbpI+DAKQ7OyRtXmQ0TunQ==
X-CSE-MsgGUID: JwjogrdIQMSAv6Ebjx8NTw==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9389745"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9389745"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 07:22:10 -0700
X-CSE-ConnectionGUID: lBqee1Y3Q4O8o8QU62LYPg==
X-CSE-MsgGUID: wwcOT1aXQkKWOooRTgOoXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24896044"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 23 Apr 2024 07:22:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id AFA1E1C5; Tue, 23 Apr 2024 17:22:07 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 1/2] xarray: Use BITS_PER_LONGS()
Date: Tue, 23 Apr 2024 17:20:24 +0300
Message-ID: <20240423142204.2408923-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240423142204.2408923-1-andriy.shevchenko@linux.intel.com>
References: <20240423142204.2408923-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use BITS_PER_LONGS() instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/xarray.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index d9d479334c9e..d54a1e98b0ca 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1146,7 +1146,7 @@ static inline void xa_release(struct xarray *xa, unsigned long index)
 #define XA_CHUNK_SIZE		(1UL << XA_CHUNK_SHIFT)
 #define XA_CHUNK_MASK		(XA_CHUNK_SIZE - 1)
 #define XA_MAX_MARKS		3
-#define XA_MARK_LONGS		DIV_ROUND_UP(XA_CHUNK_SIZE, BITS_PER_LONG)
+#define XA_MARK_LONGS		BITS_TO_LONGS(XA_CHUNK_SIZE)
 
 /*
  * @count is the count of every non-NULL element in the ->slots array
-- 
2.43.0.rc1.1336.g36b5255a03ac


