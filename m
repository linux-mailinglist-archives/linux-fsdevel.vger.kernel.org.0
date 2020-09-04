Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56EF25DF3E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 18:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgIDQHQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 12:07:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727882AbgIDQFq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:05:46 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 023322084D;
        Fri,  4 Sep 2020 16:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599235545;
        bh=ZTnazhwuQ6F6mHuDpjBCDbj+U4yMMgAvqag/Baj5oKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X9YSwrXUlbS+Q61pt4LAMX6HD1nhdQg5ecG9KUYBo/pRSXnNM+vmscfek+5znQTyY
         2QBZgCxcLPZWpkeJH0P7vzIsYPx82WTtNrkmzHnrbjY89bmRuVWWauzG+NPreFRAvR
         g31pMM/oFb0K96YXFo+nAJZUMEtNoGzBLrBgjqTI=
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        ebiggers@kernel.org
Subject: [RFC PATCH v2 06/18] fscrypt: move nokey_name conversion to separate function and export it
Date:   Fri,  4 Sep 2020 12:05:25 -0400
Message-Id: <20200904160537.76663-7-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904160537.76663-1-jlayton@kernel.org>
References: <20200904160537.76663-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/crypto/fname.c       | 71 +++++++++++++++++++++++------------------
 include/linux/fscrypt.h |  3 ++
 2 files changed, 43 insertions(+), 31 deletions(-)

diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 9440a44e24ac..09f09def87fc 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -300,6 +300,45 @@ void fscrypt_fname_free_buffer(struct fscrypt_str *crypto_str)
 }
 EXPORT_SYMBOL(fscrypt_fname_free_buffer);
 
+void fscrypt_encode_nokey_name(u32 hash, u32 minor_hash,
+			     const struct fscrypt_str *iname,
+			     struct fscrypt_str *oname)
+{
+	struct fscrypt_nokey_name nokey_name;
+	u32 size; /* size of the unencoded no-key name */
+
+	/*
+	 * Sanity check that struct fscrypt_nokey_name doesn't have padding
+	 * between fields and that its encoded size never exceeds NAME_MAX.
+	 */
+	BUILD_BUG_ON(offsetofend(struct fscrypt_nokey_name, dirhash) !=
+		     offsetof(struct fscrypt_nokey_name, bytes));
+	BUILD_BUG_ON(offsetofend(struct fscrypt_nokey_name, bytes) !=
+		     offsetof(struct fscrypt_nokey_name, sha256));
+	BUILD_BUG_ON(BASE64_CHARS(FSCRYPT_NOKEY_NAME_MAX) > NAME_MAX);
+
+	if (hash) {
+		nokey_name.dirhash[0] = hash;
+		nokey_name.dirhash[1] = minor_hash;
+	} else {
+		nokey_name.dirhash[0] = 0;
+		nokey_name.dirhash[1] = 0;
+	}
+	if (iname->len <= sizeof(nokey_name.bytes)) {
+		memcpy(nokey_name.bytes, iname->name, iname->len);
+		size = offsetof(struct fscrypt_nokey_name, bytes[iname->len]);
+	} else {
+		memcpy(nokey_name.bytes, iname->name, sizeof(nokey_name.bytes));
+		/* Compute strong hash of remaining part of name. */
+		fscrypt_do_sha256(&iname->name[sizeof(nokey_name.bytes)],
+				  iname->len - sizeof(nokey_name.bytes),
+				  nokey_name.sha256);
+		size = FSCRYPT_NOKEY_NAME_MAX;
+	}
+	oname->len = base64_encode((const u8 *)&nokey_name, size, oname->name);
+}
+EXPORT_SYMBOL(fscrypt_encode_nokey_name);
+
 /**
  * fscrypt_fname_disk_to_usr() - convert an encrypted filename to
  *				 user-presentable form
@@ -327,8 +366,6 @@ int fscrypt_fname_disk_to_usr(const struct inode *inode,
 			      struct fscrypt_str *oname)
 {
 	const struct qstr qname = FSTR_TO_QSTR(iname);
-	struct fscrypt_nokey_name nokey_name;
-	u32 size; /* size of the unencoded no-key name */
 
 	if (fscrypt_is_dot_dotdot(&qname)) {
 		oname->name[0] = '.';
@@ -343,35 +380,7 @@ int fscrypt_fname_disk_to_usr(const struct inode *inode,
 	if (fscrypt_has_encryption_key(inode))
 		return fname_decrypt(inode, iname, oname);
 
-	/*
-	 * Sanity check that struct fscrypt_nokey_name doesn't have padding
-	 * between fields and that its encoded size never exceeds NAME_MAX.
-	 */
-	BUILD_BUG_ON(offsetofend(struct fscrypt_nokey_name, dirhash) !=
-		     offsetof(struct fscrypt_nokey_name, bytes));
-	BUILD_BUG_ON(offsetofend(struct fscrypt_nokey_name, bytes) !=
-		     offsetof(struct fscrypt_nokey_name, sha256));
-	BUILD_BUG_ON(BASE64_CHARS(FSCRYPT_NOKEY_NAME_MAX) > NAME_MAX);
-
-	if (hash) {
-		nokey_name.dirhash[0] = hash;
-		nokey_name.dirhash[1] = minor_hash;
-	} else {
-		nokey_name.dirhash[0] = 0;
-		nokey_name.dirhash[1] = 0;
-	}
-	if (iname->len <= sizeof(nokey_name.bytes)) {
-		memcpy(nokey_name.bytes, iname->name, iname->len);
-		size = offsetof(struct fscrypt_nokey_name, bytes[iname->len]);
-	} else {
-		memcpy(nokey_name.bytes, iname->name, sizeof(nokey_name.bytes));
-		/* Compute strong hash of remaining part of name. */
-		fscrypt_do_sha256(&iname->name[sizeof(nokey_name.bytes)],
-				  iname->len - sizeof(nokey_name.bytes),
-				  nokey_name.sha256);
-		size = FSCRYPT_NOKEY_NAME_MAX;
-	}
-	oname->len = base64_encode((const u8 *)&nokey_name, size, oname->name);
+	fscrypt_encode_nokey_name(hash, minor_hash, iname, oname);
 	return 0;
 }
 EXPORT_SYMBOL(fscrypt_fname_disk_to_usr);
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 0ddbd27a2e58..57146f9f70e7 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -202,6 +202,9 @@ static inline void fscrypt_free_filename(struct fscrypt_name *fname)
 int fscrypt_fname_alloc_buffer(u32 max_encrypted_len,
 			       struct fscrypt_str *crypto_str);
 void fscrypt_fname_free_buffer(struct fscrypt_str *crypto_str);
+void fscrypt_encode_nokey_name(u32 hash, u32 minor_hash,
+			     const struct fscrypt_str *iname,
+			     struct fscrypt_str *oname);
 int fscrypt_fname_disk_to_usr(const struct inode *inode,
 			      u32 hash, u32 minor_hash,
 			      const struct fscrypt_str *iname,
-- 
2.26.2

