Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FC22B766F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 07:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgKRGmz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 01:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgKRGmy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 01:42:54 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64830C061A4D
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2020 22:42:52 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id z29so868231ybi.23
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2020 22:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=DV09QN89xVJWJy2G2Lk6hdWThRemlVWRM2oh2xdx8V4=;
        b=AVBnh8v1C3R+KGtEy4i7FdueXXEomxX/n+pWlo3sCw+oytZ2q9hGno6HSM7JbvFxwz
         OrHKZbOdvixT/eQizY+YzgeKTv0DIhEkVYYhBPU3pPK8sXsDPixDe+iha7Ydrr+JA+tN
         jI2tRDuaXk0i+4VuBZivUjlwtxNDHwWzZnZKS8JjCW74eyusJOGHWsQZGUkYl8gj14UB
         prKHhzqZWojkco+Wv9VgqltNqWvBEtpjgoKPbVXhiabvoPRQBIoUXyShIYeTyNps9HLV
         PvJYtWLReRl8A2jxvzTvygcUveMwL8qxkzhkUktD1hg5glU9IOR39afCciwVwlD3iqYQ
         A12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DV09QN89xVJWJy2G2Lk6hdWThRemlVWRM2oh2xdx8V4=;
        b=WgKAgt1JRevRm0JJ9ghE/r1luKRpQNTS7ziq4iJ//vi7SiPl+WYFj2k3bs8PiJ1RPD
         mpApVj86Wc+hIjoDFK6MmdB4tKDJcu1LePL1Kd5dtx7P/grcMhMA1zgreOX0nFxeEvoM
         H9qcmemj64ZxjvBEn0cDgqZlT/yiEUcTg5vqNXgNjBytpG0UMwMLjHNI+A7oUDpRAEYO
         JFm9QwXwXFULsFBCT4AA2D/4eFJ1jwbIFKsoCTEhWbeJk7KXW7wakFaWgmVXrC7JjWV4
         +2mo9UdC6wEPfO3J7FGqMOwufGxnxaVU7+qFonMPlQAeRjh5Gn1vv5oGux4+XeaSNtVP
         C8bQ==
X-Gm-Message-State: AOAM533q4wwB/SEkRrF2LfTQpmIPAyRpr6KPVS8oXkPwcqyogRoJ/IY5
        xDOvXodDf/nBKPPd6RzdAccEHue7pIs=
X-Google-Smtp-Source: ABdhPJxOd7e3q7u9BtHqGyF6Mlg3/h4hF+stEzn8jpxyxNb8EuNiIyfWe5DKbwvldnocmuozJqNRYtSR7EM=
Sender: "drosen via sendgmr" <drosen@drosen.c.googlers.com>
X-Received: from drosen.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:4e6f])
 (user=drosen job=sendgmr) by 2002:a25:e7cd:: with SMTP id e196mr4372701ybh.375.1605681771546;
 Tue, 17 Nov 2020 22:42:51 -0800 (PST)
Date:   Wed, 18 Nov 2020 06:42:43 +0000
In-Reply-To: <20201118064245.265117-1-drosen@google.com>
Message-Id: <20201118064245.265117-2-drosen@google.com>
Mime-Version: 1.0
References: <20201118064245.265117-1-drosen@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH v3 1/3] libfs: Add generic function for setting dentry_ops
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
empty directories. Unlike in the encryption case, the dentry operations
used come from the parent. Since we don't know what set of functions
we'll eventually need, and cannot change them later, we enable the
casefolding operations if the filesystem supports them at all.

By splitting out the various cases, we support as few dentry operations
as we can get away with, maximizing compatibility with overlayfs, which
will not function if a filesystem supports certain dentry_operations.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/libfs.c         | 70 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  1 +
 2 files changed, 71 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index fc34361c1489..babef1f7b50e 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1449,4 +1449,74 @@ int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
 	return 0;
 }
 EXPORT_SYMBOL(generic_ci_d_hash);
+
+static const struct dentry_operations generic_ci_dentry_ops = {
+	.d_hash = generic_ci_d_hash,
+	.d_compare = generic_ci_d_compare,
+};
+#endif
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
+ * Casefolded directories need d_hash and d_compare set, so that the dentries
+ * contained in them are handled case-insensitively.  Note that these operations
+ * are needed on the parent directory rather than on the dentries in it, and
+ * while the casefolding flag can be toggled on and off on an empty directory,
+ * dentry_operations can't be changed later.  As a result, if the filesystem has
+ * casefolding support enabled at all, we have to give all dentries the
+ * casefolding operations even if their inode doesn't have the casefolding flag
+ * currently (and thus the casefolding ops would be no-ops for now).
+ *
+ * Encryption works differently in that the only dentry operation it needs is
+ * d_revalidate, which it only needs on dentries that have the no-key name flag.
+ * The no-key flag can't be set "later", so we don't have to worry about that.
+ *
+ * Finally, to maximize compatibility with overlayfs (which isn't compatible
+ * with certain dentry operations) and to avoid taking an unnecessary
+ * performance hit, we use custom dentry_operations for each possible
+ * combination rather than always installing all operations.
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
+		return;
+	}
 #endif
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
2.29.2.454.gaff20da3a2-goog

