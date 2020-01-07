Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 819CB131EFE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 06:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbgAGFRV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 00:17:21 -0500
Received: from mail-qv1-f73.google.com ([209.85.219.73]:57098 "EHLO
        mail-qv1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbgAGFQw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 00:16:52 -0500
Received: by mail-qv1-f73.google.com with SMTP id a14so36043158qvy.23
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2020 21:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1KoqFRm8toFHbQb4HraW6ZzquFQ8seovULWIbpVglyc=;
        b=lLvfedis7T6R8lmSAP9Wh1Pxg+sftcc4vMdmmS0yfRe55tOgHHBMLZ+QfQdgVLoPE0
         INN8jInKrA9Z4XgoefL3qaCBYZpeKfAyDIHM7UdbdszU1wbKPj19jrZ6ufZBPDCEuZ68
         so0LVgwpC6MtNFPkVo5QD7RtXlvDZ5qFa7fcg1WmiETaA4HDsferh0X4dC2DWi43CFK3
         vjXAjA/2eDhLHcGBQr3wxPA4GsXJe8fXf2FkuEHayJvz7a5anXjjzHgoUkgVHcFVV51J
         1qJrf3LXIFJHqvI8QyIsdV+VTl0UBPaWG45ovj5xmje9JdwB0C8gRp2aouFep/yN8zGs
         0Saw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1KoqFRm8toFHbQb4HraW6ZzquFQ8seovULWIbpVglyc=;
        b=c1FSvSHH2pvmJ8j1sYNyAAJzW/rM8Y3lgrnxyEf4271AkNRQZkmrdhzVYQfN4wYSD4
         jvaWv/1aHhMrB+BeTjH7aRytsWIoH1jC/Yc0sHpjGV3XTj62gEbwQpZ1ytxqFeMpYZ0Z
         iM2jcHre5pEEO05pDRVrklahlv6kY65Fx8euGyQJ+TA64fXGgNy5gqvqbZFB8mDMK1cf
         MieFHRDpQavlVujJ224oLSpyB4nwjek2Qj166QgLDlYmNYNQPKlm0nBnrT/SrPPIREBK
         nKiSEBACkwNU+73IJ/af40PUmFmo3WwQ4GHRhX6OF36uKyUQdSFs2ddBXOyJjlW8YDuV
         Y7Pw==
X-Gm-Message-State: APjAAAUO0M8oaEFr979YyFBTqvc90sJNlgBFlPTvrM4rui8PTXGKXc+1
        3mrn0pTURi13W9AGyMdoo8Go4V7mtek=
X-Google-Smtp-Source: APXvYqz+aatsncKrBHi+meyY4vniJo1B8gKmB0ZHihWhsOLgzH6GowRM3C6j1PgdpzSWCkLxxBBxdnEIL4Y=
X-Received: by 2002:ad4:50d2:: with SMTP id e18mr82904873qvq.9.1578374211583;
 Mon, 06 Jan 2020 21:16:51 -0800 (PST)
Date:   Mon,  6 Jan 2020 21:16:34 -0800
In-Reply-To: <20200107051638.40893-1-drosen@google.com>
Message-Id: <20200107051638.40893-3-drosen@google.com>
Mime-Version: 1.0
References: <20200107051638.40893-1-drosen@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v2 2/6] vfs: Fold casefolding into vfs
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

Ext4 and F2fs are both using casefolding, and they, along with any other
filesystem that adds the feature, will be using identical dentry_ops.
Additionally, those dentry ops interfere with the dentry_ops required
for fscrypt once we add support for casefolding and encryption.
Moving this into the vfs removes code duplication as well as the
complication with encryption.

Currently this is pretty close to just moving the existing f2fs/ext4
code up a level into the vfs, although there is a lot of room for
improvement now.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/dcache.c             | 28 ++++++++++++++++++++++++++++
 fs/namei.c              | 41 ++++++++++++++++++++++++++++++++++++++---
 include/linux/fs.h      | 10 ++++++++++
 include/linux/unicode.h | 14 ++++++++++++++
 4 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index b280e07e162b1..a8bbb7f4fad30 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -32,6 +32,7 @@
 #include <linux/bit_spinlock.h>
 #include <linux/rculist_bl.h>
 #include <linux/list_lru.h>
+#include <linux/unicode.h>
 #include "internal.h"
 #include "mount.h"
 
@@ -247,7 +248,19 @@ static inline int dentry_cmp(const struct dentry *dentry, const unsigned char *c
 	 * be no NUL in the ct/tcount data)
 	 */
 	const unsigned char *cs = READ_ONCE(dentry->d_name.name);
+#ifdef CONFIG_UNICODE
+	struct inode *parent = dentry->d_parent->d_inode;
 
+	if (unlikely(needs_casefold(parent))) {
+		const struct qstr n1 = QSTR_INIT(cs, tcount);
+		const struct qstr n2 = QSTR_INIT(ct, tcount);
+		int result = utf8_strncasecmp(dentry->d_sb->s_encoding,
+						&n1, &n2);
+
+		if (result >= 0 || sb_has_enc_strict_mode(dentry->d_sb))
+			return result;
+	}
+#endif
 	return dentry_string_cmp(cs, ct, tcount);
 }
 
