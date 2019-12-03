Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB13410F6AD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 06:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfLCFLZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 00:11:25 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:51118 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfLCFLY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 00:11:24 -0500
Received: by mail-pj1-f74.google.com with SMTP id e5so1250939pjr.17
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2019 21:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zioOGuJqnVPXe7Qe2SnSM0LE+ZxE0SKC1ZdBPwMzHHM=;
        b=Vi7RSXxGowYOEm1R7PqAvvobd49Ow6l4LUuP+EyQ8x3TZm7tmSuo7w72xlUfos80tZ
         E/5xpFoQ2wLEqy3sJx6GTasTyPD8TUZAvrKp4r5T0yV1jwHmX+TJe1LWpY208PzxANGu
         ut5I1Zdm3X6yUrK3XUXnrofTbSEcTJfH5v7UnTEBqOPCK7VLMb4+XLPA7r9Qjv9XMHVe
         bWves33Lu3GThFsqT1xtk/MGO/+WzHg4eXBqx/6CVZSf9UYCyUHFwBkAdhuz0Y7U38+n
         Z0AY+6+IDGq3SiysmR0NHMCVZsgVSj58gcf1kCj0taMnx+Y5pxB4I/Abvbm2KLXatHqP
         Kz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zioOGuJqnVPXe7Qe2SnSM0LE+ZxE0SKC1ZdBPwMzHHM=;
        b=TF0T3jFV/BlDdiJ9IL/EEgIHyoMED1YC8ZZ7V3ro4vEd8AaySjYLHC5YUQomPkfguE
         F1szsJM1FI2jyu5MwFL4jXBUy26z2/BYzWPaGOFHth9M5xee99geXb1qZ/uDT3oVwKHd
         lEf9jlGZo3Vp/HkjObDRXkJh15xI/95mV3zKkdHnIBBoeAxvxiPwiYYKdAJA7oj9CulV
         gJWBTYcQfd0mef53g35V3BjfQg7HThF9nXoffKy4zXCVuS7lIjyB3UXKwM0lvixuYKKn
         hklkCMGfPDmTtJkoWxRYPKpjl0fJ2XqkbFv59vWAhbJkp/KeizcCeC9nFge2tDdjd130
         /xAw==
X-Gm-Message-State: APjAAAVDQzTDA0N8mYRn++riZp63OUD6Rllyu0t7sPi5gOFmnuc5nO9a
        oLP1zVKssJ0jsaqOUBV2qGPcY98VgX0=
X-Google-Smtp-Source: APXvYqwLhVT0aPs7pDtnMOWvm8ceiekoDOnf+r3AdcXHnYtS4fRpDhrmnGvkSNzLuI9YnCQKTgC4a5Cp4Jk=
X-Received: by 2002:a63:6507:: with SMTP id z7mr3034832pgb.322.1575349882981;
 Mon, 02 Dec 2019 21:11:22 -0800 (PST)
Date:   Mon,  2 Dec 2019 21:10:43 -0800
In-Reply-To: <20191203051049.44573-1-drosen@google.com>
Message-Id: <20191203051049.44573-3-drosen@google.com>
Mime-Version: 1.0
References: <20191203051049.44573-1-drosen@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH 2/8] fscrypt: Don't allow v1 policies with casefolding
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Casefolding requires a derived key for computing the siphash.
This is available for v2 policies, but not v1, so we disallow it for v1.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/crypto/policy.c      | 26 +++++++++++++++++++++++---
 fs/inode.c              |  8 ++++++++
 include/linux/fscrypt.h |  7 +++++++
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index 96f528071bed..94d96d3212d6 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -67,9 +67,9 @@ static bool supported_iv_ino_lblk_64_policy(
  * fscrypt_supported_policy - check whether an encryption policy is supported
  *
  * Given an encryption policy, check whether all its encryption modes and other
- * settings are supported by this kernel.  (But we don't currently don't check
- * for crypto API support here, so attempting to use an algorithm not configured
- * into the crypto API will still fail later.)
+ * settings are supported by this kernel on the given inode.  (But we don't
+ * currently don't check for crypto API support here, so attempting to use an
+ * algorithm not configured into the crypto API will still fail later.)
  *
  * Return: %true if supported, else %false
  */
@@ -97,6 +97,12 @@ bool fscrypt_supported_policy(const union fscrypt_policy *policy_u,
 			return false;
 		}
 
+		if (IS_CASEFOLDED(inode)) {
+			fscrypt_warn(inode,
+				     "v1 policy does not support casefolded directories");
+			return false;
+		}
+
 		return true;
 	}
 	case FSCRYPT_POLICY_V2: {
@@ -530,3 +536,17 @@ int fscrypt_inherit_context(struct inode *parent, struct inode *child,
 	return preload ? fscrypt_get_encryption_info(child): 0;
 }
 EXPORT_SYMBOL(fscrypt_inherit_context);
+
+int fscrypt_set_casefolding_allowed(struct inode *inode)
+{
+	union fscrypt_policy policy;
+	int ret = fscrypt_get_policy(inode, &policy);
+
+	if (ret < 0)
+		return ret;
+
+	if (policy.version == FSCRYPT_POLICY_V2)
+		return 0;
+	else
+		return -EINVAL;
+}
diff --git a/fs/inode.c b/fs/inode.c
index fef457a42882..b615ec272a1e 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -20,6 +20,7 @@
 #include <linux/ratelimit.h>
 #include <linux/list_lru.h>
 #include <linux/iversion.h>
+#include <linux/fscrypt.h>
 #include <trace/events/writeback.h>
 #include "internal.h"
 
@@ -2245,6 +2246,13 @@ int vfs_ioc_setflags_prepare(struct inode *inode, unsigned int oldflags,
 	    !capable(CAP_LINUX_IMMUTABLE))
 		return -EPERM;
 
+	/*
+	 * When a directory is encrypted, the CASEFOLD flag can only be turned
+	 * on if the fscrypt policy supports it.
+	 */
+	if (IS_ENCRYPTED(inode) && (flags & ~oldflags & FS_CASEFOLD_FL))
+		return fscrypt_set_casefolding_allowed(inode);
+
 	return 0;
 }
 EXPORT_SYMBOL(vfs_ioc_setflags_prepare);
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index e13ff68a99f0..028aed925e51 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -127,6 +127,8 @@ extern int fscrypt_ioctl_get_policy_ex(struct file *, void __user *);
 extern int fscrypt_has_permitted_context(struct inode *, struct inode *);
 extern int fscrypt_inherit_context(struct inode *, struct inode *,
 					void *, bool);
+extern int fscrypt_set_casefolding_allowed(struct inode *inode);
+
 /* keyring.c */
 extern void fscrypt_sb_free(struct super_block *sb);
 extern int fscrypt_ioctl_add_key(struct file *filp, void __user *arg);
@@ -361,6 +363,11 @@ static inline int fscrypt_inherit_context(struct inode *parent,
 	return -EOPNOTSUPP;
 }
 
+static inline int fscrypt_set_casefolding_allowed(struct inode *inode)
+{
+	return 0;
+}
+
 /* keyring.c */
 static inline void fscrypt_sb_free(struct super_block *sb)
 {
-- 
2.24.0.393.g34dc348eaf-goog

