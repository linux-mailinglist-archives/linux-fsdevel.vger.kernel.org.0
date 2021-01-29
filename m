Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73B23084B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jan 2021 05:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhA2Exo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 23:53:44 -0500
Received: from mail.synology.com ([211.23.38.101]:44588 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232007AbhA2Exd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 23:53:33 -0500
Received: from localhost.localdomain (unknown [10.17.36.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id 3ADA6CE781CF;
        Fri, 29 Jan 2021 12:52:51 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1611895971; bh=Zin92eGm3uQ3NA2MvXwbiph99acq62tN+NV0r8KQUNg=;
        h=From:To:Cc:Subject:Date;
        b=W7tkzYH0p+RtQcDOs1TU9AcWxYKAgXWenV4G+QdRvCfCDJxpd16vWdmMZVuFFB6/D
         rh86LUlypGcpYLeqgwaW2Mw3G9Lw4cd/zZ+trjDpA+j84rtrwZ0hteb7NM9I7OMaP8
         OKetVteEeKmotnz7/3lKXl22tmaM4/SR5aWFFtCc=
From:   bingjingc <bingjingc@synology.com>
To:     viro@zeniv.linux.org.uk, jack@suse.com, jack@suse.cz,
        axboe@kernel.dk, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, cccheng@synology.com,
        bingjingc@synology.com, robbieko@synology.com, willy@infradead.org,
        rdunlap@infradead.org, miklos@szeredi.hu
Subject: [PATCH v3 1/3] parser: add unsigned int parser
Date:   Fri, 29 Jan 2021 12:52:42 +0800
Message-Id: <20210129045242.10268-1-bingjingc@synology.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: BingJing Chang <bingjingc@synology.com>

Will be used by fs parsing options

Reviewed-by: Robbie Ko<robbieko@synology.com>
Reviewed-by: Chung-Chiang Cheng <cccheng@synology.com>
Signed-off-by: BingJing Chang <bingjingc@synology.com>
---
 include/linux/parser.h |  1 +
 lib/parser.c           | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/parser.h b/include/linux/parser.h
index 89e2b23..dd79f45 100644
--- a/include/linux/parser.h
+++ b/include/linux/parser.h
@@ -29,6 +29,7 @@ typedef struct {
 
 int match_token(char *, const match_table_t table, substring_t args[]);
 int match_int(substring_t *, int *result);
+int match_uint(substring_t *s, unsigned int *result);
 int match_u64(substring_t *, u64 *result);
 int match_octal(substring_t *, int *result);
 int match_hex(substring_t *, int *result);
diff --git a/lib/parser.c b/lib/parser.c
index f5b3e5d..7785e41 100644
--- a/lib/parser.c
+++ b/lib/parser.c
@@ -188,6 +188,28 @@ int match_int(substring_t *s, int *result)
 }
 EXPORT_SYMBOL(match_int);
 
+/*
+ * match_uint - scan a decimal representation of an integer from a substring_t
+ * @s: substring_t to be scanned
+ * @result: resulting integer on success
+ *
+ * Description: Attempts to parse the &substring_t @s as a decimal integer. On
+ * success, sets @result to the integer represented by the string and returns 0.
+ * Returns -ENOMEM, -EINVAL, or -ERANGE on failure.
+ */
+int match_uint(substring_t *s, unsigned int *result)
+{
+	int err = -ENOMEM;
+	char *buf = match_strdup(s);
+
+	if (buf) {
+		err = kstrtouint(buf, 10, result);
+		kfree(buf);
+	}
+	return err;
+}
+EXPORT_SYMBOL(match_uint);
+
 /**
  * match_u64: - scan a decimal representation of a u64 from
  *                  a substring_t
-- 
2.7.4

