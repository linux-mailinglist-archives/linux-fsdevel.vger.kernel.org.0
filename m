Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA562B58AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 05:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgKQEDf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 23:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbgKQEDX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 23:03:23 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0E3C061A47
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2020 20:03:21 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id e142so20281895ybf.16
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2020 20:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=26rm8pP8X1eqyqMFHjed3HgpBJsgTLVuVg1p5M5T4ac=;
        b=shg3+cQ9HKM0nPNtrMQTh+D5eQYXxiRjQHiCYna15DnDwGSI4q6hNF86FmwmCYrJ09
         0uszwptNamjvsfa2d+Ebp170YA7jdMrfds4LdsowSETcYPuptonfbiP7v8hpd4Y0MZkg
         TcH5aai3GlIlPjDRJOutLlBhbMbEKGMg5F5w3kD5/X0fqC2FyU3uSCyFeDu5RIXt/ixa
         9s2Vzm7JxAfAo2lWEtY1zChL12tD9p7+0mwGYHx+TBdw2Ath0P70x0MCBOufxM8RBgRH
         D/gZzY+rDOJ3wmUNZ5lYBs7E1V5A8uxoYtCXmruoFljhdbJ8IaBIehg5VrO1VZ4lsbQk
         6BPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=26rm8pP8X1eqyqMFHjed3HgpBJsgTLVuVg1p5M5T4ac=;
        b=n+Kpx3GhhENL2k+dGSnZkjxH1G95r89hLRrAF38yo0rCRxKOYPVBmpIflWGO0M7lNt
         wXGxrJf+z2xPHB4GipoCvAor7KPg0fG8EAmc5giwIow1QShDRsln0IKxWATwd/aCoHC0
         epaqlQAYIuUSqTfxhilZrsF1EU9b5BgJepY2gi9olx0Pe3W/5gpv6rSH5aNJ/g2eWHyz
         Awn4sedbmSqVfeZ416LbYqvOGQjagod/Ztfxx1DJYxTy32xeoMuNw+te225pw5Ahk18d
         XeBEYk1p3bhln8jW4dx2g82YlF5rlv2AoEFxaA8J+P+sI7q0qkArLMEajeXoJtnWPAfE
         O5aQ==
X-Gm-Message-State: AOAM5307BBNhDvcg6/W+ebWQtQ5u/n0FguvF4VZfRBQL9w5vM7MgUGO6
        aGrXpfR9c1CUhmDZfvEyAJotWgHwYGg=
X-Google-Smtp-Source: ABdhPJzKALm1EBPTQ18K+cplc9Rj54/XCyTrRJBcCgve7DfHa3FcRADsKoXoWVc+0ELNdGgH6frN1aEubL8=
Sender: "drosen via sendgmr" <drosen@drosen.c.googlers.com>
X-Received: from drosen.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:4e6f])
 (user=drosen job=sendgmr) by 2002:a25:88a:: with SMTP id 132mr26330262ybi.215.1605585800711;
 Mon, 16 Nov 2020 20:03:20 -0800 (PST)
Date:   Tue, 17 Nov 2020 04:03:13 +0000
In-Reply-To: <20201117040315.28548-1-drosen@google.com>
Message-Id: <20201117040315.28548-2-drosen@google.com>
Mime-Version: 1.0
References: <20201117040315.28548-1-drosen@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH v2 1/3] libfs: Add generic function for setting dentry_ops
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chao Yu <chao@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds a function to set dentry operations at lookup time that will
work for both encrypted filenames and casefolded filenames.

A filesystem that supports both features simultaneously can use this
function during lookup preparations to set up its dentry operations once
fscrypt no longer does that itself.

Currently the casefolding dentry operation are always set if the
filesystem defines an encoding because the features is toggleable on
empty directories. Since we don't know what set of functions we'll
eventually need, and cannot change them later, we add just add them.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/libfs.c         | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  1 +
 2 files changed, 61 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index fc34361c1489..dd8504f3ff5d 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1449,4 +1449,64 @@ int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
 	return 0;
 }
 EXPORT_SYMBOL(generic_ci_d_hash);
+
+static const struct dentry_operations generic_ci_dentry_ops = {
+	.d_hash = generic_ci_d_hash,
+	.d_compare = generic_ci_d_compare,
+};
 #endif
+
+#ifdef CONFIG_FS_ENCRYPTION
+static const struct dentry_operations generic_encrypted_dentry_ops = {
+	.d_revalidate = fscrypt_d_revalidate,
+};
+#endif
+
+#if IS_ENABLED(CONFIG_UNICODE) && IS_ENABLED(CONFIG_FS_ENCRYPTION)
+static const struct dentry_operations generic_encrypted_ci_dentry_ops = {
+	.d_hash = generic_ci_d_hash,
+	.d_compare = generic_ci_d_compare,
+	.d_revalidate = fscrypt_d_revalidate,
+};
+#endif
+
+/**
+ * generic_set_encrypted_ci_d_ops - helper for setting d_ops for given dentry
+ * @dentry:	dentry to set ops on
+ *
+ * This function sets the dentry ops for the given dentry to handle both
+ * casefolded and encrypted dentry names.
+ *
+ * Encryption requires d_revalidate to remove nokey names once the key is present.
+ * Casefolding is toggleable on an empty directory. Since we can't change the
+ * operations later on, we just add the casefolding ops if the filesystem defines an
+ * encoding.
+ */
+void generic_set_encrypted_ci_d_ops(struct dentry *dentry)
+{
+#ifdef CONFIG_FS_ENCRYPTION
+	bool needs_encrypt_ops = dentry->d_flags & DCACHE_NOKEY_NAME;
+#endif
+#ifdef CONFIG_UNICODE
+	bool needs_ci_ops = dentry->d_sb->s_encoding;
+#endif
+#if defined(CONFIG_FS_ENCRYPTION) && defined(CONFIG_UNICODE)
+	if (needs_encrypt_ops && needs_ci_ops) {
+		d_set_d_op(dentry, &generic_encrypted_ci_dentry_ops);
+			return;
+	}
+#endif
+#ifdef CONFIG_FS_ENCRYPTION
+	if (needs_encrypt_ops) {
+		d_set_d_op(dentry, &generic_encrypted_dentry_ops);
+		return;
+	}
+#endif
+#ifdef CONFIG_UNICODE
+	if (needs_ci_ops) {
+		d_set_d_op(dentry, &generic_ci_dentry_ops);
+		return;
+	}
+#endif
+}
+EXPORT_SYMBOL(generic_set_encrypted_ci_d_ops);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8667d0cdc71e..11345e66353b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3202,6 +3202,7 @@ extern int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str);
 extern int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
 				const char *str, const struct qstr *name);
 #endif
+extern void generic_set_encrypted_ci_d_ops(struct dentry *dentry);
 
 #ifdef CONFIG_MIGRATION
 extern int buffer_migrate_page(struct address_space *,
-- 
2.29.2.299.gdc1121823c-goog

