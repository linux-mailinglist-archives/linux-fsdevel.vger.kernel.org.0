Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6325C3728FB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 May 2021 12:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhEDK2K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 May 2021 06:28:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:52975 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230417AbhEDK17 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 May 2021 06:27:59 -0400
IronPort-SDR: 8aOh2HHEkGcRm1N6ETlfyv6ydCDVU784a9zh9qY3YhA+PYO41lPcmzf6dr5iAQ8ZIRAap3p7AK
 SrHU6AdKzvOg==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="218751818"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="218751818"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 03:27:03 -0700
IronPort-SDR: FxqCF/4lZfeo80U71BKBGIfPaVN0A3WEB40KDO3oScvIw3/utreFwOc82YqZrR5+TcXC2JL1vf
 DRqllTo4PGxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="463102607"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 04 May 2021 03:27:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0258DB4C; Tue,  4 May 2021 13:27:17 +0300 (EEST)
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
Subject: [PATCH v2 14/14] seq_file: Drop unused *_escape_mem_ascii()
Date:   Tue,  4 May 2021 13:26:48 +0300
Message-Id: <20210504102648.88057-15-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210504102648.88057-1-andriy.shevchenko@linux.intel.com>
References: <20210504102648.88057-1-andriy.shevchenko@linux.intel.com>
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
 include/linux/seq_file.h       |  2 --
 include/linux/string_helpers.h |  3 ---
 lib/string_helpers.c           | 19 -------------------
 4 files changed, 35 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index d78801403a2f..f8335e5a0ce5 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -380,17 +380,6 @@ void seq_escape_mem(struct seq_file *m, const char *src, size_t len,
 }
 EXPORT_SYMBOL(seq_escape_mem);
 
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
index 0b3a6096bed3..c79fffe0f1e1 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -146,8 +146,6 @@ static inline void seq_escape(struct seq_file *m, const char *s, const char *esc
 	seq_escape_mem(m, s, strlen(s), ESCAPE_OCTAL, esc);
 }
 
-void seq_escape_mem_ascii(struct seq_file *m, const char *src, size_t isz);
-
 void seq_hex_dump(struct seq_file *m, const char *prefix_str, int prefix_type,
 		  int rowsize, int groupsize, const void *buf, size_t len,
 		  bool ascii);
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

