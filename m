Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDFC217D51
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 05:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgGHDGB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 23:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729326AbgGHDF7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 23:05:59 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721FCC08C5E2
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2020 20:05:59 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id i1so34013291pgn.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2020 20:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wV4Dlp1PtfRWNCEDy3OUVmwFuHR/znQviVm4udIzuj8=;
        b=cfqa4ZI0uBxj1JWd8dAGqnZFXA438OEfTLCcfqHSddxLMr8U1C1o3sty7pkLZivxV9
         k2SLkAZmTm86qL76MMu0rWCsjw2KGoVfUpcu2Skz+1RJ2HRxepy9PS+oJHBH6EAIiKT0
         SriweU9dx43A69vye8MbQ/7x6celwyfbxtDCje7B/pL2YOYpnBZAXmG4R6XlmFBlpzHU
         zIIB+JCbamdhEvMVnfZqSc8WEq8Ob08h3jKHTybWQtf0DWwoHE/q1x+7PQ4gsYCnSPgg
         nGLeVC26zVJq9dt0SaFj68BsveNgcD72gE+9VWRDJhJ5LkwFf2660LZxMJDrcdwQGjSi
         7aVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wV4Dlp1PtfRWNCEDy3OUVmwFuHR/znQviVm4udIzuj8=;
        b=AqKKzljbo6iu2p27h/xHF4qF7/OBv3L4G9kBRqT4Hwzqea1t0JRz4OMsfdJ1+Tqd0U
         U3gm3Y338Cn6kVvb8xa/UfzbuEoZcXCPsYzK/IoGXRQw4j/U5AK07Qw+4lLea4UTvhbu
         mPEBN08RYKCemN0k5XIPDZcYZoAkiID6DfK6SQp13rI1X6rJbmwkbbDzoTNtUMhpyFgJ
         gbDefXYgQOkmTBdk2s41aszpcAijJfOMU1fTUDm2Eb0hAxCsPmd2qN5dTWYD7Mey9AhX
         vdlCutd9bKHLQ+4RP6Jv7Pd/er3votoT7xTFCgpEFm93cQ6MuHfoAcOZAVO/VI73FkY1
         cbeA==
X-Gm-Message-State: AOAM5303eJYkkTv2AnxPhzRKv756/1lzdB7Ubf9Rjhr+KOpTOL3Ib/EG
        YqHi1RjZVKh1O8DNKzAWjOVvOSAg0Y0=
X-Google-Smtp-Source: ABdhPJzqov5JL3MTCYCUXsgN1WMwA/rTbUQMcSdZ1sJWb3HhqSUyDy2izboLJgJ3fC9ih0rA4dvnY2hb6wM=
X-Received: by 2002:a17:902:744c:: with SMTP id e12mr39192696plt.337.1594177558861;
 Tue, 07 Jul 2020 20:05:58 -0700 (PDT)
Date:   Tue,  7 Jul 2020 20:05:49 -0700
In-Reply-To: <20200708030552.3829094-1-drosen@google.com>
Message-Id: <20200708030552.3829094-2-drosen@google.com>
Mime-Version: 1.0
References: <20200708030552.3829094-1-drosen@google.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH v11 1/4] unicode: Add utf8_casefold_hash
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds a case insensitive hash function to allow taking the hash
without needing to allocate a casefolded copy of the string.

The existing d_hash implementations for casefolding allocate memory
within rcu-walk, by avoiding it we can be more efficient and avoid
worrying about a failed allocation.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
---
 fs/unicode/utf8-core.c  | 23 ++++++++++++++++++++++-
 include/linux/unicode.h |  3 +++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index 2a878b739115..dc25823bfed9 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -6,6 +6,7 @@
 #include <linux/parser.h>
 #include <linux/errno.h>
 #include <linux/unicode.h>
+#include <linux/stringhash.h>
 
 #include "utf8n.h"
 
@@ -122,9 +123,29 @@ int utf8_casefold(const struct unicode_map *um, const struct qstr *str,
 	}
 	return -EINVAL;
 }
-
 EXPORT_SYMBOL(utf8_casefold);
 
+int utf8_casefold_hash(const struct unicode_map *um, const void *salt,
+		       struct qstr *str)
+{
+	const struct utf8data *data = utf8nfdicf(um->version);
+	struct utf8cursor cur;
+	int c;
+	unsigned long hash = init_name_hash(salt);
+
+	if (utf8ncursor(&cur, data, str->name, str->len) < 0)
+		return -EINVAL;
+
+	while ((c = utf8byte(&cur))) {
+		if (c < 0)
+			return -EINVAL;
+		hash = partial_name_hash((unsigned char)c, hash);
+	}
+	str->hash = end_name_hash(hash);
+	return 0;
+}
+EXPORT_SYMBOL(utf8_casefold_hash);
+
 int utf8_normalize(const struct unicode_map *um, const struct qstr *str,
 		   unsigned char *dest, size_t dlen)
 {
diff --git a/include/linux/unicode.h b/include/linux/unicode.h
index 990aa97d8049..74484d44c755 100644
--- a/include/linux/unicode.h
+++ b/include/linux/unicode.h
@@ -27,6 +27,9 @@ int utf8_normalize(const struct unicode_map *um, const struct qstr *str,
 int utf8_casefold(const struct unicode_map *um, const struct qstr *str,
 		  unsigned char *dest, size_t dlen);
 
+int utf8_casefold_hash(const struct unicode_map *um, const void *salt,
+		       struct qstr *str);
+
 struct unicode_map *utf8_load(const char *version);
 void utf8_unload(struct unicode_map *um);
 
-- 
2.27.0.383.g050319c2ae-goog

