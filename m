Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78A9363963
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 04:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbhDSC3j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Apr 2021 22:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbhDSC3i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Apr 2021 22:29:38 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6445C06174A;
        Sun, 18 Apr 2021 19:29:06 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id u15so8351380plf.10;
        Sun, 18 Apr 2021 19:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bZBVykDy+CbPTq5GPknPQk24ko2Dt8qX06614cxzmoI=;
        b=pmOjuCDaegOlVXpSgl1lzwSoy//PLBynAvQROra5Oj+O22sUO/1R5ycoyKKiF0V3C9
         3cG7pYApIKJpVSz66o01Dn1nKPSDprDCEp1rjmpistU0lbm7sSEExqWEnHXAXvDr5GQB
         vpPNBJzOPtBcZM/ga3gOacb4x4P2q0KEDP2Cl0kUPzBLMowa1ezLGXx9ZQGFZeAWbJb5
         T47V266bPzWsj8bXT91/13X/9XnzhLUosgMO9pwKbyNvRiEFZdwQYKkB2M2BeGoOHLER
         IbdI2SOE0/MFcN2o5kzd/gkBdNTrATab1XEXYF1JxC1cOk7rkH4ofTKM7RJlCNEui6Tu
         +v/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bZBVykDy+CbPTq5GPknPQk24ko2Dt8qX06614cxzmoI=;
        b=ge8tnq5sUSfPY/ZZKDO8HYEogHwIT9+mpmDJoOUuVI0TDukqIrbMQzxiDZls2FuUqq
         Aekp0L+JaPQPKDrHeEFgb1MoQnu7zK2c8kIe/pEpj1/56GWvB0PmHqHdr8in517X0CeT
         RciL3bl6I+c8hMpsB/izRaYgn6KlhQoksC0+yp7T5q1rEtzqqxZrEYDCTcZ32ddTwoSS
         qiWUD30tfrEzO5VCFMu7SemnKDbaoaVcdmhkqtw7eFNZN7KjUUt1z2SUedjoJXxzYtgm
         0NAojdHE7VP5sNCA42yUKnLQ6o8RBR7yPMBPLNEGzKiCdHNUZ6/0rcZ+JWlPmMcahARz
         LK0Q==
X-Gm-Message-State: AOAM530CvkGXFfXEHwp35nUQ0nkrFWFPy4VYmCv77EFGSfkiThFaCzwz
        +94XrUjM89nnq83JBOtsSNA=
X-Google-Smtp-Source: ABdhPJxlsKaMBLmPaeHgo0HcfC9O6q6+X+K7YIJbHuEuoB4Sq7ROCH555R+TPqR2Yu736JeDVAtZnw==
X-Received: by 2002:a17:90a:a389:: with SMTP id x9mr21888444pjp.232.1618799346177;
        Sun, 18 Apr 2021 19:29:06 -0700 (PDT)
Received: from localhost.localdomain (220-130-175-235.HINET-IP.hinet.net. [220.130.175.235])
        by smtp.gmail.com with ESMTPSA id lt11sm12577277pjb.23.2021.04.18.19.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 19:29:05 -0700 (PDT)
From:   Chung-Chiang Cheng <shepjeng@gmail.com>
X-Google-Original-From: Chung-Chiang Cheng <cccheng@synology.com>
To:     gustavoars@kernel.org, christian.brauner@ubuntu.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     cccheng@synology.com
Subject: [PATCH v2] hfsplus: prevent negative dentries when casefolded
Date:   Mon, 19 Apr 2021 10:29:01 +0800
Message-Id: <20210419022901.193750-1-cccheng@synology.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

hfsplus uses the case-insensitive filenames by default, but VFS negative
dentries are incompatible with case-insensitive. For example, the
following instructions will get a cached filename 'aaa' which isn't
expected. There is no such problem in macOS.

  touch aaa
  rm aaa
  touch AAA

This patch takes the same approach to drop negative dentires as vfat does.
The dentry is revalidated without blocking and storing to the dentry,
and should be safe in rcu-walk.

Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
---
 fs/hfsplus/hfsplus_fs.h |  1 +
 fs/hfsplus/inode.c      |  1 +
 fs/hfsplus/unicode.c    | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 12b20479ed2b..e4f0cdfdac96 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -528,6 +528,7 @@ int hfsplus_asc2uni(struct super_block *sb, struct hfsplus_unistr *ustr,
 int hfsplus_hash_dentry(const struct dentry *dentry, struct qstr *str);
 int hfsplus_compare_dentry(const struct dentry *dentry, unsigned int len,
 			   const char *str, const struct qstr *name);
+int hfsplus_revalidate_dentry(struct dentry *dentry, unsigned int flags);
 
 /* wrapper.c */
 int hfsplus_submit_bio(struct super_block *sb, sector_t sector, void *buf,
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 078c5c8a5156..772cad371371 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -176,6 +176,7 @@ const struct address_space_operations hfsplus_aops = {
 const struct dentry_operations hfsplus_dentry_operations = {
 	.d_hash       = hfsplus_hash_dentry,
 	.d_compare    = hfsplus_compare_dentry,
+	.d_revalidate = hfsplus_revalidate_dentry,
 };
 
 static void hfsplus_get_perms(struct inode *inode,
diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
index 73342c925a4b..e336631334eb 100644
--- a/fs/hfsplus/unicode.c
+++ b/fs/hfsplus/unicode.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/namei.h>
 #include <linux/nls.h>
 #include "hfsplus_fs.h"
 #include "hfsplus_raw.h"
@@ -518,3 +519,34 @@ int hfsplus_compare_dentry(const struct dentry *dentry,
 		return 1;
 	return 0;
 }
+
+int hfsplus_revalidate_dentry(struct dentry *dentry, unsigned int flags)
+{
+	/*
+	 * dentries are always valid when disabling casefold.
+	 */
+	if (!test_bit(HFSPLUS_SB_CASEFOLD, &HFSPLUS_SB(dentry->d_sb)->flags))
+		return 1;
+
+	/*
+	 * Positive dentries are valid when enabling casefold.
+	 *
+	 * Note, rename() to existing directory entry will have ->d_inode, and
+	 * will use existing name which isn't specified name by user.
+	 *
+	 * We may be able to drop this positive dentry here. But dropping
+	 * positive dentry isn't good idea. So it's unsupported like
+	 * rename("filename", "FILENAME") for now.
+	 */
+	if (d_really_is_positive(dentry))
+		return 1;
+
+	/*
+	 * Drop the negative dentry, in order to make sure to use the case
+	 * sensitive name which is specified by user if this is for creation.
+	 */
+	if (flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET))
+		return 0;
+
+	return 1;
+}
-- 
2.25.1

