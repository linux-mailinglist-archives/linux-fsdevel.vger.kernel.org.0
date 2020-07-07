Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C583A216BFF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 13:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgGGLpQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 07:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbgGGLpO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:45:14 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EC1C08C5E1
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2020 04:45:13 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id m7so32156680pgv.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2020 04:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jQyiEHFjczWzBCWOEg21Dcl16Iq/vsWySX7c2PwkqrE=;
        b=ZmBSb4zIpxtUA454VMGhfcQ9VXbfiwePK53hyXdsZi/OZ0f5+Bz2uVBr3xj2TKppN6
         EoPxCIKQ+VWRASd9lTnzet+w66GUQOa/MSXAHDNfwFI8s/aQCpXH8A+b8jG/JGiOOXM3
         lh9d4eO/HcQmfXGsnqolSUxMv/rGrOYQSDOSg4E4qsxqLw1yrGGdNWMXJXpJoO8GkiYH
         Zs0WFmNyeuofLW0RwyBqsdv874fPDW9mVsODa+zKxUQbp12ERmIsJeCvn2f2aZgSMKca
         xhCdS6J51GvK0Wl8ldcGVc1wheWiJGRDS+8rNyjU6sZ28byoGRa7WMz+m2iYmNgBCUYc
         tQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jQyiEHFjczWzBCWOEg21Dcl16Iq/vsWySX7c2PwkqrE=;
        b=I7W/PWLp25NIahkrNNnN/NRqV4LwQkOyKitFomlcgEEywdcUHjr8afxI/zeOWfzv/R
         VmjhVtFb75CIXbGQEq5IkYOlUJ+H+FGMzDpmOEchF1/M2SvB88uaDBSxuu2Kvhifsqeg
         eyVSHe8VXlsHezcgCGROGObVLlGpKVt7MCUf+PEA1S0V9sJSN13WiKwdDW+BdUf8OAWZ
         3fSOO6baBPpECF+f5xtFlF/exC10f+fZDQam4BxTQN3b+M1sk4oHuWxdftmrNd+HfZou
         t02o1UHUMQBr41hWv5G9tn+8Q81WGHG1KN2PLviePKGJ9QoB/J5LoazwA/39YckoqA19
         kRiQ==
X-Gm-Message-State: AOAM532dPdPHF426pdGpndiN5PiVUssz7fyJMiRxB16wYBcOrv7H9l9G
        juyaLwC/kx+YQkCFMWwAw1rVhiySWk8=
X-Google-Smtp-Source: ABdhPJyO1nZSZAAVf0GM6Kj7adkJ/AeTSgpaotG5seZLgh6nPg0Hy3BHnx89r9ml0wyh6q0bvtKq9WocNJE=
X-Received: by 2002:a17:902:e9d2:: with SMTP id 18mr45065394plk.40.1594122313282;
 Tue, 07 Jul 2020 04:45:13 -0700 (PDT)
Date:   Tue,  7 Jul 2020 04:31:20 -0700
In-Reply-To: <20200707113123.3429337-1-drosen@google.com>
Message-Id: <20200707113123.3429337-2-drosen@google.com>
Mime-Version: 1.0
References: <20200707113123.3429337-1-drosen@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v10 1/4] unicode: Add utf8_casefold_hash
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
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds a case insensitive hash function to allow taking the hash
without needing to allocate a casefolded copy of the string.

The existing d_hash implementations for casefolding allocates memory
within rcu-walk, by avoiding it we can be more efficient and avoid
worrying about a failed allocation.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
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
2.27.0.212.ge8ba1cc988-goog

