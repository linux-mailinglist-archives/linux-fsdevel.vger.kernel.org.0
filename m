Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DA94F4D31
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581687AbiDEXkc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573586AbiDETXI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:23:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AE64B1FC;
        Tue,  5 Apr 2022 12:21:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8549D61899;
        Tue,  5 Apr 2022 19:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC48C385A3;
        Tue,  5 Apr 2022 19:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649186468;
        bh=14o5AyS753fcTCZmC+HM1t/hgGn4Rq2wXNi53+bcw+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nLl3vhRhPAHlOR3xbsvQlr7NLV0rPQPFXFI9GXMe9Zg0qy/SlZenSfJF7B+9+HPmQ
         1pZwso5rDirMGVn95yxypey863Alt8ShGJQVCcStBUiV364309s5ITLlxZ9Dwh15vt
         UbuZCtw9pQcW5JtzqfJh+cXHEQaxnEYD5oJaDQd+p60AJyy6BNqRFbeuLuTsv+pWGY
         aFXF+c9f5fXZYvryRSBwjX4g/0Ix+lPuH4LiT8Qu7kuzrwAAe+SPlTH75pzWbetq9f
         RcKBFKp12vNCtUVkpjnnTm993fnIexkUN03o9tTyP35JCkXSmWow8QUbx2GOs8ud14
         VqFOdHABr/1pw==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [PATCH v13 39/59] ceph: size handling for encrypted inodes in cap updates
Date:   Tue,  5 Apr 2022 15:20:10 -0400
Message-Id: <20220405192030.178326-40-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405192030.178326-1-jlayton@kernel.org>
References: <20220405192030.178326-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Transmit the rounded-up size as the normal size, and fill out the
fscrypt_file field with the real file size.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/caps.c   | 43 +++++++++++++++++++++++++------------------
 fs/ceph/crypto.h |  4 ++++
 2 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 22bf3e2696cb..cb5cdf2260ad 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1215,10 +1215,9 @@ struct cap_msg_args {
 	umode_t			mode;
 	bool			inline_data;
 	bool			wake;
+	bool			encrypted;
 	u32			fscrypt_auth_len;
-	u32			fscrypt_file_len;
 	u8			fscrypt_auth[sizeof(struct ceph_fscrypt_auth)]; // for context
-	u8			fscrypt_file[sizeof(u64)]; // for size
 };
 
 /* Marshal up the cap msg to the MDS */
@@ -1253,7 +1252,12 @@ static void encode_cap_msg(struct ceph_msg *msg, struct cap_msg_args *arg)
 	fc->ino = cpu_to_le64(arg->ino);
 	fc->snap_follows = cpu_to_le64(arg->follows);
 
-	fc->size = cpu_to_le64(arg->size);
+#if IS_ENABLED(CONFIG_FS_ENCRYPTION)
+	if (arg->encrypted)
+		fc->size = cpu_to_le64(round_up(arg->size, CEPH_FSCRYPT_BLOCK_SIZE));
+	else
+#endif
+		fc->size = cpu_to_le64(arg->size);
 	fc->max_size = cpu_to_le64(arg->max_size);
 	ceph_encode_timespec64(&fc->mtime, &arg->mtime);
 	ceph_encode_timespec64(&fc->atime, &arg->atime);
@@ -1313,11 +1317,17 @@ static void encode_cap_msg(struct ceph_msg *msg, struct cap_msg_args *arg)
 	ceph_encode_64(&p, 0);
 
 #if IS_ENABLED(CONFIG_FS_ENCRYPTION)
-	/* fscrypt_auth and fscrypt_file (version 12) */
+	/*
+	 * fscrypt_auth and fscrypt_file (version 12)
+	 *
+	 * fscrypt_auth holds the crypto context (if any). fscrypt_file
+	 * tracks the real i_size as an __le64 field (and we use a rounded-up
+	 * i_size in * the traditional size field).
+	 */
 	ceph_encode_32(&p, arg->fscrypt_auth_len);
 	ceph_encode_copy(&p, arg->fscrypt_auth, arg->fscrypt_auth_len);
-	ceph_encode_32(&p, arg->fscrypt_file_len);
-	ceph_encode_copy(&p, arg->fscrypt_file, arg->fscrypt_file_len);
+	ceph_encode_32(&p, sizeof(__le64));
+	ceph_encode_64(&p, arg->size);
 #else /* CONFIG_FS_ENCRYPTION */
 	ceph_encode_32(&p, 0);
 	ceph_encode_32(&p, 0);
