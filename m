Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8F4372F72
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 May 2021 20:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbhEDSJO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 May 2021 14:09:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:14965 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232300AbhEDSJH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 May 2021 14:09:07 -0400
IronPort-SDR: sbR0/Xj5BlLDjpw+GxmWHfaX2WOnyfRF/O66V3A/ESP5/Ab/SCb0eviFbpbwqXzO6mvMHb8XJd
 GPEeIrEh32mw==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="283455832"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="283455832"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 11:08:12 -0700
IronPort-SDR: bHWqNaW2wHK/e5DUq3qTQ0GiaiF9DlvG2lxJV43GklWABiYXMAQgxVlyVRaw6zMcvz3a8A6SwG
 2vdzXd8WJ1Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="429171916"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 04 May 2021 11:08:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3FEF2B08; Tue,  4 May 2021 21:08:24 +0300 (EEST)
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
Subject: [PATCH v3 15/15] seq_file: Drop unused *_escape_mem_ascii()
Date:   Tue,  4 May 2021 21:08:19 +0300
Message-Id: <20210504180819.73127-16-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210504180819.73127-1-andriy.shevchenko@linux.intel.com>
References: <20210504180819.73127-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are no more users of the seq_escape_mem_ascii()
followed by string_escape_mem_ascii().

Remove them for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 fs/seq_file.c                  | 11 -----------
 include/linux/seq_file.h       |  1 -
 include/linux/string_helpers.h |  3 ---
 lib/string_helpers.c           | 19 -------------------
 4 files changed, 34 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 08f54029c2b1..b117b212ef28 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -396,17 +396,6 @@ void seq_escape(struct seq_file *m, const char *s, const char *esc)
 }
 EXPORT_SYMBOL(seq_escape);
 
-void seq_escape_mem_ascii(struct seq_file *m, const char *src, size_t isz)
-{
-	char *buf;
-	size_t size = seq_get_buf(m, &buf);
-	int ret;
-
-	ret = string_escape_mem_ascii(src, isz, buf, size);
-	seq_commit(m, ret < size ? ret : -1);
-}
-EXPORT_SYMBOL(seq_escape_mem_ascii);
-
 void seq_vprintf(struct seq_file *m, const char *f, va_list args)
 {
 	int len;
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index 63f021cb1b12..dd99569595fd 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -136,7 +136,6 @@ static inline void seq_escape_str(struct seq_file *m, const char *src,
 }
 
 void seq_escape(struct seq_file *m, const char *s, const char *esc);
-void seq_escape_mem_ascii(struct seq_file *m, const char *src, size_t isz);
 
 void seq_hex_dump(struct seq_file *m, const char *prefix_str, int prefix_type,
 		  int rowsize, int groupsize, const void *buf, size_t len,
diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index 9b0eca2badf2..68189c4a2eb1 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -63,9 +63,6 @@ static inline int string_unescape_any_inplace(char *buf)
 int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
 		unsigned int flags, const char *only);
 
-int string_escape_mem_ascii(const char *src, size_t isz, char *dst,
-					size_t osz);
-
 static inline int string_escape_mem_any_np(const char *src, size_t isz,
 		char *dst, size_t osz, const char *only)
 {
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index c15aea7a82e9..5a35c7e16e96 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -582,25 +582,6 @@ int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
 }
 EXPORT_SYMBOL(string_escape_mem);
 
-int string_escape_mem_ascii(const char *src, size_t isz, char *dst,
-					size_t osz)
-{
-	char *p = dst;
-	char *end = p + osz;
-
-	while (isz--) {
-		unsigned char c = *src++;
-
-		if (!isprint(c) || !isascii(c) || c == '"' || c == '\\')
-			escape_hex(c, &p, end);
-		else
-			escape_passthrough(c, &p, end);
-	}
-
-	return p - dst;
-}
-EXPORT_SYMBOL(string_escape_mem_ascii);
-
 /*
  * Return an allocated string that has been escaped of special characters
  * and double quotes, making it safe to log in quotes.
-- 
2.30.2

