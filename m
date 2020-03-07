Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 801BD17CB06
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2020 03:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgCGCgi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 21:36:38 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:40648 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgCGCgh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 21:36:37 -0500
Received: by mail-pg1-f202.google.com with SMTP id n16so2511777pgl.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2020 18:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=upHdbTD180chm+zVZgEnvZGj206fX6ERxiKApi6jZ8Y=;
        b=fyzf/Jubz9HkaxalGwR7GV/FnVvkkR3z+BL3xHAPV78dlk0xTqKWjGufJKSNBjySMS
         lJ6l9J8ZWaIMU4nYnJuLS0JP2KVJdtg58knvL2LZxAJig1d4nz0Pc8hN4CdjtrkPUh/L
         yGigvrVnnRAK1tYt/TyWTJZE14KygnZc+/ePsCWL7e5XM7ELayZaGTwE/bQ7cBu7vtFD
         6vSaxno8O+IO2yfKMw1SR77PmzhVPfUzkkgLsP7YIsL4mg+FKh+FCg7gM4axMP3W3rB0
         QJnTC98cimALDDZc7nEEDInaKRP29kqGalZn+2xetw6c5m0DBWt7tUDiZlaNbgCzCprP
         TPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=upHdbTD180chm+zVZgEnvZGj206fX6ERxiKApi6jZ8Y=;
        b=ht0sb/Zr+qWNu3YXKi2n+SQ2zd0k+025Yctek8JVs4lVqlQXrvMfjKvLfaBq4cxgfn
         hlf/nucI0EQPiGuoxjkG1/Seeufg5oik0E/eLhaPTPeY5WOVYEOFoch9pDFHVIgJV9Cq
         wWu5cynEH9igSPK82f8F2czPo2fgIjikF4REf4oHzithXj5l/Sc65V0zqQpgXJLacyIt
         QkcrEVu+xDG5a+drtmEAsAQQ16TcDkCmitnBdcYcKC3XuJndHcxKaukdrQpY8t7AUqf/
         C1X4UnBlZlJwsrAcX0DUwhope4Yp53yXjIteGa/+yIIdfsCizoJtIwP52AeTS/3awU31
         dj3w==
X-Gm-Message-State: ANhLgQ3ECCxVBCtrDZkU6A39yEqE8V3ixZrAjThdHjdi8CMUk7G4fhjH
        EWvgQU74RtiCwEUjeBwMtPHA2zGtKyQ=
X-Google-Smtp-Source: ADFU+vuXQ5IvQYoUUL0swPdg+x5Y+MMF/JrTRrg98tDU5t1A35z2Nv6UucYAIwBa/D0lgjJ2OblQhk4x968=
X-Received: by 2002:a63:f447:: with SMTP id p7mr6066483pgk.326.1583548595595;
 Fri, 06 Mar 2020 18:36:35 -0800 (PST)
Date:   Fri,  6 Mar 2020 18:36:04 -0800
In-Reply-To: <20200307023611.204708-1-drosen@google.com>
Message-Id: <20200307023611.204708-2-drosen@google.com>
Mime-Version: 1.0
References: <20200307023611.204708-1-drosen@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v8 1/8] unicode: Add utf8_casefold_hash
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
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

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/unicode/utf8-core.c  | 23 ++++++++++++++++++++++-
 include/linux/unicode.h |  3 +++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index 2a878b739115d..90656b9980720 100644
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
+			return c;
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
index 990aa97d80496..74484d44c7554 100644
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
2.25.1.481.gfbce0eb801-goog

