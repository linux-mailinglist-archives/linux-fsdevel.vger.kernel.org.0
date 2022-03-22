Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC484E404F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 15:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbiCVOPH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 10:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236505AbiCVOPB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:15:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960F275C21;
        Tue, 22 Mar 2022 07:13:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A30D5615F4;
        Tue, 22 Mar 2022 14:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4652BC340F0;
        Tue, 22 Mar 2022 14:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647958401;
        bh=sj7dHnIhjDPjmxjj1mLrGBUQ1XaqXVRV+kSbTR9LmwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QwL3BKm+Lr4dRHJxt+JU5QMrC9uFOmEZ7re3ZgfsPMpoh/qcayzq0xBkoepEJMAdQ
         tYo4SdZUegJ7aQCRAHn/rxAZemaBwESz9DkFzkMCHvvZGoyHL3rFcnSvcQDY/Ast3T
         Rw5v3g/j/6hKUNDscw+wLiUE1AzWB739Okkqt8BUYmlOLLfw1r9UsadFEod5z4p1jf
         BkPE+mprJLGYYTtmmw8aZzDvv9vaLPFPS0droiP5BgbaJDOXTeybxxHc9afGoEmqR/
         miIXL4pUPg6T6MTZDmnvNCPVbgNNwBknLUQXnB09o0ioABBuKubYQXGcFhvLl6ZcHc
         oMjnB++dFGgew==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de, Eric Biggers <ebiggers@google.com>
Subject: [RFC PATCH v11 02/51] fscrypt: export fscrypt_base64url_encode and fscrypt_base64url_decode
Date:   Tue, 22 Mar 2022 10:12:27 -0400
Message-Id: <20220322141316.41325-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322141316.41325-1-jlayton@kernel.org>
References: <20220322141316.41325-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ceph is going to add fscrypt support, but we still want encrypted
filenames to be composed of printable characters, so we can maintain
compatibility with clients that don't support fscrypt.

We could just adopt fscrypt's current nokey name format, but that is
subject to change in the future, and it also contains dirhash fields
that we don't need for cephfs. Because of this, we're going to concoct
our own scheme for encoding encrypted filenames. It's very similar to
fscrypt's current scheme, but doesn't bother with the dirhash fields.

The ceph encoding scheme will use base64 encoding as well, and we also
want it to avoid characters that are illegal in filenames. Export the
fscrypt base64 encoding/decoding routines so we can use them in ceph's
fscrypt implementation.

Acked-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/crypto/fname.c       | 8 ++++----
 include/linux/fscrypt.h | 5 +++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index a9be4bc74a94..1e4233c95005 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -182,8 +182,6 @@ static int fname_decrypt(const struct inode *inode,
 static const char base64url_table[65] =
 	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";
 
-#define FSCRYPT_BASE64URL_CHARS(nbytes)	DIV_ROUND_UP((nbytes) * 4, 3)
-
 /**
  * fscrypt_base64url_encode() - base64url-encode some binary data
  * @src: the binary data to encode
@@ -198,7 +196,7 @@ static const char base64url_table[65] =
  * Return: the length of the resulting base64url-encoded string in bytes.
  *	   This will be equal to FSCRYPT_BASE64URL_CHARS(srclen).
  */
-static int fscrypt_base64url_encode(const u8 *src, int srclen, char *dst)
+int fscrypt_base64url_encode(const u8 *src, int srclen, char *dst)
 {
 	u32 ac = 0;
 	int bits = 0;
@@ -217,6 +215,7 @@ static int fscrypt_base64url_encode(const u8 *src, int srclen, char *dst)
 		*cp++ = base64url_table[(ac << (6 - bits)) & 0x3f];
 	return cp - dst;
 }
+EXPORT_SYMBOL_GPL(fscrypt_base64url_encode);
 
 /**
  * fscrypt_base64url_decode() - base64url-decode a string
@@ -233,7 +232,7 @@ static int fscrypt_base64url_encode(const u8 *src, int srclen, char *dst)
  * Return: the length of the resulting decoded binary data in bytes,
  *	   or -1 if the string isn't a valid base64url string.
  */
-static int fscrypt_base64url_decode(const char *src, int srclen, u8 *dst)
+int fscrypt_base64url_decode(const char *src, int srclen, u8 *dst)
 {
 	u32 ac = 0;
 	int bits = 0;
@@ -256,6 +255,7 @@ static int fscrypt_base64url_decode(const char *src, int srclen, u8 *dst)
 		return -1;
 	return bp - dst;
 }
+EXPORT_SYMBOL_GPL(fscrypt_base64url_decode);
 
 bool fscrypt_fname_encrypted_size(const union fscrypt_policy *policy,
 				  u32 orig_len, u32 max_len,
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 91ea9477e9bd..671181d196a8 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -46,6 +46,9 @@ struct fscrypt_name {
 /* Maximum value for the third parameter of fscrypt_operations.set_context(). */
 #define FSCRYPT_SET_CONTEXT_MAX_SIZE	40
 
+/* len of resulting string (sans NUL terminator) after base64 encoding nbytes */
+#define FSCRYPT_BASE64URL_CHARS(nbytes)		DIV_ROUND_UP((nbytes) * 4, 3)
+
 #ifdef CONFIG_FS_ENCRYPTION
 
 /*
@@ -305,6 +308,8 @@ void fscrypt_free_inode(struct inode *inode);
 int fscrypt_drop_inode(struct inode *inode);
 
 /* fname.c */
+int fscrypt_base64url_encode(const u8 *src, int len, char *dst);
+int fscrypt_base64url_decode(const char *src, int len, u8 *dst);
 int fscrypt_setup_filename(struct inode *inode, const struct qstr *iname,
 			   int lookup, struct fscrypt_name *fname);
 
-- 
2.35.1

