Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A29D4141350
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 22:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgAQVnB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 16:43:01 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:43281 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729190AbgAQVnA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 16:43:00 -0500
Received: by mail-pg1-f202.google.com with SMTP id d9so15158679pgd.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2020 13:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ijaPqYX9QMZlgJNEqLIabbahqNoro6V7G/0uSLsc++o=;
        b=WHQxC8Nh4cFd+mKz0Z5y8hCNfaRWaIIItg6rAD4vRRKh08n1rF1ROJp9bdNhKHjJEe
         dB+QzSzQk+37KIA3xLEYSV5jYc4LXnUAkScu6uDLEfQxiLJhWSUqLkSk9o/lj3OGUOFv
         x7d1El6VyYGxobDvLS1U1KrD73lJ1hHS4/+7B8qljX4+5zRjTKVAcKRaD+DQJ+DOSszS
         Quz0IYsmfSMa9Ytm8SlgE4uCUjy38oOsimu9gdN9/5CWb0bp8uDvRUzsZv7KYdIVZQFk
         3LnqAgjGyE/d2ro52ABbHg/HE7dIctRYBIsBeLkMsAqgNdPO0t9LQXQxfHUAMHwqtmvi
         0wNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ijaPqYX9QMZlgJNEqLIabbahqNoro6V7G/0uSLsc++o=;
        b=pIP8nwdDU4a5BM2C/A2tuQCuVZCjlfpOGqQl/mXW5dtqh06vSStqMDFvTgEwUPgox5
         PZ8ysdIZkWgvl97Ge6DRaoeBFU849gG4J1lX8ql7CfE8aZaMVypqx60o8KYuBgnghn0B
         QqBFwtQPuN9ltfB+oF+4sSEd6VQaefZo+l1Xfaj+2tpeVY8QzqEoWkCUdNaGF+IZpX8s
         k2HHjzFIncHRvnNFup8QeCEWxGHjC3OTtkAgQgMRcBezPItlj4FyYU01H1CZj/W7SO72
         RQzRsjHzBOEItSYX7ohrCncL4dRyZcmSNg1GVY1cl96WyYOegWXebNJO7gNIFdn7OQi5
         NAoQ==
X-Gm-Message-State: APjAAAV5FoUrqwtWVv9yTzlYjbwcXoz7Anb2kV65rgsyiPPG86e0KD7w
        fKGwedl00OkIyfRK+k8yGteJsAPcvgA=
X-Google-Smtp-Source: APXvYqzKuQnOCxtPcdxY/PuMxbANDvGzPhycQ/4MRG+yecKcHD6KYxDk5xX57ii8X1oM1NolqUYQnxR+7ug=
X-Received: by 2002:a63:3756:: with SMTP id g22mr47225338pgn.375.1579297379818;
 Fri, 17 Jan 2020 13:42:59 -0800 (PST)
Date:   Fri, 17 Jan 2020 13:42:39 -0800
In-Reply-To: <20200117214246.235591-1-drosen@google.com>
Message-Id: <20200117214246.235591-3-drosen@google.com>
Mime-Version: 1.0
References: <20200117214246.235591-1-drosen@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v3 2/9] fscrypt: Don't allow v1 policies with casefolding
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

Casefolding currently requires a derived key for computing the siphash.
This is available for v2 policies, but not v1, so we disallow it for v1.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/crypto/policy.c      | 28 ++++++++++++++++++++++++++++
 fs/inode.c              |  3 ++-
 include/linux/fscrypt.h | 11 +++++++++++
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index f1cff83c151ac..2cd9a940d8f46 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -124,6 +124,12 @@ static bool fscrypt_supported_v1_policy(const struct fscrypt_policy_v1 *policy,
 					policy->filenames_encryption_mode))
 		return false;
 
+	if (IS_CASEFOLDED(inode)) {
+		fscrypt_warn(inode,
+			     "v1 policy does not support casefolded directories");
+		return false;
+	}
+
 	return true;
 }
 
@@ -579,3 +585,25 @@ int fscrypt_inherit_context(struct inode *parent, struct inode *child,
 	return preload ? fscrypt_get_encryption_info(child): 0;
 }
 EXPORT_SYMBOL(fscrypt_inherit_context);
+
+int fscrypt_ioc_setflags_prepare(struct inode *inode,
+				 unsigned int oldflags,
+				 unsigned int flags)
+{
+	union fscrypt_policy policy;
+	int err;
+
+	/*
+	 * When a directory is encrypted, the CASEFOLD flag can only be turned
+	 * on if the fscrypt policy supports it.
+	 */
+	if (IS_ENCRYPTED(inode) && (flags & ~oldflags & FS_CASEFOLD_FL)) {
+		err = fscrypt_get_policy(inode, &policy);
+		if (err)
+			return err;
+		if (policy.version != FSCRYPT_POLICY_V2)
+			return -EINVAL;
+	}
+
+	return 0;
+}
diff --git a/fs/inode.c b/fs/inode.c
index 96d62d97694ef..8f6267858d0c1 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -20,6 +20,7 @@
 #include <linux/ratelimit.h>
 #include <linux/list_lru.h>
 #include <linux/iversion.h>
+#include <linux/fscrypt.h>
 #include <trace/events/writeback.h>
 #include "internal.h"
 
@@ -2252,7 +2253,7 @@ int vfs_ioc_setflags_prepare(struct inode *inode, unsigned int oldflags,
 	    !capable(CAP_LINUX_IMMUTABLE))
 		return -EPERM;
 
-	return 0;
+	return fscrypt_ioc_setflags_prepare(inode, oldflags, flags);
 }
 EXPORT_SYMBOL(vfs_ioc_setflags_prepare);
 
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 1dfbed855beeb..2c292f19c6b94 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -142,6 +142,10 @@ extern int fscrypt_ioctl_get_policy_ex(struct file *, void __user *);
 extern int fscrypt_has_permitted_context(struct inode *, struct inode *);
 extern int fscrypt_inherit_context(struct inode *, struct inode *,
 					void *, bool);
+extern int fscrypt_ioc_setflags_prepare(struct inode *inode,
+					unsigned int oldflags,
+					unsigned int flags);
+
 /* keyring.c */
 extern void fscrypt_sb_free(struct super_block *sb);
 extern int fscrypt_ioctl_add_key(struct file *filp, void __user *arg);
@@ -383,6 +387,13 @@ static inline int fscrypt_inherit_context(struct inode *parent,
 	return -EOPNOTSUPP;
 }
 
+static inline int fscrypt_ioc_setflags_prepare(struct inode *inode,
+					       unsigned int oldflags,
+					       unsigned int flags)
+{
+	return 0;
+}
+
 /* keyring.c */
 static inline void fscrypt_sb_free(struct super_block *sb)
 {
-- 
2.25.0.341.g760bfbb309-goog

