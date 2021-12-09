Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66AA46EBB7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 16:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240467AbhLIPlB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 10:41:01 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:42452 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240091AbhLIPkk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:40:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 29B77CE263B;
        Thu,  9 Dec 2021 15:37:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6251C341C8;
        Thu,  9 Dec 2021 15:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639064223;
        bh=tJA3xPb4WWFzLbv2sEEV1HwKelU0Xf0meq8HwYmKIls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HdyDDCNEl94YjunGJY04bFUnWO4Pu0OXRCH2alnEqApXi5KiSvZwubEhki4JO5q84
         rcd2ZmZYB94Fs8cYlMDhJilYlAtp01h9AxTWcOE6zrd0+eNVh/Goxzeibd2yvTLD9L
         gkWJAKsJ542STwCGPBrUrYdORIupu7XZ2LH1eMhX59eWnbqPWSHI8oGfscMgObowar
         VyW1s34YS7nGTPHtVpEmrqCk9Hqw6Fv4cjC+zj3LJGoZDSEqx8sFzJdfIhTV7QTIkL
         x1Me/PV0EG7v892Ungjl+BT26Vflbs8ribPN2Gpj1cl8JDQE37PfjbX9SWDZxoHuVv
         3nJk3zR/UHspw==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 20/36] ceph: add helpers for converting names for userland presentation
Date:   Thu,  9 Dec 2021 10:36:31 -0500
Message-Id: <20211209153647.58953-21-jlayton@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211209153647.58953-1-jlayton@kernel.org>
References: <20211209153647.58953-1-jlayton@kernel.org>
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
index 1f54e948b656..35137beb027b 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -175,3 +175,79 @@ int ceph_encode_encrypted_fname(const struct inode *parent, struct dentry *dentr
 	dout("base64-encoded ciphertext name = %.*s\n", elen, buf);
 	return elen;
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
+	if (fname->name_len > FSCRYPT_BASE64URL_CHARS(NAME_MAX))
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
+		declen = fscrypt_base64url_decode(fname->name, fname->name_len, tname->name);
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
index d5e298383b3e..c2e0cbb5667b 100644
--- a/fs/ceph/crypto.h
+++ b/fs/ceph/crypto.h
@@ -13,6 +13,14 @@ struct ceph_fs_client;
 struct ceph_acl_sec_ctx;
 struct ceph_mds_request;
 
+struct ceph_fname {
+	struct inode	*dir;
+	char 		*name;		// b64 encoded, possibly hashed
+	unsigned char	*ctext;		// binary crypttext (if any)
+	u32		name_len;	// length of name buffer
+	u32		ctext_len;	// length of crypttext
+};
+
 struct ceph_fscrypt_auth {
 	__le32	cfa_version;
 	__le32	cfa_blob_len;
@@ -55,6 +63,22 @@ int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
 void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req, struct ceph_acl_sec_ctx *as);
 int ceph_encode_encrypted_fname(const struct inode *parent, struct dentry *dentry, char *buf);
 
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
@@ -83,6 +107,23 @@ static inline int ceph_encode_encrypted_fname(const struct inode *parent,
 {
 	return -EOPNOTSUPP;
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
 #endif /* CONFIG_FS_ENCRYPTION */
 
 #endif
-- 
2.33.1

