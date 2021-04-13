Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8537E35E58A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 19:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347461AbhDMRvh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 13:51:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347418AbhDMRvX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:51:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B8A961176;
        Tue, 13 Apr 2021 17:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618336263;
        bh=9ePaL4ydgwOOCxoRZDZ5GRS8iw/4x4RIaGn8mzERagQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bYzSvwQ7hgezSxne3uUn9/0fj5PqW3wW3hSjn1v8kr6YQkG4DLSsS7A+l59pKkVXY
         KDSo5KWgHuqwDquhuOWzM5d2r7rtKOCa8k7JynJM4/ukFQvUKb9ljBlf9mmSZzsdZt
         PX2QfkHF7RTWrnH/JvmnsLBO2kk9IF6jMkvkY0o5W6IqDkb1AtuwRSn5D4S5p8Awtc
         hWv102pR6GDx7cMd3gX1dr6YnVvmrP65HriCQ4QzgBVkhorKluOcm3PE25iuvGLUt5
         GFz7wsmqTPylvBY44bMWTs3jStx851O3DQNCaXIqjAvpWNWSF0UAYIUZAD0w8D2hgq
         ReymfrCbwKSog==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        lhenriques@suse.de
Subject: [RFC PATCH v6 15/20] ceph: add helpers for converting names for userland presentation
Date:   Tue, 13 Apr 2021 13:50:47 -0400
Message-Id: <20210413175052.163865-16-jlayton@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210413175052.163865-1-jlayton@kernel.org>
References: <20210413175052.163865-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/crypto.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/crypto.h | 41 ++++++++++++++++++++++++++
 2 files changed, 117 insertions(+)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index f037a4939026..9fed68f37629 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -107,3 +107,79 @@ int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
 		ceph_pagelist_release(pagelist);
 	return ret;
 }
+
+/**
+ * ceph_fname_to_usr - convert a filename for userland presentation
+ * @fname: ceph_fname to be converted
+ * @tname: temporary name buffer to use for conversion (may be NULL)
+ * @oname: where converted name should be placed
+ * @is_nokey: set to true if key wasn't available during conversion (may be NULL)
+ *
+ * Given a filename (usually from the MDS), format it for presentation to
+ * userland. If @parent is not encrypted, just pass it back as-is.
+ *
+ * Otherwise, base64 decode the string, and then ask fscrypt to format it
+ * for userland presentation.
+ *
+ * Returns 0 on success or negative error code on error.
+ */
+int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
+		      struct fscrypt_str *oname, bool *is_nokey)
+{
+	int ret;
+	struct fscrypt_str _tname = FSTR_INIT(NULL, 0);
+	struct fscrypt_str iname;
+
+	if (!IS_ENCRYPTED(fname->dir)) {
+		oname->name = fname->name;
+		oname->len = fname->name_len;
+		return 0;
+	}
+
+	/* Sanity check that the resulting name will fit in the buffer */
+	if (fname->name_len > FSCRYPT_BASE64_CHARS(NAME_MAX))
+		return -EIO;
+
+	ret = __fscrypt_prepare_readdir(fname->dir);
+	if (ret)
+		return ret;
+
+	/*
+	 * Use the raw dentry name as sent by the MDS instead of
+	 * generating a nokey name via fscrypt.
+	 */
+	if (!fscrypt_has_encryption_key(fname->dir)) {
+		memcpy(oname->name, fname->name, fname->name_len);
+		oname->len = fname->name_len;
+		if (is_nokey)
+			*is_nokey = true;
+		return 0;
+	}
+
+	if (fname->ctext_len == 0) {
+		int declen;
+
+		if (!tname) {
+			ret = fscrypt_fname_alloc_buffer(NAME_MAX, &_tname);
+			if (ret)
+				return ret;
+			tname = &_tname;
+		}
+
+		declen = fscrypt_base64_decode(fname->name, fname->name_len, tname->name);
+		if (declen <= 0) {
+			ret = -EIO;
+			goto out;
+		}
+		iname.name = tname->name;
+		iname.len = declen;
+	} else {
+		iname.name = fname->ctext;
+		iname.len = fname->ctext_len;
+	}
+
+	ret = fscrypt_fname_disk_to_usr(fname->dir, 0, 0, &iname, oname);
+out:
+	fscrypt_fname_free_buffer(&_tname);
+	return ret;
+}
diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
index 331b9c8da7fb..5a3fb68eb814 100644
--- a/fs/ceph/crypto.h
+++ b/fs/ceph/crypto.h
@@ -11,6 +11,14 @@
 
 #define	CEPH_XATTR_NAME_ENCRYPTION_CONTEXT	"encryption.ctx"
 
+struct ceph_fname {
+	struct inode	*dir;
+	char 		*name;		// b64 encoded, possibly hashed
+	unsigned char	*ctext;		// binary crypttext (if any)
+	u32		name_len;	// length of name buffer
+	u32		ctext_len;	// length of crypttext
+};
+
 #ifdef CONFIG_FS_ENCRYPTION
 
 /*
@@ -37,6 +45,22 @@ static inline void ceph_fscrypt_free_dummy_policy(struct ceph_fs_client *fsc)
 int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
 				 struct ceph_acl_sec_ctx *as);
 
+static inline int ceph_fname_alloc_buffer(struct inode *parent, struct fscrypt_str *fname)
+{
+	if (!IS_ENCRYPTED(parent))
+		return 0;
+	return fscrypt_fname_alloc_buffer(NAME_MAX, fname);
+}
+
+static inline void ceph_fname_free_buffer(struct inode *parent, struct fscrypt_str *fname)
+{
+	if (IS_ENCRYPTED(parent))
+		fscrypt_fname_free_buffer(fname);
+}
+
+int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
+			struct fscrypt_str *oname, bool *is_nokey);
+
 #else /* CONFIG_FS_ENCRYPTION */
 
 static inline void ceph_fscrypt_set_ops(struct super_block *sb)
@@ -55,6 +79,23 @@ static inline int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *
 	return 0;
 }
 
+static inline int ceph_fname_alloc_buffer(struct inode *parent, struct fscrypt_str *fname)
+{
+	return 0;
+}
+
+static inline void ceph_fname_free_buffer(struct inode *parent, struct fscrypt_str *fname)
+{
+}
+
+static inline int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
+				    struct fscrypt_str *oname, bool *is_nokey)
+{
+	oname->name = fname->name;
+	oname->len = fname->name_len;
+	return 0;
+}
+
 #endif /* CONFIG_FS_ENCRYPTION */
 
 #endif
-- 
2.30.2

