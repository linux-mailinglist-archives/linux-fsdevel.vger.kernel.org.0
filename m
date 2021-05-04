Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A46D3728F8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 May 2021 12:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhEDK2H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 May 2021 06:28:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:14053 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230410AbhEDK17 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 May 2021 06:27:59 -0400
IronPort-SDR: gGjV75/uYplp6PFQl7YWh6Q51VZPouPlKza0smrOucavtt4EoBoLoE0uv0x5P3QBdtMjuwezVT
 k6sknERUwjlw==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="185417082"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="185417082"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 03:27:03 -0700
IronPort-SDR: eXcqOwNNpn1fI7Y0s4Mi/uGEa85XGjkziJb+faAlqt0Dfo+pxkHEDZ96fExfkAS/H5I2HvDLUw
 1iFTMuqRSlLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="618429779"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 04 May 2021 03:27:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DF9E5AFA; Tue,  4 May 2021 13:27:17 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Shevchenko <andy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 12/14] seq_file: Replace seq_escape() with inliner
Date:   Tue,  4 May 2021 13:26:46 +0300
Message-Id: <20210504102648.88057-13-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210504102648.88057-1-andriy.shevchenko@linux.intel.com>
References: <20210504102648.88057-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert seq_escape() to use seq_escape_mem() rather than using
a separate symbol. At the same time move it to header as inliner.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 fs/seq_file.c            | 21 ---------------------
 include/linux/seq_file.h | 19 ++++++++++++++++++-
 2 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 532cac2eae0f..d78801403a2f 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -380,27 +380,6 @@ void seq_escape_mem(struct seq_file *m, const char *src, size_t len,
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
-	char *buf;
-	size_t size = seq_get_buf(m, &buf);
-	int ret;
-
-	ret = string_escape_str(s, buf, size, ESCAPE_OCTAL, esc);
-	seq_commit(m, ret < size ? ret : -1);
-}
-EXPORT_SYMBOL(seq_escape);
-
 void seq_escape_mem_ascii(struct seq_file *m, const char *src, size_t isz)
 {
 	char *buf;
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index 6de442182784..0b3a6096bed3 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/string.h>
+#include <linux/string_helpers.h>
 #include <linux/bug.h>
 #include <linux/mutex.h>
 #include <linux/cpumask.h>
@@ -128,7 +129,23 @@ void seq_put_hex_ll(struct seq_file *m, const char *delimiter,
 
 void seq_escape_mem(struct seq_file *m, const char *src, size_t len,
 		    unsigned int flags, const char *esc);
-void seq_escape(struct seq_file *m, const char *s, const char *esc);
+
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
+	seq_escape_mem(m, s, strlen(s), ESCAPE_OCTAL, esc);
+}
+
 void seq_escape_mem_ascii(struct seq_file *m, const char *src, size_t isz);
 
 void seq_hex_dump(struct seq_file *m, const char *prefix_str, int prefix_type,
-- 
2.30.2

