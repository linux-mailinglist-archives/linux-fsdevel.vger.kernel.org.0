Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA3C12B011
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2019 02:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfL0BAv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Dec 2019 20:00:51 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46851 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfL0BAu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Dec 2019 20:00:50 -0500
Received: by mail-pg1-f193.google.com with SMTP id z124so13638008pgb.13;
        Thu, 26 Dec 2019 17:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s2YJGyHBLvtLKqb9SRpRu2YXGxUEZDi676bDfDkyEFg=;
        b=twiCyqpn/Igign0RvlTZHvRkRYKtUufFHA5W5ycoaUd3q/8n3py3R1QLAkBGcgvad9
         Kfcxqo5rB/CXwKIUyAmRey7Sjj2B4U/UurCMPZ0Oq3XFZiq5iW4QXiNFq0XUvdph+djU
         amfN30k3K/pnAH2doaL32/Om0flzJGZE4QASYvLRwjk2VBR0jXqlVOJVvgz+OLfivS8P
         6Mln+/3Y4Tcwxlp5b4USwweIsYnqqxgEFpsBqM60Mtv37cMjkY+BMwHW+axPm8cJx+OS
         Ij0wZx7Mo/qWeWuP/P+00VbarS89o+W+QgdgXlRZwfjLokI2fh3F+FuXB0ogkEOb4Odf
         tr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s2YJGyHBLvtLKqb9SRpRu2YXGxUEZDi676bDfDkyEFg=;
        b=uFbrH3Sf5qW+5uI6/bCbHN96Bd/pOt/Ohbc9ubLCOmuLpiWguKmib6lUK/e/ftfOx2
         bBdvrhtfXgLPSTgHQZzVh6R13J6maF9bYOdax1FiEZ+CMtrF+Z0+IRse8q4n8P6oGIfB
         oRf41ozT21qwy31HVOwy2HZW1aiYyyPlcFjsZPUSVsA2/DO49YuCIlcLmphvcRajcjt+
         Iyp64enyj01PSgDQapCO1X1EvXN2qNGCWZauIhyXpUhu+TNxpB7WiDHwFfwPAnCEVQpC
         kqzZtUmMUbuz9DHyxOhT4oUIUEfGEtNvdIp/syYSMtzR1vJAkQEZBFmhFjYU3bdewMPs
         lyuQ==
X-Gm-Message-State: APjAAAV7ESRHIxg5YNZLV2I22brHjDyq2jj3m65YmQNd6lS4l4mS+KFE
        iFRRT2fGv9WTzybFJGKj8qs=
X-Google-Smtp-Source: APXvYqwBB3Je6TMn6AbEqX5wBKgLlL6tpe5IErd1reTThA5aDBcNJsLSZUMJ3tQdS3Wfj9HH1YDKYw==
X-Received: by 2002:a62:e318:: with SMTP id g24mr51146777pfh.218.1577408450192;
        Thu, 26 Dec 2019 17:00:50 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:a2ce:f815:f14d:bfac])
        by smtp.gmail.com with ESMTPSA id 65sm39640144pfu.140.2019.12.26.17.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 17:00:49 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     viro@zeniv.linux.org.uk
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: posix-acl.c: Fix warnings
Date:   Thu, 26 Dec 2019 22:00:34 -0300
Message-Id: <20191227010035.854913-2-dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191227010035.854913-1-dwlsalmeida@gmail.com>
References: <20191227010035.854913-1-dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Fix the following warning

/fs/posix_acl.c:636: WARNING: Inline emphasis start-string without end-string.

By escaping a character.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 fs/posix_acl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 84ad1c90d535..cb25966c6881 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -634,7 +634,7 @@ EXPORT_SYMBOL_GPL(posix_acl_create);
  *
  * Update the file mode when setting an ACL: compute the new file permission
  * bits based on the ACL.  In addition, if the ACL is equivalent to the new
- * file mode, set *acl to NULL to indicate that no ACL should be set.
+ * file mode, set \*acl to NULL to indicate that no ACL should be set.
  *
  * As with chmod, clear the setgit bit if the caller is not in the owning group
  * or capable of CAP_FSETID (see inode_change_ok).
@@ -743,12 +743,12 @@ posix_acl_from_xattr(struct user_namespace *user_ns,
 		return ERR_PTR(-EINVAL);
 	if (count == 0)
 		return NULL;
-	
+
 	acl = posix_acl_alloc(count, GFP_NOFS);
 	if (!acl)
 		return ERR_PTR(-ENOMEM);
 	acl_e = acl->a_entries;
-	
+
 	for (end = entry + count; entry != end; acl_e++, entry++) {
 		acl_e->e_tag  = le16_to_cpu(entry->e_tag);
 		acl_e->e_perm = le16_to_cpu(entry->e_perm);
-- 
2.24.1