@@ -2406,7 +2419,22 @@ struct dentry *d_hash_and_lookup(struct dentry *dir, struct qstr *name)
 	 * calculate the standard hash first, as the d_op->d_hash()
 	 * routine may choose to leave the hash value unchanged.
 	 */
+#ifdef CONFIG_UNICODE
+	unsigned char *hname = NULL;
+	int hlen = name->len;
+
+	if (IS_CASEFOLDED(dir->d_inode)) {
+		hname = kmalloc(PATH_MAX, GFP_ATOMIC);
+		if (!hname)
+			return ERR_PTR(-ENOMEM);
+		hlen = utf8_casefold(dir->d_sb->s_encoding,
+					name, hname, PATH_MAX);
+	}
+	name->hash = full_name_hash(dir, hname ?: name->name, hlen);
+	kfree(hname);
+#else
 	name->hash = full_name_hash(dir, name->name, name->len);
+#endif
 	if (dir->d_flags & DCACHE_OP_HASH) {
 		int err = dir->d_op->d_hash(dir, name);
 		if (unlikely(err < 0))
diff --git a/fs/namei.c b/fs/namei.c
index d6c91d1e88cb3..f8e65c9f31444 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -39,6 +39,7 @@
 #include <linux/bitops.h>
 #include <linux/init_task.h>
 #include <linux/uaccess.h>
+#include <linux/unicode.h>
 
 #include "internal.h"
 #include "mount.h"
@@ -2055,6 +2056,10 @@ static inline u64 hash_name(const void *salt, const char *name)
 static int link_path_walk(const char *name, struct nameidata *nd)
 {
 	int err;
+#ifdef CONFIG_UNICODE
+	char *hname = NULL;
+	int hlen = 0;
+#endif
 
 	if (IS_ERR(name))
 		return PTR_ERR(name);
@@ -2071,9 +2076,22 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 		err = may_lookup(nd);
 		if (err)
 			return err;
-
+#ifdef CONFIG_UNICODE
+		if (needs_casefold(nd->path.dentry->d_inode)) {
+			struct qstr str = QSTR_INIT(name, PATH_MAX);
+
+			hname = kmalloc(PATH_MAX, GFP_ATOMIC);
+			if (!hname)
+				return -ENOMEM;
+			hlen = utf8_casefold(nd->path.dentry->d_sb->s_encoding,
+						&str, hname, PATH_MAX);
+		}
+		hash_len = hash_name(nd->path.dentry, hname ?: name);
+		kfree(hname);
+		hname = NULL;
+#else
 		hash_len = hash_name(nd->path.dentry, name);
-
+#endif
 		type = LAST_NORM;
 		if (name[0] == '.') switch (hashlen_len(hash_len)) {
 			case 2:
@@ -2445,9 +2463,26 @@ EXPORT_SYMBOL(vfs_path_lookup);
 static int lookup_one_len_common(const char *name, struct dentry *base,
 				 int len, struct qstr *this)
 {
+#ifdef CONFIG_UNICODE
+	char *hname = NULL;
+	int hlen = len;
+
+	if (needs_casefold(base->d_inode)) {
+		struct qstr str = QSTR_INIT(name, len);
+
+		hname = kmalloc(PATH_MAX, GFP_ATOMIC);
+		if (!hname)
+			return -ENOMEM;
+		hlen = utf8_casefold(base->d_sb->s_encoding,
+					&str, hname, PATH_MAX);
+	}
+	this->hash = full_name_hash(base, hname ?: name, hlen);
+	kfree(hname);
+#else
+	this->hash = full_name_hash(base, name, len);
+#endif
 	this->name = name;
 	this->len = len;
-	this->hash = full_name_hash(base, name, len);
 	if (!len)
 		return -EACCES;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98e0349adb526..9a7092449e94f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1382,6 +1382,12 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_ACTIVE	(1<<30)
 #define SB_NOUSER	(1<<31)
 
+/* These flags relate to encoding and casefolding */
+#define SB_ENC_STRICT_MODE_FL	(1 << 0)
+
+#define sb_has_enc_strict_mode(sb) \
+	(sb->s_encoding_flags & SB_ENC_STRICT_MODE_FL)
+
 /*
  *	Umount options
  */
@@ -1449,6 +1455,10 @@ struct super_block {
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
diff --git a/include/linux/unicode.h b/include/linux/unicode.h
index 990aa97d80496..182352f3cc30f 100644
--- a/include/linux/unicode.h
+++ b/include/linux/unicode.h
@@ -4,6 +4,8 @@
 
 #include <linux/init.h>
 #include <linux/dcache.h>
+#include <linux/fscrypt.h>
+#include <linux/fs.h>
 
 struct unicode_map {
 	const char *charset;
@@ -30,4 +32,16 @@ int utf8_casefold(const struct unicode_map *um, const struct qstr *str,
 struct unicode_map *utf8_load(const char *version);
 void utf8_unload(struct unicode_map *um);
 
+#ifdef CONFIG_UNICODE
+static inline bool needs_casefold(const struct inode *dir)
+{
+	return IS_CASEFOLDED(dir) && dir->i_sb->s_encoding &&
+			(!IS_ENCRYPTED(dir) || fscrypt_has_encryption_key(dir));
+}
+#else
+static inline bool needs_casefold(const struct inode *dir)
+{
+	return 0;
+}
+#endif
 #endif /* _LINUX_UNICODE_H */
-- 
2.24.1.735.g03f4e72817-goog

