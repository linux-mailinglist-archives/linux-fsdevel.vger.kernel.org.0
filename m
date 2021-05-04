Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E66D3728EF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 May 2021 12:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhEDK2D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 May 2021 06:28:03 -0400
Received: from mga01.intel.com ([192.55.52.88]:52973 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230405AbhEDK16 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 May 2021 06:27:58 -0400
IronPort-SDR: bsURY5XRSkKoe2ngRgM7p9NDVAcFhkTt3t7fkVwyg9o/RuPNswO9JEA3BVCrQ9GhIYykRpnQC3
 T+EatPEGVjYA==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="218751816"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="218751816"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 03:27:03 -0700
IronPort-SDR: RYhX4NRHke3w/KIPa7RQ84PlUZjhSDeSOg+2MBIUiFnLM2y8Z+JrHROFTpFXcgBPJ9VmXSl0sy
 sNhSkTOLFmOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="463102606"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 04 May 2021 03:27:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D1F449FA; Tue,  4 May 2021 13:27:17 +0300 (EEST)
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
Subject: [PATCH v2 11/14] seq_file: Introduce seq_escape_mem()
Date:   Tue,  4 May 2021 13:26:45 +0300
Message-Id: <20210504102648.88057-12-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210504102648.88057-1-andriy.shevchenko@linux.intel.com>
References: <20210504102648.88057-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce seq_escape_mem() to allow users to pass additional parameters
to string_escape_mem().

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 fs/seq_file.c            | 25 +++++++++++++++++++++++++
 include/linux/seq_file.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 5059248f2d64..532cac2eae0f 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -355,6 +355,31 @@ int seq_release(struct inode *inode, struct file *file)
 }
 EXPORT_SYMBOL(seq_release);
 
+/**
+ * seq_escape_mem - print data into buffer, escaping some characters
+ * @m: target buffer
+ * @src: source buffer
+ * @len: size of source buffer
+ * @flags: flags to pass to string_escape_mem()
+ * @esc: set of characters that need escaping
+ *
+ * Puts data into buffer, replacing each occurrence of character from
+ * given class (defined by @flags and @esc) with printable escaped sequence.
+ *
+ * Use seq_has_overflowed() to check for errors.
+ */
+void seq_escape_mem(struct seq_file *m, const char *src, size_t len,
+		    unsigned int flags, const char *esc)
+{
+	char *buf;
+	size_t size = seq_get_buf(m, &buf);
+	int ret;
+
+	ret = string_escape_mem(src, len, buf, size, flags, esc);
+	seq_commit(m, ret < size ? ret : -1);
+}
+EXPORT_SYMBOL(seq_escape_mem);
+
 /**
  *	seq_escape -	print string into buffer, escaping some characters
  *	@m:	target buffer
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index 723b1fa1177e..6de442182784 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -126,6 +126,8 @@ void seq_put_decimal_ll(struct seq_file *m, const char *delimiter, long long num
 void seq_put_hex_ll(struct seq_file *m, const char *delimiter,
 		    unsigned long long v, unsigned int width);
 
+void seq_escape_mem(struct seq_file *m, const char *src, size_t len,
+		    unsigned int flags, const char *esc);
 void seq_escape(struct seq_file *m, const char *s, const char *esc);
 void seq_escape_mem_ascii(struct seq_file *m, const char *src, size_t isz);
 
-- 
2.30.2

