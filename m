Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E0A3721F4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 22:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhECUt6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 16:49:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:37488 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229815AbhECUtx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 16:49:53 -0400
IronPort-SDR: hldRz3wsz+OYUpdrumzRpIqoQBQxTCr7W3RH/DAg4eDuUcKyXCpXz75y9UNW4eg67BxV16NEJy
 59YLKUrdCWNQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="178040332"
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="178040332"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 13:48:58 -0700
IronPort-SDR: 9dD2iDQUSDe9dfWihS+TFYLfKqWlae1ecjrka6lo5qqB/0B1YgqoeAo5mKMDCXXgfWrtwycdYq
 VAIpORCnsWnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="432922885"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 03 May 2021 13:48:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8B441934; Mon,  3 May 2021 23:49:11 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Shevchenko <andy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 11/12] lib/string_helpers: Drop unused *_escape_mem_ascii()
Date:   Mon,  3 May 2021 23:49:06 +0300
Message-Id: <20210503204907.34013-12-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210503204907.34013-1-andriy.shevchenko@linux.intel.com>
References: <20210503204907.34013-1-andriy.shevchenko@linux.intel.com>
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
index 5059248f2d64..f7956b299408 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -376,17 +376,6 @@ void seq_escape(struct seq_file *m, const char *s, const char *esc)
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
index 723b1fa1177e..adf62aa9c6c5 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -127,7 +127,6 @@ void seq_put_hex_ll(struct seq_file *m, const char *delimiter,
 		    unsigned long long v, unsigned int width);
 
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

