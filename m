Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB6841ED72
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Oct 2021 14:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353233AbhJAMcJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 08:32:09 -0400
Received: from mga14.intel.com ([192.55.52.115]:48000 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230162AbhJAMcH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 08:32:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="225077387"
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="225077387"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 05:30:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="540144496"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 01 Oct 2021 05:30:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 99404B8; Fri,  1 Oct 2021 15:30:18 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, jic23@kernel.org
Subject: [PATCH v1 1/1] seq_file: Move seq_escape() to a header
Date:   Fri,  1 Oct 2021 15:29:17 +0300
Message-Id: <20211001122917.67228-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move seq_escape() to the header as inliner.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 fs/seq_file.c            | 16 ----------------
 include/linux/seq_file.h | 17 ++++++++++++++++-
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 4a2cda04d3e2..f8e1f4ee87ff 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -383,22 +383,6 @@ void seq_escape_mem(struct seq_file *m, const char *src, size_t len,
 }
 EXPORT_SYMBOL(seq_escape_mem);
 
-/**
- *	seq_escape -	print string into buffer, escaping some characters
- *	@m:	target buffer
- *	@s:	string
- *	@esc:	set of characters that need escaping
- *
- *	Puts string into buffer, replacing each occurrence of character from
- *	@esc with usual octal escape.
- *	Use seq_has_overflowed() to check for errors.
- */
-void seq_escape(struct seq_file *m, const char *s, const char *esc)
-{
-	seq_escape_str(m, s, ESCAPE_OCTAL, esc);
-}
-EXPORT_SYMBOL(seq_escape);
-
 void seq_vprintf(struct seq_file *m, const char *f, va_list args)
 {
 	int len;
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index dd99569595fd..103776e18555 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/string.h>
+#include <linux/string_helpers.h>
 #include <linux/bug.h>
 #include <linux/mutex.h>
 #include <linux/cpumask.h>
@@ -135,7 +136,21 @@ static inline void seq_escape_str(struct seq_file *m, const char *src,
 	seq_escape_mem(m, src, strlen(src), flags, esc);
 }
 
-void seq_escape(struct seq_file *m, const char *s, const char *esc);
+/**
+ * seq_escape - print string into buffer, escaping some characters
+ * @m: target buffer
+ * @s: NULL-terminated string
+ * @esc: set of characters that need escaping
+ *
+ * Puts string into buffer, replacing each occurrence of character from
+ * @esc with usual octal escape.
+ *
+ * Use seq_has_overflowed() to check for errors.
+ */
+static inline void seq_escape(struct seq_file *m, const char *s, const char *esc)
+{
+	seq_escape_str(m, s, ESCAPE_OCTAL, esc);
+}
 
 void seq_hex_dump(struct seq_file *m, const char *prefix_str, int prefix_type,
 		  int rowsize, int groupsize, const void *buf, size_t len,
-- 
2.33.0

