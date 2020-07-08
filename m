Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1A3218333
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 11:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgGHJMs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 05:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727908AbgGHJMp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:12:45 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E599C08C5DC
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2020 02:12:45 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id e127so24519972pgc.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2020 02:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8+TC1+grcd9+1L+bfv/X5qx9D+VjZ57HqDGHlmrwyxg=;
        b=q96aTbimluUtEdhrrGai6ITGwzBJEtjxuyK5R4Ohgo8jMj9xT3CE2pEQIPnI7YgKU0
         iZ+R+ujBZAkfm3i2yakoOqzAq77sDJ/DKwpxAwoYSJS5CsOoGES9CaumlTPPXerTo9rC
         svZP+qq435cqH5JMxhzd9HO0liyx1FRkgh+/JRijSnPZOCQoUUtu6NWMnDdYja6WCMQl
         WiOQFv8qa0NeOoqy7UgLEytqpfiFUb9Urs87YvVE9ZEk4azikkjjTTgMNa/LP41wArMS
         hovD05z9U+Vg3zkwPRG7uM3rnKL7GPzr6qaRxTaPbnB06HagWo8ViUYYrUf2i+6dDvHW
         p/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8+TC1+grcd9+1L+bfv/X5qx9D+VjZ57HqDGHlmrwyxg=;
        b=qQxmCcXgqTT0G4ZJw1z/MrLq4iXTFJAgYnz3veedBNNGM1uPHNZwxhAmP95n8z5E/T
         Sva7t8/KTEKrqwpVNincE0tb5qZZe89+VUx/hm0dRzJS94h07lUJVEy3bhq8abMMLljO
         /dhmd+jehKb49cZWTC/jNtfII6hK3JNiVNjkyNoaMiJQ8GTYs3ICdlQiOQs5uz8qKGNS
         zUqPwQTqKW0eSfxUQzBIcIvs/rmDaiBpfbntH7OTPAiIqJBe72BuP1YTYpm3XY3uycJH
         zsTjVGgE1NPfw3UQ8DwGI812Wz2j4DzFm/uS1ODrNVAouzLR2DOnpZ3IrKpvQ79HDVQz
         CLCQ==
X-Gm-Message-State: AOAM533DQECETATv9yhxOCJXcN+210h7TI1QV2Qo+HEZnxSUpdkRENSL
        xvB93mZZw1MugpFWRfQmcwh464Hb6Zw=
X-Google-Smtp-Source: ABdhPJymFIDabeVHG9reQJ9gahP1lHCXjNoctA7rMpb+c+pa+O+mAAY16K2hflrIoUySyNa//P1EBBAuC2Y=
X-Received: by 2002:a17:90b:1993:: with SMTP id mv19mr8603393pjb.39.1594199564949;
 Wed, 08 Jul 2020 02:12:44 -0700 (PDT)
Date:   Wed,  8 Jul 2020 02:12:35 -0700
In-Reply-To: <20200708091237.3922153-1-drosen@google.com>
Message-Id: <20200708091237.3922153-3-drosen@google.com>
Mime-Version: 1.0
References: <20200708091237.3922153-1-drosen@google.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH v12 2/4] fs: Add standard casefolding support
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

This adds general supporting functions for filesystems that use
utf8 casefolding. It provides standard dentry_operations and adds the
necessary structures in struct super_block to allow this standardization.

The new dentry operations are functionally equivalent to the existing
operations in ext4 and f2fs, apart from the use of utf8_casefold_hash to
avoid an allocation.

By providing a common implementation, all users can benefit from any
optimizations without needing to port over improvements.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/libfs.c         | 87 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h | 16 +++++++++
 2 files changed, 103 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 4d08edf19c78..72407cf151d4 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -20,6 +20,8 @@
 #include <linux/fs_context.h>
 #include <linux/pseudo_fs.h>
 #include <linux/fsnotify.h>
+#include <linux/unicode.h>
+#include <linux/fscrypt.h>
 
 #include <linux/uaccess.h>
 
@@ -1363,3 +1365,88 @@ bool is_empty_dir_inode(struct inode *inode)
 	return (inode->i_fop == &empty_dir_operations) &&
 		(inode->i_op == &empty_dir_inode_operations);
 }