@@ -1389,7 +1399,6 @@ static void __prep_cap(struct cap_msg_args *arg, struct ceph_cap *cap,
 	arg->follows = flushing ? ci->i_head_snapc->seq : 0;
 	arg->flush_tid = flush_tid;
 	arg->oldest_flush_tid = oldest_flush_tid;
-
 	arg->size = i_size_read(inode);
 	ci->i_reported_size = arg->size;
 	arg->max_size = ci->i_wanted_max_size;
@@ -1443,6 +1452,7 @@ static void __prep_cap(struct cap_msg_args *arg, struct ceph_cap *cap,
 		}
 	}
 	arg->flags = flags;
+	arg->encrypted = IS_ENCRYPTED(inode);
 #if IS_ENABLED(CONFIG_FS_ENCRYPTION)
 	if (ci->fscrypt_auth_len &&
 	    WARN_ON_ONCE(ci->fscrypt_auth_len > sizeof(struct ceph_fscrypt_auth))) {
@@ -1453,21 +1463,21 @@ static void __prep_cap(struct cap_msg_args *arg, struct ceph_cap *cap,
 		memcpy(arg->fscrypt_auth, ci->fscrypt_auth,
 			min_t(size_t, ci->fscrypt_auth_len, sizeof(arg->fscrypt_auth)));
 	}
-	/* FIXME: use this to track "real" size */
-	arg->fscrypt_file_len = 0;
 #endif /* CONFIG_FS_ENCRYPTION */
 }
 
+#if IS_ENABLED(CONFIG_FS_ENCRYPTION)
 #define CAP_MSG_FIXED_FIELDS (sizeof(struct ceph_mds_caps) + \
-		      4 + 8 + 4 + 4 + 8 + 4 + 4 + 4 + 8 + 8 + 4 + 8 + 8 + 4 + 4)
+		      4 + 8 + 4 + 4 + 8 + 4 + 4 + 4 + 8 + 8 + 4 + 8 + 8 + 4 + 4 + 8)
 
-#if IS_ENABLED(CONFIG_FS_ENCRYPTION)
 static inline int cap_msg_size(struct cap_msg_args *arg)
 {
-	return CAP_MSG_FIXED_FIELDS + arg->fscrypt_auth_len +
-			arg->fscrypt_file_len;
+	return CAP_MSG_FIXED_FIELDS + arg->fscrypt_auth_len;
 }
 #else
+#define CAP_MSG_FIXED_FIELDS (sizeof(struct ceph_mds_caps) + \
+		      4 + 8 + 4 + 4 + 8 + 4 + 4 + 4 + 8 + 8 + 4 + 8 + 8 + 4 + 4)
+
 static inline int cap_msg_size(struct cap_msg_args *arg)
 {
 	return CAP_MSG_FIXED_FIELDS;
@@ -1546,13 +1556,10 @@ static inline int __send_flush_snap(struct inode *inode,
 	arg.inline_data = capsnap->inline_data;
 	arg.flags = 0;
 	arg.wake = false;
+	arg.encrypted = IS_ENCRYPTED(inode);
 
-	/*
-	 * No fscrypt_auth changes from a capsnap. It will need
-	 * to update fscrypt_file on size changes (TODO).
-	 */
+	/* No fscrypt_auth changes from a capsnap.*/
 	arg.fscrypt_auth_len = 0;
-	arg.fscrypt_file_len = 0;
 
 	msg = ceph_msg_new(CEPH_MSG_CLIENT_CAPS, cap_msg_size(&arg),
 			   GFP_NOFS, false);
diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
index 080905b0c73c..56a61ba64edc 100644
--- a/fs/ceph/crypto.h
+++ b/fs/ceph/crypto.h
@@ -9,6 +9,10 @@
 #include <crypto/sha2.h>
 #include <linux/fscrypt.h>
 
+#define CEPH_FSCRYPT_BLOCK_SHIFT   12
+#define CEPH_FSCRYPT_BLOCK_SIZE    (_AC(1, UL) << CEPH_FSCRYPT_BLOCK_SHIFT)
+#define CEPH_FSCRYPT_BLOCK_MASK	   (~(CEPH_FSCRYPT_BLOCK_SIZE-1))
+
 struct ceph_fs_client;
 struct ceph_acl_sec_ctx;
 struct ceph_mds_request;
-- 
2.35.1

