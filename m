Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420833B4521
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 15:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbhFYOBg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Jun 2021 10:01:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231936AbhFYOBL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Jun 2021 10:01:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2069D6135A;
        Fri, 25 Jun 2021 13:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624629530;
        bh=BPAlxU//3NdlDb/qT9mY4xu+ESoorpTIszsalhs71eM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h7+UskuT1CfiCXZ4a0405rWlrzoi9synljzqJx46bObBT/HyG3hjL2zZyeX4qoW0a
         iZ/zf/9iR4KCJa/2AKwQT5C8pa/P7MqWFRKFrQVDcVEIP9Eat5mSmidHZofUjYHzYQ
         +V/0HPHs90CkybymTH20927d2GkNf9hijWx+Ezoq3VyKX1PXQcgUVoc27NcXSZa5XA
         bKPDHKRGkAjsiJWoNuvUyTo9sxp7MO1qQdsxDFEOt5ltSVS2Uvo299GY+aEl/NN4UD
         vv84/xzgZW53l7S17McXnv30myXBf7C+3noUYbXQvW8t5DUGzrY04Vm4ei1av8xMYq
         NNZB8DWqj7obw==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     lhenriques@suse.de, xiubli@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com
Subject: [RFC PATCH v7 19/24] ceph: add helpers for converting names for userland presentation
Date:   Fri, 25 Jun 2021 09:58:29 -0400
Message-Id: <20210625135834.12934-20-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625135834.12934-1-jlayton@kernel.org>
References: <20210625135834.12934-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/crypto.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/crypto.h | 42 ++++++++++++++++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 675d41fd2eb0..55c7f45c062b 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -128,3 +128,79 @@ void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req, struct ceph_acl_se
 {
 	swap(req->r_fscrypt_auth, as->fscrypt_auth);
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
index 60cc92f25fed..879f95972e41 100644
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
 struct ceph_fs_client;
 struct ceph_acl_sec_ctx;
@@ -50,6 +58,22 @@ int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
 				 struct ceph_acl_sec_ctx *as);
 void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req, struct ceph_acl_sec_ctx *as);
 
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
@@ -72,6 +96,24 @@ static inline void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req,
 						struct ceph_acl_sec_ctx *as_ctx)
 {
 }
+
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
2.31.1

