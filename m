Return-Path: <linux-fsdevel+bounces-19346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F09758C371C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 17:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6ED31F216B2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 15:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DA045BFF;
	Sun, 12 May 2024 15:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jEISbIdG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD3440BE3
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 May 2024 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715528191; cv=none; b=ZL2h16LAPG2rahu/aQ2Epyf3bYR1eAWTno2kDZkDf0NPhbtAP8MCoYTVTcsBbk4DI2WAv5/hQijoDQwt050MIBTfwQFxSWnDCgdvTvDigxzh60hqBIyOz7Gpq1ZZi+ivcwNre1AbfETPNyd/t3SBESrTQGQSaFVFB8Z8JVVA8TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715528191; c=relaxed/simple;
	bh=m7b0H2nPMXlW9qzhs8xhiDDvV+7cSUjEnIZn7N+Tdcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HC7N5oHtNKcREnD7R7D3iePOQ0fPBqNptzIxehcETU+VECWHNmS/7FMpa1vW4LfRqBWlxN5BCelGyJ2degGaVJlTbzNmuu6/qaZywcToc/5rBM2oZL9R9Q2kKOYtHm3srhTM2gBv1ztshSa7g6RxrCBdU/r33lK96Xef+Dl7+sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jEISbIdG; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715528190; x=1747064190;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m7b0H2nPMXlW9qzhs8xhiDDvV+7cSUjEnIZn7N+Tdcw=;
  b=jEISbIdGRdVJRRrQwbotD5EgI84JmwBjCe6ZiAYJXcAFnDjjQZjO4Uhx
   7LvlOyQZUMNWCxxyF1Aq+AbYPHnrlATuYmlefuzXqS5qPrpWEEUXZjg3y
   E6lVcuTBWVG+R8+oWlnGw9iIZoVtOkNxIQwVYKUeVlRdGZboGXrZaw1SZ
   KlNpyRPliZTLKE75DcvHetSVgdZIPbt+x48OvUjk2QzaMEaFE3nkNR86x
   tduaSXYbOeUmOlOgT0lttSj66T6cPCYziphgnGcqiPqDMEVJhtZk/Fp96
   /iwAnDHt8gWIyHmQ6VfCmtv+Kw8mZQKTBHl4xOzqMJgmWj7K4KcHYtgNe
   w==;
X-CSE-ConnectionGUID: QkpWNX7ZRaC/L34WdaqIVQ==
X-CSE-MsgGUID: 2/5mT4b1RnmetTIL+sryWA==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11403302"
X-IronPort-AV: E=Sophos;i="6.08,156,1712646000"; 
   d="scan'208";a="11403302"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 08:36:29 -0700
X-CSE-ConnectionGUID: nHVtF9cFQjKA8GWpnQJQgg==
X-CSE-MsgGUID: HAVA9ftCSMCmQGlQ+KLyxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,156,1712646000"; 
   d="scan'208";a="34976565"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.246.25.139])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 08:36:27 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	linux-fsdevel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 1/4] libfs: add simple_read_from_iomem()
Date: Sun, 12 May 2024 17:36:03 +0200
Message-Id: <20240512153606.1996-2-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240512153606.1996-1-michal.wajdeczko@intel.com>
References: <20240512153606.1996-1-michal.wajdeczko@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's similar to simple_read_from_buffer() but instead allows to
copy data from the I/O memory in PAGE_SIZE chunks.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
---
Cc: linux-fsdevel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
---
 fs/libfs.c         | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  3 +++
 2 files changed, 53 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 3a6f2cb364f8..be8aa42a2f11 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -15,6 +15,7 @@
 #include <linux/mutex.h>
 #include <linux/namei.h>
 #include <linux/exportfs.h>
+#include <linux/io.h>
 #include <linux/iversion.h>
 #include <linux/writeback.h>
 #include <linux/buffer_head.h> /* sync_mapping_buffers */
@@ -1040,6 +1041,55 @@ void simple_release_fs(struct vfsmount **mount, int *count)
 }
 EXPORT_SYMBOL(simple_release_fs);
 
+/**
+ * simple_read_from_iomem - copy data from the I/O memory to user space
+ * @to: the user space buffer to read to
+ * @count: the maximum number of bytes to read
+ * @ppos: the current position in the buffer
+ * @from: the I/O memory to read from
+ * @available: the size of the iomem memory
+ *
+ * The simple_read_from_iomem() function reads up to @count bytes (but no
+ * more than %PAGE_SIZE bytes) from the I/O memory @from at offset @ppos
+ * into the user space address starting at @to.
+ *
+ * Return: On success, the number of bytes read is returned and the offset
+ * @ppos is advanced by this number, or negative value is returned on error.
+ */
+ssize_t simple_read_from_iomem(void __user *to, size_t count, loff_t *ppos,
+			       const volatile void __iomem *from, size_t available)
+{
+	loff_t pos = *ppos;
+	size_t ret;
+	void *buf;
+
+	if (pos < 0)
+		return -EINVAL;
+	if (pos >= available || !count)
+		return 0;
+	if (count > available - pos)
+		count = available - pos;
+	if (count > PAGE_SIZE)
+		count = PAGE_SIZE;
+
+	buf = kmalloc(count, GFP_NOWAIT | __GFP_NOWARN);
+	if (!buf)
+		return -ENOMEM;
+
+	memcpy_fromio(buf, from + pos, count);
+	ret = copy_to_user(to, buf, count);
+
+	kfree(buf);
+
+	if (ret == count)
+		return -EFAULT;
+
+	count -= ret;
+	*ppos = pos + count;
+	return count;
+}
+EXPORT_SYMBOL(simple_read_from_iomem);
+
 /**
  * simple_read_from_buffer - copy data from the buffer to user space
  * @to: the user space buffer to read to
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8dfd53b52744..eb4a7b10a1a0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3331,6 +3331,9 @@ extern ssize_t simple_read_from_buffer(void __user *to, size_t count,
 extern ssize_t simple_write_to_buffer(void *to, size_t available, loff_t *ppos,
 		const void __user *from, size_t count);
 
+ssize_t simple_read_from_iomem(void __user *to, size_t count, loff_t *ppos,
+			       const volatile void __iomem *from, size_t available);
+
 struct offset_ctx {
 	struct maple_tree	mt;
 	unsigned long		next_offset;
-- 
2.43.0