+
+#ifdef CONFIG_UNICODE
+/*
+ * Determine if the name of a dentry should be casefolded.
+ *
+ * Return: if names will need casefolding
+ */
+static bool needs_casefold(const struct inode *dir)
+{
+	return IS_CASEFOLDED(dir) && dir->i_sb->s_encoding;
+}
+
+/**
+ * generic_ci_d_compare - generic d_compare implementation for casefolding filesystems
+ * @dentry:	dentry whose name we are checking against
+ * @len:	len of name of dentry
+ * @str:	str pointer to name of dentry
+ * @name:	Name to compare against
+ *
+ * Return: 0 if names match, 1 if mismatch, or -ERRNO
+ */
+int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
+			  const char *str, const struct qstr *name)
+{
+	const struct dentry *parent = READ_ONCE(dentry->d_parent);
+	const struct inode *dir = READ_ONCE(parent->d_inode);
+	const struct super_block *sb = dentry->d_sb;
+	const struct unicode_map *um = sb->s_encoding;
+	struct qstr qstr = QSTR_INIT(str, len);
+	char strbuf[DNAME_INLINE_LEN];
+	int ret;
+
+	if (!dir || !needs_casefold(dir))
+		goto fallback;
+	/*
+	 * If the dentry name is stored in-line, then it may be concurrently
+	 * modified by a rename.  If this happens, the VFS will eventually retry
+	 * the lookup, so it doesn't matter what ->d_compare() returns.
+	 * However, it's unsafe to call utf8_strncasecmp() with an unstable
+	 * string.  Therefore, we have to copy the name into a temporary buffer.
+	 */
+	if (len <= DNAME_INLINE_LEN - 1) {
+		memcpy(strbuf, str, len);
+		strbuf[len] = 0;
+		qstr.name = strbuf;
+		/* prevent compiler from optimizing out the temporary buffer */
+		barrier();
+	}
+	ret = utf8_strncasecmp(um, name, &qstr);
+	if (ret >= 0)
+		return ret;
+
+	if (sb_has_strict_encoding(sb))
+		return -EINVAL;
+fallback:
+	if (len != name->len)
+		return 1;
+	return !!memcmp(str, name->name, len);
+}
+EXPORT_SYMBOL(generic_ci_d_compare);
+
+/**
+ * generic_ci_d_hash - generic d_hash implementation for casefolding filesystems
+ * @dentry:	dentry of the parent directory
+ * @str:	qstr of name whose hash we should fill in
+ *
+ * Return: 0 if hash was successful or unchanged, and -EINVAL on error
+ */
+int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
+{
+	const struct inode *dir = READ_ONCE(dentry->d_inode);
+	struct super_block *sb = dentry->d_sb;
+	const struct unicode_map *um = sb->s_encoding;
+	int ret = 0;
+
+	if (!dir || !needs_casefold(dir))
+		return 0;
+
+	ret = utf8_casefold_hash(um, dentry, str);
+	if (ret < 0 && sb_has_strict_encoding(sb))
+		return -EINVAL;
+	return 0;
+}
+EXPORT_SYMBOL(generic_ci_d_hash);
+#endif
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3f881a892ea7..af8f2ecec8ff 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1392,6 +1392,12 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_ACTIVE	(1<<30)
 #define SB_NOUSER	(1<<31)
 
+/* These flags relate to encoding and casefolding */
+#define SB_ENC_STRICT_MODE_FL	(1 << 0)
+
+#define sb_has_strict_encoding(sb) \
+	(sb->s_encoding_flags & SB_ENC_STRICT_MODE_FL)
+
 /*
  *	Umount options
  */
@@ -1461,6 +1467,10 @@ struct super_block {
 #endif
 #ifdef CONFIG_FS_VERITY
 	const struct fsverity_operations *s_vop;
+#endif
+#ifdef CONFIG_UNICODE
+	struct unicode_map *s_encoding;
+	__u16 s_encoding_flags;
 #endif
 	struct hlist_bl_head	s_roots;	/* alternate root dentries for NFS */
 	struct list_head	s_mounts;	/* list of mounts; _not_ for fs use */
@@ -3385,6 +3395,12 @@ extern int generic_file_fsync(struct file *, loff_t, loff_t, int);
 
 extern int generic_check_addressable(unsigned, u64);
 
+#ifdef CONFIG_UNICODE
+extern int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str);
+extern int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
+				const char *str, const struct qstr *name);
+#endif
+
 #ifdef CONFIG_MIGRATION
 extern int buffer_migrate_page(struct address_space *,
 				struct page *, struct page *,
-- 
2.27.0.383.g050319c2ae-goog

